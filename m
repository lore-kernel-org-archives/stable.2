Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B93BD64A
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495963; cv=none; b=HpL3UnuD0uPbuO2nc3UBUblJ/zLqyyvCvRVUgthkHKB3Q+RIl/6XlVdb9goYG8R+x5W9q581iO1c3e182pUFPfsBi8OtruTRCx2KwTOhinvLTqEYOivSScaAsyhRrr6wQsjtfldrsGzVGxkukm69VE5CTKzXqRoVEPS5lI4D6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495963; c=relaxed/simple;
	bh=4C6+wulytzT9gybkb7TNEm83oK7id/pFcB3QGIg+MP4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNCeuMTQQF4Kh9bvJQGAHdnUTPAeYgX6QrpgEOsHcljSCSnKPpjwfUYCV3y9GY7dnti5zX2xj/c45r4FAqUBfnRhB/igqmTptwGx3bCOB0vC6zo4XSZx48ySRIZLX6np/DGbuMurA2Fuze0t+yBsS7MHjyEjCndKuVhFGCTAMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgmdRK2K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbNP6oGt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgmdRK2K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbNP6oGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791495957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS+En9JyGsTr3AjbcaJ6blNY5U2s+JVwhjESLMBOqZQ=;
	b=LgmdRK2KBLAq+34lFa4e4maBARK9NWH++6WBAfQqreWCk6QNXSVS+gBglz1sBmOv84Hwc4
	ewYpcaVW8DDxe3Ivwq0MFaAqHWqzc3A4yJLQPZurjfkmV4BjfZJKFr7QcPFPqfiOjOk28p
	UPs5+IQxsQdnznt1gqb5UwKJqTSEdgo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ikdGqFpJOXi5GR5o_AA02Q-1; Thu, 8 Oct 2026 21:45:48 +0000
X-MC-Unique: ikdGqFpJOXi5GR5o_AA02Q-1
X-Mimecast-MFC-AGG-ID: ikdGqFpJOXi5GR5o_AA02Q_1791495946
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917a109c937so75712846d6.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791495946; x=1792100746; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JS+En9JyGsTr3AjbcaJ6blNY5U2s+JVwhjESLMBOqZQ=;
        b=gbNP6oGtcXTKFFg5VPTYSgOafoosD+HoNdYvRdM03lOGg7SdyM/diznkEAolsNxWXL
         4BO5N1NccfecYdUNRbAdagRq0lZgr5RBugdhaxLIRTQ+3aIuezBIramRcor8ScxVMqkM
         QA6csvn8T9qUFt7euelc3z301Ao67RNyFeaM6ni8ZYLrGJXCNpTDI09dFZPCy4X6iKY3
         gqRY/tZOElG2Y8UJXC73KLrkQDXFvmWQ8H0CY+3T5Jrqomr56tU+G2VNcQ+71BqXItX3
         taGyVdGxElDtwqNV6WpECulHBuSjx5uk0/MJVMsUO4R4M42Gko9qZLIC3Z5XQwLnktYD
         teQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791495946; x=1792100746;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JS+En9JyGsTr3AjbcaJ6blNY5U2s+JVwhjESLMBOqZQ=;
        b=bvQIU3I8NTKhMtK8mW9VlhzICIi2vLREgGH/wIi8Gsae9W/m45/l2ukOX6VZX2oDAu
         OyC1thsK50+9P3g5gvxWF9lio/ZhJLO6WzynPx6NVcMVQjR7FoQZSZzpJ+4AoOMb7i6J
         whH5Px5QcpWlEMcmpP1CxhIecc2HeqDscqNv+uvm2z/X0fRMmui9RzK4vX32+SYd2p5Y
         xaCsbGzit+6Voa4tlBOo4YQ82D0oGRicn+tYTz2iGjeiv7P+wbbZAB5PwKtHEGxXY90m
         1hwLtYS5Y+eOX0Qh2gT0r5JkNV4vWm/Sde/4cFa73gnfwEN0CURejBdH4rinx8n6dvbX
         uxzA==
X-Forwarded-Encrypted: i=1; AKwUvBxdhM86+GOsmP1k34W0X6H3HdRQds32SyfGIJCIbO2CndU5/y4Gxz+bl8V/MPoZu8zNm2jSP28=@vger.kernel.org
X-Gm-Message-State: AFq9FYIj8YV00Z4vqTYzMF1CMxJtOc0BDW9tCDO1chnaa7Kz/xDWNo5t
	VKBEVUqJOdaFewtgVnBCOIovmkImfmgoRAXaAWwl1D7fPmlaiKTMQnDOQ+UuzJJYXzqzM65vzNZ
	VOvWwXuhH5o5k4Jxpfsc8MdMcJhHhetKsDqthaYxfVy5qIdF8zCS4NaRlCA==
