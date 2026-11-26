Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655738;
	b=OsLs68iWqJEnWmIEcQGvnYKcusGuG9aOOcil3cAOj6xQ5/hUP2sqPX8GQbYzquefSdg4
	 cKbEgmHP6PNEoWhMo6oysMwiEIQWAay+2fYuR2+5Pr8J8ydBhbUULiKHhXfvW3fJWYgfN
	 rhtCd+aAfmyjok7+ElJ8eAF33Bh9T4stP34Ces0UaJcSe3Euqor7s7kHg7McnrGWUgXFR
	 KtVWjJT5uLlEng0d8AgqddHmORSqiyHwzEryR+ciZFlDUKiJyiW0dUAmo2Hq9L+P3RaRz
	 AZDNkzPZUFb51JN6LZxqzV7ads3gB7VXu+kQwAFmSp6mlrHUyVOzU1hv9vwUWmrtdEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655738;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SSDdFJ7sJss0giD8utWY8uC3jQgIxW14BCHHjBxbRjs=;
	b=p+9VuoBzvt2BcnDiWXKtoPfgVHqALHQZRxUJurDFcHEUg0r3V++XvQdPV4ghzC2Yeuzl
	 e7dFZQd1LojWLmujxB38yY4bpwJbl3EvM/t3T7fUKP1t5HlY4jDZBxagTQ7Z6KJvvyLxq
	 s2V8PHEyFOxcH2YbLT2Tbw2aDNaMPOV7agOqblBg6PqRQO9LP8NYgsH4Wj/T7uOv8XK+d
	 zZye6O394PXzD+fnukk7FNc037po/qQtraZ1vHxTu7FeU9gZnd0Q4uuuJ2qssBIZl6KRW
	 +2njB3yA0FeNMWPcP89UHa95NXJDGxOelWu+4hUBgnL737ZP97TzZst7cbRf4VtvtxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mi13aAHT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD31606A33B;
	Thu, 26 Nov 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD31606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mi13aAHT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795655734;
	bh=MVULC1jpHJl/MMSAgxtWAG//qVzBXMEb17STRrwVyoM=;
	h=From:Subject:Date:To:Cc:From;
	b=mi13aAHTCjRoEVh8ej3Ac0TWsDFxPpd+9pTZeQwcvUoQAIVK4qtxjt1B7IpY2A9/y
	 6WRzlFqSycYmhma9Giwbxlm9lbsVeRceB7OyaLX0ID7KfGOWzQ9o0/BNawNDqZSMXu
	 ReZSmN/fnq5rv9ETPWK1Swrw1Aj4kWAbPUecXRQVi2IUbEoDruDRPgq02wcH5/Nu+i
	 qQ16NuTA8K4tuuUVaJOht/05vbIE5fYl8KG4bQ7vbDcF6VafJ8vli8jMZSKDXqSunS
	 6pRKa1xFC3MLNyg7hVNA8LrbcWZK6o04nxrgOYlp2ujZxnfenCzEFGN2/GYcW60OQd
	 FMoW5cGEy35ow==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 11F0117E0EBF;
	Thu, 26 Nov 2026 02:15:34 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id BDCAD48002C; Thu, 26 Nov 2026 02:15:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 00/11] arm64: dts: rockchip: USB-C DP AltMode support
Date: Thu, 26 Nov 2026 02:14:28 +0100
Message-Id: <20261126-rockchip-usb-c-dp-altmode-v1-0-7991eb5bb426@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJbYkar2JctNNBxh/adMCYE
 O5OxeW3eG8B5SKscGkWKPwRlTRWmEMDNPjxziixGmxrj8ZYhyXRkwbJOGtAwpjRv6Z3ioy+6+n
 kzi62XYDa58K9fPf39fa3zuHBNP2GsK4b+ujGGn0AAAA=
X-Change-ID: 20261123-rockchip-usb-c-dp-altmode-a4fc7383d04b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Cunhao Lu <1579567540@qq.com>, Chris Morgan <macromorgan@hotmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4940;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=MVULC1jpHJl/MMSAgxtWAG//qVzBXMEb17STRrwVyoM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGsHiC14OQxnltH4d9sVVk6Ncx/BhGNE3x5TW
 RXZHxX82V0OpYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJrB4gtAAoJENju1/PI
 O/qaNtAQAIQZGXI95Gm2bBHXDzBu36eiou684EpXnXBH0xN/k5ATj9bP0l9T1YWNTkZQI/eIMfE
 L1Qtsgf6Y4vrXsl5FlJFSFHTU/2Ynw8HNNEo+mesbcDyTxcCy9TGN+9H/wQTQ2qJUxnjGONY7Pl
 tB1d/zGvyb3xfahe7qs0hwiG6e51d5LmXt+YBzSAQHuMyQaotbW01EnIsElAn8BL2Nu8Ak0CuxQ
 B24jI/pegKPVzYKe3GhIB6h7wQPMmWwlQoACZn2aa866xz08GkxFU1QAtdJjNhvW8coQTRpjYaC
 wljwo5xll/DAU/cPVsu39LY1WVlMaAMLzcfRlTQBbG82KKlqwLbxPQyu9FqKCiKE5Y+Bbbh0GAP
 QcE+0UdDkgz2FRQt+yID0Y/WE7dkRZkFHMi593UIpmEYvseQDxA0hT5EsSmq/VdCW8njr6366lq
 ErkJAHghuXJe1tuTkpVo6KOxjlw1WuFlz0H9ICt57qEJDCrhFlTTJImVn1M1ZLQ6Kwv37ZStqCR
 q+EMRkonjzAkbN8NwJMcym6JOIr6pifCfJF5quwTh2P08gVZj+fBdrHukTMUp1wykxYpkb+rdve
 myozIye7x5JcXhfCfQ0fIL1XYjyg9fZY6n/wtKdHmmj7xeC8zkh7ZFg06UuAnAmbH+HjA3ODJ+A
 uZyxkCUe79z43+BP5QkYotg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The current upstream situation for Rockchip USB-C is quite messy. Many
