Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86559D623
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891347; cv=none; b=BTYXC1ioveBQnnbmzRMXcRI7X5S0/Gk0lnBQOeR/jAlZwJ7vOycbho/weAismUyQA0axEaH98Mox7HZPZd4QEFchwjNiSUSv6g4R3HDzyrhCpKJ8SplFsAArgr5KzzzRu9tqDZ0eVRtA/yrc1Z39ykXniyoqGqncKe0DWSU4x9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891347; c=relaxed/simple;
	bh=WsOIECkHNmxAjb7nTOMl1HwdcCIaAugOZfNzoRPcVLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvUavaGnpjllY61HKVg08Wc28QNzIiiw/JKw9QhuhUGZIuPWeMkKfykt0S4CfoGH87aQFFd6Kz9UUmUaJMKCUb4NUO+mK2hh2M1eq6slOQTcK5ZQJ4Nq0fIrlKt0sEXpJeCmBuVtlkntv2x8c/2Tb2or2jSLBzjQjYMvuEUhGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBseG6IF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBseG6IF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A281F00ACF;
	Tue,  8 Sep 2026 18:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891344;
	bh=lIVzVEropEM+gPJTpr6yF/zAy81Og4jJGv/bQJV9nc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XBseG6IF/jssjqrpJeWiRQfgbEpo7t7YjnM7Ge0pmP7MzifTYHltbfupI/61bqKcM
	 ruyR4wXsCttBuSvtimBFTRYHAj4EfAVQVvURpRr6jNMwk7OjB91ZpQrS+yH8nCiSqw
	 FX/is9060ECUyf5fn24bEFHQYo+f0WYdBuTMwxBRuQNwpUmofhiqDqvbPmO9C5qj5z
	 224SBB9py0hcoGOsyx1itrnXmQJzrNW3v9iM6NfB+FWxutb0KRlOvOEX6XyaZQj1BS
	 +Bcts8eszvKpb1I+1gH3yaPjOHby4Dv7BZuRfeNdcOxdgFqiVQwVYZrTUflyVDRLzD
	 YDAnCWG3NF/yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/6] params: Sort headers
Date: Tue,  8 Sep 2026 14:15:37 -0400
Message-ID: <20260908181539.191940-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908181539.191940-1-sashal@kernel.org>
References: <2026090332-blazing-handcart-8248@gregkh>
 <20260908181539.191940-1-sashal@kernel.org>
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
index 4d021ba9c677a..8c51ce17862ca 100644
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

