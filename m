Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300557D224
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966001; cv=none; b=WTH+zZArQjfygTk1z3OvVTzW0oswTCQEMhq7m6i3sSJk+tV8y6eAapjIFkYxcUwxm9Ih3L89VAJ4FsMVzpsSfNHVCfqKkdwzq5/SRrcIKePW3/BAYw7eYFLJ96p1pSj6i50fiSY3Q5ddCPRPHsS10lxEqYTwSJY23etooOXNBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966001; c=relaxed/simple;
	bh=NbHl4hg5ka1/f1UWiLXE9TwXJgc5M5zZDAIyCUjThHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ME2J9fWIvsOL9PJBwNniolNYD1Ml8cZRcP5E7Td54QpXVdtmUEgBk4bAwnpBAKJi/ii9k1H0z1kAWjqykSkuVKGy2yxGHNW12xbA2MkQHdvbgorJil2OaG7QvXFcCo3Ea23jHnu0VZGCx2/O32IyJLLlpoupDQvyvqvu4bGZXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiJhvxVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiJhvxVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853951F00A3E;
	Wed,  9 Sep 2026 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966000;
	bh=YKmqM5VWPbSrK58SQ87qdHNGtepUuK7QGnm+oWlZHRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FiJhvxVlu7NYvcEZ83/FgO0v7sqjZVR7K4xPbZTRYn4lO+KQfcbX+qdr0GzRidMTy
	 pJLBDclqxM/Ibwr/Twv0TqZDdsqc0TUsv7wITSLdYnLeLhR+2atzqT54EmkJr6kGZF
	 6QNJfxmVaf/93zVCmvCCUcpDvGLdopeg7xXp28GVkV3rThnUE25Gl1tZXzsRxNt9RB
	 weUS8T7UVUykemdCi/iCoD+npdZ4hsR3Ie7xLqvwKCl8J4HEraOQgR3XLFzLohJRP7
	 VGAtMnXF7quI2MoKLCAKixZCG1THwaLNd51gZ8IoR33Zq9De1kk1eV/4LqflAnnpyi
	 wr36exnYELlFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] platform/x86/amd/pmc: Define enum for S2D/PMC msg_port and add helper function
Date: Wed,  9 Sep 2026 10:59:55 -0400
Message-ID: <20260909145956.2754506-3-sashal@kernel.org>
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

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 2851f4f8ed4e130d864c5478c6da933a4427ae52 ]

To distinguish between the PMC message port and the S2D (Spill to DRAM)
message port, replace the use of 0 and 1 with an enum.

To avoid printing the S2D or PMC port multiple times in debug print,
add new routine to retrieve the message port information, which can be
used to print the right msg_port getting used.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20241108070822.3912689-5-Shyam-sundar.S-k@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 9cef693bce96 ("platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc.c | 22 +++++++++++++++++-----
 drivers/platform/x86/amd/pmc/pmc.h |  2 +-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index dccce5894ce5b..d8cb983e79f99 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -458,11 +458,23 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
 			    &amd_pmc_idlemask_fops);
 }
 
+static char *amd_pmc_get_msg_port(struct amd_pmc_dev *dev)
+{
+	switch (dev->msg_port) {
+	case MSG_PORT_PMC:
+		return "PMC";
+	case MSG_PORT_S2D:
+		return "S2D";
+	default:
+		return "Invalid message port";
+	}
+}
+
 static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
 {
 	u32 value, message, argument, response;
 
-	if (dev->msg_port) {
+	if (dev->msg_port == MSG_PORT_S2D) {
 		message = AMD_S2D_REGISTER_MESSAGE;
 		argument = AMD_S2D_REGISTER_ARGUMENT;
 		response = AMD_S2D_REGISTER_RESPONSE;
@@ -473,13 +485,13 @@ static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
 	}
 
 	value = amd_pmc_reg_read(dev, response);
-	dev_dbg(dev->dev, "AMD_%s_REGISTER_RESPONSE:%x\n", dev->msg_port ? "S2D" : "PMC", value);
+	dev_dbg(dev->dev, "AMD_%s_REGISTER_RESPONSE:%x\n", amd_pmc_get_msg_port(dev), value);
 
 	value = amd_pmc_reg_read(dev, argument);
-	dev_dbg(dev->dev, "AMD_%s_REGISTER_ARGUMENT:%x\n", dev->msg_port ? "S2D" : "PMC", value);
+	dev_dbg(dev->dev, "AMD_%s_REGISTER_ARGUMENT:%x\n", amd_pmc_get_msg_port(dev), value);
 
 	value = amd_pmc_reg_read(dev, message);
-	dev_dbg(dev->dev, "AMD_%s_REGISTER_MESSAGE:%x\n", dev->msg_port ? "S2D" : "PMC", value);
+	dev_dbg(dev->dev, "AMD_%s_REGISTER_MESSAGE:%x\n", amd_pmc_get_msg_port(dev), value);
 }
 
 int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret)
@@ -489,7 +501,7 @@ int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool r
 
 	mutex_lock(&dev->lock);
 
-	if (dev->msg_port) {
+	if (dev->msg_port == MSG_PORT_S2D) {
 		message = AMD_S2D_REGISTER_MESSAGE;
 		argument = AMD_S2D_REGISTER_ARGUMENT;
 		response = AMD_S2D_REGISTER_RESPONSE;
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index a33a737441821..b18bc46e36e6c 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -39,7 +39,6 @@ struct amd_pmc_dev {
 	void __iomem *smu_virt_addr;
 	void __iomem *stb_virt_addr;
 	void __iomem *fch_virt_addr;
-	bool msg_port;
 	u32 base_addr;
 	u32 cpu_id;
 	u32 active_ips;
@@ -51,6 +50,7 @@ struct amd_pmc_dev {
 	u8 major;
 	u8 minor;
 	u8 rev;
+	u8 msg_port;
 	struct device *dev;
 	struct pci_dev *rdev;
 	struct mutex lock; /* generic mutex lock */
-- 
2.53.0

