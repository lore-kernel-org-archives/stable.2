Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CB59C976
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891672; cv=none; b=bGwjwBSwJKC+tUyUfIaZQg560rs/8XHRnS3D2mbiBJuzdUteNdWKRool9h5CUjakQe+Z6EAi/5n21DLIZMaRZF5PpiGvhpStyGl+butSPpJKaEXHhbSDH9rvt3PoIuTx36++B/ecU6l20NcYXYQNPRxnVRf3zkx2EYtf5ggqDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891672; c=relaxed/simple;
	bh=2xeNW2iNp0e4Ey19MqxkD7s3qTC6MUTV0TFdOTppbMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0ml/2a5/uBWpYDCkU5cr+Jjwy3YwXkEgR+srUw+b/Ww3Lx7o0RCwmEYO2xcKQm13EPjcgyfkPN5mTKJn3sQ7xq9QifMmQxWk4dJ64XLxEnzc8VlXBiODxHewbqPxwSxJYqI1NUQq9z4dWCa8nxONfGfKPwtQVPqpjPlbvLqYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYDzbLh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYDzbLh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE31F00A3E;
	Tue,  8 Sep 2026 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891671;
	bh=RP3jCEPgpMul/Wc/pdtGa8yLco0ue3kdy2bvyNBodXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYDzbLh3CAvou7HSsw1ByDG5Z7ZDWt64AeHd8Lw08tvSnnBUPRDV61Ly2vRqKsDsW
	 qqwk+LRIeqr9BlN0y+SeTN58iV6dsjS0PKgga58sh5zPFcm0smZA71ECE4Z54fJ8hC
	 VvGjm58qsi/lnF/IVYILMIIBj/IgB8PbeXiJrvuNMypl/Yf5ESrDaucgfYOtDRYw0G
	 ZmL0jet+TdW5W+ZPsiRbCxlyreP3Ie6+IAn9zM/rejuRAN4ogrkhLCO13yE4coP4NY
	 UNkR1KADxHy0reoBdP6Mpye4WwuoItPvrASZq6NmdwMViCzAvxjSi749DEeYclnWSr
	 VG8HJqRykbfFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] params: Fix multi-line comment style
Date: Tue,  8 Sep 2026 14:21:05 -0400
Message-ID: <20260908182106.202353-5-sashal@kernel.org>
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
index dc714a1c67cc4..e1eba5b8230c1 100644
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

