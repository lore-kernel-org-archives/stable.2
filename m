Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB341A503
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218989; cv=none; b=lwW+57D2lhZmjLQQxZDjm1v9PNW9lfbANKHNVdp3j/GHFNmuB2Z8mUSbJyLpuOZ6Rnx7XlfEdkzUdJA/yJLOhIBijGBQP2zOYfQO0caHSOh7Az3dLpUQ0xQyhzkUi1fhs1JsMRuSKBKFpIw+7lp4vEbHy+yfW5DHTpVGGsbgCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218989; c=relaxed/simple;
	bh=WBefzjrz2/CjXAIfyansE/nMcdxDRp4c0Q4PEl3UA9g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PUE6OcH9bIkeBYLi5bsXsKt9hs7UakRHE6SblcT0c0ru/KN4QKyMZi889NxLwDPqT2GYsGv/u7hoSLAW2kpbdPydFQ3HuSTeTAtIlWrnnsMVi9RprVrpfrrLLt2yOFJwfNhwTC0Q3vQ99kd5pfBuo+MX5KQ3eWG7spg2JBMAI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVeH/fYg; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVeH/fYg"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so2851100a91.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789218987; x=1789823787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+xx9uV4GIqiOlAAcl6ZWviwUg5PixHQSZ2d4jk5TG4=;
        b=eVeH/fYgj6rcHPDWc+/lYmutrRZ37RcG53qpL5qqhkJDqq0NqbQEPsB1ouVUPd4ahK
         C9YI3HMoAd0QcXy30U9MaG9wMwyVqjChUcu3BrIcMrl8E+4PrhUNDXCUJ+4reP+7pK5s
         rPr8zxEjTWqpjsPBNNaWuGeDMhG0QrMOvfBa1IS0QSB/D2BTe8Z94TDvDlKmaiVzGYJf
         uYULPh4dainBBeemDh/zB2ZJ6PsXPeN+prJ9s0V9lQn/uD8DRVnl2afVKQAl00lXtnbX
         UUuxou8ZluZAWiikwbYm98DwAlBwso/kRfj1XFlHqvLEit4TBwLfz40J77G73H3w9Fab
         CGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218987; x=1789823787;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+xx9uV4GIqiOlAAcl6ZWviwUg5PixHQSZ2d4jk5TG4=;
        b=ngTPyXTwswBgbI6CkhcjNWMFGvU4s4eLfabPoHM67LhbrtoVG9LLLEAn2HlVL43/M7
         MkCA4fqILcm8oLJZlw+N2ZGMSoM00K/NrIwLIuwVfzwHP1A1dvX/lnn2YPnpV22ZCnEA
         9s4sbdtDBs4pBiALjsunwqZHXOPBWSBrAHvjFXYXLgYB6lMDm9r+Q0u63AyOsBamqteA
         LAY5ZWeNacq/Og5zFTyF9K4B5apc2UGR1CzQDwrIVze7nhPfyS4TciBMYcIw2mdwfeev
         bBAbsKKTVcICo3kTzIO51xY3NNQLooKIibgS3w500qrieE0seNUJ2EAzwRKqqwM1MP3U
         sz2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxRAHZAgBy7BtWKPa+/V2WYAO+n7myLd3vtVJXWCaBYiKLeSW7RWowUS9D4cDyW1NyCA9jWsu8=@vger.kernel.org
X-Gm-Message-State: AFuF++lFxbcG4zzhVArOF8YBnUWn0YUFfrg7EnR8r6TwZrhUoRPkth6o
	R+DdTSgG7OslzeAv8XbzjH4GgX8l37XJ6Z4cU7d/1ju2d633jXJa6tlQ1ycFiFNN7VDHdxdvuWZ
	GvMM6m15NOhxZAu9eF0yZuQ==
X-Received: from pjwo14.prod.google.com ([2002:a17:90a:d24e:b0:39d:c293:4b7])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:134f:b0:39d:8eb5:e096 with SMTP id 98e67ed59e1d1-39dbc6a3e2emr4979778a91.15.1789218986868;
 Sat, 12 Sep 2026 06:16:26 -0700 (PDT)
Date: Sat, 12 Sep 2026 21:16:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912131625.2301486-1-stanleyjhu@google.com>
Subject: [PATCH v3] scsi: ufs: core: Keep internal commands dispatchable
 during error handling
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@sandisk.com>, Peter Wang <peter.wang@mediatek.com>, 
	Brian Kao <powenkao@google.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>
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

Keep quiescing the tagset and unquiesce the pseudo SCSI device on top of
that, so internal commands stay dispatchable while the logical units
remain quiesced. Re-quiesce the pseudo device before unquiescing the
tagset so that quiesce_depth stays balanced.

Clock scaling and ufshcd_pause_command_processing() are unaffected: they
keep quiescing the whole tagset, internal commands included.

Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/6f78c4bd-a70b-402d-abfd-599091b67674@acm.org/
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
Changes since v2:
- Keep blk_mq_quiesce_tagset() and unquiesce only the pseudo SCSI device,
  instead of iterating over SCSI devices, which skipped devices already
  being removed and left their request queues quiesced.
- Dropped Bart's Reviewed-by since the implementation changed.

 drivers/ufs/core/ufshcd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a25b6a0cb5c6..91270f8e45a2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6817,11 +6817,17 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 	}
 	/* Wait for ongoing ufshcd_queuecommand() calls to finish. */
 	blk_mq_quiesce_tagset(&hba->host->tag_set);
+	/*
+	 * Internal commands are submitted on the pseudo SCSI device. Let them
+	 * through so that the error handler can recover the link.
+	 */
+	blk_mq_unquiesce_queue(hba->host->pseudo_sdev->request_queue);
 	cancel_work_sync(&hba->eeh_work);
 }
 
 static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 {
+	blk_mq_quiesce_queue_nowait(hba->host->pseudo_sdev->request_queue);
 	blk_mq_unquiesce_tagset(&hba->host->tag_set);
 	ufshcd_release(hba);
 	if (ufshcd_is_clkscaling_supported(hba))
-- 
2.55.0.1007.g17ff1f9808-goog

