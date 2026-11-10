Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341401;
	b=TfC6cIxoKYQYL2kzPn3IO11xTGnX2pkJTkoUECo9KrsvriGVogqCz8GPq/ccNz5T+8BD
	 rB93dT8uaTevAKBs7aEdxrH/3r0QTLse4pvamT7d/myOtxsNYGMUijkQnRQy/I3WVOFU3
	 dcikmEQxTn4FHHjjsLJS5jxkZ0ppnrDXYhgsZ5xl58vUUSffkanT85stQO2RUyVuFbzp4
	 BWJMuNCMQ2vWmk/27z6udYbb+/vZt+y8TO9xpDaNEU14STZKbmS2K4dgfVWqrbaWqed3n
	 WA07NC0MYzv+Z6UkDXwNr9csUh4wEk+MgEqE4a+BTHi87GhROChrH5aqFjy4BCzGt0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341401;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t47qrQn4nnNg2BAz8AcX3IcZVDg+LS4cm8LhhTszO7E=;
	b=i9FYiWwm1xK41FlTxkgnNiQPVF+sAYTzvfOQItTDCGmP3OnFgGpqP/tj5jljtSOT5LXc
	 Xd1JuuCOdjyV8u5g7OPmts8geoP8gciMvQPy/VCaT1GHuu9ASTUqwvTgvfZBc2HN+GBVA
	 Ck8owP4eL8HRowDadQgMsFd7pzU71MRpN/FK4hoVhc7q02g/37UUO91A93as2vnaI9EZp
	 F9q5n6P7TFfdFvRusIay7kmQ69ODTYy09GN+WsfWf/C4yx26ULt9tGUi5X6goTwNMESWz
	 0WWxknHrrbxb/NQlM/r6OVavOl6fa8QEHMxkcesXr3kFMpAhAM5Mz59NA+Oj0h5AE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QruvgdQc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E4606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QruvgdQc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F201F008A2;
	Tue, 10 Nov 2026 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341400;
	bh=t47qrQn4nnNg2BAz8AcX3IcZVDg+LS4cm8LhhTszO7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QruvgdQclnTle5BsuyO0GUnlrvwfsSfj/wU1UptTHyuFh8wmE7/oVmIAxqOoYfFgy
	 3CylzvBKs8D5qmzDMXSpEJVgYkmH0MJSvYilQnYUUgD7/wV4BGGx2nVw3z75cO/nsl
	 h4VEs8zU95mpnrk5UhSfC0foYIWDThE8PGx9mf+cEzxkhd6N/83+YqRrJtWFYarqil
	 oc7Ptw6hLnLzkHrxuLRIV2uAW5UED1ZPAMbgkkUODnD7syrfLsDqCCmUw6gX7GlVJk
	 7JhmtpN8Qx4ytp3Xb2GyB53ULebQDj/E82QjVvmdvm8Iiqp4U0UZ6t51+rmxF7y07V
	 45gZC9o7fKU7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chi Zhiling <chizhiling@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] exfat: advance valid_size to EOF for append writes
Date: Tue, 10 Nov 2026 15:09:58 -0500
Message-ID: <20261110200928.3702462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051325-failed-6.18-b70ab4075037@kernel.org>
References: <20261107051325-failed-6.18-b70ab4075037@kernel.org>
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
[ sashal: Moved the pos assignment immediately after generic_write_checks() so the existing direct-I/O alignment check reads an initialized value. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/file.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 536c8078f0c19..64569d8ba8d73 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -633,23 +633,18 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
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
 
@@ -660,6 +655,10 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 	}
 
+	if (pos > i_size_read(inode))
+		truncate_pagecache(inode, i_size_read(inode));
+
+	valid_size = ei->valid_size;
 	if (pos > valid_size) {
 		ret = exfat_extend_valid_size(inode, pos);
 		if (ret < 0 && ret != -ENOSPC) {
@@ -669,6 +668,8 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		}
 		if (ret < 0)
 			goto unlock;
+
+		pos = valid_size;
 	}
 
 	ret = __generic_file_write_iter(iocb, iter);
@@ -677,9 +678,6 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_unlock(inode);
 
-	if (pos > valid_size)
-		pos = valid_size;
-
 	if (iocb->ki_pos > pos) {
 		ssize_t err = generic_write_sync(iocb, iocb->ki_pos - pos);
 		if (err < 0)
-- 
2.53.0

