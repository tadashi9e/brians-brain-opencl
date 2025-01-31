// -*- mode:c -*-
#define ST_OFF 0
#define ST_DYING 1
#define ST_ON 2

inline char get(
    __global unsigned char *map,
    int x,
    int y,
    int width,
    int height) {
  if (x < 0) {
    x += width;
  } else if (x >= width) {
    x -= width;
  }
  if (y < 0) {
    y += height;
  } else if (y >= height) {
    y -= height;
  }
  return map[y * width + x];
}

/*
  - For a cell in the "ON" state, change its state to "DYING".
  - For a cell in the "DYING" state, change its state to "OFF".
  - For a cell in the "OFF" state,
    if it has exactly two neighbors in the "ON" state,
    change its state to "ON".
*/
__kernel void bb_next_step(
    __global unsigned char *src,
    __global unsigned char *dst) {
  const int width = get_global_size(0);
  const int height = get_global_size(1);
  const int x = get_global_id(0);
  const int y = get_global_id(1);
  int count = 0;
  for (int dy = -1; dy < 2; ++dy) {
    for (int dx = -1; dx < 2; ++dx) {
      const char c = get(src, x + dx, y + dy, width, height);
      if (dx == 0 && dy == 0) {
        switch (c) {
        case ST_ON:
          dst[y * width + x] = ST_DYING;
          return;
        case ST_DYING:
          dst[y * width + x] = ST_OFF;
          return;
        }
      }
      if (c == ST_ON) {
        ++count;
      }
    }
  }
  if (count == 2) {
    dst[y * width + x] = ST_ON;
  }
}

/*
  Draw field image
 */
__kernel void bb_draw_image(
    __global unsigned char *field,
    __write_only image2d_t image) {
  const int width = get_global_size(0);
  const int height = get_global_size(1);
  const int x = get_global_id(0);
  const int y = get_global_id(1);
  const char c = get(field, x, y, width, height);
  float r = 0.0, g = 0.0, b = 0.0;
  switch (c) {
  case ST_ON:
    r = 0.0;
    g = 1.0;
    b = 1.0;
    break;
  case ST_DYING:
    r = 1.0;
    g = 0.0;
    b = 0.0;
    break;
  default:
    r = 0.0;
    g = 0.0;
    b = 0.0;
    break;
  }
  const float4 pixel = (float4)(r, g, b, 1.0);
  write_imagef(image, (int2)(x,y), pixel);
}
