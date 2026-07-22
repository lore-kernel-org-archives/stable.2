Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCA40F726
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717479; cv=none; b=Ds1tpmfTxO9uPnQGZMqex0KaYVpBSrzgjLzcynauR2C/IaWgifRJQ7Y2pPgFOYskKXFjWHG8NC9Xir97nD8wXEXcoMSKPOybuOe4VaXEsia5GwwG4j3sadj0LUkL+fcNEeVbjBpMEwlbFLzKByVTQDxkm4WHqoIvUkBq92KDhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717479; c=relaxed/simple;
	bh=TN28kpJU6F1WDjFpK9FMy0WK26IGdSxgM6RzEAr8bYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THES8OergcJai5XsGC8FEDfyF0piTXaKN4+P5J9HY6NdfGnAupwyEGjVxmqKMwPjr5FPxjKCkeO2wArjZ6bfyaW6G9jg+cqcwyxa94PUYKgoPJqB49P+iDn+S5HR+0oqGX7eWcenF0u9oV67qgZvlLPgaq8CJC5P/PMyqEWUQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoW2ut11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoW2ut11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE7C1F000E9;
	Wed, 22 Jul 2026 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784717477;
	bh=/jP63cDhnnMLklOUMO0duw07b+xaCOgSu3ZIIdnt/9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WoW2ut11NRcjGJ2HVDPhVrEEqQS8KY2Fjiuty95Uf1/XgsC6hRnxsVEYDM9+LK/zg
	 fCX0zQEfDonSvSbkJiCeS451r6NOoJ699lLJ17ekxYmRrUenroMsliJr4MGxdoJRCs
	 FnemjKgHjINnUcnPKArLt+AVz0I9PkaxqBNm6KGXR9cUhrosNKyu2ICmfnS26gl/Em
	 y8pjmvBvYf7IhHo/o2/g4Ic0fiNdpNMnoAoPMZ05bkuflOJU2RxE1fzHKXXqCSexEG
	 7Lws2ko89AWbgMWCG+R5jcR54T/lSn7BRbEvCJNKFG83bc1KohGR70CYCe92FqJov7
	 iCkQBpOD7tjJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.10.y] Input: mms114 - reject an oversized device packet size
Date: Wed, 22 Jul 2026 06:51:14 -0400
Message-ID: <20260722105114.989610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071638-seltzer-gambling-3268@gregkh>
References: <2026071638-seltzer-gambling-3268@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

mms114_interrupt() reads a packet of touch data from the device into a
fixed-size on-stack buffer

	struct mms114_touch touch[MMS114_MAX_TOUCH];

which holds MMS114_MAX_TOUCH (10) events of MMS114_EVENT_SIZE (8) bytes,
i.e. 80 bytes. The length of the I2C read into it is taken verbatim from
the device:

	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
	if (packet_size <= 0)
		goto out;
	...
	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
			(u8 *)touch);

packet_size is a single device register byte (0x0F) and the only check
is the lower bound packet_size <= 0; it is never bounded against the
size of touch[]. A malfunctioning, malicious or counterfeit controller
(or an attacker tampering with the I2C bus) can report a packet_size of
up to 255, so __mms114_read_reg() writes up to 175 bytes past the end of
touch[] on the IRQ-thread stack: a stack out-of-bounds write that can
overwrite the stack canary, saved registers and the return address.

A well-formed device never reports more than the buffer holds, so reject
an oversized packet and drop the report, consistent with the handler's
other error paths, rather than reading past the buffer.

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
(cherry picked from commit 66725039f7090afe14c31bd259e2059a68f04023)

[ sashal: adjusted for 5.10, which lacks 53fefdd1d3a3 ("Input: mms114 -
  support MMS136") and bf93349b11ab ("Input: mms114 - add support for
  touch keys"): kept the flat touch_size = packet_size / MMS114_PACKET_NUM
  computation instead of the MMS136/MMS134S event-size selection, and used
  &data->client->dev in the new dev_err() since mms114_interrupt() has no
  client local here. ]
---
 drivers/input/touchscreen/mms114.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 1f96657310b751..f89676655dd3f3 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -209,6 +209,12 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	if (packet_size > sizeof(touch)) {
+		dev_err(&data->client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	touch_size = packet_size / MMS114_PACKET_NUM;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
-- 
2.53.0

