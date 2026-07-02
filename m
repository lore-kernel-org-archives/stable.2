Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97023183C;
	Thu,  2 Jul 2026 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952041; cv=none; b=f0+B8upZOrILA8jiG7EfqORvHPlONq867kj0fcHvCzQVKtb/QEOZjD0Hph5yCtUBhRUGfchZ2/bkOHLDRoJqAIRq+sDPvlFdDr2/NVRRWnOeNO0pU+bkVZkQxczzzcSr8G9m+6VWlgXiXZ/9LeTEDQFRCe0DeCkNIprDlt7r0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952041; c=relaxed/simple;
	bh=yIqeaO7FOaMegY9vPOrXwEfjriyQGtjC4/N0gGQEWwE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Iat2rTL+Ks6wEvJyeK1GLJXEEz+ph9wLQu/5b/HxOPmWOGzuOOvJjnas6XmUDG+WsLeUMQptmPaX1FFHLm77tCGEY62H2AnZJXhcEQY8n1b2PXA3/kZ5D9zKTNqnON05BQbty0omtE+3C9rB3Bx9Fft+Zz9Td77hK/uFUb61MIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ2/sMWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ2/sMWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393331F000E9;
	Thu,  2 Jul 2026 00:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952040;
	bh=3sTyqrkR4eDbnmC3hLWq/ZUAIvO8O4HY1eb/XkK/jVc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=eZ2/sMWO8m1SQUkDzovbRcZVQ3wAiBuqe+1CGTuaCOk5VmyvLxyTzJYhSiswFlbCg
	 hyPCBsNnAsrIc/hU0yjwiJI6mvVPuUeJV49oiGB0d7be9mryFdBo+ZBxzeXznmsTft
	 qrVDFHITjbJlptdpu5J4qGhTfzUxMV06cmLF1es3N13d70NwHr4mpDCyEyjplRB8mF
	 I9U0AKpPaMo5jdWu5OUU83Z/4Nxc+6i7ACf3yPEWwQ3ilUrHNfOhwlf7P/4JfLoOqD
	 zgjKF5PG2CHtpJY2lv0UCuUIjBg9XRS6zSxcYSOQuAi2mJDvdoIdmfZtrSC88U5Bpv
	 ZlqSYu1f4SYuA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 02:27:11 +0200
Message-Id: <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Timur Tabi"
 <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Kees Cook" <kees@kernel.org>, "Simona
 Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Maxime Ripard" <mripard@kernel.org>,
 "Mel Henning" <mhenning@darkrefraction.com>, "John Hubbard"
 <jhubbard@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-3-lyude@redhat.com>
In-Reply-To: <20260701182857.190713-3-lyude@redhat.com>

(Cc: John)

On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
> It turns out that the only reason our previous fixes looked like they
> worked for this was because we would occasionally set the Gcoff state to =
0
> in the normal S3 path, which fixed suspend/resume on desktops - but not o=
n
> machines using runtime suspend.
>
> The proper fix is to just never set this flag. Our current guess for the
> reasoning behind this is that Gcoff likely coincides with GC6, and not
> literally power off.

I don't think GcOff coincides with GC6, it should actually be a power off.

From a quick glance in OpenRM, it seems that with bEnteringGcoffState =3D 1=
 it
also saves off buffers flagged as MEMDESC_FLAGS_LOST_ON_SUSPEND.

My guess would be that with bEnteringGcoffState =3D 1, GSP's resume path ex=
pects
certain kernel-driver-allocated buffers to still be in place that nouveau d=
idn't
save off, or rather never had in the first place.

John, do you have some details about this?

> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 2945d5b4e5707..af5aa5065c3dd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> @@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *s=
gt, u64 size)
>  	ctrl->hClient =3D gsp->internal.client.object.handle;
>  	ctrl->hSysMem =3D memlist.handle;
>  	ctrl->sysmemAddrOfSuspendResumeData =3D gsp->sr.meta.addr;
> -	ctrl->bEnteringGcoffState =3D 1;
> +	ctrl->bEnteringGcoffState =3D 0;
> =20
>  	ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  	if (ret)
> --=20
> 2.54.0

