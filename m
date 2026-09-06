Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A637C926
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689717; cv=none; b=cbvzZC0YQja9BYWcMKU9fiAqaufwWylqDMY9iG6CVFnH6fRuN9ufSdeHAcK/mCSkw/kXn4ZQVATQm753/cQQglY0haG6TSXdbrVm4XIln1x1vmIhQ8E9PeaRb06bcb0vQz93qLO9Tdtzy7ORuElPFAuWPECcmKB6gwBN3PR5d+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689717; c=relaxed/simple;
	bh=D+Su0BmxKqAYa5jqfBEvykM54HnQ7Wf/C2f5tsHgqGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d08o1pTGEvXWXW97NzdIQYDX+3AztwOej3jWfU2w0mieFK5jP5/ZJrhcm4/PvgKYfAflafU+qB17ogOk9De8Hc7MPxdMoNfh3K32+Vdq4pyp5Fo2Gvg+ELhat211+dp5OBT+fObPGGZbuAqoSJEWJKKKvAeghiUJUqPwnKPgyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OTOU857s; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OTOU857s"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 45BED80AAF;
	Sun, 06 Sep 2026 12:15:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X33bw0n3PB6m; Sun,  6 Sep 2026 12:15:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1788689709; bh=D+Su0BmxKqAYa5jqfBEvykM54HnQ7Wf/C2f5tsHgqGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTOU857s0ehWFGAqsxyFVvmr5QdM98OQ3Mqs5vRSq402r8cI22UHW4Eh9s0gAhu7h
	 PZXLAtAA6jz+mCFuIs+bkIF3/j95aAnHLL/UPCOfRr+pGFbFsBOhBv9kCPniI8W6Sb
	 LJR9FAykFc5hupqwWvmjS7DEoxk8smGdKrYdaOL4csk+4lA1r9xo6i9i8SvVz2B3r1
	 MTI7hx7/zuQFDW2g1JNQgGmtFTKmdWu2S1m5Fl44YWPpFPXXwDALF1J67mq/RPX4yu
	 eN1Wz0PdN92/ksE6UJSfY9LHyJkwiB/OoHZACHCY6YtlrDJMmp36Z4Hre5oV6zQDvO
	 g/dfNTQT94wUQ==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: stable@vger.kernel.org
Cc: lee@kernel.org,
	Ali Ahmet Memis <ali@iusegentoo.com>
Subject: [PATCH 6.18.y] mfd: qnap-mcu: keep the reply buffer alive past a command timeout
Date: Sun,  6 Sep 2026 13:14:57 +0300
Message-ID: <20260906101457.671435-1-aliamemis@disroot.org>
In-Reply-To: <2026090340-fidgety-these-5499@gregkh>
References: <2026090340-fidgety-these-5499@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ali Ahmet Memis <ali@iusegentoo.com>

commit 47504742cea7878ebd1bf1491bbed923df6b90b1 upstream.

qnap_mcu_exec() publishes an on-stack buffer to the receive path:

	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
	...
	reply->data = rx;
	reply->length = length;

and qnap_mcu_receive_buf() writes into it from the serdev receive path,
which runs out of flush_to_ldisc() and is not serialized against
qnap_mcu_exec() at all. bus_lock cannot cover it, because qnap_mcu_exec()
holds that mutex across wait_for_completion_timeout().

On a timeout qnap_mcu_exec() returns with reply->data still pointing at
its own frame. A reply that arrives late, or an unsolicited message from
the MCU, is then written into a stack frame that has been left, corrupting
whatever runs next on that stack. The same applies when qnap_mcu_write()
fails, since that path returns without touching the reply state either.

Move the receive buffer into struct qnap_mcu. It is 37 bytes and the
structure is devm_kzalloc()ed, so it lives as long as the driver, and a
late write lands in memory that is still valid and is reinitialized by the
next command. bus_lock keeps commands from sharing it.

This deliberately does not clear reply->data or reply->length on the
timeout path. Doing so races with qnap_mcu_receive_buf(), which reads both
after its

	if (!reply->length)
		return size;

check: clearing reply->data gives a NULL dereference, and clearing
reply->length alone removes the reply->received == reply->length exit
condition, so the copy loop runs until the uart chunk is consumed and
overruns the buffer. Leaving both set keeps the write bounded by
reply->length, which qnap_mcu_exec() has already checked against
sizeof(mcu->rx).

Fixes: 998f70d1806b ("mfd: Add base driver for qnap-mcu devices")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
Link: https://lore.kernel.org/all/20260802132012.537B81F000E9@smtp.kernel.org/
Link: https://patch.msgid.link/20260802135307.31380-1-ali@iusegentoo.com
Signed-off-by: Lee Jones <lee@kernel.org>
(cherry picked from commit 47504742cea7878ebd1bf1491bbed923df6b90b1)
[ 6.18 lacks qnap_mcu_verify_checksum() and
  qnap_mcu_reply_is_any_error(), so the checksum check there still
  open-codes qnap_mcu_csum(); only its rx references were moved to
  mcu->rx.  The fix itself is unchanged. ]
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/mfd/qnap-mcu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 4ec1f4cf902f..22a7a77fdeaf 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -55,6 +55,7 @@ struct qnap_mcu_reply {
  * @reply:	Reply data structure
  * @variant:	Device variant specific information
  * @version:	MCU firmware version
+ * @rx:		Receive buffer the reply is assembled in
  */
 struct qnap_mcu {
 	struct serdev_device *serdev;
@@ -62,6 +63,7 @@ struct qnap_mcu {
 	struct qnap_mcu_reply reply;
 	const struct qnap_mcu_variant *variant;
 	u8 version[QNAP_MCU_VERSION_LEN];
+	u8 rx[QNAP_MCU_RX_BUFFER_SIZE];
 };
 
 /*
@@ -146,20 +148,19 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		  const u8 *cmd_data, size_t cmd_data_size,
 		  u8 *reply_data, size_t reply_data_size)
 {
-	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
 	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
 	struct qnap_mcu_reply *reply = &mcu->reply;
 	int ret = 0;
 	u8 crc;
 
-	if (length > sizeof(rx)) {
+	if (length > sizeof(mcu->rx)) {
 		dev_err(&mcu->serdev->dev, "expected data too big for receive buffer");
 		return -EINVAL;
 	}
 
 	guard(mutex)(&mcu->bus_lock);
 
-	reply->data = rx;
+	reply->data = mcu->rx;
 	reply->length = length;
 	reply->received = 0;
 	reinit_completion(&reply->done);
@@ -175,13 +176,13 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		return -ETIMEDOUT;
 	}
 
-	crc = qnap_mcu_csum(rx, reply_data_size);
-	if (crc != rx[reply_data_size]) {
+	crc = qnap_mcu_csum(mcu->rx, reply_data_size);
+	if (crc != mcu->rx[reply_data_size]) {
 		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
 		return -EIO;
 	}
 
-	memcpy(reply_data, rx, reply_data_size);
+	memcpy(reply_data, mcu->rx, reply_data_size);
 
 	return 0;
 }
-- 
2.55.0

