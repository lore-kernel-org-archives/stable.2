Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E8582B99
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971221; cv=none; b=MhstbXx8Iy7cWqI8PYpwqg+Xdx0qmdSU1DrBN/DUbvc3QQREBp6CxSqj906aGYFSINoq2nSu+amWfUxQ7Z+SKqqJcAMUUC3pDqF6b8qqguhTQ3o4SxFTjGV5yKzJy+E9zDBNqgtEfs5oFr2B8TPq8Jnmnotvz3oRNNuKwBMHgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971221; c=relaxed/simple;
	bh=25t8/NfPzq0GgBSJ0tPQNkdmFE+An+qGzI8Mdi+feDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rs1llPVkVeJsviWuArA0/yeJEtdnZsS4OOdjatOlC9cvjEPQdA25c3cKwUR/l6jxWisACysZ89RR/oBYQL6NUX69kGc+fcP9dTp/tWuaoNOVprTz3n3/QpgUfSMgAQVku6W0zqbC5+wV/FYTGwkkH3h0WJUxh5h2ntGhuzw8kzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNHcewS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNHcewS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C425D1F00898;
	Wed,  9 Sep 2026 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971219;
	bh=o4UjUxO5I1tV9DimlBltzNW3MKE16kIqqwBzvi3ps7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNHcewS8Y0zV3aU9M1zt3RzqXWM4EhKT5FVZPdlEOvSzKrMJ0yBhsTzwxvT62B13a
	 0pp+VTuxhxfwpVsSV2z+OQ3k2jzHKESPDekhcDW9gxJq8l5kVoJYKOGcQIFXyfopjf
	 dscu8AQFQ4raxLNGIycJF2gsJD1pZBdm5oc9YriwJTDdLaztnQ7zozRlnMS68TKiHz
	 gkBf+dLpnyGB+jQIGoT7PyVm5lG3AbuEmpxUEWz13DIYLUO2vlzEYmDksst063oov0
	 UCuVJ+IWKmclfcK8D/Y4FkgzgOqYp67NpkpgbBkwAPDosqhzP6nQeFqeJ/7vjU/H7/
	 q9+3sSXQua/RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths
Date: Wed,  9 Sep 2026 12:26:55 -0400
Message-ID: <20260909162655.2981787-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162655.2981787-1-sashal@kernel.org>
References: <2026090307-duly-earmark-1628@gregkh>
 <20260909162655.2981787-1-sashal@kernel.org>
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
index 40ec048ff9eca..5b83b306f444c 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -21,7 +21,7 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	u32 phys_addr_low, phys_addr_hi;
 	u64 stb_phys_addr;
 	u32 size = 0;
-	int ret;
+	int ret = 0;
 
 	if (!enable_stb)
 		return 0;
@@ -30,8 +30,10 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
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
@@ -50,12 +52,16 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 
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

