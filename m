Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6531F9BD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980485; cv=none; b=mDyJTtI/uIQOhxDzAfYUIzvmRAhqrr7eG+RdiMTKmzVLUFpuz9Ffi9xMx1WURbdVthDxck7ejFCzv7gjw5n6ZGSqUlW6m0LCgBtkOiaLyThZ6gw5BKj1niMQ7Xw+CIytfuwq5hcqa4GDiPUQ4Dic2BtzZPUKDE0oXpY7iEghpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980485; c=relaxed/simple;
	bh=RwGL6dPvRb6s2e54Mz0TPwx035KlPCyMqH0VtmVXm3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8j1CFt8bgJNm+63Knz5FyhCnjhVDOikjtgvFYRK0umZem/L0NE1lw70yTAxjqU5gKKkYe27gSqb/cDXDVk0YFXEIP7sXEKMHg6klp24DGN5Olmhm/FQWY4U64Se/t8wLKvugQ5belnF3gLnm1iXysYE4G/PWwxaCfZVKIKZQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVdkuESG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVdkuESG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD8C1F00893;
	Wed,  9 Sep 2026 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980484;
	bh=N8dcKqJsdneFm2kcGV7KMWZ/vbjiyGQRZInnHuTvFxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kVdkuESG4ZiCJqw+8L/XoM9DfQdvzew/U/5AbGjZNUVndDCozx079A29ShqwrJn8I
	 pMpIls5iiqDBqNw7uqGwZV/O2K8U3Wu2Y3Ak1QEoYEEn+sqQccZt3wYIDbe6W0OB95
	 5PERlVbA4aA3RaYC2sREnMf0qoYAiVKQGwM6E3XCbHxIL6dZJBplTH7Et1QxCGHUm6
	 GSi0MdDqprU9MLhLP9ciylfuomaeU9S3QLFT83XRMscG5gJBdbZlzY4to/noVoQv/2
	 sLI4w1K79fVn5nVtab/+EX43FHR9TXfrTOtluVTmqd5n1vlIwiExEfSpYix1q45ncK
	 fFM3HobJxQ8hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] mfd: sm501: Remove #ifdef guards for PM related functions
Date: Wed,  9 Sep 2026 15:01:19 -0400
Message-ID: <20260909190121.3510965-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090351-runway-afraid-7fc2@gregkh>
References: <2026090351-runway-afraid-7fc2@gregkh>
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

