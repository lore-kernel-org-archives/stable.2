Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952758124E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971203; cv=none; b=r7ftqGq3pR3HxCMOl523Bu9MMUxt1QHMWd9pGEhziP2yRgnCAOpCDQ0MNrbf1G9zZjPjFk3ijcdpKN/UsFXJsWmBDJavjdSnQuUObbn93PZr7mCNRzVRvQvIS2AJFY4yygyN3Mc2AyY5rRT1GEa+EWraz10VdmFkvxVDmXcnchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971203; c=relaxed/simple;
	bh=pfc7j+pSrW/dWu8ZRukJ4+e7f2bdEzj4kMO5kHiYDpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxeVPBQ2u5c++Lvu86tWSEWERNWC3q3sfaGJi4lc6kKcemGNC3XiBCiTvc3yjnDFcyPMGw47P1rwdeAMSCN26vap9rsbvJV1eWlXkK3aVSp4W5jqLpdveQO60e3gPAI6afy1F/JFLDAXiYRqQliSZOH5qEiWL+HWb1ucfraH290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olby+jFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olby+jFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFEB1F00899;
	Wed,  9 Sep 2026 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971202;
	bh=dFRq10bJBAzMnRH+3ERFPHptCPPQziYkeh6ii1YWY2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olby+jFdE1gFrSIW59HZfXKuqaYYT+/PYxGCXYhYPPoVRJ1/v7mH4/45SyVsajTwQ
	 qPSXYp6S5k2y9SJ2SaM1c35xog6gjJXhmayONNoLHmFxHSCOZbO/vqIzGp9MMKrFbA
	 X3gWXAWq6gvs2qpGWt47HmSDDgbhy31Li5ovTp/4pF3YWiCYQFX0iwpUWtrBMkD6Tw
	 zPAtsDtWCRXPIEIyhxUy8RtTG/DzksIUqyQSWQ8v+8+7eXBguBycdG9s+ZefGX/yb+
	 /s0zrgwwxEmrEEQhha9qS/gspzNW3wSNf9UO8ddtreK9kiIB75JabP9GzU4WGFej1t
	 aKxKZFElf03Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] platform/x86/amd/pmc: Isolate STB code changes to a new file
Date: Wed,  9 Sep 2026 12:26:36 -0400
Message-ID: <20260909162637.2981292-3-sashal@kernel.org>
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

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 3279f7a6b7d42374897d3b818630602f0ff56521 ]

Since S2D (Spill to DRAM) uses different message port offsets compared to
PMC message offsets for communication with PMFW, relocate the S2D macros
from pmc.c to a new file, mp1_stb.c, for better code organization.

Following this change, it is logical to introduce a new structure,
"struct stb_arg," to pass the message, argument, and response offset
details to PMFW via the amd_pmc_send_cmd() call. Additionally, move the
s2d_msg_id member from amd_pmc_dev into the new structure.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20241108070822.3912689-6-Shyam-sundar.S-k@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[Stable backport: The preceding STB move already introduced struct
stb_arg and converted all s2d_msg_id users. Extend that existing structure
with the message, argument and response offsets instead of defining it
again. Initialize those offsets in the existing STB support check and
use them in the PMC command and register-dump paths.

Keep the stable amd_pmc_* function names and bool message-port field.
Preserve the initializer's shared PMC-port restore path, zero-address
validation, mapping cleanup and successful DRAM-size fallback. Drop the
upstream hunks that repeat the earlier s2d_msg_id conversion or would
undo those preparations. No functions or platform support are added.

Target 0225c1d63768 applies cleanly with a three-way application and adds
the remaining SMU command error checks.]

