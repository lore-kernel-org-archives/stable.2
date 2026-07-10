Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B02D5926
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650581; cv=none; b=B0BObs/xTLmOVk3k8uE5jn6AjLj0GLtwm4hsMPkzbqvHXxfOWIh+XNby0Pz27vv/34+qbmw28vI68ZCLau230B6bBMg4w39lpGKhGqJfJ+D5p7l6t6o4rMvYIg3OjNAcVcU45Kz7IN/euNs9OomkjcFyyL7ns1JLlwq8hCNsLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650581; c=relaxed/simple;
	bh=0xR7aHWTe/ITOzofM0fEnD0N5azaQJKg215EeZ5MstQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNgJ04zanUubvz72/S0mFoLgfbKyg154A3Py/uEszmgmEt7hVTYedqbVyRUNNTgnUq77KiibSWeJdkjxsTy6rP2kUMlZHPr9tmXx39jkLcC7d5QgP1K8Qpft9LvYvAaFDKWXB8FaKyNcfmkf6BlZgBgp1paAKpE3H9heUMTbego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXu0VNe7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXu0VNe7"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c167c58f2so2712531cf.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650579; x=1784255379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0wDYbfJ49+lBvuR6ZGZa4EeCwLvpXP1kmuJhSQU9pU=;
        b=nXu0VNe7sw6Ecayvuvzkxmmf0b+nN9//1ET/vXD9gUcwJnK4KZN1pByOwsvTdA0ShO
         XoQyYvwHXqnLIHJsZ7le82ShjdKib5zlXnB+dquZlrdflHdGkTBgIKnL8Z2UeOiX1OMg
         ZgUo9vjYaDYtygJkqEZvS6JiG8iLoLjggp+WZgvw9m32l6gFrdtIinDAStBkgwkrNSMP
         mgYvbK9aeWS8Y9uMjLvTh9J3QreNoHrEPv23JaiJqehEdYyVjxWG2veTZtVE3PFoxXFm
         VJZ36M4H3PEMKFFqOEghBxaaGC9oZ0Qm4/P+4af7u4U3w69Fmr1bYVq4ZZ/njjG6mO4f
         tE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650579; x=1784255379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0wDYbfJ49+lBvuR6ZGZa4EeCwLvpXP1kmuJhSQU9pU=;
        b=T51RJd7eWimmdxjX7zSvp/3Z+LQ+ZZ7Vfw1crUKIj1JhB2CM1fmeUzjp6AVKdrPFfc
         6ubHC1QR4OmQDR3COXaa65Yalb1EDRZ5kmum0HjOQ04kvS4oQ20PZf5FTnxIx1DdmBYQ
         2RT+xLEql6V+d3v10ClD5hoNWmEXp/tlcdeGdOWaXvddlFIhwrOVjWX0rUaGRtEsxK6R
         RHf7wxrn9D3u1cYzPCfQ1FKSV/RLti5saF4lP350ZKuOCR8U501nFv4zRWIM4A67kyup
         VzPNBE6zUpfDL6tztFFRuzOw8C9gGYvBMNPpFWcrC2btP2wZ0vb5tf/n2qWd0jkRPRj4
         pi+g==
X-Forwarded-Encrypted: i=1; AHgh+Rr7lkp9udc2MAF/JV2PD3EpTR3cU3bCUAIEehOSUCVU681VAyoMoNdtqdktIum/d37eh48HGX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTr4Feltw6T+ow0t2afwnjjZ1vN2Jr3g+UwW1AFiQbV150lqcg
	xDo9fgdza6lbPAtYMrV/IZUOfbZGUS9pVCx0uF30a3ud4Bmu1Lj2ym+C
X-Gm-Gg: AfdE7ck3Hpn9s7GvEfzWotrMjtW6U5Bb37MzyoPxZzZXlOZAxCXwpP63Hgw/Peeezi5
	UvZ1BS7hu3u2agPTP1To/f7NviD3LL5AWCMIrWDprji8fFS9wfzAKFDoe4hgiN/xbjncvQvBeUe
	AeW2fwb0JkLK/AfscviUAajJ3udzBv3ghCWvRrII3iBSL9oRBIHHgz8VYxM7PyHepteoPrMyogz
	SYy42BVKWmfYP9q6U54FmKy4NVTz1CRulrPLSX/RZuxBqEsa8wEAAosiJX2SzO41Z/XshUBaDwM
	0KdN+Etnn1pBSiRwoIwrlkwCkGVzGGjF74sghLIW1S7a2X9MrR7rlbAF82+G80cEhGcpjO4V3SK
	IWuNUmS0Mbx53+BIAWrzrmqQtDLUqmdWVhNzjdmstUosSAqzqUkz105PHvWXsSv03sPesa9xfH8
	WVYThqoNx/WrlCva18XLO9EwDzTxyxWJVKD+ZeHJfgSfpQ9Jx6KVEfYfHadqN1F7hmbpg+wedy4
	A1YwGRHto1Zt0IVuw7cyPN1wKWEJmjE
X-Received: by 2002:ac8:7e8a:0:b0:51c:7b12:5fec with SMTP id d75a77b69052e-51c8b42d223mr130403491cf.88.1783650578948;
        Thu, 09 Jul 2026 19:29:38 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b4fsm6951101cf.31.2026.07.09.19.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:38 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Justin Tee <justin.tee@broadcom.com>
Cc: Paul Ely <paul.ely@broadcom.com>,
	James Smart <jsmart2021@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] scsi: lpfc: bound EDC descriptor list by payload length
Date: Thu,  9 Jul 2026 22:29:31 -0400
Message-ID: <20260710022932.3741311-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710022932.3741311-1-michael.bommarito@gmail.com>
References: <20260710022932.3741311-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

