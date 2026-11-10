Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325202;
	b=p76z1LGyhv6N4dVUvtkFnnJIURw6POcvISYJKdFP4JeAVfff+687JnFwAdj791rJqdoC
	 1F9mWxbkJvvfygK7knrwXzKVmkTblbeX2w3uC+bFrakWfm0eBnQdtswUsvPRKakoMMXLn
	 77ZwiUQCHgxBAdQ/bLs+mpPu4v0E1kaT02YSoz/7hises7uY8PjCTihkyPeb5c+jpGNQ8
	 YuPvFIZyERQNs0gjLTTMcW8z2JqX+9IV9+OJeFX2wvtjvaHG/03fD5Axo+TMXcBlbduBa
	 yP41u8ib9+OLwYPYWgvQjmzDoI5yc/hx0/osmcuKPmhFJ3Ym22KtNsqD4jO5pA7OaiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r+d4tl+Pp3xYxHDTfZRL1+/TNXuvbUP+Qww6KOb+ahU=;
	b=t4Q+cks8fBQwwd3G0nHdkerWEbAUa9761GHClxrdS0FHfTVr5C5vqERa2YfT7jhYn7v/
	 zrHZ9WYTkI8DgoLZuwqs4jB3KDJ689jQLYsinv0Vju4DSm6/vc+8SlA3HH/gK+Gv625Ih
	 rofM7F2NNqHKsdh05I2tpg0VnloRLTqV8HxCJ5ndOtB8tkEv2aPBfhRVu3X9rJ4EVm91u
	 u905BdUjaFelYw4owP0XmY/wQZl39F0VFFqCQRKMsyNcr7jeWSGo17+w1WKlgWP/YUDaH
	 mHGevw2dHBkfQEm1Sz1TBe+OpAZwr4ylru/bcgXoHdeXtyYxz2LJPgovyzgxC7tT25A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gH2RY9pT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291FF606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gH2RY9pT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035281F008A2;
	Tue, 10 Nov 2026 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325201;
	bh=r+d4tl+Pp3xYxHDTfZRL1+/TNXuvbUP+Qww6KOb+ahU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gH2RY9pTj/RsSgB7f5UnthAwOHC1W0nBmDarCFZQUSDn3yipkPZMYt0O7UH7PIEtF
	 S0iFtCLRXTjxOLhqSPQ5GYMDhy2OD5Rka3WQZZmAZy1pzQb17OQ5LZEFOSi4ESL0ym
	 scjarG++3tUF1xRCMHHtB8q6Drvwl2tRDxWqsiHElA4blkTnLiC9tGSyHrkC0L1Lxx
	 1/2mJGSMZYZxxeiqZMFiG87k1b/UD9oWyMrfAHscbnlBGnVGUFG9/6lnFj1Mhuq939
	 BMisl2dsmVPm9dVrtwZue67AQ/5t8J8kdkfa2a00UWPsF6jFkXMNghiOvFbsSdFKau
	 2MsXl8AI+IdfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francesco Orlando <francesco.orlando99@libero.it>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Input: xpad - add GameSir Nova Lite support
Date: Tue, 10 Nov 2026 10:39:59 -0500
Message-ID: <20261110153944.2331158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062307-failed-5.10-2e6f2e5799f3@kernel.org>
References: <20261107062307-failed-5.10-2e6f2e5799f3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Orlando <francesco.orlando99@libero.it>

[ Upstream commit 2e6f2e5799f328ca0879dad14d7f3709c7f7496b ]

Add vendor and product ID for GameSir Nova Lite (0x3537:0x1040) in
XInput mode to enable force feedback rumble support.

Signed-off-by: Francesco Orlando <francesco.orlando99@libero.it>
Link: https://patch.msgid.link/20261011165821.72698-1-francesco.orlando99@libero.it
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ sashal: added the missing XPAD_XBOX360_VENDOR(0x3537) entry to the USB device ID table ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index b5c3b8f73011e..f3d32527d7527 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -354,6 +354,7 @@ static const struct xpad_device {
 	{ 0x31e3, 0x1300, "Wooting 60HE (AVR)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1310, "Wooting 60HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
@@ -482,6 +483,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x2f24),		/* GameSir Controllers */
 	XPAD_XBOX360_VENDOR(0x31e3),		/* Wooting Keyboards */
 	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
+	XPAD_XBOX360_VENDOR(0x3537),		/* GameSir Controllers */
 	{ }
 };
 
-- 
2.53.0

