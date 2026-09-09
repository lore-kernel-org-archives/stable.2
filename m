Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E48370D5C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984069; cv=none; b=E5W7rUQ/dmzbsBTj49SceGoCsVEB8DIt4ihfRUvt1kX3E0clg/nVD4r271ozNwIswKEO9rbSAehMStzt3ontVRSUJs5u1YnR0xUDo+jc8zbY4cFz1vBmwVdkKSVNfvUxNIwqLYgQkEGFvZcZl3JaVulFSBu6UA4j+nnqR6d/zBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984069; c=relaxed/simple;
	bh=1Ry12KTRLZcfua5CWBw86X7nz0fnetvHJGk4LvMBHsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdLyu7ZJeTO2qCiBX/YI5UKYuEJjVYUE81gi8pyD2TYO2MpTCHwsFT9FADJ4sWdmPz3r0buZhzT+sUSM5E3DhCwvjIzzkHzUtmL47835O/vsEIWDyI8Gp1KxvQJ0Jl489X1Od29nn9ZiddNb/9uIXEMH0BUjB0P5rPhXgTySz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2+g4VsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2+g4VsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B2A1F00893;
	Wed,  9 Sep 2026 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984067;
	bh=097stnyYeCRNYGCdTHJRi6UvM/4Feo6NApDIQHXmFqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2+g4VsQ6gpKfNohr7jEujdxL0gwwj66QE+dkHUEseF/py23DUW/vSTJB0fgtzmuC
	 QS/9WudvaaJuLAhhcYILIUyDVnyQSJdwV4d5RxS954gdTzK5A57AyeM47nbLiL/J4U
	 qSNrPYYVWe1spkvnwXZPJJzXf2kVfd+kCvcExIWv49ki6w44bzeG03eAMr3f+Nl01u
	 3OQiP26ceO2xvMTb/rRBbIJ9ARX3uAfSU8fPc6E3R5QcIZDh6oP2Y94XeFmFZ4Z6Xk
	 iuZWhHdAfSlfsydz0chbktAFJe3Xp8naD0I+N/0+46NO8KPe/o9KMgoKy6pDfSsZLi
	 1DC53IqIZo3GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] mfd: sm501: Remove #ifdef guards for PM related functions
Date: Wed,  9 Sep 2026 16:01:03 -0400
Message-ID: <20260909200105.3592162-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-pavestone-customary-a077@gregkh>
References: <2026090352-pavestone-customary-a077@gregkh>
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
index fe95022320343..c4c31a890ab2a 100644
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

