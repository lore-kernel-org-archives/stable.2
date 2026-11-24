Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526087;
	b=k59Q/yohmdvgm7oq6OTFlpiO51qxf5kXn+4HMkY18TZVRhe0wvqJ4Zl6Kw4vZRbCoIg+
	 kp7gIMFgekErhbDq7URv86EG+EXtwfTcF/aN9+ks1MgfK7pd651brKmtSmFAkNk5vTzjY
	 8CeCt+eBO1wETccOC1HwkJbhAVqTuygkYr7XN1yTl1WH5gV10O5se51c/6+rMCGhPe6Wk
	 MZGA3OP7TZA3zUuLhoKzQshEmYSnW6CKL8ucB8NInK39a9eLhrxSO16wZE7jqW5N2aiOH
	 cKEfAilCpjNHoaxxk9jxyV/TrE/e5P4GBJwjG/Am+qCXIocJnnDpSU9+Ci+xI0u3C+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526087;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oYMA+I1ChVexlwqljAYD9stKsVlsIrLPpIr5y/H1ce4=;
	b=PsiwXrRHFSad7BtgczROE3efEHi7vOft43/Zyw0Nlg6dMvHOUoNqrJPCiuN8uGt1Ukj/
	 VjWWDb53/rdAYpDYwWv+x6jJPFXx6gC7k1qjwOz4qp7INKTNBBepiT53fMvVOPBoqTj2q
	 JQ0+na549Lx8Xdk4HH/dTNlztQJw/NdP/Su3m5/MBjkgOkoDv2DhipWucJStl2YPySoQd
	 5eexjJfjshz/eufH1x4pm7wLPNQ0y4zSoK5qyGaagTOMmoB9/QpJB62MJTrzB490XArEB
	 czIPZzodnUj/ANgsY9LgSaZJeCmhV2Fq4LD2mhV9gDviaawKUYkP+WLr7DYI3D90T7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3dllRdg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548E606A31E;
	Tue, 24 Nov 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3dllRdg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6A61F000E1;
	Tue, 24 Nov 2026 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526086;
	bh=oYMA+I1ChVexlwqljAYD9stKsVlsIrLPpIr5y/H1ce4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3dllRdgovE0K8wEwpo/avOs2CTalQOyMxfZVAEtlhIH3lg+0WU8mies1GL2FipTP
	 x8w4e/R57wOBo8oZMgyY1IdXz99YYYBcKxFxyrjPFn0S6/hZFBz/AnGfovfnzLs+aO
	 50OCr1eECbZpkmOAO4BKX02aOPxzb5nFfMWOzHxtIaxGQDPd/2R32TUD8trDK55cVe
	 IJPB2pTUlIOYUYZy1A88B1XrcGQkTbK/mY1Isd50rsFby+sQIL11huiWEEShOKzkqF
	 S4naHNjqyrrWFu2rWtAEoxKXUdfWmHplQ4JGw0bP1lbl3KTm3v9dY+m2CKkr9xM6dv
	 qlrHCDgay7rMQ==
Date: Tue, 24 Nov 2026 13:14:40 +0000
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
Subject: Re: [PATCH 07/10] clk: samsung: exynos5420: Terminate PLL rate
 tables with sentinels
Message-ID: <20261124131440.GG70182@joneslee-macbookpro.roam.internal>
References: <20261123164834.3330320-1-lee@kernel.org>
 <20261123164834.3330320-8-lee@kernel.org>
 <ff973b48-043c-4cd8-88fb-dc38ec54c09d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff973b48-043c-4cd8-88fb-dc38ec54c09d@kernel.org>

On Mon, 23 Nov 2026, Krzysztof Kozlowski wrote:

> On 23/11/2026 17:47, Lee Jones wrote:
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
> 
> Also drivers/clk/samsung/clk-artpec8.c, artpec9, exynos5410,
> clk-exynos7885.c and probably others?

I have 43 fixes queued for clk, in all!  =:-|

-- 
Lee Jones
