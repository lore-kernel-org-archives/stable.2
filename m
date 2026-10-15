Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38763B2D18
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033059; cv=none; b=tdCzGgxagBUKn2Wtpcf25a5GaCva6gVXDDTIzZO4mxRZgcBvDYvCliifa7tN+eTQvhEU0aR29gf2GWNA9f5NOnh8lNKSttheH7FR6FA6B5mUdSnnhgzOtSYu18I4lAtDUiGDHI08hqSzVohLIyNc56BJ3YgAUgcr6vN8x7Vcq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033059; c=relaxed/simple;
	bh=sZniqozc4w8922ObuoQPVNbXGED/+im3bzoyWHB/MwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3Glh9x61C29pGNxjceG2erenwFNIAaOAGlo9yCGaSaeY0GZBoLsvGcKL0V9lRj+ybS+U8ZajuVs65JY60rovvEamxa2CDxASbmEE9TE1XbyLW7tAeHSQgmogOKDZbA35iCb4MmMkryle6YQ+8uJGYNcJ7JNvNNpfVBBRCknfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf63Rz2z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf63Rz2z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2dd76b1361dso11269295ad.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792033058; x=1792637858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IsDm/3n5TTGtnRMOmw6WlAZLpwcXANG4w05bJxvvhdo=;
        b=Gf63Rz2zsCglLz82wyN2e+QTp+6erLtQluCoRxfdjC+mtDmFRTW6LEpO5L4hyqGFGH
         Bc6b+5gZQW2QityinyBydsDKkYD3cxemoZjHvyTTzJsJ4q+ueSsFLpCXtxLHTnZKvyLW
         VUo/TKhbiTYDf4dXlHGRgwV/cYKWsDdxW7IblIneOmdvVLSyTQOgEwWpfv0kat/jyM/Q
         5BBkIE7eOU7YH0gbvWEHALv5Tf4d2kZkZ0vC/QEpcCJRHP3gWThrR2jFSMr2jJjJgbxG
         YDNcH/ooklT+VzhoR6N9wZsODJYBevtR2+yjUrTqkIWPU4crtMpggATnVOl+kL3hau3y
         EIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792033058; x=1792637858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IsDm/3n5TTGtnRMOmw6WlAZLpwcXANG4w05bJxvvhdo=;
        b=Lfu2JdWQANIqcSLOV5Nv00Z+Si9SNUaAiciSobuD4vsPFMH+CFHkdgoBZkU9IUNvhG
         rV2DYEFuqSFKU5BA2LGdEOhUaXgQ5kPMGtolkmGq96xLngZy5aX9YeLs3EBMaymF0Q0e
         jTFY33+7rN0S5ORsrEdZ2/i8uroqPdZmkDxqeeLQzRj+9HnX++1Aws5m9/zG4mIPuLGV
         cr+Am+68dVT12/wszs0ZHcS2e78u8k4+clgXOXoe66qsLZMpDmFxeLdTJ3TzJLko7fXX
         IgokiEbjZnKall0BW/XF7vIW055q8GGUazT+SPlvRGxQjfvqT3+JuLOqIfeVdKIYBqwv
         +2Rw==
X-Forwarded-Encrypted: i=1; AKwUvBzbMbP93JKQSlpljdfi//9b4wIbqnXqhL4WvHx4gYvn+qKJHTnDSlfzBee67TMIv/nMk/8UUHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdXZFGC4PaypOS9FIIf4ttpRZj5j3AMyJy1PiDrey7FaknBVI4
	HYfMd5wCUbttuwqFJGuS7T+9xnt38K1RotzAaSYnmbLH75DY2OnJ3En/
