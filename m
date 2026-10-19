Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792452074;
	b=ac1pG1RasLiZ1RGWvLiCoOgcsCpaH4HoRmDlVEXfAe5hgxdVMVthRmM73/aLM/j7Ms37
	 w0gW70S+PkY/7wkPJ2SyZFU74MT4DD83ZAi5yHU9Kf/z9gznAV2fEXdV+5bAIHu4gb3F7
	 vAQ3mtSJ64gV19Fj7yBEyXRuHVgSzIs/osM55OvewyneDO5W4MdSh0O/58p2X1Y/ipMPy
	 rM5Cxk1PRP5d0Vac5dEduyKrol9SJBqqPF3yjuZ1gisobnLlBgJCVnHTQNd6FAltrbnVe
	 dT2iVVKQs7kTiCc3xvpo7YFVFO5UKA4h9OiscESIJEhmK3SHm1n1damij6lFfqIar2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SDRnHnRoknSiYUsalL/FFfb9UodnclNsTRZz4O77Pzg=;
	b=kpoxcTbVle4y3lU8yWvtXoN3icnW2SKsAXjJgem1KZe4f2o7bVNTWeLFpZiakLNkd4Kn
	 tttPXgd1Ua8MLhBQ9h1mGBuNIRz8rnom5lAEgVK9gxrYRN69LElgEzf0qTTETZMjESNkc
	 SZ7EBpmPtB+8J67hu2uPZGP7PyAAJQ7uzR5kV9py3eqBuhXfUVumsUO9ezkXXkEmpsiVR
	 9HfTxqlQPkSz0yWXCFlm17qXgsdVqbSdnNV/ZTE9KWiuUY87MCgLJ5DdyupVccYTxbVAn
	 99tyarxipAkf967sB0wXhEQlUiBxhT/8DaNfhuWE4lcS/JpaWytddcB7mIuWhf+VOtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OB8lLIal;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2C606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OB8lLIal
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4f48d91ba7dso1644421b6e.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792452072; cv=none;
        d=google.com; s=arc-20260327;
        b=HNALizSIBy4OMHOU9yoxnk/QVWMriF2H/7P/gLpFoSpT87cUVoxFxAM69f50CCx6wD
         C1fSjcGDJ67Qvv/aFDJtIRnp7QDYKAdRUzWZI/ivmyB2Lt7VTkU0WjtN3PQOpObCvQlY
         iyt2vEkdh6XLNYG6BYIlR2mIF7z6dhP1A18EvkAEzcF5nwNXMb3+m9f2GorHxOL1hjev
         fyIrNxertvFpHK235ZkYhEzjphSfBVf/1BRf2s6HQep3hPttpfcf3lM+/IwP7yfUiL4l
         mGIeeDdPiZrFu8JfQHD1vJUaoDBWyMFvZrrVIVcK3KjVhTlJLumanOh31KyiKOzrPPVL
         rq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SDRnHnRoknSiYUsalL/FFfb9UodnclNsTRZz4O77Pzg=;
        fh=t6hokBev10KMq7DrWsBPUJeafgvTlzbDCm2yXkkmYTU=;
        b=a56G/FH9/Yg4QaUMqQp6mB+94OSLSl6fHtXcWHVQq9g4jk06IGOv1ZIJCVhIy2uqyD
         A3RzBMAnAe+yysAOj8k5Y1ZA4CxnZ6gKtK7mrGp5bTu/FHtpdeXsTINAqRC5ja1wUtoG
         8a+K4zoXzhmFTgLSScvfTtH0KbPEjXgDcNN2xutB6KgyiVwGc2g2EOeFVKQhFlcDqCi6
         JYl+JbFQt3DYTuC8o6xzQ7LzCNGEPukxUBz9nOggMs+I+fXZaHkm8p3oWT1L6GoJ02IN
         iQexaIOBi+jE3pDIiVR48VU+5hktjGTgg02oia2dhANZR+yvjeIvr/WT0hnZwyRlHeaW
         jABQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792452072; x=1793056872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SDRnHnRoknSiYUsalL/FFfb9UodnclNsTRZz4O77Pzg=;
        b=OB8lLIal3BnEANO0+3epJPMs3uAeH6wcSS8AF6FERJCKubysRyBPdlIhnZ0rscD+K6
         TFOmmO2wOSZEr92QQvRHXQIB70qvQFh2biSw4gQ3JfkFxnxOihj5Gd7dJL3z1eOjOU+h
         FIL27j87jNQ8pAYAd4XBs9OWBTsHXzmETAUxJRgi8/6Qmx/ukn26VSgWgcYCfRoeiVm5
         BkdZDaQntLnrPwN0YTimmsPmu4Lln4sCc0mNRjHDC0YXbyyngPPeCEK/pFbetiSbVhQ5
         RGgZssf+nonHnG2Qh+CurwyKPb5I+9BNB+NDQBsnDeuXrP8eJtomMFY3VjmzbduId4IQ
         isiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792452072; x=1793056872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SDRnHnRoknSiYUsalL/FFfb9UodnclNsTRZz4O77Pzg=;
        b=ye6FrGytOQgqOOziSyi3iGWp9+yu9LI+M2MZDEbJFNsZFiC9qSDcJ6LZ3T597jOKlA
         qWRJi3t+RDKn+Pfj3liry0Qas0ZefJ/ZFlAe4myWtPfoqHaMkw90RIvrF481oDKuX2MF
         N5/+Pp1EDdYxWm7NuGdPkDEoOM9PZzQy/mepbFQ/0HFSNXpMkIXoQplOYEpfZ4LEzum/
         CQNljT3hqvqDgeifMoGMAUmnFKOsjweI15SJGsz8b58oM29A/7LrwK9z0bqXBZxxBL0t
         a7HaDJWFgqDVKqAIkhTXU6TP23ZJy0iktOr4XSk5VChsC/mngluil6puSo5dukFwsM+O
         ygIA==
