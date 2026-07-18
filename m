Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF872459E5
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784373643; cv=none; b=m9+CgjJyZPLlb/l9c6qiIein3EvPtWu2aW7Y1acT8/6sYqYO8q1XjEi8PCOJS66dNbBxjvOeWDXM2lStys6L2+CEp8SnOFjapLEuIaPzYCV0YXHn8VlqakGKSUDkVSfZUGgz1iwMSoD2tfn5uzzscPr3k7OBz2xfqhIQLRegj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784373643; c=relaxed/simple;
	bh=0VN9isK8DI1e2ktcvk/8xYEvUtyn1GsSXjWHl+QUQL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHyLySy6i2uQbGg1wi3YXiD558FLIcWw1B1Q8JAn3pqreRumRkrtaps7u7V7fAAiR8DNrlX6PRjo/iYV3u+ZdR0WiLB0d2wQRNgPeS/aStdRJb3Sd74Ph+2muFa1NcwYye2HJFfMZ3j8N1AuTyICqe12oqfANs9ZZ7aJ5PF4454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMsvWtYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMsvWtYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C141F00A3A;
	Sat, 18 Jul 2026 11:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784373642;
	bh=+Bf3FaHIep44bk9Cb9r3gs2PQH4iZmVBFQk0xj0DTLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMsvWtYi+DukVjtcTtou35iyOIzagMKNFX1wPCgqdGXQ1MIppTTB2+QzLi7d2QU6S
	 oS47+ef0J14BcmenXyC5cuY4nOCs8/DMnxjIFxiHBdVtrrmF3N61wxi/Pw+uk+POiO
	 uiddWfdi+MjtxxV7XK8xzdeXLNxygCZvCglZjmQucOsK/d4c2PNUbg5i1RTLe/C053
	 y2UzzxbS+E2CtT2a+rDbYSEq6d4Eq6PYgOs3TRFN2G1mw0mPBufdTNs9e5hMGwnorN
	 j9ssJJFwSE8cTw4NijujpzZZIFnt68IXPpvQIda+/ygrRA+qSSjuH9f79vc3u2mrGC
	 pNOBHwz8WqZbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com,
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Sat, 18 Jul 2026 07:20:38 -0400
Message-ID: <20260718112038.2956632-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718112038.2956632-1-sashal@kernel.org>
References: <2026071427-party-pantry-0a68@gregkh>
 <20260718112038.2956632-1-sashal@kernel.org>
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
index e239bcef8b1f49..2de2790315c87d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 06d6354001fe52..005f9648e1d973 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -613,7 +613,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
-- 
2.53.0

