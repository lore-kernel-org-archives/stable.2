Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDBB3624C8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681463; cv=none; b=Xh4IXaZ+PkPK8mtQ5v1y+/A7yB4pDnaAvmlXtvyjo6HBphuwhL03UDEwc3kyLr/cWAvf+8/5Ce8zh2k9uMsfmQTvinBV8/bY2Ia7DUQYO60l/HU4ga6hs4SLs1Tce7Gm/yZk1pkoac4DSQu23aoXyI1hwQrHE1WlLNk8S3RGNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681463; c=relaxed/simple;
	bh=RhehwHHBb8H4OBjE7eqWKzTTFv6N/2VV1vQcwbnVPZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9DFoSbRYLr2OESEWl9/wRl3CQqBjeswRSL84aFLxKMSfgkmnTWpfQ+sllSTMpRp65dKM2yusIhm6i5EdkGX4ywlE1hQ3IaMZ35GnwvIwQ+iGyNyMAZ/F9bylnoxZB3nUM2GZ6uIeatTkDAmeuvcBWBOtRTnKj39c+VUL9AVLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs4K/AC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs4K/AC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9171F000E9;
	Wed, 22 Jul 2026 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681459;
	bh=64Q4fCb7iHZWkyyvPNGmWvoD0jglG3qdOb4ULx/Yvo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cs4K/AC3Scom2ozL8qAX6/wFm3qb/5YZjBsBAUVaFC7rL0YL7pJPYEcXOsmIIoD3y
	 o4c/fw2++HiBSdET6KoUW3smTRMUUcRs+iv01+RldNOAgQFhYkWJozjAnduszdWD3J
	 oIImOf+mUEl2rKvjb8cnNkxCRgiFhigBAsbxcv+gbDgTNEAPms1KMGHD7W9PyOFbRY
	 4fOJTv/uGFAYAq3rBa7PFkcJVCVWPwCVBmHFX3fJbpMTYDDVAHcNRU/lLXlkZNA0/o
	 0fIXEa4NMysG9GMrm58FDWomXtULRHLp0CpiyFKK7/odPxKiC0e0u+Z1jzE9PwJaT4
	 aDfHboP9EY/CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Input: mms114 - reject an oversized device packet size
Date: Tue, 21 Jul 2026 20:50:57 -0400
Message-ID: <20260722005057.604420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071644-upscale-amaze-5106@gregkh>
References: <2026071644-upscale-amaze-5106@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 66725039f7090afe14c31bd259e2059a68f04023 ]

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
[ changed `&client->dev` to `&data->client->dev` since 6.1's interrupt handler lacks the `client` local variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/mms114.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 9fa3b0e421be2a..566a95ab0cc347 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -212,6 +212,12 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	if (packet_size > sizeof(touch)) {
+		dev_err(&data->client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
 		touch_size = packet_size / MMS136_EVENT_SIZE;
-- 
2.53.0

