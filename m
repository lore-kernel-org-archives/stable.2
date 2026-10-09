Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61A3E1701
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588242; cv=none; b=bbZHLGcBxLcbbBxxKZyK4wt/EyS7Lymra/4R+ggodAcx19sn6npMitnDzusl4Z10abqvXXCmRIhmFCW0BsNnFNrOiiFb3Gf80WTrKUXMiAq6r8zHk1iz6ibvrbx5XCszvV7lYZGu4L+GuR455TI+ctEp/99+k2fR8OF8p4LeoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588242; c=relaxed/simple;
	bh=sfOZXNVw/q9uYORsZL0FlPc4JiF7q/+Bna+hgg5zIok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIsBEn42TMLvJeiI45jMXUmEdvxbsZomRD29RcHb2J71f90Hw5WsVf2QXy2p0CW5Axy0GoBhOYJUUY5eC3SbaAB/Rw3k2LQjzRqYmQd4i2+sD3J/hCOxV7Zz/bwmW1NQeC385HI8nIXhttRpEMZEPtLBqc90sfawlwGbv6ijqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvuYQyaA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZtw4Wun; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvuYQyaA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZtw4Wun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791588239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itTUK0qBJAobOiyoWxRrJ2RE7+6HMxd85fVudqmm2Kg=;
	b=XvuYQyaAVpZDjXvWhg+4FPRl+v0TNisyvwFSSwacbDtop04yQtpqPn5htsTfzwxgXkMo0P
	FIEAIq9a1OJ6gXHl7g5VsC1XxTDlfv0agTnbiUa60ls07dnq/mH2WCFaAQSLaWxD7Jzwuw
	TFQzMJy7HCioU/ue3u0e0/01xIkqBN4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-uWqC44gBPxW9MP_BnhvWkQ-1; Fri, 9 Oct 2026 23:23:56 +0000
X-MC-Unique: uWqC44gBPxW9MP_BnhvWkQ-1
X-Mimecast-MFC-AGG-ID: uWqC44gBPxW9MP_BnhvWkQ_1791588236
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c26012cd0so4828821cf.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791588236; x=1792193036; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=itTUK0qBJAobOiyoWxRrJ2RE7+6HMxd85fVudqmm2Kg=;
        b=RZtw4Wunr7AhakbrT1kXs8S7VlsAJOMXttLDYFYHMlmS7VDQXvlfRz/KTBG0e8AcaL
         Erg/jdr6H9I6VzkcCmblHc39D/HiH4FD6+QPiCv5Pj/c8RqBagQNnu2/2CFwiIQiawba
         cdRK9AxIeDisFnnvWtj7dSYeJjdjXMeeiIudFwo+G3SanZ/0X3WNIdlYwVvArtg6jc7I
         BT5oYmzGdvIBArVnhYV+qYrOvH2WAG2Rw7cJB5CBw5XZ5U+kzO0WY5in4RuJs+0xL8dm
         3KY/VFCPlLWkcu17n0HCHy9CnbjOgtQtNdXlybXVo9UR5Vb0sFueLyylf7s4lQ4mkhVO
         7xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588236; x=1792193036;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=itTUK0qBJAobOiyoWxRrJ2RE7+6HMxd85fVudqmm2Kg=;
        b=RaEsmuo5CRQ/7WyTjE0hKs8stbpJNdgTFtQE4+J+/i2MQHBX4I+Lr/DObvKEo4w9b9
         Qmrxdm9SCXkOB6tdGjdJTVMwXdw8k7I3b9WVuKw9vNMhDv36VwAzQv11Vz6C1tvw3v0K
         d/+EV7KujnBVJCpbK1nkpiHXPhcsL4e2pg6hJ9wgPOuiT7RhT4LSbQNmkX+R8tgh6qjG
         h19PMeHNmdCkbXtKctG8I2pLVFirsqG5tzYSQ80oKDzrFNqucYgFLPntfr5W8wd80VGI
         nREONUqQiiEFruk9YBriFlQQmnd9A8rHrszh6w3vzNbxRJBz+O/z/Bu70uKS6rKdSoRG
         LC4Q==
X-Forwarded-Encrypted: i=1; AKwUvByIyGNnJ/7449z1exNFiuQrVf3lU/hAkvAnNU0Kr1YgSXxeBWzpzJUjdWKGf6RmRn5G5NZPNWI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjt8KCMNeN0IfVC50SJYq5cymnltICR2Zb1VoTO6DENgCvtxvP
	XowIXIU8BdQRB27+5Y9Hp0wKfgMNxn5yQENNedIa0+b3XGrt7RwI3ho3GQyem7OKrgtQGETJx25
	FA7yGie+JxLalr9+ZE6irCsvABFD9jNNAjEa+G3/0rKtf0J8eD40nHMEXmA==
