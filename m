Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283003;
	b=bmyKNCebutFuvCmmfgAbh3uHgnOod8PHk91NHajnakkWYnPDgcwt/dHdXAdQI3+zlgJq
	 /319XpKFyyNA7UvW15FwMXXfwLvNwjIt5n6RqhalbFZuHuQMIkYcW2bDMvSdlu+n1t3YT
	 IIZa2oJ9vMxVCIjo+/HlteLoiYepcd0i2VtQv7YwZtpUJTG7BU9ahifqngm3tJHHFPA/p
	 6gQsj1yJKpTwaSOM2LuCYoP5JUNuvBXPrmdvAualkKQhtGPazRjIl12NriXKd5eOTOmrK
	 DwIaDbzYpVveAnFNXOUoY4zAOKymr3J7J0kjVrX28bW+NfdPPdpVuemYnEf7MI/UpZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283003;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VZXNRW+cKea1EVRo3ETF1f7+1j624i4RqMAaOHXf7qI=;
	b=YLm7LUZ/YsryiHZrGk2wGcSQTrN5xh3QvbTeEuLO5LMHs9N8Aqx14Bven6IMboW0dbBK
	 B+DTKRo8FGnzvmN/MEbbrZns/BAmHl+2vIjPdXlaC3PzzrmhVPHRUTsrspEkdxWz67YRC
	 K5K+fIYc9zRGRCICAvRoyIBSxpMh7Sb7prQ2nCXH5kceFtbAaVtKHXWngRclcCwW9JmDQ
	 NkRxeGfcZ9dwqH2r7+rjoU16+oZIkvXOhQ+RoYYFEC4MfbYeIjtgWy7D+aHNkZbhlvEVI
	 gJnuGW4cs7/obXHRIO1rDU3kx4tcCvq9dbt6gMciAg6XydEFSIfVEA8ZOukkIdVqW1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PED++M/d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093F606A331;
	Tue, 10 Nov 2026 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PED++M/d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794283003;
	b=G6vBdmnW+16LRfDenE6Iz7Tjiayo7bd1gatdlFOvgMh+x0dleFNDR9fNAUBSz1FODPuu
	 GiPDstvjRFvsQaamzrdWjFtcONITsmQ5wEsWHpr6KeXzqekIHDReafR13t81OpnQTw5MI
	 0W4K4T9X6uk3kTKVDf5WYU0+OzI7XgU0zwgb2YW+Y/xba1UvW8oGitQmUo7Fgjq00f82C
	 Av4yCBOR1vdLG9yH44oECsCoBbV+EAxOqs+TtP0wyeYzMcP0ThRLU3L2M8ZRcac25Weg8
	 /aM/F6ueWGdZqzyqrm8yX8tOrrJhxWoQyEGQBAD/8bNpV7eqfyjzp1WQaG0bhw7+5Sg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794283003;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VZXNRW+cKea1EVRo3ETF1f7+1j624i4RqMAaOHXf7qI=;
	b=GvMvViUxItGLL07YLLWmshRp9wgZwXPDUg2QKAQOCQ7FjhHmqtBFBkdA4+GQo0S+QQk1
	 /IGqDvEZputozB2T/xC5fgnrs0i6A2lSMb+lShMsxiRFtmY+pErEGJyPi/GAldAQ7o4ln
	 T11tekXSm4keV5GjaaX61hnT6hV0sgIyU7o/6AngynwalRBd477ixoh227vPQdO2meSJ1
	 B0Hwu0MiZpK3Lc96FhTLRh+UQZ41VW3rLoRF2Cqy+cH7ZOPTI28KT7Y31jTWtxWYyqRHy
	 +MQqw0fBXY1T6VcYfDfIdDxs3B9os3N4Vwnw7J0msreMUWCM8Jzgh9pA7MLLBoK6vsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 874401F0089F;
	Tue, 10 Nov 2026 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283003;
	bh=VZXNRW+cKea1EVRo3ETF1f7+1j624i4RqMAaOHXf7qI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=PED++M/dpCIPdybyJkt7OmJuVvMvtcfVtcyihbDH5n+26ENeyK1dOHzcDM53HUyoD
	 Qif8LSD1+2/amCS+3OJI/9BhyxG6+lEhhYmY/Zp/x3UN4IG0VefHyqvxrdhoU+ZRxn
	 6anSLGfaQquaZF5yKcgHejV/isO1gRZoagsSO/aArdF06X3xb6KD2+VdebFSuww2k+
	 CcuqgXB/OutpzyCXexz1aG9inn75L2tpu1JQ+x/pIP0QjwASH9HQ7CxnRoXX7/rJbo
	 qdisfP0uKdPSo51CohnKeppVoNBV/xkFJKMou5ehQQK/SzfYi7B/YiPcR3PyFcrgpN
	 Y9hyn4lXFAsGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 138BB487D7;
	Tue, 10 Nov 2026 03:56:42 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Subject: [PATCH 0/2] can: kvaser_usb: validate values received from the
 device
Date: Tue, 10 Nov 2026 03:56:41 +0000
Message-Id: <20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAPmV8moC/x3MTQqAIBBA4avIrBvwJ1p0lWihNtVQWGhJEN49a
 fkW33shUWRK0IsXImVOfIQaqhHgVxsWQp5qg5a6U0pJ3LKtBO/kMNudJ3sRGuM1mdZ1xs1Q5Rl
 p5ue/DmMpH243goJlAAAA
To: mkl@pengutronix.de, mailhol@kernel.org, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794283001; l=1136;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=EPk1ni/Kaeh4ujfokyWdtrgUBNNRLNvf/WMEh31WoiY=;
 b=nkNiEMfXBkaVQ/nlluzDvnFqTBmhnBLKAMCzqrXuFqIE/imjRTn1LgKkuRcSHdQhGvzcbuHrE
 jdVyAqsUB13BICwH3ukTIUxgLf0vob/yTcOIz8AX/cl3KEUxgnS7uqE
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com

Two fixes for values that kvaser_usb takes from the USB device without
checking them.

Patch 1 rejects hydra commands whose length is shorter than the command
header, which otherwise stall the command loops.

Patch 2 rejects devices that report zero max outstanding tx, which
otherwise leads to a division by zero.

These issues were found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fixes myself.  They are build-tested only (W=1, arm64); I
do not have the hardware to test them at runtime.

---
Joas Antonio dos Santos (2):
      can: kvaser_usb: hydra: reject commands shorter than the header
      can: kvaser_usb: reject devices reporting zero max outstanding tx

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  | 6 ++++++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-kvaser-usb-validate-33c2e34b63bf

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


