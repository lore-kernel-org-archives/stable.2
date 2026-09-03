Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2524B2713
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448013; cv=none; b=gJJqW53TN/9Gf7JQw76acx55O6FfcYPYRIk8unTolhcjE/Ew8HB8sR76ZCoIUJHxIwHfnNVOyhI7da/Moc3ZuMRvwawb7UZnAOLXhQ+KCph++noYFB8FYZEfsqO1/CAqfEJAEfpodFP+O7ZQqadfII/V+4xogN9/g5piAcJRrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448013; c=relaxed/simple;
	bh=wVfQDISZjCiGalZtiJhLbbDnT3ohF5jIYQ2GQ3lLnoI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WEjcY4woY6aOEjagLqfl+t+x9Fyy+XmSm9eCB+s8VYHu1KC0zmVqDBks2ePV8IJPEAK9Ct2Ks1SjdRBkVxe8W2y8lRVeTFFlj7+tXr/tA/MJRZ3hfEZPpADu5ZzxPJumT8BAG8i0AOEoyimHcpolXYu9pKrDnysxCnUamCUOw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ha7Vve0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ha7Vve0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8661D1F000E9;
	Thu,  3 Sep 2026 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788448012;
	bh=A0x9Tw8mysRR+Ul0LD9/DdMyL+Cye+7vLfyp+OMI2eE=;
	h=Subject:To:Cc:From:Date;
	b=2ha7Vve0jPOTUywfPWTC+7+sMH6uWDVWumFDZdvtNm2uVGV4gLjGVI9FG7fo+dnYV
	 1JVekauW7lyLRr0PF1YYttnXrZAy4xZPkavt65o9WzPZNYG1N9mMKt2aY7u6wSydKN
	 Cu0lybmBLjyoXDKFfvqXjSjqIsgKrk7trZaRWER4=
Subject: FAILED: patch "[PATCH] platform/x86/amd/pmc: Propagate SMU errors and validate S2D" failed to apply to 6.6-stable tree
To: mario.limonciello@amd.com,francisdb@gmail.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:50:17 +0200
Message-ID: <2026090317-retool-chivalry-dde5@gregkh>
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
git cherry-pick -x 0225c1d637687b03726f00ac65b6def843d2c464
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090317-retool-chivalry-dde5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0225c1d637687b03726f00ac65b6def843d2c464 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 21 Jul 2026 13:17:53 -0500
Subject: [PATCH] platform/x86/amd/pmc: Propagate SMU errors and validate S2D
 address
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amd_stb_s2d_init() discards the return value of several S2D SMU commands.
When the SMU refuses a command (e.g. "SMU cmd failed. err: 0xff") the
failure is only noticed indirectly - if at all - and reported as -EIO,
masking the real error.

More seriously, the S2D_PHYS_ADDR_LOW/HIGH return values are ignored, so
on failure phys_addr_low/hi are left uninitialised and the assembled
address is passed straight to devm_ioremap().  When the SMU leaves them at
zero this maps physical address 0 and trips the ioremap-on-RAM warning:

  amd_pmc AMDI000B:00: SMU cmd failed. err: 0xff
  ioremap on RAM at 0x0000000000000000 - 0x0000000000ffffff
  WARNING: CPU: 13 PID: 4592 at arch/x86/mm/ioremap.c:...

Check the return value of each SMU command and propagate it, and reject a
zero physical address before calling devm_ioremap().

Reported-by: Francis De Brabandere <francisdb@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221759
Tested-by: Francis De Brabandere <francisdb@gmail.com>
Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260721181756.143084-4-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 90b8a5cebfa8..1ec0e599df7f 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -311,30 +311,39 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	/* Spill to DRAM feature uses separate SMU message port */
 	dev->msg_port = MSG_PORT_S2D;
 
-	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	ret = amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
 	if (size != S2D_TELEMETRY_BYTES_MAX) {
 		ret = -EIO;
 		goto out;
 	}
 
-	/* Get DRAM size */
-	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true);
-	if (ret || !dev->dram_size)
+	/* Get DRAM size; fall back to the default if the query fails */
+	if (amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true) ||
+	    !dev->dram_size)
 		dev->dram_size = S2D_TELEMETRY_DRAMBYTES_MAX;
 
 	/* Get STB DRAM address */
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_LOW, &phys_addr_low, dev->stb_arg.s2d_msg_id, true);
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_HIGH, &phys_addr_hi, dev->stb_arg.s2d_msg_id, true);
+	ret = amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_LOW, &phys_addr_low,
+			       dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
+	ret = amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_HIGH, &phys_addr_hi,
+			       dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
 
 	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
-
-	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
-	if (!dev->stb_virt_addr) {
-		ret = -ENOMEM;
+	if (!stb_phys_addr) {
+		dev_err(dev->dev, "S2D phys addr query returned invalid address\n");
+		ret = -ENXIO;
 		goto out;
 	}
 
-	ret = 0;
+	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
+	if (!dev->stb_virt_addr)
+		ret = -ENOMEM;
 
 out:
 	/* Restore the default message port for subsequent SMU operations */

