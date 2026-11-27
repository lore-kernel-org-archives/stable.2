Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776711;
	b=lRevum720cILDvgYxBNKfdqJ3QSvCClqWN7/tctftyYjhPt5JEQDb7OFYVcC2p2x+f6c
	 lLZmTl67/7qJc3OIv5Eg81Hq+hxjrIyTH5zZp8sQRVrNQbNB8uRCswl2++1mPlMofkz6p
	 gUicJfOecM5LHQinkpRup4WIWwSfOPaVImxrlPlXYgU+rkleH53YA3J24CSdirbT4DVpE
	 Wlmzx8WAMmmusJnLFxAvrenEvnub34oqKQm3zllESYbWvHWajG5ZIT/FezS/3/ysC5THy
	 UKmpZMENMQVvZpYCX7krCepi7Fdl2XHyVpdeadsru1xykcMDD3QTPgPNeyIl/UKmFpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776711;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qK4OBJuV5NQSXAniRegbhebp0FOPNEyoFinbxRFiOLE=;
	b=myXObQshlvXRzsxcN1686nVylxr5N531U4cnRLsumXzsJgY0pF09OQy3NnxgARBG1Xfc
	 K0FKfYU/x4VEwxuF0lonY/j6oh0wLv3z+lgaUuu+150PJ0q6ArCJ/SLsF4opfT8aWiUoO
	 Tc9pYjZgQGyyf2uM8bM4hOotrqXHFObG0SVFtPKeYcjD0x4wkRENvhdcD3oD+typnAuGO
	 rQeLjRB74wInkl14KchlPRNlqmQRi11ns1K51lbec2gBLHUm3FifoG0vYPqm7ZQyZU5WK
	 y4fSUHfqZnfoX9QwRJ2q6qsDhHrsqL6e1zqKUsK8JBW5EkItTi2ENG+HuPbX8rbDejA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="QNnEL/Zz";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F261606A31F;
	Fri, 27 Nov 2026 10:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F261606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=QNnEL/Zz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795776708;
	bh=GrzzKgpiZ0CLEiwz4+lvImtTNjkiXNEnBTiY1cg7Qwk=;
	h=From:Subject:Date:To:Cc:From;
	b=QNnEL/ZzBe4Z8Az/1bgHDJcjNRzbxDmV0KlsA/cv5kYyh9O4KpxEbtaL2DNnA9sag
	 lGiuL3B1XLiKqt2ypaI0jSNVgRMHCblwOecplgf3XwAkJZ2JSMdHjFKhwLhB34YqFx
	 6azMyRefcBPxRrYrvz2q43+MbkNPpvvNcaYg37wKTgZt8QY6z3jF1OLaBOu3Wy41PY
	 bhYYWFYeoSWAgwntu5zrcCRNnEEWZPyFUiargqEcfvLETNL7OOtI1BsMHYRWMFDlyK
	 4W7hfsZ3NGrUHOIQ6gctGuH0rEAoBiZRl5qM3oPG6D5GhhfkEO71iVLBNC6N5qrUdP
	 ndE7w133hN5hg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4513117E010E;
	Fri, 27 Nov 2026 11:51:48 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0598C48002C; Fri, 27 Nov 2026 11:51:48 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 00/11] arm64: dts: rockchip: USB-C DP AltMode support
Date: Fri, 27 Nov 2026 11:51:37 +0100
Message-Id: <20261127-rockchip-usb-c-dp-altmode-v2-0-77ee78869307@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RhaEMSV9zAs2ukgVaCkBaIh3
 F3AuHX5kv/fmyGwtxzgEs3gebLBum4FeYiAatXdGa1ZGWQsMyFkgt7Rk2rb4xg0EpoeVTO0zjC
 qtKI8OScmTjWs/95zZV+7+1Z+OYz6wTRswm1R2zA4/97jk9h2v072pzMJjDEvCsH6pHUqsyu5p
 lHaeXUk10K5LMsHA0isf9gAAAA=
X-Change-ID: 20261123-rockchip-usb-c-dp-altmode-a4fc7383d04b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Cunhao Lu <1579567540@qq.com>, Chris Morgan <macromorgan@hotmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5239;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=GrzzKgpiZ0CLEiwz4+lvImtTNjkiXNEnBTiY1cg7Qwk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGsJYMM2OyNFfsZ9dBlw1xz5Dj73sgJ59cKMl
 CRG7Cu1rpUezokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJrCWDDAAoJENju1/PI
 O/qaJm8QAJh+BXIB0EbBiiy44EQjXHvd6670a+K14mIeOCkeHHPuZC27t+lahzJbyi21iTSSV2a
 GsZHvyTCDtMGfushFPFggWyFLev9kWLxyyMEHOfKaw5UTP8pCc0LjkQHzvMzrGnF1DYIErT4a9r
 FlMMSHLNnXadBEs2LVCSyr80PhA1Tut9am6ydv9lkI90MDo+nrhJcj68LB34MYcMJG5SohMiUfV
 6ixR68iPe4YH8UTQSRRXQ+7hHIAOv0KoX/wtmpbmB39Go38MBctQP8mY+i9m7IolL9Qw2BtK98j
 jJ/xOTDfEZq0tpC4GGR+QvlWwnSebrAZ3Un7UkmWBGTjgINiM5TxzCaZSu+/fSCAa3NNriJXTge
 1Wlkowx8QruTIGpkUUTiVbpsb/OKfvo6hsOvmArZAbxYLLJiFOhPEwvzUM1vDaEIIVOP3jlW+mS
 nMYIu1QnB66Mn5syAn42TAIpCfVFCzbFk54/TEHBYSrvfwJDurZ6+CEVe/Dy4jtqnzKWUeDLA78
 FBRe4dOO3dK0aq+wdBjmOA7tbSLvWSRBCpy9n0p6wBbgXBYO77K/ddPWJYndGP2YaQW+CQSSO8q
 Db674eCRsceni9YjizJ429Q6vExwPqvmrx1NbxHPo3PqgYKDRklqWctLG8R5m3szWB21WMNAwwu
 BGpJLUKF9vvJ9wwSlFCYonw==
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

Changes in v2:
- Link to v1: https://patch.msgid.link/20261126-rockchip-usb-c-dp-altmode-v1-0-7991eb5bb426@collabora.com
- Add missing DP AltMode in RK3588s Gameforce Ace DT (Sashiko)
- Add missing DP AltMode in RK3588 Jaguar DT (Sashiko)
- Collect Tested-by from Cunhao Lu for LubanCat 5IO patch

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

 .../dts/rockchip/rk3576-anbernic-rg-vita-pro.dts   |  80 +++++++--
 .../boot/dts/rockchip/rk3576-armsom-cm5-io.dts     |  88 ++++++++--
 .../boot/dts/rockchip/rk3576-armsom-sige5.dts      |  78 +++++++--
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  92 +++++++++--
 .../boot/dts/rockchip/rk3588-firefly-itx-3588j.dts |  93 +++++++++--
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     | 182 ++++++++++++++++++---
 .../boot/dts/rockchip/rk3588-lubancat-5io.dts      |  32 ++--
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   |  84 ++++++++--
 .../boot/dts/rockchip/rk3588s-gameforce-ace.dts    |  94 +++++++++--
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  |  33 ++--
 .../arm64/boot/dts/rockchip/rk3588s-lubancat-4.dts |   2 +-
 11 files changed, 722 insertions(+), 136 deletions(-)
---
base-commit: 0202125a80af9dad6d762dfe52572b95ca7699db
change-id: 20261123-rockchip-usb-c-dp-altmode-a4fc7383d04b

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

