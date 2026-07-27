Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9A28AB0B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174912; cv=none; b=WgaGLnWSks26e99/M56Jptc2d1PxpWNH+YmFlAQzClU1/N4VH99kFiVrsqyyuUl/JeBwP3KBqngqMGnpaF5ODfP19OtWVK++NP0TXRScwfECDuh5MUU6h8mWCoFHubz/XdHeDBUx9CATxMMXyoCuv12WDiyosJX2ZAIw0iekkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174912; c=relaxed/simple;
	bh=sCtd8BBpVHGqs846lKJ2CTMT7DjVK6z3vqMo8R9S5sM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHr6E1CE6wHD2KZTcDOn1/OreFBoSllClu8AHcbSNGJJC1H6TxdfciovCJIY4TaFZtk4L0EHolpp+/avOOAL15CPppV3hpmLW4y9Da+CNSvixHpjtsBb/iuZamfBFCBQ5U7gBfnB6pJTECsgpYV09dVzqBWYbScU09LY0frTJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuykeHUc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8aQPhPf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuykeHUc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8aQPhPf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785174889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3hTRi91CNq2ftIlTw2qCUxBc3lKuCHq2yzoU+61UwA=;
	b=CuykeHUcz0b8dsi6SKe1DABayGewDA+oRdXm8S8J2jdqnPOti8FtXNxS75LSdV9IxA+M4H
	QGd+bMSo273UVNySlFvGwSB44FSmgjisobxcS1oA47OvCobUwJ2d7n7MZqLq8FCkX1VKZj
	ODc7T+XkZqRS0riEnv7Y7niJAxcaYIw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-jvIardwPMvCfVnUOiZcqjg-1; Mon, 27 Jul 2026 13:54:47 -0400
X-MC-Unique: jvIardwPMvCfVnUOiZcqjg-1
X-Mimecast-MFC-AGG-ID: jvIardwPMvCfVnUOiZcqjg_1785174887
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f113592bf3so65865646d6.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785174887; x=1785779687; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U3hTRi91CNq2ftIlTw2qCUxBc3lKuCHq2yzoU+61UwA=;
        b=b8aQPhPftDs5pAtVkm3pXhLgHWuTex7x6oIilpCoVE1cIvxGV9jvO4A7eIa0DDtfGz
         lpKYF99DJ4CBbgtAy5AsVbd+8bUxoo4mxyOj7aqxuqneZEjpcPjknixeHLgznRElgQEg
         J2st3i/nTIzqkn4wCem0UoAxoLduflLZciKqIcXKmDiy50qNd9/qXM9RkfoA++0TIFfG
         0GrjcF73WUxjv+4fhQZL+T7m4VN1Tfqyckn+3JUcnVXiCDIEoHRFgR6gEv7SxRkF8cKv
         FTSeM5OYws3tPcW7tIdCbs9FXOV1iXWhLU5i0R4k4mJO7uFYdCUwp/rdY81Q+fZQh8D9
         HqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174887; x=1785779687;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3hTRi91CNq2ftIlTw2qCUxBc3lKuCHq2yzoU+61UwA=;
        b=Fzyqbc2vZ6GRvtmGT9DnYMTy28jFrzTfoticTL3sQw+e7hVMkF43W5lXmRgpetRHLm
         r7MlPBGCVkfz4WIKlabXkuQ2getg2S2lMVifAahkm9YsOwqZynS+8WKhkNBx9/NDLYWl
         elrKSpjS+OKFj6HAOfW6JBfff+deBAN1gP2Qciln8UkrQDsLRBoFp/xZ3AY+nxSDYavr
         d5jjKn4Z1jCszSj1fkUMYK9BCKFekqkbftR/ixLW1MOnYZmow7wEewz4uXPAXQbZdjOX
         Wk8eg1IXI+IrPktNJJovDQ+vdPvxvu+I7OdJnphSALAZkTs3GAk7oC+Cxs5OfoppWiPM
         sW/w==
X-Gm-Message-State: AOJu0YykG2bVheJZw9i1ur9ElW2x38XV5y05CqINmOQ3AcoJ00FCw7H6
	ijLhhEHZKjkWUvCeBpSgjcCtag0C0+DuFxUqskglM3Ti+TbQ+/iu99085bO0mkxxTyBVhAprWZO
	B0AlBX3gUksx9cxGXHhnO2gIPwHVIJizew5yPPNJFw+Tgvc19vDGszZ+IuA==
