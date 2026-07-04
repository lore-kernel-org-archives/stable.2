Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229E433E7A
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783146838; cv=none; b=Wix7SbH4LFgPvaIlV39ovTu3Aa+KcXEhzOlGqSAzL4P/H7hk/itXLVSHvgSyGu62ND/8LszRk3pLVM5uiZFsYXml61BUmBguFL07xGnPukE1lWMKxAd+WqQO7kC275L7KI06aK3vMUFVh9QQnj2vycYs7oh9YGlpHXXezCILH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783146838; c=relaxed/simple;
	bh=0WY4lujUoW+8t9RPZRyrWC9DAATMKinYMCIbcmBY9IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fR5LyziX1crkyZ6J+3XZ1kG4XpOhUNx/vjOUrmgIFe1s55pbFtdJCJ371QLAdtL0qOttfc8ghqkeHdJ6urRMpAe/qWlKmjp9bJ8GG4chp6t0czkDwrclAwbopWXC45YUR0ChbrFc5QKPEmnK3ibqyI83kQqFkO1CIFlLUNXhd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNNgzQT5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNNgzQT5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so10427375e9.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783146836; x=1783751636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+wFC810afrczCAEG00O7cfnbSsokPgX0e3PuC6Ayj8=;
        b=ZNNgzQT57KXHd2R4QHca8vvMEZjlXpAh1LOtDN8bIt+tVYWO600YsYbqLI7XBI6BcE
         0ER1dTUCD5be4jOwUHJhFgzq1lo/V3uG/geHGbIFMbrMS62lXfGCjUQy/HO4at0dGAj6
         rMswwTqKBsiXLuL32byl6L9mWxMJbfgWHHQd0Nf0yn2maFyew2e47Izirz/3vyIe1RBd
         Myr2bOiXAl2yLLwb5i3Qr3GOacKz3FGN4jO6dL9fX02BzwywmwzCqN0FXQ+1/l3eTJGo
         cwaRilu3pe8+knFXqLeKbviVE74Qu01aO23coggw7xEdznM3ej4Ssa1KNkNIDJAUgkzA
         sEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783146836; x=1783751636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+wFC810afrczCAEG00O7cfnbSsokPgX0e3PuC6Ayj8=;
        b=I7dz8MffYHg38CRIpqsLR7R/nkfi9DV2J3fM26XMWf0d9Sj0onJvmQxtjH3iIpls28
         ldqIS+QUnPm3CJXvZeRMfuBRmPTSkHDOycdBR3mm+wMdANFUopXh/iJohfIespM7ozRe
         DDA9BkJ63pqWzFYRICLdrSUfA9T0VePyLi9yzUddX7nReQ7eIZa3GVrRYEIKEV403CRa
         UOnA4Yzmb7SdpAqfWMHo7Nw5n4QWTqttfa1SrzdgVy8PzosKnG9hwUQJrN/j3w5ZFxHP
         vmUd3S3d36q9A2j8WtHO6jMkETKIt0SOtdDZor+aG0HNNKxQtGg2fHA4N1Bvm82utGVb
         MSlw==
X-Gm-Message-State: AOJu0Yxqgyv2HlGaPanpOEzEBm6264ahYcpVocdG4Fofk2XZgQZl5yzA
	5pVF2B7qaYtASDSzhFdgHB6BK9fDOsMOzoj9Q75157MEJ5d9PmFT8nYBF6QJSHxs
X-Gm-Gg: AfdE7clIigqAtIuAVLAXH7ywAl/H9Yux9rm+TNiAtEs7PH8OQHrLzNeDlWIqX+Vzcg1
	u3GMBqfp0Fn7WqFwaxiGp2oSvQtxPff/UKLgJybvuRbB05iJ4moEitKumS9opa2JQay/OCqdOuC
	hEHZ2YHJT80PzoK7+6+8DYxreQAIlgjqyia5zMLGdEWCoAcyWojuUmLAqpTuvB5QygJjqWIpmbv
	xTeLnSHLBqrdckBnl3zqCPy+8ekPZGQidZRH90ijOm5IXuuruxv9k9nRBRCCBHbvmugfpy5dAJH
	sEHybtvBQBq6zaos9Y6hoqVHRjnkdK7QgnmK6SAkiTOs9ikn1Bb27WM+yBo/p2aj3VRcLqNMc61
	dICj4p4bRy2WC8krXJXw3Gw+skZovOQVQ0eoIU1dUqPsQJIizgmX1UA/fIBrLOlk3BK3mu/S2r6
	lV65pwi5MfFCmn8Ru3txHhOmN5fhOHrRC/5sA=