X-Gm-Gg: AYBFou3b5ZLMfraZQbqO8flzOgTayu/Knwon1KVa4MKELYuNLYd6mXYvyF/Cjk/1f4w
	y1nc4H4ihZwU6I7WLCnbvu2gTGYW5n9lEP43mBV4kXuQiH3Y4m82nXDi0BX0w2JatwhxTetOXSx
	cZjqK47O9nh6KjHrUZhD+z0Zf1K1AXjrcSvyAljTuZ2pxTEPGXHGSGfQgbkP1aY0vEInwNDMDuQ
	kpM/APTkvfY6w5m9qFHUPuYiXhlsQ0gNMvkCm4KNZYw6qno6cG7i4ayjNludY+qrxw6NAXYwE9Y
	XsRT+FMEjGSZPJVCTWzmqquwsD9rT+NHX2twvE1r7CJsY9maoBryhZ1mMlzKv2ytFCsDBTg=
X-Received: by 2002:a05:622a:4c0f:b0:535:384d:68ac with SMTP id d75a77b69052e-5359facfcbamr53929181cf.13.1791588235702;
        Fri, 09 Oct 2026 16:23:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0f:b0:535:384d:68ac with SMTP id d75a77b69052e-5359facfcbamr53928871cf.13.1791588235223;
        Fri, 09 Oct 2026 16:23:55 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b277938sm29237071cf.0.2026.10.09.16.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:23:53 -0700 (PDT)
Message-ID: <4200b4cefe4868fc3ca085d01957446ebfdc53e9.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/sw: prevent NULL deref of disp in
 vblank methods
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Fri, 09 Oct 2026 19:23:52 -0400
In-Reply-To: <929077046827f363bc32f6f59e760de27a48b5ff.camel@redhat.com>
References: 
	<20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
		 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
	 <929077046827f363bc32f6f59e760de27a48b5ff.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Bah - sorry I keep doing this :), could you add a fixes tag for this
and respin it before I push it?

On Fri, 2026-10-09 at 19:22 -0400, lyude@redhat.com wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>=20
> Will push to drm-misc-next in a moment
>=20
> On Wed, 2026-08-12 at 23:00 +0800, Zhenhao Wan wrote:
> > The NV50 and GF100 software-class vblank methods
> > nv50_sw_chan_mthd()
> > and gf100_sw_chan_mthd() evaluate "data < device->disp-
> > > vblank.index_nr"
> > to validate the requested vblank head before allowing its notifier.
> >=20
> > On a headless card the display subdevice is absent:
> > nvkm_subdev_disable()
> > (strap-driven from devinit) and the -ENODEV path of the
> > NVKM_LAYOUT_ONCE
> > device constructor both leave device->disp =3D=3D NULL while the device
> > continues to probe and still registers a render node
> > (DRIVER_RENDER).
> > An
> > unprivileged client holding a /dev/dri/renderD* fd can then create
> > a
> > software channel and push method 0x0408 (NV50) / 0x040c (GF100),
> > which
> > dereferences the NULL device->disp and oopses the kernel.
> >=20
> > The channel constructors nv50_sw_chan_new() and gf100_sw_chan_new()
> > already tolerate an absent display ("for (i =3D 0; disp && ...)"), so
> > no
> > vblank notifier is ever registered on such a card and the method
> > handlers
> > are the only path that assumes disp is present. Guard the
> > dereference
> > with the same disp NULL test the constructors already use.
> >=20
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
> > =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c=C2=A0 | 2 +-
> > =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > index 0171cdf6f639..4cf8cd120c76 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > @@ -72,7 +72,7 @@ gf100_sw_chan_mthd(struct nvkm_sw_chan *base, int
> > subc, u32 mthd, u32 data)
> > =C2=A0		chan->vblank.value =3D data;
> > =C2=A0		return true;
> > =C2=A0	case 0x040c:
> > -		if (data < device->disp->vblank.index_nr) {
> > +		if (device->disp && data < device->disp-
> > > vblank.index_nr) {
> > =C2=A0			nvkm_event_ntfy_allow(&chan-
> > > vblank.notify[data]);
> > =C2=A0			return true;
> > =C2=A0		}
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > index 0cfb1eaae6de..b202e11238a5 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > @@ -69,7 +69,7 @@ nv50_sw_chan_mthd(struct nvkm_sw_chan *base, int
> > subc, u32 mthd, u32 data)
> > =C2=A0	case 0x0400: chan->vblank.offset =3D data; return true;
> > =C2=A0	case 0x0404: chan->vblank.value=C2=A0 =3D data; return true;
> > =C2=A0	case 0x0408:
> > -		if (data < device->disp->vblank.index_nr) {
> > +		if (device->disp && data < device->disp-
> > > vblank.index_nr) {
> > =C2=A0			nvkm_event_ntfy_allow(&chan-
> > > vblank.notify[data]);
> > =C2=A0			return true;
> > =C2=A0		}