X-Forwarded-Encrypted: i=1; AKwUvBwxvSvSRp+Oh/+ZYUj6lZ6aoPqj4fBT0f/wk4cLn96/m7ICpjp6orX/267hth50ZjuZjAOlQUE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeDAcI4iyxxxaJNi4x14tiBbUfax/NGxvsoYtSzzI2OtNsjrN/
	IOj9VxMSBuWKkij29qnlignop73fQMJbf32ZusW3kwQBVW0ZwO8Pdy5jNqQ/+s5ZnyJQXKclfLM
	3ClY030DXKimzWNkDlguOmMQGlJZRUYE=
X-Gm-Gg: AYBFou0a9PUyE9IsPXRRH9ipT2Uud3zkPcZLr/IJh3BjJ3KkExfZ8U6Z1JVXl+M/EBA
	x63fjlIHVJaxNc7QtINeb8yLkqXxfWfzzu3IWwFngYmfX8ja0QQdN/xopUHGb+KSJcDmgwrVQ7h
	hf5bqb3d+JeNVvzKBv3Eszxxv3LrD3b0eEMRIRavLnYuas7PC+9TAKyhKcRfnIhgKsI3/l/EHU+
	feNu26Vg1/4KI6gRw1L46+zTwzs513ZRxc/Auyt0zY1k3HHza8nxHSPuLpmiwuSPcSFHk1RZTU9
	1V6BfHirTNiEWVtxQGBKKuXApTzrPHSZtEgFTUa+6pXwjPSxS5+ezA/d8Isxiv7I0hubouVCtTN
	hSCxfbEHA+F4wcm4sukXXpwisGaooHlcGWXceNZLh
X-Received: by 2002:a05:6808:f8f:b0:53c:7298:3591 with SMTP id
 5614622812f47-53cc5b5ba6amr7389614b6e.1.1792452072397; Mon, 19 Oct 2026
 16:21:12 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com> <atYPlC-f2AQEjYWS@intel.com>
