Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053323;
	b=ekilFSYO18OG7bNid2NygUhhPUijxzWPCXFn3H7uObEbtQ6ByO3bt0Kf141rTLwkADJw
	 Oys8DobuJVjaSYZp5cZKp1KYzWFBCnT6tZJUPwdLSviFX8U+Vp5P8G9hsZs7W04+ogOq+
	 C7CI5INK3Ne6WVAY+zAXWFKA0Ancewymkcb2uIdCI/NZ9ew16KoQhOz67kzsIiCnuralo
	 0xebjXs9YZ2Wcm+X5CH5yv1rwXjuHzMQ+wolo56bZwltE11V8Gowzg1YLQRV04y4iStAW
	 +WXe/hkvlCdyfWHmonU2lrCe/iRgeYIT2J4Zlp+HwIKRBVVs+8pCRVtJc2oYSCPdb/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053323;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KKOKH1RNBhgOxwIAjLKGZKKnrp47rIinB2DXJQ/zAaY=;
	b=rxg9KtxvHm7Zjm6n7Ctyz23g7PwIOfn+1aMz6Z0TWfjovhk3xVAakP8gtvy8CWWH/I2Z
	 S0RvZ3vxqSJUe82qTdA5BIOcD23H0kFrjNQPqdKeS/aFmPlJjjK5KH7IR3eEmB3LW0HiQ
	 fCBbO7wN9ggTciBExnb8AImP5VKgcT6jW4WHunmgmh6iO6C9og2aGkJ7ds/zeIQVEL8cy
	 ggX5ies+xIxBcLJseRnrh46qp6IO9NevHB3XJf2CU39FXVwEk80yIZO1fVu/J1AyAeZ9B
	 OEus0n3b38O6aqOfxKMZ+icfp8rA6Im84bF5S+RuuC+YY8F0o8gpsE3SbiLo6CmIExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6zZkezV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D277606A32C;
	Sat,  7 Nov 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6zZkezV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD9D1F0089F;
	Sat,  7 Nov 2026 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053323;
	bh=KKOKH1RNBhgOxwIAjLKGZKKnrp47rIinB2DXJQ/zAaY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=c6zZkezVLgrjRnr8N7TtqmjebF5ZBOCHOmVAwkg95mg7J41cEMRitRgDq+lr3RRJ9
	 qNwQbWFXtSummRnC9isUzproAvHXEgdJemNKqjoJelh8BPv4kquq/v079seDQDqbiK
	 xTiWqF2FXt/LKbuiWVbO2hNRBvMaaO9jH183fJfnEU5+c1jETWnSsdx/Gv9z+G8STp
	 plgITm4qsVtpOw1B5ohRyiXAa7IKqNtSgzHyCFozWkADQREO4WM9onh47MmAB9EehW
	 J6exTvdneWR5cAz8Y37uW1RvdDbATLO0hzxm6gRkp7FT1mSq63aMaxHz8DiQzfu1jN
	 VMssqfUOK0hsA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 55B1128F342B;
	Sat, 07 Nov 2026 12:08:39 +0000 (GMT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] spi: cadence-xspi: Reconfigure to STIG mode before
 SPI message
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
 Tanmay Jagdale <tanmay@marvell.com>, stable@vger.kernel.org
In-Reply-To: <20261104100643.162694-2-paul.cercueil@bootlin.com>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
 <20261104100643.162694-2-paul.cercueil@bootlin.com>
Date: Sat, 07 Nov 2026 12:08:34 +0000
Message-Id: <179405331442.3424803.15701905615212408804.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o7Hawe4BqoLvWAjz7558tRlzUn7bRYgFWjveFL9lrd8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeixwWPeN1LmRGoPFK0S+b6iL4eCZxvBExDpC8Vu659
 yDHCpv8jlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzEYxvDP3uP3OyvljtZt004
 4rY8OnR6dLPC5I7ezp11OgEz3G8nZTIybDu/VSIyU0JbdWbwy3yV2Vks0345L33efM5/91RtfWE
 bPgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The .transfer_one_message() function uses the STIG mode, therefore the
> xSPI needs to be configured to STIG mode before starting any transfer.
> 
> Without this, .transfer_one_message() simply won't work, at least on the
> CN10K SoC.

> @@ -1112,6 +1123,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
>  	int current_transfer_len;
>  	int cs = spi_get_chipselect(spi, 0);
>  	int cs_change = 0;
> +	int ret;
> +
> +	ret = cdns_xspi_set_stig_mode(cdns_xspi);
> +	if (ret)
> +		return ret;

If we return an error we need to also set m->status otherwise it'll be
stuck at -EINPROGESS and we will get confused.  This is a preexisting
bug in other bits of the function :/

-- 
Mark Brown <broonie@kernel.org>
