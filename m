Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70958F09A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966002; cv=none; b=Wn8r7gG/e35Mk6Tsiu29dQMTPj9hB02/frrUzoMptsnA7I+enomlLkDqF3NF5jktcg2SRA7gLx8BCppvKaJbdjsQ5iM93LrtIQV6yKhcF7f1vUoozzLBQovxsHwLnAn1J38sD1qaTYgzD3Bfyw/UE8s9FXF+qI0N8QsjNrdyAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966002; c=relaxed/simple;
	bh=UWk8Vxkx4KJVL2DvHU8+1VB7fVra4aviU+aEcvI7M6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGCiGtxw4hthxymgfR0NOOGtp5adnxCsZU+VXhCo3+6ynLjzmzjlZj+Prpvy5F7d4aeJm2wtB10QlGvXbURkPWwtQwuhChwmtarRWsIwFj8zZVotxu+YVblpZszzSp184KsyW+Nj+VGKIs+kmP4MuczwpkV3/KRtEar2LfeKVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Od1ryP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Od1ryP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA7A1F00A3A;
	Wed,  9 Sep 2026 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966000;
	bh=H/CDM0GfZTHRRTscJ2UjJ9RmakEt/j2EtDEFnpnF8lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9Od1ryPE1vn0iW46DewaiRwmObR7EszEM+ZHdy7b1OIUusrPMIEnZhZb+om2b3qO
	 vuv86w1B50tRMbMIrySJ8VJkJkbJqtAchTaVQ6Klq6KgUTqCizn2Ig9tVG2EdfsmiI
	 ACnIfFGpXtmjCJMQjZTSTEuxaeBLbx4ETABtapGipybtuBjJmzuYU4Da14cZKX0oIQ
	 tPZqQi67hZouKfSN0PnGna7Rvpsv+BZbhIC47DlrFS6nEcYvE8pIJ/NReyUcM3P8Wx
	 yWWYooHDyaloYUqcm2cVwh9WrEr36r+A5MLduXj98SxgJyYGxIWYjbrKs9iOh0cZUf
	 c3ElOEUeGTZHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths
Date: Wed,  9 Sep 2026 10:59:56 -0400
Message-ID: <20260909145956.2754506-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909145956.2754506-1-sashal@kernel.org>
References: <2026090307-otter-shaking-7dc7@gregkh>
 <20260909145956.2754506-1-sashal@kernel.org>
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
index 53665d6d9c63a..36ca0859c31cf 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -253,7 +253,7 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	u32 phys_addr_low, phys_addr_hi;
 	u64 stb_phys_addr;
 	u32 size = 0;
-	int ret;
+	int ret = 0;
 
 	if (!enable_stb)
 		return 0;
@@ -271,8 +271,10 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
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
@@ -291,12 +293,16 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 
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
-- 
2.53.0

