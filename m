Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8D3F4DEE;
	Mon, 20 Jul 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547386; cv=none; b=jpjVzAgPyIqqn9/4p58BTBmP8u7ud7Bd52E9nx/xYngwUtoFmxbNnEGw+715L5GeNhbLN7CNQO7LdRONRfJ+/NP6hwV+s1gH8FY93W11d8Myv/4OEmNZ6CDK/mcbEHe1+wgdde1dlKnJrEjY835Zxi9pfj2FWHIJQDafeLfI9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547386; c=relaxed/simple;
	bh=/rlZHWliG290EAqWoQtV0b8UQ3JaaG+Ctmqqq8p2H6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sWFC/1plACRU5NQdkbTgkq000bVOhKQaz9a5qFP/tVDA28wvbxvlwejeHSZJ9P8+PCoqtl79psNGaTbcNe4XVJqyVmX4H59eG6y/BRkbyMy4MEIHO2S+iPRqWapGPL4Y3/9qqW+sUsyhyPZzwuNju5YomLYp8EC4UCMVnTReUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR3tQwnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR3tQwnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4961F00A3D;
	Mon, 20 Jul 2026 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784547385;
	bh=v36e970MK+YgUbuwLDVXe5yspfmfNDBswqX60ky+hII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hR3tQwnjfBN2EIGsDQoz+X4UVx6Wjqmnc8SKjKcQhsrpAVIZ4EATATQa1tBxBNjJ4
	 /516ebGbb9o8t5/PjRVE4gRynVQRztTGg6bKpY0xcChyqkPdTWW+V/9uOa3Hg/J6Da
	 h4XlKtJjKoprBP+3/iL0UZIj3h6DDer2HTvcfyzGFcRqRp3c5cIq9F4IA1EgFg4+lK
	 2SmleYv2VM+rtgLxpHphsALgeDDSlMx3RzA2NI+/QgJE/MLRIOpLS7oBavRnjXx8k4
	 g5Bf+fIOp6JsTv/4tIdfE/bBh3VkH+II3K53VLKghK5nbRrxevRc2n/yELoCrWnATM
	 qamclOw8FtkLg==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Alexey Charkov <alchark@flipper.net>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260714-naneng-ssc-fix-v1-1-1c40a58061ae@flipper.net>
References: <20260714-naneng-ssc-fix-v1-1-1c40a58061ae@flipper.net>
Subject: Re: (subset) [PATCH] phy: rockchip: naneng-combphy: Always
 configure SSC spread direction
Message-Id: <178454738244.1375859.4122685311138244257.b4-ty@kernel.org>
Date: Mon, 20 Jul 2026 17:06:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 14 Jul 2026 19:41:20 +0400, Alexey Charkov wrote:
> Commit 0b31f297557f ("phy: rockchip: naneng-combphy: Consolidate SSC
> configuration") moved the SSC spread spectrum direction setup into the
> new rk_combphy_common_cfg_ssc() helper. That helper returns early when
> the 'rockchip,enable-ssc' property is absent, whereas the equivalent
> RK3568_PHYREG32 direction writes previously ran unconditionally in the
> per-type switch statements, independent of whether SSC modulation was
> actually enabled.
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: naneng-combphy: Always configure SSC spread direction
      commit: be2b5b17b7053fee142939076746d26b2d6c9702

Best regards,
-- 
~Vinod


