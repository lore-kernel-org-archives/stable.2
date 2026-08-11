Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D37353A7D
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485392; cv=none; b=o29qKU0rpsKYbgsajJ/EzmwzBHwOHhXPCDtCCOvlDhBDd/qBpwReCnsHKsS2tEzHag6QmrK2/2DC/4/V76evZIjw4ohAwATwd7+lz6hguH/qOg1kX0oV9/qqEC5uas32BCNDmDeR8OIgnlHQ7KSehZC+3i6+mIqY50+C26Me4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485392; c=relaxed/simple;
	bh=UfO5GTjXHvoFpUxirelLBunZxdJGiurIwuNIlIkF25U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FFbPUwnx9G2NPeIJLbDu8dxtuqLJVxmdsMD/vf3lDMzDiSHSsaRyTHYNCU7+g/Oi6s/b2UXKujPuOaFU9FtJbLy0kdoHLBfGNBqK0/5aR7t2vG2I66fbwmzIFzao7T7RtRgj3Sj5B69lgyP2DvZ2aifZDD5Ae69zMkfjNMk0pvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxMSZEMQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIygu+4g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxMSZEMQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIygu+4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786485390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfO5GTjXHvoFpUxirelLBunZxdJGiurIwuNIlIkF25U=;
	b=SxMSZEMQAaeEHAiU58GdJ2VMYi7v+PzvBQQ6CPfh5Uid+oSX1wOZYMfpzaHYQk81KG+37+
	GMUuEXPTHL5b1pnIev7/q39yplfgJcIQdPwXK4w0J7YK69GcbdeEG9nStLr/gpMxzLHDas
	ug5M3f9GW+58eobUiTrXofDQNh1lV70=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-G6eNTODYNg66jAP_QEW_Ww-1; Tue, 11 Aug 2026 17:56:28 -0400
X-MC-Unique: G6eNTODYNg66jAP_QEW_Ww-1
X-Mimecast-MFC-AGG-ID: G6eNTODYNg66jAP_QEW_Ww_1786485388
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90a60102d6eso2191116d6.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786485388; x=1787090188; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UfO5GTjXHvoFpUxirelLBunZxdJGiurIwuNIlIkF25U=;
        b=KIygu+4gfbHJnGx/e1z8qA1GG4DwpOJA16Zo9Pdm8ePcnU292zz9duMX2bM/LHhJ8Q
         bW/xWUxt5e5yCsMUdgepBmGh0GKW31y5Wm0B2upHVXK9Ovb9jNZ6ZaSHVZmT0Jljlr2N
         Yi6xd/QSIKQiLH+EJa3CJt7d+B0A44G3lCwjL2VlYb66LaMa4VfktN9DsowOqnhmf0VV
         mii7D0wXMoRaDOCFPtjvgrcZGjHYUSoIvofWPnpWUyGxc/elcRT7mm35tGbA8GhfKLAg
         TwAY7ccPJ07WyInKCkT5dZWnxpCerKgFQYD6UU4TF203XCr70fztg3BvRFMoe3jh/wz3
         K94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485388; x=1787090188;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfO5GTjXHvoFpUxirelLBunZxdJGiurIwuNIlIkF25U=;
        b=NjYI3LIwhGuj5SIUIiMrBR4ZTODhtCcb9A70b03AaWsRJrYyRPlFW61YlrFkGG+uvO
         JgLAHgqMNDg3ll5Mg/lEoAwJKr+VSju9fQV5KHyS5YuoLcPQQu/2THh6CJRAkQja2jkM
         Vcc/KzyiyiOvvmrWNyl47o8j5gkYLcCZ6VNGtS+6upCtMKFv2WJZ8RKYJKhP5zq9j/gz
         7bbYUZr5tS1DTSc+UrVFLN8VnNkEhrLHuOI1DcLCuRVLEAtc9q95ACyCYgUvooRjO9wN
         gtpJj34GRLTWJLJxH+37vUSjjm7Cl4iFq2w/xB3cmdCoFPYP5MgTEeij/GGZvRk2uikK
         89CQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpk4+rRS1RH/o1FOe2nao5C3RKOt4yiJOPE+sepink2swPajN0wFElRYjrABuLtIIv7kmKIqqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQ48mrLRrKwt9szdMrC0XUMRJK3Xni3IlbmQcAUX7NwjKEasT
	8J1K+Erha7LoLvyUsrPcA2xJGGshHCd7ZDVthHB5m19LwunH0nmjLyqZCBODRS+NgnPqGmGyRci
	1hwBh1fSkb3gW1p6MIJaW+nJpIHjqKxTzPoxqcsSG0rpzJd7dTjkI5NiLpw==
