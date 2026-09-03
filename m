Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568BB4B3382
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444931; cv=none; b=G8aw9kWJKw9SAn64q4FeFirrBBleTHV3vL0iMUTmTPylahLaowIwc6qTGg4Gey9puDiFZdekFASfB+pnMhfkGJsq6IxZ+FUervQ6c79tjD3zgvf3HoBPXuOI+6Us/xxdM8C9RZ6aAF4rcupn0vxHjTe3LFV7hSe7sO2yhcjn078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444931; c=relaxed/simple;
	bh=ig8Plwsu4pCGzPCjaW2Jo2VGOKSm8g2488mbU3XcI6A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=umHTK2Dd4I95GGzmAS8R1VKXBbnjURgsyzsQlaY1ykgat6aO4Kd/7PZxMsoM23PxKvXwLbgjgNyBpNELX93/HV88iZW9kzxrr6CB/hbZqWTMtCsWZI3KknJz+yUHSL75KbeesFrEm5T1iSBxHfbWMjEv5y84B4U6g/94njQ40R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xFIObnM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xFIObnM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEC81F00AC4;
	Thu,  3 Sep 2026 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444918;
	bh=Ot8QNp7PgQiwo1CmuxGDK5OLWmUXtxsBx6hu+Q6nuMM=;
	h=Subject:To:Cc:From:Date;
	b=xFIObnM08cwixcQ37ouFBZUPhbBrYGJID+L/2Ajv9P7qaighnJuPRHEY8sDTHXNnH
	 D1cDyZZbW1rA5oErDLHxGCJBwHQogPJZ2NfIBDrdoJYDO1hiFlpXNECipoFyb8Hfar
	 ujPCOicF6d4r3wApotzqMVlep0VAzgg5tM0zRB/Q=
Subject: FAILED: patch "[PATCH] cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity" failed to apply to 6.12-stable tree
To: terry.bowman@amd.com,alison.schofield@intel.com,dave.jiang@intel.com,icheng@nvidia.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:54:17 +0200
Message-ID: <2026090317-roundish-company-df16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9d399526128bae184b153deab42b49f5f3eea2ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090317-roundish-company-df16@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d399526128bae184b153deab42b49f5f3eea2ed Mon Sep 17 00:00:00 2001
From: Terry Bowman <terry.bowman@amd.com>
Date: Mon, 3 Aug 2026 17:17:58 -0500
Subject: [PATCH] cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity
 register

cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
errors as fatal or non-fatal by ANDing uncorrectable status with
PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
Root Error Status register bit (bit 6), not a severity bit. ANDing it
against uncorrectable status tests a reserved bit and produces incorrect
severity classification.

Fix by ANDing the unmasked uncor_status against uncor_severity. Per
PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
Error Severity register indicates whether the corresponding error is
fatal (1) or non-fatal (0).

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Cc: stable@vger.kernel.org
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20260803221810.3685703-3-terry.bowman@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 8a3965edaa12..e0e01aa5eba6 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -94,11 +94,11 @@ static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 				     int *severity)
 {
-	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
-			*severity = AER_FATAL;
-		else
-			*severity = AER_NONFATAL;
+	u32 uncor_status = aer_regs->uncor_status & ~aer_regs->uncor_mask;
+
+	if (uncor_status) {
+		*severity = (uncor_status & aer_regs->uncor_severity) ?
+			     AER_FATAL : AER_NONFATAL;
 		return true;
 	}
 

