Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39CC4B8DFC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448005; cv=none; b=uiVjOYmspkIy19akWOmgHKQwy2RwPKFrCACAj3LEM/+LRIVjx3CzwJKWlM6rTIRCwr3lnBsy8IFR79YWZhaAIJhZa0YHEucw+B0pPtTwCTamd/uasacNAb8dmN9ymHeZzEBia4hUr+yS9JjeYKcQ1RKRlpdoOygTqN3qrQSfMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448005; c=relaxed/simple;
	bh=RjKeWdMpH5gBUZXuq2V1QfMePWS3WrHRkcTy+9lcT+o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IQX95z3Hi/YFIMrXvdFVgh+u7u+zlUVx8SOfIpHIEgv8UMwUjO4UNftWhRu6r4D3Xcl2EKF12rgodjqK00P7RfbC49WDehOKFUIM27KW3lAe1y4azg2y3dOZwX/RsKdp3BheKvOWlTfey2GikxQT6k/4pTFP79vujf8bCESaUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIGvpVv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIGvpVv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B1D1F000E9;
	Thu,  3 Sep 2026 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448003;
	bh=5VMb8ylDULuuVwcC70fhTPa06ldRf4cAky0hIr9I0Us=;
	h=Subject:To:Cc:From:Date;
	b=gIGvpVv3F6CBEiODlhsvQSJwvCWAxtKAwzNbeDq1yyZERUDJTeoo9F7QDWIjUC+yu
	 9KfgsrFUaL1RpKVoDmIVSndQ0te/qCdDwq0/qEOV8O3sl6SSx5SVzdEyVoRuQRcDlI
	 uSBgFCohD3eXyQHbzcebUbTYRv2IOb3QUo1AssLI=
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init()" failed to apply to 6.6-stable tree
To: mario.limonciello@amd.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:50:07 +0200
Message-ID: <2026090307-duly-earmark-1628@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9cef693bce96bb4c6952f48d855284cf7fa4f367
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090307-duly-earmark-1628@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9cef693bce96bb4c6952f48d855284cf7fa4f367 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 21 Jul 2026 13:17:51 -0500
Subject: [PATCH] platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init()
 error paths
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

dev->msg_port is switched to MSG_PORT_S2D before issuing the S2D SMU
commands but is only restored to MSG_PORT_PMC on the success path.  The
early "return -EIO" and "return -ENOMEM" leave the port stuck on
MSG_PORT_S2D, so all subsequent SMU communication - including the s2idle
prepare/restore handlers - is directed at the wrong mailbox.

Consolidate the exit path through a single label so the message port is
always restored.

Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260721181756.143084-2-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 753d630f3283..83645c0a8d78 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -289,7 +289,7 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	u32 phys_addr_low, phys_addr_hi;
 	u64 stb_phys_addr;
 	u32 size = 0;
-	int ret;
+	int ret = 0;
 
 	if (!enable_stb)
 		return 0;
@@ -307,8 +307,10 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	dev->msg_port = MSG_PORT_S2D;
 
 	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
-	if (size != S2D_TELEMETRY_BYTES_MAX)
-		return -EIO;
+	if (size != S2D_TELEMETRY_BYTES_MAX) {
+		ret = -EIO;
+		goto out;
+	}
 
 	/* Get DRAM size */
 	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true);
@@ -321,12 +323,16 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 
 	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
 
-	/* Clear msg_port for other SMU operation */
-	dev->msg_port = MSG_PORT_PMC;
-
 	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
-	if (!dev->stb_virt_addr)
-		return -ENOMEM;
+	if (!dev->stb_virt_addr) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	return 0;
+	ret = 0;
+
+out:
+	/* Restore the default message port for subsequent SMU operations */
+	dev->msg_port = MSG_PORT_PMC;
+	return ret;
 }