X-Gm-Gg: AR+sD13b9Ax9d+eE3o5kO+w+eiIwNlLR+stbBFmE2DlqDRO8H6mhWiEeKUMgm5IcJOv
	e9lU0P34iQkksUrjSq236FueYVZLWA39j7uXZxo6i9gBbw85V5+prLZElY/21kZCfpS8tgk7338
	PkAcDkBIiD+dnEOsVEqfrErCP0Z0xZkRnhk4vh+5+hYlNm3ewj1aaueI+ZRmGY5nm/fbB1YbWS0
	m2WFJZQDfJcdS3dNWskybNvbSPoyGS8gUMGZGIwrkhmCGK79ZxARNiuXfEZDukRoZO4b0GIOUGG
	RI/LdyG3soH8EJpF9mQ+TEJcrQIqMtXHb4d345KTKCOEICKHsXg9J+fVPXjBFQ5WiQ5ux89p
X-Received: by 2002:a05:6214:44a1:b0:907:5150:a2dd with SMTP id 6a1803df08f44-90a6ff95966mr2475466d6.14.1786485388248;
        Tue, 11 Aug 2026 14:56:28 -0700 (PDT)
X-Received: by 2002:a05:6214:44a1:b0:907:5150:a2dd with SMTP id 6a1803df08f44-90a6ff95966mr2475246d6.14.1786485387868;
        Tue, 11 Aug 2026 14:56:27 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c26d83fsm8495466d6.4.2026.08.11.14.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:56:27 -0700 (PDT)
Message-ID: <1fb27dc24b3d01c9a6318b0dabc0e7571adb7cda.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] drm/nouveau/uvmm: fix VM_BIND submit/unwind
 error-path bugs
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Dave Airlie
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Tue, 11 Aug 2026 17:56:26 -0400
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This patch series is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2026-08-11 at 16:46 +0800, Zhenhao Wan wrote:
> Three bugs on the nouveau VM_BIND submit/unwind/cleanup error path,
> all
> introduced by the original VM_BIND uAPI (Fixes: b88baab82871) and all
> reachable by an unprivileged render-node client:
>=20
> =C2=A0 1/3 NULL deref when the unwind loop frees a never-populated
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OP_MAP_SPARSE op's ops list.
> =C2=A0 2/3 premature free of a region on a failed OP_UNMAP_SPARSE, becaus=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op->reg is left set on the failure paths.
> =C2=A0 3/3 a sparse region left permanently marked dirty after unwind,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wedging later binds over that range.
>=20
> Each fix is minimal and self-contained; all are Cc: stable.
>=20
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> Changes in v2:
> - Add an Assisted-by: trailer to each patch; no code changes.
> - Link to v1:
> https://patch.msgid.link/20260811-nouveau-uvmm-vmbind-fixes-v1-0-40df1c04=
6b49@gmail.com
>=20
> ---
> Zhenhao Wan (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau/uvmm: fix NULL deref unwinding=
 an OP_MAP_SPARSE op
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau/uvmm: fix premature region fre=
e on failed
> OP_UNMAP_SPARSE
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/nouveau/uvmm: clear the dirty flag whe=
n unwinding an
> OP_UNMAP_SPARSE
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> ---
> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> change-id: 20260811-nouveau-uvmm-vmbind-fixes-c2dfab359df2
>=20
> Best regards,
> --=C2=A0=20
> Zhenhao Wan <whi4ed0g@gmail.com>

