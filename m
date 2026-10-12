Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC5468C3A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805288; cv=none; b=u2IgYDGd02Q5V07IBmPQ/7iTkqtro75C6qOCuRrO88+Ojjgv20/15dem1hMExs/GmwbgrvoUbW0U/MjSbJUZtActMRRuXPzYBnkbdKDCkYW78ohCBtRRd/UH0VvJ8A/kGIvH2uldjySU8+MUFusrsDiF8vLAdWW8VoJ0N7TZ7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805288; c=relaxed/simple;
	bh=O/U2e+QqN9YMda8JFonKQPt+g/TRSqc4wUEQgFCYC+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk2/eciWlGnqpsEMoxrjryP4+96CNVii991ab8jOPEFo1rRGlEWO3zG3WLbYDr9qTKb//2MN5j5wt1HR20Ib4zA+EAdgjx2lnHSzjvCTRPtOb3rWPCySwIAnklzeIF3AIArwS341LxOyjRODH1rPKdWg9ZoNlu58zyjxy4u2IsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=fhBH8Ds0; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="fhBH8Ds0"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1433e7b057fso1108753c88.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791805287; x=1792410087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Gk+eLK+Afec/F5Dy8ncMcU+oQ9dTTafP2aI3GptknQ=;
        b=fhBH8Ds025mFgTDQhw6hqqxBkGTKMSxTt6QTDzzWO5W8N+6vRoIrdQCwuLeN5TRQWf
         HVlthfZWYKK3DWQnXwC0b9G7kZoVJZXyPzdIbD0zWDzLHZx7JXEqArsTTgaVgeBRNLz9
         4bdGhdRR1qzhqoTCHa76jS7onZVIHHi0456U7qyqu5kRHOILmCJZXvZalMF0yNYHASYS
         WQKjEi/F8lmDNEYM3J5dYXxlefsnxL0wjvKShH89Edt+nMSbaajopTZ2OSURPR8YCfpC
         D7ssoHP89eZvNCA3EZLx0TZrVeLp7OF9CEMEtZU2RIpntNpxEU/Dzp9wW36Jv/G/GTZk
         0L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805287; x=1792410087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Gk+eLK+Afec/F5Dy8ncMcU+oQ9dTTafP2aI3GptknQ=;
        b=gaH29T859KJJWN/4jtFhg/SP1LTgcE6XPmBwcnyFl0qnnLTRaHkY75xT/e3XSH6sdr
         ce+0pWkCur0YoiUy67qfFP2a/0Zf/M5ZD/gOzqjpCLkPWW8ODcFXLhAQcvxrlQgFJcWL
         Fgpo6xkEjZSiOZCkf/SZZLyWp8UBvFTCuaEL/8dAJsDoHyw7Sg6J/QHn3AFZCLvZh9zk
         CYWUV5Ff8lxhdS2oNodTJFyBn7AzMnR/WS9HMCR3Iy7s2rrf3YAIXPGjrrBdFCGTPV3A
         Qa0Jed8LyCwaUrqDryUpGpvF0t8taHQBdiKsHSWUH4jiQF0UiC4S1cz//YeX9JJ7kKcf
         qPVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRJAWja/dPT9pcbPRJ8fTRSnZbDD2KB/dnkc+6AZY0l1k3bahL1fKkCiYR01YDVXdI69p4T2g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLecklor/lN1xVpZM7zg/jCvRPygQWiVdRg+f9UJIuMk0BMCfTi
	9Sly/95i0/zxB1XUC+avaF8j6bmYpEENKHSiQEjMSZJUbomfR2ot4wCjBo+FJnhqb7A=
