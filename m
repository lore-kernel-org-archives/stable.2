Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A936B076
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318120; cv=none; b=AaW9fDrE92cpL1d1aJCdUB4IO8tzkf0wnv3qEIZMRZTKLURWT9zw5c1+LSq1wp3FGHEeY+sgxZmFQ5qUVyHbfzD2oHf2UKsjG3ftTZsZy8/3u/zphV4HHL48C2QuKeOuUPJjf3LHQhMpXLJKLhAL0Z/rXPDWv9WfV45QS9Vo8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318120; c=relaxed/simple;
	bh=38rB7DNzfVWvpRWRpFiS09jTlq6aoYQ09M47cAqZR9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNApoahKBsl8CnwEwMKZ+zbnLBf3UYnQGC1owgM0S6/+tq6tvbGnKWzk2W9ex6rcBjY3g5rYvOMnaIoRz3I+h8a5PHLwxba7oEITcss42gdrTaZFPjyyREYz5zrnoOhfr087k3v4AB+CgVnJM74joqTryHV34xRwunKIJnbgkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOJXU7TU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOJXU7TU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEB51F00A3A;
	Fri, 17 Jul 2026 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784318119;
	bh=QYm5iruYgoHs3V8TKuxg1QcPFhu4oyMa+7Vo/jPq72s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EOJXU7TUYtZzqeqz1C/e3v7SqBFiO6VPLR5+zsCu2yA5WFJoH/7Iaic5Y0ATpfbkH
	 64bSAOTXNNiZucTNd1pWBRBSO8Tu7BoxUpQAoHhT7rxHg+kJ7RBTDxtqDsg1tZKXrG
	 z7K4KMlRh3X+Q5tcCAxmQwUxpmDJEYolO2dEGDoJsgWi6Uo4sX2wy91CPteXTQdgAc
	 KL1hsDpydzrE2XupM/25ptRCyGvIK6eC6ia0emKF05mdubGYLp7ZezV6LMM5dUrick
	 fbyXBYCC5pBgSecKuf/s1emIwljwkWJI/tR8laHpVYZbM5U7joEYzcCrYAK1XIJ8wr
	 GPEvojVtBbI0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com,
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Fri, 17 Jul 2026 15:55:16 -0400
Message-ID: <20260717195516.2194907-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717195516.2194907-1-sashal@kernel.org>
References: <2026071426-subplot-sinister-60df@gregkh>
 <20260717195516.2194907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit 966cb76fb2857a4242cab6ea2ea17acf818a3da7 ]

check_and_correct_requested_length() compares (off + len) against
node_size using u32 arithmetic.  When the caller passes a large len
value (e.g. from an underflowed subtraction in hfs_brec_remove()),
off + len can wrap past 2^32 and produce a small result, causing the
bounds check to pass when it should fail.

For example, with off=14 and len=0xFFFFFFF2 (underflowed from
data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
which is less than a typical node_size of 512, so the check passes and
the subsequent memmove reads ~4GB past the node buffer.

Fix this by widening the addition to u64 before comparing against
node_size.  This prevents the u32 wrap while keeping the logic
straightforward.

Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e76bf3d19b85350571ac
Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20260505111300.3592757-2-tristmd@gmail.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/bnode.c          | 2 +-
 fs/hfsplus/hfsplus_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46bf..9571f33b910857 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index d2cc0f9f3d513d..2da2bd52d200ec 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -585,7 +585,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
-- 
2.53.0

