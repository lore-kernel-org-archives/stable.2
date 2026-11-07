Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047780;
	b=3jchf7CJ+Wl8OlOE+XIXEgftY57x+Kd1nX2oLX7eN3LknL1dN60udTmIiDXtePSO/G12
	 nrl1Yy9SOj2kpa/6Ac5vHpLDHQFYFhywmAi3btP8uE6kUi1XJk6BRaCmN2mDod+u+p+1/
	 QaZRLw0B9wwu4eRK7YAetYFzmiJfC2fFbSR6sULyCTfWL7+dHkOc3s9lx8rnpLJBkM2IV
	 6zlUhJRlGsqNCSOtwKoEXkwsvOwDG0Cr5xWHpACaOdPTv4iYiO87otaCI6kcrT47GBqsJ
	 AXC0y57kH+v4Tf/SixijF48bW11sjba9aeFGaInlU/OD0t1LayAgCc7VaLrxxEog5/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047780;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v8d1RQyi1clHrC6IzcX4/bKvu2YoAPwtnOb2ld6xWlM=;
	b=oHZ2wUVgjCJJQOSWlWdiKjuVBFMVJLie/EGelmWRwIEc59k4faB0a3RGZE6X0Fig+96w
	 hfw9nHOF0NF3A3K3Eickes33D7fbfF6siCJnH/P3uvX20FT7pOOMvouLq3isoLURPc6fj
	 X6+AgBDdWj78c/pO1MUtlWQoubFC+ijuyfwNyKjCCf+lYHvrU+Y/hg/KZ3Nwh9xjz/4Ch
	 2bemaZogTECFGiV9kh3hmidBTFY2qzToE/6AsQWoL8E4HVESkoo+uUF7Q/1FE1Zb0mgAZ
	 14jaTgv5oEE2VDUIYkSvYVgRtlEF2lfEttTe0+B83od5O6L0gx6T7iCoV0I4uNCXHbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxcCx6St;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxcCx6St
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4161F0089F;
	Sat,  7 Nov 2026 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047780;
	bh=v8d1RQyi1clHrC6IzcX4/bKvu2YoAPwtnOb2ld6xWlM=;
	h=From:To:Cc:Subject:Date;
	b=cxcCx6StyFqQRsGcjCMssCko3iPiVQ4EA3UAdcR8NzsMZJdV651znoU05nQCz4yw3
	 xufGE3nw6aJFoBhadZaLxvWgutBdqDWVLlNU72CRvPM45CWCjLuzojIrnOBjId/t16
	 8uCOoXlbCoCWOSpoklvpL+Xl3aIehad5Q1Ybymcg/uUqW4gUtPtdnynmODeMc1AKYN
	 OfyIwinzsi+p4JW2nDmf2eHbtiRX+oBYS8wPXn9pXVGiW2hS1YrAhKe/04C/85YqvI
	 jO+BQJ1sdrVbT7ofmvVm2PPQohzu5dVgTCZ04w/Otih7X6nULiq2C48jMIXy50FwZh
	 Vko5wcmFB67Ug==
From: Sasha Levin <sashal@kernel.org>
To: fabricioakio@gmail.com,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: qcom_smbx: set the charge enable after software control" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:18 -0500
Message-ID: <20261107053618-failed-6.6-1fba78714201@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 1fba787142011145e1071cee9448b3677fb2323d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053618-failed-6.6-1fba78714201@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1fba787142011145e1071cee9448b3677fb2323d Mon Sep 17 00:00:00 2001
From: Fabricio Akio <fabricioakio@gmail.com>
Date: Fri, 2 Oct 2026 22:29:32 -0300
Subject: [PATCH] power: supply: qcom_smbx: set the charge enable after
 software control

The init sequence sets CHARGING_ENABLE_CMD before CHGR_CFG2 selects
software control of the charge enable.

The Motorola Moto X4's bootloader leaves the charger watchdog armed to
disable charging when it bites, which it does after a few minutes in
fastboot. Charging then stays disabled in the next boot until the cable
is replugged. Setting the command after CHGR_CFG2 re-enables it.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
Link: https://patch.msgid.link/20261002-qcom-smbx-enable-order-v1-1-7df92bd809db@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/qcom_smbx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 3951326f488fb..52bb5a6eb145d 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -819,11 +819,7 @@ static const struct smb_init_register smb_init_seq[] = {
 	  .mask = SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT |
 		  VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT,
 	  .val = VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT },
-	/* Enable charging */
 	{ .addr = USBIN_OPTIONS_1_CFG, .mask = HVDCP_EN_BIT, .val = 0 },
-	{ .addr = CHARGING_ENABLE_CMD,
-	  .mask = CHARGING_ENABLE_CMD_BIT,
-	  .val = CHARGING_ENABLE_CMD_BIT },
 	/*
 	 * Match downstream defaults
 	 * CHG_EN_SRC_BIT - charger enable is controlled by software
@@ -844,6 +840,13 @@ static const struct smb_init_register smb_init_seq[] = {
 		  AUTO_RECHG_BIT | EN_ANALOG_DROP_IN_VBATT_BIT |
 		  CHARGER_INHIBIT_BIT,
 	  .val = CHARGER_INHIBIT_BIT },
+	/*
+	 * Set the enable command only once CHGR_CFG2 has selected software
+	 * control, or a charger its watchdog has disabled stays disabled.
+	 */
+	{ .addr = CHARGING_ENABLE_CMD,
+	  .mask = CHARGING_ENABLE_CMD_BIT,
+	  .val = CHARGING_ENABLE_CMD_BIT },
 	/* STAT pin software override, match downstream. Parallel charging? */
 	{ .addr = STAT_CFG,
 	  .mask = STAT_SW_OVERRIDE_CFG_BIT,
-- 
2.53.0




