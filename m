Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE73264C8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976140; cv=none; b=htfneIhg90hGx6uy/sa7HCJJsVGJJJ8isb5zvxMoqJmNVM2wjVyBUkGfeQz5gSx1RxPSRshZRmiGWYxiEOMVkAUwTks6ff60WsAbuAWex0Gn1NvRy+RtlNnz28DtqDC/wZ4BpLQyq8fkJt9WS9EiANO68Khx4KfEx5K9YWMlitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976140; c=relaxed/simple;
	bh=h+xz7ANviEGQscoAtXhtAjwfawzBEZsPfL91dXt7KpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glxyvF51qk3LLHZoo4UGI4QGHb3ku4N4R0meCKxtsGcmk9uoT9WafSTIvJewxL48IqEM4yF6OeEwqqvxOeBWUZ/X2uAlZnsze6c1phbQDtTMDkf8YZywxnRCVHk7DTU4FgBlS/KJHA5nSFjx5UYXGGvn2x6Kqc2aGrSpNWPZekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNbsV7+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNbsV7+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63631F00898;
	Wed,  9 Sep 2026 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976138;
	bh=ThrIZ5GSTZR+HS8Y/UvTywtJL6cM3UK+L3l5PJZ+udc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CNbsV7+p6AgxXL+35EiMiUSnmFgiCqyUeZ6R9jjLeVts4lEM0ayveU0JGWlFT1mS3
	 AANyLR8VLzSwuwla5lhgSvaP0qE7v5l6gw0c4S1W6lc4kv0Rwj3ySQjn9bp6wq6Y7D
	 AKm/gOojhBjJtmhlAsEgqiSw272Br9Q2pKKRscQi6JeCLzC3CbKSiyyBdpFzEjmNZ7
	 FZ2qQjk3rWBCJCJ4ytvmls5/nTmyO2aNPxaKTvpHcE4ipH1eLnStRxVCtUmNVRc6Gn
	 J+yi5v703t1gmPaRuW/f+m8643fihWj+lQX7XU9ZFY8uPk3v7EQlyeOHoUsqd36nxV
	 PlUHV4K+QKJwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] platform/x86/amd/pmc: Isolate STB code changes to a new file
Date: Wed,  9 Sep 2026 13:48:54 -0400
Message-ID: <20260909174855.3353995-2-sashal@kernel.org>
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

[Backport dependency for 0225c1d637687 to Linux 6.1]
The preceding STB split already provides stb_arg.s2d_msg_id and the S2D
initializer context needed by the target. Extend that existing structure
with message, argument and response offsets, move the S2D register macros
to mp1_stb.c, and use those offsets in the PMC command and register-dump
paths.

Initialize the offsets in the existing amd_pmc_s2d_init() before selecting
the S2D message port. The upstream amd_is_stb_supported() helper is absent
here, so do not introduce it or the unrelated newer platform, MP2 and
enhanced STB debugfs code. Preserve the stable CPU gating, command ID,
zero-address check and common message-port restoration. No functions are
added. The unmodified target applies cleanly through a three-way apply.

Stable-dep-of: 0225c1d63768 ("platform/x86/amd/pmc: Propagate SMU errors and validate S2D address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c |  8 ++++++++
 drivers/platform/x86/amd/pmc/pmc.c     | 21 ++++++++-------------
 drivers/platform/x86/amd/pmc/pmc.h     |  3 +++
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 52fc05a1bad68..351b724dc303b 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -31,6 +31,11 @@
 /* STB Spill to DRAM Message Definition */
 #define STB_SPILL_TO_DRAM		0xBE
 
+/* STB S2D(Spill to DRAM) has different message port offset */
+#define AMD_S2D_REGISTER_MESSAGE	0xA20
+#define AMD_S2D_REGISTER_RESPONSE	0xA80
+#define AMD_S2D_REGISTER_ARGUMENT	0xA88
+
 enum s2d_arg {
 	S2D_TELEMETRY_SIZE = 0x01,
 	S2D_PHYS_ADDR_LOW,
@@ -159,6 +164,9 @@ int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
 	int ret = 0;
 
 	dev->stb_arg.s2d_msg_id = STB_SPILL_TO_DRAM;
+	dev->stb_arg.msg = AMD_S2D_REGISTER_MESSAGE;
+	dev->stb_arg.arg = AMD_S2D_REGISTER_ARGUMENT;
+	dev->stb_arg.resp = AMD_S2D_REGISTER_RESPONSE;
 
 	/* Spill to DRAM feature uses separate SMU message port */
 	dev->msg_port = MSG_PORT_S2D;
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 4740476df007b..859f2f17078b7 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -44,11 +44,6 @@
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
@@ -438,10 +433,10 @@ static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
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
 		message = AMD_PMC_REGISTER_MESSAGE;
 		argument = AMD_PMC_REGISTER_ARGUMENT;
@@ -465,10 +460,10 @@ int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool r
 
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
 		message = AMD_PMC_REGISTER_MESSAGE;
 		argument = AMD_PMC_REGISTER_ARGUMENT;
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index f372321eb37a0..265216dcec90c 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -12,6 +12,9 @@ enum s2d_msg_port {
 
 struct stb_arg {
 	u32 s2d_msg_id;
+	u32 msg;
+	u32 arg;
+	u32 resp;
 };
 
 struct amd_pmc_dev {
-- 
2.53.0

