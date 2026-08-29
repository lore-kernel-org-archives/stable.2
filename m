Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840683AAF70;
	Sat, 29 Aug 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788009727; cv=none; b=bFX5OIm62EElEuZtSHCnszM9oM42H+RiCxjKFsbHhqgU+Y9esqQAh8fOwsxFoR0k7ACvQIdUx9+udcYeTBdfnx5dBfhVf4gmat6D3j+AGKSxgGhXc1Tu24k0x2lQP5gIjsXz47/FHhpeyle8i4tcc7yHOXK+b8j5V7r0+nGwpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788009727; c=relaxed/simple;
	bh=B02Fe4E8lU4Y1IpAzQLYaXHEvKJxtlOVAzUzJsKr83s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9peCnSmvYAeNNE6GkDDz0v4VqHtZ3yhie9bLkFxz5J/6yVVPxb/QhKLbkKjDUDYTNKgaIv98hpM4mqjF5cstNIJErfT9mt5Gzfeovtqlq8cRO11AEDhIcEsMS5LQWFhapnntoCyWTRZ0RkOofwlPzVWFo/5G1FVjYJBdI3bg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm; spf=pass smtp.mailfrom=berg.pm; dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b=Yfqj7KBp; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berg.pm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berg.pm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berg.pm header.i=@berg.pm header.b="Yfqj7KBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berg.pm;
	s=protonmail; t=1788009713; x=1788268913;
	bh=kOUaTMopWpaKKOhbUb4RUunbnnazzcLoEE3TY78zkg8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Yfqj7KBpKiKeKjyIMxiFuV8Qqq/yfHqTmYTIR8Q/j9vvRl/NaW1bRpr030p2oVFXe
	 CkFAkARVV5FuQKg6H2kKc5wAy4YBXaWBUEVd1nAfF5tw7MF0eJwQHQa103gXeNv+jo
	 zgpd7c7ug+Ea+stHExBROlD8wcI+QoG8Ql2sBCFQpmcvUwvaU+tNwErAFeD5hrIVW/
	 tPulsPcOsNYLEJbS4p/x3GjKReMVKfnu6d0LUhog1PpMcy7JZJpUaCFHa1JJMiJIfm
	 b0rYc/XDcad+FwMi0/Lob6DD6Sk3AiYM1ouPdtdEsEjUJIiYMnsmEW8SeOx0GvRqOX
	 07HUit96gnMMw==
Date: Sat, 29 Aug 2026 13:21:48 +0000
To: "D. Manresa" <dmanresa@gmail.com>
From: Jakob Berg Jespersen <dev@berg.pm>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, =?utf-8?Q?K=C3=A9vin_L=27h=C3=B4pital?= <kevin.lhopital@bootlin.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Daniel Scally <dan.scally@ideasonboard.com>, Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, Hans de Goede <johannes.goede@oss.qualcomm.com>, Fernando Rimoli <fernandorimoli11@gmail.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: ov5693: fix horizontal flip polarity and Bayer phase
Message-ID: <nCjqoWI6z141hFVhaIJmJKK83OIBg5hmB1uE_5U_sqbA0B_kIEPUmVzPTuOViWOyT0y-dCy5yDo2BpGGXWO99LeEugNunoW0eVooQGFMxrw=@berg.pm>
In-Reply-To: <20260828231805.29790-1-dmanresa@gmail.com>
References: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm> <20260729-sp7plus-ov-flips-v2-2-91884b81a8f5@berg.pm> <20260828231805.29790-1-dmanresa@gmail.com>
Feedback-ID: 210104851:user:proton
X-Pm-Message-ID: 308facf0fe3cb9294a1957e0f6b31a3f8689038f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the careful measurement. You are right, and 2/2 should not be
applied. It took me a while to figure out what I had missed before I
could reproduce your table on my own SP7+. I had not been careful to
track vertical flip. My original validation went through a libcamera
preview rather than raw frames, and libcamera leaves VFLIP set on this
machine, so I had only ever looked at the one state in which the patch
happens to be correct.

So at VFLIP=3D0 the compensation sits on the wrong flip state.
2/2 takes a default that was color-correct and leaves it one column off
in both flip states. This 2/2 patch should be dropped.
1/2 is unaffected and can be applied.

I have collected detailed information from my testing here:

Raw SBGGR10 frames off the IPU6 CSI-2 receiver (/dev/video32), no ISP in
the path, no test pattern, a red card as the main subject. Full
resolution 2592x1944. Crop start X (0x3800/0x3801) reads 0x0010.

The FLIP_HORZ bits and the ISP offset were written over i2c while
streaming. They have to be: ov5693_mode_configure() writes
OFFSET_START_X =3D 0 at every stream start.

