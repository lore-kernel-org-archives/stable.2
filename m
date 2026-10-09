Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5223B05B0
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588138; cv=none; b=i+FU2NfcdIfNJKnB2op03K4/MPO4QBmIgUBweUVv6/CHCkb7nggI4a4GqtQ3Y/EP8ouSW7oxKqg7gUVg3XIdsWZyACzMnEZqhUYGpoousZQsT+M/EVCvDRQwBGJmkgTpLR4ID2q259cvTpm+CjZ3E6UXz8F6Z44HWmM6O6tAzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588138; c=relaxed/simple;
	bh=Mk6ry6v2KD/wkuaGvrTV43kFARxZWmChZfj474Sudrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dz+KU4kL0yvRMnsSd+x/gSH10FjmqbXdGJWBKUftoAA9+4ZtnOz71svH4tHLEEXpWcKS2T0g0YfCiM8nW9M1pLjk1dqZlISezSFP0OsVjdHPKkTTXgEqcXUeC0loKzYsYiSh3O354vLE6GNSMGpj6VGxXRk6I2v3ciuADyFag0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxkYxhZB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQJaGjLM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxkYxhZB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQJaGjLM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791588135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOkSafKPWfgergQn1PH0zCTo27W7O5llrWCsPU5yGRE=;
	b=fxkYxhZBken87NPdZo97Tc+MAtTtrSBFNONJmr/J28BTyJiI5saibAGtsztu+F2REoG3Gn
	dQ/dNRNU1Qta+b/jorQDOhaCqJ8TVe9Bca2XTsk3Z6slVFx8S9f2j83OFi1Gfy72rZ5sw/
	zxc0BbsYdxaMKwxLTGE3ndxgb4htFow=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-gPYjizoFPvKymeipyLGLUg-1; Fri, 9 Oct 2026 23:22:14 +0000
X-MC-Unique: gPYjizoFPvKymeipyLGLUg-1
X-Mimecast-MFC-AGG-ID: gPYjizoFPvKymeipyLGLUg_1791588134
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e834ff4d0so50794485a.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791588133; x=1792192933; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MOkSafKPWfgergQn1PH0zCTo27W7O5llrWCsPU5yGRE=;
        b=NQJaGjLMVCMWXhW/MKF0bU961wgnUIwUCXSiIObH6Y/7HFSRsBQoLWrUDJd37FXz9Y
         u1g7W8JfySzrKeBw/MfyjMYudAK3j3mbUXthpWwvJxuDYsePvHaNjabTENjWibbd/vtV
         mP47arJlrb+v2zBuTDEZxjftQX/KvffcfKbmYVcWDbp35/JgbTywyzkgiB5vWKiULEjw
         +rdAUNUNfLV4GY3zWSLwcekzZxjTKHCUydz8Wwnia7bH9ky6gpbrhLTIGrAEfMi+gmX7
         FQcfInEWAQtz1uxRWJQbfdt9+iQtjC9aJi4BaWb2QOiWQ3ICttsVMCl4o0SMzE1/TVLT
         s89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588133; x=1792192933;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOkSafKPWfgergQn1PH0zCTo27W7O5llrWCsPU5yGRE=;
        b=HFp9NMeJBsWWhigwsCij7X8WU0RLrgsJpKt9kgJ4KdwI3HegENCAdD+LE0wE/2ScY8
         fgG+kN+U61do5BfSfUA6msI3uGDmiN8JkHM09pHyXXisVCSJFMQNA0LBi5PPjT96ga2w
         3YN8Kb4zNc7s+M7aRva2EKsHnkgTJ5Zk8qhjSmV7RYxgVhWsaDc+ghXIjcFmjzVylpFY
         yl22G9RGC+N9PneTyBhA1DKudIQs0fX72Zk6dquJLNDGB6Z+DJPFWpOeD9zBj3O+LFlR
         o+0biskbm1UTtGLi2ccu3palNYHXY/43BtIwLwc8xJib302Jft8/rkWHIJag37iNOKGM
         5oFA==
X-Forwarded-Encrypted: i=1; AKwUvBx65WIXZbAlD2FwAz/Sx+be303rh5nF0RiJM626VNY6+kC5d4zv9f5JewXIL67Q22i5CVN0l5Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVKYU3i68lIEBrFmSNPfIbaIgpVjCfdWz8idVhQf6YYuHaHVG2
	K6gdpNL5+orGRj/+s3TzYO64zx2r0AEoQ3IFSAnKV7MRyizPkeIy7lCluFcPNB1NXOdRdQpmZct
	Mq1jsjLm/CcZ5RMWzYM32/FhGfk6KvFN24HecB5rmc7DQn6EcPQ/+yf4Qkw==
