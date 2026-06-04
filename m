Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AF405E7;
	Thu,  4 Jun 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568284; cv=none; b=c+d/Tc6kWlBYaLOWu3eNLMta70mH1zopgvCIKDR8VKNsthyIOHRQtVbFhEnH4XFpno28C169u5VP4FeXCZ47fCliTcgnsO5EsPPQllTzwuqSbT6lozgoUtOg2iQjk9C40S2IKc/EuLmOlAiu+R/6X8zGnMpGjJM+BT6iOaCFpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568284; c=relaxed/simple;
	bh=fHROndg5THUN4wVkBOJsFujH2BeidORwx6fT/hry+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOZfW+wCvwDtC17WxLoz/bkhE7ANBeN6S9Xyy841DE3IMgkHpZVGyIbqNlvfXjOHw3a8ElyQuYS3dn/bLFp8eP6dg/9Gs9Cg6bwuPai7ApzyTWYGR4Xz2fz+GnzamEe4Q4NZJ9vnwH8WP2cbtINaRx81Hp0yNT3jM7UKShEzyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzq2rcP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzq2rcP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F121F00893;
	Thu,  4 Jun 2026 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780568283;
	bh=pUj7m2CDaW3G/ucn/7/SD3wFXRKZCFFvrBjYxGmN+is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nzq2rcP1fx+yyhPnOyn2Rq5EpciyRCD4vPctNirtOQoDW5WlfuokxEuH+hpss8sJ8
	 XuqVFpGttKjbEU/tiRl8K/dZMpaX6+5eqh0RHpkkP0+6OweCCTW8vJI5hcXoeSNaSS
	 5I9q8T17WkGk5zvMZAOhag9Rwd/GiNIWsuOrSO6LSAT8emfcZOug74ZHaNaJ8TLgly
	 N3IaWugx+FmOnkk2lBV6OQ0A5qrjkWqoT59ET04IjDxUrL0Oy+fbTieF1K+U3SL+Zy
	 lnUK0I31pZgbfGpDGDQhfDvnYIUeEbJ68F5XgYweaZAUT8TBY31Tz2H7LedkRIo0Dd
	 wR3AvuQ9yVpMg==
Date: Thu, 4 Jun 2026 12:18:01 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Add NULL check for
 of_reserved_mem_lookup() in airoha_qdma_init_hfwd_queues()
Message-ID: <aiFQ2cQIHGXiRdBx@lore-desk>
References: <20260604070352.2603077-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MHS1sKb/1YHuFP2O"
Content-Disposition: inline
In-Reply-To: <20260604070352.2603077-1-zhaojinming@uniontech.com>


--MHS1sKb/1YHuFP2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> of_reserved_mem_lookup() may return NULL if the reserved memory region
> referenced by the "memory-region" phandle is not found in the reserved
> memory table (e.g. due to a misconfigured DTS or a removed
> memory-region node).  The current code dereferences the returned
> pointer without checking for NULL, leading to a kernel NULL pointer
> dereference at the following lines:
>=20
>     dma_addr =3D rmem->base;                          // line 1156
>     num_desc =3D div_u64(rmem->size, buf_size);       // line 1160
>=20
> Add a NULL check after of_reserved_mem_lookup() and return -ENODEV if
> the lookup fails, which is consistent with the existing error handling
> for of_parse_phandle() failure in the same code block.
>=20
> Fixes: 3a1ce9e3d01b ("net: airoha: Add the capability to allocate hwfd bu=
ffers via reserved-memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: ZhaoJinming<zhaojinming@uniontech.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index cecd66251dba..2444d3275a81 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1153,6 +1153,9 @@ static int airoha_qdma_init_hfwd_queues(struct airo=
ha_qdma *qdma)
> =20
>  		rmem =3D of_reserved_mem_lookup(np);
>  		of_node_put(np);
> +		if (!rmem)
> +			return -ENODEV;
> +
>  		dma_addr =3D rmem->base;
>  		/* Compute the number of hw descriptors according to the
>  		 * reserved memory size and the payload buffer size
> --=20
> 2.25.1

--MHS1sKb/1YHuFP2O
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiFQ2QAKCRA6cBh0uS2t
rGQoAP0Y+U3xaU4dH4A4qEA5eXkvOPfKybpxGlsEg1dZFVcKfgD/fEwzNgGlnKUX
1JLWfHZ0UTnNgp7WgqnMb40Sm39fpgM=
=v7Zm
-----END PGP SIGNATURE-----

--MHS1sKb/1YHuFP2O--
