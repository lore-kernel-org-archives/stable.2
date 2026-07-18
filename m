Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAB30DD2A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375073; cv=none; b=i9fVV4qbZqpuR4cWpenmv8I1SwvQjwpGyoao1MSzDlZkrgUpvPQSJZmGOJ4mf1jtrGe803kTxLq6g+E/cc7lDF1KOikkyITen5zHbVj+OxWFEKAlVK8QjlGp8MHMPkIv4gnvlmsWmVkFPwnmw5nNQAk2JNZxMUnz1eSndezfNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375073; c=relaxed/simple;
	bh=v035PCJN4zBJz8sKaiLrP0wJENqHHQjtccPbKGh/mhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki5IXu9MQmUW0s1weFmlokSd2yUs9SEpEN38nXkANBAxP9Orq+OPCjeZq3lSMrnjd7kXl+YsFW/RtuNAGMHfUrevH5nuJS+PILsCR7OdHJ1tnq3GoEQ4M/BrzVxz5v31CxvSuHT8vZqCfTYokTNpstXGgQNf405TWcqyrJuEmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJjtLnDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJjtLnDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3AE1F00A3A;
	Sat, 18 Jul 2026 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784375072;
	bh=EgY3HP9LZfjjrPWv+fAk9but1qFkJgvN+mhTSvd4inY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJjtLnDGfKjiRCLQyrT3uwKSJHmE+DxJFP6FsNETvrwfSOeba1lRT2w0FfQR6xwP5
	 lUzOXxnCLf2gBNFmWd+QRcnhhYKX0O2LdODnSeJM2dazAdF4Mt/B7FdP3P7TKpS/Vi
	 ph+31qrBB7yLItcpzu82QMzM2bG21I8VfZsKKJH77CsCnGfT7dW/JoOuIgB+7dSqSx
	 4ytlVG/+LKrHDlQKTdFUu+cYA2gwpQSOW+bcuSgxveiK51e5wOgsJkXFZxZoQ2GKSb
	 jRL7Y5MWeea0xz/tFgmRANHyZ4CjZpMfCW/EtAhyNW6ocQ7zRWTD25diaOuOiJlYAc
	 oTIRlgU5UQvSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com,
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Sat, 18 Jul 2026 07:44:27 -0400
Message-ID: <20260718114427.3045393-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718114427.3045393-1-sashal@kernel.org>
References: <2026071427-alike-singing-16b5@gregkh>
 <20260718114427.3045393-1-sashal@kernel.org>
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
index 1f72af8ec2aa87..8d988ca0ea8b28 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index b3cb05deff3ad2..ef8c087098853c 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -611,7 +611,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
-- 
2.53.0

