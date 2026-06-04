Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6125228D
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570163; cv=none; b=QuVXpvFV96lYZjFQs5ekGwM2b5wynRv4ntVclxFaCLIWvlAGAX4wKq6xjyib/Hs9E0tkL4VErmkX0HyoBmD85I+zq9jzdeOpKnDQbZxBoiEwXEsRIFLFqtgNMcG2AnBSlYFR1WDYvKPsnUgG3O3VjBl3BUPZUlDpXashz64nVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570163; c=relaxed/simple;
	bh=WWXOzENIVz8DhY3xdScoNTUKazrAyifkHwc73r/MCrM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ez/wsE7LaEniXIsSP5R2F3FUokSqqbqazLAtq/fOwLj2GCjkCNdUIBf/scibq0HmfvHDhbqN7UjOSFpVWK+5tXfdL63wGxfj+YkmDCL8I0U2+hPBfvSXRZ2mdSUWdwDrEEaq3hA9DtIhr3xg9WYFJ9G1lah+cjOBvSPXCTZWPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FRa5ljod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FRa5ljod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120151F00893;
	Thu,  4 Jun 2026 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570161;
	bh=zJGnAZqyHA7AuYIOFZwe5PDD+WUDRv1XDAV9DF9Z7Q4=;
	h=Subject:To:Cc:From:Date;
	b=FRa5ljod30XZt0i+18FTS9oHlh9HerIKgP3zYlt5/jUaGUfhqX/BBZREHlldc9zdG
	 ueBZcUWfsuFOMOSI9MOK7WktnZ6/LjZIrMA3W9vyyYRD30pfVtAOlJkuePBJIEj7Pv
	 WZT6P3qX8I4DsYpA0tAUWPqtcnKWpgHxXeOQYVmE=
Subject: FAILED: patch "[PATCH] thunderbolt: property: Cap recursion depth in" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:48:10 +0200
Message-ID: <2026060410-caloric-peculiar-b695@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 928abe19fbf0127003abcb1ea69cabc1c897d0ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060410-caloric-peculiar-b695@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 928abe19fbf0127003abcb1ea69cabc1c897d0ab Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sun, 10 May 2026 19:16:58 -0400
Subject: [PATCH] thunderbolt: property: Cap recursion depth in
 __tb_property_parse_dir()

A DIRECTORY entry's value field is used as the dir_offset for a
recursive call into __tb_property_parse_dir() with no depth counter.
A crafted peer that chains DIRECTORY entries into a back-reference
loop drives the parser until the kernel stack is exhausted and the
guard page fires.  Any untrusted XDomain peer (cable, dock, in-line
inspector, adjacent host) that reaches the PROPERTIES_REQUEST
control-plane exchange can trigger this without authentication.

Thread a depth counter through tb_property_parse() and
__tb_property_parse_dir(), and reject blocks that exceed
TB_PROPERTY_MAX_DEPTH = 8.  That is comfortably larger than any
observed legitimate XDomain layout.

Operators who do not need XDomain host-to-host discovery can disable
the path entirely with thunderbolt.xdomain=0 on the kernel command
line.

Fixes: cdae7c07e3e3 ("thunderbolt: Add support for XDomain properties")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 74c92f9801ff..da2c59a17db5 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -35,10 +35,11 @@ struct tb_property_dir_entry {
 };
 
 #define TB_PROPERTY_ROOTDIR_MAGIC	0x55584401
+#define TB_PROPERTY_MAX_DEPTH		8
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	size_t block_len, unsigned int dir_offset, size_t dir_len,
-	bool is_root);
+	bool is_root, unsigned int depth);
 
 static inline void parse_dwdata(void *dst, const void *src, size_t dwords)
 {
@@ -97,7 +98,8 @@ tb_property_alloc(const char *key, enum tb_property_type type)
 }
 
 static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
-					const struct tb_property_entry *entry)
+					const struct tb_property_entry *entry,
+					unsigned int depth)
 {
 	char key[TB_PROPERTY_KEY_SIZE + 1];
 	struct tb_property *property;
@@ -118,7 +120,7 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 	switch (property->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 		dir = __tb_property_parse_dir(block, block_len, entry->value,
-					      entry->length, false);
+					      entry->length, false, depth + 1);
 		if (!dir) {
 			kfree(property);
 			return NULL;
@@ -163,13 +165,17 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 }
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
-	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root)
+	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root,
+	unsigned int depth)
 {
 	const struct tb_property_entry *entries;
 	size_t i, content_len, nentries;
 	unsigned int content_offset;
 	struct tb_property_dir *dir;
 
+	if (depth > TB_PROPERTY_MAX_DEPTH)
+		return NULL;
+
 	dir = kzalloc_obj(*dir);
 	if (!dir)
 		return NULL;
@@ -200,7 +206,7 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-		property = tb_property_parse(block, block_len, &entries[i]);
+		property = tb_property_parse(block, block_len, &entries[i], depth);
 		if (!property) {
 			tb_property_free_dir(dir);
 			return NULL;
@@ -239,7 +245,7 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 		return NULL;
 
 	return __tb_property_parse_dir(block, block_len, 0, rootdir->length,
-				       true);
+				       true, 0);
 }
 
 /**