X-Gm-Gg: AYBFou17uw9ZVGMIQjUpNvK3NgbuX/uiZWAa9PJOmNhP4rEyRB0Wqp/tFBhLVennluI
	EddLwjx69RvbBTzEHIQ8/T3a8UIvR+yhZJAqxsPJtak+BwJn+RY8OvC1x94gS7tcjKkbhyI/SYT
	Ul1smikvLfStbtzC/piuSZjHz2iKUssQN22EZE24HpUkRsu/ghe41EPVc9AdzLwkgYVQncvSNJ1
	jiUQLVmcMKhKNKx7FqBlb++jnTHDoVxAhBEQ/ZiDq4V7lH8XKn9qrJ2SlaaE99V/A0WfRwTdvuw
	s7Ee4DMaEdNm/uE4zi3PabE0n19MOde8RWREyXvcxaXD0hBSxLLZxco/lNoQctHL7rI7hbZuaJ/
	3Kdl4oFo2Xh9qvoNBU32gVWyFpEW3IhfBRdIuM939zJwDOBFZyUlziGTBMEjC4uTu1L+f1xROXr
	cj7ND1b3GDvHXwE3s8ed3xNXYXZDYoWdvlQglYJKuBhUMa4NBukBaQWGfGzZb80tIc22EYC6C0n
	EUjJR23u9AZ4zZAeh2+mAtR+Bi9kYsm/e5GCOqRZtxFRRms+K+1pltlrKauNrpigOYuw0JbrFPE
	9ItdEl+CCsmNVac=
X-Received: by 2002:a17:903:32c2:b0:2e6:23e5:4938 with SMTP id d9443c01a7336-2e842bc54bemr163564685ad.22.1792033057837;
        Wed, 14 Oct 2026 19:57:37 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4eb2sm76539465ad.74.2026.10.14.19.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:57:37 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: release a removed xattr node in roll-forward recovery
Date: Thu, 15 Oct 2026 02:57:31 +0000
Message-ID: <20261015025732.1564032-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

When xattrs shrink enough to fit in the inline xattr area,
write_all_xattrs() truncates the xattr node and clears i_xattr_nid. If
the file is then fsynced without a checkpoint, only the inode block is
written, with i_xattr_nid of 0.

Roll-forward recovery starts from the checkpointed inode, whose
i_xattr_nid still points to the old xattr node.
f2fs_recover_inline_xattr() copies only the inline xattr area, and
f2fs_update_inode() writes the old i_xattr_nid back. So the inode keeps
the stale xattr node:

 - The node block is never released, and fsck reports "nonzero bytes in
   xattr space after end of list".
 - If the inline xattr list ends exactly at the end of the inline area,
   its terminator is read from the stale node, and the removed xattrs
   come back after recovery.

When the fsynced inode has no xattr node but the checkpointed one has,
release the old xattr node as truncate_node() does: check its block
address, invalidate the block and drop its node cache, which may still
be dirty.

Fixes: 28cdce0459cc ("f2fs: recover inline xattr data in roll-forward process")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
Changes in v2:
 - Drop the cached xattr node, which may still be dirty, as
   truncate_node() does (Chao Yu).
 - Check the block address of the old xattr node before releasing it.
---
 fs/f2fs/node.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 55008f18afd..13f977ca6d4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2831,6 +2831,43 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 	f2fs_cache_wait_writeback(ientry);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
+	/*
+	 * The xattr node of the checkpoint was removed before fsync, e.g. the
+	 * xattrs became small enough to fit inline. Release it as well, or
+	 * the inode keeps pointing to the stale xattrs.
+	 */
+	if (!ri->i_xattr_nid && F2FS_I(inode)->i_xattr_nid) {
+		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		struct node_info ni;
+		int err;
+
+		err = f2fs_get_node_info(sbi, F2FS_I(inode)->i_xattr_nid,
+								&ni, false);
+		if (err) {
+			f2fs_put_cache(ientry, true);
+			return err;
+		}
+
+		if (ni.blk_addr != NEW_ADDR &&
+		    !f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
+					   DATA_GENERIC_ENHANCE)) {
+			f2fs_err_ratelimited(sbi,
+				"nat entry is corrupted, run fsck to fix it, ino:%u, nid:%u, blkaddr:%u",
+				ni.ino, ni.nid, ni.blk_addr);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INCONSISTENT_NAT);
+			f2fs_put_cache(ientry, true);
+			return -EFSCORRUPTED;
+		}
+
+		f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
+		dec_valid_node_count(sbi, inode, false);
+		set_node_addr(sbi, &ni, NULL_ADDR, false);
+		/* drop the cached xattr node, which may be dirty */
+		f2fs_truncate_node_caches(sbi, ni.nid, 1);
+		f2fs_i_xnid_write(inode, 0);
+	}
+
 	f2fs_update_inode(inode, ientry);
 	f2fs_put_cache(ientry, true);
 	return 0;
-- 
2.56.0.385.gd3acb90ef8-goog

