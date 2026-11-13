Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577243;
	b=V6rMKP2yo672ftPsfziGf8l/STa1Ho/raX3a7Tm1X4dTQ3dktOu0gzFrrSdjLvadqy/3
	 e1+9vR1rrNkC9zmP8K7+iaBmvReIpl6mH5d+0OeDW17egVZBt0jZL0GMugMfOrj8/N/at
	 8qGB1uyaMYBuxsoYD/e14tVG553NqOCznBxX0kL0iVrJ46NN9+zZdEQKI6NoQWWSkMCyK
	 XMTF/6qW+ybcf7u7C0QZCbk1Z4FKXpDtNUukYhPA9q+dkzlur4X78Sba2XmlO+VaPYTmT
	 c86ZMfwqqoIPCyQdcN2scCFbjjj8SaSNoepGsGHtPN+jAgh1U9bq3eRLzxR5HDfDJIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577243;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=SNoLKxUB9rBkU92blcv5qQgqkRz/rRE9L1+6xhOucIA=;
	b=R9CFNyWfpO95yP+nTm3rqJw0FGVGkTvb0A0d1NW+1z6jLo9Wo79OfA8ho4vj05n/hoTS
	 d36iM9SezZRxwtw4EL7dynEFdMo7eX88NyhC0sG2rcrhQipfu4EdZTpFO4IXQkEz1UL0f
	 YZsgOSwI5kb8VmnAKG8Ky5mMd0qyTwsRuISeJMGQq6OrhKRjlth6qIy48zxUxX0fDvxLw
	 XSsq9o57Gr8Dq9RA8da7N27iQUXVqlu7cWGGWI7fhlEwgy+liRbh1n5PEdGYRn4xKZSVc
	 Gv157iXhe153Clc7JY1WTnkJR6PZpZaeGa4DatPb6cLNYoxG9k7OT89/3Cl3UHyovGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5E4Lnpk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AA606A330;
	Fri, 13 Nov 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B5E4Lnpk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098DC1F000C4;
	Fri, 13 Nov 2026 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577243;
	bh=SNoLKxUB9rBkU92blcv5qQgqkRz/rRE9L1+6xhOucIA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=B5E4LnpkBq28Oq9EAKWTxU+UWi7ZQ+FXozOPosnLV1L8e46K6i2TMUCPLGfeuQ2e4
	 3JV/DtoqSxfwnzlSEx4QZLe6y5gWXxGPvq+WfTC0eW2VMArWrmJ5lnS0KGJy9Q54RR
	 6bCHv7qiqrqXkWtXVb5S2rDrtMmE9ynqNucJFhrIDr1MC2jhBKAd5V13Esfh7NUo9F
	 eYcuLvgDiCgFGGUbqSUNmLRprSGJiCiDVLU8W8M4HH6OOhqV1LOA5WF3CGoTmjyC5r
	 HOjBp1/zphBabRt/yAERDtHRT7hz3a8k9ugyiP8enhvZvh1JLLIC3iNpT9XbdfyD0x
	 uzwb5HFYEoO0w==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, daniel.baluta@nxp.com, 
 linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, stable@vger.kernel.org
In-Reply-To: <20261110120546.6247-1-stefan.ghetu@nxp.com>
References: <20261110120546.6247-1-stefan.ghetu@nxp.com>
Subject: Re: [PATCH] phy: freescale: phy-fsl-imx8-mipi-dphy: Fix hs_zero
 underflow
Message-Id: <179457723966.636098.12816261169765119793.b4-ty@kernel.org>
Date: Fri, 13 Nov 2026 19:10:39 +0530
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
X-Mailer: b4 0.14.3


On Tue, 10 Nov 2026 14:05:46 +0200, Stefan Ghetu wrote:
> The hs_zero timing is computed as
> 
> 	n = (144 * (hs_clk_rate / 1000000) - 47500) / 10000;
> 	cfg->m_prg_hs_zero = n < 1 ? 1 : n;
> 
> hs_clk_rate is an unsigned long, so the subtraction is done unsigned and
> wraps for any rate below about 330 MHz, where 144 * MHz < 47500. Because
> n is a u32, the wrapped value is never seen as negative and the "n < 1"
> clamp does not take effect. The garbage value is then truncated into the
> 8-bit m_prg_hs_zero register field. At the minimum supported rate of
> 80 MHz this programs 199 on 64-bit and 181 on 32-bit, instead of the
> intended minimum of 1.
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: phy-fsl-imx8-mipi-dphy: Fix hs_zero underflow
      commit: 9a0dd2a09484e5ba45eb8e6ab58c0effe18703a3

Best regards,
-- 
~Vinod


