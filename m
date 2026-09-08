Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF8361DD5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897648; cv=pass; b=MNXZHvb+jgWHR+egMMOTbPi/PWOGMRx+XZVdoZQQLPofF6bP3QsJczzgzKCcLlXM0pbKFYu6tQni0/dMmbEygOzRs+ZfqZRRlKXQgbfOIJ8sv6v6UI2m+dy1C7Zr/5FKVmvSUjbVd6FNGuxvSJXmXv+fZx2hX1ZGG5LJOGjDyqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897648; c=relaxed/simple;
	bh=ct6BRIS7gjSE545HaS0qgtu8ZzLKg5GQW5zmft9i63A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXuM52lKxssqshhN50bwtkeLkZyCjYuAx2dskDQ6fAhHmO2TqEUeM0JDxI1Cht6siKVq0WA9q+BJDrgDfcXnmTBD6j6wUwST7QpLtH+kfOcBQRK3DeixrWvU/Aw1d56a+ppk+JQ0k9mnXlpIAHqab0Nb9BvEjVV3Yhosu7kg3Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY/ISxz8; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY/ISxz8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84864086bfeso4542980b3a.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 13:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788897646; cv=none;
        d=google.com; s=arc-20260327;
        b=jjnO8JWG1kiTxEmXKP8JYCAM3o2hTkJh4hhDJia2V25aY3WApl/GxSlZQnu3//+rby
         2uobMkiU7e9h0SHGi6p5ACLNrlxuEsyQUsjGsBNtbiv3tBHqyglhijoFozm+YGcD3jGE
         pC9RmwQFvD5CXtBcmObRglS9fs9wTDc3ehLtxyNpyZBNcIuxHUJB/STCt1sRS2q7riPU
         bU0cD8Cyp+99O+D9x+W9a1aYv+l5T0vwcFOG7VFgXFGfbgdt9KmZCYTUaog849vNjxzT
         +tKkB8iv2gbM5ym3kHrrZENM821CKG/ULpEk0qFEXHmshNHR8BU5KBQymGASNVSK3ifO
         hiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CgnFpj0KhXyBQSPhlPzZGfxCaAjurfhKYEu5Mk/FQ5I=;
        fh=+KE2LajI3UfcwiDXaKPzs/tyiHmCtoeGQZsjhYzbxGo=;
        b=i25Y0jf5Z44olaYCifVCkTxgC7TAgspeZWBgvz9rn8u+X3vqatK8jP0r3rIllHcKPn
         LGXtRfPih3SCCMybFEwG5Lv6GmOryG6lpBXq8nrheG3NatCVhi5fk0zd7Ls+SxFMujVc
         QfIEhdj68s3FLwkB/bbmhKPT5SAyKg1xqXT+HmMi2EFb2wHnouJ+eMCb8eIIyzOcFJ5t
         /L/qIKWf30DxRWwS55IhmBb6EsklzdXs3yFerSGuZ7B3eiIDFkn/KrY/zckm4EKNXLL7
         vAgQ931Mg2nRGn+sQvW2RBUwRKC13QTOhBv/mD46rdZCsXICAd1uFnrin26Ky5dbD/ac
         GJ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788897646; x=1789502446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CgnFpj0KhXyBQSPhlPzZGfxCaAjurfhKYEu5Mk/FQ5I=;
        b=QY/ISxz8eUguiJK1vVdvruytyoW/xtSUJdt7KWQA2hivNNlZ84tSYf/FFeP6/4bWzN
         2lbZX9ynl7DkUFFly5nIJxQm1ZDfwaWB0VIu/N5QPO9D0ow/iu+T2P9D1kxHlOQZj5Vc
         HLTtEjTjOY8FJCJ0gWahl6aFfWtYWHeORiXEUjDbQrnq1uLfTy8F6mX1MXYd6w+uli6E
         GXzLa3BxyyT+NZayaGSOfj0nocKffkrxVwks26bJmg37O6jvUJ8JVzrk9inF7oP+nd9v
         AgtcIMjcAVCnIzTm3sIBfZ/R3Yd8Qx3hZgOtOcxmuF6cx7qUKEd50KrOCOZ0Xfzy9s+J
         sewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788897646; x=1789502446;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgnFpj0KhXyBQSPhlPzZGfxCaAjurfhKYEu5Mk/FQ5I=;
        b=JtSzocbt90PPJgc+v45zKbzGLSLk2if3AMFMiQlp6im9e3faR8+2002XlrBL7YFomx
         CPZYGgZ1tUfvuQzUBuhpde7e8vn1uVBWyunynLGDcsL3aid/n8BRn9CiYh9Dgx/dq7ON
         hX2SJpSsWjH+2cxrjpM9E2XszGlueaeA3k+bBSpzs4Zxne+U2pIU+aL/H8NMkAXgfXk9
         iGtmD64iDZHfFgfj4JkJW0ejPeYW+MdSYIklpN/h/01V0zJe38VtJ8KJnxvKOyMq8Bnv
         FGyRc9VCJVLVb+EGFCIW5y8r8M9jpR2Ot4oH1+/1NR8rCDO5EScccqsptdJy4LlptfpD
         4d/w==
