Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293671;
	b=LU/y9e9LoGGvTIvUK3gRJ5LluXKk/C2cH8JcYeMrG6dt5uVtlzR1zJfrsboNjWHg0UH6
	 ARg3Xv3mO614Mug72kLJ/lvgyN0vRVAv0bsmPZllyy/13qtlyiPqer/xdIkDhIKmeJ6B5
	 u1fX2N8NJfA/2ouMzyJiR5kFSa81uTztaCyLlVThHUiISshKegwqcsmgyaHf/cJJz+7U5
	 Ct9IgKUx4ZDmjUBYUrPdC3ZkEw6MGG72AD3HbDEVKW4UPInPuCEXXaPYBhnDNxqTnT91x
	 Wvl01fNRVrJ5ahpqke6rcCxkBDE3j3xrt5O6uTDbMDdfc9ppSm3tp6I4qIUFc7YVNPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293671;
	h=DMARC-Filter:DKIM-Signature:Date:Content-Type:Mime-Version:
	 X-Lms-Return-Path:X-Original-From:Content-Transfer-Encoding:X-Mailer:
	 To:Subject:Message-Id:Cc:From;
	bh=sP+DPAIHRyDY5BL/ReTkTAoRO1psvX04lxLyQm1cgCQ=;
	b=UiieH2CAtJDgl+yVuvdZdKQZ8hRZ16nC1Z+hubOYJipah+vAKpQBP/QEVlecZHUpw8/f
	 SGxxl8nduTdw0x6JM8H0YudUQV2Rcsgpwm5UhzT6fgVg7Ji1Oe3aM+VyCPpKUidCWMxP4
	 8Ye2N8XjHlT1orJGXOmTm9T2B0dCB5mRMNchAE82hhgVBiCjcawX3XvcT2P7ugs8QSiGl
	 c/+1pz/Ed7I5czuf62fDeLRIQCTUE9ZU4KHxqOSD0JxRQHwqm9NGqVrszBJ1Vjr/J8ia1
	 orfgPG/Sxlk84RW70NqVpJKLv+UyA9tnyZLWqDxf4zxR7CwgF8xfTkTfDmt2TwyDdVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=XzVUvMbg;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=XzVUvMbg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794293664; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sP+DPAIHRyDY5BL/ReTkTAoRO1psvX04lxLyQm1cgCQ=;
 b=XzVUvMbgX3no7zmTgUC2YFfcCjAh1YHxciYhGhU6JttLbSYQ6qSTCsT3jvXe/Y6gBaVWOO
 lTOwqGzR+/lAM4xZzgqliwZh+fEbMMl9GivkzzzJ12jbprGGGLT3p+iV3SRZSEtRzvvmEC
 uYuK77+rF7G26rYyPvJwd6yyjvEU6bC6+UaqUtiD5v+Zuro+5gLxQvwb0OodE8qq3VTZ+g
 Q4V+wm+tZ+z4EvU7usomiTCOHSZfAh4QQMol994vieK0BDJrk9AxMCDQtNhPwDCRB78Cwi
 hh8nEuWNuJH1v6lbcEZOR5dXAN6DaUOdQ4klevwQ3sNPjHTHK2Qto4d/K9Djgg==
Date: Tue, 10 Nov 2026 14:54:05 +0800
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26af2bf9e+0410cf+vger.kernel.org+zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
To: <stable@vger.kernel.org>
Subject: [PATCH 5.10.y] ata: libata-scsi: reject data-in commands with a data-out buffer
Message-Id: <20261110065405.45993-1-zhaogongyi@bytedance.com>
Cc: <cassel@kernel.org>, <dlemoal@kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>

[ Upstream commit a4845f077415ef32fe672c841e2fc58ae9e28273 ]

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

Backport notes: Use the older five-argument ata_scsi_set_sense()
interface and spell DATA IN BUFFER ERROR as ASC/ASCQ 0x4b/0x0a.
The older ata_scsi_rbuf_fill() takes struct ata_scsi_args;
get the device and command from args, and reject before copying.
In 5.10, reject before ata_scsi_rbuf_get(), since its matching
ata_scsi_rbuf_put() copies the simulated reply to the buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20261104130638.37882-1-zhaogongyi@bytedance.com
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 drivers/ata/libata-scsi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9b9e33f..ca44187 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1764,6 +1764,18 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
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
+		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0x4b, 0x0a);
+		goto done;
+	}
+
 	return ata_scsi_qc_issue(ap, qc);
 
 done:
@@ -1849,6 +1861,12 @@ static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 	struct scsi_cmnd *cmd = args->cmd;
 	unsigned long flags;
 
+	/* A data-out request may contain pages pinned without write access. */
+	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+		ata_scsi_set_sense(args->dev, cmd, ABORTED_COMMAND, 0x4b, 0x0a);
+		return;
+	}
+
 	rbuf = ata_scsi_rbuf_get(cmd, false, &flags);
 	rc = actor(args, rbuf);
 	ata_scsi_rbuf_put(cmd, rc == 0, &flags);
@@ -2674,6 +2692,13 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 
 	qc->complete_fn = atapi_qc_complete;
 
+	/* atapi_fixup_inquiry() writes to the buffer on successful completion. */
+	if (scmd->sc_data_direction == DMA_TO_DEVICE &&
+	    scmd->cmnd[0] == INQUIRY) {
+		ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0x4b, 0x0a);
+		return 1;
+	}
+
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
-- 
2.39.5 (Apple Git-154)