In-Reply-To: <atYPlC-f2AQEjYWS@intel.com>
From: Michael Anderson <mwwa919@gmail.com>
Date: Mon, 19 Oct 2026 19:21:01 -0400
X-Gm-Features: AclHuK8zNi-iWumfIYywLUJws8kEsLt3lRCO9cEQZoc-Vcc1AV0INueMYu3zYtw
Message-ID: <CAL-Wm=OR8FRGC6Vv-5+4u6aUrnPH=jP8RfSOqKXjvwhEyXWREA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV MIPI sequences
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	intel-gfx@lists.freedesktop.org, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 03:39:48PM +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> Please file a bug
> https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items and
> attach a copy of /sys/kernel/debug/dri/0/i915_vbt there so that
> we can all see what it looks like.

Done: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17402
with the VBT dump (raw and decoded), i915_display_info and a full
drm.debug=3D0xe dmesg from the unpatched driver.

> I think what we should do is stop using .gpio_panel and/or
> .gpio_backlight when the VBT expects to control them via the
> sequences.

One wrinkle with keying it on which sequences exist: on this tablet the
reset sequences drive pin 10, the one i915 owns as "backlight", and the
VBT has no BACKLIGHT_ON/OFF sequences at all:

  DISPLAY_OFF:     GPIO 10 -> 0
  ASSERT_RESET:    GPIO 10 -> 0
  DEASSERT_RESET:  GPIO 10 -> 1, 0, 1
  (GPIO 11 is never used)

