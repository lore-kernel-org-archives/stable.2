Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11E357CF4
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190278; cv=none; b=dD5s3Veqri7vEp+EcJefgSaJSz1ie0pW3rUFdTnKQCGYnhnHTWOO8fhstl7ylsZhrG909gT9ho30/TEBncA5E9EnFGaO/KSmifxnkEol4BXzsC5bHWG9sgmuHOe3A/ckXA2S9/m3tjrEtmSaBmoGHC93hoSpeBJW6J1HEEjekZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190278; c=relaxed/simple;
	bh=7zHfeCmQWeGbP3dVpYHYW8/FWi66YWkTVtTzQPhoats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTN+7iAX3FrwuyOIr9kTbtgfuKDXkYMseIT6jhrUKoNB71pDGoskkaihYZIDZcodaE5K9q2BEbgX0SOrNWhXqN/bXe2Pn5tug/GnEBmLL3XTWvnzjvNMrtUgMrridZk6SE2RZ3ZQ+q5wJJR3GOQbG9zLlvXyHi/CPlDl177UypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=KPN0gSYC; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="KPN0gSYC"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gbmC11H0Zzh5Z
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 17:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781190269;
	bh=bqW0RhbkxKWfgbrkVMtQ9jSHJs8wTyA2a5n8PJR4O7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPN0gSYCNYLLDKEbtfATD4sGxmT5V5AB4NX/gHX+fT1q7hJyWssWQyBLCiv8W0s0M
	 j69dXcuY0HosgkfF9OK8UbYnXUMphTBzgkBUDrElwjMRyC1QH4bNyhu7M/6B9BV2O4
	 c3XYUgLeN9BFQR190Z4ChGJQ+cbRV6ujvvlqByIIAQEMlgjSvN09Lui6L1X1YghlDp
	 n9u6Ge3BWfDKSRZiZpMPaoljUDlPh+HGTIWjjIRkyIxCexTpORfBdA7Y7HwlhpWFO8
	 Mf2Vu5n1P/olO33oqNU5edMlde40eY00zelaqnfkXA5WqDT9N+kAe7ls02j1XMZBwa
	 iY2L41SiDkpCg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gbmC04Z4RzLQc
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 17:04:28 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Thu, 11 Jun 2026 17:04:28 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Cc: Daniel Gibson <daniel@gibson.sh>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 3/4] platform/x86/amd/pmc: Add delay_suspend module parameter
Date: Thu, 11 Jun 2026 17:04:25 +0200
Message-ID: <20260611150426.3683372-4-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260611150426.3683372-1-daniel@gibson.sh>
References: <20260611150426.3683372-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Enabling the new delay_suspend module parameter delays suspend for
2.5 seconds which is known to help for some AMD-based Lenovo Laptops
that otherwise failed to send/receive events for key presses or the
lid switch after s2idle. Apparently the EC needs to do some things
in the background before suspend or it gets into a bad state.

There are many reports of AMD-based laptops (mostly but not exclusively
IdeaPads) about similar issues on the web; this parameter gives
affected users an easy way to try out if their issues have the same
root cause and to work around them until their specific device is added
to the quirks list.

The parameter description has a note encouraging users to report
their device so it can be added to the quirks list, inspired by a
similar request in parameter descriptions of the ideapad-laptop module.

The module parameter can be set to "1" to explicitly enable it,
"0" to disable it even on devices that are assumed to be affected,
or -1 (the default) to enable it if the device is assumed to be affected
(according to fwbug_list[])

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 758abcf9f094..ce97c27bc362 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -16,6 +16,7 @@
 #include <linux/bits.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/limits.h>
@@ -183,6 +184,11 @@ static bool disable_workarounds;
 module_param(disable_workarounds, bool, 0644);
 MODULE_PARM_DESC(disable_workarounds, "Disable workarounds for platform bugs");
 
+static int delay_suspend = -1;
+module_param(delay_suspend, int, 0644);
+MODULE_PARM_DESC(delay_suspend,
+		 "Delays s2idle by 2.5 seconds to work around buggy ECs, often causing keyboard issues after suspend. 0: don't delay, 1: do delay, -1 (default): let amd_pmc decide. If you need this please report this to: platform-driver-x86@vger.kernel.org");
+
 static struct amd_pmc_dev pmc;
 
 static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
@@ -697,8 +703,23 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
 	 *
 	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
 	 */
-	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
-		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
+	if (amd_pmc_quirk_need_suspend_delay(pdev)) {
+		/*
+		 * delay_suspend=1 force-enables this, otherwise it can be
+		 * disabled with disable_workarounds or delay_suspend=0
+		 */
+		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
+			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
+			return true;
+		}
+		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
+	} else if (delay_suspend == 1) {
+		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
+			 dmi_get_system_info(DMI_SYS_VENDOR),
+			 dmi_get_system_info(DMI_PRODUCT_NAME),
+			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
+			 dmi_get_system_info(DMI_BOARD_VENDOR),
+			 dmi_get_system_info(DMI_BOARD_NAME));
 		return true;
 	}
 	return false;
-- 
2.48.1

