Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709100;
	b=fXWgJCsD3bgQHgCp9ajV57cCpSnA0mJ63dCcy6MuGvcE3njhU9/AY8DL3fYQpfQgWmuB
	 cr6+/99sJK3jE0zLjS5WUxIrczpCjK+06PTSdxQ4TKUGDDBQyIRIENNPFXvevNpvAobb/
	 L4aEKts0ZPKPhv6PYmCYORNzJa3qBj17HlBTPUCeEuVcUWTgjAbCnJd2DBdKooey9gpaF
	 8oQyBKaW9efFmr06DQIDxhVFIKXfFQPWuCYmAZr2+t6Hdg8LaGpCJ5wl+SsxsUB2eIJ9y
	 UWoDRMjvkKsvug1EQLAnKULiMm2JQ43GjUMpBl+Tu1MAH5gnt34RWietdrR4Th9nWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UkNT4NMgWvmScyrptyaPuVUT8+ALfNynJSKY199s3Ow=;
	b=jRT+J1RTKQDGatnUwZdVKnAyGofjY5H1740JbclhsbnHnknuA7Z5/hSRs3G1/SxMCBt7
	 cu4I/ih5mFpW/UdRFIv9bKtQJAZHb2Jucy6UAC+h6IqXqMYcabiIEwHFjKOo4pD2UdVTw
	 5JSDnTe5AjdXEWp1TXm4hfUCKmzbpxO6vWD17gIKW1lpV5FTSnhiUOSno0nUXpib5sAJV
	 BaWZkBqb1Te5rOfRvxohfkVcqWCDQGJ2KIMs99KZkCtf7dyJbBZn6DqftXENUkEj/Sj54
	 ltXS7KqTGfVjHvPXhahB5ojAyeX14TB/+P4jPAjwlG7GSplQTDJ5NuQIRbMqh4GpD7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7ag14pU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB31606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7ag14pU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A81F01825;
	Thu, 22 Oct 2026 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709099;
	bh=UkNT4NMgWvmScyrptyaPuVUT8+ALfNynJSKY199s3Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7ag14pU8vpQBVEmmKxsQ0PWvg4KvPgxjjI58jzbxOANo2IoiV9el+z4Hdeg9QY8N
	 zR47d0fFVyyES4PHlSpwoJULZ6M32UQSgyEbSoRcWuYIHjXLMbdczy6LCUS1ZEjtzm
	 GbgB+FI0ZOc8m6CQ+nEbZv4tet9A7gYT0yM7yArS/vUm6vh8VLS8Xf/utn5q7njmnh
	 Wv2sc3DYnv/pYOWbpCY4bB82GK8QtuKG0lB7WKg9k2r0Wl7S2OMBJQSTDSHB7iAKkt
	 8y8MKI6wFj3ZnRlQ/iKs1FPX3YdAGsVrblplIK5Q3Yph3WvK/EV3SotQyVTdXEHFp4
	 1ftxSa+4xECTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] ntfs: use pagecache_isize_extended() on size extension
Date: Thu, 22 Oct 2026 18:44:56 -0400
Message-ID: <20261022224438.2162291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102244-balmy-unicycle-3160@gregkh>
References: <2026102244-balmy-unicycle-3160@gregkh>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 5c32f0b8d791c3464d7b280859f312b006e08fab ]

When extending file size, call truncate_pagecache() first, then update
i_size, and use pagecache_isize_extended() instead of manual
iomap_zero_range(). This ensures the straddling folio is properly marked
RO so page_mkwrite() is called and post-EOF area is zeroed.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 9cc5761b8f28 ("ntfs: take invalidate_lock in ntfs_setattr_size()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs/file.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 8f682dbe51eaf..265f780c1f92d 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -269,23 +269,19 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		return err;
 
 	inode_dio_wait(vi);
-	truncate_setsize(vi, attr->ia_size);
+	if (attr->ia_size > old_size) {
+		truncate_pagecache(vi, old_size);
+		i_size_write(vi, attr->ia_size);
+		pagecache_isize_extended(vi, old_size, attr->ia_size);
+	} else
+		truncate_setsize(vi, attr->ia_size);
+
 	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
 	if (err) {
 		i_size_write(vi, old_size);
 		return err;
 	}
 
-	if (NInoNonResident(ni) && attr->ia_size > old_size &&
-	    old_size % PAGE_SIZE != 0) {
-		loff_t len = min_t(loff_t,
-				round_up(old_size, PAGE_SIZE) - old_size,
-				attr->ia_size - old_size);
-		err = iomap_zero_range(vi, old_size, len,
-				NULL, &ntfs_seek_iomap_ops,
-				&ntfs_iomap_folio_ops, NULL);
-	}
-
 	return err;
 }
 
@@ -1125,13 +1121,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
 		filemap_invalidate_unlock(vi->i_mapping);
 	if (!err) {
 		if (mode == 0 && NInoNonResident(ni) &&
-		    offset > old_size && old_size % PAGE_SIZE != 0) {
-			loff_t len = min_t(loff_t,
-					   round_up(old_size, PAGE_SIZE) - old_size,
-					   offset - old_size);
-			err = iomap_zero_range(vi, old_size, len, NULL,
-					       &ntfs_seek_iomap_ops,
-					       &ntfs_iomap_folio_ops, NULL);
+		    offset > old_size) {
+			truncate_pagecache(vi, old_size);
+			pagecache_isize_extended(vi, old_size, offset);
 		}
 		NInoSetFileNameDirty(ni);
 		inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
-- 
2.53.0

