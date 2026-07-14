Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326D2931D7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066178; cv=none; b=Cu8n4E8r5ugF7KD2j6YSQ6mH7xJFfOzt3GXiWXYpk3QALAnsZIsvoBQ5bFzPvaZXGh1pX3et8ZwIQdgkBXux6BobUge99c5VxLX4hb1LTsGhPLbe6X2WrNA8AIaCy2DdbKyhdr7BfG1Uhwnhlyl4gFEJoHsQlHK6JsgcPLhdLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066178; c=relaxed/simple;
	bh=/AfF9I8r9L88QBqEXJ+knjHCrOUZXwHF9Mjcs14h22w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYKwLtfUStQ4+gGGXreIkwJScgC5ABDL0/de5ogA4fP7SqeowkwfcowM58Q8qa2P5iQ6Qw3QTh+KdIfaC+76J3khO5Vp7sHJ5y33ge/53qzoikp3astJoli8k48RFx5QWG0zsQUkNuxhCHelm3l5WBf1q8mHjb1Q7L/g3c3hOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=DREa4cm1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="DREa4cm1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ce98cb8165so15007585ad.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784066177; x=1784670977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a3bMWS4b6GGm8PZgGzkoAOMcuJeTSNNgmOihDM66PlI=;
        b=DREa4cm1m9Ylo7pKIQDsuRve4bsUFOEFus+ELhJDsYeTdBv4ZmbfoFXRBZntrl0Sff
         oRKEmy3QGgnHQangciwzBVKJEi2lKt0raXk3YAvj2hfzG2NnCwO26KGdMiTQvaPr0WHN
         Wl1TGVZGSyBpkc7XcZlKDCQbzEa1kpT9dKWJ1Hemcp32RnmRZXRTKGlVMvmICJwjJ8F2
         e3TC/E87pg5MrDKBrZSs9wsf/pWZtf6mOvoReIJvM2WO4y3Jg+XrxfXV1KZOyqUc8mpU
         J2pgaVRDfNLZwUY68Ogm0U3xsXQWYGqIGu6ycGM9cJ+hymr0oJixMJ+UlrF6ZbHK5YS3
         c2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784066177; x=1784670977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3bMWS4b6GGm8PZgGzkoAOMcuJeTSNNgmOihDM66PlI=;
        b=n+tsnJOBtBtqz0GQH5Xz7I9VS4kpUBptAUiTuU0gA1REQCiKcc2pmFmfyEheO60NdU
         sIB+5q7MfTadjSsWfqLIGY/lmIBXb7Byh5kDyvVkVT6Ja9XJtuCWs9YV5el627y35eqb
         i1opCMtbgDtD9ZnKijS1FMKccycID0gBi1LgPge7+XmJABbJYsDSm72XefCnBzRazf/h
         UmEqYdy8RO+gLgcSM45kf/SpnGd3P7eojx8TdcmXWS4wGCmb/bGvfXsfc5hacsTAOykY
         3faZgW+Fl8nUr7hDG2dANX5CY5oNhVPVBoa6LkIbdGGCTBabzMpiRRrVnjsWAOO94YWh
         rdPA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8n2syFAHKgaldqaGgyD6OI69aEDLzqpBMGX/bR2CJHp3HQF8QhYBB963t7OnjLZceLBm+1po=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIbfhgHL/vD4q8oklBRK23oYlMkz2/9k6UTMKX2g6Xxf8Qqcr
	0EXMwuVf69T5mxxqbrBKfQgvsF+AZ1BtLgSy0ugvysmjQoPHfyVFvI1iq7QKd1XelFPn46h3Q0A
	nQutsYg==
X-Gm-Gg: AfdE7cm1Jy8wnnxCE8RLBT84AuUt6OouRuO+H7xcEa94ai/xCLxmbKFSq29Z18y3Eve
	ThSvwFkQYstJtaj8dEFQI86BmakWf7EJ+Q7FRTmlHbEx64fzcb0hX+W9xNMzLvR4jZle3zXu/J2
	UUXoOljv0XX2P71HnsNll6f4SSpk8oIU/3kCOyRqcOXCQHycQYsH6B5SO2xAZfTas/lh6SmZqQp
	vgM5ybpIIej+2XrzbaIU4/QzbCV4FgPVcjbB8d2+rI8+JyldarGERTiYXNnstq5VFtQ1ZPdeBp/
	OUMiZVz9M65WoDVhrNzaIl3ygDyJJHjP17rdQTNEoHUWlqXjY25NEgAX7stv/+Z/0GyyF6TS8y0
	2TPKhU5vAndOAO+iLW2wWf9PJtq2P0sn6WhTmfLi57+VciBCJfAwqQxpXpfOCOr3PNPb2uMPI8y
	hCMWYfqB4=
