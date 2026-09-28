Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E53644C9
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626691; cv=none; b=p6tNEG5tbZN+HHrUr6P3Vq4l1Q3/Vf12zQNqg8o3GlHqdDowGqIzmILpc62+FPssT4L+yicpSEalymfX74UL62UUSdPWumWCu+48hRIVHUSwBbL3xRnDNdhdLVruwBNy5fgFfxz0XO8HRQles+mAKtf1sasVzZvmHS0QyBhRuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626691; c=relaxed/simple;
	bh=CgZhHGj1pW6833JwW53EB4b6tZGAvoRHquleruZAoaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfX5mWDiZUkbuNR7UVKZpIj8eYqxCcs50N+n9kMdToeZZmt68wbDIzCUf7s787fNzagk2/qyNbu6hz5DXKPaeX3CrG689GM9qPgxRtFLZWXX8ngqGEeqPkrkljNJyP+AvVAtW/xlPXlVQfVCQdjPl6G5CKOOxhStFEUhuGK0kuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=dyBCZ3ra; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="dyBCZ3ra"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7b42996ae72so375959137.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1790626688; x=1791231488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P8gb2EQ4YEQM5mnoy3pmR3dgRg6e0zG6BOgph6Y9a+g=;
        b=dyBCZ3radDp8NPPuky5lRIVeEStjDLSxCR/fe0QOxD3GJKsM7UztGPRF3CyZWb25BL
         GQkb90LA0Ew0NGGK7fgAoHJcVeqhqsm59g5UbrTQZtQDbGGZMzuNJ7wSK9U9TgihRIae
         Hb1OPh+2gyW47mHGuDMfYl5yILeUGDfK8ONLgV9IHO3P45f7VroRGCtZWwEpYVWpcGnw
         rO6N0PAeU2R//L77bnSjGRnl18G8pvaGypsMQ2tJP6zcVs4+UjV8u9j8NE9Q9AwTI/Ia
         /cLpSG2R7UmXGLgZPx15SLlqKYwcicvLIb8/MIV0PttZ1JfRBQZSD3kuyoDUeRaza/a6
         2Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626688; x=1791231488;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P8gb2EQ4YEQM5mnoy3pmR3dgRg6e0zG6BOgph6Y9a+g=;
        b=dfhyYfmkeMwkJOjyoknAymvuKOU1ydTgSE6xeCPoUbwsNyxkL9MmSRSdSb+wVqf1Ch
         beRH+AdRVXq3JLurbz8sd0BttcmzUI4CsmnXO7yTZseeQ/iIuRmTddRZmk0mzTMtLeYK
         hQmJR56E3fTmHIDXY27kWoUFf56t42n7CkNlDMYyhN+lalfM7G3SGdVi9gIubzIa2EKr
         sXwiFWM4G97sSIzV+2YchP5tXtzgjAHrgwVJXOb7KXd9DLU8Ysd4uH6AWnztq2vrsii8
         c0pIw8iacdKUoPx3+AYqmwLLrqaq0wKaKuQ8aUrlRmL+/KqJeRbGr5feY/xiN2Wc6zRY
         nNpA==
X-Forwarded-Encrypted: i=1; AKwUvByEWBO7QOOMpw4g1LzEl4fiGH4Uvkmtsi1BmBMqLUJQgAcooyfzH37WqvwUAxt66lW3p70WrYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo1gMzZ7YboB5r/hOiL1kr1nukRlmcrF2B9Sho01oNTndcX+ly
	6uL6sm3WfVfeqbjDDBOqZE5ouYei95BtTK7aRdMziitvGxLwSEjvZ+8xol7NkyYiwANB/Ha0bnh
	3crLmbvIcEg==
X-Gm-Gg: AYBFou09fpnF6Kh5uXVpMbwkF2Qc8kcqLLbU9Ve21igS+so7NHWW3lpo/23oILGx0Ob
	Cd3m/n0HHEfWQ5wjtCau/UpYwjIlEnWxQ89Qwse5mRBYjCimwm0nFBMbsI8X969o7R1hlxGK0f8
	s8uFNb09pEnZ7ZTWGZL4vRsGRzxQTGZgurC4W4KtB8Dnq+4vXahJKcc2Kwl+oq6VBZfZC4QkuFw
	WwD02vgjkvaZFWE+4LNifyEPIqdAQ1llhLdMTkIDcZB9toEAnYfzlI1wInFieiRgyRnhnN9UURL
	3CYIh5pws7KZCm3ox4vqfI20Dt6VhH28AXzCdWDnqQir3sqcKDLkm6HZjwOoJW6gXxYksTDEGjP
	O9zjqjZW5pZj17ZaaGBlh08AuFIuQgGJmZZeNZT6oQ/GEA0KeYVv8uPN5ZwuG2b7xyi2edBJwUU
	r5Ls1aNFtRtsCUjrp5QG9DR5rIKI7T+HXy0DwrjLU1DT9b+AU/t99IJQoQ8DwXV7rstbypdrFj/
	oxDk+lFKx4EwKDxvI9eCITO
