Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD873EA96A;
	Tue, 11 Aug 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474575; cv=none; b=d0tRgqvJVVB4hhCLDpMM/nZjVtJMZKm48FzEdqOjdnLdegda7tSKrY7srhbap3rn6NXOstA0gZRG0lJNGcA/BzBDHsbYB2OrJM86pmrHXWPSuiHBYtdFoTe67+wFwT+3ySSq4xhZs9OCPKBMPPuuLQZC/WCAdXCtGNAnGIJbpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474575; c=relaxed/simple;
	bh=TYzIM3nc1vd7btd9/T3y6M5boLaB0jF3Sp2JAOVYZpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxMuzbxGiC4RaC9WcX9eK64fe7KJM9Az421SRbDAYSCI+mZRYt3/YzxtxIIzxjDtynX5feP5RSL+jLd3Ow9R5hzfMKhYxqCFUj8Pig9ikipkEut2MutS4BH4Px/6VVkp6CIfOsE4l5k/DpbNS23KRe0wvhlmcm88uOKq1+DNJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/d+NNBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/d+NNBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390261F00A3E;
	Tue, 11 Aug 2026 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474573;
	bh=HR2kKp7sgGTXW7+sIDB1ePIKe/b0SC6SUIJPkHa8n9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/d+NNBz2P608w9uQSkmEuhHzepwkEd0ni2Mk1dKE/J9GkXg7PX1RcN/1zDEymebh
	 bTFTkf79FGRTsf5b8IIiTx+B91hI4eAZczA7RX8/X8jKGx3+hiiNB6GEt6ijExIPvq
	 nlS2k0jsgXN9AIkA6uuEpMQMH3f2PITjXcUTbisCasxcasBA/7YE19DKJH6LRc/af2
	 fJXctXbQxNSB+mbUBVVKxMkLs0l3tORbCv8t4vQnP85gSIFHnt3bZfsA62siSG8TuA
	 qJKaBugUColAghFYftyLbKLZO1PKhFPIpREptpRjcTYNMRtYGW1NDbHVFpmUuSWdVn
	 naM/6j6Q/OlAA==
From: Sasha Levin <sashal@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
Date: Tue, 11 Aug 2026 14:55:56 -0400
Message-ID: <20260811184500.stable-0013-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811091322.3592403-1-mehmet.fide@gmail.com>
References: <20260811091322.3592403-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Either way the behaviour is the same. On vf610 in DMA mode the accel path drops
> the tail of odd length transfers and byte swaps under SPI_LSB_FIRST, and this
> commit removes both. That is what makes it worth having in 6.12.y, whatever the
> original intent was.

cac7e5054115 ("spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers")
applies cleanly to 6.12 with no dependencies, so this is not a mechanical
question - it is whether it qualifies. It has no Fixes: tag and no stable tag,
and James reads it as a refactor.

Larisa, Mark, Vladimir - was this a fix? If so, a Fixes: tag would let me take
it here and on the older trees, where it applies just as cleanly.

-- 
Thanks,
Sasha
