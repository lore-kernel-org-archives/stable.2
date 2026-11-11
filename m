Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408296;
	b=cnkwKVk37qFe13O5LiYCAx2J7D+Rps3xx+hkk/UiWwmRHDM0GE/vM1+Yhqo7ZnJZttE6
	 zx3HPM0Gc+dEDtILP4l/4aDhmg9sEk0gpdP348mMISQYJeexTCw3nMYSR8/fT1tbl86/a
	 7KB6gWvlIRyAol9RKW4wTxeHzZnan/HtFi2oYGYUwno48O6QEO8plmZVFzqFzjo3VSxWk
	 1BGcNvh1jOcv3I77ZDMEVgGSHH1rhOwe+igh+6BvAIKPmmzWjU41cKkUTWAEJssXA/fJr
	 EM8jxzSNfVU6XLIel5uyW9Kjb3kmXzB3DRmmsR9A1aP2O7rt5GbcBBFspR+3C7+emhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408296;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4ezMSxxG5nZosououoqVf0wC8Vcik3fvZGrvqV8dLHo=;
	b=xb293SsC8pEPxvH1gsbZTiPguXw/PgBmtUMLcoIfF7L6HPoaA4n/BlCLo7fC6iLQV/O6
	 KpF4t4c47KXWffaxCVJBIr5eJV2nd2364jGRuagAqYljMm6W0eswX9tTcAJRT5plwyUaM
	 SADrri5OjbiY4L5nRmBllaXMQeapYjc8LldPVUALLxiYmnrRR/MNxRHtPQ7U4Mzwk+kfX
	 iGAOetiuMenz2MVBm4ONu5NdGDCRYIl8egZMQtBMK+TBfIUfbp//QMa98/MXBlhWNCLid
	 YxQF86qNpfmtellg8w8Sh1whLjhlslZsNSRtRYvfPLt1Rht8ZgxnZJTQ4G9+2WR44GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fh7qZ/z5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016D606A88E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fh7qZ/z5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7879E1F00A05;
	Wed, 11 Nov 2026 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408296;
	bh=4ezMSxxG5nZosououoqVf0wC8Vcik3fvZGrvqV8dLHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fh7qZ/z5MhE6AbmCQSNVo7WXfgvg14pdH9smJLIKZ22o/Aro2eY1NzyclChBhq4tY
	 oluIs02WhStZrXHqkjhJoI9jAHn1LQWCxMRf6YmTTwCEvKR3ROqr2N0XQ9UsE3K05R
	 p6HnoriDj/K00SaO5irI0nGcOgP5alO8SD7ER5rs5uDy/jS99UelNX+DPz1nRBH1Na
	 1e9NeIt7uVwsuuxggG+fRSL4oTV9luWspqFJ1TdGx3NW9VZS2Te49T4dxxxjiuDoex
	 ck7TNlONigXxdxnA9ibKYuONK5jnSWobdxwbyPwc/g/xhgzq38/MebWfKafEs+4xn7
	 lBdlHaKEg76fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+151afab124dfbc5f15e6@syzkaller.appspotmail.com,
	Heming Zhao <heming.zhao@suse.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ocfs2: fix oob in __ocfs2_find_path
Date: Wed, 11 Nov 2026 09:44:51 -0500
Message-ID: <20261111144420.2422486-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062251-failed-5.10-6193ce7896af@kernel.org>
References: <20261107062251-failed-5.10-6193ce7896af@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit e0b0f2834c9bec51b1068de5cf5e10c7519143eb ]

syzbot constructed a corrupted image, which resulted in el->l_count from
the b-tree extent block being 0.  Since the length of the l_recs array
depends on l_count, reading its member e_blkno triggered the out-of-bounds
access reported by syzbot in [1].

The loop terminates when l_count is 0, similar to when next_free is 0.

[1]
UBSAN: array-index-out-of-bounds in fs/ocfs2/alloc.c:1838:11
index 0 is out of range for type 'struct ocfs2_extent_rec[] __counted_by(l_count)' (aka 'struct ocfs2_extent_rec[]')
Call Trace:
 __ocfs2_find_path+0x606/0xa40 fs/ocfs2/alloc.c:1838
 ocfs2_find_leaf+0xab/0x1c0 fs/ocfs2/alloc.c:1946
 ocfs2_get_clusters_nocache+0x172/0xc60 fs/ocfs2/extent_map.c:418
 ocfs2_get_clusters+0x505/0xa70 fs/ocfs2/extent_map.c:631
 ocfs2_extent_map_get_blocks+0x202/0x6a0 fs/ocfs2/extent_map.c:678
 ocfs2_read_virt_blocks+0x286/0x930 fs/ocfs2/extent_map.c:1001
 ocfs2_read_dir_block fs/ocfs2/dir.c:521 [inline]
 ocfs2_find_entry_el fs/ocfs2/dir.c:728 [inline]
 ocfs2_find_entry+0x3e4/0x2090 fs/ocfs2/dir.c:1120
 ocfs2_find_files_on_disk+0xdf/0x310 fs/ocfs2/dir.c:2023
 ocfs2_lookup_ino_from_name+0x52/0x100 fs/ocfs2/dir.c:2045
 _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:136 [inline]
 ocfs2_get_system_file_inode+0x326/0x770 fs/ocfs2/sysfile.c:112
 ocfs2_init_global_system_inodes+0x319/0x660 fs/ocfs2/super.c:461
 ocfs2_initialize_super fs/ocfs2/super.c:2196 [inline]
 ocfs2_fill_super+0x4432/0x65b0 fs/ocfs2/super.c:993
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2a0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]

Link: https://lkml.kernel.org/r/tencent_4D99464FA28D9225BE0DBA923F5DF6DD8C07@qq.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reported-by: syzbot+151afab124dfbc5f15e6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=151afab124dfbc5f15e6
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6193ce7896af ("ocfs2: fix array out of bound access in __ocfs2_find_path()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/alloc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index a1c50a44961a6..f7c80cf1f1efd 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1806,14 +1806,15 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 			ret = -EROFS;
 			goto out;
 		}
-		if (le16_to_cpu(el->l_next_free_rec) == 0) {
+		if (!el->l_next_free_rec || !el->l_count) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
-				    "Owner %llu has empty extent list at depth %u\n",
+				    "Owner %llu has empty extent list at depth %u\n"
+				    "(next free=%u count=%u)\n",
 				    (unsigned long long)ocfs2_metadata_cache_owner(ci),
-				    le16_to_cpu(el->l_tree_depth));
+				    le16_to_cpu(el->l_tree_depth),
+				    le16_to_cpu(el->l_next_free_rec), le16_to_cpu(el->l_count));
 			ret = -EROFS;
 			goto out;
-
 		}
 
 		for(i = 0; i < le16_to_cpu(el->l_next_free_rec) - 1; i++) {
-- 
2.53.0

