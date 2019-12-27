# ocrd_imageconvert

> Thin wrapper around convert(1)

## Introduction

[ImageMagick's](https://imagemagick.org) `convert` CLI contains a treasure trove of image operations. This wrapper aims to provide much of that as an [OCR-D compliant processor](https://ocr-d.github.io/CLI).

## Installation

This module requires GNU make (for installation) and the ImageMagick command line tools (at runtime). On Ubuntu 18.04 (or similar), you can install them by running:

    sudo apt-get install make
    sudo make deps-ubuntu # or: apt-get install imagemagick

Moreover, an installation of [OCR-D core](https://github.com/OCR-D/core) is needed:

    make deps # or: pip install ocrd

This will install the Python package `ocrd` in your current environment. (Setting up a [venv](https://ocr-d.github.io/docs/guide#python-setup) is strongly recommended.)

Lastly, the provided shell script `ocrd-im6convert` works best when copied into your `PATH`, referencing its ocrd-tool.json under a known path. This can be done by running:

    make install

This will copy the binary and JSON file under `$PREFIX`, which variable you can override to your needs. The default value is to use `PREFIX=$VIRTUAL_ENV` if you have already activated a venv, or `PREFIX=$PWD/.local` (i.e. under the current working directory).

## Usage

This package provides `ocrd-im6convert` as a [OCR-D processor](https://ocr-d.github.com/cli) (command line interface). It uses the following parameters:

```JSON
    "ocrd-im6convert": {
      "executable": "ocrd-im6convert",
      "categories": ["Image preprocessing"],
      "steps": ["preprocessing/optimization"],
      "description": "Convert and transform images",
      "input_file_grp": [
        "OCR-D-IMG"
      ],
      "output_file_grp": [
        "OCR-D-IMG"
      ],
      "parameters": {
        "input-options": {
          "type": "string",
          "description": "e.g. -density 600x600 -wavelet-denoise 1%x0.1",
          "default": ""
        },
        "output-format": {
          "type": "string",
          "description": "Desired media type of output",
          "required": true,
          "enum": ["image/tiff", "image/jp2", "image/png"]
        },
        "output-options": {
          "type": "string",
          "description": "e.g. -resample 300x300 -alpha deactivate -normalize -despeckle -noise 2 -negate -morphology close diamond",
          "default": ""
        }
      }
    }
```

Cf. [IM documentation](https://imagemagick.org/script/command-line-options.php) or man-page `convert(1)` for formats and options.

### Example

    ocrd-im6convert -I OCR-D-IMG -O OCR-D-IMG-SMALL -p '{ "output-format": "image/png", "output-options": "-resize 24%" }'

(This downscales the images in the input file group `OCR-D-IMG` to 24% and stores them as PNG files under the output file group `OCR-D-IMG-SMALL`.)

## Testing

None yet