X-Gm-Gg: AYBFou0dVQrXBEO38qbvomVoCADL0GS50R+LvFBWq5QzanSQ0XVQrAEzD56dQemZ9uE
	Nu4xh95ij+vHrh1djUmGSv2P5OxuOPAAi241et38YTSwypzmj88j3Jm4pse1ulfZGaEmNO+BvVF
	0B/vg/Qbz6k0c4lXZBykkAhGmdYdc+hA2flufILCITZ4jNfkwgjlgmhM51xGpBj7PeLOaDdVJLS
	sIdd3FvF4cG608gxsVkWCJVPBVMly9Cvv9ZAsIcvevOA4tVptTiIJ/mHxj//n3smIW/FdmHIPxK
	p2DL8fM380Z2mCxWpSNRnsMtV9ehTscgJ3cVmp5Gz/sjOMeZXuVFV0yE7GIwR9WyTQfyFTE=
X-Received: by 2002:a05:6214:1d0d:b0:918:d743:fd92 with SMTP id 6a1803df08f44-91b555354f7mr894226d6.24.1791495946432;
        Thu, 08 Oct 2026 14:45:46 -0700 (PDT)
X-Received: by 2002:a05:6214:1d0d:b0:918:d743:fd92 with SMTP id 6a1803df08f44-91b555354f7mr893776d6.24.1791495945817;
        Thu, 08 Oct 2026 14:45:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550ca9a7sm949466d6.38.2026.10.08.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:45:45 -0700 (PDT)
Message-ID: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
From: lyude@redhat.com
To: liupeng <liupeng01@kylinos.cn>, dakr@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 linux@roeck-us.net, nouveau@karolherbst.de, 	bskeggs@redhat.com,
 dri-devel@lists.freedesktop.org, 	nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 	linux-hwmon@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 08 Oct 2026 17:45:44 -0400
In-Reply-To: <20260922044044.21442-1-liupeng01@kylinos.cn>
References: <ff3015a1c4b08088b0638b00670e86d612a27978.camel@redhat.com>
	 <20260922044044.21442-1-liupeng01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

One nit-pick below:

On Tue, 2026-09-22 at 12:40 +0800, liupeng wrote:
> In nouveau_debugfs_init(), if nvif_object_ctor() fails, the
> previously
> allocated drm->debugfs is leaked because the function returns the
> error code directly.
>=20
> In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
> the allocated hwmon structure is leaked because the function returns
> the error code directly.
>=20
> Fix both by freeing the allocated memory and clearing the pointer on
> the error paths.
>=20
> Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for
> debugfs")
> Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything except
> the hwmon interfaces to THERM")
> Cc: stable@vger.kernel.org
> Signed-off-by: liupeng <liupeng01@kylinos.cn>
> ---
> Changes in v2:
> - Add Fixes: tags for the commits that introduced the leaks
> - Add Cc: stable@vger.kernel.org=C2=A0for stable backporting
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_debugfs.c | 15 ++++++++++++---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index 47d5579c568d..88223931f382 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -295,13 +295,22 @@ nouveau_drm_debugfs_init(struct drm_minor
> *minor)
> =C2=A0int
> =C2=A0nouveau_debugfs_init(struct nouveau_drm *drm)
> =C2=A0{
> +	int ret;
> +
> =C2=A0	drm->debugfs =3D kzalloc_obj(*drm->debugfs);
> =C2=A0	if (!drm->debugfs)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	return nvif_object_ctor(&drm->client.device.object,
> "debugfsCtrl", 0,
> -				NVIF_CLASS_CONTROL, NULL, 0,
> -				&drm->debugfs->ctrl);
> +	ret =3D nvif_object_ctor(&drm->client.device.object,
> "debugfsCtrl", 0,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NVIF_CLASS_CONTROL, NULL, 0,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &drm->debugfs->ctrl);
> +	if (ret) {
> +		kfree(drm->debugfs);
> +		drm->debugfs =3D NULL;
> +		return ret;

^ We could get rid of this extra return=E2=80=A6

> +	}
> +
> +	return 0;

=E2=80=A6and just return ret here

With that fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>
> =C2=A0}
> =C2=A0
> =C2=A0void
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> index 726397ab035d..ffbe7f542ab0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -697,6 +697,8 @@ nouveau_hwmon_init(struct drm_device *dev)
> =C2=A0	if (IS_ERR(hwmon_dev)) {
> =C2=A0		ret =3D PTR_ERR(hwmon_dev);
> =C2=A0		NV_ERROR(drm, "Unable to register hwmon device:
> %d\n", ret);
> +		drm->hwmon =3D NULL;
> +		kfree(hwmon);
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0

