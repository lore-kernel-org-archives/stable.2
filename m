Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7EE1F12FB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683104; cv=none; b=O4BpopcGCOf/eP1FH8sbbc3W0O9quu/3mBAxBDHEy3kd3QeHJqIwGaPw0lGcWbBdY6V+3/CMn7RyL6Iy+EnMC8iTFS3Ttt/wCWGjyFRhfWo7P6PJmBvQIN1t8fRwX9R0wo9GIJZT3L0S2lnLgG34X9FCjEMSVeayi3Fc1RHiPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683104; c=relaxed/simple;
	bh=RFFY9k7Gm1W4Nre5AsaOcL68AdxzG+ESLVmFUUBmgLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=azr/b4PLUCDg8F3LBmeTyrM8S9kHXPaOY3BseXdoXdpOXKIBe/ok7EzF+BcMfuIUF+m5ILBHhM7ZmbqnCkbiD5MEo2mj09r65R36NbmmS/Lq3tzDaIfVaQpcFXP2f8Typq7GFprrvlmQRO1SJyXzjrBtt7WH8pMGALR5dVv0HRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2ZP/RLf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tqqxnmNl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2ZP/RLf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tqqxnmNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789683101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O71094SnvEzOsUSd9r3JWt4fCSADbtCWy3jIsFoSJ/s=;
	b=W2ZP/RLfE9JAWkExQbTXNWJKURWlogNyJzoDVNQYwoHEB60uQFrgFnLDRTIX+Bf5HPSi8o
	UXBj9fvZPdyRnc8E1iRZpqqEHtrqYZ/coD2YvTe58VovCWdqexCn0MUzWJn6ky06GQqERW
	e90AUJRm+olpFoCQkzT8E9qmWfEI76I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-jnxw-9f2PhKljsT9rfNrlA-1; Thu, 17 Sep 2026 18:11:40 -0400
X-MC-Unique: jnxw-9f2PhKljsT9rfNrlA-1
X-Mimecast-MFC-AGG-ID: jnxw-9f2PhKljsT9rfNrlA_1789683099
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e8472ee1eso3865006d6.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789683099; x=1790287899; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O71094SnvEzOsUSd9r3JWt4fCSADbtCWy3jIsFoSJ/s=;
        b=tqqxnmNlBMSlizkQIfMCaOp82wk1YQ1qyP3daz6E03yJIRKq+LdGTjE64PpYV7+fK4
         kitvt8IhwAfvIutq2TlFpv8u/MXl3b85i5ANoFGiMRHJnHYNgzT6rw4Nvjty/USWm1kV
         yYDPlDsvLgEAjaOJPASeYoSXxwUrAGbszqBHB8QwyU0AmN5BlW2A8qYeUqk7LKpvvoS0
         TSQspeg3YezHpemAqUkn0OkBJmC5hL8dB4NjN71Oa40MgOzqNERJ07rvBJSTSYwS3y+Y
         S+mPNsKG+1iCK/TspCaeh7hCK2vWAMu0efJUlDvloJK+Gp1FMJ7iHiOc0qU2R1n5S1zg
         T9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683099; x=1790287899;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O71094SnvEzOsUSd9r3JWt4fCSADbtCWy3jIsFoSJ/s=;
        b=sikTS75LtMAunP+5I4l+KAICO8YfrwsGZ12tw6XiWwnV1wEXapWLIHiWCXEu5tvpOj
         u6X3q8gYLC8MYsL7eyKMxnjMSXHO0glno8xtO2cMFLPpgwJuvJlSGaiomIbT9MJY39Eo
         mqmmpN9xIpdsTWkmohkLvR3d+uww+Dhrbh3zkG1bBO1DWt6pq7aUKITDMoxW8tnH74A2
         GWoq93YRRFbIxB0pygLtEj7LT4FodDwAFJJVaxLvkiMgt0PLOrPLd52gLOyxTzr/LLPy
         jkigtZu01/jwf7rg/JsyWHt2PhuLDkT82NPhLsoPVsJkfRzJD6QRr5T1sN3rzmHopFEL
         ypUg==
X-Gm-Message-State: AFuF++kIYgEK9qJGL5zWIzR1bGtNnfbNkppBghpAIz0eNtEwwbL1PO4d
	F+4vyqIiTfhLMFX8JhFdmBxLn2IVrlhLQUQrz36K5u5re9k0hidYTfsFxKF3ro9N3fPavuBg3Fe
	PIKSyt7MuMFm8wn5Rh7SuSRZOqQVv6v+Do+Bee2sVLJCUvAov13hui4T97Q==
X-Gm-Gg: AYBFou06hQnGZIKeDJhZgv9TUo4OfQyodf7IJE/QvzpIbu14tIYSTn+R7LZX27P5JDS
	AnkokNdkD+J3t6dE/lwnVUQ1yiA81HJSo7ADhb7g+YVzZdGH7RBl2C5HCwxS32iLsHQn+1seucG
	3l7UBXgFeWu2lBjZ5Oju515jpEYPYE5joVuIXWKzzmTppl1wHMqvovzGGFcVtJw34+mr5I520FY
	tPb99eOzvGM4KIv2oiOZRR2DqRNKubP9iFkNcZ2iI1aDvCiEOvqq+ChAHb/bBNQliEyuyayxPGQ
	ntUa2A/RYZ/nlohCVJSxX2Y7coWU5XtjA1VKsM38992iBITdZsJbcZ5xydPl5duFDjDTnKPy
X-Received: by 2002:a05:6214:6110:b0:912:517b:913 with SMTP id 6a1803df08f44-91254cd0952mr9604866d6.50.1789683099406;
        Thu, 17 Sep 2026 15:11:39 -0700 (PDT)
X-Received: by 2002:a05:6214:6110:b0:912:517b:913 with SMTP id 6a1803df08f44-91254cd0952mr9604356d6.50.1789683098863;
        Thu, 17 Sep 2026 15:11:38 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-912568b9646sm142846d6.31.2026.09.17.15.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:11:37 -0700 (PDT)
Message-ID: <8ae8462fb2f74d0ab1a1d6ac663fa3a90d57ff5d.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: fix autosuspend cleanup during teardown
From: lyude@redhat.com
To: Guangshuo Li <lgs201920130244@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>,  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann	
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Thu, 17 Sep 2026 18:11:36 -0400
In-Reply-To: <20260808134137.2864847-1-lgs201920130244@gmail.com>
References: <20260808134137.2864847-1-lgs201920130244@gmail.com>
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

Will push to drm-misc-fixes in just a moment

On Sat, 2026-08-08 at 21:41 +0800, Guangshuo Li wrote:
> nouveau_drm_device_init() calls pm_runtime_use_autosuspend(), but
> nouveau_drm_device_fini() does not call the matching
> pm_runtime_dont_use_autosuspend().
>=20
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count
> remains
> unbalanced.
>=20
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
>=20
> Add the missing pm_runtime_dont_use_autosuspend() call to the common
> device teardown path.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 5addcf0a5f0f ("nouveau: add runtime PM support (v0.9)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index e16f59b00f6f..1579a4b0785e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -585,6 +585,7 @@ nouveau_drm_device_fini(struct nouveau_drm *drm)
> =C2=A0	if (nouveau_pmops_runtime()) {
> =C2=A0		pm_runtime_get_sync(dev->dev);
> =C2=A0		pm_runtime_forbid(dev->dev);
> +		pm_runtime_dont_use_autosuspend(dev->dev);
> =C2=A0	}
> =C2=A0
> =C2=A0	nouveau_led_fini(dev);

