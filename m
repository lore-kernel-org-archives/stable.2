Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571353;
	b=oW8iSLYHE0RKicn81PmAsV5cCAEv8WwZOusDQqRHNE40T2YzSan5GIP5h6KI4lJAQKKg
	 JGwqg2qhKbCU/30PkOfQqCuJNMqCXHFVP19NXh7SSeWoZioTWI26kHLMl+ay673haxBLX
	 voNRHaor1zkHCpeolyz8yVFUgQaBgRCi7+90CI0S2Tcn6woBHpmAP/hDSA65QPhW3pbqD
	 8pIUImkSe1WflEEiSVxzGFj4rzL1q9sUQDPbu+W9BPPMf1KncKeBksVe3ch6PbCnme/BN
	 fi/t+nlZV3SNrz6qEny2i9z4lK0J6/YfQSQOUZUgghA6Qio9sh3AdaDWt/CfO5kyf6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571353;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dzHxCP/qlD9U2Pnz2CYx8W1+O2sBTItyxz8i84HwCSk=;
	b=J5Pv9jkEBsdwo1+gE9cuv8m0UwJKvhBAkpiQknFKEvkBa8/+N/JcoSIHcONoQxGQ8fCb
	 0Q6qZCYKTmclS7MjYZBk1MbC4Ud75HAPrk2R22+6hNPD3MePpJ7r082SxJOv7dufXhJBF
	 6D7WasSNbsPBXZUoZ6Gm5qkq1IpfqdTCIbs2Ter5EJZjKjNOI4lOr9l8aSL0svHzZjRcr
	 GBgedxby3lgj2odDqgo1gLNbfe2VenF1tO27Dj5mKbULRLUDbjmyWliJHFqgLRJKHbBY9
	 m/WHLtS8s1aADP7Iamdi5d0Y0vIoKWMvud8/uR6zAYwMcP8s/S0rI1/REAjtxxhclAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=i5d2cbhq;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58760A2603;
	Sun,  1 Nov 2026 22:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D58760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=i5d2cbhq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=dzHxCP/qlD9U2Pnz2CYx8W1+O2sBTItyxz8i84HwCSk=; b=i5d2cbhq02cEiFA3UdTTb0AY1q
	0Llb1mDrR9x6zaFxdqunHTec4sA/W7RR35xBlTxiCxWNWNQUelPcrb1tLVsF3SeGx3X9bz2xNs1TZ
	Zkdel6DtXGM7lZY2KHBfo6GFDnpL9g6BiGJowo3OpMVTkigQYTM7Adk/lUt+LfRNz1Ecp0bYTX5rp
	7lDyco/nl2rP+NQ9+x6P+g5M+EtCyeiK9WFEJ5wHkMjsYG+ZDr0Trs4uFRtFt1tfItfZM5BlIii6w
	NJvou2MDY7gErqc76cmtcrL5KTlHRWB6age/1B2K+E4fPisTdpNHTIU8pay0J8IDW8iX6s0QRbUkL
	ZB3f15ag==;
From: Heiko Stuebner <heiko@sntech.de>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix hym8563 interrupt pin on Orange Pi 5 Plus
Date: Sun,  1 Nov 2026 23:15:29 +0100
Message-ID: <179357131393.4107717.8550224711242554057.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908111908.19371-1-royalnet026@gmail.com>
References: <20260908111908.19371-1-royalnet026@gmail.com>
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


On Tue, 08 Sep 2026 13:19:08 +0200, Igor Paunovic wrote:
> The interrupt line of the hym8563 RTC on the Orange Pi 5 Plus is routed
> to GPIO0_C6, not GPIO0_B0. The vendor device tree uses RK_PC6 for this
> pin; the mainline board file uses RK_PB0, which does not carry the RTC
> interrupt on this board.
> 
> As a result the alarm interrupt never reaches the SoC, so the RTC alarm
> cannot be used as a wakeup source on this board.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix hym8563 interrupt pin on Orange Pi 5 Plus
      commit: dc963c9ec182ec24f0b10f11fe377db00528f7a8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
