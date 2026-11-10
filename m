Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273603;
	b=RV2ScoOMjymmYieNybirXlXdr8suImYL7NAG8TDw8hPlvgVAwIUhdqZqdgtiLY5iicHr
	 02KGz9zHyopIOPxV7goo/h2m+iqI42hLL8Pv2atrg5IiLiBPOThFwU639YwmquyhbykLJ
	 RLb9QYnj8thJN3UU/vgalr5K8d3DtgLyO1JpTaY6PYL+F7ebMZcOL7Edvjv2eHN5PrEVm
	 5amW5UXr5NlDgSz8v2b9fKC6jc0BjNVISlPm5HJGLUNF7StQ7Vx+r1XFETAMIM3B9rX8R
	 QvFVcavT1zQgpCle7xhMnq5bVIY5dJRcvVuE/BoglI+pewt50RmTpcIjmCa5H7YPlSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zlr3JtSKGo1yB6bN8iDZJm2oazPihOiSroKnxYQLPwU=;
	b=ZNISEh9j63vBP4jyXbFmo3cuSa3N6d3Zdv4I/2y/2/aoacois+k+rnj3RwPPjXR68haY
	 2/iGC92/h/hAOhVjJkzLcDOqn/01Y9dM51Txp8lx6soosRaAS4ap30roes5a52r2tVRz0
	 GKSd4bBEKHVAVEg0DaNzmNs228B14fPXbNEwn7me1NeeDQvydyx1KMBW3A6Ca+myl/vnA
	 7Zf9Tmh50EGq6Il0dWVV3xc9/HkYz1bui0tRTLDF3oguLOmOUjqAnJT8O/DnJeIywGQWn
	 2ZV3DUeDKxRcbQEPgA1S/YU1uW4MSc5XU6m00xZWcli3ujarZEwBlIQ9pbRivhzus3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsBSpxda;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B81606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsBSpxda
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBD81F008A1;
	Tue, 10 Nov 2026 01:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273602;
	bh=zlr3JtSKGo1yB6bN8iDZJm2oazPihOiSroKnxYQLPwU=;
	h=From:To:Cc:Subject:Date;
	b=TsBSpxda/OxdSA4uV5eu63bLeAG0wPRbzLoNvSD46+eTx5u0xBliBC7N8sr6LmWoy
	 fvZ1Vu/4v7UzyjkTn8xuuRnzLY21fn50QVLgvBy39d5NUqfM1ZFfl3a970/gb6RgS9
	 gQKDUM3BU40itzsHMIX27/LHsfuPQeI6XUYchwqIYwvbGDmZ7vHAZMxhq/h/OAxitV
	 vczjyu9NGPJZPgmYs8fw9afkIejv6+/T+4Eb0y+LWlOAcQps00aizd72M8MvvmTUIL
	 f3hRwr7vtaSD41tqcF8d0B2f4pQwEwULnYY1b5/tz2EuXYK65a+aEMJZEA1S3/WBxW
	 UR+TX6I11pkXA==
From: Sasha Levin <sashal@kernel.org>
To: zhaogongyi@bytedance.com,
	cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libata-scsi: reject data-in commands with a data-out buffer" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:20:01 -0500
Message-ID: <20261109202001-failed-6.1-a4845f077415@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a4845f077415ef32fe672c841e2fc58ae9e28273
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202001-failed-6.1-a4845f077415@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




