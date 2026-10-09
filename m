Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3834E744
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588289; cv=none; b=jMywO/b4w7lFOT4VvnPveKwfo+CmT9F6BGB3/6ANfISnLasr31L2xHgeQfJhmTx+oSqHxnhZegnN5dinwg3KTxgpgmCut2nvGM/At9xBBeOBO7ARh5n83CHaDyrL1slkQQhGOKL1p61yWBvzxrYRQsf5AmYg1tjQDIN6/MPfrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588289; c=relaxed/simple;
	bh=gCPRAyhwbGy3U0SZyNA6UYREvhetTlsvLl1xaWQ4Ano=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlG9ae0MVUnNLSzivjXS7VYpMYpDmkMJB4WCUZZceueKgzOz9I/BLjgv2Pa10oV0J1ThAhNPgT3rVgSeStzC1M6sIU08Xss4sdduZ70im4KCHFm4KfCSkEquiNxpf/6a2SeKL9jxfoR9yErc21OwYEUudgMMrUzIMPCLRqhs3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APoeOkkc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tAFwygCw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APoeOkkc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tAFwygCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791588287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5sL1IN+vEe3uRvA6b5GRf1/o9Y8z+Hb4XnuY1HXzNs=;
	b=APoeOkkcWpe5sETfBNxc69M7RI0eShjaU7f8azaKZtgiVz06V7DdBegScnJbWrfPEPVFHr
	fD/wcw3F3bQTMSxBmgb+9PNq09DDoN69bqFq135U+PBFAX/1esJYTo7tCd+Oqi6O1sRkGv
	L5a8gS6w2Qo6e5UvcWSLmA66mJkboyA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-X7ue4rtANbGDhSyPO1sr-A-1; Fri, 9 Oct 2026 23:24:45 +0000
X-MC-Unique: X7ue4rtANbGDhSyPO1sr-A-1
X-Mimecast-MFC-AGG-ID: X7ue4rtANbGDhSyPO1sr-A_1791588285
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a1de6d5c3so40818885a.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 16:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791588285; x=1792193085; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T5sL1IN+vEe3uRvA6b5GRf1/o9Y8z+Hb4XnuY1HXzNs=;
        b=tAFwygCwm1o8VOyj2DBJ4+hkK7QErQUavkGAYwJ4c7n+MpASaM/V9HbCXrk6RWeDgl
         LkQfnitKe5AfX6KX2H3FOyrv3sSBSjkgguFSj8oNJJSN8pBGSl/7a2vZ/jO9WPiEEX/N
         AVZlEob3S9pE6aKcJ9/EHvoRzLSknipG/uLQAHpE5vlQ81NUrM5xkqKrdhSNTlAq74TI
         3TTIZkaEwqp4WxHNRNE96qFPsQJPRXig/xdaRhX7HduF8A2Y0rvuO7S2vgTW4Kij8dzH
         DFHn3JmaBatbMJZ2KHvAVBatSiC8LPqUlRMljfxPwWrllygtTUggnZ9NlWWXs3ptfJOb
         5TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791588285; x=1792193085;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5sL1IN+vEe3uRvA6b5GRf1/o9Y8z+Hb4XnuY1HXzNs=;
        b=kf9CcGWeTQsHfJQZdVij/loewvvN3hQRwIBOvbcUkotHhZ47bCLigeN2IR1HdcXIk6
         5Db6Y3WTjv7/RsSWlhv4EkTmF8VIuejJ5oZb3eAIe358nImTgA+XVllLu3FqJHaC1RcT
         lhD51dko9MHiq58BJqyOssi9s+zox3bydJqman03X1Tuhtn0Z6n8KbObWhDHB10u9iDD
         IlqC/HrfXwbPaLJDyZE/EvKFud6dBIWNgcD5RxDU7eQjHxn7ZTFh3rhWuRkQuKdUfCXJ
         /OOgs7i3UNYgUx21pkHyQjnTYgencfNuNLrlWPvr6chv/R1xl7qdiV7O3fS2Xqtn8Vae
         nRQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrSGuPml3sn3Ys4RWVMn8A7XIoNoFjk7nbjjPtZ+5u/ElJnb6jhzRlk3x5sry0mWoqZg97RaA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFXjljacFl4T53nT14GF0ttacOnLBj80Kf1TIrwwMSrh7/hNc7
	FChldnKQ+9Yl2kJH4d5by+AX7Ml5m20WtQghYxEgfEcX/yMOQkCyDMMQ2zRUcUck4lZMgk76YOD
	2vzb/zcxKCq6Rhks0KOHUfsyWcg1rSPkqnjDmrkLfYLY5UXt2Yd9Wz9Glq4sg6bVJLw==
