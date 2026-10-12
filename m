Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0983471269
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795734; cv=none; b=rWCNa1hj2K4+K14FH8OBxxIfR+cuI//+sFzFFLNEA7EA+AePfwby2EV18KG38Xf6XtbDm47p1u49Thh58sBSLuXTa+MVGnqTkrxSOUwxT+HHEXa3Vx1FiTgGr2vEb/Y+7GKOBbuE3W91+Q02/4wJEbnw7mHLD32XEXezf05iiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795734; c=relaxed/simple;
	bh=1mryeQI47wEbsjOwSPFsxuqQGczGchnMTagE/QelKcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqgZkFSncVOJzXyzQ5XwfMwcX8jfzNunDYfsqADLOEjYrHnoRS0cQZX1c9PhhUAkgdx4OaIGPKoJv3erAoAZmaWbGak9doHcBOuNWPUgIrUgj/td6ZbHTWDHJogBizHeubZcz6PVieSAlMOXBpUTs8hJQVfl3noEJlPFs+auKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=xvSMpfyQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="xvSMpfyQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso897905ad.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791795732; x=1792400532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eeSDPQo+FqQoQRBVVkhRhWFGqoR5OOlMgwCNRH1vZa8=;
        b=xvSMpfyQF353QUxniNO0i6Cw5HWC1hVV3e1NuFivTw9TibQrUxkNjITX/7NbTdbQn4
         d/ziLWJJ0Lfvo0fu620/VvnMJyeD3aRd11XMBg/FpbYPta9fiwOKCp9mSf0mjgQaZJrT
         sKYumJ8CZGV9QKW6BEtVRAhBkscHmiWRY/Tk4g8/S9bvHImNssoTZtNpNYSY4lL8+aLr
         39Jcq07oUW7GmKbYdAtIqPErP3FgFcGLsIT6IrtBUIYOJ1qK38+DsWfjrBEkfWqH2ZrC
         Vrelg/Z1CSK5z7pO8fQrSrFI0iDJ0FTeYbhVGhTXMbX6P+6qLOGiPPI3RG0tBXI4GF84
         WxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791795732; x=1792400532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eeSDPQo+FqQoQRBVVkhRhWFGqoR5OOlMgwCNRH1vZa8=;
        b=pFXAnDjqN+2ByNNJ942KDprcxiTCOWKxsZZASjfsMCuPc7YLGz1aaI55Ej3SrKxQjF
         vEjuOQhItLsL9GrhIGngzxRRhERcEOHhcjhi/lI0jHDhELoZ5Hk3+uVQ/CtnA4kwm9Fk
         etbDVr8ryp7QU41LeY0gE4dc9sbLxxa+FG7tIh32UM2v/LgdJJdV4j3EBvbMUZSdPOUC
         mKfb0uV+sUAAhzeaKd5oCJSUrX+nlYp+4TLcti6RAnRqsBMCUGldpf9IG1kjluYGtJzv
         kJnfWvmD48BA17N+8F9h+XLC8HFJr8Hfdq09aJGm4GlySYg7Kbv4iZsCv8QhSLapJcFa
         N9cw==
X-Forwarded-Encrypted: i=1; AKwUvBwnhK4AWXFmyeN8EHziPpQ3QqERFqYws+I/50uL0AiqNMpQcIuhER9a3fSPFqejgSRKhmLbomk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5h785H4gTxWFnSU/vb3s5uSeaRBCWL5aLa2vmP1emxeu94Pko
	s3C7EO5rK3kWzFMiM32TYIeA+Uu91aRZhKtX3JMOjM1GZbzcNQQldWT/IvnnXTHH/Uc=
