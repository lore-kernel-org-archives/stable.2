Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793040325;
	b=c9j69EJOmM9Wo7+0UlB+JbcBCWH1iEzdE86ML0d3GjstVw6zsfOY/8b7pNyyfNi1uQB4
	 t7OtXilOx+E8I0TRnb2UobiA03BG/PJRkBsCPc9l4pMZUHL0NU6HqSZqjFZ9AtCAkJdTJ
	 0ZNYExESpk3I9U3DSAjcl3Y8xHKv0NAqYYXJcCexkzCqzgjfm7ZGG4dDO3EbAdW63Mcme
	 I35HxK5pFbxvQb7m52RxeEYvn/XRFPLbIPrQjo01NrkAWOHgH/Vs43PbUnUJWEs+o6ZgT
	 zPe+Kkq7M0hKJKZCjwymuT1I6DUUQeCmufHMromT360tcUWdq7hV4TOibcqOdDdvBlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=XHbiiewkR+mN1W61HItkm2X7FsNUNH6KlltcmHLisPE=;
	b=UfyN56PNspIRY12WCJKX6/tRGs5KrETQjlvkP1mlZixP0ZDLLK4slsPAjiUqrHkwdPcm
	 mX1Uw/p/882sPymb9GnDqHIy+pVA1QoJ5p+vcRcuRIRpTuPi9r5gEsFT4MmSL2x6gT3o4
	 sN5P2eA1UMpF2P3KMY0m0mjOub8Ux8psvC+jhhXqtXEAWTi7Iy1Chnz3xzpi/TOpMCbLb
	 vhjVvIp7oxq4/3+UIfDwaacdoSVguaoJzN0+EFVREgept4or1bxGATjZydnJ1IBJmJUgN
	 6i2nEudfz70NJ9igQobUT7RBpnDXw+6VRspigTDHydVtymv94xTxk44Azr+gxa3Uo/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CAdQhR5Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C7606A31E;
	Mon, 26 Oct 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9C7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CAdQhR5Y
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D843D200F75;
	Mon, 26 Oct 2026 19:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XHbiiewkR+mN1W61HItkm2X7FsNUNH6KlltcmHLisPE=;
	b=CAdQhR5YGY7OfyIVfPbSPioladeDBlJOc3x3+sKtYh9sQv+f7w8QjGR11C5+w9Je06l075
	jcJyVnfWXdDjvL3v0Td9zkAqjHY/tTHX5Po/1DuO2uEFAgsn3tY05G6qFQpVVLpkGY5iQC
	4PouBryRzlKkFTh+nQcf95AEIfJq57wA5WVO/9U3ZJs06KmRqlCnogXp1OrEzw4IFOk1ra
	xxl1y86NB1k58MKjjPmNFypJsfHX7MgfTy5CnWI0a67zKtEqKoJcdLD7jSLEuDixtPDytV
	8GTLWd8CUpVIDyDQKWXzbaXqZS63LZKARu0YyU0BtbLYsZZC2CTEeyJloZnZLw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793040317; a=rsa-sha256;
	cv=none;
	b=C2E5LGVHb1smNyA2trEvsrEkCbfOvocmm9BGUqzqU7Jeo+GcruobuqLRIHoJCdPvaXKQF4
	FgidYQIfwuH9U+WDRlGiLxwa5BG6qqjTeqTwddLEex1TvYPmUwNEXZwS2vxYRQWf/Oq60I
	mLDydKN7ZEH7zdJODNch2ChytDAU0g07Vr2tqTknDegneEzuf5Rpkwpt3R/N+8wuvprzH9
	jGjjEwa36j/2g0sslv9M2/kZTB20UGtyvYtp1/M01pSYpa/TgaLj3OubkezT50KHxwF+Th
	vs4FXUghuhYDwjs9TTtpXLi36GTmOuJyOLG7c4m7+8+jV5RLOldrg7E5MZ0Z8Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793040317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XHbiiewkR+mN1W61HItkm2X7FsNUNH6KlltcmHLisPE=;
	b=U5mv+tv7pJNHd14erDPYGR/CddwYXYrjES0xLaLkKqScDvzUoynziufGoOscNexcK890Ta
	Z3+fDFbuECiNqRmDVYWAgmAHdljZibi8s8mnTUtJt7/yAc6ZMBxOAAa9pfrMkkpI6w3tPb
	R+1EMCGBY7Di1puvvqwbmgZHvp9wW9ZTdPlOLLyRFgDfqZXR+lLEzpcOXVDb/0iYD/NcUi
	u7uJtG2fgEobRq9locGW/yc0NQhzgG2uF00BUp2E+HSkeZiEwD6/rRh1EUUkrTUu+Ut/Qk
	ZC/dW/5/4XA8gncoG2jIt+LbpU82w5zmjvrwZEpOsE2QF7GI3+0rCjk3qfx4cQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLPh7-001JyN-2W;
	Mon, 26 Oct 2026 19:45:17 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 647305D7285;
	Mon, 26 Oct 2026 18:45:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 0/4] gs_usb: fixes
Date: Mon, 26 Oct 2026 19:45:05 +0100
Message-Id: <20261026-gs_usb-fixes-v4-0-59e3b6360053@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QQW7DIBAF0KtYrEsLjMFuVrlHVEVgBodKxilgy
 1WUuwfHm6pNuvxi/kMzF5IwekxkV11IxNknP4YS6peKdCcdeqTelkwEE4ozIWmfjlMy1PkFExW
 SOWhbAM4aUirniPeH0jh8bDlN5hO7vBrrxMmnPMbv+38zX+ee0DOnjLqmRmNsbTWo/RlDP+U4B
 r+8WiSrP4v/BFEECdLWkr03rhEPBfgpqF8CFAG0ah13SrQc/gjXbcmIX1M5Xd42J0YnpN04DD7
 vqoCZBlzy26B9KI3rDZQrgV90AQAA
X-Change-ID: 20261025-gs_usb-fixes-250f38833107
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=If48e9zr2z0tCHZNqZQlpWWgSK0qjxGDBeBil9IXgr0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6P3/bmhRj7dNK5nmTkmf+cc+Uun/S8P/ZE+kzn+55P
 7VGNPBkfkcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmYpvCyLBBmVFvp4uKSaFF
 gduuZZ5l2c/kZb+tfHY5gyP/J9OJ8COMDOcfBXf/r7u7aiGn8o5tlwMFPS1b9O1qWkyuvlztl39
 TgB0A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Hello,

this series contains fixes for issues found by sashiko.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v4:
- patch #2: fix cleanup if register_candev() fails (pointed out by sashiko)
- Link to v3: https://patch.msgid.link/20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de

Changes in v3:
- patch #2: fix cleanup if register_candev() fails (pointed out by sashiko)
- Link to v2: https://patch.msgid.link/20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de

Changes in v2:
- patch #2: add missing cleanup if register_candev() fails (pointed out by sashiko)
- patch #3: do not increase rx_errors during OOM (pointed out by sashiko)
- Link to v1: https://patch.msgid.link/20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de

---
Marc Kleine-Budde (4):
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish

 drivers/net/can/usb/gs_usb.c | 85 ++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 31 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

