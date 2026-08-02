Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577E3B83FB;
	Sun,  2 Aug 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785678834; cv=pass; b=UvyTizSOnK2XFFLk6/FBbGN96JAmejfgh4aOHSPlA1KbogC1fDBXYNDENtD/PaTsM187uVb2G5us4G3HuTSIw/9loi1IeMhLIAir9985P8zOl7wXTnW/gh/ZYhb+GOyRvVOj07Kf9k2M9jC+8TV9Qs3ld4TSdmkeTYHyvY0sSHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785678834; c=relaxed/simple;
	bh=8LnF5ffux6+AGVmnLZWNQnzyj+FhzZbozWboYiTLSbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEIcdKz4GAaSjTVlNWZkCKbHqzMhrYitWeSZmjm65UmIa/74AATa8qt6qgfFi7s0WLcFBoNi2dug9DysddRWW+1G/qQ8F0gXjfIKpOHjHASeSpQ9b6sX5GTwc+gOFMZj8uGbJuNG4QpMGECsK/9FLQcUOgxv88PAw3vnPzDBOIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=FAlLkGr1; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="FAlLkGr1"
ARC-Seal: i=1; a=rsa-sha256; t=1785678800; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MkXhCojgLF4zgsAmAcB5E3H8sQnriDYGA/5GkNDBKAmc7a8JfdoSd7uuCqE8iPEVXBGB3hNmEuDWYj7D7c2ogbZfrhU2B3XMxOrSkGQQCF1szMApwX0AeVMfMhLRfolMUsCT/VdvqbN9LFbyWLk5kspsrYSaVERD9OYlgVwL8/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785678800; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tPDUMVhdRwUTaaGEfDcv30DZhrsJ+20oD7Px6MCdUpU=; 
	b=HtZT/05AlUbSq+LouKpvfkKxSdiANAGvYhuWE8xozS2lwKw+pcdd0NfmnubYsaDxuiPaolY/CZbR3UzuBiw99Hxa0szyMA1EVKV1lxNLd53/xUrbBrCxGkJ8xZX0rjBUHLyXXErc2LuRf6LnzcxeDHw5HKxnnJV9lDHsHOZzJvI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785678800;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tPDUMVhdRwUTaaGEfDcv30DZhrsJ+20oD7Px6MCdUpU=;
	b=FAlLkGr1MvTJ2CEpjEU+KlSbBOdHHw/186ErpisyQ/Vo/dlg5yNV0KntYKiy1jeZ
	M3WJNRQbXcGXMT8Gsu9yeed5ljzyuHuFuIug1oEoSXGLlW4b7XicwMZVVwvhiT2CjfL
	Aqa9aV+ssqx17OevjuTgIN+6ckNJMJMaJgSOk61Y=
Received: by mx.zoho.eu with SMTPS id 1785678797901270.71141046914715;
	Sun, 2 Aug 2026 15:53:17 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mfd: qnap-mcu: keep the reply buffer alive past a command timeout
Date: Sun,  2 Aug 2026 13:53:07 +0000
Message-ID: <20260802135307.31380-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
---
v1 cleared reply->length and reply->data on the timeout path. That was
wrong: it races with qnap_mcu_receive_buf() and, as sashiko-bot pointed
out on that thread, can give a NULL dereference or drop the copy loop's
exit condition and overrun the buffer. It made one failure mode worse than
the one it fixed. Thanks to the bot for catching it.

  https://lore.kernel.org/all/20260802132012.537B81F000E9@smtp.kernel.org/

v2 leaves the reply state alone and gives the buffer a lifetime instead,
so there is nothing to tear down and no new race.

What this does not fix, and what I am not proposing to fix here: a late
reply can still be written into the buffer while the next command is using
it, so it can corrupt that command's data or complete it early. The
checksum test turns most of that into -EPROTO rather than bad data
reaching the caller. Fixing it properly means serializing reply setup and
teardown against qnap_mcu_receive_buf(), which is a change to the driver's
synchronisation model and not something I want to fold into a fix. Same
for the unprotected reply->received accesses, which KCSAN would flag.

I have no QNAP hardware, so this is from reading the driver rather than
from an observed corruption. What I checked:

  - flush_to_ldisc() calls receive_buf() from a workqueue, so it is
    process context and genuinely concurrent with qnap_mcu_exec()
  - bus_lock is held across wait_for_completion_timeout(), so
    qnap_mcu_receive_buf() cannot take it
  - struct qnap_mcu comes from devm_kzalloc() in qnap_mcu_probe()
  - length is checked against sizeof(mcu->rx) before it is published,
    so the bounded write stays inside the buffer
  - the u8 rx[14] in qnap_mcu_get_version() is a caller buffer, filled by
    memcpy() under bus_lock after the reply is complete, so it is not
    exposed to the receive path and is left alone

 drivers/mfd/qnap-mcu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

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

base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
-- 
2.55.0

