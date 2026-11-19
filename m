Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093411;
	b=UrE26SHhP2Q1JBJvjWMRX5kTFJ0wbVheRl7x46sOYWdSVri7aMMgSK4NTKwqANYDMCLT
	 yccATf/H4iYAC5gbGylmakEQ8hoSTHjrfslV0Z+Ga08gVP/H1mSshqTilMNrmx3gSFFxR
	 Zd7oixebTpAQeZlr+h1EJ+vGmAmGsMy3qdXB0Sf0LIkyJXFWQVlq/Rlh7GTL16xrXYVre
	 JWqZMf2bFX2L8tOrZuQH3sLc8xJVHqJqNVn3e9mQGijwYL+DqOILEchdP6OTx8Q2rqJqf
	 ztkP21O21/FltXv8Q0qBNgZHXJv3CNSeAvQQQ1fHvtHXMUH6hfBIdVIedc01LKuU1/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093411;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=j50qeo7+7H5R+nKfOu8rA+1h5BbW5vTqhKtlNRyMzhc=;
	b=SR/DY9fQCGYa0TmSkPAudX0U093Qysk8OIsIjiwvQ5FrZ8CVp9Q6PCsXMOL6NE6YJURw
	 ZH2O3zbe/Ue1jH1le/xFfYC/7ZB9zM+C5zpiVPoPKY1nElZvrzv8nyoJfD8RzKEJ+YWTj
	 4vDa27PzoOuW/vnwNtdvZKZeIMYFp1lbK5XrLRBuO5B6IT86VWgBcw5QzmUa/b4nu+X+Z
	 CwQAGYBzlvjJ9/fFA9DoLTfu1e5uSAMMGyS6nKdjzBdt9abhRWbNGLO66vKUV7Hw1llvi
	 WjnRcK0nGfgHzdOK+MNm2otvoHJGOjDLLcsorimQzQ3aJITINIRmO9CjCrjykvXbrsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Y7BqJSoJ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44858606A32A;
	Thu, 19 Nov 2026 13:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44858606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Y7BqJSoJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=nxmeA4mtNSZ0clCsHWnlplVqVoOTDWFcgcE0wBWlVWw=;
	h=From:Subject:Date:To:Cc:From;
	b=Y7BqJSoJO/Nno8fElofOBRkIfRKLlutw/D5W2KELXReMpmOwjd37GJsdZ95J7DCVX
	 ErrvTCOd7FZdRtsj73EjktHWNHaYWeZOQv4Q0jR9/2vF9eyOPih/DdtwAtunRhN38Y
	 4D4/1BuwiheCnGQZbo0ZQgVGryRg5UJev4giimsn4j+2VFts8fSILp5OGu0nZgbzMG
	 0DcsvfbzMQTqg29p2aAwIk0K4TBoLIoL3L83poFN5EoxgcLXvuFRo7oGt+bapABqMF
	 BgIbX11ozaoFmZHFCDxPYzYlJClSoQVzBH5g7sdVj+N6EZloiEENFRPWX14DW1vjbd
	 nFSUT2/8vLIMA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D471F17E0406;
	Thu, 19 Nov 2026 14:03:22 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8E83D48002C; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 00/11] PM / devfreq: rockchip-dfi: cleanups and RK3576
 support
Date: Thu, 19 Nov 2026 14:01:50 +0100
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OSw6CMBiEr0K69jf0QYuuvIdhUfqQCrZNC0RDu
 LuAN3D5TSbzzYKySc5kdC0WlMzssgt+A3YqkOqkfxhwemNESsIxxgJSUL3qXARtHaSeVnUNajD
 STzGD9PrIBIc8xRjSCIIJIjRnWpAL2lZjMta9D+O9+XGe2qdR467ZG53LY0if49JM997/9plCC
 ZRYiyvG29KwmwrDINuQ5FmFF2rWdf0CXM8ejAQBAAA=
