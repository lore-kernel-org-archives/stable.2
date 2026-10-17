Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12C45BE3
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195556; cv=pass; b=Ekz5Rseu8GeOK1Aw4u8ThREHRhMhU+e97f65GLBz1qfWJqCK/n53qYKhfb+syL03TVP0YVoT0uv6mqx5jweU98tb/dPk3V/zq1jbZp32tnkpL1C0Y3KIq/knQ/4PN6+BkiNi2GWd55UNqkYosDvSadxIh+UAx+L4b9UpjpA6uKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195556; c=relaxed/simple;
	bh=02BQi84FUAtE5RV52UueDOwghGcWGs0jqPnkAQ/Biq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sR2auyW7h2SxVM9zijT+kxcqOwQJwYZcomNcEDmmqSstO/gr2xRJ2RCqMJBL8eVsncuoai6HZvYBs8WqECPkFVRDLGApw5yNbheCdaReenzF11wkEcjmPT1i8hzBdHtSHpj4Ofqq9oF+oAWhkn4gLplII/8xv8rm4bEcfbL5fRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Da5ntQ; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Da5ntQ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91791ec1b83so4116066d6.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792195553; cv=none;
        d=google.com; s=arc-20260327;
        b=pI5pwjCCqh7PDfMzqF8NRY0yfBmHkwplkd2DPAT04Vedd0hksvYXFpJKB05aM4OQYO
         ZIz6+8qvWDUmlb4LjFgHevgjERJ1ukE7w3UjzWoW8/sQDwyaCxeHxsEsIQLrD7prrMnF
         nmlRs45WcTRSwB1iTILFZTOQ6iQ4a+IMENrsyhrSmTc9ZhBd5POOj1LlLwnN4F7itrgX
         jswaczGqsKXFXaNXYZB7UtNgNNBbp3IfandcJGcZDwdaAJSijZX5IqnuQ7WNUIFeBB9m
         Zm+zZO7F8RAkGELXiRXKCilUFNpAnA9GwX7czOhHfoJFXgA4wtG6TLgu7RbD1225XeWl
         X/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kK9dd5FfOGQnyxwJqESSjuJBP8NcOkq7nYMyK9tV4Xo=;
        fh=1HnYejAXTqRvIYbJIbcm/PBmkQ32iCYAgYd8Pig4S+g=;
        b=c1w1B3kbC3YtD3gfoOP+7px8dCn/7NDDniQIAXDboIEXM1xL9hhc3y2b4GMn66TB9M
         /7cRPLlaBYGnKgYplRJiiWiKAmHVITP9ubmlO/2XHCp09x31WGDTuPhwcpkpiaYSzKji
         xWLJKgjvueqtRSXHUD/b0hoxss2E40UhW8oUx+HfoO70nLHDVR5lz3ztFFpcbeCU0shf
         c1zZnq2iwxX+C3dWYnnKQZ3AOiSz9ooneiW35dIU/JAZGUu/AY2aL9j8ywjb1HC/1piO
         z1IKJSzHgttU7VShnCwGtUe3wlDKnDRjvDGBrA9iXs+R8NXggC7Mr17BahBhzOC4i1WW
         xg8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195553; x=1792800353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kK9dd5FfOGQnyxwJqESSjuJBP8NcOkq7nYMyK9tV4Xo=;
        b=I2Da5ntQy1wRwm2IWbBknBmBrfuYQ0AxYfreIOE3eg1BxZQ/Zo3843Fx4zoRlhC0j9
         EK/943LyhOquLgI/LHjRFArE1V4htatDRk5X6+MXETpGwzgUJOmrhRjuJfHEb8l+hpr3
         ewNVEoo62MDbKwOvIAyRaAAJH6F8JclYVm7eNGzTTM9n2MyTlR5O1MGHpxvB24zAoE+o
         o+A4Dv4Gj8pXw/kuzSAYD6Fqv1F8ROZpyR3mxvT/Supi9MgLtJr89Gvkbk0POl7BvCwG
         WwIM2e7AI9t/LK0IKAXJmIBGPOJTr2OHhCCK+9F/brkEULWChtCMCdOZ7Fohmb9RDVGg
         Jl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195553; x=1792800353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kK9dd5FfOGQnyxwJqESSjuJBP8NcOkq7nYMyK9tV4Xo=;
        b=Pur4kccFnGGi2hUrC5wvrSlitULPnutEb8VjAZYefmp1In4vR7LSQPoC4w1IPWODyG
         Gqv9yCednIXNNIzzmpFfZBNikkjtyEg4TRIF7VO/qJX0kX3bviZOukZurA4CdaWjY0/9
         nd+AQ1dK+sw12GKHbQQB1rEiw8umScaY4iQBzu+wzZgFeprDk8Jf+1CO1SXPBHAOFsCA
         iCrnOiYgtS23oAbKQne3KukEU3T4OCtyIrtJi41A0CYg2v7ch2kpHj4MmiOq2hPfuup5
         F1cEG9aBmJP70AAIFTlyrFl2GZY2doG/XZcvhFCyQrFDqI/HP30GCSKxlzoKjm6wgz8D
         p8Aw==
