Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240133EB17
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177429; cv=none; b=RarVLcWbpI20+h0FMuvxbxoWicVFH5Xe6fE8LQEU9HYII+YouKNM/1Wn9u20pCEXZhOwRm5eSaLWARmlqfs1ArODvAC/y7u8vYXccbzQh7DDFCsm2Z5XnuJbKVs2vZhh96n3vO+E9XKTf7hW1saOP1vlCKJJT5rkRdrMfZ1E8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177429; c=relaxed/simple;
	bh=sJCNHL+SC8yGY9JTnFgz7omkAyT5GFdfutTbo9+HmL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/vAk+bhtv/WS3KxZqLIv3Z43EJAnnBppmAuMt5BuMKMcp8Q3Cu9ewJQb3II2A70cg+TwW5vTzB5diRD2JSaVLpQZD6c+v0gQbaK3bkktIe206XJkwpJYp3tTVZ8JaUyG6DKcAUIAEHqC7WtLkIvQ6ESBepSLsc/R28BGoHzAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5MvKEeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5MvKEeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AB51F000FF;
	Sat, 12 Sep 2026 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789177427;
	bh=whkw78rhNFDIxIwH45WTF9eotvigCAZ4TIOv+eXD7QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5MvKEeFnXBy0OPz9VMNx1t5U1mQPoioiCrhX/WfcBFX4h6HGp+T2FXb7PbdbSXIf
	 Qp4Ihsa7frZSCuKg/1ZcY1JZIyY78bkfmJ5ABHeDV4mxTIFwDJnZmtomosUy6n1JfM
	 Go7SL2GkQDLOlBNgb7J/bWfBqAk9SmFbzxrUaACCiwx+az5gbjG1+WyZHtm0vO3w4v
	 CHPjQ/BCKsqvFhWlk5P4zlm7A4aonVK/DGFD8DqzjUD9ouoo9D0Q59vA5iIJcgGMTM
	 iPsP5KA4tqaeq+B7xoh8ZlAjz98gNXAeUCTDFKjftu2yA1lgOTdKFPukWqq0E7F+zx
	 ZehOKWNFEdkqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] f2fs: avoid NULL checkpoint thread access in sysfs
Date: Fri, 11 Sep 2026 21:43:43 -0400
Message-ID: <20260912014343.1817848-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912014343.1817848-1-sashal@kernel.org>
References: <2026090930-appease-drainpipe-8027@gregkh>
 <20260912014343.1817848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenjie Qi <qwjhust@gmail.com>

[ Upstream commit 5cb33b00c8fbb6e8f1fa3d281c3036d5f7c7c41f ]

checkpoint_merge can be enabled even when no checkpoint merge thread is
running. A read-only mount is one case: f2fs does not start
f2fs_issue_ckpt there, but ckpt_thread_ioprio is still writable through
sysfs.

The ckpt_thread_ioprio store path updates the saved ioprio value and,
when checkpoint_merge is enabled, calls set_task_ioprio() for the
checkpoint thread. If cprc->f2fs_issue_ckpt is NULL, that dereferences a
NULL task pointer.

Protect ckpt_thread_ioprio sysfs writes with s_umount as well, so the
checkpoint thread cannot disappear under the store path while updating
its ioprio.

Fixes: e65920661708 ("f2fs: add ckpt_thread_ioprio sysfs node")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index cd969ba2eda57..16cd5155f3434 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -427,7 +427,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
-		if (test_opt(sbi, MERGE_CHECKPOINT)) {
+		if (cprc->f2fs_issue_ckpt) {
 			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
 					cprc->ckpt_thread_ioprio);
 			if (ret)
@@ -607,13 +607,14 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	ssize_t ret;
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
+	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio");
 
-	if (gc_entry) {
+	if (gc_entry || thread_entry) {
 		if (!down_read_trylock(&sbi->sb->s_umount))
 			return -EAGAIN;
 	}
 	ret = __sbi_store(a, sbi, buf, count);
-	if (gc_entry)
+	if (gc_entry || thread_entry)
 		up_read(&sbi->sb->s_umount);
 
 	return ret;
-- 
2.53.0

