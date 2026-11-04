Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793789941;
	b=sw+js5AYu9/27z6WazuyZRXPYBAAIxI83S2z0SfAKDli3e4vpwWxydmpj5JcaygK/cbj
	 SuoiMgl7SEGK/lTfMf6zb7NmOcwmRzlyTmidi+Ys/w0eNh16E6zSZ1pMhKmqHxLA1Yh8c
	 +ZghHUwmn8Ud9Rg8dmUwhKv6jT9cZy+D6TcYDFBIRB3nHsNDsZbtZFfimpyiAPkuRciLW
	 d2SI6oburpS1YUQSiD/GuEFvyNwnfpSKEa3D7ScRnYE1niPdcHi2f93YGkxTm+ewfOhKL
	 q1kj2qKFvuRuXkoP7I0eAJkpH5YtY7ciqNwiziBL39wqXiwvAfYBSPpZVutJtM/TZKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789941;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=BZFGF4yVK8CasvOvAXi/K/IhB8egqk0MRd0U/7JM4nI=;
	b=EG5KCnrCQQAF4aVjML/x73R9nDdDwTgHLZU+EbRaUoUVwFuYVoQaotDgwGoNNlT3GQCn
	 QqD3/ew00XzE4RUIA3FAxKXszESmrMwiNrUGxlzhyCzc+4V0Z4zbiRK3q1PAOWGxP/+Ph
	 Z7NrofxfYZTUFvCsq+oVZwuBtNv9vb1Ygxo0poxwkAfXcsyQzkHwCrQvvTQlSWI3SgKTH
	 s/twXDpF4TRMEgGpxL9m2kQp56+d68BvRLL3RcueFKRoHAz1u7IeBDAee89wfJFkZok1M
	 UKsBUfFRDyUPNUINZrwdCa4/JKIhFY9+m7mW9AsOrDF2/lgqJC1/B3yl2bN6A1b/BHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TLlQ6ZKv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFD606A31B;
	Wed,  4 Nov 2026 10:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7AFD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TLlQ6ZKv
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: lst@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EE5752008B9;
	Wed, 04 Nov 2026 11:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793789938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZFGF4yVK8CasvOvAXi/K/IhB8egqk0MRd0U/7JM4nI=;
	b=TLlQ6ZKvu6bXMiiyckpsPoVyhjyUb3xv7sKk4zj8QfNRV58YyZqR4MBdrR/cY1k1zA7hdQ
	uKDGpM56BoeZ//CrB2JXnAgK7ilFxaYcgYSmhYdDm6S8bQ/+fHVtS/f3s+0fE2cXUUfc9W
	jV4LiNVQgEk9LEDbUBybPA84WQiY6xyuPvvd8t8/bx/iwsrENROeKYdnlYuEwLgo8qeOWU
	6uVta/ZX1eNY0gr+ue9goAn1CWOIa9pwDGx9oGjJeLkiNvzJkn49v4PEe9Kc7wJhziLrm4
	xeWHR3q+XSgTS0Rk/wKyxdCN/7Hy74B+hh088Hinkpm+SbibTkZAhFPqXtvkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793789938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZFGF4yVK8CasvOvAXi/K/IhB8egqk0MRd0U/7JM4nI=;
	b=R1jiyD1hstnR1F9AVO7KSV5iL0G0U/obkKEufsN7hXhAVXr0/ElCasNPA1UTHusDYKNJYY
	pieUChCofcGko+EIj35+uf9gqkVJXm8Xm7uFigkNICre+1U2AeNYZI+xbfN7FOpwQFqrHH
	CsdX6QKoJrHTv4N1vbvX57jjipfX6cR/V3OzpNNPSQFzXFjAbWpuFYQFhnvDYdV1x7g5T7
	Mc/UfLoS/o/b0GZdxKWJzSQG6foQI6883dql5DB0hhoHtFlnIWmKfXWNqM5rACptO3lVVJ
	s36Raux9NSxWMgLXBvLjzJGt8h/HfE37J3pk6BquVaj8v9yI0+Lvj+cpDgTHHg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793789938; a=rsa-sha256;
	cv=none;
	b=Jqu7Cv3wg03x/46cig9MB5ofn6u8liJyLUhcMrPmM8KpDDiFKpLLZ0ueHOctlDa/7w/wMl
	6GtAdfXZ7kk3oFgy8Eba+EDFxcQ27mkhKCs0Qbj2FCzC28n5wR2WKLDHu5d0VEzKIdxOhO
	qdlFFklqag6fMhT+RxsWeyli+XrkXJRPYuWBqgzFiLeSrDlCba/JNNpOiedZAyQn+9kz2e
	QFml4f26Ar/MjKN5syonIjCBxpjk/JRe1uQvCVx2eUWziOZb+GbwrJc1L+8F/Y4OlLoID5
	o0zfL1KpnBtDAYmbmsoZxUjzRHpkQl6Kp821g+4uQUfWc2zePSyFlF35LE26hg==
Message-ID: <b6999d67d14772a9b3b90e3cce84d96551e9d63d.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Fix NULL dereference on unbind without PPU
 flop reset
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Gert Wollny <gert.wollny@collabora.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
	stable@vger.kernel.org
Date: Wed, 04 Nov 2026 11:58:57 +0100
In-Reply-To: <20261102-etnaviv-unbind-flop-fix-v1-1-588fd16f6768@igalia.com>
References: <20261102-etnaviv-unbind-flop-fix-v1-1-588fd16f6768@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Am Montag, dem 02.11.2026 um 11:38 +0100 schrieb Christian Gmeiner:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>=20
> flop_reset_data_ppu is only allocated on GPUs that need the PPU flop
> reset. However, etnaviv_unbind(..) frees it unconditionally, and
> etnaviv_cmdbuf_free(..) dereferences cmdbuf->suballoc before checking
> whether cmdbuf is NULL.
>=20
> As a result, unloading the driver on GPUs that do not need the PPU
> flop reset causes a NULL pointer dereference at address 0.
>=20
> Fixes: 85ba57ad88cf ("drm/etnaviv: Add PPU flop reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 08aca9035fc1..ec1352c1b09f 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -601,8 +601,10 @@ static void etnaviv_unbind(struct device *dev)
> =20
>  	component_unbind_all(dev, drm);
> =20
> -	etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
> -	kfree(priv->flop_reset_data_ppu);
> +	if (priv->flop_reset_data_ppu) {
> +		etnaviv_cmdbuf_free(priv->flop_reset_data_ppu);
> +		kfree(priv->flop_reset_data_ppu);
> +	}
> =20
>  	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
> =20
>=20
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-etnaviv-unbind-flop-fix-5c77f75de45f
>=20
> Best regards,
