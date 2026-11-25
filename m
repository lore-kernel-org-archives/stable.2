Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638091;
	b=uywlq0rGwZBuxVh0PRIl62KRQP4QSKdHvta0FtPNHYTc7vYMSwOiaZb6JzDDJTcar/RE
	 LAc659fBXkTlYXyMYVoHJDRpjbXGUvwbt9egT+A2hrA+o0t9QAQSbY9H+EzEOeYkts9BN
	 H6LJaXLsEEeTA8Ly5NjNQWo7TJpP8QeNQHD/a3+zGUy1kE3gbKaEvNYgfDFCUdJTu4Q+f
	 pbGC2Y9BgJS9PyRulvREEADR5vLLa8fzO3AbgcUgyt+WICEqRdyBFZjWZ8vaI5kThESWQ
	 co1iq8A8rshpHDueZ7m4jB5fm9podpocYxElwJu9Hs9El5UC8ueCAUYZdqqyFr3uq6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638091;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AE/wzhThT744Ehg7OqHssiTU1Rv91pn1FajB72yyO10=;
	b=B++mRyErD2w9ybdsjmp0DIaL68J45kl2Zf/z9XGwR6R151SncMggg3gI27xdFn39xnU1
	 DjPQXjo7pUloEcV48Oy5b18A1weRuigFvOQkTEv2M9D6pSOKVvp0dFfrM4uteLYWVQ4r0
	 y4SeWDZ5ocVEIaQrPD/MiKfrGh21vexZ2lkg0B6jFN2jYbgoUS9uJPgU6JZZU1m6E1CcK
	 qwaEGxl35a/8/jddwjFcj/o3mwzA+Wj1aUfw2Vj7r95+NAkKuehE21bDL1tIjLXLVlVaY
	 J/D31ZjPU6TiJszyIfYPErB8xpRNZLg18fOricoRn6GTCp4VasDSc7g5FKHTKMecsyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=I1vtHIVQ;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61A606A32E;
	Wed, 25 Nov 2026 20:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E61A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=I1vtHIVQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=AE/wzhThT744Ehg7OqHssiTU1Rv91pn1FajB72yyO10=; b=I1vtHIVQSiSLSL2zq/c+V5J0x2
	f67cihlOJIHb8zJdc4fPWvrRhFxrRZaN4gMbveyDN6PGvul6xZLwV4s0g5dyec0Li8urjyYcoiouX
	OMI/YPDjH++kgN0q8pn7FFiRmyb5Z8hgucz3ubuKgYFSe0fZrr3YGz6WcH2ekomtCdAy6DHkJt0l6
	OYp3DPawIBCyvdRKQS2AQNM9oFqnIcei2OZQlywpD/FccOe56ordVioyDrpoViNm1BUoPhVRJ4va6
	Vps/IsvCA6KOGOz/cTrraYm7kD1Ak69mmjhN7fIbYzC4nkA9Y0UM0CCk0ZqQPqU12wYxcxAiGnLZk
	NlHULMxg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tim Surber <me@timsurber.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Valentin=20H=C4=83loiu?= <valentin.haloiu@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix HDMI RX 5V detection pin on CM3588 NAS
Date: Wed, 25 Nov 2026 21:21:02 +0100
Message-ID: <179563805243.3885553.17543172613899587160.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118024718.1540336-1-me@timsurber.de>
References: <20261118024718.1540336-1-me@timsurber.de>
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
Content-Transfer-Encoding: 8bit


On Wed, 18 Nov 2026 03:47:15 +0100, Tim Surber wrote:
> The HDMI receiver node uses GPIO3_D4 both as the receiver's HPD output
> (hdmim1_rx_hpdin) and as its 5V detection input (hpd-gpios and the
> hdmirx_hpd pin group). The GPIO setting wins, so the receiver can never
> drive HPD. Sources then see HPD asserted all the time, may read the EDID
> while the driver is writing it, and never notice EDID updates.
> 
> FriendlyElec's vendor device tree for the CM3588 uses GPIO1_D5, active
> low, for the 5V detection [1]. Use that pin and leave GPIO3_D4 to the
> HPD function. Tested on a CM3588 NAS with HDMI0 looped back into HDMI RX.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix HDMI RX 5V detection pin on CM3588 NAS
      commit: d7db59f605810f37a625d106e2a04c985fcc3e6e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
