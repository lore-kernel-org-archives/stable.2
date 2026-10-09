Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE136CDF2;
	Fri,  9 Oct 2026 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582058; cv=none; b=o2FTh7VtUhmYuw8M8qiO7FwUHT2yZqGQ16KIq85j85EDnVNnqDwF4kZuB2ddhFV23TTPpWawJHCu33HVvxycoC/Xs9Hap9Pl5+qyAY4RHthAPGpPIC9JYnj7GeSANkw2W+ri9fcvBkdpdulirxqC2Goi0GmkxhCW65rmMR32Abs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582058; c=relaxed/simple;
	bh=AcSglezOrPHR5TzikiR9V903ADKuaFdALR/qMmfPw1M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Vxb7z6T5OkrKM1aCecVX/kR6a+Gwg1nWN/3Jddq+m6SpOpOxAQHOOUVOUzgs7lNYpluLM2bcUpbYMm2sPMkwKsHM6aPM+I1XYI1JAqAkiTkp3Ee2rpp5uDLND+oGl/tzQDMV+dmAe1cZt3zJvNNntn5BBg5lkbfQtLiofytNmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAAGYAMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAAGYAMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E852D1F000FF;
	Fri,  9 Oct 2026 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791582056;
	bh=975XJHp6HfBeBQvf/fCx8fkoMxk7dSZ3qT++BuIIxYM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=aAAGYAMlyxywBeS4ImXPe8+f9iH4wYg1AObXeEJ4wQNbZCpMy96xDOocYMcLC8Osk
	 q0uGVyNUXeYmehHWbGlNeUAeITnbPoQqcWJ8L0lOCxyqwcIRnGjPsMsPWUqvYkzPC9
	 Fo6Vu2yIxrTVWDiyA/MK+2ApHCuh62bA7/uDPR8MLjAAUhmp5QvEl1Wfq563A/JRYY
	 9bF0EPi0Cix1YPRE+qE7OGWWbMtLlYdYH/EFftTwyzYtvxSd3r2QGui92djkEcPM9U
	 J1BZ/cuvvXaxJFqUYuM7jJGrkXywIEXZw9s2dOvhTK+VvhztGA8mkE3RgrxYBj4ShP
	 Ao0SeaGll0sNw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 23:40:52 +0200
Message-Id: <DM0MU0O43EB9.3EEKZ4C2IUP9J@kernel.org>
Subject: Re: [PATCH v3] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
Cc: "liupeng" <liupeng01@kylinos.cn>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <linux@roeck-us.net>, <nouveau@karolherbst.de>,
 <bskeggs@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-hwmon@vger.kernel.org>, <stable@vger.kernel.org>
To: <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
 <20261009115151.13877-1-liupeng01@kylinos.cn>
 <25778dca265f58185917c5948490e76184c778d3.camel@redhat.com>
In-Reply-To: <25778dca265f58185917c5948490e76184c778d3.camel@redhat.com>

On Fri Oct 9, 2026 at 11:35 PM CEST, lyude wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> Will push to drm-misc-fixes in a moment

Please wait, those are two unrelated fixes with two different Fixes: tags, =
so
those should be two separate patches.

I'm also not sure this is -fixes material. A memory leak in an unwind path =
for
-rc7 feels wrong.

Thanks,
Danilo

> On Fri, 2026-10-09 at 19:51 +0800, liupeng wrote:
>> In nouveau_debugfs_init(), if nvif_object_ctor() fails, the
>> previously
>> allocated drm->debugfs is leaked because the function returns the
>> error code directly.
>>=20
>> In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
>> the allocated hwmon structure is leaked because the function returns
>> the error code directly.
>>=20
>> Fix both by freeing the allocated memory and clearing the pointer on
>> the error paths.
>>=20
>> Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for
>> debugfs")
>> Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything except
>> the hwmon interfaces to THERM")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: liupeng <liupeng01@kylinos.cn>
>> ---
>> Changes in v3:
>> - Drop the extra return in nouveau_debugfs_init() as suggested by
>> Lyude.
>> - Add Reviewed-by tag.
>>=20
>> =C2=A0drivers/gpu/drm/nouveau/nouveau_debugfs.c | 14 +++++++++++---
>> =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A02 files changed, 13 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
>> b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
>> index 47d5579c568d..338421e52f69 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
>> @@ -295,13 +295,21 @@ nouveau_drm_debugfs_init(struct drm_minor
>> *minor)
>> =C2=A0int
>> =C2=A0nouveau_debugfs_init(struct nouveau_drm *drm)
>> =C2=A0{
>> +	int ret;
>> +
>> =C2=A0	drm->debugfs =3D kzalloc_obj(*drm->debugfs);
>> =C2=A0	if (!drm->debugfs)
>> =C2=A0		return -ENOMEM;
>> =C2=A0
>> -	return nvif_object_ctor(&drm->client.device.object,
>> "debugfsCtrl", 0,
>> -				NVIF_CLASS_CONTROL, NULL, 0,
>> -				&drm->debugfs->ctrl);
>> +	ret =3D nvif_object_ctor(&drm->client.device.object,
>> "debugfsCtrl", 0,
>> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NVIF_CLASS_CONTROL, NULL, 0,
>> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &drm->debugfs->ctrl);
>> +	if (ret) {
>> +		kfree(drm->debugfs);
>> +		drm->debugfs =3D NULL;
>> +	}
>> +
>> +	return ret;
>> =C2=A0}
>> =C2=A0
>> =C2=A0void
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
>> b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
>> index 726397ab035d..ffbe7f542ab0 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
>> @@ -697,6 +697,8 @@ nouveau_hwmon_init(struct drm_device *dev)
>> =C2=A0	if (IS_ERR(hwmon_dev)) {
>> =C2=A0		ret =3D PTR_ERR(hwmon_dev);
>> =C2=A0		NV_ERROR(drm, "Unable to register hwmon device:
>> %d\n", ret);
>> +		drm->hwmon =3D NULL;
>> +		kfree(hwmon);
>> =C2=A0		return ret;
>> =C2=A0	}
>> =C2=A0

