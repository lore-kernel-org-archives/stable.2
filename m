Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C554B1C4
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890147; cv=none; b=rWFOFTfXGX+xQ7k/CXrfw38FEWO0i4st3nsEBesUzaYMKa/5xfGICTuvV4csVPT0jujZ1SH8NLsOd08JQkqtdJFvX+a7dvfenJ16fdHpmw5mo1u81wINCNL4f60XYSLow0U8UvTsvh4uIhu+i0r6CBi/hA8g70Y0DBgpwmweBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890147; c=relaxed/simple;
	bh=rc0rBJzhtY4AO91GyjPWVnPfi23385KVYLyaJqyLwjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHDI2gc9wt9n7OrXUU6Bafabj2S0vBk0im7wFv8jCinL4f9goqzO1+WxAbbfPVCouJ7wnGxj245ZeXLxp6VGWn81GOC/nEii147eYhY5Yn8d/XAiVys056Z7bzrb9jo5HfFgG6b+o7yvVjbqquEpMXzKFRI+Ud/nHp70lffHW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM14HH/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM14HH/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6051F00A3A;
	Tue,  8 Sep 2026 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890146;
	bh=zcZgGyP1Xly+oZ7Dg84PhlEwmY4p8y18sqvTUwfBMXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QM14HH/Zs32OdbEtzjiYGpQ2ICGE4jNFh1GPSxOHTaxva8DMK3rvL7NuTbB+6Es0O
	 LQl88XhFghF35WtNhAoYzzvhER+XParT+3815jevPTi4Y0K5wcyGMFZ2e0PbLasdX4
	 n7JxI8Vx88Woq8+Aj8czJwA5Dkm6hUT+y1k+gWgHTkcs3Kbh4FJFpRx6fzOhZI5h1V
	 cV1OtJc37TMh0hXbGlaXZMztXmyi5WzdYKbCXbw7gy+bBAjBy6rLAOCyV0E6zU+AS5
	 yLyZLY4h6Jp7u8zWCm6dw+N+LXH4ZYSNMeLDgbRtdZktPAF+qo5ay8m3N0tvyVOARp
	 Atst8BnTIdPgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] params: Fix multi-line comment style
Date: Tue,  8 Sep 2026 13:55:40 -0400
Message-ID: <20260908175541.151692-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908175541.151692-1-sashal@kernel.org>
References: <2026090331-stays-casually-f049@gregkh>
 <20260908175541.151692-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b5e3f86a47d34f7b8af899f8cc70520f6daf8b53 ]

The multi-line comment style in the file is rather arbitrary.
Make it follow the standard one.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20231120151419.1661807-6-andriy.shevchenko@linux.intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Stable-dep-of: 3dfaae04243c ("params: fix charp corruption on allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/params.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 8e085de8551c3..f6d11831749be 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Helpers for initial module or kernel cmdline parsing
-   Copyright (C) 2001 Rusty Russell.
-
-*/
+/*
+ * Helpers for initial module or kernel cmdline parsing
+ * Copyright (C) 2001 Rusty Russell.
+ */
 #include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -275,8 +275,10 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 
 	maybe_kfree_parameter(*(char **)kp->arg);
 
-	/* This is a hack.  We can't kmalloc in early boot, and we
-	 * don't need to; this mangled commandline is preserved. */
+	/*
+	 * This is a hack. We can't kmalloc() in early boot, and we
+	 * don't need to; this mangled commandline is preserved.
+	 */
 	if (slab_is_available()) {
 		*(char **)kp->arg = kmalloc_parameter(len + 1);
 		if (!*(char **)kp->arg)
@@ -741,8 +743,10 @@ void module_param_sysfs_remove(struct module *mod)
 {
 	if (mod->mkobj.mp) {
 		sysfs_remove_group(&mod->mkobj.kobj, &mod->mkobj.mp->grp);
-		/* We are positive that no one is using any param
-		 * attrs at this point.  Deallocate immediately. */
+		/*
+		 * We are positive that no one is using any param
+		 * attrs at this point. Deallocate immediately.
+		 */
 		free_module_param_attrs(&mod->mkobj);
 	}
 }
-- 
2.53.0

