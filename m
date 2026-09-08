Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BE5921FD
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892137; cv=none; b=qMwaEA4ZLnxMerot/cXQbDMcnx+zw7MbdPZMoK+hKmWVPIq2NXwZbDtophJNWj/MJb+xGyUBZa3LrtjoP9AUWgpi3UPqWvg5vSMqM8askLctj4oSSzlEpz17fzmOfx0kML3gkc27vITJ14OE7p8XAkTWujTpnK2RMQts6OPLj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892137; c=relaxed/simple;
	bh=CMfXBfo7/8F3sjxHx2pJ2p5VFkAC5frPfj9Y0p58AIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paPyFwpiXEXqXP7tbPVuAyaZgoT4SKPU7UfUvQD4cCG+jx5m/lLQTQGX+bN9zcMjDcNQ5FPk90PDmCAxih2izN0BH4pGd2B4gkaJOFtUUWGtDbm/FHwFaUb80MGTMS/AL05V3c6KHeck8SI+JkdSd+oJyptOrFvj0/Us5pme5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAh+bdbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAh+bdbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1004E1F00ACF;
	Tue,  8 Sep 2026 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892130;
	bh=8Eu8XKQ+WCb94ltCI29ZnNtFmOPBjRaSP3eKurieHLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OAh+bdbFl6twAr1w1cmi6wuXV+o0e6K1MTOQXDzVgqm9YVU7ZbUGW6yvEHzqAzJLu
	 wzIcA4bmLGzEy/2sAqtw9VLWViOroLtnX4pk2+/loqCGHX++l9NBVnO3Vk0PW58xpz
	 ewOEXn2+hMFC6FITqXIwQhqspuobMwyImtb/FNsxnGEVfDy6wRppiTk50p5kYB19Xo
	 HNXn/PP7WAK0RsrB0V1IrlnCMb0ew+bpwW+HRSCHFvt8pIKGF/eQIjAMBB9wrh8tVK
	 oRGD1AQNwi5EMFuK2jK6j0OcQ3C+ZtKIDO/Wgk09Cy/AnPsm8SDhPCenvNWnR34UyI
	 LbM1zMtjvG17w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/6] params: Fix multi-line comment style
Date: Tue,  8 Sep 2026 14:28:44 -0400
Message-ID: <20260908182845.219246-5-sashal@kernel.org>
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
index 94ee86e6f8fe1..e6d96f84ac1b5 100644
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
@@ -747,8 +749,10 @@ void module_param_sysfs_remove(struct module *mod)
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

