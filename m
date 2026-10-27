Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099300;
	b=jcKQ+L1rJUfFtlp30MKkozOzI3kFljF737Om34pjbZcmdOkWJn8MktCJ332c5YiYI1rG
	 YYsns3S69vIhDoEZEBJznliQSVjURzRC10vWcaBB2Fh3sx6YtBsQpABjuF5cGudMUgNLI
	 HPLByeEhBpciDT7si9q3lzK3ZozjF4DZGZT/1FiMpJbr730bEwDQGl/uQiksETzG37m88
	 5M0xQs5oBFDGM3Da0AAjtIv3bGYtXwwvwCsb14AlVS26xnwivxDpLk5hHt431O+nYKxbB
	 FgZGHTsTuG+d1DU7GXtxGhPUj4X90egLOAuj3wzhkhD4u8AV9kHsHUFrxmxrEVFVcWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099300;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:
	 Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:cpgsPolicy:
	 X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=J2d2zJ5HLBob4v1CtJnPXEx47rAgJ9b+O4LDKjyJETg=;
	b=4fVqOfFh/4NYFSNQBepShC0ZoQEbN84dC16XYkYjNQAOcWxoMGg6GW7agd94a4UUV1Gc
	 k9KFEPFZBdUGhFlvHHdXUfHTF3wkXo+ZWK90aTuYqQ643sVKSeMfKYFNm3kJH+V1kUyHO
	 QpqcwdhbyEtNZvLIa5GjcniZTDjptFm7orKuTWOk6WNYuAxdlyLh0XnoyvwnHbshk9tMy
	 5tQ36GR/gmmggQhL75MA4HfxlnZjiiAq9a1yddb/itE040Bv+MZfMhjwmD4DBHPdn3t7f
	 fcaesWK97Ym3gP0LKB9/mKMWiPNHKv7r1F1cJP1zlrWIJW3XgvwcVn4gbE4WOYxQ8BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="MoH/qVXp";
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697A606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E697A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MoH/qVXp
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261027110815epoutp014d0058d5f56fbdd59a008cae776bdd38~iXk8UR69T2757527575epoutp018
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:08:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261027110815epoutp014d0058d5f56fbdd59a008cae776bdd38~iXk8UR69T2757527575epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793099295;
	bh=J2d2zJ5HLBob4v1CtJnPXEx47rAgJ9b+O4LDKjyJETg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MoH/qVXp1KJnlmYOItify0XUtHFePB31y9JecR0hmjt6jSGvR5XNUfTH/s3+Nutjm
	 /rMdkHoawjN4G0v1TXQZpjscg8ob1cL9N61DDbXlRL+2tK0ZMXBQx4YkLEtVsaESso
	 RuT5PlRltBF0me6AXh1PsPePJdqPT2K80lhebMVM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20261027110814epcas2p276d32aee099ea7822dbe9495c9d4dcd4~iXk71-ODu0483304833epcas2p2F;
	Tue, 27 Oct 2026 11:08:14 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.202]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jDSQk40V1z6B9mB; Tue, 27 Oct
	2026 11:08:14 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20261027110813epcas2p4011de6cde600db5c995d3a3e45b056fb~iXk6uJPBq0449304493epcas2p4t;
	Tue, 27 Oct 2026 11:08:13 +0000 (GMT)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.81.221.204]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261027110813epsmtip2c36e1e5b4a84ca8655d87b84dd827fcb~iXk6pG0-l0549405494epsmtip2Q;
	Tue, 27 Oct 2026 11:08:13 +0000 (GMT)
From: HOYOUNG SEO <hy50.seo@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, bvanassche@acm.org, kwangwon.min@samsung.com,
	kwmad.kim@samsung.com, cpgs@samsung.com, h10.kim@samsung.com
Cc: HOYOUNG SEO <hy50.seo@samsung.com>, stable@vger.kernel.org, Stanley Jhu
	<stanleyjhu@google.com>
Subject: [PATCH v6] scsi: ufs: Change the error check sequence for auto
 hibern8
Date: Tue, 27 Oct 2026 20:03:57 +0900
Message-Id: <20261027110357.3649301-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261027110813epcas2p4011de6cde600db5c995d3a3e45b056fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261027110813epcas2p4011de6cde600db5c995d3a3e45b056fb
References: <CGME20261027110813epcas2p4011de6cde600db5c995d3a3e45b056fb@epcas2p4.samsung.com>

