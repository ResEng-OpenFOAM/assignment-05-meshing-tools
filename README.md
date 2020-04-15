# Assignment for "Meshing tools"

## Goals

- Master `cfMesh` workflow

## Basic-level skills

### Basic `cfMesh` usage

By now you should know that if mesh generation with `cfMesh` is to be attempted,
we need to go through a couple of steps:

- Prepare a geometry file for the external surface of the domain
- Set minimal cell size in `system/meshDict`

In this section, we'll attempt to mesh a pore-scale representation of a porous
sample; similar to what we featured in the lectures.

Of course, you'll go through **all** the steps; starting from preparing the
geometry file up to defining boundary patches on the OpenFOAM mesh. So, let's
get started.

#### Preparing a sample geometry file

Typically, you would usually get the geometry from some CAD software; but we'll
try to generate one in this section.

1. The first step is to install [PoreSpy Library](https://github.com/PMEAL/porespy) 
   in the container; Clone this
   repository and run the `scripts/installPorespy.sh` file (This may take some
   time):

```bash
(rem) > git clone https://github.com/FoamScience/assignment-meshing-tools
(rem) > cd assignment-meshing-tools
(rem) > chmod +x scripts/installPorespy.sh
(rem) > ./scripts/installPorespy.sh
```

> PoreSpy is a collection of image analysis tool used to extract information 
> from 3D images of porous materials; we are interested only in the generation
> of a sample porous material at this point.

2. Then, generating a sample porous material is as simple as running the
   following code in a python interpreter:

```python
(rem) > run; ipython
>>> import porespy as ps
>>> import matplotlib.pyplot as plt
# An artificial 400x400 (40%-)porous medium
>>> im = ps.generators.blobs(shape=[400, 400], porosity=0.4, blobiness=1.5)
>>> plt.imsave('porous-media.png', im)
>>> exit
```

- The first line switches to the `run` directory, and starts a Python session
  there.
- All subsequent lines should be executed in that Python session.
- The first two commands are just "imports", loading some the required modules.
- Then, we use `porespy.generators.blobs` to generate our sample porous medium
  and save the results into an object `im`.
- The `shape` dimensions are "pixels", and the blobiness affects how well the "pores"
  are connected to each other.
- The following command saves the `im` object as a PNG image.
- The last one terminates the Python session, getting us back to the shell.

You can now download the image to your local machine (if you haven't mounted any
remote directories locally, which is the recommended way):
```bash
(rem) > scp -i ~/.ssh/remotesshkey.pem linux1@xxx.xxx.xxx.xxx:/home/linux1/run/porous-media.png /tmp
```
Or, if you are not on \*Nix  locally, you can upload it to `transfer.sh` for
example:
```bash
(rem) > apt install curl -y
(rem) > curl --upload-file ./porous-media.png https://transfer.sh/porous-media.png
```

These operations will result in something similar to:

![PoreSpy generated porous media image](images/porous-media.png)

(Hopefully, you can tell which color represents the grains and which one
represents the flow domain).

3. After generating the PNG image, we need to "trace" it so we know where grain
   boundaries are:
```bash
# First, install some utilities we need
(rem) > apt install netpbm potrace -y
# Then trace the image with potrace
(rem) > curl --upload-file ./porous-media.png https://transfer.sh/porous-media.png
```

These operations will result in something similar to (the black region
should represent the flow domain):

![Trace the image file](images/porous-media.svg)

4. The final step is then to **Extrude** the 2D image into a triangulated 3D geometry.
   This can be automated using some CAD tools (eg. OpenSCAD), but we'll keep
   simple and use [svg2stl.com](http://svg2stl.com) online web service.

   All you have to do is to upload your SVG image, choose an extrusion-height
   (choose the default value, doesn't really matter) and download the generated STL
   file (call it `porous-media.stl`):

![3D STL file for the porous medium](images/porous-media-stl.png)

#### `cartesian2DMesh` workflow

## Intermediate skills

### Advanced usage of `cfMesh`

## Advanced skills
