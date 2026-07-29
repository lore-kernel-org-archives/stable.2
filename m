Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BB3EC832;
	Wed, 29 Jul 2026 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340761; cv=none; b=b/ZNnBEW7tDxVAa9vR59QtqIyrKc9Ak9rp8v6p8IVrIsNZ6E8PxM6u4seNxD/hgeNQI3qiruKNraRlxjhafZDDsxgBp+MrMuch7WQOJgUx3xJwPAFXYCM4ja+ozVJdYe1NZZZZZn6HqtrOoratakjKGB3OjbCqbkQ9/bGQ6RvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340761; c=relaxed/simple;
	bh=ZL6h8xXo51r9pRKKSO6ntuoM4jqONloTsmHEEEaqPcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG9LIwLPxloNeGSIqa8ruqUYNt6QsH5XjRlLPDpHmezCxb7o7UDMrp8f6nujATMYtmQAEKZHaZevPjWEOrenU41q2K1cOx85DQYq4Jf30UyyUlgkuOZijbgpY3bTKo+E230ra8tZ2YGNIb1ksrmwxzflbRc9uWZ6xjWs4VtMbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=WI3buro2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="WI3buro2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=opJFIr+DqIwybOpicZ49d5YUTu7nDbtYSMfx7eDXb7s=; b=WI3buro23khtexlX1rIbPyKj23
	BlFulK++Qhs4WD/2r7GwIrg0HphTe2IrHXxRe2jme36nsrKmL1nVgBzV42X9snuKMSy6DazmU07ir
	6yqtrmHUIWpf6hxHQyDnXQu7a66fHrSJHSNbJXBoOyAtER8wdeV2NS3kFEDcjC4P0YUXOdXZu4fVi
	3dcjg3Fahw+GUSvjNDLXjIP0Cu2VfzTjYLAGsw3l+LLPKfzlmUO5qOTPsnAnbQL8uGTQyuWoSFKzg
	dwdMppgX5XOnlCOR/n1h/4AZydmJsTrwb2jUWpYOvdTUEYjIEn+4MVIvoDG7m1KVZzp4hu42/JJRF
	4bBn7uRg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Fix rk3399-roc-pc-plus analog audio
Date: Wed, 29 Jul 2026 17:59:01 +0200
Message-ID: <178534073342.533990.16123229159963490732.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717010736.578419-1-festevam@gmail.com>
References: <20260717010736.578419-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 16 Jul 2026 22:07:34 -0300, Fabio Estevam wrote:
> The ES8388 sound card on the rk3399-roc-pc-plus fails to probe because
> i2s1 cannot claim its MCLK pin:
> 
> pinctrl: pin gpio4-0 already requested by ff880000.i2s; cannot claim for ff890000.i2s
> pinctrl: error -EINVAL: pin-128 (ff890000.i2s)
> pinctrl: error -EINVAL: could not request pin 128 (gpio4-0) from group i2s-8ch-mclk-pin
> on device rockchip-pinctrl
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Fix rk3399-roc-pc-plus analog audio
      commit: 4f7259ebe1eba4778768a4f5a0bbbe439d10f3f3
[2/3] arm64: dts: rockchip: Enable wireless on rk3399-roc-pc-plus
      commit: 2dfc88c13fb2db7f17c55f16b679cdfe4ded19c5
[3/3] arm64: dts: rockchip: Keep rk3399-roc-pc-plus work LED on
      commit: b2007873ddfff223bb680c7ff60eaf675670f07a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
