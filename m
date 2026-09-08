Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64859C996
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892135; cv=none; b=tZobBVPU7Mh5TgkQNYnkUcO5f3HNzvze9iiZazMKKwp0z5QHAGK1xPDAYYLvXij6D58OrT+e9JTO2HdMZaN8CJogFsu5XatyGJKScHqMs/PHQ5y6x7MkE+Z0M/bBSKxAXyZ0g6ymU64mpSUTVrrYfTTIXyDKFVBi54qemFVmbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892135; c=relaxed/simple;
	bh=a/gtmHT2211r274jxg/b2cDq5RkTASuvGS/QOhMsBmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7f6cu95+A9RGtZrWWm9430RGuB74nare9mrObJEqjp7a/868MqERnjb8u7lPBiBJVewgoC7qfqPSekPzrhQ+W71iIQQXmt0O8kzJupxf7NNlqqzs3gVIgM1dTQb2KuPm1n991WCtWJ2FhgqqUYtF9Nk6vZtgX9GHKtxqdUlfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKNwHErr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKNwHErr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A26E1F00A3F;
	Tue,  8 Sep 2026 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892129;
	bh=db4373X05gndDLzzF52xeXPNCSaEH0lgu7maR8kY2ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oKNwHErrHUmYq4YCvjucNtA0GBrLtRHqfxBl36chTzApQ5qiCHMQwGVB9aPpPlgcF
	 R72cKo3+I9angs8M8xL91fWvhpCG/41txekvPL5Kssw150jSGahvXJTzpwBM2EGXAD
	 DIVsm3rJ5p6/EjxZgaVZWCgmpeqz6op/k58fLD1LGka0sa2e+++5a2UE6bCkwAA39c
	 To9N1OwvbZCUJJewwt3nIvfsK8EVdzfgdcnSifeNIjKTTi+1eNT7cqRDbjy3RPtGi4
	 V6BHykQOUPPD9R9WPpe+FjAvMWIcBiHiIdqbj9Ir4fpkwRXydLHzAhd24AJLs0IBUp
	 SVXeH8vHA5/lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/6] params: Sort headers
Date: Tue,  8 Sep 2026 14:28:43 -0400
Message-ID: <20260908182845.219246-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182845.219246-1-sashal@kernel.org>
References: <2026090333-barista-diagnosis-cdab@gregkh>
 <20260908182845.219246-1-sashal@kernel.org>
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
index b930d3a4677cc..94ee86e6f8fe1 100644
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