X-Received: by 2002:a05:6102:4497:b0:7af:4a46:4c12 with SMTP id ada2fe7eead31-7b1c4a2ca24mr2719387137.2.1790626687873;
        Mon, 28 Sep 2026 13:18:07 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10681972137.7.2026.09.28.13.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:18:07 -0700 (PDT)
Message-ID: <c5bb16dec180576cb7e68221880b5e36b7cb689b.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: rockchip: rga: quiesce IRQ before releasing
 m2m state
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Fan Wu <fanwu01@zju.edu.cn>, jacob-chen@iotwrt.com, 
	ezequiel@vanguardiasur.com.ar, Sven =?ISO-8859-1?Q?P=FCschel?=
	 <s.pueschel@pengutronix.de>
Cc: mchehab@kernel.org, heiko@sntech.de, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 28 Sep 2026 16:18:05 -0400
In-Reply-To: <20260704084659.612221-1-fanwu01@zju.edu.cn>
References: <20260704084659.612221-1-fanwu01@zju.edu.cn>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-39ovF+b+wtIn04/R/uu7"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-39ovF+b+wtIn04/R/uu7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le samedi 04 juillet 2026 =C3=A0 08:46 +0000, Fan Wu a =C3=A9crit=C2=A0:
> rga_remove() releases the m2m state before the IRQ is freed. The IRQ is
> devm-managed and is only released once rga_remove() returns, so rga_isr()
> can still run while the m2m device state is being torn down.
>=20
> Store the IRQ number in struct rockchip_rga, unregister the video device
> first, and free the IRQ before releasing the m2m state so the handler
> cannot run against the freed state.
>=20
> Fixes: f7e7b48e6d79 ("[media] rockchip/rga: v4l2 m2m support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Again, I don't know if this is a real issue, but seems fair.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Picked, ty

>=20
> ---
> Changes in v2:
> - Rebased onto media-committers/fixes (Linux 7.2-rc1) so the Media CI
>   valid-ancestor check passes. The rga driver was rewritten upstream
>   (rga3 support, external IOMMU, clk_bulk, cmdbuf moved to rga_ctx), so
>   this is a re-port rather than a pure rebase: the resource freed during
>   removal is now rga->m2m_dev.
> ---
>  drivers/media/platform/rockchip/rga/rga.c | 4 +++-
>  drivers/media/platform/rockchip/rga/rga.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/pl=
atform/rockchip/rga/rga.c
> index b3cb6bf8eb86..fbc99462dce2 100644
> --- a/drivers/media/platform/rockchip/rga/rga.c
> +++ b/drivers/media/platform/rockchip/rga/rga.c
> @@ -797,6 +797,7 @@ static int rga_probe(struct platform_device *pdev)
>  		ret =3D irq;
>  		goto err_put_clk;
>  	}
> +	rga->irq =3D irq;
> =20
>  	ret =3D devm_request_irq(rga->dev, irq, rga_isr,
>  			       rga_has_internal_iommu(rga) ? 0 : IRQF_SHARED,
> @@ -876,8 +877,9 @@ static void rga_remove(struct platform_device *pdev)
> =20
>  	v4l2_info(&rga->v4l2_dev, "Removing\n");
> =20
> -	v4l2_m2m_release(rga->m2m_dev);
>  	video_unregister_device(rga->vfd);
> +	devm_free_irq(rga->dev, rga->irq, rga);
> +	v4l2_m2m_release(rga->m2m_dev);
>  	v4l2_device_unregister(&rga->v4l2_dev);
> =20
>  	pm_runtime_disable(rga->dev);
> diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/pl=
atform/rockchip/rga/rga.h
> index bd431534d0d3..7bcdf36c11b4 100644
> --- a/drivers/media/platform/rockchip/rga/rga.h
> +++ b/drivers/media/platform/rockchip/rga/rga.h
> @@ -73,6 +73,7 @@ struct rockchip_rga {
>  	struct device *dev;
>  	struct regmap *grf;
>  	void __iomem *regs;
> +	int irq;
>  	struct clk_bulk_data *clks;
>  	int num_clks;
>  	struct rockchip_rga_version version;

--=-39ovF+b+wtIn04/R/uu7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarrLfQAKCRDZQZRRKWBy
9KCPAPwM1fyw7fD5QEP3/mMmZg+7cHaUSSeU24SoTWd1bUpA9AEA7xkB7orTNjBo
jdc9UGf06pEwlRtqhefYvUSz8x45Rgg=
=QwDi
-----END PGP SIGNATURE-----

--=-39ovF+b+wtIn04/R/uu7--
