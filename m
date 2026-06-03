Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B63E557A
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456290; cv=none; b=nhJfyNCYwjIKUUU4dBt8xS0ro00K2w57QRoFiffSFfvt44aSgWaY9WjllDqIQb6YvQNBtibH+dSYKSJLqz7mFSaY8cpgac0uryHzsCp55rNqy/lavCmQe7C4Y4oGgEFq9IlIDOjl/65KxxFT5GXTCsIgl8nddnT5SLj/K3iqkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456290; c=relaxed/simple;
	bh=iEjA2MjKSCB7UYuBfpm7ZoN6u/xw2LXb42wJfvgR3/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP1+5+MFKqBGPSV5Ppe4LZGF+vEQQtF2JsjS5MNu1fOmnISehXjEZaOXsA05P9yGxn91jdYMz0tcnGJRLULnhGVrGOqhyRwgawxP2gOxd9OAmfJuNg4HDWyt1/EvxJi1IxsYU7QNYogPrAO52XJxxElvX3l/CSkGgriRkXcPddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=B2kGzEDh; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="B2kGzEDh"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gVXlr5YxSzC5D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 05:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1780456280;
	bh=Mx0oPR9bcP29fTc5WI0tJYSbBL/td4L1Mh46SbEbR5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2kGzEDh/HIRFLpf+X19zTY7k3m3sQfei3dMulLLhaiqXNpfaZ+3uFGJHnYw/hUr3
	 i7wIM7f2Dq4lS9zr1kVhDkSAv9nB40WM2YmLgxOX9IJuHY4LPBplUxSl9WSA/QvG/W
	 13ApwIH5iz2pdLOncpId2LLelBSZtChoZrH5GQjUsZBjQZbbe/2lMe0KfSIv9dlKmE
	 XEsOjF6uqgRc2kW3uMInIirqm6yklVzO63/Ujkp92yk0gG0qgDzMRWEDJXLha2vyjF
	 lT785sDM0PS7i293uJbHMSOIfcsqgdGIBLIiADFTbq+B2qSRFT8cta7c5Efzqe1bQD
	 fQELIDHixWCPQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gVXlr2CfGztq5
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 05:11:20 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Wed, 03 Jun 2026 05:11:19 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Cc: Daniel Gibson <daniel@gibson.sh>,
	stable@vger.kernel.org
Subject: [PATCH v3 RESEND 1/5] platform/x86/amd/pmc: Check for intermediate wakeup in function
Date: Wed,  3 Jun 2026 05:11:06 +0200
Message-ID: <20260603031110.345815-2-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260603031110.345815-1-daniel@gibson.sh>
References: <20260603031110.345815-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Refactor code introduced by commit 9f5595d5f03f ("pmc: Require at
least 2.5 seconds between HW sleep cycles") to allow adding different
conditions for that delay in an upcoming change.

Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index cae3fcafd4d7..2b9e5730170a 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -598,6 +598,19 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	return rc;
 }
 
+static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
+{
+	/*
+	 * Starting a new HW sleep cycle right after waking from one
+	 * can cause electrical problems triggering the over voltage protection.
+	 * That is avoided by delaying the next suspend a bit, see also
+	 * https://lore.kernel.org/all/20250414162446.3853194-1-superm1@kernel.org/
+	 */
+	struct smu_metrics table;
+
+	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
+}
+
 static void amd_pmc_s2idle_prepare(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
@@ -632,11 +645,9 @@ static void amd_pmc_s2idle_prepare(void)
 static void amd_pmc_s2idle_check(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
-	struct smu_metrics table;
 	int rc;
 
-	/* Avoid triggering OVP */
-	if (!get_metrics_table(pdev, &table) && table.s0i3_last_entry_status)
+	if (amd_pmc_intermediate_wakeup_need_delay(pdev))
 		msleep(2500);
 
 	/* Dump the IdleMask before we add to the STB */
-- 
2.48.1

