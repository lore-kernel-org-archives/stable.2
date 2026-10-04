Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A13E715E
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791085293; cv=none; b=enq031ZQmxOKxWFKpul9ltRMpFnMawcr/2jJ2+3m2oEgQFr7D/4yMrzWW8v4QofrWWc+0+7Ao6yCn3X/8BtY/MUd+KJf+9HsilQpP79TQz6GKkJER51iVGgXWOSiv9dH3VwoY69N51IczFzC/1G/mbc8vlZItwQF9GY7XweEVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791085293; c=relaxed/simple;
	bh=mtXZMLqLr5g9veYiMJstL74hAVNmvU1gSaLw2qIGZS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtKmKNmQY2nCy6oTLsC9ik8jb7Lnu1GeNAN5B8LnqgDzZ4ouxPeTWzVcIOTsukUn+5HpSS0Fzz/JwIEn14Kl7BGhAv6zabUZ1BrM/vMbnFRIeYcxCeBE0DjbBxys9CAO0OV757wRv+gZjFxtzAt2IvnrmwjaTFzTXbnZAxvmD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=XOA3SIMY; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="XOA3SIMY"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso943768eec.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791085289; x=1791690089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1YLIVr1Fakqkl2VaF1GTuGfoGj0C72l92imytXWUw0=;
        b=XOA3SIMYiVCC6rfHzq6B/EwfTmqtlfWW2aa3LJb9Vd6Het7eGcPWK0bDVBjcuZZmZT
         0mWUpb1faIbuI/cY34QyN7++oMN9oZKQ7bkYcqDUBcHV4x21c1dmsoMhmIKmp4/9pb9K
         IiZ+zdqiAGIdvZr86xtErD4eww8kXLmBPJFvoqEXAcxvrVoRF8YkUS7F7nl6EyqtYRDs
         s4+LiBXQW7YAWKLDfmScNalkv08CBIBASXh8Q3O2U/f1fh0Ow6ttfxCk+waySsgKDh2x
         5g22j4gC55njT1CAkwoN1tb2gCJD6CuVnI9u30yOGcVx94xaLvs84RhFZgapxr9TbCHj
         JiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791085289; x=1791690089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1YLIVr1Fakqkl2VaF1GTuGfoGj0C72l92imytXWUw0=;
        b=vTfUHDRF8Lwd12d1YaMc/+40fUgU3E6KuB34uWVmJozUYBguRRu70JKTJv8lrAJiP0
         THltVQLlrSVHtmFa6gyQ/StP5cngSUpwBSMjazEPb2mgp1RumndZUzQ4G2ez7vC8PRMu
         STe/P0/a0Bl+ll6JtcsKAFHr4BKUggLlNXW4CmB6XceKznftv2Afrqg5VpYZBQg/j+v3
         Skh2mQY0UJJALGvgWKxRsfOFiRXaYhfLbKm6ZQwkjSL+nuu3astddGt3LnfK4FQe8eQA
         kzY1bE7PmNGywz1pzHxKNYuiloai0aozOIoDXBx+G6FGGa2jW7XUcEucD8Suy5coGrz3
         aScQ==
X-Forwarded-Encrypted: i=1; AKwUvByN+LRLqFD+jVZT+HZvMgymyBCKYwrcbCPQpRX2nPUBDXnbWQHzsj1R0SUx4jr4fwZg5b0KafE=@vger.kernel.org
X-Gm-Message-State: AFuF++l/eFk3OFA6t+7R2jv3lcsN0gxWQRLlFNl+jVNqM3hxNruJcLwB
	29ZdMuUjWUAbcNCBDJ6pJiXDCZNnwcCe3W1z7ZfWi8jE/CY5zSyZ6kldeP2LJJ5TCUs=
