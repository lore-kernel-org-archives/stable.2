Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4D36CDF2
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582240; cv=none; b=jr5HgJD7iQmLnzEg84qCPpGUZgFXxc2DhKBqHrQxQPcUdIio5OPtJw5uSErNMG0CT+bisEpHdTQOF1Wb4wJfxT0FTXLEtC7N54p6BmfYMSkSUL7NfDQQk7UtAy0bxGvYA5IbIfhYiH1joWKssR8J8n180NhMJFU7Cad20rW2Ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582240; c=relaxed/simple;
	bh=Zu0HMojq54+g3/8p46ih3C6jdzsLJb9uoo77H+0fS98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oU/Wnht/OPpid1tKDwbOQknhiopPxxgIGfdIl/x41fv7vdjVYjzaYPewB8AjoTZ9CLbEBz/DL83IF6AsAzVvF3NbKV3GRVjZtFRl6J1As8gnk9kdzPAUoaH+BDUJPUBFK8Yy6XurOr0rkMydnIfRScivbT21rdvy6n0QZgL8J40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7wlvkiD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL485xi2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7wlvkiD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL485xi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791582237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlNSozwHWelaDwiAeqzmQRLEfEKU54b/1DRu7LW/zDY=;
	b=W7wlvkiDmveYUmbXMjvh5HeIVkn4KIuyWCLLc+fRXop6xmKNGvY9XAue/1CxuhPTZriUop
	TfYfHt4yB3ggnm4LS7ul5wo21bflPBvvYV6ts+YfbVkEu87q0zvkCdLlIx+OuuwMUa6QEJ
	9DNfTSimt97ga2aTQI+a0UGfS7g4CTM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-xOxzvFYEPPS072PRWtiHnA-1; Fri, 9 Oct 2026 21:43:56 +0000
X-MC-Unique: xOxzvFYEPPS072PRWtiHnA-1
X-Mimecast-MFC-AGG-ID: xOxzvFYEPPS072PRWtiHnA_1791582236
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53514fbd4a3so3377251cf.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791582235; x=1792187035; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DlNSozwHWelaDwiAeqzmQRLEfEKU54b/1DRu7LW/zDY=;
        b=FL485xi2Qn19Ei5tZXhGEBLitif/n1A1c9gzkKOKsfmRj9gzeLl9ptTeOrh7iSzEnX
         VnpIJLZ6hz4W4/u7hSPlSUiYCntq9O3DGRxS0uw4uhShuiaQIgoO43VyL4RZeDm9Yget
         2ViiN1BWIKgekR99aNLPYioonuk1YmE9TITyYvFr382oQwAnqo1MsnCCdjh4RZGTWyic
         ioyP/bxyIqqUMP8cl1hK8cTfAYtMPedAUiG01Ue71AU7gjwftK4gv4+xDc7C38FL0bu7
         /yA33JGTG9LBLbeor7gzuys0js4Srs3Az2F717nurn4WKpQbm8H/IennS38XdDH4L8Rc
         mmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791582235; x=1792187035;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlNSozwHWelaDwiAeqzmQRLEfEKU54b/1DRu7LW/zDY=;
        b=1fB1ut4NBQROtAjS9SzIlXf/GYaeqpMZHRMuZKCJyXNN0zrEK6Un13oI71LuzUj/gs
         ymMWZdSNFovfqhVEhThs1F6eWhR3zrolAKe3ey4Xd0evnx+zhLTcVRGoSZLelE7dGzA4
         6/c3lBlrG/AzIEnOQQjk5BjqwCl5H/puMJKib06dUAwKBY7MLfDp6URmEbiJWp8uA3t4
         Cpl6ol70a9YTIqVZzNrtRBh/F24UePhI2YDqtWUmba5mLPHwSyjL3cx1eoK0ReIS4uhX
         UeIAcBy6VpQc5Jc/B4UP8HoULxzyuxcXZKczeJaYokH+MUKF1ScUt5tc0kQskT9LuJh1
         YRbg==
X-Forwarded-Encrypted: i=1; AKwUvBwOiE09qE3KOkSAoexbjJ+O4k3jxqCwL+AJsCDy7oBR2ijXQCJsUOrH/A85L0l1MkBoWMVBY0s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhBdUpZXvi7xVOZLUg13UOUA79nd6jYruqJztb7oYjy107ne9S
	4NkolMvGRJaFGFQO9518dZCA093wxPo8f+JJK6SO8I5xB1GanWhWAW7YdrZfQIj4cTViZ2eyV2l
	oi+/K5eU3qf16ATSop3UkkwtjcPwTtbXqVgdlRWKxsj3rBNi2FeEFA3JMwA==
X-Gm-Gg: AYBFou3Ivcly41YPYvaFljq3PxZZMcy7lTernxWj++dSTJwBeNp0JrY23vkuOHaUhbG
	5EOpRM0Unr4FOjA67Xj8kYBcaI5MrHbcYOMJ5Q2bfc+HAnKtn66IAMMbZYF6PPHOe7SofMgX/bw
	suyiHoPN9cwJNrGBvffijcQYI5zpfhghgDoFG2jeq/7G04nwpQfgW+HlM8LGEoUc4bDsjpXx2bT
	ePfWAf/5YNCiv7q8M4EOYsX+7OVpStC3IZehv4/IOWWTsmUVetnzUw6B32vBuPgIIRUbQo7soOQ
	pwVb9U9GLIDNYU88w+qK2CiSB0IKgb3qm/kwhAfkHmX/Ds6ob8g2YB7hhj2J0X8MydPYaeA=
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fb with SMTP id d75a77b69052e-535a5fb8494mr34446321cf.71.1791582235441;
        Fri, 09 Oct 2026 14:43:55 -0700 (PDT)
