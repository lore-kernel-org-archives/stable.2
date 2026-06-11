Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273342D1916
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191438; cv=none; b=isIYyKYUy1zU468JvZ6IZ+ooO66uZ6nmpND/DUrsDZexjJvf6Q2LuqDiwxqFQThlcPLIFOCCiPGnY7miG3gVtmLPp0lvhvuD5sWbTgxF6k6VHvSP7EacHyC4jGcUojRaoB5JO7SOGumw8CS5/3VKylG4imze/vDwPEXlr+8R5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191438; c=relaxed/simple;
	bh=ldEjmRTtGXtvqQM36rVtzfGUKHm6h3b8k6Yyh6EYEKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXDhE5IJBCZ7jU0DMdEHFpGEu7jSzrrPrAKiDVW6uiWo+3mB5kELshSafCUOhIP+UfsZsrTIPd3dXycTVRQpDQrBj7Aa7yrWBb76t+52QKbmFCAhsSGsdHlG6YYWUyC5fGQDJizk3mvHRmMeftqYRatZ1E8MMBn/j4Y4tUFITcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=hQW09xmG; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="hQW09xmG"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gbmC11gQ0zs5Q
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 17:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1781190269;
	bh=ddd/C3MV0f6jniH/HHXw2Qim2MIZ2eDJT+LOTz2LunY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQW09xmGBqkq7dG1XG+cJEg6suA8GT2Ady4qpxiGi+MLfTFo/94yCdORf/yzxP5Yo
	 2EuqsN5cgPkJeN7XsFpnJvdK4gn4cmUCidUOvTd1veTUC5HAfQYAl22bhBKBasokcR
	 7/x//ngeke8Q8sL5XNp/83tMx1gGH84zohXGf2mZHUR/4qiG64FX1aI5/u42TYwlsc
	 ngcQnGA34H+3xObHZQyMPpKeg9BDN8davm0af1zVU8cm0YhjOfj3kLIoNNWWE2vQSz
	 1R6trNvOiiwT5V48EDZ8XRQ0p00mWzZ9PzCAswYRe5os/r7CMyGa+L2+OLYW7+VYNV
	 wD+lqO+MXcTbg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gbmC049FDzvnh
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
	stable@vger.kernel.org
Subject: [PATCH v6 1/4] platform/x86/amd/pmc: Check for intermediate wakeup in function
Date: Thu, 11 Jun 2026 17:04:23 +0200
Message-ID: <20260611150426.3683372-2-daniel@gibson.sh>
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

Refactor code introduced by commit 9f5595d5f03f ("pmc: Require at
least 2.5 seconds between HW sleep cycles") to allow adding different
conditions for that delay in an upcoming change.

Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index ccb37383b337..25509099a958 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -670,6 +670,19 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
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
@@ -702,11 +715,9 @@ static void amd_pmc_s2idle_prepare(void)
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

