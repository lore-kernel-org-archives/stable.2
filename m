Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310B3B47D5
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789206072; cv=none; b=Pijyhx+zEc/kzm9SzlJiW1cdzLITHTGvssBkAbRnraR3E17B4em3T7IpWZ4S7Tk3WMka3J3AgYBm/0ZoR10VaELCOpMUg9jrX71pXRrQrQwRBsXz9N0l5tshSNFCSvq7PhZHEu2L/M1KAOckIeOFMNzAU5LBUwIPMVS2SSbn83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789206072; c=relaxed/simple;
	bh=fvzxqf7pM0EWszKj6MSRzE26zroEJddeoZwwP/wHf68=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FKrxRW69KeV8d8EILEAI+oaZrevXLKExc4S2BjUvVEo3+fLZ5vvjxWZ6jXHetxFavw53H2t4yhtAvFXIG/oHdbjulAPaPxfvz8KOuKR24bXQecGIATOZfjEXZD0eZH+tLYgtkbzc3G+xaksACU5TvQw+Ij1GPuZtYdprAGFIIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpsZfOPM; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpsZfOPM"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4afc810bfso2809834a12.0
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789206070; x=1789810870; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MEw03QC+JSmM4SSD/Ogrqaba9N735GaiSihiR65530I=;
        b=ZpsZfOPMuoAbor6qEtVbCOC0AZ9ot/XYm8/peLnSCkqVR0Yy2t2noNct2TOBLjKOMk
         NTQaHso8bK7XoeEJtjZERyS24jqehc9ZLhCQTsKg5OR1TPoH+0ll9rwnW+ufFbfT2YaA
         Ni8QM/xgkVyRu54qx7/3F1kF7u5EMus/mPjtePQYuQ+9psI7+UsmI/JqzxloC5m9Tapq
         bPifiydJzgsTR9+QlSzKRTCWnsUukkxWZwIQCX8qt0LXz0uhsjuZkUd+T8UkDrot6D1T
         FANKpzSdnsM1saao8nqp5pM3oApJD9qkSHC4WLobtVBVnV3pK9OkMVrTT+CMZ9Wq4ZiW
         Xvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789206070; x=1789810870;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEw03QC+JSmM4SSD/Ogrqaba9N735GaiSihiR65530I=;
        b=Krr0fq6F5mHkNqwmrCcoLaK5MSgGtevTltsE1PiAK5Kjc2YM0ZyDXbM9BxDLHFNeV5
         Brc2letwC3zPr331xG+skYxpEtS+1Ku028fZbwnoNofs7qEJa3GYZsmqGDIQiPC+AaCa
         /NfJgphe6B/kjt1BFNxv39a5K/R2bUy1/td9Nz8wWXGwkv6fWY/gnmkp8lrwVAo/3sak
         P5dIAfAoaTyoBSy+UHcye9QQXUeocbCCWMUEEICa1TpesQrjOm2cpN3vGMcLkMVGa4E8
         YdadFjciS/blksPOga0+G2GQnQFrRkakenUITrcCD8CDlx7bie8cGYkEgV6/dkmqAUFt
         +5oA==
X-Forwarded-Encrypted: i=1; AKwUvBzxzoKDD2KhOnKXRe9W8rktCNCXHTLbZueh0MMocEYAN4OV1b45BM+AW1Vf1WjobGLRw/Eak2c=@vger.kernel.org
X-Gm-Message-State: AFuF++lWBpAE68z1fTF7ZdzngZpo+2BK9c9GFUhgpAU7+j5ByplugZTe
	6MeQG6ZOKQtShk+x9k0EDJh/zdJTdgoFLfu2BrkNaoGc6opl+5TyUt5kEn4ZHsozF8h0o0LY9l0
	UbNG8VXB60gA8Sf0oBnNs5A==
X-Received: from pjbmv23.prod.google.com ([2002:a17:90b:1997:b0:39d:9080:e1e1])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:581:b0:39d:b4a8:92f3 with SMTP id 98e67ed59e1d1-39db4a89bf3mr2048256a91.1.1789206069981;
 Sat, 12 Sep 2026 02:41:09 -0700 (PDT)