X-Received: by 2002:a05:622a:58c4:b0:535:a5fb:67fb with SMTP id d75a77b69052e-535a5fb8494mr34446061cf.71.1791582234996;
        Fri, 09 Oct 2026 14:43:54 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55092856sm28672986d6.35.2026.10.09.14.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:43:54 -0700 (PDT)
Message-ID: <b4cd38b48d85298a7a99cf30fbd8cbbdb34a347f.camel@redhat.com>
Subject: Re: [PATCH v3] drm/nouveau: Fix memory leaks in debugfs and hwmon
 init error paths
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>
Cc: liupeng <liupeng01@kylinos.cn>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	linux@roeck-us.net, nouveau@karolherbst.de,
 bskeggs@redhat.com, 	dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 09 Oct 2026 17:43:53 -0400
In-Reply-To: <DM0MU0O43EB9.3EEKZ4C2IUP9J@kernel.org>
References: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
	 <20261009115151.13877-1-liupeng01@kylinos.cn>
	 <25778dca265f58185917c5948490e76184c778d3.camel@redhat.com>
	 <DM0MU0O43EB9.3EEKZ4C2IUP9J@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 23:40 +0200, Danilo Krummrich wrote:
> On Fri Oct 9, 2026 at 11:35 PM CEST, lyude wrote:
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >=20
> > Will push to drm-misc-fixes in a moment
>=20
> Please wait, those are two unrelated fixes with two different Fixes:
> tags, so
> those should be two separate patches.

Thanks, I think my brain just glossed over the tags while looking at
this.

liupeng, could you split these patches up?

>=20
> I'm also not sure this is -fixes material. A memory leak in an unwind
> path for
> -rc7 feels wrong.
>=20
> Thanks,
> Danilo
>=20
> > On Fri, 2026-10-09 at 19:51 +0800, liupeng wrote:
> > > In nouveau_debugfs_init(), if nvif_object_ctor() fails, the
> > > previously
> > > allocated drm->debugfs is leaked because the function returns the
> > > error code directly.
> > >=20
> > > In nouveau_hwmon_init(), if hwmon_device_register_with_info()
> > > fails,
> > > the allocated hwmon structure is leaked because the function
> > > returns
> > > the error code directly.
> > >=20
> > > Fix both by freeing the allocated memory and clearing the pointer
> > > on
> > > the error paths.
> > >=20
> > > Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object
> > > for
> > > debugfs")
> > > Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything
> > > except
> > > the hwmon interfaces to THERM")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > Signed-off-by: liupeng <liupeng01@kylinos.cn>
> > > ---
> > > Changes in v3:
> > > - Drop the extra return in nouveau_debugfs_init() as suggested by
> > > Lyude.
> > > - Add Reviewed-by tag.
> > >=20
> > > =C2=A0drivers/gpu/drm/nouveau/nouveau_debugfs.c | 14 +++++++++++---
> > > =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0 |=C2=A0 2 +=
+
> > > =C2=A02 files changed, 13 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > index 47d5579c568d..338421e52f69 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> > > @@ -295,13 +295,21 @@ nouveau_drm_debugfs_init(struct drm_minor
> > > *minor)
> > > =C2=A0int
> > > =C2=A0nouveau_debugfs_init(struct nouveau_drm *drm)
> > > =C2=A0{
> > > +	int ret;
> > > +
> > > =C2=A0	drm->debugfs =3D kzalloc_obj(*drm->debugfs);
> > > =C2=A0	if (!drm->debugfs)
> > > =C2=A0		return -ENOMEM;
> > > =C2=A0
> > > -	return nvif_object_ctor(&drm->client.device.object,
> > > "debugfsCtrl", 0,
> > > -				NVIF_CLASS_CONTROL, NULL, 0,
> > > -				&drm->debugfs->ctrl);
> > > +	ret =3D nvif_object_ctor(&drm->client.device.object,
> > > "debugfsCtrl", 0,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NVIF_CLASS_CONTROL, NULL, 0,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &drm->debugfs->ctrl);
> > > +	if (ret) {
> > > +		kfree(drm->debugfs);
> > > +		drm->debugfs =3D NULL;
> > > +	}
> > > +
> > > +	return ret;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0void
> > > diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > index 726397ab035d..ffbe7f542ab0 100644
> > > --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> > > @@ -697,6 +697,8 @@ nouveau_hwmon_init(struct drm_device *dev)
> > > =C2=A0	if (IS_ERR(hwmon_dev)) {
> > > =C2=A0		ret =3D PTR_ERR(hwmon_dev);
> > > =C2=A0		NV_ERROR(drm, "Unable to register hwmon device:
> > > %d\n", ret);
> > > +		drm->hwmon =3D NULL;
> > > +		kfree(hwmon);
> > > =C2=A0		return ret;
> > > =C2=A0	}
> > > =C2=A0

