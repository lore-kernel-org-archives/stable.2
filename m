Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AC411FB9
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080237; cv=none; b=k7xunQn6UQS/pRUoRjxB+cP0S46H9KLqAPFb61OuPqtXlNlC+E2j7PCJqLHZ/KsT86VLEOovtBaAYeMQ6f0jmgfwD/4XiWnenq7919UH55lcg4nRBylyMi8VbxXZjJVpKRU0Bxj78sLLN8gL5unSzQbnyx1yMMvM86UM9O/IEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080237; c=relaxed/simple;
	bh=DAdsEC0Uuf+qib7V+KURez0DyL7Z6gLPhSiAW/SJ1NY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJnJVlPtSWR4CLtacg45iL7DQenHaBXq9E3xnZcQt942AfF4IyP/OhvfjgZ8Rfwee/EeMAwIEff6jv3IRadVRty4iWYYcmfGRloLWQU8PnaHnyIhE0dcor+zKEHyXY/NkP+ls1ypjrQn+MgVW5KNgMIE65Tyjm4Kp89Z8lk9UMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIOwfCXx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qWPDAbDO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIOwfCXx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qWPDAbDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787080235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kbwhzYfa9+JR+FXCNWXDj5upifP6ZSYoTxSiBsZODs=;
	b=SIOwfCXxvMNMlzyuM0Q1In188bqGanZCz9GDhqB026wcnuazROc86U8PuE42JkW4SyVBf0
	JnH+J8iZZvT3tfoApqZ+E5xLuHh45Aqq7m1NjeMYefLYwAUmOtGBQJT2q1h1qpK00E/SjM
	wKp53SKfDJ2Ea0fZcGjGmzGb+nQqwpM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-MIXIe_iGOYSNrC6hNQFrpQ-1; Tue, 18 Aug 2026 15:10:33 -0400
X-MC-Unique: MIXIe_iGOYSNrC6hNQFrpQ-1
X-Mimecast-MFC-AGG-ID: MIXIe_iGOYSNrC6hNQFrpQ_1787080233
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so2186181cf.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787080233; x=1787685033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9kbwhzYfa9+JR+FXCNWXDj5upifP6ZSYoTxSiBsZODs=;
        b=qWPDAbDOBTTgvEkbT4qQp3HLVzr1DRDhoJIEhW1d6mTqQz1bx09U1/AdbxyT8U2cEc
         fgFxRz2OKjJTUJx8nfyBbihU7mdxG/I3LThg/XLZ8/bG6qx1wzDBYErOf5ohGkVmPQEI
         m6phxtxBe6STQLwj/M5CiDt7JhRP1eT95AOyHaofwj9WOaa6ox+/SHEE3gsOfFirHzkv
         WR7tQpDa8L7bewdsSoNv0jCPcZwcuNqZGVxBJOhh+A+7FQCtL9kbzKfdLtvtrAN+X6ad
         O2Uya3u9Hdyhg3IzFtNzhaHuu5+NMR6G10vMQT8yoHopIKvn1L7KJinQoWwITbyttQEl
         jBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080233; x=1787685033;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9kbwhzYfa9+JR+FXCNWXDj5upifP6ZSYoTxSiBsZODs=;
        b=FGoCYyc27rStndpbJOHLsoQ/wPj96/xfQfCc1mNtdw9On/9PTHmPxMPOpbCXhilTG6
         Pt7h01Zallg9mzMj1S5XVuiBI2GOqz6qiXukheOdXkMFeNWxt8D0j1eeIdZRyjAUEujS
         mua0H7BYVw9mIwF+cf1vZbIXv9bJAN4atGF3vdJ5iLXYyYwwmqka2ILUqxG7WFnhg4Dg
         /tf2pxryYSQl51uH8py1qYQ2P1pt7XyQh53hpks1DTKz4y4aCVzqGPwN4pk1KAAIrYe4
         YX3LWqR9wEnh6gRuEXYAgW0zEE2wx6ZWSOmzscmoxhQgnNgfTOgNYuhyrIQ/Hv4u7lqx
         IElw==
X-Forwarded-Encrypted: i=1; AHgh+Rrcwfl29AxJOEURdnrbysonSuD80v108HjwDDpRRCGNvCNOv/BH8Fayuws2iNCAv3NG29TiScw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrV3g6mNpZLv+eq3MLw+qx93mcx3J4v8WXa5OFegqKyTl9InyH
	fV5In6Ny6JhgEEzdLKFmbAl0bWQkfN5qWFw/WGYAAnLf/s0WlioqVmWresWQImzaj62pMCC0p1h
	7lo7vAXe3Faw/phRNENqp1tDgY+/jp7J8cGUd8ctpSL5WS5H5euNnhrSz1A==
