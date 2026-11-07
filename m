Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046407;
	b=IyUA2C4b0KenoNrbdTseqGeKbmFe5yBuF8oF05InerklMiSo6k5rSSwCicwZPBx3lK46
	 HIV2W3GZFqLeb7IQqDfIsg92Y5F6Z3KMC5LL2GizxmrWVx0xwLdniYT9kXIMlNgrRKE7E
	 VbQ331dtzuHKgQNLlFcjrhWjLl18zbz7VEoNcen2j551aMDFuwEtwW0NyONl6kj2AwYmk
	 r4pR9mhkJzDZmTkuFlvsIU0LvHaGclRIU3YaVeEyvSJoXMi46WYSPjVWeVoA5Br4I+9Wc
	 pPS0J0NGNuFaN1HFvHGAbbZYx86dURrZHKipRF8c/OdYGowfkpUb7WGAJm+YGLO0JGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046407;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pItlQUG/DO1uKcg055sOHH7laY2tNlFTO8mzPyvWVrU=;
	b=dF3ECZth3t+S8iANu+kwhAP9RkQ0jE0KfI90wIjYI/ZdILT1rCBveuxafNzpWNLwBcyf
	 DYhgT9HHsxalrK4Iz3UXneeaosGtQ8+RCaxft4m0EKLEQorfaGMyEEOcz3THDdbrTqWGz
	 PUo24Q30mLQsMEWH09k//iIVzI3qyJpLuGSmg4ax93RAOlZJlbN7uD5HNDfY99Iyiw/ud
	 z/ErmjVKz4rU1/hIu+J3/Ivu6aZ13WBcqwvfJ15lynPu0uuH22AghLvWQ4fHadAVZRddC
	 +Cf+UhI/2GiXTPi3sPOxbHuHn56y/AACqzgMXSxX/X9CEw6YnVNYIC82MY/my7l1SiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhnGMcLL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9A4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhnGMcLL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD03F1F0089F;
	Sat,  7 Nov 2026 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046407;
	bh=pItlQUG/DO1uKcg055sOHH7laY2tNlFTO8mzPyvWVrU=;
	h=From:To:Cc:Subject:Date;
	b=HhnGMcLLrfNjgV3637RR+Fk+KWZxIygN3Nkht5g7+i53NorTff1seqwiKyGQLGEX+
	 hm5yWmi7Vc5r9Z0CozXMjHlDkHqO6fogwauhtG2mxcb0uiaKdexAnRFDA0PzyRwJHZ
	 y3kzhQp1SPZwdxjwTAuKyDlraQC/fI+kLuUvIpZGtWjaHhfVQV29It0iya9pLdST6V
	 kTAYT86JSQ2YX7iLn8fXQcYiHuqAA0zkrJv7CA/XKQE8UadRcG5ScxgM37zdiSDlTc
	 +l4cY8BT08SCwXEtBO4E/7atQatXohZYKLEmjVQ8lSFQofHiIYeT+Edfm6mytc0bUZ
	 3GfIy22jfbfeQ==
From: Sasha Levin <sashal@kernel.org>
To: chizhiling@kylinos.cn,
	linkinjeon@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] exfat: advance valid_size to EOF for append writes" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:25 -0500
Message-ID: <20261107051325-failed-6.18-b70ab4075037@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b70ab407503706289163dd59f1ac3e942bacc37d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051325-failed-6.18-b70ab4075037@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




