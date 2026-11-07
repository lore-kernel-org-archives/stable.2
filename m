Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047112;
	b=EbEBSe5uHafQtD5gTDfRtd2aiFpYgUlm8RJbT9juHDIBalbudj92gLY9NnEgSeMP5U8E
	 CSM4t1QIl5Fd31djZS8mNnxWwKq1HJMbUEjlFe2xgYrIbA8IecP6VEHLGxpDOdmzn49BQ
	 //qcm6tEvzjdSPCCD5Idqc2uS5T7CYf0IA6WT+W5HHzD5bnIwZgPAW9Ivz7555Qf8zREF
	 Tmy9WjOuwQE/wvqj2D3FaOg23t5J2qdLZ/FgnXSicWoEgnGtSH00YIB2nHeOL8Ke0LEDn
	 1zoE7lI4NkjcppMM3SkRP5btYnV273ilYOQ9dGhZMjPlZCp2ogoQ0UCIaUHtO+K3Bvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i+bPh3tZnZLmK6BzqTr+483Uxt7U8dxJqnJFm3NXQU0=;
	b=5tAMvjYQhx5dVcEiLWPO1vHZR40O++V3R6vfg3WykVKFhQyk6w5GMw0l3wl7s/owB7Rm
	 PpBwNLHlTb9qk4HNTpb0oxE3E+dXaVtriPsG6w6ZWDZB6gzxu63PCmQJxvvB8Zpz113rm
	 UvlvclfND5+LMKCpBxtcwaGFkd8xQuPEC8YLy17t2ZEL8FibdQ+ZReeWcBDPx5wqOV+/Y
	 PFeLiO3XpeqbPkTx5sAn2dnonvX9XJH8fVooudH/kVPdWnz+3pEkIGrYiNHP8XLpKball
	 11d8Emp20svD/J7lm9FSh+2NxL5MB48vFwEJWXbH0hUK44vX42XfFbsYXBF9/LdA1Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOwAshV0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF347606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOwAshV0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED10C1F0089F;
	Sat,  7 Nov 2026 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047111;
	bh=i+bPh3tZnZLmK6BzqTr+483Uxt7U8dxJqnJFm3NXQU0=;
	h=From:To:Cc:Subject:Date;
	b=GOwAshV0t3vZ8MG63CEU/nD+HZBNh9XUGNFRaxubebIcEnVdu09bf8abXoXnko0vS
	 u6FzA6UFjwVdfXhWKT3ZkMqy+RtroHelMJI7M1TrF4qmZCuJDc8fjJfy9e+SUnz8JG
	 yOUNbcZqZgBCYV/rtqUiIttdt26+ibZkvogh59cfS1GeHHTvNMOl8gNMe4kGmIZd1x
	 +c7n6uwhn8H+FTUra8rWFwOhRrYrPiR2Gk1OWxhwciZ4WM3HXHA+fUbRotbPrJLHML
	 mOMEhSI8hddXj9+mw6wzcuePTJKkSFrJK5+vQoxANCFZ3fTyRq54du9zHPl1bkwPH5
	 83k/wjsvNzvjg==
From: Sasha Levin <sashal@kernel.org>
To: chizhiling@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] exfat: advance valid_size to EOF for append writes" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:09 -0500
Message-ID: <20261107052509-failed-6.12-b70ab4075037@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b70ab407503706289163dd59f1ac3e942bacc37d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052509-failed-6.12-b70ab4075037@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b70ab407503706289163dd59f1ac3e942bacc37d Mon Sep 17 00:00:00 2001
From: Chi Zhiling <chizhiling@kylinos.cn>
Date: Sun, 4 Oct 2026 18:19:30 +0800
Subject: [PATCH] exfat: advance valid_size to EOF for append writes

For an append write, the write position is recalculated by
generic_write_checks(). Therefore, the write position must be obtained
after generic_write_checks() returns.

Using the original write position to advance valid_size may cause the
valid_size update to be skipped, potentially exposing stale data.

Also move the truncate_pagecache() check below the recalculated
position, so that pos is never read before it is assigned.

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
Cc: stable@vger.kernel.org
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 3867e78c23125..87afb6bffd353 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -854,8 +854,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t pos = iocb->ki_pos;
-	loff_t valid_size;
+	loff_t pos, valid_size;
 	int err;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
@@ -863,11 +862,6 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_lock(inode);
 
-	if (pos > i_size_read(inode))
-		truncate_pagecache(inode, i_size_read(inode));
-
-	valid_size = ei->valid_size;
-
 	ret = generic_write_checks(iocb, iter);
 	if (ret <= 0)
 		goto unlock;
@@ -878,6 +872,11 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto unlock;
 	}
 
+	pos = iocb->ki_pos;
+	if (pos > i_size_read(inode))
+		truncate_pagecache(inode, i_size_read(inode));
+
+	valid_size = ei->valid_size;
 	if (pos > valid_size) {
 		ret = exfat_extend_valid_size(inode, pos);
 		if (ret < 0 && ret != -ENOSPC) {
@@ -887,6 +886,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 		if (ret < 0)
 			goto unlock;
+
+		pos = valid_size;
 	}
 
 	if (iocb->ki_flags & IOCB_DIRECT)
@@ -899,9 +900,6 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_unlock(inode);
 
-	if (pos > valid_size)
-		pos = valid_size;
-
 	if (iocb->ki_pos > pos) {
 		ssize_t err = generic_write_sync(iocb, iocb->ki_pos - pos);
 
-- 
2.53.0




