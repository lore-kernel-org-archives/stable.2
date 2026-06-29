Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C73C9EF6
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769043; cv=none; b=ltwgqeM7YlLVKr8KWEIgtxCYn3x8Ycv0W8Xn7JmZC2rocdt0L2wxv8PZlqE9xHBSchsGu8WNYy+e1q6iJieNKMD/9wgIoZ9MalQutUm6G2hBwtCgFwZijNoMNLrYaPKNHXLiaMqDByXb1u1kPC5zUFdAA9h9ASvGhSj3nvtPN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769043; c=relaxed/simple;
	bh=AZQ+cjOZHCfOyxMgYdne5WnISx9eGyDfgFzs+70859A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBu+CKWx47HsYHAqSueixN+93T+6jG0Cizo4qwffQnSqBolXaSzgCqHR/t8EVu48jMmk2GXQb2lIyF5ezhk5pChjAMpelhSwgthtq3NggyDD6aqMdaHjdUpILO5359C+S1YCit8sMh3h7SgBYh7Pr+6hqA/wLn7wGKkCPH2L6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Azeuf5ot; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8nxc/KG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azeuf5ot";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8nxc/KG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782769041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4h5QDGQfeC12aIw9GPepcb1Zj6xE1bUvcgth2ziWe1A=;
	b=Azeuf5otafjuZ75H82kAasb7+RR4SH03O7Eqweb/fEEn03clBvrJIXl7YSX+LMy0dWxGKD
	n3rhXDVMKIE0EjI6nAOA1QJRd7j4s59Hr4dNgzvf4vhFaOMm/yFedQF6SlL0wPiJTYihrO
	3M+vVzDwnxDV3msPMfv0P+RL7/KpOuM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-bVBCw5pbMUKRLhLyN2yccg-1; Mon, 29 Jun 2026 17:37:19 -0400
X-MC-Unique: bVBCw5pbMUKRLhLyN2yccg-1
X-Mimecast-MFC-AGG-ID: bVBCw5pbMUKRLhLyN2yccg_1782769039
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so19874561cf.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782769039; x=1783373839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4h5QDGQfeC12aIw9GPepcb1Zj6xE1bUvcgth2ziWe1A=;
        b=e8nxc/KGJg91ceP1zXUJVzcaNR06dP3R/mXSCRvW7YCCFHkQVSrXC7diZXKPlKUFOa
         6zTV7PHAb22njPwyBwl29K3/L2DgQVjAlUaAbe59nPjgC7wk21Ihy0PLJYslXhqxLI36
         FFi3duNb8uoU7iNHI+qiYh78Aa4uSAkydDVVOvnp8YtXDSGHKckGwhLpLIj8j74IBLlJ
         6NbOMpO/XlMsCpMhuhu99iWrMgkab1oHdzjdn1j3FM9msK8j6f3w2eSQt/57HdHb6MBS
         cjAuztpz2JnA+BG8Gdiz72yzKEd2ItCKyl4LwaMoke9zC14O7QVUnitWuKtzqGH1j1+G
         ZGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782769039; x=1783373839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h5QDGQfeC12aIw9GPepcb1Zj6xE1bUvcgth2ziWe1A=;
        b=fyG+rJfAnKGeBIrmywmFCzm8LqJdrtYUgm4NS2m9/8mbGm5IWOrnenmVLxH6ebXDS2
         byKEaClZ3NLB4vj6CRLOO13SRLe15jTJ3/7aZc9ZekflDlmq7c2QJEOZFdCYyZerv5vz
         gXBe6Fw1/D+Vy3AcOrabRo+CTM9iAfBbSnWeuKHjpNpJDrUiGuP6Jlw5Fqgr/TTyWYlV
         sBlKfxuufAe5ltHPyidpyWMEQYiKdR+HNoVthE2BJvcgRlZOJN69UIww7l5YcyG4sHC8
         Dlf0DlyDJxLDIBtNiErnadX4lHZ8zfTxed5hnN6YQRhyU7e7M0ABBmiic1aK8IjbVaCD
         DF+A==
X-Forwarded-Encrypted: i=1; AFNElJ92hqB2Uo93AsL+CRkBQb3wRPafO8OOvJiIRBXZ3N9tpTknr9JjuyT3FKzCx8VThv6dKtnaMyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx9ePKzKZR42f44WpVCFIO8ujVHOiETCN46sZPhgBfUrv6IyFp
	Tdpgma8P3CzRGqrAfcP1/WTxwltHJm1rTer/XfXI5b6987VQmzmjBG360QN/4+8/cuFwjdrhSDr
	SvE1430ivl5sTCmdOcgNjFeA7IkeScjv91LDRsF40lk9i+N73/6F30qbDTg==
X-Gm-Gg: AfdE7cniym9TZvtLWYcv+Pv+J44Fvlbbb6EFCjOV4JZliTRUG7zrlvjjwJSVwAPE5kW
	tqrUKESo06Qz+1Tmky/ePQ28u8gOpcjksZZDXljnRhjKx06zmPJbkNvLmJd/UUFClQ2aPkAQRV3
	thFXkTOOMq0UpfEo5jtDzpJ30NvJxY4jwRL0WIOVDEaiarVIkOF4WLojXAdoBYEkYKGC2pMJ888
	HAX+tZmwCO4WLQsDzUw+myt/1z2S+onljZJkpgiC7AO6eCZNnGMhfeUXR1AqcrmU3QfJhajWi3E
	cfdsOHOj36e+MgTQWPAZNvj3W20ORtrKg3mazg4E89ZE6yj6qPgp6OZ4Cb4EQigSuvOoRX5+6JJ
	bFw3p5FE=