X-Gm-Gg: AYBFou3onOHE0UDPZzNw1lv2clFkLxO0U9XD6idUvWGBQNZwHsW9I6e5gVmd8cC0Xg8
	FvErWEMWRdwqnODEmccV4KXEVJ4L9OLQWqEEJMDjkTIqHOchi27SygGCLcMq2/FpQqgt8I/59YG
	8oLsBtjNtEaYlqNZzdiBFKL5XegQHffoYgNYBGsgiLoX6HqN7FSlE4PliAzNGd0BUVSYkCdh+L+
	DIiY97hDg/RuB4t0/tcPYgFj4oPYEjGFj1n1wmJeI56G7ItD5C1uvyfqWvPH/W9LcoYOzSrQ6/K
	NpFHyGE210gbq1GmuIEe5gYBIMKeg273H/t08QcXrVdcN4ONqgNHzvET0GOzUnXCirnY4pA5nJ2
	cC2OkKPrexOe72VGlj67PTNc2pdsYKH0XJhzN60TVIkYqVbdv23tiQZAVcemt1KISrrkJHe1f5t
	+Bt/Xnou1b+xQh4/ciS7m/Jo8K+K2v8kInDiEvgD8afMOI3f7xesOoEMCd6VHorcwOht+0E8p0I
	fiaDgbScY62vzpIVlnqFeabU7Iv039inipAq0obJCNX4Rwf880bsTB2+M/EOXSIPKttv6I=
X-Received: by 2002:a05:7300:f818:b0:33c:14c9:c79d with SMTP id 5a478bee46e88-34f1506643emr8632451eec.9.1791085289071;
        Sat, 03 Oct 2026 20:41:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a817:e330:2fc8:fa47])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35127023cc6sm1122416eec.2.2026.10.03.20.41.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 20:41:28 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Paul Ely <paul.ely@broadcom.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	James Smart <James.Smart@Emulex.Com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/3] scsi: lpfc: Do not touch the SFP mailbox after a wait timeout
Date: Sat,  3 Oct 2026 23:41:25 -0400
Message-ID: <b65e363ff0c63b745de9dba1c1b9e0c988b2dda2.1790968549.git.artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790968549.git.artem@trailofbits.com>
References: <cover.1790968549.git.artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ede596b1434b ("scsi: lpfc: Handle mailbox timeouts in
lpfc_get_sfp_info") made the mailbox cleanup in lpfc_get_sfp_info_wait()
conditional on LPFC_MBX_WAKE, so that a timed-out mailbox is left for
its late completion.

Once lpfc_sli_issue_mbox_wait() returns MBX_TIMEOUT, the mailbox belongs
to the late completion, whose default handler frees it together with its
DMA buffer. Reading mbox_flag at the error label after a timeout is
therefore a use-after-free if the completion has already run.

The LPFC_MBX_WAKE test is also wrong when issuing fails immediately.
lpfc_sli_issue_mbox_wait() clears the flag before issuing, so the caller
still owns the mailbox but skips the cleanup, leaking the mailbox and its
DMA buffer. The A2 page dump does not check for an issue failure at all,
so it can report success with a zeroed page.

Never touch the mailbox after MBX_TIMEOUT, and treat every other
non-success return from either dump as a failure that the caller cleans
up.

Fixes: ede596b1434b ("scsi: lpfc: Handle mailbox timeouts in lpfc_get_sfp_info")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 52fc50589..ea8835515 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7410,12 +7410,12 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 	}
 	mbox->vport = phba->pport;
 	rc = lpfc_sli_issue_mbox_wait(phba, mbox, LPFC_MBOX_SLI4_CONFIG_TMO);
-	if (rc == MBX_NOT_FINISHED) {
+	if (rc == MBX_TIMEOUT)
+		goto error;
+	if (rc != MBX_SUCCESS) {
 		rc = 1;
 		goto error;
 	}
-	if (rc == MBX_TIMEOUT)
-		goto error;
 	if (phba->sli_rev == LPFC_SLI_REV4)
 		mp = mbox->ctx_buf;
 	else
@@ -7472,6 +7472,10 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 
 	if (rc == MBX_TIMEOUT)
 		goto error;
+	if (rc != MBX_SUCCESS) {
+		rc = 1;
+		goto error;
+	}
 	if (bf_get(lpfc_mqe_status, &mbox->u.mqe)) {
 		rc = 1;
 		goto error;
@@ -7482,7 +7486,7 @@ int lpfc_get_sfp_info_wait(struct lpfc_hba *phba,
 			     DMP_SFF_PAGE_A2_SIZE);
 
 error:
-	if (mbox->mbox_flag & LPFC_MBX_WAKE) {
+	if (rc != MBX_TIMEOUT) {
 		mbox->ctx_buf = mpsave;
 		lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 	}
-- 
2.43.0
