Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407249;
	b=Zg/oPeVGzmlU/vJNeBgwEQ0VfUisEIH3Vx5c4H6VZazQxc5KXvtsHa3Jjv9uDjlAC8iH
	 62El6gkG62mjo1LyNOU5FoT5n0rh8ClTU41kiPnsjWJCVyaa5ETKAMEt1k+8L68cftLzJ
	 z8yGt5wSTozXNV9b9LCKsgT3rBkFKQlvJ8nSRJrL4Qrziusgbkv34DXahcUyZ8PNe367O
	 k/O64w0Pug0IAknEqz4x59R1UvLPahhB2X7wDC14Gm77D3Annrh6pq6AKhypiea9piM6m
	 vREVpXdNMCfFTECDrXeHcped8OiHL1hHF/Nd4cNmvRfG2vPcLOwIi+8NATi/zHSjSAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3OGTdXiIou4duAOiYRGaqPVE8IlT7RdpQ/1NVN9kpWc=;
	b=WJtQgyTqOrQBbs/NulRpBBzxX8mlpCm3LeoGPDMlSpLfTj5jevtxccB7rOrrkoPVnBtM
	 ZpqNzbJa9D0LMxbwQlveRVJvNnztJ+uHbBOQ8/blwnyH0SpOZHqtHJUFDm8fcANSJgZu1
	 M95nu0Yeaz9IWOrIEHIQHacjdRFkLsSARLgTw1rExxcHiFT58lbQH0G3qghQz2lXMT3KW
	 AeJ2tWIb2K73e2ZUdhbiVAjh7NZtf8R9TNRXfFH+cLsjVMG1Xp9d9G9kZfQFhAaQSD3ZF
	 nVXvsepBj4La9e95LRUJmct5Zrn7X/L0lLCZKVpCjEUU3cANOC7fXHQMulsFYGfnvXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzDs+Ah8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8B606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzDs+Ah8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDD81F00A05;
	Wed, 11 Nov 2026 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407249;
	bh=3OGTdXiIou4duAOiYRGaqPVE8IlT7RdpQ/1NVN9kpWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AzDs+Ah8w+nBngcdwqQjyhxabxR3z5M0EK5RZtTX07iUQpwTyVG/K5eJzPi7eHVUX
	 Ui1pKZx/nae6bAy3qbCJVtEieEY6gzkyNv9qmk7y7btwSWQzQl3o0S2bxCp/JuKs42
	 Izfv2y1U0uHoO3bExtu2BhiUMcJmNBt5VIzNPYI7qGyyMote1AQ5q9dvyEAD2tQr5I
	 Ks4LcaSqKDMSoX4GMi+CGaOaS1QRUqJMHdQfLwzyEt2yx8trVhzPAqhDhjWFPxafOL
	 j7gnLT7BVgtMZCnUMvuMPHYlmdn8QT0gKr3A4KxOCIL72f/XNUcxErG9kbLAG013cr
	 QHUaBolyp4SKg==
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
Subject: [PATCH 6.1.y 1/2] ocfs2: fix oob in __ocfs2_find_path
Date: Wed, 11 Nov 2026 09:27:25 -0500
Message-ID: <20261111142707.2335918-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054844-failed-6.1-6193ce7896af@kernel.org>
References: <20261107054844-failed-6.1-6193ce7896af@kernel.org>
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
index b8b9f8c7d2893..e5d446d78e817 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1804,14 +1804,15 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
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