X-Gm-Gg: AR+sD12rr+zZzdEib5/lFkci+8dRXRP/HtaEimR92AypewcbK0rj5q3nomy78cfaQJQ
	j40RyGq6Xw7EE4wpIs9CaRgt0pi0d6jOq9jHZwRMfn6z+ML9ac7TnyomPAz+GIq813LPX8Uvtfv
	AK1wEbwbSwyH+p3K8tfjQcJEJNON4W0Y+QbDaN8w5+wNxTExGfE6FcmX6VFRgTF4lwOhgkt1lyG
	qdkx76vm7ERZPrx6EtMbsWvvu63lysJWC12KGnuteeFTjjFCL+o23TvIiCw3TbCOPN7H7+4qFXF
	CISGI88ua/EZaEthm8bjPLgTkuntw1LUr98KAjDByvjAT01Y1d0wKpOuZb/s4l6i0zRkQQTU
X-Received: by 2002:a0c:f202:0:b0:8fd:6dc5:94a with SMTP id 6a1803df08f44-907ec8d84a7mr125962486d6.63.1785174887335;
        Mon, 27 Jul 2026 10:54:47 -0700 (PDT)
X-Received: by 2002:a0c:f202:0:b0:8fd:6dc5:94a with SMTP id 6a1803df08f44-907ec8d84a7mr125962086d6.63.1785174886773;
        Mon, 27 Jul 2026 10:54:46 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e8694197sm70197646d6.24.2026.07.27.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:54:45 -0700 (PDT)
Message-ID: <4c953dda5ca7ab96fc419f99f1e0019768ea05a0.camel@redhat.com>
Subject: Re: [PATCH v4 2/3] drm/nouveau/gsp/r570: Set GcOff = 1 in fbsr
From: lyude@redhat.com
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>, Dave Airlie	
 <airlied@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Ben Skeggs
 <bskeggs@nvidia.com>, Kees Cook <kees@kernel.org>,  Simona Vetter
 <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  Maxime Ripard <mripard@kernel.org>, Mel Henning
 <mhenning@darkrefraction.com>, Danilo Krummrich	 <dakr@kernel.org>
Date: Mon, 27 Jul 2026 13:54:43 -0400
In-Reply-To: <20260727175246.642071-3-lyude@redhat.com>
References: <20260727175246.642071-1-lyude@redhat.com>
	 <20260727175246.642071-3-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

aaaaand I completely forgot to change this from a 1 to 0 in the patch
title ._.

Reviewers - I will make sure this gets fixed before pushing it upstream

On Mon, 2026-07-27 at 13:47 -0400, Lyude Paul wrote:
> Previously, it looked as if we were able to fix suspend/resume on
> some
> desktops by setting Gcoff based on whether or not we were entering
> runtime
> PM. This was a mistake though - the only time suspend/resume would
> end up
> actually working was if Gcoff =3D 0.
>=20
> It seems like it's likely the main reason for this is the FBSR GcOff
> argument actually controls GSP's behavior with regards to which
> buffers it
> decides to save across suspend/resume. When GcOff =3D 1, RM reserved
> regions
> are saved unless they are marked as LOST_ON_SUSPEND, and RM channel-
> context
> and kernel-client buffers are also saved -including- when they are
> LOST_ON_SUSPEND. This means with GcOff =3D 1, we end up having GSP save
> and
> restore buffers that actually need to be reinitialized on resume -
> causing
> the failures we're setting.
>=20
> In the long term, we do want to have GcOff =3D 1 as there are still a
> handful
> of edge cases around broken runtime PM that I've seen on laptops -
> and I
> have a strong guess that actually properly implementing the required
> bits
> for enabling GcOff will probably address a number of those issues.
> For now
> though, disabling GcOff results in runtime PM being dramatically more
> stable then it was before.
>=20
> Thanks to John Hubbard from Nvidia for providing some background on
> what
> these options do in the GSP firmware do!
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 2945d5b4e5707..af5aa5065c3dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct
> sg_table *sgt, u64 size)
> =C2=A0	ctrl->hClient =3D gsp->internal.client.object.handle;
> =C2=A0	ctrl->hSysMem =3D memlist.handle;
> =C2=A0	ctrl->sysmemAddrOfSuspendResumeData =3D gsp->sr.meta.addr;
> -	ctrl->bEnteringGcoffState =3D 1;
> +	ctrl->bEnteringGcoffState =3D 0;
> =C2=A0
> =C2=A0	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice,
> ctrl);
> =C2=A0	if (ret)