Auto-hibern8 enter and exit are performed by the host controller without
a UIC command, and the auto-hibern8 idle timer only runs while no UIC
command is outstanding. An auto-hibern8 error (IS.UHES or IS.UHXS) is
therefore usually reported while hba->active_uic_cmd is NULL.

Since commit fcd8b0450a9a ("scsi: ufs: core: Make ufshcd_uic_cmd_compl()
easier to analyze"), ufshcd_uic_cmd_compl() returns early when
hba->active_uic_cmd is NULL, before ufshcd_is_auto_hibern8_error() is
called. Such auto-hibern8 errors are no longer recorded in hba->errors,
so ufshcd_check_errors() is not called for them and the error handler is
not scheduled.

Check for auto-hibern8 errors before checking for an active UIC command,
as was done before that commit, but keep returning early when there is
no active UIC command so that a NULL cmd is never dereferenced. Only
report the missing UIC command if no auto-hibern8 error was found.

Fixes: fcd8b0450a9a ("scsi: ufs: core: Make ufshcd_uic_cmd_compl() easier to analyze")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: HOYOUNG SEO <hy50.seo@samsung.com>
Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
---
Changes in v6:
 - Add the missing "Cc: stable@vger.kernel.org" tag next to the Fixes tag
   and keep the tags in one block (Bart Van Assche, Stanley Jhu).
 - Add Stanley's Reviewed-by. No code change.

Changes in v5:
 - Fix the unmatched brace in ufshcd_uic_cmd_compl() that broke the build
   in v4 (Stanley Jhu, Sashiko, kernel test robot).
 - Use a local bool for the ufshcd_is_auto_hibern8_error() result instead
   of testing hba->errors (Bart Van Assche).
 - Move the Signed-off-by above the "---" line and Cc stable.
 - Link to all previous versions.

Changes in v4:
 - Changed patch version

Changes in v3:
 - Check auto-hibern8 errors before the NULL check again, so that errors
   reported while a non-hibernate UIC command is active are still
   detected (Sashiko review).
 - Return early when no UIC command is active instead of falling
   through, to avoid dereferencing a NULL cmd (Sashiko review).
 - Add Fixes tag, reword subject and commit message.

Changes in v2:
 - Check UFSHCD_UIC_HIBERN8_MASK for auto-hibern8 only when cmd is NULL.

v1: https://lore.kernel.org/linux-scsi/20261021051951.1687479-1-hy50.seo@samsung.com/
v2: https://lore.kernel.org/linux-scsi/20261022074249.3098100-1-hy50.seo@samsung.com/
v3: https://lore.kernel.org/linux-scsi/20261026051851.1845934-1-hy50.seo@samsung.com/
v4: https://lore.kernel.org/linux-scsi/20261026052632.1848929-1-hy50.seo@samsung.com/
v5: https://lore.kernel.org/linux-scsi/20261027021037.3398180-1-hy50.seo@samsung.com/

 drivers/ufs/core/ufshcd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d085d394858f..c08278a2e43e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5939,18 +5939,26 @@ static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
 {
 	irqreturn_t retval = IRQ_NONE;
 	struct uic_command *cmd;
+	bool ah8_err;
 
 	guard(spinlock_irqsave)(&hba->host->host_lock);
+
+	/*
+	 * Auto-hibern8 is performed without a UIC command, so check for
+	 * auto-hibern8 errors before checking for an active UIC command.
+	 */
+	ah8_err = ufshcd_is_auto_hibern8_error(hba, intr_status);
+	if (ah8_err)
+		hba->errors |= (UFSHCD_UIC_HIBERN8_MASK & intr_status);
+
 	cmd = hba->active_uic_cmd;
 	if (!cmd) {
-		dev_err(hba->dev,
-			"No active UIC command. Maybe a timeout occurred?\n");
+		if (!ah8_err)
+			dev_err(hba->dev,
+				"No active UIC command. Maybe a timeout occurred?\n");
 		return retval;
 	}
 
-	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
-		hba->errors |= (UFSHCD_UIC_HIBERN8_MASK & intr_status);
-
 	if (intr_status & UIC_COMMAND_COMPL) {
 		/*
 		 * Store the UIC command result in the lowest byte of
-- 
2.34.1