Stable-dep-of: 0225c1d63768 ("platform/x86/amd/pmc: Propagate SMU errors and validate S2D address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c | 17 ++++++++++++++---
 drivers/platform/x86/amd/pmc/pmc.c     | 21 ++++++++-------------
 drivers/platform/x86/amd/pmc/pmc.h     |  3 +++
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index f36e112cdbf0b..0eeec64df259d 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -31,6 +31,11 @@
 #define STB_FORCE_FLUSH_DATA		0xCF
 #define FIFO_SIZE		4096
 
+/* STB S2D(Spill to DRAM) has different message port offset */
+#define AMD_S2D_REGISTER_MESSAGE	0xA20
+#define AMD_S2D_REGISTER_RESPONSE	0xA80
+#define AMD_S2D_REGISTER_ARGUMENT	0xA88
+
 static bool enable_stb;
 module_param(enable_stb, bool, 0644);
 MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
@@ -235,17 +240,23 @@ static bool amd_pmc_is_stb_supported(struct amd_pmc_dev *dev)
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 		dev->stb_arg.s2d_msg_id = 0xBE;
-		return true;
+		break;
 	case AMD_CPU_ID_PS:
 		dev->stb_arg.s2d_msg_id = 0x85;
-		return true;
+		break;
 	case PCI_DEVICE_ID_AMD_1AH_M20H_ROOT:
 	case PCI_DEVICE_ID_AMD_1AH_M60H_ROOT:
 		dev->stb_arg.s2d_msg_id = 0xDE;
-		return true;
+		break;
 	default:
 		return false;
 	}
+
+	dev->stb_arg.msg = AMD_S2D_REGISTER_MESSAGE;
+	dev->stb_arg.arg = AMD_S2D_REGISTER_ARGUMENT;
+	dev->stb_arg.resp = AMD_S2D_REGISTER_RESPONSE;
+
+	return true;
 }
 
 int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index ca2bf410d986a..443b8b94a978f 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -45,11 +45,6 @@
 #define AMD_PMC_STB_S2IDLE_RESTORE	0xC6000002
 #define AMD_PMC_STB_S2IDLE_CHECK	0xC6000003
 
-/* STB S2D(Spill to DRAM) has different message port offset */
-#define AMD_S2D_REGISTER_MESSAGE	0xA20
-#define AMD_S2D_REGISTER_RESPONSE	0xA80
-#define AMD_S2D_REGISTER_ARGUMENT	0xA88
-
 /* Base address of SMU for mapping physical address to virtual address */
 #define AMD_PMC_MAPPING_SIZE		0x01000
 #define AMD_PMC_BASE_ADDR_OFFSET	0x10000
@@ -462,10 +457,10 @@ static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
 {
 	u32 value, message, argument, response;
 
-	if (dev->msg_port) {
-		message = AMD_S2D_REGISTER_MESSAGE;
-		argument = AMD_S2D_REGISTER_ARGUMENT;
-		response = AMD_S2D_REGISTER_RESPONSE;
+	if (dev->msg_port == MSG_PORT_S2D) {
+		message = dev->stb_arg.msg;
+		argument = dev->stb_arg.arg;
+		response = dev->stb_arg.resp;
 	} else {
 		message = dev->smu_msg;
 		argument = AMD_PMC_REGISTER_ARGUMENT;
@@ -489,10 +484,10 @@ int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool r
 
 	mutex_lock(&dev->lock);
 
-	if (dev->msg_port) {
-		message = AMD_S2D_REGISTER_MESSAGE;
-		argument = AMD_S2D_REGISTER_ARGUMENT;
-		response = AMD_S2D_REGISTER_RESPONSE;
+	if (dev->msg_port == MSG_PORT_S2D) {
+		message = dev->stb_arg.msg;
+		argument = dev->stb_arg.arg;
+		response = dev->stb_arg.resp;
 	} else {
 		message = dev->smu_msg;
 		argument = AMD_PMC_REGISTER_ARGUMENT;
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index 24c7aab40f19f..0b8c0c179d657 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -21,6 +21,9 @@ enum s2d_msg_port {
 
 struct stb_arg {
 	u32 s2d_msg_id;
+	u32 msg;
+	u32 arg;
+	u32 resp;
 };
 
 struct amd_mp2_dev {
-- 
2.53.0

