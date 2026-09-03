Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908639EF19
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449985; cv=none; b=G1DIccdqGNmcjRVELkgOc7XLP80GYlb2OXLz14r9BCkGpW/ofvSZoJAqrPQAWvGj2Yb4zB2sU6HhG5zG2Ywfj98K9p64NDd5exKQ3AtRsMP7hPrjqUzrmPoxtp0hbrTXENfhj9yLSoY7s8zP4UVg1pZ878zstkH0TmFtCUaRVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449985; c=relaxed/simple;
	bh=/oeEC+6DMU4TRagSHmGruECD4mKcbN7yXBu6EqjONDM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YTzPIhNfsVz1NusElcLkIYGfa/RBSRi06OJHwJqvHVZNxqJZ9kY7JeKhbR8D4DGxVxiQoLETr2beoqlp1EzA4lWZPftFWng/qqWoUkiZn6VQCTNurz11mSnWJQDTmojkGqA90n4H5O2E4rmhBaCaD12xCp8CuLmt7/8kG3b3NBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGX0OHdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGX0OHdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80C31F000E9;
	Thu,  3 Sep 2026 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449984;
	bh=mZaFf8+okkdkTpcPPBKDozPiVr6ZYg05XFE9Nc0QmpE=;
	h=Subject:To:Cc:From:Date;
	b=fGX0OHdMhMqx6scwQvKEBuIxtHZZzxEkj5XUGaHGqCAbBDqNIPJRbtkZm5Yn0Nxg4
	 cv4/5FAz/s1H/jsGX13FKYtUt+HteRzYnt0vIRodXUaY0E+20m15OEcu0p0FynYfNP
	 jtm/4A1SE87FpS+6gtOYkcVH1B17DLvS6prUsdCQ=
Subject: FAILED: patch "[PATCH] mfd: qnap-mcu: keep the reply buffer alive past a command" failed to apply to 6.18-stable tree
To: ali@iusegentoo.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:12:40 +0200
Message-ID: <2026090340-fidgety-these-5499@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 47504742cea7878ebd1bf1491bbed923df6b90b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090340-fidgety-these-5499@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47504742cea7878ebd1bf1491bbed923df6b90b1 Mon Sep 17 00:00:00 2001
From: Ali Ahmet Memis <ali@iusegentoo.com>
Date: Sun, 2 Aug 2026 13:53:07 +0000
Subject: [PATCH] mfd: qnap-mcu: keep the reply buffer alive past a command
 timeout

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

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 8de974ddac3e..93a3dd93404d 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -56,6 +56,7 @@ struct qnap_mcu_reply {
  * @reply:	Reply data structure
  * @variant:	Device variant specific information
  * @version:	MCU firmware version
+ * @rx:		Receive buffer the reply is assembled in
  */
 struct qnap_mcu {
 	struct serdev_device *serdev;
@@ -63,6 +64,7 @@ struct qnap_mcu {
 	struct qnap_mcu_reply reply;
 	const struct qnap_mcu_variant *variant;
 	u8 version[QNAP_MCU_VERSION_LEN];
+	u8 rx[QNAP_MCU_RX_BUFFER_SIZE];
 };
 
 /*
@@ -214,19 +216,18 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		  const u8 *cmd_data, size_t cmd_data_size,
 		  u8 *reply_data, size_t reply_data_size)
 {
-	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
 	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
 	struct qnap_mcu_reply *reply = &mcu->reply;
 	int ret = 0;
 
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
@@ -242,15 +243,15 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		return -ETIMEDOUT;
 	}
 
-	if (!qnap_mcu_verify_checksum(rx, reply->received)) {
+	if (!qnap_mcu_verify_checksum(mcu->rx, reply->received)) {
 		dev_err(&mcu->serdev->dev, "Invalid Checksum received from controller\n");
 		return -EPROTO;
 	}
 
-	if (qnap_mcu_reply_is_any_error(mcu, rx, reply->received))
+	if (qnap_mcu_reply_is_any_error(mcu, mcu->rx, reply->received))
 		return -EPROTO;
 
-	memcpy(reply_data, rx, reply_data_size);
+	memcpy(reply_data, mcu->rx, reply_data_size);
 
 	return 0;
 }