X-Change-ID: 20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-74727d64d729
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=nxmeA4mtNSZ0clCsHWnlplVqVoOTDWFcgcE0wBWlVWw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85pb7hvmL+6vJy7jrGoh3OyZedy2p6yzc
 /Ad3gYBY+nsFokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qa/GYP/j5cae6aFj3rtw1N8LipoThw8puXXG0hlXTTBCbzF44PCDHf2FWQxMNOcCaakTuc4LN
 rguI+AbQl1mhPdtentR62zirPqko1+bgQtuXlh/Cq3rncc/6tZcKNKbYUTo+XCq3M/3UR1cu3s2
 aVBa3+vp0aLL0W/NFeN6qFpkL+YHTNnS85OdYN5bVLKPxIiQiktSbq1Nz499du4Yq6u9xULyekG
 BNRBAWc48uNzTSJ1mZOJk2LKZx6f5B4K9d9cMRIv1m7Np4Fva0Q6eQHgkXiQkYVA13zHmyikkie
 7G9QSDhbWPNXnjcT4bh4KkF7UVnRXGrPSILMBBGZRrYoqSkwAvLuhvX2Cfqg3mNs0+m6nvsIPAb
 nYBu6d7tfLzI1GqL3KX6QHtvS9IS3UyduMvo8IaZpX63yy3fcfxpE+7+zRd9cTPHQWaJq28j7Ua
 IjaweT0XTVt79m8C4w/sY26c0ll5BlymHF1ApBvD0gIsG/rS6lsPXsKjUJxk594Jeq4tESCDSUj
 Iia+HRajKDPWsyfGEKStvDZGZI4mcd30fJNi/4rN7qJhofa23VbYW0qx/jtaWowiwOI9lyhvaH1
 LpExnap/+U5wqqCPU93z59fBSlJrkowIt1TQrNruSGF3yR8fS+lfW7V87s1i4oFvZzBJjbqaz5o
 pjeklEDcvbefHneCwKFs/3A==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This is a combination of the DFI driver patches from the following two
series to ease applying to devfreq tree. It is based on devfreq-next
and there are no other dependencies.

 * https://lore.kernel.org/linux-rockchip/20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com/
 * https://lore.kernel.org/linux-rockchip/20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com/

Changes in PATCHv4:
 * Link to v3: https://patch.msgid.link/20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com
 * In PATCHv3 I accidentally used the patches from PATCHv1 as base with
   the wrong DT bindings; this is now fixed
 * I've fixed num_clks typo in kernel doc (Sashiko)
 * I've fixed incorrect LPDDR5 BANK_MODE_MASK for RK3576 (Sashiko)
 * I added a fix at the start of the series correcting LPDDR5 bank
   mode value (Sashiko)
 * I've added a fix at the start of the series avoiding usage of
   uninitialized memory (Sashiko)

Changes in PATCHv3:
 * split out DFI driver patches from both series and merge them into a
   new one; clock controller and DT patches will be sent separately.
 * rebase to devfreq-next
 * collecting Reviewed-by / Acked-by

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Nicolas Frattaroli (6):
      dt-bindings: devfreq: event: rockchip,dfi: add clocks to rk3588
      dt-bindings: devfreq: event: rockchip,dfi: add rk3576
      PM / devfreq: rockchip-dfi: move to per-variant const structs
      PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf capability
      PM / devfreq: rockchip-dfi: use bulk clock APIs
      PM / devfreq: rockchip-dfi: make RK3588 use its clocks

Sebastian Reichel (5):
      PM / devfreq: rockchip-dfi: drop incorrect shift of LP5 bank mode
      PM / devfreq: rockchip-dfi: initialize dmc_count structs
      PM / devfreq: rockchip-dfi: move register offsets to variant struct
      PM / devfreq: rockchip-dfi: prepare support for v4 DDRMON
      PM / devfreq: rockchip-dfi: add RK3576 support

 .../bindings/devfreq/event/rockchip,dfi.yaml       |  89 +++++-
 drivers/devfreq/event/rockchip-dfi.c               | 297 +++++++++++++++------
 2 files changed, 290 insertions(+), 96 deletions(-)
---
base-commit: f9316c13d6f621af4f6f4a6089d3c989ffe899e6
change-id: 20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-74727d64d729

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

