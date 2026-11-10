Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272761;
	b=RJREGxmczeFGU15adf1AxdOk1N2xNqfP4eD6AkhT87lP6N+zbNyk/i/RV1wsLE0l8Gh5
	 EDypap0AvX4UgC2iJjecKaVV5Z4wXeYnz6iJsQtVcLgTAK37L2GocZgNF68VNa9tQwGbn
	 YYHmCsYjwTmymvXo4cLGypE2O9Hm9RKAmkGGGsImrkHtorqieMDn+wLAOKZ4/ohGD3zvK
	 LWNuSlnSEAuSS8d7tYSQiON8ZlQbkRDkfr5aRDHymieHl7HvtK3zGFGhzK1b/hYe7xXjV
	 4vg4da462uSlt8GgqWn+u+Rog6UCj3qT5ktDfZUF9mdMcvkdBIhKu/Qz25kwnWJ2brQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272761;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xeETHbR/4mUu+1SxQCEL22frrz3AjHyV5ILmdrfiP0U=;
	b=l8rTZeQBryhGGK19FZjdTaO6/LiFSSOkLxGndTnRswveON1tajGhr+smb7IXHZLZYIWE
	 TsLmDSZ1ZvgrsquDFA4gHTIdGdSE3/NWuZlWCC1l06r9a2OXpyCNTU1WiDVRj8pq+sqjU
	 SnXCoFHfzVbpp/GWLe7gLLdIQ+eyu3r+TVT12v6LByhmoPUtb5f/v58tPn+xjgGzgNu+Q
	 tx6mQT/8TMDFmQxLGY+ssdaIOn1TDZqEGjWKFxj/vCQhKbnh+2mqkW5WDWqogX89gB512
	 nkNYxR1gSuboEN2IsI/AILEvova+AJ51QSyzUtHzYV6pO7ymQ5sqddxC/Go6KxTZzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaJDFGc5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20168606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OaJDFGc5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD1C1F0089F;
	Tue, 10 Nov 2026 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272761;
	bh=xeETHbR/4mUu+1SxQCEL22frrz3AjHyV5ILmdrfiP0U=;
	h=From:To:Cc:Subject:Date;
	b=OaJDFGc5Cv4q1OLByOUeyXX0HU4RbvmHQfNc8CXX3cPGpg3qtQfyQFDsIdW5o7jiS
	 0+lEejzMW72YKh7UcCclXH1D+0Q2lo4OxHpYk/L7Pzno0lzV8WrNpswUJD+4N5y6N9
	 DkV/VMPL8F5US5N7A9QJ3GNh5kHcwUeoZnf2WDyZ0AU1jp772fOQDAt09aEiqX/4Bx
	 swdfSSOiuFKXoKaxo5xd524xTTsvLFNe/P10FA5Mi3oJGHBgiHckRZEr+wGvkPIY0g
	 AQcp50AEzhYUPIDRZf0BJItQ3/u72XKag/C9ISuTbj9o0n7eMs8kgjzGmPrDladwVv
	 YqbOpAChZmaXA==
From: Sasha Levin <sashal@kernel.org>
To: zhaogongyi@bytedance.com,
	cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libata-scsi: reject data-in commands with a data-out buffer" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:59 -0500
Message-ID: <20261109200559-failed-6.18-a4845f077415@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a4845f077415ef32fe672c841e2fc58ae9e28273
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200559-failed-6.18-a4845f077415@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




