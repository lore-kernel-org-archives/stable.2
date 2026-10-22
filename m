Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709101;
	b=o6E7YPGfMPwOdVP3Dleh8DPzDLq7H0QO6AHb265zsxdBakWlnRqOjWqk84RTUNzL5RND
	 AFCBy0gfV4wunNRHvgnU/zb/daJXvB1sHU2Mo9lSo1LDUY5mHOOpxDTrLam6pFCllW3Ib
	 CE3n8j8zkOouAlFG6NtGNp9nb2jLE47Ki5GaP6ZWwjWwx6KGEXO8CZIMf9H27ClMAsl2g
	 4YW/zwFUBUgXEEc5yQotHPGonQmlVMTaI9iffi6AAa4iY5WdI1nZjhgIjDDeQhNnOgYgF
	 cql901s3aAgPrk54JhD3CCmRGJzUhHU0wGsArNRqgiMJY54wYFG6ZznBb+8OFHnDEtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+uQ1wMT21WmUWTKFTpURTGiywNbQqYHor0GLH1pFm6g=;
	b=dZf3uVCGrG5BQAIowJBz+/JmLTN8mOeQucAvSF8OOWcSNsplzrKBuV+6Qz+VOIhKV93d
	 YmW0jf4Yp9Gte7taGtVfhvpwlOJcRZ3Nu4XH30tDO+dNwdQvU8I/Kc+3zrYubs7kCdM5Q
	 r6pHrFCsINd7lmpeH0zR8q3+PqJJceXhfTe+mgPJutN+g0aj7tto/GONqAskSEzfYZo+6
	 JWPxEgtHJGasVJ9PDrrjw3YtpGAR/a8bGkhRlkByO+J628CqsCuBus14lOr/hRQoZrKnu
	 DlEX8DMezaZrH/oS3gZ4F1nWUtRXqX13AZyPdmNemz3s0qCBzg23U8ntENGs5N60n/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFQcH6AH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED116606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFQcH6AH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F011F01828;
	Thu, 22 Oct 2026 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709100;
	bh=+uQ1wMT21WmUWTKFTpURTGiywNbQqYHor0GLH1pFm6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VFQcH6AHVCM0dFT9kPXHDq7BVUsOe4RmG7Ewb/31MjjIyhi28iWaefoJGjunn39Xi
	 VMDTGg5G0eEyIgFqjiBerzck/V5FKBJGNuNcjvWB/k54k8Z0K4hxYfgdygMybw3RNO
	 ya06N8OuISj0xV98nNdh74Q/Qk+zkuz10l0gYIQHvYmabeY4QvB58wO+k0mYy84ymG
	 VdHKcbAKt7bPEyrlWzNsjLiXPlgrr2ubn5T3Kb4M3xBNS0kGH4N5D5KE3LziIWJF3n
	 oqTN1pQMeWa/quv32ajnUiuCD1tF0VVNGpg+YNNf4fScIo5plVfpkr0v0zC9L3bPKQ
	 sfQoLs1lrujqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongling Zeng <zenghongling@kylinos.cn>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Baolin Liu <liubaolin@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] ntfs: take invalidate_lock in ntfs_setattr_size()
Date: Thu, 22 Oct 2026 18:44:57 -0400
Message-ID: <20261022224438.2162291-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022224438.2162291-1-sashal@kernel.org>
References: <2026102244-balmy-unicycle-3160@gregkh>
 <20261022224438.2162291-1-sashal@kernel.org>
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

From: Hongling Zeng <zenghongling@kylinos.cn>

[ Upstream commit 9cc5761b8f28f9cef72061094eb5e37e2cd44d97 ]

ntfs_setattr_size() updates i_size and resizes the on-disk attribute
without holding mapping->invalidate_lock.  Page faults take the lock
shared, so a fault racing the resize can resolve a VCN against the
transient runlist state of ntfs_non_resident_attr_expand() and fail
with a spurious SIGBUS, and can interleave with the size-change
epilogue (truncate_pagecache(), i_size_write(),
pagecache_isize_extended()).

Take invalidate_lock exclusively around the whole resize after
inode_dio_wait(), matching the fallocate path and other filesystems
such as xfs, which wraps truncate in its mmaplock (= invalidate_lock).

Fixes: 9c87959601e8 ("ntfs: update file operations")
Cc: stable@vger.kernel.org
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs/file.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 265f780c1f92d..fb8e525743970 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -269,18 +269,25 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
 		return err;
 
 	inode_dio_wait(vi);
+
+	/*
+	 * Serialize with page faults and pagecache instantiation so that
+	 * readers cannot observe the size change until the attribute
+	 * updates below have completed.
+	 */
+	filemap_invalidate_lock(vi->i_mapping);
 	if (attr->ia_size > old_size) {
 		truncate_pagecache(vi, old_size);
 		i_size_write(vi, attr->ia_size);
 		pagecache_isize_extended(vi, old_size, attr->ia_size);
-	} else
+	} else {
 		truncate_setsize(vi, attr->ia_size);
+	}
 
 	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
-	if (err) {
+	if (err)
 		i_size_write(vi, old_size);
-		return err;
-	}
+	filemap_invalidate_unlock(vi->i_mapping);
 
 	return err;
 }
-- 
2.53.0

