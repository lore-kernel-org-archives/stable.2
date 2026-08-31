Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBD370AE7
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194574; cv=none; b=VKR6UJRSUvce9DG2/pEibXC79gNv6Vg0izoXVAxDMMPwmp6ptjVA0TKYx10nZFqIa0vOBT2NqGm5TQ2Bpgm1OokDm2dZIH0yCcYU4FyJWajZqSMhL4uu5Tcldk08i3wAoKfayf9guMwdxgHIdM/5skMYKj2a2siMbFY8XTVSYNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194574; c=relaxed/simple;
	bh=Ae5qY4dAVgLNMFFkkTHLKE2N6R3nM3YMDZgAvI+HV4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgJSjw/HoDo8VkE1W0YcK5fwa6bt5N3Lb0OzWUcsh4Fk6Dv5NlBcf6LDrEsfXH+unETyAUCPAneFHa/W5/Roz6pqZVefEko8PkZ+UQ7OOhoJmWKv20JHgYr+N4M5FJyWXdgEWftQ7O2G12k4eXOslk95KXBo9IJKDtQzaFv4ig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odaywbhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odaywbhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A141F000E9;
	Mon, 31 Aug 2026 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194573;
	bh=atnRlIfBIqZlNFLcJzeVvXRsxE/uucLeQc3g0yQbqyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odaywbhYmd1X9MY7BrtMZnk2TsiiLaQg4TGAciyNi3vdQvhVG5uoV2eJkKCyCqytF
	 3mPXEdi4TJybp9CccvgGz5S6YDxPyGx88Q2eG/NpPjZfzagAY858LevWA03qdgnyI7
	 SCde/rhMcO2NKQIqjYewldGs5kriLEF3zr5HKPcsbAj6RAHkuCIiX+l0/PGMhjrVjq
	 wkrqv4XQz9CPhMceULKxsOqZ/TA8nbAhQqUMRPwwFPEVnpyj9kcnxhwHAlVV40qq9T
	 0zG2hqWnmfdWe78FCGczI1haYb7AN7s+0D7ZK1tcr4wXfODXgyONH9Cf/mRgjqu9Ct
	 kJtvEBzgnOXfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] fuse: split off fuse_args and related definitions into a separate header
Date: Mon, 31 Aug 2026 12:42:48 -0400
Message-ID: <20260831164250.269934-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083142-tingly-scarecrow-e145@gregkh>
References: <2026083142-tingly-scarecrow-e145@gregkh>
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
Stable-dep-of: edb310bc27f0 ("fuse: fix missing barrier when checking io-uring readiness")
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

