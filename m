Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274171;
	b=wh/1yJOPp0J5+kW9pSDh20Yc3UYMF6Et5NbxQ8R8cbVljnYxajiRhKV3JaHuL8JJDHj3
	 yAaptx52aOJ0RAPtmo6v36x19bWsdRI8+W+KXKZDhOnU7uJgKg23On9kmJ6/C7BKTDDkW
	 rAxLvHqVnbjzDVa2d92Zhowekx2ClBf5H7zy2Mjq9vjpWY7gKzX5lOXGlU/ptPV2l3SAS
	 1lx4T8HKP9+wrSeuVnzuQGRJjnkKwgIlJz1vkpNWpR+Qz3OEdutpI14561CuEB5mJlHYn
	 bhLsBJcvE/whUdT2lEkXowSSBBxMiFosrKaW+c6PRtMkwgwJRUNUmQ6nZ6Kovqeudog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274171;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=z5E0ilkb1R0znp4oaGghSQ5YI7U69fC/TbYHV8AayCY=;
	b=f8Gg3o0RPjJU+NgXyf4V9ud4q3LLXpRkboFCOeKfBwMzsUGvcfQSON5AsCRxCQqghcJE
	 4fjp7bJcOmGx4lODSCJ8SuKV8Xs7ZblFE9Ck1rU5o17OnhVERPFDQ9Hv2F9uML6LLwsc4
	 anLf3xZOnz/k2d8T7slGgcuyD+8Kqml5HpCD7rgz4kgC6IJXQhb9CLCFlzKhbWuNXqSqv
	 s0Wj68HZBJH01knw9Pc+hiYuBonKKBNpu5BZCt6VNCOoDuW7iE9fAI63HX0e6Mblzi4Sc
	 a/BmB5DotT5ha68jAEfWU978rKrSaiN8LWcolfZ/iJ3gkmb1u1zcbUKciNFw0n2NoEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAoShDct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lAoShDct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC641F0089F;
	Tue, 10 Nov 2026 01:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274171;
	bh=z5E0ilkb1R0znp4oaGghSQ5YI7U69fC/TbYHV8AayCY=;
	h=From:To:Cc:Subject:Date;
	b=lAoShDctGWDdkb/hS38V6z/7WfoowbpXrqfOa5C7uSsX8SdZtt5TlPSUAKnL6etJ5
	 cNlnZdTOxpn8sd7vVCNLmFVdr+CJVcJ21/i0Yo9LE5T3NKou1vXDEhI19bApgoEAqP
	 wq/MxsR46cusOSISvhbWjrWhhrHVoi+t5+Au4sHX2lGZTMVpizVRGvHmFIdMcpOuRE
	 HvHQilNh3D2Fsnh22Ak9+ALfoDD1Cg/Z7YncgeBAEI9PohuaZYazwCTLh9e9oR5lhP
	 aNBqy3u9aWdermnqpwSXacm/58k2daRZnpAfBg7U34rlfzlkYvXWIMptpIU55DHY7K
	 BVWyzhqndas7A==
From: Sasha Levin <sashal@kernel.org>
To: zhaogongyi@bytedance.com,
	cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libata-scsi: reject data-in commands with a data-out buffer" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:29:29 -0500
Message-ID: <20261109202929-failed-5.10-a4845f077415@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a4845f077415ef32fe672c841e2fc58ae9e28273
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202929-failed-5.10-a4845f077415@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a4845f077415ef32fe672c841e2fc58ae9e28273 Mon Sep 17 00:00:00 2001
From: Zhao Gongyi <zhaogongyi@bytedance.com>
Date: Wed, 4 Nov 2026 21:06:38 +0800
Subject: [PATCH] ata: libata-scsi: reject data-in commands with a data-out
 buffer

SG_IO can submit a data-in SCSI command with DMA_TO_DEVICE. The
scatterlist can then contain pages pinned without write access.
ata_scsi_rbuf_fill() writes simulated replies to that scatterlist;
in the reported case, the copy tried to write the shared zero page
and faulted in the kernel.

The same mismatch can affect SG_IO commands translated by libata.
ZBC IN and GET PHYSICAL ELEMENT STATUS completion handlers can modify
the receive buffer even if the drive aborts the command. For ATAPI,
the successful INQUIRY completion also rewrites the buffer in
atapi_fixup_inquiry().

Reject these mismatched commands before the buffer is written or the
command is issued. Report ABORTED COMMAND / DATA IN BUFFER ERROR because
the CDB itself can be valid; the supplied transfer direction is wrong.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20261027090809.94126-1-zhaogongyi@bytedance.com
Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20261104130638.37882-1-zhaogongyi@bytedance.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b1d5d822a9a20..87a57495d2e4b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2048,6 +2048,19 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	if (xlat_func(qc))
 		goto done;
 
+	/*
+	 * A data-out request may contain pages pinned without write access.
+	 * Reject a translated data-in command before issuing it, since its
+	 * completion handler may write to the buffer even if the device fails.
+	 */
+	if (unlikely(cmd->sc_data_direction == DMA_TO_DEVICE &&
+		     ata_is_data(qc->tf.protocol) &&
+		     !(qc->tf.flags & ATA_TFLAG_WRITE))) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		goto done;
+	}
+
 	return ata_scsi_qc_issue(ap, qc);
 
 done:
@@ -2079,6 +2092,13 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
 	unsigned long flags;
 	unsigned int len;
 
+	/* A data-out request may contain pages pinned without write access. */
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		return;
+	}
+
 	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
 
 	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
@@ -3173,6 +3193,14 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 	qc->complete_fn = atapi_qc_complete;
 
+	/* atapi_fixup_inquiry() writes to the buffer on successful completion. */
+	if (scmd->sc_data_direction == DMA_TO_DEVICE &&
+	    scmd->cmnd[0] == INQUIRY) {
+		ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND,
+				   DATA_IN_BUFFER_ERROR);
+		return 1;
+	}
+
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
-- 
2.53.0