X-Forwarded-Encrypted: i=1; AKwUvBy6vWMcbORyE7XbW8BgI6OQhA1TiO5lw6yVxNvp1C1vAs1NXxjYEQn4nZMtrlEC9uSVBGIiRjA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIefrw+Dr1BXIXl8JAfWfO5vURlkjFcy5hy3TXNXdqQhBoNYzbh
	//RKYQ+WdCQuUJeqHTxKWcPr6fjtSMfjqYU+R4l3uHqkrOjemWRqP9BLv2d7kKY+nAAR8wNxWM/
	csCgfeIjePtHXUuagMeGzRamXQBJnzFI=
X-Gm-Gg: AYBFou3Vv4dMMzwc79Fnps0vrSMuX4p4b5EM3hgJc4grT3u5WbhbznPTjN6pgThpw6x
	9ClaJCk5mUxRvkNw3Y570EFEQsN8DlhhpbQQPrzJIAUQZfILyYyn310WIMfy+U13+e5yVUaGi1k
	dcRTuOL+jL9wPqkKTze9XtfjBrW+udaC+lYP12sP9gtaQ/RfVwtYkyRb4vuIHzs1xYZnubIbNIt
	+NDcmefq9P9UWApEbVPwSvcc+wKOQYbtYG7LfryWmjXWDA5Vsc7dMPg2Egral544d3sRnmid6O4
	GPKobCXd1X3lb2JtgSVySozeBfXUBuKPuOLukOjLMidHZ6KJSHBLWvs=
X-Received: by 2002:a05:6214:766:b0:917:8783:341 with SMTP id
 6a1803df08f44-91bdf3e1e3bmr28225306d6.45.1792195553124; Fri, 16 Oct 2026
 17:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20260927041138.4112920-3-jinmo44.yang@gmail.com>
In-Reply-To: <20260927041138.4112920-3-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 16 Oct 2026 17:05:41 -0700
X-Gm-Features: AclHuK_pqOM0nh2PKLmkogbaRyb0DRMy3kSfOq2Ob-BWY6-XdtMjof79nHSmSJM
Message-ID: <CANRwn3SL3_1ees-D6CQviQRLjwLjCp4Ssjqwj4M_wbb8Fefprw@mail.gmail.com>
Subject: Re: [PATCH 2/5] HID: wacom: check the input devices in the legacy irq handlers
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 9:12=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_penpartner_irq(), wacom_pl_irq(), wacom_ptu_irq(),
> wacom_dtu_irq(), wacom_dtus_irq() and wacom_graphire_irq() take
> pen_input, and the latter two also take pad_input, without checking
> either.
>
> As described in "HID: wacom: check the input device in the shared
> report helpers", a partial interface leaves one or two of the three
> input devices NULL on a fully successful probe, and wacom_wac_irq()
> still dispatches to these handlers. Seven locations fault, each
> reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
> device plus a single UHID_INPUT2 write:
>
>   wacom_wac.c:137   wacom_penpartner_irq    pen_input
>   wacom_wac.c:227   wacom_pl_irq            pen_input
>   wacom_wac.c:244   wacom_ptu_irq           pen_input
>   wacom_wac.c:303   wacom_dtus_irq          pad_input
>   wacom_wac.c:326   wacom_dtus_irq          pen_input
>   wacom_wac.c:391   wacom_graphire_irq      pen_input
>   wacom_wac.c:444   wacom_graphire_irq      pad_input
>
> for example, with vendor 0x056a product 0x0030 (PL) and report id 2:
>
>   BUG: KASAN: null-ptr-deref in input_event+0x44/0xb0
>   Read of size 8 at addr 0000000000000028
>    wacom_wac_irq+0x2b27/0xb3f0
>    wacom_raw_event+0x68f/0xb60
>    __hid_input_report+0x398/0x4d0
>    uhid_char_write+0xa99/0xfc0
>
> Check each pointer where it is taken. wacom_dtus_irq() and
> wacom_graphire_irq() serve both pen and pad reports, so the checks are
> placed per branch rather than at function entry: an interface that has
> a pad but no pen must keep delivering pad events.
>
Such a device does not exist for the cases handled by
wacom_graphire_irq and wacom_dtus_irq. A pen interface is expected for
all of these device types, and a pad interface is expected for all but
the GRAPHIRE case. The wacom_setup_device_quirks function takes care
of ensuring that the pad type gets added to the same interface as the
pen (for all but GRAPHIRE) so that wacom_setup_pad_input_capabilities
does not cull the interface later.