So with your sketch want_panel_gpio would go false (freeing pin 11,
which the VBT doesn't touch) but want_backlight_gpio would stay true and
pin 10 would still be busy. Would it make sense to scan the sequences for
the GPIO numbers they actually use, and skip requesting pin 10 and/or 11
when a sequence references it?

> The big question here is whether we need to keep some kind of
> hybrid approach where one pin is controlled by the sequence and
> the other explicitly by the driver.

This machine looks like that case: pin 10 is driven by the VBT, pin 11
only by the driver. I don't know whether the panel actually needs pin 11
driven; the GOP leaves it high. I can test a build that leaves pin 11
alone if that helps.

Bart pointed out that a timed pulse like DEASSERT_RESET is beyond what
reset-gpio or gpio-shared-proxy can do, so not requesting the pins the
VBT drives looks like the simpler fix to me. If you agree I'll do a v2
along those lines and test it here.

Thanks,
Mike

On Mon, Oct 19, 2026 at 8:39=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrot=
e:
> > From: Mike Anderson <mwwa919@gmail.com>
> >
> > On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> > backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> > itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> > GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> > sequences also request their pin through gpiolib, so when a sequence
> > toggles one of these two pins the request fails and the toggle is
> > dropped:
> >
> >   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY=
)
> >
> > Before that commit the pad registers were written directly, so the
> > sequences could still drive the pins i915 owned.
> >
> > The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> > panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> > MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> > failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> > during takeover and stays black, even though the backlight PWM and both
> > enable GPIOs read back as on. The tablet only has a usable display
> > with nomodeset.
> >
> > When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> > corresponding descriptor, set it through that descriptor instead of
> > requesting the pin a second time.
> >
> > Fixes: 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV GPIOs behind =
the driver's back")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM sparse
> > Signed-off-by: Mike Anderson <mwwa919@gmail.com>
> > ---
> > This patch was developed with an AI coding assistant (Claude Code,
> > Claude Opus 5.5): it ran the debugging session on the tablet (drm.debug
> > log, gpio/pwm debugfs), traced the -EBUSY to 8241b55f1ded, and wrote th=
e
> > change and the changelog; I reviewed it and tested it on the hardware.
> >
> > Testing, Toshiba Encore 2 WT8-B (Atom Z3735F, BIOS 2.10, VBT MIPI
> > sequence block v2, PPS_BLC_SOC):
> > - Arch Linux v7.2.11-arch1 with this patch backported (applies as is):
> >   the panel lights up at i915 takeover and the Xorg login screen shows;
> >   no "GPIO index ... request failed" errors; gpio-10/11 stay owned as
> >   "backlight"/"panel". Unpatched v7.2.11 and v6.18.57 give a black
> >   panel with five -EBUSY errors during boot.
> > - drm-intel-next: built intel_dsi_vbt.o for i915 (=3Dm and =3Dy) and fo=
r
> >   xe (=3Dm) with W=3D1 and sparse (C=3D2, sparse v0.6.5-rc1): no new
> >   warnings.
> >
> > Not tested: other VLV machines with PPS_BLC_SOC. Their behaviour only
> > changes when their VBT sequences touch pin 10 or 11, which currently
> > fails with -EBUSY anyway.
> > ---
> >  drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 32 ++++++++++++++++++++=
+++-----
> >  1 file changed, 27 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu=
/drm/i915/display/intel_dsi_vbt.c
> > index fe12041e9..85d1cdc6e 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> > @@ -54,6 +54,10 @@
> >  #define MIPI_VIRTUAL_CHANNEL_SHIFT   1
> >  #define MIPI_PORT_SHIFT                      3
> >
> > +/* VLV NC pins of the backlight and panel enable GPIOs, see soc_panel_=
gpio_table */
> > +#define VLV_GPIO_NC_BACKLIGHT                10
> > +#define VLV_GPIO_NC_PANEL            11
> > +
> >  struct i2c_adapter_lookup {
> >       u16 target_addr;
> >       struct intel_dsi *intel_dsi;
> > @@ -247,10 +251,12 @@ static void soc_opaque_gpio_set_value(struct inte=
l_connector *connector,
> >       kfree(lookup);
> >  }
> >
> > -static void vlv_gpio_set_value(struct intel_connector *connector,
> > +static void vlv_gpio_set_value(struct intel_dsi *intel_dsi,
> >                              u8 gpio_source, u8 gpio_index, bool value)
> >  {
> > -     struct intel_display *display =3D to_intel_display(connector);
> > +     struct intel_display *display =3D to_intel_display(&intel_dsi->ba=
se);
> > +     struct intel_connector *connector =3D intel_dsi->attached_connect=
or;
> > +     struct gpio_desc *gpio_desc =3D NULL;
> >
> >       /* XXX: this assumes vlv_gpio_table only has NC GPIOs. */
> >       if (connector->panel.vbt.dsi.seq_version < 3) {
> > @@ -265,6 +271,22 @@ static void vlv_gpio_set_value(struct intel_connec=
tor *connector,
> >               }
> >       }
> >
> > +     /*
> > +      * With PPS_BLC_SOC, intel_dsi_vbt_gpio_init() already owns these=
 pins,
> > +      * so requesting them again fails with -EBUSY. Some VBTs still to=
ggle
> > +      * them in their MIPI sequences, e.g. as the panel reset line, so=
 drive
> > +      * them through the descriptors we hold.
> > +      */
> > +     if (gpio_index =3D=3D VLV_GPIO_NC_BACKLIGHT)
> > +             gpio_desc =3D intel_dsi->gpio_backlight;
> > +     else if (gpio_index =3D=3D VLV_GPIO_NC_PANEL)
> > +             gpio_desc =3D intel_dsi->gpio_panel;
>
> Please file a bug
> https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items and
> attach a copy of /sys/kernel/debug/dri/0/i915_vbt there so that
> we can all see what it looks like.
>
> I think what we should do is stop using .gpio_panel and/or
> .gpio_backlight when the VBT expects to control them via the
> sequences.
>
> The big question here is whether we need to keep some kind of
> hybrid approach where one pin is controlled by the sequence and
> the other explicitly by the driver.
>
> For example https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/1=
4605
> has a VBT where the reset pin is controlled by the VBT but there is no
> backlight stuff whatsoever in there. Well, unless some of those DCS
> commands has something to do with the backlight, but IIRC DCS has no
> standard stuff for backlight so it would all be panel specific. So
> it's not clear if a backlight GPIO pin is needed at all there, of if
> the DCS and/or the PWM alone is sufficient.
>
> Hans, do you still have these funky VLV DSI machines around, and if so
> can you check whether they would need this kind of hybrid approach?
> Sadly all I have is old stuff that doesn't use the VBT sequences at
> all.
>
> If we do need the hybrid approach then it could perhaps look something li=
ke this:
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -917,8 +917,14 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel=
_dsi, bool panel_is_on)
>
>         if (display->platform.valleyview && mipi_config->pwm_blc =3D=3D P=
PS_BLC_SOC) {
>                 gpiod_lookup_table =3D &soc_panel_gpio_table;
> -               want_panel_gpio =3D true;
> -               want_backlight_gpio =3D true;
> +
> +               if (!connector->panel.vbt.dsi.sequence[MIPI_SEQ_ASSERT_RE=
SET] &&
> +                   !connector->panel.vbt.dsi.sequence[MIPI_SEQ_DEASSERT_=
RESET])
> +                       want_panel_gpio =3D true;
> +
> +               if (!connector->panel.vbt.dsi.sequence[MIPI_SEQ_BACKLIGHT=
_OFF] &&
> +                   !connector->panel.vbt.dsi.sequence[MIPI_SEQ_BACKLIGHT=
_ON])
> +                       want_backlight_gpio =3D true;
>
>                 /* Ensure PWM0 pin is muxed as PWM instead of GPIO */
>                 ret =3D pinctrl_register_mappings(soc_pwm_pinctrl_map,
>
> > +
> > +     if (gpio_desc && connector->panel.vbt.dsi.config->pwm_blc =3D=3D =
PPS_BLC_SOC) {
> > +             gpiod_set_value_cansleep(gpio_desc, value);
> > +             return;
> > +     }
> > +
> >       soc_opaque_gpio_set_value(connector, gpio_index,
> >                                 "INT33FC:01", "Panel N", gpio_index, va=
lue);
> >  }
> > @@ -430,7 +452,7 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *i=
ntel_dsi, const u8 *data)
> >       else if (DISPLAY_VER(display) >=3D 9)
> >               bxt_gpio_set_value(connector, gpio_index, value);
> >       else if (display->platform.valleyview)
> > -             vlv_gpio_set_value(connector, gpio_source, gpio_number, v=
alue);
> > +             vlv_gpio_set_value(intel_dsi, gpio_source, gpio_number, v=
alue);
> >       else if (display->platform.cherryview)
> >               chv_gpio_set_value(connector, gpio_source, gpio_number, v=
alue);
> >
> > @@ -886,8 +908,8 @@ static struct gpiod_lookup_table pmic_panel_gpio_ta=
ble =3D {
> >  static struct gpiod_lookup_table soc_panel_gpio_table =3D {
> >       .dev_id =3D "0000:00:02.0",
> >       .table =3D {
> > -             GPIO_LOOKUP("INT33FC:01", 10, "backlight", GPIO_ACTIVE_HI=
GH),
> > -             GPIO_LOOKUP("INT33FC:01", 11, "panel", GPIO_ACTIVE_HIGH),
> > +             GPIO_LOOKUP("INT33FC:01", VLV_GPIO_NC_BACKLIGHT, "backlig=
ht", GPIO_ACTIVE_HIGH),
> > +             GPIO_LOOKUP("INT33FC:01", VLV_GPIO_NC_PANEL, "panel", GPI=
O_ACTIVE_HIGH),
> >               { }
> >       },
> >  };
> >
> > ---
> > base-commit: 0507cc5a476af0b6d037b19248bdd20dbe27487d
> > change-id: 20261018-vlv-dsi-owned-gpios-cd127ba137e7
> >
> > Best regards,
> > --
> > Mike Anderson <mwwa919@gmail.com>
> >
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel



--=20
Michael Anderson
