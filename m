Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281D401A16
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483625; cv=none; b=spAF1tNYj1NgL9RmzeYNdUBZrqqtP/jGa0XN074YMXZ6zgBsbBp7dozLfAHkbkOiValZ7eJFueNb+UzfuWQYDoNXCbxPfkQMwbBOFvekf/zCNvXjr+c0yw5nhpZj9T+rS5VGfFhpEU2vyWAEPluuX/AZViZTXrVBdmAmowDMMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483625; c=relaxed/simple;
	bh=PFqGJ5C6TnX1ODtkcQO7QhDgZjaXedNcrOd+Vws8BDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBRFJcQ4AKHW7IxJPhbV2SX48Q0rQlpBOMu6q+kQTpxnsHK0AKRWpq6TD4dCERNaIZ8qIEO8HBLTdJkEMzgT/qr1nL8x8BwbcpueU9kJGcRqOmSYzhjENExeKe7yBD2qV0d8VF/CD1rGctAvJknRHkuLDFXDNFYLQQ4VCNflqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8VdoLVl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ta61aS3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8VdoLVl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta61aS3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786483622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTYFSNNmHE5Ej6nfI5EPC0KoXgMH1Yho7tZYF93ZSko=;
	b=Q8VdoLVlobPn8jIQEa4Olb9IS6BdmgRF8NqihQ/kjCqD3RUPrSzqVgF84MHfPGUNrwhDVD
	zMQc38OLFyWG6LvLZtn4FTkSl6mK2PcC1MzuXvXXiSmc65joiDVhMWvi0pmG3lfta8J0XL
	JXE27mtDOuBKPu43foVbq93vu9fyAU8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-wL7-RcamNsmvU7xuAJyBbA-1; Tue, 11 Aug 2026 17:27:01 -0400
X-MC-Unique: wL7-RcamNsmvU7xuAJyBbA-1
X-Mimecast-MFC-AGG-ID: wL7-RcamNsmvU7xuAJyBbA_1786483621
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so5626681cf.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786483621; x=1787088421; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rTYFSNNmHE5Ej6nfI5EPC0KoXgMH1Yho7tZYF93ZSko=;
        b=Ta61aS3jlbJknH+xYQVLKav2y8BlFItpTqjn0+nfQnSQaHYkkOWdceZ9AHa3BmSPvI
         S+euDSJLmtJ6eTNHyyk10YxBhkT969pxQgLJeiJ2+pBSWpWg+afhYybSzxSFi/Ylrxcs
         Pa+PJ/4xMy5rpbZI60KQS4mVqziHBBv/2U0UYznI4NuDOogur17ULA7HQjigmSKidN+9
         WYmV8LOrJ0jSasgqqC54p1e6x2SpJ+X6jqxoMwQ5vWjzyrh8tfNrxZ62wSdY5B28o7TE
         g17KQ6pgnM4X3Zaqe3Vswf0g9M1Xg72RK6p70EazgX0IegtuTJrDRHJIAct+tTazH9dY
         YmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483621; x=1787088421;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTYFSNNmHE5Ej6nfI5EPC0KoXgMH1Yho7tZYF93ZSko=;
        b=BEcgE9bLJ2svqyQcqXURnRDTNq9u23vHr0CF7pLJsIJZvBkKURvWfhnaHCTyplX+i8
         OlXMSs3wo0mVIeVVbdury2W6G0R7cXwOuH0SJD9/Gtj74bg4boiNvGG7+CrzTiKMh/SP
         eBHrf9WbuRdX6ETUaqFVn6s56Rwktb9AJxQXQZZYOL13ll87Ezybfawqize9awsuQi+R
         J6p1f8etsRmtsLftzh3SQ6CM6vQIjJMOr1YweDjl4VyZiU5XoQDYrQ45a0Kn3cB/qqak
         syATaJwwsMzYK20TDSS8hxKdP5HjNMhKN2SCA8jZq3Dc1IuNKJgmSIpoudem+fUYuOnJ
         VzRA==
