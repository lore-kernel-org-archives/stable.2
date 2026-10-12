Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3404448D03
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790727; cv=none; b=MY++K89Zx7ozcxjb6XkoXIQR2Ku7leXIWqMlsKh5kTzgfMdW09W5Al2K2ug6WOp0rRyCil6E7pr/+ihTLs2SkvcBown3eXEyhy+T1PDH9ZVpFS+0QS93xEo0qqjBl+2ryJesbY063X2GFTM2k4PqenaXGKrh/TtxM6UiVxd7P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790727; c=relaxed/simple;
	bh=DeHgONwGOvPKRhitMl7KjVlAN7+DHObUJO88XdfNGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0a3wYlXnaE+tB4Vysy7LGF0mww9X2izvth7W5TjpIkmVjHnRebir5uKarhpliG6B0uCzbeKwcRL8YrhrWV5gd9qrgHwzAMdIIsoIFYMhgoxSLlLAV+E+WwGFsMw6rAPuhsvnJ6FQCR/d16fPmUGsTHGVANsKgYsy/53n4vfZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=janzi5iP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="janzi5iP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-86aecf49833so739712b3a.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791790725; x=1792395525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UlInBA7JKl335oYahoEr7gxTOB8Q4akEw+e1sscDqpY=;
        b=janzi5iPD3jNlWsnGRC8HoKbaBURNxki2vXHtD5rviw2Wce7nYNhRk6nShBNfMGq06
         6r/7F2SByoG6ERDOXI1ATmTgyEJswA4JNEW5lPA9b8c1CAtFPbC+pdd5vKm/BNwjIPh2
         tnfO4swnZ3lnb1tyzEpt8BlAfvm0F8nSJ7W2+/qgDLoav8HurUSCAWuNOn5yKmbOAWuM
         jcHH81eDSOoV0V2rmxVzJd1pg3tC8li4I0k0fKmZLLdkiDYEuN8ojSOAd4cy9iPtcKwz
         nLi/8r4WlLBy0gB5fDsv7JSG3SE12pD0+7PvPHtGopb0C1Fok02N6AeGkZGSk0t758gd
         Ve6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790725; x=1792395525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UlInBA7JKl335oYahoEr7gxTOB8Q4akEw+e1sscDqpY=;
        b=AXGTylzl0Biaz7j6XEWLRyyR9/tUIh3nvPJxw7kIFiD+f8y7DULISrRKqOV2ruB4AR
         67TR49DGc5yUaJYc/RhD4kgYyvGcxjsmS7ui24Ru892AnTxnxD0uNkAY1JmaiEJvcaqN
         mo+++IXzg2vLXHBCzhIbx7RsQGk1iJp5dFz/9WdnJar+E+0RMUjYO2W+5A0FStU3DBFe
         c4bbol4RoON7rBjF8FS0J/X4sgNJLh/e/6v9uLVIax6f4CPwr/2URwiYcVAKx622w/hE
         gOv111aI/bwG9egAGcDmpBC+AfNsjkzRx0Wze0bKuFwLRrLekAUqEhjODxlUBV5WCZZj
         GmVw==
X-Forwarded-Encrypted: i=1; AKwUvBwgvb6LTQqUEBcCzfr24oTvODUopvedFg8aCHkzJrmedCq7SastIH6GCGYeKENqNb6Ln+QAa/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmM98ezt8uFXfxgp5z9Y67xEKyaAcUub45tQQdEwtYEFK7CMGp
	7CgA6+XRRAtMKphI+bDVAD3ZskvZ1icVxvsbsFrei1eyNs531FQWm3j6L48ii2EGgrNrHgDKUfV
	Eyx2x
X-Gm-Gg: AYBFou2BllfcnCPXLf5wvms4l7YCnQ5yk0uZyL7XJrKIoJFftqjYlFHcJUcidU2pjGl
	3pnVp61vwBAov5BuqsX+Ffz3fWPhZUZ2QVwKtxQvYqdmZEVSY6oeurl8zR6gy2rSFh8VvTvKLbV
	RpSICoEgfqS9Z4p+/9Rf/uX0WhGgjAHvhMLi8QbSV7euDlsFnZtJMLQ+s0jQtXHZohOMnvFHNat
	BKGvGibRnZX0WZhHmtlvKYMClq2n6ADmLPhC9k3J2/eSOCgRDjqTLXpMNmc9LItRGHDHtkC78I5
	liC0EC53DeRI4EZ8hGySG3zJlxGIyjzvODTICKLtFAKIKZR93qLvXdBSLBmSimWAVTWgfs7jYAq
	S0O+UkG+g6JtRayNgjAZKE5ojB/SBuhD3kOfAiIrOJ5//gSNYwVa+uSbMj0HjL8IagojiETb1ys
	VtYZpO4+n6GUVzDAP5kk2bZzkkY16H6PGmMRF4+WlAr41CNMVmuw5cb8or8zeMP1/U9EkDElfpz
	8VppUMdNjXPyHu/
