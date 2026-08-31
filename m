Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FC37267C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194597; cv=none; b=J6Oyp6s7kOKg1/ryvwnWCaBKq5fAcL6O2PUOKCWTTK9QxuZmzsmmugFIu2BK5UINrIDWDW6tPSjJcZTuWNaCVphKXJbsDm4b+9cfNMSYot2orJ1q+M8EqnmU1IJqBvn6ut1ioKjQvufFOtEyqe13VdG4LpKMdBvyzXQ+VVAhoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194597; c=relaxed/simple;
	bh=pt6p2zTGYpBQO1aUgYVSHWWakm4i6onZJu0LjsZfg7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p97Gu3E0yVCU7xyjlNSlcqu0eZcwRZV3pFttwFNZAsqlGfy79K3TvgcRdP/MFwCs7GrRA5yxY4Zusc6qDSDWky/pisBo5SDeF9HU6+F5+t048237Qcoc2Fb/PPDL/OenfDHjKWTIYDbkGlRmt2Yl+5syupViaBxrly1AEzmwIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0LUcxZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0LUcxZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E721F000E9;
	Mon, 31 Aug 2026 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194596;
	bh=L3dfDgSe+dffKJaoPr6iYa4nFbOoT8zzZbwRBPulCyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0LUcxZ8ntrImb4ge4BX/00jOq2D/zN+h786nADZCmHSXsfaf3U9TxbF1UgDTbqfe
	 AYJcQX/4vCDcZ/XnshZj2Z/HK5QYdpDmMU6nO2/nzpVGcbRb9kTVSnr8toD1X1853+
	 U8W/0o2uhIwkKEEBKV+Jy9oZMwM/XupqbrWnfX/Ltg/mkxSbWAqSQI/YTviGfXupbi
	 e5w4sli3Dg6wTDqrGxmBy3fP3l0Dg31EODRj3z5/CTG2HgYl00+vlY5cP8wpxijvEc
	 0GXbFPBEu0JCQVM2QAzpi5xD3JLMawwXKsXlP7xJBx0v0r4Fn/X1S+cjuYXP4Smr4y
	 V/HIFV8zhyRdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] fuse: split off fuse_args and related definitions into a separate header
Date: Mon, 31 Aug 2026 12:43:11 -0400
Message-ID: <20260831164313.270365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083132-jaybird-willed-acf3@gregkh>
References: <2026083132-jaybird-willed-acf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 229f9b9b66ab5be9e015422cf30b97740cfbdc8d ]

This is going to be used by both layers (transport and filesystem)

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: ed9c881f3b49 ("fuse: fix race between interrupt and resend")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/args.h   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h | 53 +--------------------------------------
 2 files changed, 66 insertions(+), 52 deletions(-)
 create mode 100644 fs/fuse/args.h

diff --git a/fs/fuse/args.h b/fs/fuse/args.h
new file mode 100644
index 0000000000000..12c94ece569fb
--- /dev/null
+++ b/fs/fuse/args.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _FS_FUSE_ARGS_H
+#define _FS_FUSE_ARGS_H
+
+#include <linux/types.h>
+
+struct fuse_mount;
+
+/** One input argument of a request */
+struct fuse_in_arg {
+	unsigned size;
+	const void *value;
+};
+
+/** One output argument of a request */
+struct fuse_arg {
+	unsigned size;
+	void *value;
+};
+
+struct fuse_args {
+	u64 nodeid;
+	u32 opcode;
+	u32 uid;
+	u32 gid;
+	u32 pid;
+	u8 in_numargs;
+	u8 out_numargs;
+	u8 ext_idx;
+	bool force:1;
+	bool noreply:1;
+	bool nocreds:1;
+	bool in_pages:1;
+	bool out_pages:1;
+	bool user_pages:1;
+	bool out_argvar:1;
+	bool page_zeroing:1;
+	bool page_replace:1;
+	bool may_block:1;
+	bool is_ext:1;
+	bool is_pinned:1;
+	bool invalidate_vmap:1;
+	bool abort_on_kill:1;
+	struct fuse_in_arg in_args[4];
+	struct fuse_arg out_args[2];
+	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
+	/* Used for kvec iter backed by vmalloc address */
+	void *vmap_base;
+};
+
+/** FUSE folio descriptor */
+struct fuse_folio_desc {
+	unsigned int length;
+	unsigned int offset;
+};
+
+struct fuse_args_pages {
+	struct fuse_args args;
+	struct folio **folios;
+	struct fuse_folio_desc *descs;
+	unsigned int num_folios;
+};
+
+#endif /* _FS_FUSE_ARGS_H */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c288f28f6c6ea..7d26159af4059 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -13,6 +13,7 @@
 # define pr_fmt(fmt) "fuse: " fmt
 #endif
 
+#include "args.h"
 #include <linux/fuse.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
@@ -296,58 +297,6 @@ struct fuse_file {
 	bool flock:1;
 };
 
-/** One input argument of a request */
-struct fuse_in_arg {
-	unsigned size;
-	const void *value;
-};
-
-/** One output argument of a request */
-struct fuse_arg {
-	unsigned size;
-	void *value;
-};
-
-/** FUSE folio descriptor */
-struct fuse_folio_desc {
-	unsigned int length;
-	unsigned int offset;
-};
-
-struct fuse_args {
-	uint64_t nodeid;
-	uint32_t opcode;
-	uint8_t in_numargs;
-	uint8_t out_numargs;
-	uint8_t ext_idx;
-	bool force:1;
-	bool noreply:1;
-	bool nocreds:1;
-	bool in_pages:1;
-	bool out_pages:1;
-	bool user_pages:1;
-	bool out_argvar:1;
-	bool page_zeroing:1;
-	bool page_replace:1;
-	bool may_block:1;
-	bool is_ext:1;
-	bool is_pinned:1;
-	bool invalidate_vmap:1;
-	bool abort_on_kill:1;
-	struct fuse_in_arg in_args[4];
-	struct fuse_arg out_args[2];
-	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
-	/* Used for kvec iter backed by vmalloc address */
-	void *vmap_base;
-};
-
-struct fuse_args_pages {
-	struct fuse_args args;
-	struct folio **folios;
-	struct fuse_folio_desc *descs;
-	unsigned int num_folios;
-};
-
 struct fuse_release_args {
 	struct fuse_args args;
 	struct fuse_release_in inarg;
-- 
2.53.0

