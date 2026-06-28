Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0122E738E;
	Sun, 28 Jun 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674019; cv=none; b=J6zfFSo71DvhcThq9qf9QhXSfpnIwFO5+rc0VwCyxuK9xj5WUfEpB6nL/xNLjnw8iuMN9rdWjvPljvqjRKBHF1aDhAaCAnbwOh8u4RTgXBxxoxqxKu0g9b5N+3lMD++jbgZ3XhestF9zEAcK3Sb0FkjE+F6rcPvz5LMJZJ5uCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674019; c=relaxed/simple;
	bh=KffqV9jUGwL/BENjtztTYeyDX+RNBRkN+k7bmjKie7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeDXGgn150zWBlqg5vqP9177uHr+NdXyZyaYZnPmDSrvVeIkrQHBtNyVDOzZN2g+UUCVuayW9PzfVIQEl9qRscNBymmxSqDwy7ZCs12sbyI61iWAN90LWwhXEqqA9G/cASAROpSPZ2qpaNwIxEJ1iCHiDgr0G/h+dJsnE7a+dcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bg125zN9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bg125zN9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=kfo+fkpfY9grTAyC+1zdbUT1BIaN20nZVt7M4K3K5pg=; b=bg125zN9beK0JBe6EXswp1z86i
	W4OCtJPdDzOsvp3XkyT2bpgqQPaRiGQVWbMPom/LlqAySt6Pgd6UM1AHzUCSHvFepUaJpKm5iV+Wi
	5vILZ5nL3wmMsnE0hGlk8quMNxHI/Dtp0QnFGrffLEmpo9VBASK2So6oWVp1DwKtUz90xmmlQ8e72
	pK3+lVtSepXem5YVduoXQ56Q3yJxcV96+YA/GYcVm3gYWB4YgjIoEoAkddcqljyJcqASvzbqa9NDZ
	KFYCBeiP1itaAx3C9LT6J4FXqqdQP0s7CJYG1jnO5uzJRX+wAi3c6/pnjWx+vLcCZKDDSE5Wvf+0N
	HHiseXmA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC reset polarity on PP-1516
Date: Sun, 28 Jun 2026 21:13:23 +0200
Message-ID: <178267399836.3089434.16007967740669483311.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-pp1516-emmc-polarity-v1-1-4816c1c909f7@cherry.de>
References: <20260612-pp1516-emmc-polarity-v1-1-4816c1c909f7@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Jun 2026 18:47:34 +0200, Quentin Schulz wrote:
> According to the Jedec 5.1 specification, the device is held in reset
> when RST_n is low, therefore the polarity of the line must be that, as
> specified in the Device Tree binding (mmc/mmc-pwrseq-emmc.yaml).
> 
> Due to the wrong polarity, eMMC devices with RST_n_FUNCTION[162]
> bitfield [1:0] set to 0x1 (the default is 0x0) will be held in reset
> forever.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix eMMC reset polarity on PP-1516
      commit: 2a08921edcab6a462fa6ddb02c91b90b5ac92429

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
