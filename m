Received: from cvsmtppost31.nm.naver.com (cvsmtppost31.nm.naver.com [114.111.35.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8F2BF3D7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734518; cv=none; b=TCjqna371X/TcZTc8iYDLU2IeKW8p6L0Q2hSLhHX0LTlaj6qzFD8H90BcenRJqyNKUQdINPQcTefdZdHZ7dGCiMbHqu62SOCmAMnUfcaxBSL5CSvyMF7Sq3lYYQ+AbLL7V+4os/oCKGlt6YBAU/+DCp5YOXgCrMD/63S22C4fAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734518; c=relaxed/simple;
	bh=Odm4bgUe5yiGB1PQFAXlnF8TGTM0tTyU/1kX3aDHpWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cw4yRNXyhi+bKEzVZ+hiPpdz7LMGoghpWgXUflhMtHHM+FMimT5ft5qxqFDbdnhCIVbdWS+ixKAvkWtPKoIB/2RotB4kTOD/JVRnwhVSj76t24z6Ql9Z2eCvjbtNTrQ1jEADOqKDUbMQ2aHwl2AgwWjVPIeXXucASkrpCBsoDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=CApIy78F; arc=none smtp.client-ip=114.111.35.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="CApIy78F"
Received: from cvsendbo026.nm ([10.112.20.48])
  by cvsmtppost31.nm.naver.com with ESMTP id NeDj2TtZTT62sZ5AIADAGQ
  for <stable@vger.kernel.org>;
  Mon, 03 Aug 2026 05:21:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1785734508; bh=Odm4bgUe5yiGB1PQFAXlnF8TGTM0tTyU/1kX3aDHpWI=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=CApIy78FiC+hxk0kQn++GlULR9pInsVQL3vbsWoDP58Bk94R1xSVaCA8EROzRfE1E
	 fVc2woqg6bmslEH9+2wnDkzwrWNmQtmM6xL88gl8t555afqjEAMTcK4vZxAZiswWd4
	 Qx31MSMflefisTg22LGyCV5pJE7XzAsDS8kf6eQUACuAfS4gUsuxViN80rRFNu0f1R
	 jnvHnQsjtFIoJFh0KJ7TvBGb6hG2Qe3EbJgHea41q+jMoK2CNNc8EnZUJZ84GZdybV
	 6PhMaHcEF37TLtqp2JQcgiqA7SRjAiUbZJYhQPg8LeIfCqQp4j9Hhtepgnq8NyUIhV
	 fcPbpB1Q3H0XQ==
X-Session-ID: 2Llb3e00Q4Ooir7Ie8einA
X-Works-Send-Opt: rle8W4eXjHwYKBm9FAF9FHmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: YwnmFqE/FqJZ+HmXKAuZ+6E=
Received: from localhost.localdomain ([125.131.91.97])
  by cvnsmtp009.nm.naver.com with ESMTP id 2Llb3e00Q4Ooir7Ie8einA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Mon, 03 Aug 2026 05:21:47 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyeontae Lee <wonju345@naver.com>
Subject: [PATCH] fs/ntfs3: bound DeleteAttribute asize against rec->used in do_action
Date: Mon,  3 Aug 2026 14:21:45 +0900
Message-ID: <20260803052145.71949-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_action()'s DeleteAttribute case (fslog.c:3316), attr is
Add2Ptr(rec, roff) with roff taken from the on-disk lrh->record_off, and
asize = le32_to_cpu(attr->size) is read straight out of the MFT record:

	asize = le32_to_cpu(attr->size);
	used  = le32_to_cpu(rec->used);

	if (!check_if_attr(rec, lrh))
		goto dirty_vol;
	...
	memmove(attr, Add2Ptr(attr, asize), used - asize - roff);

check_if_attr() (fslog.c:2869) walks the attribute chain from
rec->attr_off and returns o == ro.  Its loop breaks on ATTR_END, so ro may
legitimately equal the offset of the ATTR_END marker; that is exactly how
CreateAttribute appends to a record.  But check_file_record()'s walk
(fslog.c:2831) also stops at ATTR_END, so check_attr() never inspects the
bytes there.  When roff is the ATTR_END offset, those never-validated bytes
are what gets read as attr->size, and used - asize - roff underflows.

The read itself is also unbounded: roff is a u16 and attr->size is
dereferenced at fslog.c:3317, before check_if_attr() has constrained roff
at all, so it can be up to ~64K past a record_size-sized object.

Commit 0ca0485e4b2e ("fs/ntfs3: validate rec->used in journal-replay file
record check") added at fslog.c:2844

	if (used < PtrOffset(rec, attr) + sizeof(attr->type))
		return false;

and its changelog names this very memmove.  It bounds rec->used against the
ATTR_END offset; it does not bound asize.  With record_size 0x400,
attr_off 0x38, a valid three-attribute chain ending in ATTR_END at 0x158
and used 0x160, a record whose four bytes at 0x15c read 0x100 gives

	used - asize - roff = 0x160 - 0x100 - 0x158 = 0xffffff08

i.e. a ~4 GiB memmove whose source and destination both run off the end of
rec, a kmalloc(sbi->record_size) object (record.c:105).

The equivalent non-replay path already refuses this.  mi_remove_attr()
performs the same removal and starts with (record.c:548):

	if (aoff + asize > used)
		return false;

Apply the same bound, spelled as a subtraction to match the neighbouring
cases, and move the attr->size read after check_if_attr() so that the
header is known to lie inside the record before it is dereferenced.
Requiring roff + SIZEOF_RESIDENT <= used rejects the ATTR_END offset
without rejecting any real attribute: for an attribute the walk validated,
roff + asize <= off(ATTR_END) <= used - 4, and any attribute a
DeleteAttribute record can legitimately name carries a full resident
header, so roff + SIZEOF_RESIDENT <= roff + asize <= used - 4.
check_attr() itself imposes no lower bound on asize, so a crafted
sub-header asize can still pass the first test; the second test then
bounds it and the memmove stays inside the record.

Reproduced by mounting a crafted image on v7.2-rc5, which already contains
0ca0485e4b2e, under KASAN.  The image is an ordinary mkfs.ntfs volume with
four bytes of one MFT record changed and a crafted $LogFile:

  BUG: KASAN: slab-out-of-bounds in do_action.isra.0+0x3211/0x83c0
  Read of size 4294967048 at addr ffff888002423258 by task mount/66

  CPU: 1 UID: 0 PID: 66 Comm: mount Not tainted 7.2.0-rc5 #3
  Call Trace:
   kasan_report+0xce/0x100
   kasan_check_range+0x105/0x1b0
   __asan_memmove+0x23/0x60
   do_action.isra.0+0x3211/0x83c0
   log_replay+0x920a/0xd300
   ntfs_loadlog_and_replay+0x3ef/0x510
   ntfs_fill_super+0x1d23/0x4550
   get_tree_bdev_flags+0x2ef/0x550
   vfs_get_tree+0x82/0x2f0
   fc_mount+0x10/0x1b0
   path_mount+0x517/0x1df0
   __x64_sys_mount+0x20b/0x270
   do_syscall_64+0xf9/0x540
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 66:
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_noprof+0x1b4/0x460
   mi_init+0x81/0x110
   mi_get+0x6a/0x220
   do_action.isra.0+0x1dbf/0x83c0
   log_replay+0x920a/0xd300
   ntfs_loadlog_and_replay+0x3ef/0x510
   ntfs_fill_super+0x1d23/0x4550

  The buggy address belongs to the object at ffff888002423000
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 600 bytes inside of
   allocated 1024-byte region [ffff888002423000, ffff888002423400)

KASAN reports the source side because __asan_memmove()
(mm/kasan/shadow.c:94) validates src before dest and returns without
copying.  Both ends are out of bounds, and on a kernel built without
KASAN the copy is performed.

rec->used is also left at used - asize by fslog.c:3323 before the memmove,
so the record stays inconsistent even when the copy is suppressed; the same
mount goes on to report "ino=1a, mi_enum_attr" and marks the volume dirty.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Hyeontae Lee <wonju345@naver.com>
---
 fs/ntfs3/fslog.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index f038c799e7ac..f415785c60f9 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3314,10 +3314,21 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		break;
 
 	case DeleteAttribute:
-		asize = le32_to_cpu(attr->size);
 		used = le32_to_cpu(rec->used);
 
-		if (!check_if_attr(rec, lrh))
+		/*
+		 * check_if_attr() accepts a record_off that points at the
+		 * ATTR_END marker, which is how CreateAttribute appends.  The
+		 * bytes there are not an attribute and check_attr() never
+		 * validated them, so refuse an offset that cannot hold a
+		 * resident header before reading attr->size, and then bound it
+		 * as mi_remove_attr() does.
+		 */
+		if (!check_if_attr(rec, lrh) || roff + SIZEOF_RESIDENT > used)
+			goto dirty_vol;
+
+		asize = le32_to_cpu(attr->size);
+		if (asize > used - roff)
 			goto dirty_vol;
 
 		rec->used = cpu_to_le32(used - asize);
-- 
2.43.0