drivers/scsi/lpfc/lpfc_els.c:lpfc_els_rcv_edc() trusts the EDC
descriptor-list length from the received frame without checking that it
fits in the actual ELS payload. An adjacent Fibre Channel fabric peer or
device can send an unsolicited EDC frame with a short payload and an
oversized descriptor-list length. The TLV walk can then read past the
receive buffer and trip a KASAN slab-out-of-bounds read in the LPFC ELS
receive path.

Impact: An adjacent Fibre Channel fabric peer or device can crash an
LPFC host via a malformed EDC ELS frame.

Pass the received payload length into lpfc_els_rcv_edc(), reject
truncated EDC headers and descriptor lists larger than the received
payload, and avoid logging a third payload word unless it is present.

Fixes: 9064aeb2df8e ("scsi: lpfc: Add EDC ELS support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

I reproduced this with a same-translation-unit KUnit/KASAN test on
f5459048c38a. Without the patch, the malformed EDC frame triggers
BUG: KASAN: slab-out-of-bounds in lpfc_els_rcv_edc after the benign EDC
control passes. With the patch, the benign and malformed KUnit cases
both pass.
 drivers/scsi/lpfc/lpfc_els.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index cee709617a313..5408b116f2d5a 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9409,13 +9409,14 @@ lpfc_els_rcv_fan(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
  * @vport: pointer to a host virtual N_Port data structure.
  * @cmdiocb: pointer to lpfc command iocb data structure.
  * @ndlp: pointer to a node-list data structure.
+ * @payload_len: received EDC payload length in bytes.
  *
  * Return code
  *   0 - Successfully processed echo iocb (currently always return 0)
  **/
 static int
 lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
-		 struct lpfc_nodelist *ndlp)
+		 struct lpfc_nodelist *ndlp, u32 payload_len)
 {
 	struct lpfc_hba  *phba = vport->phba;
 	struct fc_els_edc *edc_req;
@@ -9423,25 +9424,39 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	uint8_t *payload;
 	uint32_t *ptr, dtag;
 	const char *dtag_nm;
-	int desc_cnt = 0, bytes_remain;
+	int desc_cnt = 0;
+	u32 bytes_remain, desc_len, word2 = 0;
 	struct fc_diag_lnkflt_desc *plnkflt;
 
 	payload = cmdiocb->cmd_dmabuf->virt;
 
+	/* No signal support unless there is a congestion descriptor */
+	phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
+	phba->cgn_sig_freq = 0;
+	phba->cgn_reg_fpin = LPFC_CGN_FPIN_ALARM | LPFC_CGN_FPIN_WARN;
+
+	if (payload_len < sizeof(*edc_req))
+		goto out;
+
 	edc_req = (struct fc_els_edc *)payload;
-	bytes_remain = be32_to_cpu(edc_req->desc_len);
+	desc_len = be32_to_cpu(edc_req->desc_len);
+	if (desc_len > payload_len - sizeof(*edc_req)) {
+		lpfc_printf_log(phba, KERN_WARNING,
+				LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
+				"6468 Bad EDC descriptor list length %u: %u\n",
+				desc_len, payload_len);
+		goto out;
+	}
+	bytes_remain = desc_len;
 
 	ptr = (uint32_t *)payload;
+	if (payload_len >= 3 * sizeof(*ptr))
+		word2 = be32_to_cpu(*(ptr + 2));
 	lpfc_printf_vlog(vport, KERN_INFO,
 			 LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
-			 "3319 Rcv EDC payload len %d: x%x x%x x%x\n",
+			 "3319 Rcv EDC payload len %u: x%x x%x x%x\n",
 			 bytes_remain, be32_to_cpu(*ptr),
-			 be32_to_cpu(*(ptr + 1)), be32_to_cpu(*(ptr + 2)));
-
-	/* No signal support unless there is a congestion descriptor */
-	phba->cgn_reg_signal = EDC_CG_SIG_NOTSUPPORTED;
-	phba->cgn_sig_freq = 0;
-	phba->cgn_reg_fpin = LPFC_CGN_FPIN_ALARM | LPFC_CGN_FPIN_WARN;
+			 be32_to_cpu(*(ptr + 1)), word2);
 
 	if (bytes_remain <= 0)
 		goto out;
@@ -9471,7 +9486,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 				lpfc_printf_log(phba, KERN_WARNING,
 					LOG_ELS | LOG_CGN_MGMT | LOG_LDS_EVENT,
 					"6465 Truncated Link Fault Diagnostic "
-					"descriptor[%d]: %d vs 0x%zx 0x%zx\n",
+					"descriptor[%d]: %u vs 0x%zx 0x%zx\n",
 					desc_cnt, bytes_remain,
 					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
 					sizeof(struct fc_diag_lnkflt_desc));
@@ -9497,7 +9512,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 				lpfc_printf_log(
 					phba, KERN_WARNING, LOG_CGN_MGMT,
 					"6466 Truncated cgn signal Diagnostic "
-					"descriptor[%d]: %d vs 0x%zx 0x%zx\n",
+					"descriptor[%d]: %u vs 0x%zx 0x%zx\n",
 					desc_cnt, bytes_remain,
 					FC_TLV_DESC_SZ_FROM_LENGTH(tlv),
 					sizeof(struct fc_diag_cg_sig_desc));
@@ -10815,7 +10830,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		/* There are no replies, so no rjt codes */
 		break;
 	case ELS_CMD_EDC:
-		lpfc_els_rcv_edc(vport, elsiocb, ndlp);
+		lpfc_els_rcv_edc(vport, elsiocb, ndlp, payload_len);
 		break;
 	case ELS_CMD_RDF:
 		phba->fc_stat.elsRcvRDF++;