X-Gm-Gg: AYBFou3EBn+6rAv5pmh1201PZRqYDZiZPljlM5d2Q8I2U/yLVDQyKSHSl9RISL1DHBd
	m8DOtwCJW+Fa/A5oVOEnsyybFaSXfjYznfZhW3leUqVeAm+RKCfbcTh4aF32UuNMUesdeZYWKea
	+LkZgeVnq70dwAM2M/hyUXqghboDkCSqZoe0JEyBn+oI5oTCVHOH4OzvDcex2etQ5V7mrQyZRNU
	1SVtWibVWvWcfm9s3ayvNhbXwQEZbnto634VqDT/NpDmZG21Th/ohO/9T9CLV6BfMrMd8gFyWDu
	kMhAZM6iVJGLb039ipWyydhXjZ6oEwQs3t/5tLrNffUqows7Qpb/e1mdDb66blJd2HsYUiMTZzx
	j3FYHjGZJE3NZ/8tTsIVpXP0UArWyXlY+XKfAYqquilHqm+GmvSRxyrSjpTi5ftqsy+tZ7mNYuv
	GU2CYce85fOliq28e9SoORSZbfzxPMiztW+VGuxbbGlPR5Bezll26D2sfz2y0j7HuaoKVrj/3ij
	6aPK5wW1n7IvZUrlyFtDw==
X-Received: by 2002:a05:701b:42c4:10b0:15d:2387:b09a with SMTP id a92af1059eb24-16a6090df74mr14593599c88.31.1791805286466;
        Mon, 12 Oct 2026 04:41:26 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:7bd2:1202:246d:44ce])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm8725533c88.13.2026.10.12.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:41:25 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v3 2/3] scsi: arcmsr: check the completion index the adapter reports
Date: Mon, 12 Oct 2026 20:41:02 +0900
Message-ID: <4089c75829a7adfc3761af8ce775a980d16ccf02.1791803953.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791803953.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791803953.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On adapter types E and F the adapter reports a completed command by
writing its slot number into the completion queue, and the driver turns
that number straight into an array subscript:

	cmdSMID = acb->pCompletionQ[doneq_index].cmdSMID;
	ccb = acb->pccb_pool[cmdSMID];

cmdSMID is a uint16_t taken from DMA memory the adapter writes, so it
can be anything up to 65535.  Nothing compares the two.

arcmsr_drain_donequeue() cannot stand in for the missing check: it
starts by reading pCCB->acb and pCCB->startdone, so by the time it can
notice anything the bad pointer has already been loaded and
dereferenced.  arcmsr_hbaF_postqueue_isr() rejects the single value
0xffff because that is its queue-empty sentinel, which leaves
1024..65534 accepted.

Reject an index the driver never handed out, in the two interrupt
handlers and in the polling path.

Bound against acb->maxFreeCCB rather than ARCMSR_MAX_FREECCB_NUM.  The
array has ARCMSR_MAX_FREECCB_NUM entries but arcmsr_alloc_ccb_pool()
only fills [0, maxFreeCCB), and shrinks maxFreeCCB further if the pool
has to stop early at a 4GB boundary, so everything from maxFreeCCB up is
a NULL pointer.  Comparing against the array size would let those
indices through to be dereferenced.

Also clamp maxFreeCCB to the array in arcmsr_get_firmware_spec().  It is
derived from the host_can_queue module parameter and gets 64 added to it
when it is below ARCMSR_MAX_FREECCB_NUM, so with can_queue in
[961, 1023] it ends up above the array it indexes -- which the pool loop
itself then walks past.  With the clamp in place, maxFreeCCB is both the
populated range and a valid bound.

In the interrupt handlers, release the entry and step the queue index
before continuing, the same way the accepted path does.  Stopping at the
bad entry instead would leave the consumer index behind the producer,
so the adapter would re-raise the interrupt on an entry the driver has
already refused and the completions queued behind it would never be
reaped.

Measured with a KASAN build and a crafted completion queue.  struct
AdapterControlBlock is 17504 bytes with pccb_pool at offset 496, so a
reported slot of 60000 reads 480496 bytes in, past the end of the
controller block entirely:

  BUG: KASAN: use-after-free in arcmsr_hbaE_postqueue_isr+0x242/0x2d0 [arcmsr]
  Read of size 8 at addr ffff88800bf354f0 by task init/1