X-Received: by 2002:ac8:5811:0:b0:51c:1d9:e95c with SMTP id d75a77b69052e-51c10716e14mr16826041cf.5.1782769038988;
        Mon, 29 Jun 2026 14:37:18 -0700 (PDT)
X-Received: by 2002:ac8:5811:0:b0:51c:1d9:e95c with SMTP id d75a77b69052e-51c10716e14mr16825551cf.5.1782769038320;
        Mon, 29 Jun 2026 14:37:18 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c25absm7952766d6.27.2026.06.29.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:37:17 -0700 (PDT)
Message-ID: <88003b81e8dc83f675ab94280409a1202a0c2959.camel@redhat.com>
Subject: Re: [PATCH v5 16/19] drm: fix race between partial
 drm_dev_register() failure and ioctl
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, ecourtney@nvidia.com, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, 	lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, 	deborah.brouwer@collabora.com,
 boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Date: Mon, 29 Jun 2026 17:37:17 -0400
In-Reply-To: <20260628145406.2107056-17-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
	 <20260628145406.2107056-17-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2026-06-28 at 16:53 +0200, Danilo Krummrich wrote:
> If drm_dev_register() fails after registering a minor (e.g. render
> minor
> registered, primary minor fails), userspace could have opened the
> first
> minor and entered a drm_dev_enter() critical section. Since the
> unplugged flag was never set, the ioctl proceeds while the error path
> tears down device resources.
>=20
> Fix this by introducing drm_dev_synchronize_unplug(), which sets the
> unplugged flag and waits for the SRCU barrier, ensuring all in-flight
> drm_dev_enter() critical sections complete before cleanup proceeds;
> call
> it on the error path of drm_dev_register().
>=20
> Fixes: bee330f3d672 ("drm: Use srcu to protect drm_device.unplugged")
> Cc: stable@vger.kernel.org
> Reported-by: sashiko-bot@kernel.org
> Closes:
> https://lore.kernel.org/all/20260620190648.2E9F61F000E9@smtp.kernel.org/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/drm_drv.c | 34 +++++++++++++++++++++++++---------
> =C2=A01 file changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 675675480da4..e890052061f3 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -473,6 +473,22 @@ void drm_dev_exit(int idx)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_dev_exit);
> =C2=A0
> +/*
> + * Mark the device as unplugged and wait for any in-flight
> drm_dev_enter()
> + * critical sections to complete.
> + */
> +static void drm_dev_synchronize_unplug(struct drm_device *dev)
> +{
> +	/*
> +	 * After synchronizing any critical read section is
> guaranteed to see
> +	 * the new value of ->unplugged, and any critical section
> which might
> +	 * still have seen the old value of ->unplugged is
> guaranteed to have
> +	 * finished.
> +	 */
> +	dev->unplugged =3D true;
> +	synchronize_srcu(&drm_unplug_srcu);
> +}
> +
> =C2=A0/**
> =C2=A0 * drm_dev_unplug - unplug a DRM device
> =C2=A0 * @dev: DRM device
> @@ -485,15 +501,7 @@ EXPORT_SYMBOL(drm_dev_exit);
> =C2=A0 */
> =C2=A0void drm_dev_unplug(struct drm_device *dev)
> =C2=A0{
> -	/*
> -	 * After synchronizing any critical read section is
> guaranteed to see
> -	 * the new value of ->unplugged, and any critical section
> which might
> -	 * still have seen the old value of ->unplugged is
> guaranteed to have
> -	 * finished.
> -	 */
> -	dev->unplugged =3D true;
> -	synchronize_srcu(&drm_unplug_srcu);
> -
> +	drm_dev_synchronize_unplug(dev);
> =C2=A0	drm_dev_unregister(dev);
> =C2=A0
> =C2=A0	/* Clear all CPU mappings pointing to this device */
> @@ -1091,6 +1099,7 @@ int drm_dev_register(struct drm_device *dev,
> unsigned long flags)
> =C2=A0		goto err_minors;
> =C2=A0
> =C2=A0	dev->registered =3D true;
> +	dev->unplugged =3D false;
> =C2=A0
> =C2=A0	if (driver->load) {
> =C2=A0		ret =3D driver->load(dev, flags);
> @@ -1118,6 +1127,13 @@ int drm_dev_register(struct drm_device *dev,
> unsigned long flags)
> =C2=A0	if (dev->driver->unload)
> =C2=A0		dev->driver->unload(dev);
> =C2=A0err_minors:
> +	/*
> +	 * If a minor was registered before the failure, userspace
> could have
> +	 * opened it and entered a drm_dev_enter() critical section.
> Ensure all
> +	 * such sections complete before we clean up.
> +	 */
> +	drm_dev_synchronize_unplug(dev);
> +
> =C2=A0	remove_compat_control_link(dev);
> =C2=A0	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> =C2=A0	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);