boards got upstreamed using the vendor-style bindings, a missunderstood
version of the upstream binding (before it landed upstream), or
something weird in between. This fixes the worst offenders to properly
describe their USB-C port incl. DP AltMode. Getting DP AltMode working
requires three more patch series for the kernel, which do not affect the
DT binding (so this series has no dependencies):

 * https://lore.kernel.org/linux-phy/20261114-b4-rockchip-dwc3-rockchip-glue-v19-0-b79fb5f4b42a@collabora.com/
 * https://lore.kernel.org/linux-phy/20261119-b4-rockchip-usbdp-cleanup-part3-v18-0-fb325e336494@collabora.com/
 * https://lore.kernel.org/dri-devel/20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com/

Without these driver patches, the DP connectors will be exposed, but
always stay in a disconnected state. This works because the existing
upstream DP driver does not yet support any follow-up bridges.

To have functional DP AltMode Anbernic RG Vita Pro in addition also
needs support for generic USB Type-C DP HPD bridge from Chaoyi Chen, as
the "richtek,rt1711h" driver does not have a manually registered one:

 * https://lore.kernel.org/linux-rockchip/20261020072816.180-1-kernel@airkyi.com/

The other boards all use fusb302 and that driver registers the bridge
manually. Having the generic patch series is not necessary for them.

All patches from the series can be applied individually and the grouping
was only done as they touch the same topic and apply to the same tree.

Short summary of the different patches:

patch 1: Fix VDO from 0xffffffff to 0x00001c46; the incorrect 0xffffffff
is used by vendor kernel and has been copied by everyone.

patches 2-3: LubanCat 5IO + Indiedroid Nova tried to follow the upstream
style, but got it quite wrong as all endpoints in USBDP are routed to
the first port instead of having one port per endpoint. I did not test
them due to lack of boards.

patches 4-6: RK3588 EVB1, ROCK 5B+ and Sige5: These boards were tested
by me. They are the reference used during development of the previously
mentioned driver support series.

patches 7-9: These boards had DP AltMode described in DT to some degree,
but with all kind of issues that definetly prevent them from working. I
converted them over to a proper description instead of having the
current half-baked upstream state. I did not test them due to lack of
boards.

patches 10-11: I had a closer look at the DT of these boards, since they
had a orientation-switch, but no mode-switch in the USBDP PHY. I'm
investigating, if we can make it mandatory in the binding to have either
both or none of the properties. For these two boards, mode-switch is
actually required for DP AltMode. Upstream never had properly working
orientation-switch only mode either (i.e. runtime orientation switch
change does not work). I've added proper DP AltMode for these and added
the missing mode-switch. I did not test these either due to lack of
boards.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (11):
      arm64: dts: rockchip: Fix USB-C DP AltMode vdo
      arm64: dts: rockchip: Fix USBDP ports for LubanCat 5IO board
      arm64: dts: rockchip: Fix USBDP ports for Indiedroid Nova
      arm64: dts: rockchip: Add USB-C DP AltMode for RK3588 EVB1
      arm64: dts: rockchip: Add USB-C DP AltMode for ROCK 5B family
      arm64: dts: rockchip: Add USB-C DP AltMode for ArmSom Sige5
      arm64: dts: rockchip: Add USB-C DP AltMode for Gameforce Ace
      arm64: dts: rockchip: Add USB-C DP AltMode for RG-Vita-Pro
      arm64: dts: rockchip: Add USB-C DP AltMode for CM5-IO
      arm64: dts: rockchip: Add USB-C DP AltMode for Firefly ITX 3588J
      arm64: dts: rockchip: Add USB-C DP AltMode for  RK3588 Jaguar

 .../dts/rockchip/rk3576-anbernic-rg-vita-pro.dts   |  80 ++++++++--
 .../boot/dts/rockchip/rk3576-armsom-cm5-io.dts     |  88 +++++++++--
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      |  78 ++++++++--
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  92 +++++++++--
 .../boot/dts/rockchip/rk3588-firefly-itx-3588j.dts |  93 ++++++++++--
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     | 168 ++++++++++++++++++---
 .../boot/dts/rockchip/rk3588-lubancat-5io.dts      |  32 ++--
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   |  84 +++++++++--
 .../boot/dts/rockchip/rk3588s-gameforce-ace.dts    |  87 +++++++++--
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  |  33 ++--
 .../arm64/boot/dts/rockchip/rk3588s-lubancat-4.dts |   2 +-
 11 files changed, 701 insertions(+), 136 deletions(-)
---
base-commit: 8872b4a4ec35378bacbf515aba5465a91a856d6f
change-id: 20261123-rockchip-usb-c-dp-altmode-a4fc7383d04b

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

