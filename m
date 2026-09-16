Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49648BD54;
	Wed, 16 Sep 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549828; cv=none; b=j081OIGOcfnBcfh0GpvfY64byboGO4poDAd37byVwEP6y4kpq1Ifm2HNot5AYn8OTAW37mTx1WIlMa2A9nIIj8MLBSc4xJXkOnDkR7MJ7HWV7k6NhdYzHz4tNEtvbQk9607ENy56w2ll3vQUQr8ZFpyLBkWO8Mrjmi/Uu2ci8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549828; c=relaxed/simple;
	bh=AEqSX65qBK51YRCjzACTfTXXqKYV8OXz+2tbKUCGkPs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IiDKyoyaihmkFWbcg1Kwxo0mCRnSLEQn4iRMsskrOX4HvfNWGo95pYBUrJ0w5DUf3gZdh2bayG+p+W9ofkPRI4ZLDkGNVvn+UV2P4yCLejRaIvCkI6rP0mrcdOADM4oTLXCF3BS1SeO0U05tvTu58hkT949HPcHi6vDHMCbFxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=saa+zYdO; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="saa+zYdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1789549801; bh=aJ2RoaVrTR5lScqJ6fDtJfwi0fg4FnGoIrHJd1m6gsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=saa+zYdOqn2vAfEPLskj8giuvnVq/3WactJ2bwt2rtAaJ92dBdkJbUAUlLKV4oIk9
	 Kc2P8sCURuuqmeXC8cxL6wAH2n2jBorbWc49s93Z0xp9ZK+ubwSDTQerM2IunwVb63
	 ma0o0jfpHeixRSMfmfXqQjgonUJQW98zztamj92g=
Received: from WIN-U8J9BGQPJ22 ([61.136.26.125])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 277B8E5A; Wed, 16 Sep 2026 17:09:55 +0800
X-QQ-mid: xmsmtpt1789549798ts0pxda6l
Message-ID: <tencent_6BAAD177CBC8B253A2297594808F7D546606@qq.com>
X-QQ-XMAILINFO: Ne0X32Z2O2BRPTa9PytJI71zJiFWkCoc+o02MwZhDmVH0c3wqBG5GK/XpRvZLO
	 uVl9f/zxFqogwBdALUaKhNMLG1r8qO+IloMA+n/8iecW+ggbeLM5ltNPmlY8reX4+g2xWw/arILW
	 UDkiOULB2BvS/Otf1o1eRNUhTNK0a6MzkSa3lO5muQrZaBiMQYlWthRj1mJAtvtbPFf6eii8zWZQ
	 jcbnZPikeHzbcng1UuRN9koP+4llgI0ClWZupSk5EaP1Rw2HAl6JuLyCuv6a+iQ/FXMBaDZRDWdA
	 N6GKf7f6XUuy4zKuMNvyln8lyXxDc0k7jF0V1xFfhJAoNcUU85+Q1V/E4+yj7d5Wkv5RQMyFlV7F
	 PNCt8YkLD007l9xgFFkwbtvK+PMM/S8GN364ilajl2H2uAUI+7Rl0/xE2XJitNRCUBCjZ7vlOCQY
	 LPwI0/8R2tXixQQD+ztIFWUTe4HFZqXKdLpwkmWYf4/uyoQHfR8UbOVVNaXSUmq+cjSEtq01L45/
	 TwxIylFqsYLA390rQP8bwhwXDPIrAcLKHR2wKemT+1GxuM9tL5XDY6ok9M+dMsXyTCT0SxHuwoY0
	 nUYAYJJLTxEEIibdKcahJPm0TSwdxSFyfeJt8mi0ZRUONXD4IztJSpeAOBe51j90K9hpG88CGDIY
	 fm3qjSXuyTO7f/q/X44YQm7oDSu0FYrKhxOVGkz2UioIqBHpfQyVEeldxVnaCoWoWwGeez0/l0ST
	 HviiDRtnftrkPQeitkpcxH1DLcVg5FHbGkFzOCKhwjwNqxqBt9r8nYAI7ZBMujLmoEKPQjvNdXBa
	 UDTyKVLD6p/NLdthu6DROQpxHu/gXl3KjH2RU1nQsi8J2S/0Pt30nbLGULYbp7NEnF99ZPAYzTVq
	 fjI0OYuhpe6a6vpdRwPp4kTl3us8dxCRaIqjmYgTXDM6fM1EghPC1l5H4UACeUXY0fr3KcKHSs6t
	 ZmAoIX+VWB70mJ9Qu03hTe4Z/kNMx9JS66jFP3dcsV98l444S1R1n5Qf4AykYazQ7E4J3JQW/noE
	 ZNDYjkt7pD1qC8O/UBz4gXPryrF9+hgfk6RlNi83xgEFtk70+2VlOekhfyy5Qv4baCjHMvLfzZKZ
	 Rd7g8DEZ7reBQQCNSLYShDZPtQ9Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: 1sh1ro <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: 1sh1ro <yangguikun19@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] hfs: don't let internal B-tree inodes leak into the VFS open path