X-Gm-Gg: AYBFou0aKtYuQLurYA3xEQO3JQZFSmMYdKrmvSbeGCZY/uPzGaEF8ACl8f+9yHFhY5r
	c69g92Y+JzZbum7rl6+UCRs3ITz2WqXWTk2xvr3mbluQhWOuQhI1xfYlFS6qB3PST3m8Ew8LPaU
	pqKI1I0MITxg/RKGUOc5k9VC5873jFP1udJtr0Vqxe0Kyl9BVtIYuf/SEtoU0RUKoNbYxY48Kb5
	Oif+YxYVdNbZhgr1S/H8/anSEQ4ykfTdb8b4Pf/ti1egHbDl12NY1iQHKk8e7kKoP7EpPgzk2zh
	OduRs+S6DoZA0qPchKHUDYyh8EW/85N2nz1Chd033h8PE6RNP1yrERFNIl6GP8QDm4aAD/o=
X-Received: by 2002:a05:620a:178e:b0:93c:57da:4ef0 with SMTP id af79cd13be357-93ebd2916eamr545876585a.56.1791588133607;
        Fri, 09 Oct 2026 16:22:13 -0700 (PDT)
X-Received: by 2002:a05:620a:178e:b0:93c:57da:4ef0 with SMTP id af79cd13be357-93ebd2916eamr545873585a.56.1791588133188;
        Fri, 09 Oct 2026 16:22:13 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984889fsm300130785a.13.2026.10.09.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:22:12 -0700 (PDT)
Message-ID: <929077046827f363bc32f6f59e760de27a48b5ff.camel@redhat.com>
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
Date: Fri, 09 Oct 2026 19:22:11 -0400
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
References: 
	<20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
	 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in a moment

On Wed, 2026-08-12 at 23:00 +0800, Zhenhao Wan wrote:
> The NV50 and GF100 software-class vblank methods nv50_sw_chan_mthd()
> and gf100_sw_chan_mthd() evaluate "data < device->disp-
> >vblank.index_nr"
> to validate the requested vblank head before allowing its notifier.
>=20
> On a headless card the display subdevice is absent:
> nvkm_subdev_disable()
> (strap-driven from devinit) and the -ENODEV path of the
> NVKM_LAYOUT_ONCE
> device constructor both leave device->disp =3D=3D NULL while the device
> continues to probe and still registers a render node (DRIVER_RENDER).
> An
> unprivileged client holding a /dev/dri/renderD* fd can then create a
> software channel and push method 0x0408 (NV50) / 0x040c (GF100),
> which
> dereferences the NULL device->disp and oopses the kernel.
>=20
> The channel constructors nv50_sw_chan_new() and gf100_sw_chan_new()
> already tolerate an absent display ("for (i =3D 0; disp && ...)"), so
> no
> vblank notifier is ever registered on such a card and the method
> handlers
> are the only path that assumes disp is present. Guard the dereference
> with the same disp NULL test the constructors already use.
>=20
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c=C2=A0 | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> index 0171cdf6f639..4cf8cd120c76 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> @@ -72,7 +72,7 @@ gf100_sw_chan_mthd(struct nvkm_sw_chan *base, int
> subc, u32 mthd, u32 data)
> =C2=A0		chan->vblank.value =3D data;
> =C2=A0		return true;
> =C2=A0	case 0x040c:
> -		if (data < device->disp->vblank.index_nr) {
> +		if (device->disp && data < device->disp-
> >vblank.index_nr) {
> =C2=A0			nvkm_event_ntfy_allow(&chan-
> >vblank.notify[data]);
> =C2=A0			return true;
> =C2=A0		}
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> index 0cfb1eaae6de..b202e11238a5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> @@ -69,7 +69,7 @@ nv50_sw_chan_mthd(struct nvkm_sw_chan *base, int
> subc, u32 mthd, u32 data)
> =C2=A0	case 0x0400: chan->vblank.offset =3D data; return true;
> =C2=A0	case 0x0404: chan->vblank.value=C2=A0 =3D data; return true;
> =C2=A0	case 0x0408:
> -		if (data < device->disp->vblank.index_nr) {
> +		if (device->disp && data < device->disp-
> >vblank.index_nr) {
> =C2=A0			nvkm_event_ntfy_allow(&chan-
> >vblank.notify[data]);
> =C2=A0			return true;
> =C2=A0		}

