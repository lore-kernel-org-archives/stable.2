Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995813BA244;
	Fri, 16 Oct 2026 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146481; cv=none; b=XIMidj4O8nyt4TXKWyeJeWktGx1AOoGRl+T5UtPxKvv4fkbGHmRVq4KNBvv0gi0H6psuuWkwLd5nUpO0bq0cAMSSaTFZMKcWguie3PBCCRLczaFu6MQbvsuAlStHSQ5t2yDsSJOLLmfqMkynXgXwiuOLznBOXTFFibaedmYJdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146481; c=relaxed/simple;
	bh=mrE/BzO7bhFTMiLHsRW6/vXVrJHPy36G3R74Gh3OASw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp5W/XWtI7XjAuPXlHX50JdWqysre4yEu+cN+3mt5zWRuoQMyHUHERNcVX5BzYdMCvt8UZukVDS8nvrVRql4/Gox/iFbaQY5194nsfSHEUl3Z6/UnkEWYZdUpdLcXOVmfzOyzpcgcaH1aedH5aF/XxA5jOr3hOMasTg7aydFK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUSsEjB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUSsEjB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524C71F000C5;
	Fri, 16 Oct 2026 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146480;
	bh=mrE/BzO7bhFTMiLHsRW6/vXVrJHPy36G3R74Gh3OASw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cUSsEjB+E23hz6BEJoFYLGF7+rFGynzwXMi1/SR1ljJOM5acgFubhLGBYxAr8Y5Hc
	 U9rPCO2DPsB3I2ZQEAH6Ipmqeilb0BBgQwRdFMWIVZ8mD7Z8Igd1q0oWn/ZaoPqF2N
	 JKZ3yl7j3MBAlD0ghMPmeuzwYJX925sbOMkB8X/LS+CFe/NK+VM5NsiUM/poegS3ZW
	 lWiq6/JUom/aHBiq6v9ajPDAzgq/5lyqPtalWgT9G2jGOWtHjivR1CT20w5XjPZtvH
	 HnSBtAbM1se4hM9Nxpti+vJOyaEBKDbdbpWWYk1PJLMzKxMtJ4BygiABsbWu2dQ2jq
	 P+CfIQJm3UUQA==
Date: Fri, 16 Oct 2026 11:27:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: thangaraj.s@microchip.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-pci1xxxx: quiesce DMA engines on transfer
 timeout
Message-ID: <c16a2559-7fcc-48ba-a3b1-3e1273f6666f@sirena.org.uk>
References: <a02880a9-f20f-45ad-b22b-c405fb7e74d0@sirena.org.uk>
 <20261016020036.1333548-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C1mMnbE9vl43J2N5"
Content-Disposition: inline
In-Reply-To: <20261016020036.1333548-1-liuwb@xiaopeng.com>
X-Cookie: <<<<< EVACUATION ROUTE <<<<<


--C1mMnbE9vl43J2N5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2026 at 10:00:36AM +0800, Weibin Liu wrote:
> If a DMA-mapped transfer times out waiting for DMA_TERM and neither DMA
> abort interrupt arrived, pci1xxxx_spi_transfer_with_dma() returns
> through the error label while both DMA engines are still enabled, the
> done/abort interrupt status is still armed and the transfer state
> (p->xfer, p->tx_sgl, p->rx_sgl) is still registered.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--C1mMnbE9vl43J2N5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrR/CsACgkQJNaLcl1U
h9DbFQf9HQTODZj2F1BAfEjNyDgAhTr+T1RqJ/j8y6sNWOy5nNkSZDpvxdsOj/gC
2eXdK2HVMC1IBX0LFWguyuVQKPy3mRVbQnNjmyCAkiFhosRJxIJ+Zx+/YL+vj2H8
PkT54dYqfFNhaB+KAYdWDj3jAm/iq++NfgJ/SQNnZ2g42ym4iWa0fGfPyOwAjnKj
76akhk+2MByEtjtubsLmgcJsN6kNK/j9+e4hhAwX0ujt05GdQBx+4NW3kpwnvWg6
psg0G1Np1Bp5lUHxFq189OAAszdknZoHaITJmgZCAaco25xoyYJYGVgnXkZiE4av
XadeFk1nRK24a1oQ5YdT4if/15k63g==
=KJZa
-----END PGP SIGNATURE-----

--C1mMnbE9vl43J2N5--
