Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5838DC78
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976141; cv=none; b=ppFkpp1B4prPE4JMMNBn3m2Gn/DROMlmX0KmPG+qHJ/HK/B1MHab0ZkdJznchKE2qx7vK+nXF9FdJt0YEtV7PQqVd0aR8uHKWu0qXdVP5f2Wk/mB3h0GV9PpHsrUqUG1XqBDfKbFTOmu9v9e4NJbu/+KsKhCzpCiwqG29LZAZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976141; c=relaxed/simple;
	bh=llbdfDys5HVzRl8Vae6qooA15EMA/HH+UZcC5Bno11U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOw6JCD3gLS0QLe+V9EARX9Csuz87vuXyw6X5rb/LE/clBBYXCEWd834VuN1knbBwxiMJ76x1Zq4MPA2/OmqQIQhwsf62DUQJnZbvBqu0QkiGatUSlq3VSJuNIFMyaRzLOfMmUqeX8v/tLfYR3YQKq7KQZNWdjjdPQSge6On8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGmWdpwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGmWdpwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FFE1F00893;
	Wed,  9 Sep 2026 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976139;
	bh=0xXf1HCgKPUIqKFAh228TaUmvZO53BsDOrOZ/b/u5MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGmWdpwWPbn2RT9SoMI+wD4z7cTl0IeMARjTr71pJ2dnyIEhwfYHZxmSlGCyEkRhi
	 QN0k4SG440F22mwD39Km2FZuTVbJwY0f7MwcQ26JmAp2M/3uzvwtwAjNnH6rbH6qQr
	 qF24Yxc+2nXa1mZYPYwf8mUN/Aa/R95OwMFMBdpuCq2cnZBJEivAq5kLAQj72a2+7i
	 RLgYR9a4kYoPlT5iplxiweJq0NQpfpjTyJMZ/i7ZBNaSyV5pVlrX0qBgtZgKb5hd/c
	 UzXRrXR+3+ClpefAetR/9I+HTsWyyMbYPNHfgg8G6HWDVA6bBGLuh9ooPhsdIYnslU
	 QHoJfNwisPVlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Francis De Brabandere <francisdb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] platform/x86/amd/pmc: Propagate SMU errors and validate S2D address
Date: Wed,  9 Sep 2026 13:48:55 -0400
Message-ID: <20260909174855.3353995-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909174855.3353995-1-sashal@kernel.org>
References: <2026090317-buggy-snowboard-d47e@gregkh>
 <20260909174855.3353995-1-sashal@kernel.org>
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
index 351b724dc303b..53e9514a924f5 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -171,20 +171,28 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
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
 
 	if (!phys_addr_hi && !phys_addr_low) {
 		dev_err(dev->dev, "STB is not enabled on the system; disable enable_stb or contact system vendor\n");
@@ -193,14 +201,15 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
 	}
 
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

