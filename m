Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9584B5142
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444933; cv=none; b=fPaCQ/vBqlWG6Agv1a8oRDe9tzHxHnG1DcXYkC60qYBG4ozVuRTSreFDXhw/JobrdA957jHlwv5mU8bftUQc+Q9/Z7O1lgg8LVS4m8t4OvIJq+vAhT+tSH/+7cgR6s571GSwJrPIBhst3iimn9HXvCfAvtAIKYESKTckMOjuziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444933; c=relaxed/simple;
	bh=0vTfsaFy66wm4Dp3PLNQwd/S2ZFEO6UyO4DV5QskTlo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OLCdaR1XzPLP0phSj4m4cYoOCDKESVr46ji7mrQoKbuAlF1fxR5emC+wxvxDw/z/pL3zygxDV7Bt95rmDaGfrddGW4HzYc5okAnfKfbi3dl7MFvQ79qXzfS6V7nEcy5d6cyaphNP8a8PIKm2gECFs+So1YxFse2qx+c1c+bAY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HIZhXY4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HIZhXY4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4891F00A3A;
	Thu,  3 Sep 2026 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444920;
	bh=4DdEROesGCQtMBQIEju9+9CUYVZe/UXtQ2jd9nVijNM=;
	h=Subject:To:Cc:From:Date;
	b=HIZhXY4BWdiL7oiSKPwg91b0lgrudy3bE7+vVDoDea4twt4RDET2tHAsvmVzol31o
	 PBU/ms/HZ31t39kntUDeY0uiq54wVqQgh2t/5FmJ9tKg9LWDsyW3Hx98iDi/aPHNC/
	 ilIoWnG1NO0ZzZykB1VQ5kq4vhvyveVRUqRL9uAw=
Subject: FAILED: patch "[PATCH] cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity" failed to apply to 6.18-stable tree
To: terry.bowman@amd.com,alison.schofield@intel.com,dave.jiang@intel.com,icheng@nvidia.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:54:17 +0200
Message-ID: <2026090317-uncooked-enduring-e40a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9d399526128bae184b153deab42b49f5f3eea2ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090317-uncooked-enduring-e40a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

