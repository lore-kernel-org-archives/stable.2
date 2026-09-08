Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A8599A38
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891347; cv=none; b=RuAC56RyXfZ37HHuVtOZSOQmjsnHnWm6LtSF6OaV+sxkK+dyUENbZh9YMYPs8ENBav8DiUsrDHDn0iXc5CyYoL/IjyrTLJ/gv+YmNC9KY3NoSMgMt9tEJVA6vVKP+mG0ZSC8y/+1L4j4yKBhOMxdhsku8A5zJZyW+KGaiXx0eLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891347; c=relaxed/simple;
	bh=r7HWAlJNjmswD/8EpIvPuAxSfCZiKeyF/XK8L1Joo2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA1TFlusoqPRpPEwgWFoBpZkQq4Nvtr0zsXcvWeruSPAPhkhEqa4lJQmFy1FECPjciO6cuWek7mmf6WUlmTquyvVctwtlHG+XG6xSyWyzF+m4yb7S3ev5iETedMtRHCVvOyVlozIR6TUzp2RjqwNyf20A9GzvsoM0PJphpYdbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ4qqxen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ4qqxen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB351F00A3A;
	Tue,  8 Sep 2026 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891345;
	bh=VVJhyc3PmzeptUPTsI0Y2y/Ky/+9K/CqdEYCZTcEOVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJ4qqxenWNk/v6u6ivMhb9ycnUSQEDy2UEZ7n1yNL8mEqtW7nw1mx2DuVIPSuRhcu
	 jAJixdcPmMfR0h3FjdAPv/mL9NC1mumEQk60QTI+YNKxTcBVQwXp39VM8qwmlwH/BB
	 W1NHFRcYDP9kP5MvHOGAZvHetzy6jOArUzt+p62BYodOH0vb4WdkO/NcmiHeB/n2R5
	 0LIVI2ayY7JoFYwJigaXLvlGLvc7dcyPiLq/Z2GtWhNkSQEnbZqXdTGO6PRwU2IQWB
	 gB4uBOKGyvF73PvrlCADuEr8Gvp0pXyCxH+wJdLywl3VkTEFoSqdLNSN23s5UqLrO3
	 iHQaCanSf13aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/6] params: Fix multi-line comment style
Date: Tue,  8 Sep 2026 14:15:38 -0400
Message-ID: <20260908181539.191940-5-sashal@kernel.org>
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
index 8c51ce17862ca..03443c99496c6 100644
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