X-Received: by 2002:a17:903:298e:b0:2c9:97a7:3283 with SMTP id d9443c01a7336-2cea187c0d0mr144303245ad.23.1784066176736;
        Tue, 14 Jul 2026 14:56:16 -0700 (PDT)
Received: from p1.. ([2607:fb91:153f:24b:150b:bb6f:1d25:f03e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf77e4sm122119835ad.22.2026.07.14.14.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:56:16 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] xfs: fix off-by-one in rtrefcount btree root level validation
Date: Tue, 14 Jul 2026 14:56:12 -0700
Message-ID: <20260714215612.1528518-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_rtrefcountbt_compute_maxlevels() sets

	mp->m_rtrefc_maxlevels = min(d_maxlevels, r_maxlevels) + 1;

where the trailing "+ 1" already accounts for the inode-root level, so the
deepest valid on-disk root level is m_rtrefc_maxlevels - 1 and a cursor must
satisfy bc_nlevels <= bc_maxlevels (= m_rtrefc_maxlevels).

The two on-disk validation paths, xfs_rtrefcountbt_verify() and
xfs_iformat_rtrefcount(), check the root level with ">" instead of ">=", so a
crafted rtreflink (metadir + realtime + reflink) image whose
/rtgroups/N.refcount inode has bb_level == m_rtrefc_maxlevels is accepted on
mount. xfs_rtrefcountbt_init_cursor() then sets bc_nlevels = bb_level + 1,
exceeding bc_maxlevels by one. Since the xfs_rtrefcountbt_cur slab object is
sized for exactly bc_maxlevels entries, the first btree op on such a cursor
indexes bc_levels[m_rtrefc_maxlevels] past the end of the object. This is
reached by the first rtrefcount cursor built after mount, via log/CoW
recovery (xfs_reflink_recover_cow() during xfs_mountfs()) or an
FS_IOC_GETFSMAP over the realtime device.

Reject a root level equal to m_rtrefc_maxlevels, matching the ">=" form
already used by the sibling data-device refcount/rmap verifiers and the
in-memory rtrmap verifier.

  BUG: KASAN: slab-out-of-bounds in xfs_btree_lookup (fs/xfs/libxfs/xfs_btree.c:2101)
  Write of size 2 at addr ffff888018391658 by task exploit/144
   xfs_btree_lookup (fs/xfs/libxfs/xfs_btree.c:2101)
   xfs_btree_query_range (fs/xfs/libxfs/xfs_btree.c:5308)
   xfs_refcount_recover_cow_leftovers (fs/xfs/libxfs/xfs_refcount.c:2113)
   xfs_reflink_recover_cow (fs/xfs/xfs_reflink.c:1085)
   xlog_recover_finish (fs/xfs/xfs_log_recover.c:3551)
   xfs_mountfs (fs/xfs/xfs_mount.c:1158)
   xfs_fs_fill_super (fs/xfs/xfs_super.c:1940)
   get_tree_bdev_flags (fs/super.c:1634)
   vfs_get_tree (fs/super.c:1694)
   path_mount (fs/namespace.c:4161)
   __x64_sys_mount (fs/namespace.c:4367)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  The buggy address belongs to the cache xfs_rtrefcountbt_cur of size 216
  The buggy address is located 8 bytes to the right of
   allocated 216-byte region [ffff888018391578, ffff888018391650)
  Kernel panic - not syncing: Fatal exception

Cc: <stable@vger.kernel.org> # v6.14
Fixes: 9abe03a0e4f978 ("xfs: introduce realtime refcount btree ondisk definitions")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_rtrefcount_btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rtrefcount_btree.c b/fs/xfs/libxfs/xfs_rtrefcount_btree.c
index f27b80a199ba..22acc1411aac 100644
--- a/fs/xfs/libxfs/xfs_rtrefcount_btree.c
+++ b/fs/xfs/libxfs/xfs_rtrefcount_btree.c
@@ -201,7 +201,7 @@ xfs_rtrefcountbt_verify(
 	if (fa)
 		return fa;
 	level = be16_to_cpu(block->bb_level);
-	if (level > mp->m_rtrefc_maxlevels)
+	if (level >= mp->m_rtrefc_maxlevels)
 		return __this_address;
 
 	return xfs_btree_fsblock_verify(bp, mp->m_rtrefc_mxr[level != 0]);
@@ -651,7 +651,7 @@ xfs_iformat_rtrefcount(
 	numrecs = be16_to_cpu(dfp->bb_numrecs);
 	level = be16_to_cpu(dfp->bb_level);
 
-	if (level > mp->m_rtrefc_maxlevels ||
+	if (level >= mp->m_rtrefc_maxlevels ||
 	    xfs_rtrefcount_droot_space_calc(level, numrecs) > dsize) {
 		xfs_inode_mark_sick(ip, XFS_SICK_INO_CORE);
 		return -EFSCORRUPTED;
-- 
2.43.0