Phase identified by green-pair statistics plus a demosaic check. As a
control I repeated the sweep with a blue object and the opposite
assumption about which channel dominates. Every label came out the same,
and the two scenes put blue at the same site. For VFLIP=3D1 I also
rendered the frame under both candidate patterns and looked at it, which
is unambiguous.

RESULTS, VERTICAL FLIP OFF

My unit gives exactly your four rows:

  FLIP_HORZ set     + 0x3810/11 =3D 0  (patch's HFLIP=3D0):  GBRG
  FLIP_HORZ cleared + 0x3810/11 =3D 1  (patch's HFLIP=3D1):  GBRG
  FLIP_HORZ cleared + 0x3810/11 =3D 0:                     BGGR (clean)
  FLIP_HORZ set     + 0x3810/11 =3D 1:                     does not stream
                                    (IPU6 "csi2-4 error: Frame sync error")

So the compensation is on the wrong flip state, as you found. The state
it would have to move to is the one that will not stream.

This is visible without trusting my analysis. Render both frames as
BGGR, which is what the driver tells userspace to do: the pre-patch
default (bits cleared) looks natural, the patched default (bits set) has
a magenta cast. Red and blue swapped, which is what a one-column phase
error does.

RESULTS, VERTICAL FLIP ON

My earlier testing was not done at VFLIP=3D0, and that is why it disagreed
with yours. V4L2 flip controls persist on the subdev between openers,
and libcamera leaves vertical_flip=3D1 here for the 180 degree SSDB mount.
My raw captures inherited it. With VFLIP=3D1 the same four combinations
invert:

  FLIP_HORZ set     + offset 0:  BGGR (clean)
  FLIP_HORZ cleared + offset 0:  GBRG
  FLIP_HORZ cleared + offset 1:  BGGR (clean)
  FLIP_HORZ set     + offset 1:  does not stream

So the absolute phase depends on both flips, and no compensation keyed
on HFLIP alone can be right in both vertical states. VFLIP=3D1 is the
state my patch was written for without my realizing it, and the state
libcamera uses here. That is why it looked correct to me and to
Fernando.

One oddity I cannot explain: the vertical flip moves the phase by a
column, not a row. This does not depend on my red/blue naming. Under the
opposite naming the same transition reads GRBG -> RGGB, also a column
shift, and neither is the row shift a plain vertical mirror would give.
I checked that the vertical flip really does mirror vertically by
rendering both frames. I report it as measured; I have no mechanism to
offer for it.

WHAT 2/2 ACTUALLY DOES

Per vertical state:

  VFLIP=3D0:  before the patch  HFLIP=3D0 -> BGGR (clean), HFLIP=3D1 -> GBR=
G
            after the patch   HFLIP=3D0 -> GBRG,         HFLIP=3D1 -> GBRG
  VFLIP=3D1:  before the patch  HFLIP=3D0 -> GBRG,         HFLIP=3D1 -> BGG=
R
            after the patch   HFLIP=3D0 -> BGGR (clean), HFLIP=3D1 -> BGGR

At VFLIP=3D1 the patch is an improvement. At VFLIP=3D0, the driver's
default, it takes a state that was color-correct and leaves it one
column off in both flip states. That is a regression.

BINNING

Your point 4. At 1296x972 (SUB_INC_X =3D 0x31, HBIN_EN set) my unit only
streams in the mirrored state. With the FLIP_HORZ bits set it gives
frame sync errors at both offsets, so I cannot test whether the mirror
alone moves the phase when binned. In the state that does stream, the
offset still moves it:

  FLIP_HORZ cleared + offset 0:  BGGR (clean)
  FLIP_HORZ cleared + offset 1:  GBRG

Same conclusion as yours by another route: with the patch applied,
HFLIP=3D1 in a binned mode writes offset 1 and turns a color-correct
readout into a one-column-off one. The compensation should not fire
there, and as posted it cannot tell.

WHERE THIS LEAVES THE SERIES

- 1/2 (ov8865) is unaffected: it only inverts the HFLIP polarity and
  contains no Bayer compensation. I repeated your check on that sensor
  here. Raw frames off the CSI-2 receiver in all four HFLIP/VFLIP
  combinations decode correctly as BGGR, the code the driver reports.
  That agrees with your result, so 1/2 can be applied as it stands.

- Please drop 2/2. The window-offset approach cannot express what the
  hardware does: The phase is a function of both flips, and the register
  combination the fix would need in one state does not stream. It
  carries Cc: stable, so I would rather it be dropped explicitly than
  left pending while I rework it.

- I am thinking to have another go on this patch and maybe send the
  ov5693 work as a new series, would the following be a good approach?

    1) Report the media bus code as a function of both flip controls,
       with V4L2_CTRL_FLAG_MODIFY_LAYOUT on them, as imx219 does. This
       is a fix on its own: the driver hardcodes SBGGR10 today and is
       already wrong at VFLIP=3D0 with HFLIP=3D1, before any patch of mine.

    2) Invert the HFLIP polarity, which is safe once (1) is in.

  In that order neither patch leaves the driver worse than it found it.
  The polarity fix must not go first: on its own it moves the VFLIP=3D0
  default from color-correct to one column off.

  Hans, Fernando: Your Reviewed-by and Tested-by were for the offset
  approach, which is gone, so I will not carry them to the new series.

  Sakari, Dan: Two things I would rather ask than assume. Do you want
  the code table done this way? And should patch (1) carry Fixes?
  It fixes a real pre-existing bug, but it also changes what
  the driver reports to userspace.

