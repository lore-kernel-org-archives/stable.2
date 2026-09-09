Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80DA35C689
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973565; cv=none; b=oh/qxM5DIGzvtly27J+h+gMMKNUpOYQ3OtSCHX062Lkq2fqXx+o3HZFhkuUvauRuovRMISPsse3pHMvQV4KxgYtis/HEvsNSSSch4dpRT3A8rnEfAtO6FS1qeP65AvxHCDQXdd0bvILsOF+Y7Pwa5+ApbhH6Cvdfh9OlqpJoigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973565; c=relaxed/simple;
	bh=fQa4CJCW2eoirazhkuYWA8ymJOjbVlDvOT2RwBkKP7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ivxb1nna8XFVeAZLj/X2271xnrBWH2td37Dtx6d5PqC0UmXeeWhGsuNZNd1mk96l601WAn4my+x5IHeFH5QteYxJi2QFjDD5tBYGhzwB9ly/c6YfIWiHrbXhfRSoiufbkFfzJDmj6JqBbEzdp0wGpHNi1u8joIIRx8X6MqSxJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4QdkT6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4QdkT6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784EF1F00898;
	Wed,  9 Sep 2026 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973561;
	bh=6jrvVMtErP3mT2LeqcCe3SUdZj0GBsIoJf6xRqs6l+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q4QdkT6Dio7KARvoOVvX6B/nHurV8FYArsLuD5PTfqC+QhVW2aMqJC21tKqZ1T6uc
	 CESC+UeNoHsJ6oz/xGSZbx3x538qusCsrrAFCcJIOosFQOPHa/fy19rlbmolGwsMez
	 g84j6hIT0cYaZt2EjCjqtZZvhnO1GF7ZeGBwDRikZVsNo8fS7cMhCDcTLiV+3hbkN0
	 6LZ85oCo9Vg3N3tyFQy753GDmhAZ3xvOHBU/YxOKqr6e6G9GD6WAWXQq/Jcn0WoQUx
	 G0bn82JtTs6VX90o64OCZlZUQlg0b33Q9bdUBPPoBBYeL3GK4yqbloPw1Sm8Sx/Mo8
	 knH9G7XlVWGlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths
Date: Wed,  9 Sep 2026 13:05:57 -0400
Message-ID: <20260909170557.3185402-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170557.3185402-1-sashal@kernel.org>
References: <2026090307-boss-eatable-41c7@gregkh>
 <20260909170557.3185402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 9cef693bce96bb4c6952f48d855284cf7fa4f367 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index c5de2b6208c3b..484d9d9d6df2c 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -31,7 +31,7 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
 	u32 phys_addr_low, phys_addr_hi;
 	u64 stb_phys_addr;
 	u32 size = 0;
-	int ret;
+	int ret = 0;
 
 	if (!enable_stb)
 		return 0;
@@ -42,8 +42,10 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
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
@@ -62,12 +64,16 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
 
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
+
+	ret = 0;
 
-	return 0;
+out:
+	/* Restore the default message port for subsequent SMU operations */
+	dev->msg_port = MSG_PORT_PMC;
+	return ret;
 }
-- 
2.53.0

