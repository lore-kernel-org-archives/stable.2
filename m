Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294B1FF7C8
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338445; cv=none; b=MuCFrAL4hGS7yQG9hUDVJwq2w45E/f6qgdNmMzXLKdr140P00eBNCUs3WRAOw0XyoQKQ+ZUIKycz/scDOXbUdIbaa/bg3t1yUdfIvr7Pe8zSj2zU5eAvu8ZuaRsDLft2lsXYZ5tyV/3CDynsSdKCqCIh+ltc9vCI3SlF70BFZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338445; c=relaxed/simple;
	bh=K5czpE7kY/a9YYyg52rH4qBcZtAkxysmB/QNw3KdKAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr9oGmtPkJrOkuSITgt0M48OSSLZVnX+mvaMVRNEvoh94q762k1cj/wAfaT0qrTNeZJYDOwtcsdJiYcQt5iRWFzduMgqhptL8ClYLXa05dWuqXFxsc+qVxzqxhlY+m6LUbOR8qlzo39v7L4/r5B9+/afMhWLbRRPBW4rMMVLaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvaJTIZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvaJTIZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF9B1F00A3A;
	Sat, 18 Jul 2026 01:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338444;
	bh=pAlk+pqXYkocEvmeF7J6H9QlwE7XdLUSU/Jqhg34UL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvaJTIZpMBhUOkuGb2MOn4joifuPxPUxW1vuMEiAGgij5Rd86c56PwuAAtKFvaNbP
	 Xm8rMhoW3SzY3BWpr3cS4efz0l+5UM9z0sTJEzyw9DOR8Bbnu2gcZzKKy4M3nRS79t
	 S4S+Ad0qKYIvcoTHw5jUy968WOXy7kSz3tElHgv44YwUYVoolYXdmDsaWzeLDIlkWZ
	 L8I34gfEh+bCDhnrt4WLOSIjz2XmkhkU5n+g8fGO11Jzl+7sF0K6VlyO6IBa6aW3Wf
	 erUaf+q4PIpjxsm9J1jEhBzsEhBWa7v7KLO/+32axyaDQntI5j5bDCvyZ3g5929msl
	 N0g9uwMidm7OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com,
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Fri, 17 Jul 2026 21:34:00 -0400
Message-ID: <20260718013400.2623033-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718013400.2623033-1-sashal@kernel.org>
References: <2026071426-streak-landmark-fd09@gregkh>
 <20260718013400.2623033-1-sashal@kernel.org>
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
index 46eac4b4800563..0e45973be3df10 100644
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