Thanks again for catching this. It would have gone to stable otherwise.

Jakob



On Saturday, August 29th, 2026 at 01:18, D. Manresa <dmanresa@gmail.com> wr=
ote:

> On Wed, 29 Jul 2026, Jakob Berg Jespersen wrote:
> > The sensor's native readout is horizontally mirrored and the FORMAT2
> > FLIP_HORZ bits (reg 0x3821) un-mirror it; the init table sets them by
> > default (0x3821 =3D 0x1e). The driver sets those bits for V4L2_CID_HFLI=
P=3D1,
> > so the control is inverted: HFLIP=3D1 yields the un-mirrored image and
> > HFLIP=3D0 the mirrored one. Invert the polarity so HFLIP=3D0 yields the
> > unflipped image.
>=20
> Tested on the front camera of a Surface Pro 7+ (OV5693 behind an IPU6,
> patch applied on v6.19 sources, loaded on a linux-surface 6.19.8 kernel),
> Bayer phases read from raw 2592x1944 captures. Partial results - the
> polarity fix checks out, the 0x3810 compensation appears to sit on the
> wrong flip state on my unit:
>=20
> 1) The polarity inversion is correct. Independent confirmation: the
>    register tables inside the vendor Windows driver (ov5693.sys from the
>    Surface MSI) keep the 0x3821 FLIP_HORZ bits set in every mode
>    (0x3821 =3D 0x1e/0x1f), and Windows delivers the un-mirrored image; wi=
th
>    your patch HFLIP=3D0 keeps them set, as the init table intends. HFLIP
>    also toggles the mirror geometry correctly in both directions here.
>=20
> 2) The 0x3810 write does what the commit message says in the relative
>    sense: the two flip states come out with the SAME Bayer phase, so
>    toggling HFLIP no longer changes the colours.
>=20
> 3) However, on my unit BOTH states then decode as GBRG, one column off th=
e
>    reported SBGGR10. I measured the four register combinations
>    independently (phase identified from raw frames by green-pair
>    statistics and confirmed by demosaicing a known-colour scene under eac=
h
>    hypothesis):
>=20
>      FLIP_HORZ bits set     + 0x3810=3D0  (your HFLIP=3D0):  GBRG
>      FLIP_HORZ bits cleared + 0x3810=3D1  (your HFLIP=3D1):  GBRG
>      FLIP_HORZ bits cleared + 0x3810=3D0:                  BGGR (clean)
>      FLIP_HORZ bits set     + 0x3810=3D1:                  does not strea=
m
>=20
>    i.e. here it is the un-mirrored readout (bits set) that carries the
>    one-column phase shift, and the mirrored readout that is SBGGR-clean -
>    the opposite of what the patch compensates. The last row is why the
>    compensation cannot simply be moved to the other state: with the
>    FLIP_HORZ bits set the sensor refuses to stream with a one-column
>    window offset (perpetual "Frame sync error" on the IPU6 CSI-2
>    receiver, reproduced across repeated attempts); shifting the crop
>    window by one column instead should work, but I have not tested that.
>=20
> 4) For completeness: in the 2x2-binned readout the Surface uses for
>    video (a downstream patch of mine, not in mainline), the mirror does
>    not move the Bayer phase at all - same behaviour I measured on the
>    OV8865 - so there the 0x3810 parity must stay constant across flip
>    states.
>=20
> Since you and Fernando verified colours correct in both flip states on
> your units, and point 3 is exactly the opposite assignment, maybe the
> two of us are not decoding the same thing - or the modules differ. Could
> you double-check the absolute phase at HFLIP=3D0 on your unit from a raw
> capture of a known-colour scene (not through an ISP that may be
> auto-correcting, and not with the sensor's test pattern - on my unit the
> colour-bar generator is inserted after the flip/window stage and shows
> the same order and phase in every flip state, so it cannot see this)?
>=20
> Happy to test a v3. For patch 1/2 of this series everything checks out
> on my unit; sent a Tested-by there separately.
>=20
> D. Manresa <dmanresa@gmail.com>
> 