X-Gm-Gg: AYBFou0KCGmPSWMqlhZ66qOg7uHOA1Wf6cnpnvgrRio6/tEXecpkNKe6IuzAngHDaVY
	1HR2bKmJV8c9x80OMPCNuUsZUE4foNcym8olXpdUuApicf5/2SH+dSpZpJ93pG01jLJsyha81Fn
	LVaK4yZPRNyypcX/qwJz7aNe1+KuIfXvwGbzE6nMQ6bxdAit0wltJZhvMQftvaq9Yrky3hqjQtr
	s8q4HN3GPpFN8E4571lLqie73ReJzRzmj99AcIaohWm5pkw/jp1+X9+IntVBiu/PxzFmq8XyY0M
	vE/QPP5i8RCm4CT5p9bVgsf8vXpqOpXOA+tXAkr5nnUfYCB3IQNxH7SII5SzBSULCNfxa1w=
X-Received: by 2002:a05:620a:a419:20b0:93e:c12c:f145 with SMTP id af79cd13be357-93ec12d06ddmr330167485a.79.1791588285229;
        Fri, 09 Oct 2026 16:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:a419:20b0:93e:c12c:f145 with SMTP id af79cd13be357-93ec12d06ddmr330165185a.79.1791588284801;
        Fri, 09 Oct 2026 16:24:44 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98e3a33sm297469885a.40.2026.10.09.16.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:24:44 -0700 (PDT)
Message-ID: <a6f23983895d0d09b9c2c6a02160c5e3949a6a81.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau: prevent NULL deref of gr in
 GETPARAM_GRAPH_UNITS
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Fri, 09 Oct 2026 19:24:43 -0400
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
References: 
	<20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
	 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
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

Since this kind of relies on driver initialization having already
failed (which I'm sure breaks many other things we haven't found yet)
I'm going to push this to drm-misc-next

On Wed, 2026-08-12 at 23:00 +0800, Zhenhao Wan wrote:
> nouveau_abi16_ioctl_getparam() fetches the graphics engine with
> gr =3D nvxx_gr(drm) (i.e. drm->nvkm->gr) and, for the
> NOUVEAU_GETPARAM_GRAPH_UNITS parameter, passes it straight to
> nvkm_gr_units(), which dereferences gr->func with no NULL check.
>=20
> When graphics-engine construction returns -ENODEV, NVKM treats it as
> an
> optional absent engine: the NVKM_LAYOUT_ONCE device constructor
> deletes
> the subdevice, leaves device->gr =3D=3D NULL and continues probing, and
> Nouveau still registers a render node. An unprivileged client holding
> a
> /dev/dri/renderD* fd can then issue DRM_IOCTL_NOUVEAU_GETPARAM with
> NOUVEAU_GETPARAM_GRAPH_UNITS and oops the kernel on the NULL gr.
>=20
> Report 0 units when gr is absent. This matches nvkm_gr_units()
> itself,
> which already returns 0 when the engine exposes no units callback.
>=20
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index 291203121f0c..dd3f8d386377 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -306,7 +306,7 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
> =C2=A0		getparam->value =3D 1;
> =C2=A0		break;
> =C2=A0	case NOUVEAU_GETPARAM_GRAPH_UNITS:
> -		getparam->value =3D nvkm_gr_units(gr);
> +		getparam->value =3D gr ? nvkm_gr_units(gr) : 0;
> =C2=A0		break;
> =C2=A0	case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
> =C2=A0		int ib_max =3D getparam_dma_ib_max(device);

