Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184E37C929
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980839; cv=none; b=iBjGK6STcd+zRARomofD1XLMWQM8ZCdKOqCvhclb6YdOm59riZxtDwCj5bxFoUNSoj8XkyQoKsY/op8c9FbXWzZbwjobWitCxfIPYDtZFlFeoGBIz3Td4b5DJw1csQNhqN18+rUWs4R1KkdeuaUAaq5ERAn9CoVsUD/z+6+8HFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980839; c=relaxed/simple;
	bh=RwGL6dPvRb6s2e54Mz0TPwx035KlPCyMqH0VtmVXm3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTYSy/QYmiQVhcGL0t3L2/+atuiNcdpoifNApeXGvPcAKwuShfUaQFgXuWcOS/bDUNfCyvdaUDD/Hix2UqBG1ZKdC9MXlGmeLNfs0/EmkIZPo92cNoIwDDKUCosi0CkmKqwPr+njWVUDc8pihqU8NI6XEPlXPSQXgg7vaIzJgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojYHKRxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojYHKRxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31801F000FF;
	Wed,  9 Sep 2026 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980838;
	bh=N8dcKqJsdneFm2kcGV7KMWZ/vbjiyGQRZInnHuTvFxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojYHKRxZry02cf/F4wf/beT4rmiC/yvWR6yJfPBmaA1Da2m2DqBYT/gP2f0ZLZo0N
	 20BEyVIEmIEM5+b50tdc0curMQ4crsKxrn77J89EG8qVFk18+BCQxu+0g63EI2GJp6
	 gK6dX12UuY8bOOzJ3dpKS3eNIkpo1cvQehmVI86stlg2Z33UE6kOz6eApTGLiqSaA2
	 mpUw0OTfXaCb78ItcmMxudPC58NZ3xhV5foDI75k0EYX4/BUMYCiJ/jF6oQlj8xx7y
	 0Rw9Dz0XHiikZ+KnFM4Gcg5Hnv+3/6quX2beE+rvSb8aqBSDxEPMv3PftoQErsZfLd
	 MiLs07vDJxChA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] mfd: sm501: Remove #ifdef guards for PM related functions
Date: Wed,  9 Sep 2026 15:07:13 -0400
Message-ID: <20260909190715.3536119-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-reptile-skyline-e58f@gregkh>
References: <2026090352-reptile-skyline-e58f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 3833239b5ba22256389c2fd83ca70b6a9028435b ]

Use the new pm_sleep_ptr() macro to handle the .suspend/.resume
callbacks.

This macro allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 83feedd9d83c ("mfd: sm501: Fix potential memory leaks during remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/sm501.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index fef0dc5684885..1865621d62f27 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1434,8 +1434,6 @@ static int sm501_plat_probe(struct platform_device *dev)
 
 }
 
-#ifdef CONFIG_PM
-
 /* power management support */
 
 static void sm501_set_power(struct sm501_devdata *sm, int on)
@@ -1511,10 +1509,6 @@ static int sm501_plat_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define sm501_plat_suspend NULL
-#define sm501_plat_resume NULL
-#endif
 
 /* Initialisation data for PCI devices */
 
@@ -1716,8 +1710,8 @@ static struct platform_driver sm501_plat_driver = {
 	},
 	.probe		= sm501_plat_probe,
 	.remove		= sm501_plat_remove,
-	.suspend	= sm501_plat_suspend,
-	.resume		= sm501_plat_resume,
+	.suspend	= pm_sleep_ptr(sm501_plat_suspend),
+	.resume		= pm_sleep_ptr(sm501_plat_resume),
 };
 
 static int __init sm501_base_init(void)
-- 
2.53.0