X-Gm-Gg: AYBFou2ObFdEwoJzvN2lAns1Y0aRNV9zxi5BrQCBe6OUX6tdlDTR+fQHjqCRYWBFRTm
	8Ck5Tgfte4GRZXi6/ke9BwgnFJhX+7SuIhpMUEXJ54uThvPr/FQfC8lMhV29hfHoL2ZrwfJOifF
	EZ+/XVwg5ZCkOipPu/M4ZnEr024B66dVzGTD/e8BfoIFsBfZ94cQ/1Lc3mRNoYttxjSUZM1RgZ+
	ubUClD3WZHsIq8LZCPdpXwodkPF5TySgA+CdZJpbSzOIL9X37vvsXDDVo1hJ474idH23PxN4ZFa
	0x9ebxyg+WFU8ge7EPMjMffrAdTBm72hW4c8dyMBBw4bCK04eAuady/AVUWouxeAU16vGmqqobl
	Opj7PpLlZYmKVY6RIAeTu+x7W7RbPU3yMuZlVXCjWiBRzS1vR4PElWe65jaLj074JHP48KkrMER
	oCujlaA0B4TSYLwF5Z8ih4tjedL+81xGeJhwY/NMzHdoOA0m3QgDuClrZylv8CzQR9Po7NdrwWM
	9ng2w==
X-Received: by 2002:a17:903:1585:b0:2e4:901b:9dc1 with SMTP id d9443c01a7336-2e842d030b7mr73824645ad.50.1791795732048;
        Mon, 12 Oct 2026 02:02:12 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4ebfsm41638795ad.78.2026.10.12.02.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:02:11 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v2 2/3] scsi: arcmsr: check the completion index the adapter reports
Date: Mon, 12 Oct 2026 18:01:47 +0900
Message-ID: <a9c7e18a8f392d216301a3e08b69a47d7981e1c9.1791792888.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791792888.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791792888.git.yhlee@isslab.korea.ac.kr>
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
ARCMSR_MAX_FREECCB_NUM (1024) entries.  Nothing compares the two.

arcmsr_drain_donequeue() cannot stand in for the missing check: it
starts by reading pCCB->acb and pCCB->startdone, so by the time it can
notice anything the bad pointer has already been loaded and
dereferenced.  arcmsr_hbaF_postqueue_isr() rejects the single value
0xffff because that is its queue-empty sentinel, which leaves
1024..65534 accepted.

Reject an index the driver never handed out, in the two interrupt
handlers and in the polling path.

Bound against ARCMSR_MAX_FREECCB_NUM rather than acb->maxFreeCCB, which
is what actually guards the array: maxFreeCCB is derived from the
host_can_queue module parameter and gets 64 added to it when it is below
ARCMSR_MAX_FREECCB_NUM, so it can be larger than the array and would let
a slot number past the end through.

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

A smaller out-of-range slot such as 2000 still lands inside the
controller block (offset 16496), so there is nothing for KASAN to
report; the driver simply reads an unrelated field of its own
AdapterControlBlock as a command pointer and faults on it in the same
place.  With host_can_queue raised so that maxFreeCCB becomes 1087, a
reported slot of 1050 faults the same way while comparing below
maxFreeCCB.

A queue holding a rejected entry followed by a good one drains to the
producer index and the good completion is reaped; valid slot numbers are
accepted unchanged.

Fixes: 235090241c55 ("scsi: arcmsr: Add code for ACB_ADAPTER_TYPE_E")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 255f1d898079f..9519715883b5a 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -2677,6 +2677,14 @@ static void arcmsr_hbaE_postqueue_isr(struct AdapterControlBlock *acb)
 	pmu = acb->pmuE;
 	while ((readl(&pmu->reply_post_producer_index) & 0xFFFF) != doneq_index) {
 		cmdSMID = acb->pCompletionQ[doneq_index].cmdSMID;
+		if (cmdSMID >= ARCMSR_MAX_FREECCB_NUM) {
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
+		if (cmdSMID >= ARCMSR_MAX_FREECCB_NUM) {
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
@@ -3880,6 +3897,11 @@ static int arcmsr_hbaE_polling_ccbdone(struct AdapterControlBlock *acb,
 			doneq_index = 0;
 		acb->doneq_index = doneq_index;
 		spin_unlock_irqrestore(&acb->doneq_lock, flags);
+		if (cmdSMID >= ARCMSR_MAX_FREECCB_NUM) {
+			pr_err_ratelimited("arcmsr%d: bad cmdSMID %u from iop\n",
+					   acb->host->host_no, cmdSMID);
+			continue;
+		}
 		pCCB = acb->pccb_pool[cmdSMID];
 		poll_ccb_done |= (pCCB == poll_ccb) ? 1 : 0;
 		/* check if command done with no error*/
-- 
2.43.0

