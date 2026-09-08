Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E44CC28D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861680; cv=none; b=fENDInBM7H3PLkcz5ssDFJBT6lACHwOhpSFBf6KJptQgLUeXDmhxJbGE40E1R1WAwaap4bWI8TGSP+zzJfZ4Dqi40mpjFB0cEw7YNklEo3mzev5zHnLuOzOujycP4c+Sg/c0WOHc7xUau1KqkF/o7SGazNvwS1cxqANqN2BJg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861680; c=relaxed/simple;
	bh=prqhbGL2ybSLdgXaQzKESe6ayZWuxHZHzfaM0LS9ww0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YFzy916LhHrbL+Sxs9WXMAsETgTRtPWyAYWcrmosFh/I70/9JLvP4oXNmRJiDnDv47OsoG2H504+yzbTroLt7MvX78o52fR10Ko4j5Zlt8iWSfrq7fZNnSEzFN5PxjBI352DMEgpGFssVQKSMV2Ve+D6BFPKZTYgP6m8mrpcdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Za83YX9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Za83YX9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E3A1F00A3A;
	Tue,  8 Sep 2026 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788861678;
	bh=lRspDD1x9OlIjsC2tc03S1DsvgbPJdM31BKtNMMD8os=;
	h=Subject:To:Cc:From:Date;
	b=Za83YX9jidjqn17e10MyyLuZV2dtJ7LHWHC+4Y2pudQBLbmlS78gqRFE39KVUA/Hu
	 Pd38a5ImEdMBU5XSQfT35e6ga4b05EQJw6adbExkcb81FvME8YLwdNAPOpZhC5wLrh
	 B4J7ouEB2b9ULylXODaT4HtYqwzOJp5jSM/7Wx8Q=
Subject: FAILED: patch "[PATCH] fs/ntfs3: fix slab-out-of-bounds write in" failed to apply to 6.6-stable tree
To: skyexpoc@gmail.com,almaz.alexandrovich@paragon-software.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 12:01:03 +0200
Message-ID: <2026090803-neutron-crazed-bd82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7c4841e2a62794a3bab7c1ff0540580f387e377f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090803-neutron-crazed-bd82@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c4841e2a62794a3bab7c1ff0540580f387e377f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?HE=20WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89?=
 <skyexpoc@gmail.com>
Date: Wed, 10 Jun 2026 09:29:29 +0900
Subject: [PATCH] fs/ntfs3: fix slab-out-of-bounds write in
 ni_create_attr_list()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ni_create_attr_list() allocates a fixed buffer of al_aligned(record_size)
(== record_size) bytes and then walks every attribute of the primary MFT
record, writing one ATTR_LIST_ENTRY per attribute and advancing the cursor
by le_size(name_len), with no check against the end of the buffer; the
total size is only computed after the loop.

A minimum-size resident attribute occupies SIZEOF_RESIDENT (0x18 = 24)
bytes on disk, but an unnamed attribute expands to le_size(0) (0x20 = 32)
bytes in the list.  Because the number of attributes in a record is not
bounded (mi_enum_attr() accepts arbitrarily many equal-type, nameless
minimum-size attributes), a crafted record packed with such attributes
produces a list larger than record_size and overflows the heap buffer.

This is reachable from a crafted, loop-mounted NTFS image: opening the file
and adding an attribute (e.g. via setxattr) drives ntfs_set_ea() ->
ni_insert_resident() -> ni_insert_attr() -> ni_ins_attr_ext() ->
ni_create_attr_list().

  BUG: KASAN: slab-out-of-bounds in ni_create_attr_list+0xc48/0x1058
  Write of size 4 at addr ffff000008984c00 by task setfattr/345
   ni_create_attr_list+0xc48/0x1058
   ni_ins_attr_ext+0x510/0x7c0
   ni_insert_attr+0x3f8/0x70c
   ni_insert_resident+0xc8/0x3b0
   ntfs_set_ea+0x66c/0xd28
   ntfs_setxattr+0x4d8/0x5b0
   __arm64_sys_setxattr+0xa4/0x124
  Allocated by task 345:
   ni_create_attr_list+0x188/0x1058
  The buggy address belongs to the cache kmalloc-1k of size 1024
  (the write lands at object+1024).

Size the buffer from the actual attributes instead of assuming a single
record_size is always enough.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Reported-by: HE WEI（ギカク） <skyexpoc@gmail.com>
Signed-off-by: HE WEI（ギカク） <skyexpoc@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 547c8ab1b6b8..3ad309d38fe8 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -768,10 +768,23 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	rs = sbi->record_size;
 
 	/*
-	 * Skip estimating exact memory requirement.
-	 * Looks like one record_size is always enough.
+	 * Compute the exact size of the attribute list.  Each attribute in the
+	 * record yields one ATTR_LIST_ENTRY of le_size(name_len) bytes.  The
+	 * minimum on-disk attribute is SIZEOF_RESIDENT (0x18) bytes, but an
+	 * unnamed one expands to le_size(0) (0x20) here, so a record crafted
+	 * with many such attributes needs more than a single record_size; the
+	 * previous fixed kzalloc(record_size) could therefore be overflowed by
+	 * an attacker-controlled record.
 	 */
-	le = kzalloc(al_aligned(rs), GFP_NOFS);
+	lsize = 0;
+	attr = NULL;
+	while ((attr = mi_enum_attr(ni, &ni->mi, attr)))
+		lsize += le_size(attr->name_len);
+
+	if (!lsize)
+		return -EINVAL;
+
+	le = kzalloc(al_aligned(lsize), GFP_NOFS);
 	if (!le)
 		return -ENOMEM;
 
@@ -781,7 +794,6 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	attr = NULL;
 	nb = 0;
 	free_b = 0;
-	attr = NULL;
 
 	for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
 		sz = le_size(attr->name_len);