X-Forwarded-Encrypted: i=1; AKwUvBx4cpW9jLOroXDXynsxdZbDQjBvOtkXvmoZz4v42HB0I7wyS2Ri6r195Vq6AZ3xTOm1jvlsvVY=@vger.kernel.org
X-Gm-Message-State: AFuF++mARXvnHO6jpBo05ocya3Fg7OQRvK3Hr8mbTlRJRcJ45EFRxw50
	mqBN/YTG7SLoASHbjxPcio6Smcq3togxsPHkzio3aMLMl3iQr8UekBrCZl5YcUxCZFafnfUrdFx
	7yiWwPV4I+sMZSF22sD96KEGjEhOa8rc=
X-Gm-Gg: AYBFou3Wwy+pZeJDjZSIo9MaMZrK4XaxcGDEtL0OSTA3CnNMQo3/PULrOYpHVbrcKEO
	HGn+r0HKgkylATXT8SCTMSWuMMv5Day2ZwSLmIlVtLrRzx0eL1MsrZMR+6WRGaLOzD/qT/dwJRY
	d/x6wjrBM3naZDucS12IdllHNvTYWKYbTYXJm63w+i9XgwiM61jT96k/x/eej3PxRK9Rrdk16CF
	pJOQBZFjyEnVMsW4iIiwuUBqIsSOWinhq6d1BjwOQ8VlBLTJ0n5TomwuNXijLSlm7w+yQ6CRnwz
	OsdRyjmpvXW1S/P1CILjy82U/l5aue2wJ/R5RyuezWf/ZorldPe0LSK6
X-Received: by 2002:a05:6a21:a06:b0:3d3:aec2:4dcc with SMTP id
 adf61e73a8af0-3da3a0fd0f3mr52835956637.24.1788897646281; Tue, 08 Sep 2026
 13:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
 <20260825211819.100210-3-mauriciobellon@gmail.com> <CHXPR12MB99922037436C4ADE71BA82E152E5B12@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB99922037436C4ADE71BA82E152E5B12@CHXPR12MB999220.namprd12.prod.outlook.com>
From: Mauricio Bellon <mauriciobellon@gmail.com>
Date: Tue, 8 Sep 2026 17:00:33 -0300
X-Gm-Features: AcwNN1WthglvDl-B0dk2ve42MA1wB5FLHFgw6l5Zd038WYo8I01-a0pmBvdKj24
Message-ID: <CABNo9DcRfNQyw436eP_Y4PdbbwW7NTH3tfH0SB4st+uShFvtJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin, Wayne" <Wayne.Lin@amd.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, Mauricio Bellon <mbellon@lenovo.com>, 
	"Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"Koenig, Christian" <Christian.Koenig@amd.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

