Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80353DDAFD
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965334; cv=none; b=hE8Jsxkb84wrKW5z9Bmt282RG12Be9uLggvfQ9tyrAVv1QgcKSPKq/Vp4cUuXw9kP3j6x/SGxefbpWO4r1QY7sU84u2BHRXPWWzX3hfHpLIZ1Bt0S1CYKBhtKuW6O3An4K7fAaTCxt6eKXpPv7tiT3OGGEFrjtOooVTXX7zV6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965334; c=relaxed/simple;
	bh=XA/LcG30A89I8ibW3HrALMPwb0k1N71VAQSji6GdAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3Ox+y5coQud4jTf15VBkzlWVFrNc5f8hUL36vnwZxdfOER+VoQDAzCx2IVymos8pAT/NThsgVA0DuhvpHZT2kr20LkvfEPtWn2awb0lNCa8XUNC0GU26MmHScgGfNV3abO/yTa+LMmrXhi86NDovtwQ1kqF5iYAsk2VLPyIT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=an391FoY; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="an391FoY"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bcb929cceso2715830eec.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790965332; x=1791570132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzkpjE5EmLze0PzWkZvxDWKx3hV+CThhGbSmB1rf5Sc=;
        b=an391FoYka0prLu2V6wwZzqJnKoXdnHR1Z/wMOWQWXae0RwMwKAJsYoXqeS8VIZB3+
         +CxB8B+jQSMm8N/isnGdTndUIWg10kmbWAw7xMjiXP2CUyF8cyZv8S+fKmGmD3wnvLrS
         /PUo4QEuMC98MNQlzsv9jul3RWDUbc40DfIvckDseOOegXh7iDyqK4M7fie0zHs6NgO7
         0NaZfzTfuC+dRjNLnCcxTBCer3p9L+Onj2xyUC12cM4xqG51muUP1c5CphImO7alodIG
         3Mx4ZfYSeCoLy10ORSd9Xnuwokngk4l5p66GVMYdNrrrhz7YA8gPGAtHlE++Q7waRKR1
         JYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965332; x=1791570132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzkpjE5EmLze0PzWkZvxDWKx3hV+CThhGbSmB1rf5Sc=;
        b=gd5Os7xJ1V8dboxKvbIvIf3/D0rl1vEUIGwQtCxo9OYNUV1YeNfWqgxJKheyGM+a9/
         MNfvk/jDra5buiIQlU4qtuCxSkEkT33xeg+WbeSdrn6+nJgQ9pyGOVKRu9Yl1hJEK0yg
         3shlvr8vyDIfbhAK7pLj6coza1DA6Ki7tdUSB5LkZXfetZZEID8c/0QPOis+okAMgSCc
         /qA8QJiI6rjBeravCven9+4OAZTv8A1isnThmWIMP1eWpY40xnbaJ1WbXHBg03qHpAWl
         +1dECfIwUq0bIRkEVGUYgojwmvmeuwFFDpFrrMQnlQCS07LAjB0oZ4wXWP6EWbNXLUE+
         UhWA==
X-Gm-Message-State: AFuF++naWKhefn10FcQGpyRCpI4ir98mZ1o/UAv1Y6qq2abwIIsfwyLI
	q7ow1bN1b5xW0czDl/c2pLE5qYwV1eN8/K2SWfYXXbiw6NrZ3vv7aNNVwOu5WFLXpMFHcKq/ZXo
	OlCUf0VgKDA==
X-Gm-Gg: AYBFou2kOgCwG1XVycX20DS5uOVpojiRA8x8UiNApRorT6G6THoI+I2wHr5xgEGsPIs
	qDx8ul0Oj6OEZO3lirF79F1FhtcYsu38smp3S6O7jO8h0EfWWSIdPCA9gFKEZ93Qfs0L/KjsEB6
	Sl/3mxdhMd+kheLZmgE3r7ZKQEdlX8U7FKFSjIKQgL+uFuZQModUaE79j+m469w7aKz7Zg6kGnj
	MH0h3DNNhmYTW+wiS+psObJzViugratJViy6c1Wg9LlXtFevr1ujT/RpUD/nLExWSrDRAbxxqbC
	ss3qTP2xPMYGv5f6ltFgtQBDA1HNXOvacfoHEFiOBiwdeQTbkdgpYWK1Qgo0bl4NxVga7nsvqEp
	DpsIgXqQ7EkRh9sAXBehTZ0/xtO21XEupnZ0NTi6KmRYIXiRQ1XJvxVDaAvZcidF7iqiHtMhknQ
	JrVZJGaIStKiob8AfcG3+NkmcOVA1AuglVpZRTriHP0nXFIg2zRaRoEVw1NylKcvDwQN+GjalP9
	OotPLSXDljJ/IHwIBSZ2ZDyBMttf5DTd6F3wTrBC0j3xSK9VwH9K+e31Jt734JUw2UxAio=
