Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594734AB1D
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387581; cv=none; b=Lfh6eVZJ/SKw7BsxPh0/rPZj9NC3skJpsz3MeQ0mZwLofPc25in6zXhQnWpKakY7XXcZLFQl+2Mw3EkTltmaipPhQFgpCUh1kL9JZwAbWbmTE6qzSdSRSblcGruaaeG/QdR9uARQ1o1O03ewadmXPc7LeREsaa1j0QwMZAg7eoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387581; c=relaxed/simple;
	bh=BmZHq/q/AY+nLPLSmAU8Nf21wqRKYeLAqFMSWQQxdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krvWcj5L/L7JMoB9znugoSRWZknEzRgWB1LklLO+i9ySI9Cp1D8u7pOOxgK8cnpyVmCmQZa5eB2N0hXQyyS/uQpX+J4M6nCNfeMcXDXkgyEwV/cuNX6vWred5+R140rq01mfXMS506vUlohu+9TRj6ehMe5mvD+RPBC6c8IuEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ/ypf5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ/ypf5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F170B1F00A3A;
	Sat, 18 Jul 2026 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784387579;
	bh=qvzSfO/56QwknoMmAE071CNmdl8K+43xptK7l9bb7lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJ/ypf5PcGXDvEL0xoTY3Qgh3b160gBW2RKGjruihivnyqeMyDt/9Qjjo9P///bF3
	 KbjfFLVUinc/Y+oEVFoepngFjPJxY5NAeaVYVBxSHZBX+CVAfFtQ2v4oTmpcZL0vsk
	 IQJ79citausy8ZbOXSJe86/1haY2+HYzTQ19lb3QBsulKFBWKioNlfunsxAjEES9sN
	 5dwFh4wabY2Zws/ECFD3jq6pkDr9df3XKPt1hLI+c2Q+X0pKKmiiiQcX3ZQt6JfTi3
	 JCEt0/Yz0rhpiyYflhopSugwzu2MC9IwR7J5jlg/4LqmFLlkIng+TCJ4Pg2hpPGYbb
	 z9ijNLx3GQA1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com,
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Sat, 18 Jul 2026 11:12:56 -0400
Message-ID: <20260718151256.3269669-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718151256.3269669-1-sashal@kernel.org>
References: <2026071428-shoplift-askew-e8dc@gregkh>
 <20260718151256.3269669-1-sashal@kernel.org>
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
index 52e5eb80b46f13..ffc72d9d892aff 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -614,7 +614,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if ((u64)off + len > node_size) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
-- 
2.53.0

