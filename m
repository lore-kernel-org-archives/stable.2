Received: from cvsmtppost04.nm.naver.com (cvsmtppost04.nm.naver.com [114.111.35.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4503AD527
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507135; cv=none; b=dSmeGlH61BrGbmj2YoG2sUyhRjjMN/Wku7mPZlpd5S+3AtmITGUyQk0BLgvQ9iH/qAz8nFWl8SdvOVQbhKBpdOvD+nVSycmBP3PxTnlFfgzOvsoJY5srVmyi/dSJDWF6TgXuwfem9QK6dmZcwAmUUxD+6ak84Hsix/8i7pEPVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507135; c=relaxed/simple;
	bh=a7eSvM2JHbOvQCUTR4TaiBdpKKZS4wqzFVkZje62WEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvud3KBMf1vQ43jOKdCF0IXnL2XxdLv/kfgCCMqjSr0KAa02JeRw+4GJLR7yU41xb1nEBblNpP95OKinzU1qRicoU2z+AVIMU+DutC1Ji0QL6LArTGSwdU+KeuwxIGuOOzuxtKqNxtuaVUEAX6AMPNXs9MYNvQzgwNGMtirNDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=lHI1WCfK; arc=none smtp.client-ip=114.111.35.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="lHI1WCfK"
Received: from cvsendbo034.nm ([10.112.20.50])
  by cvsmtppost04.nm.naver.com with ESMTP id HNZBWrqNQNe4jAndgFQEjA
  for <stable@vger.kernel.org>;
  Fri, 31 Jul 2026 14:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1785507121; bh=a7eSvM2JHbOvQCUTR4TaiBdpKKZS4wqzFVkZje62WEI=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=lHI1WCfKSLqM9UoFddueqO1hW/0tDs4QraEzg1yaktWjJYiH5dEeXsDGWqTqS0vkw
	 nH+I7X+f+hKFQW+W8l/ARn1g6llyPRZboub8t8a4MbHYlulOVEuK9c7JTf+zrn6hV9
	 XyvDuB1hMQl6veBoJIHk+Cel6zQ02U4xL1HAPYSsvhbwc3vpOkyOfqoNLK11z3A8M7
	 jVpSpiJl/pDutwFORAMOU/Ceuo7+vMcGiYGLV4bHQx8eVellot6WJbml7SBfJ4qwn8
	 iKjKrEC30E4+iOwIxWqGFD4Sl2GD/MaHEZ7jYyIzWfeF8nFr+g0rDL3okZFUvspMso
	 efQ7W4YVdn4CQ==
X-Session-ID: s1LCs-8YQzCidKm9lgWXTg
X-Works-Send-Opt: rlF8W4eXjHwYKBm9FAF9KBmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: gZnXFAE/FqJZ+HmwKobd+6E=
Received: from localhost.localdomain ([211.41.193.194])
  by cvnsmtp005.nm.naver.com with ESMTP id s1LCs-8YQzCidKm9lgWXTg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Fri, 31 Jul 2026 14:12:01 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: wonju345@naver.com
Cc: stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: bound CreateAttribute asize against record_size in do_action
Date: Fri, 31 Jul 2026 23:11:58 +0900
Message-ID: <20260731141158.52129-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_action()'s CreateAttribute case (fslog.c:3286), attr2 points into
the on-disk log record and asize = le32_to_cpu(attr2->size) is therefore
attacker-controlled on mount.  The guard bounds asize only against the
log record itself,

	Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len)

where rec_len is the client data length, and separately bounds dlen
against the MFT record.  Nothing bounds asize against record_size, but
all three writes that follow are into rec, a kmalloc(sbi->record_size)
buffer allocated by mi_init() (record.c:105):

	memmove(Add2Ptr(attr, asize), attr, used - roff);
	memcpy(attr, attr2, asize);
	rec->used = cpu_to_le32(used + asize);

With record_size 0x400, roff 0x38, used 0x160 and asize 0x800 the memcpy
writes 2048 bytes at rec + 0x38, 0x438 bytes past the allocation, and
rec->used is left at 0x960.  dlen is 0x18 here, so the existing
dlen check passes: dlen bounds nothing about the size of the copy.

The equivalent non-replay path already refuses this.  mi_insert_attr()
performs the same insert and starts with (record.c:488):

	if (used + asize > sbi->record_size)
		return NULL;

Apply the same bound, spelled as a subtraction to match the neighbouring
clause.  used <= record_size holds here because check_file_record()
validates it (fslog.c:2826) and is called on this record at fslog.c:3172;
roff <= used - 4 follows from check_if_attr() together with the ATTR_END
check at fslog.c:2844, so bounding used + asize bounds both copies.

The sibling WriteEndOfFileRecordSegment case does the equivalent check
against record_size at fslog.c:3277.

Reproduced by mounting a crafted image on v7.2-rc5 under KASAN:

  BUG: KASAN: slab-out-of-bounds in do_action.isra.0+0x41f6/0x83a0
  Write of size 2048 at addr ffff888005c74838 by task mount/69

  CPU: 0 UID: 0 PID: 69 Comm: mount Not tainted 7.2.0-rc5-00300-g8ba098e6b6ff #2
  Call Trace:
   kasan_report+0xce/0x100
   kasan_check_range+0x105/0x1b0
   __asan_memcpy+0x3c/0x60
   do_action.isra.0+0x41f6/0x83a0
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

  Allocated by task 69:
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_noprof+0x1b4/0x460
   mi_init+0x81/0x110
   mi_get+0x6a/0x220
   do_action.isra.0+0x1db4/0x83a0
   log_replay+0x920a/0xd300
   ntfs_loadlog_and_replay+0x3ef/0x510
   ntfs_fill_super+0x1d23/0x4550

  The buggy address belongs to the object at ffff888005c74800
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 56 bytes inside of
   allocated 1024-byte region [ffff888005c74800, ffff888005c74c00)

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Hyeontae Lee <wonju345@naver.com>
---
 fs/ntfs3/fslog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index f038c799e7ac..2230a4a77872 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3288,10 +3288,15 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		asize = le32_to_cpu(attr2->size);
 		used = le32_to_cpu(rec->used);
 
+		/*
+		 * attr2->size is taken from the log record and is bounded only
+		 * by the log record length, not by the MFT record.  Refuse an
+		 * attribute that does not fit, as mi_insert_attr() does.
+		 */
 		if (!check_if_attr(rec, lrh) || dlen < SIZEOF_RESIDENT ||
 		    !IS_ALIGNED(asize, 8) ||
 		    Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len) ||
-		    dlen > record_size - used) {
+		    dlen > record_size - used || asize > record_size - used) {
 			goto dirty_vol;
 		}
 
-- 
2.43.0