X-Received: by 2002:a05:7300:c38f:b0:34c:f181:85dc with SMTP id 5a478bee46e88-34f219cc55fmr3872366eec.41.1790965331728;
        Fri, 02 Oct 2026 11:22:11 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm10551449eec.4.2026.10.02.11.22.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 11:22:11 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Ely <paul.ely@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	James Bottomley <jejb@linux.ibm.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Martin Petersen <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.6.y v2 1/2] scsi: lpfc: Define lpfc_dmabuf type for ctx_buf ptr
Date: Fri,  2 Oct 2026 14:22:02 -0400
Message-ID: <20261002182205.11550-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002182205.11550-1-artem@trailofbits.com>
References: <20261002182205.11550-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 115d137aa918d879e3cca9605bbf59e0482aa734 ]

In LPFC_MBOXQ_t, the ctx_buf ptr shouldn't be defined as a generic void
*ptr.  It is named ctx_buf and it should only be used as an lpfc_dmabuf
*ptr.  Due to the void* declaration, there have been abuses of ctx_buf for
things not related to lpfc_dmabuf.

So, set the ptr type for *ctx_buf as lpfc_dmabuf.  Remove all type casts on
ctx_buf because it is no longer a void *ptr.  Convert the abuse of ctx_buf
for something not related to lpfc_dmabuf to use the void *context3 ptr.

A particular abuse of the ctx_buf warranted a new void *ext_buf ptr.
However, the usage of this new void *ext_buf is not generic.  It is
intended to only hold virtual addresses for extended mailbox commands.

