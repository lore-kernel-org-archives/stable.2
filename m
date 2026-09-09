Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F258125F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971204; cv=none; b=ev2cRzmDZyO2PT7MIHdpTcVd6TVcqDCT1FlYh35WUUJgfipEqrE5/pXVez0+4VYevcIbcr3SJOYpfo/X0B0+x4wYQ+XJq6lF7mW4o8bi6bycXSyPAAAUAeQWLZGFmIyvkOnI21Eoif1+3bIaN+Nleceftut7HecFxJCyDZfkoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971204; c=relaxed/simple;
	bh=gKOnLuS1vcKw0qV0LxusW6JC/9StGFg+lsiBqIBJuV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao8VD6L5rvj183N9mN19RQ0HuwI+mMYg630baU2wHwq1gEeqYIQoW264M5z315LL5AKCH8j9kDPov1QfcdrEFkV11qYgvG3uOH+uEPbPbI8nMMaGFjzdOKzTpaPybmubZIB6LHkC9LeZiOW9+b+Dngncrrc+iNaFCsswA0x/QpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsheHlqv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsheHlqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9C21F00898;
	Wed,  9 Sep 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971203;
	bh=4NHGlEzBVxhv5Jz86mzM33SCgOhJFd9YFIEJn9BErjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KsheHlqvj2XGYZnE1pF9NE6UsTveCkoephN5PxYQjYdrZWewJrtBonL3qhIqR/Q6+
	 JLKub6E2U6pC5kVG6v0dOyK3jFVq/6Cj8eRmWx+JrMSAneASjlNr8tid2vxUEbN6TP
	 eFdSFI8gwxLm+xpurCmwuu5Rxochx8e2T7EdNjdKN5IMfdg8YE7OPa19Mqiduz0L+o
	 FubZybFdOXrE37keu5nh/1ix8PzyXHdveaxZI0Haj9cz9lA2/f4UZHJU5gDpnINWWy
	 gPf89YQg15p/br8EhskI+4vuXRGNhn4RQKIHi82MG4Fq5o/bD4f9ROr1+jIvleKdQL
	 OemOiJvw0ZOGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Francis De Brabandere <francisdb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] platform/x86/amd/pmc: Propagate SMU errors and validate S2D address
Date: Wed,  9 Sep 2026 12:26:37 -0400
Message-ID: <20260909162637.2981292-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162637.2981292-1-sashal@kernel.org>
References: <2026090316-rogue-eggnog-a086@gregkh>
 <20260909162637.2981292-1-sashal@kernel.org>
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
 drivers/platform/x86/amd/pmc/mp1_stb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 0eeec64df259d..7af8ec7d76531 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -281,7 +281,9 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
 	/* Spill to DRAM feature uses separate SMU message port */
 	dev->msg_port = MSG_PORT_S2D;
 
-	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	ret = amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
 	if (size != S2D_TELEMETRY_BYTES_MAX) {
 		ret = -EIO;
 		goto out;
@@ -293,8 +295,14 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
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
 	if (!stb_phys_addr) {
-- 
2.53.0

