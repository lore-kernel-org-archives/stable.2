Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792953402;
	b=Kb8LPi/KqQrHKSzPpQYoykLlMYmxR/8cSFh0H0UYqT+pvH4QN6zaGo2CFVujR2U4jHLb
	 wSK3LNcJm28UC7vMLVLW9DJ4IfL07eRP0tyfeOxDAr4jRiZv6VSW7R1VQcmLa75N45Mmb
	 YwWN6CNoKUM/KE5UK6Xk0/3oQAORi/RLFjlLcWMTeVf2AamEjjURLRaSCGfGWKnz9PFvk
	 Wht8iTBZMw2aE2iOdIVW64HNn85nJ9ff37Sm7PvwQliJkTgxLcO3avmiyc9D6/143nEQi
	 xkiZsuxJLjaj251/KFTzWx5snSMtvGEN0+lEVi7PjsC11OljotQFruKvnc4xbFAYUzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953402;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=JeL/zz25zvRSYSUYtlfRVlo8wVU4wNntxjI5AIdZBxg=;
	b=aaQU5+w87fXqnVnmCvpa71k2xV2nU+DCgq0Dvs3fOv2kVIrdKLeho2XDsNf9Bk8xAge/
	 HUireTsvZo/BN09wFcih8ew6BZMezgX+3PzQxUSDs8hUPOGqSm67HYOTjBk60BEdRD3CU
	 DTFzGoCuLjSFNhS5F/wgjOgLm0lNLdgZkrZnQMd9ZSWGTFFEw6ZiRb1N5Hg/8oAWq66ek
	 u5eEX6+XMIDpRGTJVczhvmT5XvthFyDwuOtWilxeBs/tOUclixEraG0Gps9lRcDgIY2DE
	 JcacAid7b+ymrE9dfZ6KmukhnspJP/KMZL/SxWCbG0nIZQr5RPS60WO4gsPe9XsD55w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Ov/6k3Jy";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15F606A31D;
	Sun, 25 Oct 2026 18:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F15F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Ov/6k3Jy
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3471E200ADF;
	Sun, 25 Oct 2026 19:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JeL/zz25zvRSYSUYtlfRVlo8wVU4wNntxjI5AIdZBxg=;
	b=Ov/6k3JytNEwiEurkM94Yhj/86p8Ge2MlftD3dVyw00tIpzfM7wRfy7hHKhYxkQghyGgLC
	/uGJ/GJ8ChTUK6FbngAMS0K/Jrd/oC/MSC3gP/QVrp2Fw4aOoXPpgPJl+W1HDtLQLKDU9+
	K6Y/7NtYe0Ikj3EzTVTNeKqzyIu2LX8f5WW9aWbg3u1NJOF4Km7alj3PtYQzowAmaAcIbB
	hKK3pZQo73vYwzgWZPJQLhl1sYPcpLM02LQSe4Y5k3reGHkQ8E7engdbe+GukBNhghzlJY
	LAUQ8nJKVkN19bQgysRTrtFjBw0I32cV8YLhO188nmZW6eHvgYhhwcSHEZ4Kig==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792953398; a=rsa-sha256;
	cv=none;
	b=HtUixI0UIAKuT9WW4WwaiDV5UNBLwApAcKJymmyhRsbn9Eb9fGRV6LdkEoEA/yLzbJwGQe
	jR3AKk9KoGlWYnK/GXav4vKJvLpJgtH/vJmPE9Ejz4qg1uCoIdEp9Do44mQg+YNH0vu/6D
	QV3HG1s1K4A6IDdThDm4n+/nU2hSbYV+MnNPXRPWbaps8pyuWcGffuAc1MyUgxxQ3zE/Sl
	aAMYwm+q9fagGjj0VepHO6+A9XQVJoN1ubwb28/AAapyozV9uTGKkJV7V12Ubl1GcG6vFT
	tZSjTlrfumCzZp4LpEEFtHkjYnHsV3XOkcSux1Yw7UxKoOhf65ihqFThwmvoQQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792953398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JeL/zz25zvRSYSUYtlfRVlo8wVU4wNntxjI5AIdZBxg=;
	b=RW2A42VGbY81cr++CXT3GkxQJ732207MjIsIxes68vbl7VMEKa0onEwAXj2cB7Ned5rZ4g
	pWEW/r6Afo0NSp/5y4pS6PE1Ir4g/Fcv0WFiO8wxxITylC8r9bIDEtZOiOraL2FNohfh1S
	PBqdfjTsp6+tK9QaSbrErBqEsi6LziqkOINjk5AFtt9Y/FSN88pp0PyqWY+qf2V89aoU4u
	O4YS0lRydLyh+vQZsaMI35sL3+IWw4+WLKc/cZPSSu1OC6lPO126K3k8345ywsAhNrdDa9
	5Qq0MVkPmDf+nx2yiln0oHKUintDy9C0jENOdf/E5BErh7LoAyBSc7uJYzzriA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL35C-001AZa-0C;
	Sun, 25 Oct 2026 19:36:38 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5D86C5D4137;
	Sun, 25 Oct 2026 18:35:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/4] gs_usb: fixes
Date: Sun, 25 Oct 2026 19:35:30 +0100
Message-Id: <20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQqAMBBE0auEXhvIgANeRUQcWm0XUdJGBPHuR
 l0+il8XMHpChlJc4PEgptVF6ERAP7duQklDNBhlMq1MKiduAndypBNZmlSNtiis1SqHmGwevyE
 WVf2bQ7dgv78fcN8PgOykmHAAAAA=
X-Change-ID: 20261025-gs_usb-fixes-250f38833107
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=SfgjjC3fZOcT0yQyIkz0JEwQPlFvT19Er16vIHYbEYQ=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi65/19jsOpJqUrzjKJcYdbjgpINxw9M29tRPSfHcwnv
 vz3/v3pWUcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAm8nc+w//yaZaCdiZRqZJS
 /3ekmd4+FHrnY9WvUyKLH7/K+dbI+SuW4a+YrsbvTxOjPm7gm9NmvOvA95o7nf+cTb9L961JDFt
 hrsIBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Hello,

this series contains fixes for issues found by sashiko.

regards,
Marc

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (4):
      can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
      can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish

 drivers/net/can/usb/gs_usb.c | 67 +++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 22 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
change-id: 20261025-gs_usb-fixes-250f38833107

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