X-Received: by 2002:a05:600c:3e18:b0:493:ad8a:e7fd with SMTP id 5b1f17b1804b1-493d11d7fd6mr21700165e9.14.1783146835652;
        Fri, 03 Jul 2026 23:33:55 -0700 (PDT)
Received: from localhost ([109.110.46.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm5031735f8f.34.2026.07.03.23.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:33:55 -0700 (PDT)
From: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>
To: yashnikov.valeriy@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ntfs: avoid calling post_write_mst_fixup() for invalid index_block
Date: Sat,  4 Jul 2026 16:35:46 +1000
Message-ID: <20260704063546.419578-1-yashnikov.valeriy@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_icx_ib_sync_write() calls post_write_mst_fixup() when ntfs_ib_write()
returns an error, intending to restore the buffer after a failed write.

However, ntfs_ib_write() returns an error immediately if
pre_write_mst_fixup() validation fails. The caller,
ntfs_icx_ib_sync_write(), interprets any error as a write failure
requiring rollback. It does not differentiate between I/O errors and
validation failures, and calls post_write_mst_fixup() anyway.

Since post_write_mst_fixup() assumes that the index_block contents is
correct, it doesn't perform the boundary checks, which results in
out-of-bounds memory access.

An attacker can craft a malicious NTFS image with:
  - large index_block.usa_ofs offset, pointing outside the ntfs_record
  - index_block.usa_count = 0, causing integer underflow
  - or index_block.usa_count larger than actual number of sectors in the
    ntfs_record, causing out-of-bounds access

KASAN reports describing the memory corruption:
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x19c/0x1d0
  Read of size 2 at addr ffff8881586c9018 by task p/9428
  Call Trace:
   <TASK>
   dump_stack_lvl+0x100/0x190
   print_report+0x139/0x4ad
   ? post_write_mst_fixup+0x19c/0x1d0
   ? __virt_addr_valid+0x262/0x500
   ? post_write_mst_fixup+0x19c/0x1d0
   kasan_report+0xe4/0x1d0
   ? post_write_mst_fixup+0x19c/0x1d0
   post_write_mst_fixup+0x19c/0x1d0
   ntfs_icx_ib_sync_write+0x179/0x220
   ntfs_inode_sync_filename+0x83d/0x1080
   __ntfs_write_inode+0x1049/0x1480
   ntfs_file_fsync+0x131/0x9b0
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x1aa/0x1d0
  Write of size 2 at addr ffff8881586c91fe by task p/9428
  Call Trace:
   <TASK>
   dump_stack_lvl+0x100/0x190
   print_report+0x139/0x4ad
   ? post_write_mst_fixup+0x1aa/0x1d0
   ? __virt_addr_valid+0x262/0x500
   ? post_write_mst_fixup+0x1aa/0x1d0
   kasan_report+0xe4/0x1d0
   ? post_write_mst_fixup+0x1aa/0x1d0
   post_write_mst_fixup+0x1aa/0x1d0
   ntfs_icx_ib_sync_write+0x179/0x220
   ntfs_inode_sync_filename+0x83d/0x1080
   __ntfs_write_inode+0x1049/0x1480
   ntfs_file_fsync+0x131/0x9b0
  ==================================================================

Let's move the post_write_mst_fixup() call to ntfs_ib_write().
The ntfs_ib_write() function calls pre_write_mst_fixup() at the beginning.
If the index_block contents is invalid, pre_write_mst_fixup() fails and
ntfs_ib_write() returns early without calling post_write_mst_fixup() on
bad index_block.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Cc: stable@vger.kernel.org
Signed-off-by: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>
---
 fs/ntfs/index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index c5f2cf75b750..faa7ee920a3a 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -110,6 +110,10 @@ static int ntfs_ib_write(struct ntfs_index_context *icx, struct index_block *ib)
 	ret = ntfs_inode_attr_pwrite(VFS_I(icx->ia_ni),
 			ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
 			(u8 *)ib, icx->sync_write);
+
+	/* Perform data restoration before returning */
+	post_write_mst_fixup((struct ntfs_record *)ib);
+
 	if (ret != icx->block_size) {
 		ntfs_debug("Failed to write index block %lld, inode %llu",
 				vcn, (unsigned long long)icx->idx_ni->mft_no);
@@ -147,7 +151,6 @@ int ntfs_icx_ib_sync_write(struct ntfs_index_context *icx)
 		icx->ib = NULL;
 		icx->ib_dirty = false;
 	} else {
-		post_write_mst_fixup((struct ntfs_record *)icx->ib);
 		icx->sync_write = false;
 	}
 
-- 
2.54.0