X-Forwarded-Encrypted: i=1; AHgh+RqdanCAnQia1vTvMwhBYQgpSS9X4wpMu5EJDPuyNmeVFpGyM7lLlnu2CjD2LbTBYnVG0yEmY8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI78ixmdRnxiK3ozsS/fxXavDEHhk9yHJAnoyJUympOhmSv+MP
	fQ85pbQqL46dPxROaIeWPaXG3R7yRfiZUWaLWzumpLXGddD1mICdZG/k48B3M3KNtgRo0D/dgUO
	pDZUAnsUbD97jL/k+89veWXMTfQzlVmwiDOOKeM1+Z9UBxJjglmjQ7KEnxg==
X-Gm-Gg: AR+sD11RZdIXjqS+9O3LqIZ2L6n772447ZJi1sczwI0WzLYJHaiirak5rt3NgW93RxP
	W58XooW2ghpHx7ynv1+VIVKr4r1OjH06oKPBDVcat4925N1lR2h/OlMixrPtpb/Z+ArXWdA0nk+
	YC5Xsqs70P5DubY4TujoP4HzLcenuwkDe+2a0wf6ORAuNWLStvqzkggi9gBxkvsTekVPvOVtqWU
	3sqaSq20xSS7LvsMUbq+agIcmqFZ0p9Qh9CR8vkFadHxmlcHsYiHcxYn1L8pDYQ3Dq19E6ruacr
	JIBVqEaBYDasSxMhKL3MGjznjUEJnHhf2ecWFr9ypBs+enX264R/DJZe9fC/G/MDP4GYgmVD
X-Received: by 2002:a05:622a:1cc7:b0:521:934c:bcf with SMTP id d75a77b69052e-52d64838801mr2844131cf.41.1786483620767;
        Tue, 11 Aug 2026 14:27:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1cc7:b0:521:934c:bcf with SMTP id d75a77b69052e-52d64838801mr2843391cf.41.1786483620229;
        Tue, 11 Aug 2026 14:27:00 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61d91199sm4729021cf.14.2026.08.11.14.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:26:59 -0700 (PDT)
Message-ID: <3449a374543614d15655576d13d87c3822e29896.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] drm/nouveau/uvmm: fix NULL deref unwinding an
 OP_MAP_SPARSE op
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Dave Airlie
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Date: Tue, 11 Aug 2026 17:26:58 -0400
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-1-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
	 <20260811-nouveau-uvmm-vmbind-fixes-v2-1-aaee4b395d04@gmail.com>
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

On Tue, 2026-08-11 at 16:46 +0800, Zhenhao Wan wrote:
> Each bind_job_op is zeroed by kzalloc_obj() in
> bind_job_op_from_uop(),
> and the OP_MAP_SPARSE case in nouveau_uvmm_bind_job_submit() only
> creates
> a region, so op->ops stays NULL for a successfully processed sparse
> map.
>=20
> If a later op in the same job fails, the reverse unwind loop revisits
> that
> op and calls drm_gpuva_ops_free(&uvmm->base, op->ops)
> unconditionally.
> drm_gpuva_ops_free() dereferences its argument right away
> (list_for_each_entry_safe on &ops->list), so a NULL op->ops oopses.
> The
> path is reachable by any render-node fd holder, since NOUVEAU_VM_BIND
> is
> DRM_RENDER_ALLOW.
>=20
> Guard the free with IS_ERR_OR_NULL(), as
> nouveau_uvmm_bind_job_cleanup()
> already does for the identical free.
>=20
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index 36445915aa58..849bf42c124e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1489,7 +1489,8 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job
> *job,
> =C2=A0			break;
> =C2=A0		}
> =C2=A0
> -		drm_gpuva_ops_free(&uvmm->base, op->ops);
> +		if (!IS_ERR_OR_NULL(op->ops))
> +			drm_gpuva_ops_free(&uvmm->base, op->ops);
> =C2=A0		op->ops =3D NULL;
> =C2=A0		op->reg =3D NULL;
> =C2=A0	}

