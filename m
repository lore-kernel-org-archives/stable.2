Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E118FDDE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176737; cv=none; b=nTsC5ctsvOJe4yir2Z852BvVH3hIpp9Fvi7IHDIs4UHAAKRkF+EAntgwjzkkKAUvlIQg/06OEknTNfZVg5Lh7c4AYPY/YoTwIjVUeQQ1BrsEyZ1slO2Z99I9FzVK3zgoivtDe3+rkOIIppkFD+ea3PSesfj/d8od1PHlhCpgWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176737; c=relaxed/simple;
	bh=5rz9YEDGoZZ8lkDe8nkk3TqZKCFd9o/mUfo2gkV/22I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtGCwWC6S/Ob4PObSdjQnLuk9wuHVL4Fc9fY3NnuIrUwZtk220BjNUBmFuR3Ae3DIhdUbMZ4JIKcF+VH+96gAlRp8pU93aoenSBBQYXZRmGINgP+991BFFMoz+qo1DhQSuzmeUnhfGM9UsF9/EkhjKLR/adNfP9k4T0IjmmIF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJUh1w9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJUh1w9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F35E1F0089A;
	Sat, 12 Sep 2026 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176736;
	bh=dHuTVlL8hV0EqKyCEL0f3RncnE3GspKmX3RQvCqhhWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJUh1w9bwWxW5kPUFzvdyE7UU/AMq7GX1Z4RJb8Kq1KLV8gzSilVZkm1OK3o9z9uM
	 naDRSsu0KFgicVvReqAQwELv6ez84WIvN6ore2TXisTna1nr8SLeX2poST0Zxz0vCl
	 45q31rKbossUJuBAlBP1FTwwcCvwTEgxhCnKwJPeKkjGOnyZeDNBPIPzfF4DAWBf7y
	 G1Qz3nWRKrJWe8uU5oKoQoTS2HCO1oW6ljBH0S+/R0sajNNDyJgPIlAPAD/9nUwy7W
	 7NMkGVoOAkUgNZrTYwQnCWvM+wR8Ebj1SeTAmH6uTmFNGr9QmKiQTE+cjkFLmtpSot
	 VRK3mVXgrv+og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wenjie Qi <qwjhust@gmail.com>,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] f2fs: avoid NULL checkpoint thread access in sysfs
Date: Fri, 11 Sep 2026 21:32:11 -0400
Message-ID: <20260912013211.1760018-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013211.1760018-1-sashal@kernel.org>
References: <2026090930-ricotta-unpledged-5906@gregkh>
 <20260912013211.1760018-1-sashal@kernel.org>
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
index a83e17636c054..f5d1faec2210b 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -471,7 +471,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 
 		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, level);
-		if (test_opt(sbi, MERGE_CHECKPOINT)) {
+		if (cprc->f2fs_issue_ckpt) {
 			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
 					cprc->ckpt_thread_ioprio);
 			if (ret)
@@ -703,13 +703,14 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
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

