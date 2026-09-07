Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763553A3E88;
	Mon,  7 Sep 2026 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767001; cv=none; b=RH0B+fix6/eNXTCC4+9BoSY1ALVS438bDvivi0EZ4iojCR6pGamYYkvflnKDLXKf9wlgjIMAzDuNKEOUwo1hJndk+fd5q/LkqXGL0tu6CKZaeg6xGH1dw++7ADpobXGH6dBcPqncHPVg/gOpRvKX5CdDNZNjlgpJcOPZju+ajrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767001; c=relaxed/simple;
	bh=gE26fmAVmlGPrHZNY+Mz82jfGvwSpLVDxURtnfKB2Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXrJcSmYEP5LdWBsnXtH+0qB4fB0x/TFlxLXfZwpwzC1n8AM/tIXq3WPlN3tA1pVCtvIB5zWIRiycgSeggHSZI8B82VBAWkuWvbALHp7UnkGAIA4kuDWJDeFbWH1dIyLUCOzG02AwDtyswkP/MKSwQRah0bw1+uZTcQTAPvcDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeQB8rer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeQB8rer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B81E1F00A3A;
	Mon,  7 Sep 2026 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788767000;
	bh=Zr7A1tEkdrp6PUTPuyC3f4qOvrO1WN8HeZNd7b+EEUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AeQB8rer4btJEQehOGOZQzkGmqSKHoF1A2AQ0KWb7GqXcwXkzwQhi2qQFlycyFhH4
	 m4QX7T5IY5HfTPSgfCYUIH8hH/mbaWVBR7qPeDd3iFP5z1AscBuF9OlaQfgoD9mla0
	 AWWaeS8EPGVER4XHkmflz/OIUvRXXF7EosYS+CjfbQpJbl2G2+t2DGW/6mxHxpeSyq
	 1cWbjl6gZ7vNGqW4O9VgVktFugiG7/UKkczJmD3b669H+L7dnhMkMKu+F0hzWN1zTK
	 JFg+Qu+hLKR3c+woX0+CaNJnBnxjghNENqUYreylOl/EsQEbqmzqoeuWQVWuJippc8
	 LUNWhoHyZOoBA==
Date: Mon, 7 Sep 2026 07:43:16 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	Aurelien Jarno <aurelien@aurel32.net>, stable@vger.kernel.org,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] clk: spacemit: k3: add CPU PLL rate tables
Message-ID: <20260907074316-GKC2330@kernel.org>
References: <20260907-k3-pll5-pll8-1800mhz-v5-1-5cc96d716b0a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260907-k3-pll5-pll8-1800mhz-v5-1-5cc96d716b0a@linux.spacemit.com>

On 09:54 Mon 07 Sep     , Troy Mitchell wrote:
> The K3 CPU PLL rate tables currently describe only one rate per PLL,
> although the hardware supports a wider range.
> 
> PLL3 and PLL4 support rates from 1.05 to 2.4 GHz, while PLL5 and PLL8
> support rates from 1.05 to 2 GHz. Populate the tables with every
> supported rate in 50 MHz steps.
> 
> Fixes: e371a77255b8 ("clk: spacemit: k3: add the clock tree")
> Cc: stable@vger.kernel.org # 7.0+
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
> Tested-by: Aurelien Jarno <aurelien@aurel32.net>
> Tested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
