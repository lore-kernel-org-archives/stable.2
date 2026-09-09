Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C227E29B77E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973201; cv=none; b=J6iTJPaF1sLhKDMI06hnZhk9PckNUqtMfHHJzTJRND1FLoLu2loUvlK5EJclUc5clMzJbX9QY4KUj13tfCT9AAp1o2+NEwaOcW1EWb8jsLEdkb7+9RL7KZ39V291+3aO2P7p60dJYK7PEeQJwSFCmIeMF3jDP/19M29V90DPzss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973201; c=relaxed/simple;
	bh=Ec4O7DP9hU3+AGPu/D/M/RIeENtyFeuoWvulHLpAgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zq6mk6LavstWcWtPDY2uD+H0qSEIbymxPgZpQ5kQAJ7WIGkwWPMgxG6Wnbohp3Q42ip/oCm8mbVCtlwzk7jc8eyQfZZJcWimi/ETJbU703eBRA6YvidOs2iqMM88nV0tJWe7jNhlA2PzfFb2QzkMTass7HrBAdCmEtJ70GPF4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqAMiGmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqAMiGmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB31F00899;
	Wed,  9 Sep 2026 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973199;
	bh=RXJ2I4uGn5POxkU7RzaMtEpNfxl18iJ7tbumx5RAsw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqAMiGmtxa/D12SG4bpXq93OM5w9KN4txThioiwjPz6PEPrpgSrz1Kfb6f67r0kTY
	 /jjvxGI/0fIH9kXwKhtgaVcW5zSr+vVRYe18u6JfG0jItJqmDP4GtPIWmZvIsE4b2Y
	 90mmnePL0sB4nIASiMQyjdbx8D+fzBk6w/vIMZJOAMEJvB+3iyXVkZrA+7kTkEDcVw
	 ZJpTi2Erw9NrDUIHmXxU06G2hgrITDaNINMlD6rAQj/1IY2gEVizpEAJiV/0E00Nx3
	 hJr+KbuYajnMQzXbFMgvIC/5OFaCQ3MmLJKidmP1T/17R8qiziTykE+DTuVZM6lycJ
	 yZLQjPmL/xigg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Francis De Brabandere <francisdb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] platform/x86/amd/pmc: Propagate SMU errors and validate S2D address
Date: Wed,  9 Sep 2026 12:59:56 -0400
Message-ID: <20260909165956.3156218-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909165956.3156218-1-sashal@kernel.org>
References: <2026090317-retool-chivalry-dde5@gregkh>
 <20260909165956.3156218-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 0225c1d637687b03726f00ac65b6def843d2c464 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c | 31 +++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index afb9555d63ea7..6d90f52531636 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -26,30 +26,39 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
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
-- 
2.53.0

