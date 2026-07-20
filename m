Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770D39B4A3
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533137; cv=none; b=fn31FiMxb182dLiYTInbEjAFtNruZQC72pi1kzfEz0Vnzs7zPx5/AD4f4FmGpBfjNRlbAp9FKTYM6IGbCOp+qEiSR6k2zQnGXI3pzscucdb1PU9XXTMPSMM1ceLSFKqsO4FbTbVKs4UMEycIlwF/QU55sOpGifWtu3WTvnh9cuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533137; c=relaxed/simple;
	bh=z6aou2br63XQoflJDCerJuFgJK5wKfxry9p8lEb8iGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suOH/XAlUrm9Er3Ilfi4AkZlbYC3O16q7eJ9tPzSpADbzvH8+cA4va8JtnNbHUFrnUlrjvMBXT5toriJ3mzo93VDhIQbahRkl5WqlEbGLUw6TNc5ighXVQEMhJtd+GkH4jDENfq7Q0RWU9cb0spSNjIibUZSB3UxhCYPmh8Ww64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TgHDacOw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TgHDacOw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=ysDbyQ7bJyQyW4i7rFOQNKE8Lm0dZWu5oq/b5BCxZek=; b=TgHDacOwuDGzyRuzmo1ciHcIof
	uLRDVrKoKvu87TqlSttICjO8xdZLLzl5X4CT87685MaM5gphtG/gq0eJwou29B4BWL8VO25vu0J3D
	swgxknwqTaomaSxnHqFL7ps9/LCYGcupD35kN1aKCKsgbW+SptcQ10FUVwD0PHrgJDZq23zHCJurW
	PqOKHFM16rn3CqbrQyRjoxmeeLkusXlzic1ZcDacSNKGXFjc+ULB15nEHKooGzTaj0vfdI7ssYoYS
	t17wjZweWb9CNBu/XF+tGPkOYI1HHkiflmIxiC7e9/LK59hX3Q+CaRBWua1ZvkgOvu82jCJYb8JzT
	qtcbY7ww==;
Received: from [159.147.19.205] (helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wliaI-000jNP-Lo; Mon, 20 Jul 2026 09:38:42 +0200
Message-ID: <c4b5bfd3a5fe8d4ee1d283b77db3530158bb3a17.camel@igalia.com>
Subject: Re: [PATCH 2/2] drm/v3d: Idle AXI transactions before disabling the
 clock on suspend
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Date: Mon, 20 Jul 2026 09:38:31 +0200
In-Reply-To: <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
	 <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ma=C3=ADra,

I question below:

(...)

El s=C3=A1b, 18-07-2026 a las 10:44 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> diff --git a/drivers/gpu/drm/v3d/v3d_power.c
> b/drivers/gpu/drm/v3d/v3d_power.c
> index ade8e932fb9c..f608e6d5516a 100644
> --- a/drivers/gpu/drm/v3d/v3d_power.c
> +++ b/drivers/gpu/drm/v3d/v3d_power.c
> @@ -56,8 +56,15 @@ int v3d_power_suspend(struct device *dev)
> =C2=A0
> =C2=A0	v3d_clean_caches(v3d);
> =C2=A0
> +	/* Wait until V3D has no active or pending AXI transactions.
> */
> +	v3d_idle_axi(v3d, 0);
> +	v3d_idle_gca(v3d);

Don't we need to do anything on the resume path for these?

Iago

> +
> =C2=A0	ret =3D v3d_suspend_sms(v3d);
> =C2=A0	if (ret) {
> +		/* Staying active: undo the GMP STOP_REQ from
> v3d_idle_axi(). */
> +		V3D_WRITE(V3D_GMP_CFG(v3d->ver),
> +			=C2=A0 V3D_READ(V3D_GMP_CFG(v3d->ver)) &
> ~V3D_GMP_CFG_STOP_REQ);
> =C2=A0		v3d_irq_enable(v3d);
> =C2=A0		return ret;
> =C2=A0	}
>=20