Date: Sat, 12 Sep 2026 17:41:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912094107.2098303-1-stanleyjhu@google.com>
Subject: [PATCH v2] scsi: ufs: core: Quiesce SCSI devices instead of host
 tagset during error handling
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@sandisk.com>, Peter Wang <peter.wang@mediatek.com>, 
	Brian Kao <powenkao@google.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
switched UFS internal commands to allocate requests on
hba->host->pseudo_sdev->request_queue, which shares the host tagset with
regular LUNs.

During error recovery, ufshcd_err_handling_prepare() calls
blk_mq_quiesce_tagset(&hba->host->tag_set), marking all queues in the
tagset as quiesced, including pseudo_sdev->request_queue. When
ufshcd_verify_dev_init() subsequently issues internal commands (e.g. NOP
OUT UPIU) via blk_execute_rq(), blk_mq_run_hw_queue() skips running the
quiesced queue, resulting in an unrecoverable circular wait deadlock.

Resolve this by quiescing only the logical units attached to the host via
shost_for_each_device() during error handling. Because
shost_for_each_device() skips pseudo SCSI devices (via
scsi_device_is_pseudo_dev() in __scsi_iterate_devices()), pseudo_sdev
stays unquiesced and internal commands can be dispatched and completed.

Keeping the logical units quiesced preserves behaviour that predates the
current call. Until commit 2a36646012fc ("scsi: ufs: core: Simplify
ufshcd_err_handling_prepare()"), the prepare path called
ufshcd_scsi_block_requests() to hold off new commands in addition to
blk_mq_wait_quiesce_done() to wait for the ongoing ones; folding both
into blk_mq_quiesce_tagset() kept that behaviour. Waiting without
quiescing would drop the first half, so the queues stay quiesced here.

Clock scaling and command pause (ufshcd_pause_command_processing) paths
continue to use blk_mq_quiesce_tagset() as they require freezing all
queues including internal commands.

Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/6f78c4bd-a70b-402d-abfd-599091b67674@acm.org/
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
v2:
- Commit message only; no functional change.
- Fix the Link: tag, which cited a Message-ID that is not in the archive.
- Explain why the logical units stay quiesced, referring to the behaviour
  that predates 2a36646012fc, instead of the vague claim about retry storms.

 drivers/ufs/core/ufshcd.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a25b6a0cb5c6..1ca731675ad1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6781,6 +6781,23 @@ static void ufshcd_clk_scaling_suspend(struct ufs_hba *hba, bool suspend)
 	}
 }
 
+static void ufshcd_quiesce_all_sdevs(struct ufs_hba *hba)
+{
+	struct scsi_device *sdev;
+
+	shost_for_each_device(sdev, hba->host)
+		blk_mq_quiesce_queue_nowait(sdev->request_queue);
+	blk_mq_wait_quiesce_done(&hba->host->tag_set);
+}
+
+static void ufshcd_unquiesce_all_sdevs(struct ufs_hba *hba)
+{
+	struct scsi_device *sdev;
+
+	shost_for_each_device(sdev, hba->host)
+		blk_mq_unquiesce_queue(sdev->request_queue);
+}
+
 static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 {
 	/*
@@ -6816,13 +6833,13 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_clk_scaling_allow(hba, false);
 	}
 	/* Wait for ongoing ufshcd_queuecommand() calls to finish. */
-	blk_mq_quiesce_tagset(&hba->host->tag_set);
+	ufshcd_quiesce_all_sdevs(hba);
 	cancel_work_sync(&hba->eeh_work);
 }
 
 static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 {
-	blk_mq_unquiesce_tagset(&hba->host->tag_set);
+	ufshcd_unquiesce_all_sdevs(hba);
 	ufshcd_release(hba);
 	if (ufshcd_is_clkscaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
-- 
2.55.0.1007.g17ff1f9808-goog

