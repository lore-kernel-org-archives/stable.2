Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273906;
	b=X1vbQy0DbRj2US0RghMwTHsa/32UgOC7D9nh5yiFTiK5i323Ln7ZG54N6WtXAD9T+kJF
	 oHmzEiybW+tcIkJGPHuL43MYeRXmcqXpUTCamsq9TPZEkmQt6wyybDE9J68dBTo9eS/qi
	 KnFQMcPMoxEQgENcTdYcWFrFsyl7pP/PzcO8yDiWhyiMqoOqfPAViGRLB2oFwytDk9uNS
	 GxMjYIOOIY707GWt6R78yd+W5K49dcKbHaIVNsq+SQl3vEr8TzkEuP6E1bLuDmVpvcEPv
	 4WcO13CdPdoJXY9quWICCjv+Jj2BoYmqf+uf1jxULvvpCJUPYDEf29MOOzGyXLU5FTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273906;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UeRTWvkCTwLSK0jam8M/idbTilMiyhy73sOnPIYVwtE=;
	b=pfASb/hSUgjixBXQ0B8gGPO9AmFzgyunTYBY7tncezZlbQTEahbFiw6eDmxKenzOLktH
	 GR7NfghIGjqevYITIgKv0ay/CG5d4PrbPh77rNBfVkbC8dW4O19f3FOrp557Ii5Kit+DD
	 d9EHIndKvBUBUmX4OYRATSfkHt4SPol7p3VNa8CJJIG7V3m/OEjBkkdC7Dcv3y9lTOMBQ
	 1WluKgJvrC99H90LGhRNqVKAMqRUnBBfZzbtulNTHOM+QT5tjdri8gijK0aXyiD96Jjit
	 cLFoZkK1Wzl3qJGCb0Zj1cU8N0zFf253ZYzmgT6Lel4+O1q+RYGcoT40DNcAGs1A2Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHqNPTDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB3606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHqNPTDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DD81F0089F;
	Tue, 10 Nov 2026 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273905;
	bh=UeRTWvkCTwLSK0jam8M/idbTilMiyhy73sOnPIYVwtE=;
	h=From:To:Cc:Subject:Date;
	b=mHqNPTDProNdYbw2kNk0iPlHe98aAx56vdUv3v6tu0j4dvb7jYiXdJhR+s9ldwAXk
	 jzmAUfopz4IcpA72r3W/baQmRJ/P2V4tPDLXtkFGtwbUrpkFiKrbrKAq6Rf81Vv9P3
	 0s1/10OhIO21/o11X9JeVIw4IdVnxIvXD2PWqVlbqDyQON/Cg1TfYFlpKvJ4M4BQhq
	 AKzAbdrYRH0Qx4TpWeEVTh46jiQiu8RnPuEOOSh00s4woK+w1tZmb9K1c98tBcvqVr
	 NcPES9z3KY6QZ2bJdIqDGx53i7mZQvLIs6sCNO7nJJM4uw64wpheSk3R84TATLSMXk
	 dKV78cOe6Oo4A==
From: Sasha Levin <sashal@kernel.org>
To: zhaogongyi@bytedance.com,
	cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libata-scsi: reject data-in commands with a data-out buffer" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:25:04 -0500
Message-ID: <20261109202504-failed-5.15-a4845f077415@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a4845f077415ef32fe672c841e2fc58ae9e28273
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202504-failed-5.15-a4845f077415@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




