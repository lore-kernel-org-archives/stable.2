Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324866;
	b=IoAK/q6OeqodvJTi5ppp3b+iz67gfPZrHnNjaR/EaEBSGOhFG2VLBmfC4nuYuTYVurbk
	 1fcwofcYDngk0U7Nij/WDgn0Rwp7U5WzpyUPPACIHZ8mPYp0ReAGMP1PPhOm4+ALpvcuL
	 XdxY21JHujzuUaDd0D8lCy231PRqzot48hllXFmFoHFPRztd2UZv3OgQjxeCoTpdBcIyH
	 NN7EOVD4QcJkDsCe707ggFQpPOLQHllIPDYjj7/BT0ykQ5VIXpmNwGd5f0VnipG8cEk1d
	 kYSzur363I2WDeDfHGPjyh1tonht0LLYLOcRS9iRK7b+xRxn7TMPZ6fR4mTmELDxiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324866;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bQ0BY0gwfQ0Td2ZsrTEMeZF2LIiY0caMdOZYmSGZe94=;
	b=FmmogpKbeCIFbeNa9SnMzwb+zZ5ptEXlMC/0SXltQlm1p6+XT3K92rvvlnTZRYpjuB1R
	 F+FtMjIQzHNIy/fnf2dajppzLYUK1TM3D9cpsRpTy3TaBDSdK8pgQUc0eR205+sMCGAew
	 2E0tW7KhnP+KrSy3EC9BE6wGUJX6QUjlRq3uBl6HT5i+V2uRBQKuAHkLpUj7qEjhAd8oI
	 DD4Lm1bBuqyOLQ8dsKR736nTATN65PaBZy022ky97FuzypwUVyRfipKHokg+6HqSU/WZc
	 p+PPjJkXSahhy+we1HF4QNk8fCQ2bbZbg+DpWtPzddfkTcHgU7tF6xnGD1gdatTv1Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ0kGPl2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796360A262D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ0kGPl2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDACA1F0089F;
	Tue, 10 Nov 2026 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324865;
	bh=bQ0BY0gwfQ0Td2ZsrTEMeZF2LIiY0caMdOZYmSGZe94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZ0kGPl2EV5f+XgaVyPIc6w3zCoXqQCoiANVyoLUbAgU8ZmYeKNAXGyW8wgmSIBS7
	 DAhjGmCsK/QythDSE5/CR5F1xK1gqk2566c5vztbpHP8AHeUhnbEm2sUNDuzxYA8v/
	 af7si+PJxTzZIijdgPc92i97GLJsWX7VjyL5bOV0lS4wy3uiFOCYDjZSfus/0k1hlR
	 5QPn3Q4CwmDpKkXszRyPN1TVWKqoq3zSgg69GOZi5+1yoXnUggxaXqEi6QwPPm7+RS
	 f8Sk5bzZmgM0Kb4Rj2e5tVO86kCBJGI3XkKZYZKzVi8LnGbmMiD/ei0H3ScxXa+45S
	 CNXOB3Uiur+MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francesco Orlando <francesco.orlando99@libero.it>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Input: xpad - add GameSir Nova Lite support
Date: Tue, 10 Nov 2026 10:34:23 -0500
Message-ID: <20261110153412.2136503-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054902-failed-6.1-2e6f2e5799f3@kernel.org>
References: <20261107054902-failed-6.1-2e6f2e5799f3@kernel.org>
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
[ sashal: Added the missing XPAD_XBOX360_VENDOR(0x3537) prerequisite entry already present upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 458e166b97095..85c58e512bd40 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -383,6 +383,7 @@ static const struct xpad_device {
 	{ 0x31e3, 0x1300, "Wooting 60HE (AVR)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1310, "Wooting 60HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
@@ -521,6 +522,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x2f24),		/* GameSir Controllers */
 	XPAD_XBOX360_VENDOR(0x31e3),		/* Wooting Keyboards */
 	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
+	XPAD_XBOX360_VENDOR(0x3537),		/* GameSir Controllers */
 	{ }
 };
 
-- 
2.53.0

