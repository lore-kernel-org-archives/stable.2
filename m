Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665D37DEBE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739262; cv=none; b=FydQba1Msw1/gaWFNV29T+t6VO9otiBUabdaSIB5Z2a0CFl6bu88q/9Co4RmqVjawe2PFHGL9wyI8VrNMAzyyCejdvTTnPhBoPc66we+H5XdusVigP8CPRY+k1ajoMVumfms+eg8ohJpkro3qmazdKa616Kr31C+5nULCe+cLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739262; c=relaxed/simple;
	bh=jgZhpNuGJsuUOkTvMAEynwEATsIKv77rBK76z4sRDJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wsyq/pofndYbp2AkjfrVoq6YG+c74UiJELi0O9DAVHmD3ZG/hUCk9KFBOWOsTo0RyYBKOhIgFHoZ6FcQL2CJ6n2cmzJiOQKZIvwJBvhjy8/4UQmQU0UCiogenZXD2kVvEFDEDYrT/naaxWNQuEMwYQeL7qMTwxco03vvcNnSA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=WMRHXdgQ; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="WMRHXdgQ"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h50hm1gvSzWys
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1784739256;
	bh=H5tNkW++EOh3AbW6eD0nREGLjc854Nql3h0rKadMuLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMRHXdgQIlyaxDs1dSgUA4v7ccfXIr77CDg4Ey0bS0U2MGtkxEnY9T6sDaCLiWV9A
	 9oxLvQwb+pSyYtn14SzeDLk60IzoaN8eHLAoBBVmjglnM1Cs4skC3Yz4y3o7GM29ri
	 wRbqZwVOe1Fpml9a+ZjX++5PYp05OucFiUOBWFkgLo7wudYNkUry2A4Zx3zgouQXlu
	 xp8P4vIk5ZYZQJm6j6C6TLWfl0RTtZ9FqzCxE0itQCcRhjLextBdKX0RA5d7TGaQMJ
	 Qp0caViTm9S43IYau3gn3N0vrXj7ucQXCLs73OBegwiMC3uzyILfT2Am80Q5YQWUiW
	 75ioKV/NAavrQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h50hl5SNszXq1
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:54:15 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Wed, 22 Jul 2026 18:54:15 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: stable@vger.kernel.org
Cc: Daniel Gibson <daniel@gibson.sh>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] platform/x86/amd/pmc: Avoid logging "(null)" for DMI values
Date: Wed, 22 Jul 2026 18:54:02 +0200
Message-ID: <20260722165402.3199573-3-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260722165402.3199573-1-daniel@gibson.sh>
References: <20260722165402.3199573-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

commit a0738abd042f7406edd2175a819cf2e66388ed97 upstream.

dmi_get_system_info(...) can return NULL. Using that as %s arguments
of dev_info() would log "(null)" (as part of a message like
'... System Vendor: "(null)", Product Name: "(null)" ...'), which may
be confusing for users.

Use Elvis operator to print "(Unknown)" instead.

Fixes: 428b9fd2dce5 ("platform/x86/amd/pmc: Add delay_suspend module parameter")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606251540.Nr2BtaNu-lkp@intel.com/
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Link: https://patch.msgid.link/20260626220210.1761783-2-daniel@gibson.sh
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index b09512368877..bf6c7ca247e2 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -852,11 +852,11 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
 	} else if (delay_suspend == 1) {
 		if (!intermediate_wakeup)
 			dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
-				 dmi_get_system_info(DMI_SYS_VENDOR),
-				 dmi_get_system_info(DMI_PRODUCT_NAME),
-				 dmi_get_system_info(DMI_PRODUCT_FAMILY),
-				 dmi_get_system_info(DMI_BOARD_VENDOR),
-				 dmi_get_system_info(DMI_BOARD_NAME));
+				 dmi_get_system_info(DMI_SYS_VENDOR) ?: "(Unknown)",
+				 dmi_get_system_info(DMI_PRODUCT_NAME) ?: "(Unknown)",
+				 dmi_get_system_info(DMI_PRODUCT_FAMILY) ?: "(Unknown)",
+				 dmi_get_system_info(DMI_BOARD_VENDOR) ?: "(Unknown)",
+				 dmi_get_system_info(DMI_BOARD_NAME) ?: "(Unknown)");
 		return true;
 	}
 	return false;
-- 
2.48.1