Date: Wed, 16 Sep 2026 17:09:54 +0800
X-OQ-MSGID: <20260916080000.1-hfs-fix@localhost>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260916080000.0-hfs-fix@localhost>
References: <20260916080000.0-hfs-fix@localhost>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_btree_open() creates the extents and catalog B-tree inodes with
iget_locked() and never assigns them a file type, so both stay cached
with i_mode == 0 after mount.

A crafted HFS image whose catalog contains a record whose DirID/FlNum
aliases HFS_EXT_CNID (3) or HFS_CAT_CNID (4) makes hfs_lookup() ->
hfs_iget() -> iget5_locked() return that already-cached internal inode
(hfs_test_inode() only compares i_ino), without running
hfs_read_inode().  The typeless inode then reaches the generic open
path and, with CONFIG_DEBUG_VFS=y, deterministically panics:

  VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)): inode:... fs:hfs mode:0 opflags:0xc flags:0x0 state:0x0 count:2
  ------------[ cut here ]------------
  kernel BUG at fs/namei.c:4271!
  RIP: 0010:may_open+0x2ba/0x480 fs/namei.c:4271
  Call Trace:
   do_open fs/namei.c:4698 [inline]
   path_openat+0x1600/0x3de0 fs/namei.c:4863
   __x64_sys_openat+0x13f/0x1f0 fs/open.c:1385

Fix it in two steps:

 - give the B-tree inodes an S_IFREG type in hfs_btree_open(), so the
   "every cached inode has a valid S_IFMT type" VFS invariant holds
   regardless of what is on disk;

 - refuse, in hfs_iget(), catalog records that address the reserved
   B-tree CNIDs so a malformed image cannot alias internal objects
   into dentries at all.  Returning NULL follows the existing
   convention for unaddressable records: hfs_fill_super() turns it
   into a mount failure and hfs_lookup() into -EACCES.

Without CONFIG_DEBUG_VFS the assertion compiles away and the same
crafted image silently makes a typeless inode openable, so this is not
merely a debug-config nuisance.

Found by syzkaller-style fuzzing of v7.2-rc7; still reproducible on
current mainline.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: 1sh1ro <yangguikun19@qq.com>
---
 fs/hfs/btree.c | 8 ++++++++
 fs/hfs/inode.c | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2eb37a2f64e8..bd69ace8f309 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -43,6 +43,14 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
    if (!tree->inode)
       goto free_tree;
    BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
+
+   /* B-tree inodes are internal objects that must never be exposed
+    * through directory entries.  Give them a REG type so the VFS
+    * invariant "every cached inode has a valid S_IFMT type" holds even
+    * when a corrupted image contains catalog records aliasing these
+    * reserved CNIDs.
+    */
+   tree->inode->i_mode = S_IFREG;
    {
    struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
    HFS_I(tree->inode)->flags = 0;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ac4a9055c5c0..bb759345f1fc 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -432,6 +432,17 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
    default:
       return NULL;
    }
+
+   /* Refuse catalog records that address the internal B-tree objects:
+    * a crafted image can otherwise make hfs_lookup() return the cached
+    * typeless B-tree inode, which then reaches may_open() with
+    * i_mode == 0 and trips VFS_BUG_ON_INODE() there.  NULL follows the
+    * existing convention for unaddressable records (mount failure /
+    * -EACCES).
+    */
+   if (cnid == HFS_EXT_CNID || cnid == HFS_CAT_CNID)
+      return NULL;
+
    inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
    if (inode && (inode_state_read_once(inode) & I_NEW))
       unlock_new_inode(inode);
--
2.39.5

