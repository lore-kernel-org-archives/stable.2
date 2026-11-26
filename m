Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677113;
	b=uEjq/uCD9RJ6M1LNhcWJimhQKybsKf4XyPn0Mnjq5eaVnfO+Ldv9WrDJ/U1IAb/s7CNy
	 eI69UTX3KxaIO7EoJ0uldVxhFvzfKpbX6PLGgydvIdDiRpJdhBHGDrZ2tThD9OZDL1ZJg
	 kMzPypf/mZKaFhpmPiPfYntWe0frCNqgBNHwn+LtIvGyhXy4zdCdC0APKJzyl3+o3cbbM
	 55es5Hn3Y3ShnzvP1bKCS+gRhWLtCiU4NzIPQXlL6HcOdhUQXIBnkI8j0Jz6sdluTH9vy
	 ALbQhixprk4sAkPQaEDDpe9Xv/sX2fJyNaVFqOFTeiu7wJgcLWxfZgQ4hpPUF+0yWhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677113;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=4YyEWwAkCQU+bFSGO99qgS4Bf2a+9peUpz7t0o/uWGE=;
	b=G2RbekYcOE32nnAYk05r9unWcNhbYnyDjtzDBbexGrE/4QeA7bw4WVIFkKvU3n4y59n4
	 3AUtQw7fnwlHLZD3dvI1a5Qx/E4dygKc2pGxuufKlC2bTeWP9eOFd7h7akOj3+Z80oM+p
	 VbynMSEzg9L4bD5PuSaZKeeRI0Na2gp5bVmjCgQ760c+mQde77xPT4oVCsC418qxSzjEw
	 8FGJ2j72He38vSXh+YA5QyjO2Lxap5feXRDQzmYeKsJIHFoZop/nXQ2oN/3D2Ud60i5XR
	 m8M2Ylnb+zP+R23v2MkjovqWTFWj8hcHzUD9JW4hcQDVpVz2AvSl/gKo5qPetRkdjSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmnxEBiQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D669606A69D;
	Thu, 26 Nov 2026 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmnxEBiQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247671F000D2;
	Thu, 26 Nov 2026 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795677112;
	bh=4YyEWwAkCQU+bFSGO99qgS4Bf2a+9peUpz7t0o/uWGE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=EmnxEBiQ2we8OzqZSSUpuEIO00yeED7qfKBz7UYPbFY1VeUVc6EPIae2wwJbIamBP
	 hsGAerkUoYPIC2tpHu80+9l9MufpHAlp9RPJ0hcvleJe+v7uDzB6bhnB5Kul5aL4uk
	 hgKXpV0OSsQKhMunlU/5XLrtjy9IWeto8hzJL9DppEl0UZsOY/79Gg6xL7Rtg30rGD
	 demWXX4eczRRkAoisvA8lkKM9GX+c7rZOELcjsJ485j5234h5gHVpkL28DQsdqcblc
	 iO8ceRNxm22qrTd7U+L93JEWMBK2c95sTIlngtQwIqFiXYM88xeSZlBCEQjdvMh6LJ
	 z5752lLHGObWw==
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
Subject: Re: [PATCH 07/10] clk: samsung: exynos5420: Terminate PLL rate
 tables with sentinels
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Thomas Abraham <thomas.ab@samsung.com>, 
 Chander Kashyap <k.chander@samsung.com>, 
 Amit Daniel Kachhap <amit.daniel@samsung.com>, 
 Tomasz Figa <t.figa@samsung.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Marian Mihailescu <mihailescu2m@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <179567696129.9086.5750343229179878451.b4-reply@b4>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-8-lee@kernel.org>
 <179567696129.9086.5750343229179878451.b4-reply@b4>
Date: Thu, 26 Nov 2026 08:11:49 +0100
Message-Id: <179567710988.9086.18307051341647082138.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-26 08:09:21+01:00, Krzysztof Kozlowski wrote:
> On 2026-11-23 16:47 +0000, Lee Jones wrote:
> 
> > _samsung_clk_register_pll() sizes each PLL rate table by scanning until
> > it encounters an entry with .rate == 0, then copies the counted entries
> > into pll->rate_table.  However, exynos5420_pll2550x_24mhz_tbl,
> > exynos5422_bpll_rate_table, exynos5420_epll_24mhz_tbl, and
> > exynos5420_vpll_24mhz_tbl all omit a terminating zero sentinel, causing
> > out-of-bounds reads into adjacent read-only data and populating
> > pll->rate_table with bogus entries.
> > 
> > Append a sentinel entry to each of the four PLL rate tables.
> > 
> > Fixes: ca5b40293822 ("clk: samsung: register exynos5420 apll/kpll configuration data")
> > Fixes: 9842452acd3d ("clk: samsung: exynos542x: Add EPLL rate table")
> > Fixes: 8b4a7acf7b30 ("clk: samsung: add BPLL rate table for Exynos 5422 SoC")
> > Fixes: b92981de92cb ("clk: samsung: exynos5420: Add VPLL rate table")
> > Closes: https://sashiko.dev/#/bug/linux-553831f9-0a7b-4e94-be60-222de60ca8c3
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/clk/samsung/clk-exynos5420.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Actually let me just grab it and I still wait for other files as well.

-- 
Krzysztof Kozlowski <krzk@kernel.org>