Thanks for catching that, you're right.

I went back through the sequence and confirmed that my new
dp_set_dsc_on_rx() call runs in the pre-enable phase, before
enable_link() performs DP link training. I had mixed up the requirement
to configure source-side DSC before link setup with the separate
requirement to enable DSC on the sink only after training.

It happened to work with the X13 and monitor I tested, including the
hotplug cases, but that clearly doesn't make the ordering safe for other
sinks. I won't keep patch 2 in its current form.

Would the right place for dp_set_dsc_on_rx() be at the start of the
post-enable phase, after link training but before
hwss->enable_stream()? Or should it stay in its current location after
hwss->enable_stream()?

I'll wait for your guidance on the intended placement before sending a
revision. Patch 1 should be independent of this sink DSC ordering change.

Thanks,
Mauricio


Em ter., 8 de set. de 2026 =C3=A0s 15:14, Zuo, Jerry <Jerry.Zuo@amd.com> es=
creveu:
>
> AMD General
>
> Hi Mauricio:
>
>      This change breaks dsc, causing black screen.
>
>      Sink RX dsc enable should land after link training. Writing dsc enab=
le to the RX on an untrained link is too early, that should be done after t=
raining. That is likely to be the main sequence regression.
>
> Regards,
> Jerry
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Mauricio Bellon
> > Sent: Tuesday, August 25, 2026 17:18
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lin, Wayne <Wayne.Lin@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Mauricio Bellon <mbellon@lenovo.com>;
> > Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; stable@vger.kernel.org
> > Subject: [PATCH 2/2] drm/amd/display: enable sink DSC before source DSC
> >
> > [Some people who received this message don't often get email from
> > mauriciobellon@gmail.com. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Mauricio Bellon <mbellon@lenovo.com>
> >
> > Direct DisplayPort high-refresh modes using DSC and two-way ODM can
> > commit without visible output during a 4K120-to-4K144 transition. A wor=
king
> > 4K144 stream can also return black after long-pulse hotplug reconstruct=
ion.
> >
> > The DPMS-on path currently enables source DSC before link enablement bu=
t
> > does not enable sink DSC until after the source stream is enabled. This=
 leaves
> > the sink and source compression state ordered differently while the str=
eam is
> > brought up.
> >
> > Enable sink DSC immediately before source DSC in the pre-enable phase, =
and
> > remove the later redundant sink-enable operation near PPS packet
> > programming. This establishes the order as sink DSC, source DSC, stream
> > enablement, and PPS before the compressed stream becomes visible.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > index 48b086d15..412ce52b3 100644
> > --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > @@ -2635,8 +2635,10 @@ static enum dc_status
> > link_set_dpms_on_pre_enable_link(
> >          */
> >         if (stream->timing.flags.DSC) {
> >                 if (dc_is_dp_signal(stream->signal) ||
> > -                       dc_is_virtual_signal(stream->signal))
> > +                       dc_is_virtual_signal(stream->signal)) {
> > +                       dp_set_dsc_on_rx(pipe_ctx, true);
> >                         link_set_dsc_enable(pipe_ctx, true);
> > +               }
> >         }
> >
> >         if (link->replay_settings.config.replay_supported
> > && !dc_is_embedded_signal(link->connector_signal))
> > @@ -2729,7 +2731,6 @@ static enum dc_status
> > link_set_dpms_on_post_enable_link(
> >         if (stream->timing.flags.DSC) {
> >                 if (dc_is_dp_signal(stream->signal) ||
> >                                 dc_is_virtual_signal(stream->signal)) {
> > -                       dp_set_dsc_on_rx(pipe_ctx, true);
> >                         link_set_dsc_pps_packet(pipe_ctx, true, true);
> >                 }
> >         }
> > --
> > 2.53.0
>
