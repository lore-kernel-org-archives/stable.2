Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341789;
	b=1eW4J9BumPBVVEGzb0ZjkC89d7HT88OKTrjQaGgNsIGbz//Xakf2HiMQLx1/EkFtbyqz
	 MmWE00kLwKag3CV8DqzhKm+4o3j3Q2jbjSz65MbGSSz4tbpKC4V/11yp4IfRJ+oEH44DH
	 jPWUmMZjM2Bu/BS816E+QaqLCGBNJtisq14cf3g37va482acvwwWn5XiO74+kj5jedRiP
	 zLXtwhkGn6okXxgEf3c82V0882mbLR1SjB/BOkzdye20HeXLKgRQbMAoq0vU5j2JTBxr7
	 T5mQs8nqvp7O18gBQikrCxrcdcUKhsgMA2Sd3n6ocs2WAPe7NKCUnQ/6hqXWhd7NGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341789;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=whqOxjUeWCaS2TujboeAUWI+1OnmZgKD0Mgj5wHfXuo=;
	b=AYkHgNSjcSfPsNIOwrdlQ3Vy9gJbsnKoxExXjIfXrbpDJifO2CKqHAinfvutA49UPlK2
	 ePLFeU/HHisb88ei2c8tfc/Wt8y6gOk6pjvMqhwjUtzYCRhyGUCDPWtgTDncnevOyf8DM
	 yBQBk2j+Xsv5oxouzZrCWuosoUw9ziNkyfD1JwR7e6Vz8ywx4xUoSRAbm/zCvq/f7TF+J
	 fRMjaecJaF/ytCugLAuOBtnQJL5i5GKR/0MHOVJKmmARAOoi/5GvkFed0FPoCk4QN7nh/
	 XLa6ENlpwg/lDG3ea8DH3P8XBk6soH3vyV45hh4gxbzIm7LLM1T7tpGMa39tKJv/Gbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjdNvWpN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B7606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjdNvWpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CFD1F008A4;
	Tue, 10 Nov 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341789;
	bh=whqOxjUeWCaS2TujboeAUWI+1OnmZgKD0Mgj5wHfXuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjdNvWpNTGgyLtEzLVIOAoiB6ArcCgEwmeYKqcgvO/qA3Vxi5uK5odZtP2f3h0jeM
	 LwvZc/JDglJknEDlWu7p8eSZeFfGSGoq2Wd+zVQOGWtP6nycDCAuKPHT9MAhr7Jzdx
	 qIP9Qngnc5NbyvivgRS0XjahWJAInpjO0rCUuQPkG5weuM0N8atHByLn7T+/wEV5iG
	 RTy6dYtXzuLsD5KS5Xbi9s0wlOTE596picrq6SzdPc6UPR9Gvj+c+dtXsIhh4ZgQc0
	 /3c6Dq6pEVToRdwzalnYo4git6cmVrU20KstI0e1Bkk7mmNKsf1hKwpg7iktqW5sr1
	 tsidb1XypRTZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chi Zhiling <chizhiling@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] exfat: advance valid_size to EOF for append writes
Date: Tue, 10 Nov 2026 15:16:27 -0500
Message-ID: <20261110201612.3747230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052509-failed-6.12-b70ab4075037@kernel.org>
References: <20261107052509-failed-6.12-b70ab4075037@kernel.org>
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

From: Chi Zhiling <chizhiling@kylinos.cn>

[ Upstream commit b70ab407503706289163dd59f1ac3e942bacc37d ]

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
[ sashal: moved pos initialization before the existing direct I/O alignment checks ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/file.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 033852efe5dc3..b624dc527f675 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -581,23 +581,18 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t pos = iocb->ki_pos;
-	loff_t valid_size;
+	loff_t pos, valid_size;
 
 	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	inode_lock(inode);
 
-	if (pos > i_size_read(inode))
-		truncate_pagecache(inode, i_size_read(inode));
-
-	valid_size = ei->valid_size;
-
 	ret = generic_write_checks(iocb, iter);
 	if (ret <= 0)
 		goto unlock;
 
+	pos = iocb->ki_pos;
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		unsigned long align = pos | iov_iter_alignment(iter);
 
@@ -608,6 +603,10 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 	}
 
+	if (pos > i_size_read(inode))
+		truncate_pagecache(inode, i_size_read(inode));
+
+	valid_size = ei->valid_size;
 	if (pos > valid_size) {
 		ret = exfat_extend_valid_size(file, pos);
 		if (ret < 0 && ret != -ENOSPC) {
@@ -617,6 +616,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 		if (ret < 0)
 			goto unlock;
+
+		pos = valid_size;
 	}
 
 	ret = __generic_file_write_iter(iocb, iter);
@@ -625,9 +626,6 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_unlock(inode);
 
-	if (pos > valid_size)
-		pos = valid_size;
-
 	if (iocb->ki_pos > pos) {
 		ssize_t err = generic_write_sync(iocb, iocb->ki_pos - pos);
 		if (err < 0)
-- 
2.53.0