X-Received: by 2002:aa7:9308:0:b0:878:3705:571d with SMTP id d2e1a72fcca58-896a47e04b0mr5745255b3a.41.1791790725190;
        Mon, 12 Oct 2026 00:38:45 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-898c9ee8bc5sm2148780b3a.60.2026.10.12.00.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:38:44 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH 2/3] scsi: arcmsr: check the completion index the adapter reports
Date: Mon, 12 Oct 2026 16:38:27 +0900
Message-ID: <f0e71746bcdaabb1e105297ed86ddcf2245b0c86.1791789900.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791789900.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791789900.git.yhlee@isslab.korea.ac.kr>
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
can be anything up to 65535, while acb->pccb_pool[] has
ARCMSR_MAX_FREECCB_NUM (1024) entries of which only acb->maxFreeCCB are
ever filled in.  Nothing compares the two.

arcmsr_drain_donequeue() cannot stand in for the missing check: it
starts by reading pCCB->acb and pCCB->startdone, so by the time it can
notice anything the bad pointer has already been loaded and
dereferenced.  arcmsr_hbaF_postqueue_isr() rejects the single value
0xffff because that is its queue-empty sentinel, which leaves
1024..65534 accepted.

Reject an index the driver never handed out, in the two interrupt
handlers and in the polling path.

Measured with a KASAN build and a crafted completion queue.  struct
AdapterControlBlock is 17504 bytes with pccb_pool at offset 496, so a
reported slot of 60000 reads 480496 bytes in, past the end of the
controller block entirely:

  BUG: KASAN: use-after-free in arcmsr_hbaE_postqueue_isr+0x242/0x2d0 [arcmsr]
  Read of size 8 at addr ffff88800bf354f0 by task init/1

and the pointer it picked up then faults in arcmsr_drain_donequeue:

  RIP: 0010:arcmsr_drain_donequeue+0x27/0x360 [arcmsr]
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

A smaller out-of-range slot such as 2000 still lands inside the
controller block (offset 16496), so there is nothing for KASAN to
report; the driver simply reads an unrelated field of its own
AdapterControlBlock as a command pointer and faults on it in the same
place.

Fixes: 235090241c55 ("scsi: arcmsr: Add code for ACB_ADAPTER_TYPE_E")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 255f1d898079f..1381420d9fbd7 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -2677,6 +2677,11 @@ static void arcmsr_hbaE_postqueue_isr(struct AdapterControlBlock *acb)
 	pmu = acb->pmuE;
 	while ((readl(&pmu->reply_post_producer_index) & 0xFFFF) != doneq_index) {
 		cmdSMID = acb->pCompletionQ[doneq_index].cmdSMID;
+		if (cmdSMID >= acb->maxFreeCCB) {
+			pr_err_ratelimited("arcmsr%d: bad cmdSMID %u from iop\n",
+					   acb->host->host_no, cmdSMID);
+			break;
+		}
 		ccb = acb->pccb_pool[cmdSMID];
 		error = (acb->pCompletionQ[doneq_index].cmdFlag
 			& ARCMSR_CCBREPLY_FLAG_ERROR_MODE1) ? true : false;
@@ -2706,6 +2711,11 @@ static void arcmsr_hbaF_postqueue_isr(struct AdapterControlBlock *acb)
 		cmdSMID = acb->pCompletionQ[doneq_index].cmdSMID;
 		if (cmdSMID == 0xffff)
 			break;
+		if (cmdSMID >= acb->maxFreeCCB) {
+			pr_err_ratelimited("arcmsr%d: bad cmdSMID %u from iop\n",
+					   acb->host->host_no, cmdSMID);
+			break;
+		}
 		ccb = acb->pccb_pool[cmdSMID];
 		error = (acb->pCompletionQ[doneq_index].cmdFlag &
 			ARCMSR_CCBREPLY_FLAG_ERROR_MODE1) ? true : false;
@@ -3880,6 +3890,11 @@ static int arcmsr_hbaE_polling_ccbdone(struct AdapterControlBlock *acb,
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