X-Gm-Gg: AR+sD11C+j5MWDyoHyGlCMLIIL6PQ2tev5o3VMixSS3GH4Bao2Dmimm7L2sRoYTQtrU
	R2dJK/Z5AMv0EmYS+Z3PLuSJljwfV2v5fkqqtqY0CZTt1z/sMKkVxxCoBSyeFGhvav94prDDKp5
	NSFaSlQRGuBXzFNBg9XygRXs+vKKyCm3zVo2waGRJt3OUvkW1z5Bwn05VtgFwI1C8/UETmNDAQH
	PV38VM4tLXWmVFZQcmIdz3KEKxfZlZm1SqzGxaiMYMPZBkf4R8LGNY3C+svvIKn99dCGhFKa3Ii
	hdUpYAuEzF+/a6BTj3x3X0Zf27bT0YgYB7XdfTgzdc2mjfCcvNc32DvnhrnNwQEdWy54/c/q
X-Received: by 2002:ac8:5749:0:b0:52b:4e1f:941d with SMTP id d75a77b69052e-52dd30d0802mr3569071cf.6.1787080233335;
        Tue, 18 Aug 2026 12:10:33 -0700 (PDT)
X-Received: by 2002:ac8:5749:0:b0:52b:4e1f:941d with SMTP id d75a77b69052e-52dd30d0802mr3568331cf.6.1787080232870;
        Tue, 18 Aug 2026 12:10:32 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db623bfb0sm44781051cf.24.2026.08.18.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:10:31 -0700 (PDT)
Message-ID: <7ba5804dccefb1fde985f19242f6bad94aaefcc8.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: reject zero-size notifier object allocation
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Tue, 18 Aug 2026 15:10:30 -0400
In-Reply-To: <20260813-nouveau-abi16-notifierobj-zero-size-v1-1-20dee38077cb@gmail.com>
References: 
	<20260813-nouveau-abi16-notifierobj-zero-size-v1-1-20dee38077cb@gmail.com>
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

Will push to drm-misc-fixes in a moment

On Thu, 2026-08-13 at 21:14 +0800, Zhenhao Wan wrote:
> nouveau_abi16_ioctl_notifierobj_alloc() passes the userspace-
> controlled
> info->size to nvkm_mm_head() as both size_max and size_min without a
> lower
> bound.=C2=A0 A zero size satisfies the allocator's "e - s < size_min" gat=
e
> (size_min =3D=3D 0 makes the unsigned comparison inert) and yields a
> zero-length node, after which
>=20
> 	args.limit =3D ntfy->node->offset + ntfy->node->length - 1;
>=20
> underflows (offset 0, length 0 -> 0xffffffff) into an oversized ~4
> GiB DMA
> window.=C2=A0 The dma object constructor only rejects start > limit, so
> the
> validly ordered [base, base + 0xffffffff] range passes and is
> programmed
> into the GPU DMA context.=C2=A0 The ioctl is DRM_RENDER_ALLOW, so any
> render
> node client can trigger this on pre-Fermi hardware.
>=20
> Reject a zero-size request before allocating anything.
>=20
> Fixes: ebb945a94bba ("drm/nouveau: port all engines to new engine
> module format")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index 291203121f0c..8d139bbb2934 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -660,6 +660,10 @@
> nouveau_abi16_ioctl_notifierobj_alloc(ABI16_IOCTL_ARGS)
> =C2=A0	if (unlikely(device->info.family >=3D
> NV_DEVICE_INFO_V0_FERMI))
> =C2=A0		return nouveau_abi16_put(abi16, -EINVAL);
> =C2=A0
> +	/* zero size yields a zero-length node, underflowing
> args.limit */
> +	if (unlikely(!info->size))
> +		return nouveau_abi16_put(abi16, -EINVAL);
> +
> =C2=A0	chan =3D nouveau_abi16_chan(abi16, info->channel);
> =C2=A0	if (!chan)
> =C2=A0		return nouveau_abi16_put(abi16, -ENOENT);
>=20
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260813-nouveau-abi16-notifierobj-zero-size-5d3888d36b57
>=20
> Best regards,
> --=C2=A0=20
> Zhenhao Wan <whi4ed0g@gmail.com>

