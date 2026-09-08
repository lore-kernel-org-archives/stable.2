Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E6598BE6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891672; cv=none; b=c4H6hnkzNT4vFTqlaJ4H11e3ZW3awH/LEdM6+7lN3DCZrimoHn78bJW/m6ueH/WH+0kvL//W0RAUJeiQFey2JfpIPEGvyZLWcdNJkLyhFu7DsD07kvx3D82gjOExg7AUrv3QRzAyoE195md9zBNqGS6+mS/GrbtEo2KAsUUTvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891672; c=relaxed/simple;
	bh=12ktaynBAQC3yYHuRVt8N/9o1T/uJ92Bw3CXqMOuGLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNl+Vsb5PxMxwjzZxIbicajHT4ISfMQVpHZLyzH4Jt5RFuOsvRuQQd9MJkx1xF+5IIliSbS2e69kW2r8APgRM7aJk05MCAwCieeSmsTknd0X766kqOLjZbJohRgXcDb0EhC7ZsF3UJ04GyZBUVaD+m3PLK68Gfuf7b0pNfJ2eFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otSVRdyD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otSVRdyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC071F00ACA;
	Tue,  8 Sep 2026 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891670;
	bh=mMZMo4lr0au0b1DzP+ad3+rfT1U0BnNMmSsJ0AsSxq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=otSVRdyDSBMfMZZVrieYIFt79e3JY+BmjlYKnovEK1wLiiMW8CgX6tkNMQzVyubwz
	 FamBOgCc496Ks/xgKnNJ/Ep3pQP81LWC6n8OlvqhGDzclCzXDdkaEnBOKS7wsTijfr
	 aqPHVgjqVIwTS1++mlMIWHZyn4o+FMgWJQHRoMlhQ87idVcNlhdKSB7bqQsKr2orup
	 2RCTYjdMOJYjq/FbmyzcEScZy22LqwqdUKVql21TrsxcsOOihZZ61YLwXZsZM89OpP
	 weCJXCBeU+MSEMVUkI3o5H8qDXzrkASTV41Htl8mvWMFJ1L8eUWNlV/1t6jLe/Lh7e
	 scD3Lp35pzFNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] params: Sort headers
Date: Tue,  8 Sep 2026 14:21:04 -0400
Message-ID: <20260908182106.202353-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182106.202353-1-sashal@kernel.org>
References: <2026090332-lankiness-same-e48c@gregkh>
 <20260908182106.202353-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a05f096c2c0ca52e8fd34740c7d4b53ab3e7123e ]

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120151419.1661807-5-andriy.shevchenko@linux.intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 3dfaae04243c ("params: fix charp corruption on allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 0139fe38d0b2a..dc714a1c67cc4 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -3,18 +3,18 @@
    Copyright (C) 2001 Rusty Russell.
 
 */
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
-#include <linux/string.h>
-#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/err.h>
 #include <linux/overflow.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
 #include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
-- 
2.53.0