and the pointer it picked up then faults in arcmsr_drain_donequeue:

  RIP: 0010:arcmsr_drain_donequeue+0x27/0x360 [arcmsr]
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

A slot inside the array but above maxFreeCCB, such as 200 with the
default maxFreeCCB of 192, loads a NULL entry and faults in the same
place:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:arcmsr_drain_donequeue+0x27/0x360 [arcmsr]

Both are refused with the check in place, a queue holding a rejected
entry followed by a good one drains to the producer index and the good
completion is reaped, and valid slot numbers are accepted unchanged.

Fixes: 235090241c55 ("scsi: arcmsr: Add code for ACB_ADAPTER_TYPE_E")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 255f1d898079f..e635b76daae9a 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -2677,6 +2677,14 @@ static void arcmsr_hbaE_postqueue_isr(struct AdapterControlBlock *acb)
 	pmu = acb->pmuE;
 	while ((readl(&pmu->reply_post_producer_index) & 0xFFFF) != doneq_index) {
 		cmdSMID = acb->pCompletionQ[doneq_index].cmdSMID;
+		if (cmdSMID >= acb->maxFreeCCB) {
+			pr_err_ratelimited("arcmsr%d: bad cmdSMID %u from iop\n",
+					   acb->host->host_no, cmdSMID);
+			doneq_index++;
+			if (doneq_index >= acb->completionQ_entry)
+				doneq_index = 0;
+			continue;
+		}
 		ccb = acb->pccb_pool[cmdSMID];
 		error = (acb->pCompletionQ[doneq_index].cmdFlag
 			& ARCMSR_CCBREPLY_FLAG_ERROR_MODE1) ? true : false;
@@ -2706,6 +2714,15 @@ static void arcmsr_hbaF_postqueue_isr(struct AdapterControlBlock *acb)
 		cmdSMID = acb->pCompletionQ[doneq_index].cmdSMID;
 		if (cmdSMID == 0xffff)
 			break;
+		if (cmdSMID >= acb->maxFreeCCB) {
+			pr_err_ratelimited("arcmsr%d: bad cmdSMID %u from iop\n",
+					   acb->host->host_no, cmdSMID);
+			acb->pCompletionQ[doneq_index].cmdSMID = 0xffff;
+			doneq_index++;
+			if (doneq_index >= acb->completionQ_entry)
+				doneq_index = 0;
+			continue;
+		}
 		ccb = acb->pccb_pool[cmdSMID];
 		error = (acb->pCompletionQ[doneq_index].cmdFlag &
 			ARCMSR_CCBREPLY_FLAG_ERROR_MODE1) ? true : false;
@@ -3572,6 +3589,8 @@ static bool arcmsr_get_firmware_spec(struct AdapterControlBlock *acb)
 	acb->maxFreeCCB = acb->host->can_queue;
 	if (acb->maxFreeCCB < ARCMSR_MAX_FREECCB_NUM)
 		acb->maxFreeCCB += 64;
+	if (acb->maxFreeCCB > ARCMSR_MAX_FREECCB_NUM)
+		acb->maxFreeCCB = ARCMSR_MAX_FREECCB_NUM;
 	return rtn;
 }
 
@@ -3880,6 +3899,11 @@ static int arcmsr_hbaE_polling_ccbdone(struct AdapterControlBlock *acb,
 			doneq_index = 0;
 		acb->doneq_index = doneq_index;
 		spin_unlock_irqrestore(&acb->doneq_lock, flags);
+		if (cmdSMID >= acb->maxFreeCCB) {
+			pr_err_ratelimited("arcmsr%d: bad cmdSMID %u from iop\n",
+					   acb->host->host_no, cmdSMID);
+			continue;
+		}
 		pCCB = acb->pccb_pool[cmdSMID];
 		poll_ccb_done |= (pCCB == poll_ccb) ? 1 : 0;
 		/* check if command done with no error*/
-- 
2.43.0