[ Backport to 6.6.y: retain only the ext_buf member and the corresponding
  extended-mailbox producers and SLI3 copy sites. The remainder of the
  upstream context-pointer cleanup depends on earlier patches in the lpfc
  14.4.0.1 series and is unrelated to this timeout fix. Keeping the SLI3
  payload in ext_buf leaves ctx_buf pointing to its DMA descriptor through
  late completion and cleanup. ]

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240305200503.57317-10-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c |  2 +-
 drivers/scsi/lpfc/lpfc_els.c |  4 ++--
 drivers/scsi/lpfc/lpfc_sli.c | 20 ++++++++++----------
 drivers/scsi/lpfc/lpfc_sli.h |  1 +
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 0166f86c7b71a..d5febd2119ad6 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -4747,7 +4747,7 @@ lpfc_bsg_issue_mbox(struct lpfc_hba *phba, struct bsg_job *job,
 	if (mbox_req->inExtWLen || mbox_req->outExtWLen) {
 		from = pmbx;
 		ext = from + sizeof(MAILBOX_t);
-		pmboxq->ctx_buf = ext;
+		pmboxq->ext_buf = ext;
 		pmboxq->in_ext_byte_len =
 			mbox_req->inExtWLen * sizeof(uint32_t);
 		pmboxq->out_ext_byte_len =
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2e9972a587810..8ef571498d846 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7300,7 +7300,7 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 		mbox->in_ext_byte_len = DMP_SFF_PAGE_A0_SIZE;
 		mbox->out_ext_byte_len = DMP_SFF_PAGE_A0_SIZE;
 		mbox->mbox_offset_word = 5;
-		mbox->ctx_buf = virt;
+		mbox->ext_buf = virt;
 	} else {
 		bf_set(lpfc_mbx_memory_dump_type3_length,
 		       &mbox->u.mqe.un.mem_dump_type3, DMP_SFF_PAGE_A0_SIZE);
@@ -7360,7 +7360,7 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 		mbox->in_ext_byte_len = DMP_SFF_PAGE_A2_SIZE;
 		mbox->out_ext_byte_len = DMP_SFF_PAGE_A2_SIZE;
 		mbox->mbox_offset_word = 5;
-		mbox->ctx_buf = virt;
+		mbox->ext_buf = virt;
 	} else {
 		bf_set(lpfc_mbx_memory_dump_type3_length,
 		       &mbox->u.mqe.un.mem_dump_type3, DMP_SFF_PAGE_A2_SIZE);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index c88e224feed8a..fd726348cb693 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9558,8 +9558,8 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 		}
 
 		/* Copy the mailbox extension data */
-		if (pmbox->in_ext_byte_len && pmbox->ctx_buf) {
-			lpfc_sli_pcimem_bcopy(pmbox->ctx_buf,
+		if (pmbox->in_ext_byte_len && pmbox->ext_buf) {
+			lpfc_sli_pcimem_bcopy(pmbox->ext_buf,
 					      (uint8_t *)phba->mbox_ext,
 					      pmbox->in_ext_byte_len);
 		}
@@ -9572,10 +9572,10 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 				= MAILBOX_HBA_EXT_OFFSET;
 
 		/* Copy the mailbox extension data */
-		if (pmbox->in_ext_byte_len && pmbox->ctx_buf)
+		if (pmbox->in_ext_byte_len && pmbox->ext_buf)
 			lpfc_memcpy_to_slim(phba->MBslimaddr +
 				MAILBOX_HBA_EXT_OFFSET,
-				pmbox->ctx_buf, pmbox->in_ext_byte_len);
+				pmbox->ext_buf, pmbox->in_ext_byte_len);
 
 		if (mbx->mbxCommand == MBX_CONFIG_PORT)
 			/* copy command data into host mbox for cmpl */
@@ -9698,9 +9698,9 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			lpfc_sli_pcimem_bcopy(phba->mbox, mbx,
 						MAILBOX_CMD_SIZE);
 			/* Copy the mailbox extension data */
-			if (pmbox->out_ext_byte_len && pmbox->ctx_buf) {
+			if (pmbox->out_ext_byte_len && pmbox->ext_buf) {
 				lpfc_sli_pcimem_bcopy(phba->mbox_ext,
-						      pmbox->ctx_buf,
+						      pmbox->ext_buf,
 						      pmbox->out_ext_byte_len);
 			}
 		} else {
@@ -9708,9 +9708,9 @@ lpfc_sli_issue_mbox_s3(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmbox,
 			lpfc_memcpy_from_slim(mbx, phba->MBslimaddr,
 						MAILBOX_CMD_SIZE);
 			/* Copy the mailbox extension data */
-			if (pmbox->out_ext_byte_len && pmbox->ctx_buf) {
+			if (pmbox->out_ext_byte_len && pmbox->ext_buf) {
 				lpfc_memcpy_from_slim(
-					pmbox->ctx_buf,
+					pmbox->ext_buf,
 					phba->MBslimaddr +
 					MAILBOX_HBA_EXT_OFFSET,
 					pmbox->out_ext_byte_len);
@@ -13822,10 +13822,10 @@ lpfc_sli_sp_intr_handler(int irq, void *dev_id)
 					lpfc_sli_pcimem_bcopy(mbox, pmbox,
 							MAILBOX_CMD_SIZE);
 					if (pmb->out_ext_byte_len &&
-						pmb->ctx_buf)
+						pmb->ext_buf)
 						lpfc_sli_pcimem_bcopy(
 						phba->mbox_ext,
-						pmb->ctx_buf,
+						pmb->ext_buf,
 						pmb->out_ext_byte_len);
 				}
 				if (pmb->mbox_flag & LPFC_MBX_IMED_UNREG) {
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index cd33dfec758c0..350bd4f147e83 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -184,6 +184,7 @@ typedef struct lpfcMboxq {
 	struct lpfc_vport *vport; /* virtual port pointer */
 	void *ctx_ndlp;		  /* caller ndlp information */
 	void *ctx_buf;		  /* caller buffer information */
+	void *ext_buf;		  /* extended mailbox payload */
 	void *context3;
 
 	void (*mbox_cmpl) (struct lpfc_hba *, struct lpfcMboxq *);
-- 
2.39.5