It should be safe to move the checks for valid pen and touch
interfaces to the top of both of these functions (again, with the
additional condition that wacom_graphire_irq must must ignore a NULL
pad in the case of a GRAPHIRE type).

> wacom_dtu_irq() gets a check too. Its only dereference is in a
> dev_dbg(), so it does not fault with CONFIG_DYNAMIC_DEBUG=3Dn, but it is
> unconditional in the source.
>
> Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
> Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD de=
vice_type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 177a1e09fd05..794c2865064a 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -128,6 +128,9 @@ static int wacom_penpartner_irq(struct wacom_wac *wac=
om)
>         unsigned char *data =3D wacom->data;
>         struct input_dev *input =3D wacom->pen_input;
>
> +       if (!input)
> +               return 0;
> +

As with patch 1, each of these checks is for an unusual error
condition so a dev_warn_once or hid_warn_once before returning is
suggested.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


>         switch (data[0]) {
>         case 1:
>                 if (data[5] & 0x80) {
> @@ -174,6 +177,9 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
>         struct input_dev *input =3D wacom->pen_input;
>         int prox, pressure;
>
> +       if (!input)
> +               return 0;
> +
>         if (data[0] !=3D WACOM_REPORT_PENABLED) {
>                 dev_dbg(input->dev.parent,
>                         "%s: received unknown report #%d\n", __func__, da=
ta[0]);
> @@ -233,6 +239,9 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
>         unsigned char *data =3D wacom->data;
>         struct input_dev *input =3D wacom->pen_input;
>
> +       if (!input)
> +               return 0;
> +
>         if (data[0] !=3D WACOM_REPORT_PENABLED) {
>                 dev_dbg(input->dev.parent,
>                         "%s: received unknown report #%d\n", __func__, da=
ta[0]);
> @@ -263,6 +272,9 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
>         struct input_dev *input =3D wacom->pen_input;
>         int prox =3D data[1] & 0x20;
>
> +       if (!input)
> +               return 0;
> +
>         dev_dbg(input->dev.parent,
>                 "%s: received report #%d", __func__, data[0]);
>
> @@ -299,6 +311,8 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
>                 return 0;
>         } else if (data[0] =3D=3D WACOM_REPORT_DTUSPAD) {
>                 input =3D wacom->pad_input;
> +               if (!input)
> +                       return 0;
>                 input_report_key(input, BTN_0, (data[1] & 0x01));
>                 input_report_key(input, BTN_1, (data[1] & 0x02));
>                 input_report_key(input, BTN_2, (data[1] & 0x04));
> @@ -307,6 +321,9 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
>                                  data[1] & 0x0f ? PAD_DEVICE_ID : 0);
>                 return 1;
>         } else {
> +               if (!input)
> +                       return 0;
> +
>                 prox =3D data[1] & 0x80;
>                 if (prox) {
>                         switch ((data[1] >> 3) & 3) {
> @@ -363,7 +380,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>         }
>
>         prox =3D data[1] & 0x80;
> -       if (prox || wacom->id[0]) {
> +       if (input && (prox || wacom->id[0])) {
>                 if (prox) {
>                         switch ((data[1] >> 5) & 3) {
>
> @@ -438,7 +455,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>         switch (features->type) {
>         case WACOM_G4:
>                 prox =3D data[7] & 0xf8;
> -               if (prox || wacom->id[1]) {
> +               if (pad_input && (prox || wacom->id[1])) {
>                         wacom->id[1] =3D PAD_DEVICE_ID;
>                         input_report_key(pad_input, BTN_BACK, (data[7] & =
0x40));
>                         input_report_key(pad_input, BTN_FORWARD, (data[7]=
 & 0x80));
> @@ -453,7 +470,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>
>         case WACOM_MO:
>                 prox =3D (data[7] & 0xf8) || data[8];
> -               if (prox || wacom->id[1]) {
> +               if (pad_input && (prox || wacom->id[1])) {
>                         wacom->id[1] =3D PAD_DEVICE_ID;
>                         input_report_key(pad_input, BTN_BACK, (data[7] & =
0x08));
>                         input_report_key(pad_input, BTN_LEFT, (data[7] & =
0x20));
> @@ -468,7 +485,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>                 break;
>         case GRAPHIRE_BT:
>                 prox =3D data[7] & 0x03;
> -               if (prox || wacom->id[1]) {
> +               if (pad_input && (prox || wacom->id[1])) {
>                         wacom->id[1] =3D PAD_DEVICE_ID;
>                         input_report_key(pad_input, BTN_0, (data[7] & 0x0=
2));
>                         input_report_key(pad_input, BTN_1, (data[7] & 0x0=
1));
> --
> 2.53.0
>
>
