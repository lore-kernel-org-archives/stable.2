Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403047;
	b=JwEV9vUJq38chpwXD0iG5R6JLTuofaouLjckvNCfhrh5kBD19zrDYRLIc5tBLoIJ1Obo
	 zinFYNqn0TzZw24vFSC9PJHkKM8BBXceIpherJHi1TNzMwSupN3bUvf0rhwcyetoX5aNy
	 r6ztmxvKNn6/G8xsVqNW0uLT/30b75mHa1hzlSR5AhMHOQo8lSi2bRXgwbyX1gGB8ID6r
	 ywkAiFHTI/LZEs0NtyI46rtswWTr7rO/efGI60A1xb6pQ5CalTaUXiC+k9G16o3e8y1lq
	 2ZnvbLow1QGpJNRFfck2MaqTeFFIEuTEbathaOCgnFF+sLMTJVXGi+TBPiNZ5DpZJfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+Am3ZFEfP5PRMYw1OSmyr5SVbiwkToQp2Xt8tqzOQJA=;
	b=Aj2NVvcV1uhZmMBRpE5+KxUDq3SlJZrGvxLXf1d4ZGgGpTKEvWEAtZNxiM8/auVhLGLi
	 2iuJu7kkXwELpk8Uyw8vnBHe4qeQKkSSfILiaVxMIXb7UcdvaGk5irihdWfZawLJ07Kgn
	 lmHsYQycQDwGSpwelhKmBimXS3eLUMF3QB37a19t/mSYjfq0SItbhKaIqI0WBD5ersQqd
	 Tyv6Y9BCYEIzQ0zoSWHa+sh6EXq0NI4w39WpS2yrO/NCjMS/DVu7YE6KzZonSHA/Yp++7
	 ZonUTnnR/Dc+L4DVY05OVuLSdfHbPpptH6wsDysSWeNIvMbWDoVdl2zD0TvAy4pga1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPf5C6GE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316C606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPf5C6GE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB4B1F00A05;
	Wed, 11 Nov 2026 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403047;
	bh=+Am3ZFEfP5PRMYw1OSmyr5SVbiwkToQp2Xt8tqzOQJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPf5C6GEtHQb1WRXYc1ib/4iMS5O/1IyV9Zz6Ob/bWGWppfWHIB2sMXCpWey8YJBf
	 REynbkejZZ472QjT1alPf/SPSn2Hpb1BRt9JHNWtdqAGSZbcG6QXA5v4ALHf6qgPwo
	 upzvbGVfNj0Evk/f2CcFkwBm5ra1BxpLSkp2rENAluMnaG8exGYNWkNgMaNHBLKhDB
	 iVgqdW8JiZb3j/Ud6qjvtvYEn9Rd9NWPxMwtyl4T1t2cAoI4R2qNLTbgYK32FTxDRi
	 gY9mZRmxo1n4RdsN6+ftwIWrqg4QrJ3g/AN2f2lYst+kaDFGsOq/uIIGEIj5KWD1yo
	 qR9gYRfzWt0nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fuse: don't drop destination page cache on a zero byte copy reply
Date: Wed, 11 Nov 2026 08:17:25 -0500
Message-ID: <20261111131459.890336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060013-failed-5.15-f7585e1ce341@kernel.org>
References: <20261107060013-failed-5.15-f7585e1ce341@kernel.org>
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

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit f7585e1ce3418ec282485854b3d8d31c6a961e37 ]

__fuse_copy_file_range() clears the destination page cache after the
server replies:

	truncate_inode_pages_range(inode_out->i_mapping,
				   ALIGN_DOWN(pos_out, PAGE_SIZE),
				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);

A server may legitimately reply that it copied nothing, eg if the source
file turns out to be shorter than the size the kernel has cached for it.

If pos_out is 0 as well, the end of the range is ALIGN(0, PAGE_SIZE) - 1,
which is -1. lend is a uoff_t and truncate_inode_pages_range() takes -1
as its end of file sentinel, so rather than clearing nothing it drops
every folio in the destination mapping.

That is not only a cache drop. truncate_cleanup_folio() calls
folio_cancel_dirty(), and fuse_writeback_range() only wrote back
[pos_out, pos_out + len - 1], so dirty data elsewhere in the destination
file is discarded without ever reaching the server.

Skip the call when the server copied nothing, since there is nothing
stale to clear in that case.

Fixes: 9b46418c40fe ("fuse: copy_file_range should truncate cache")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[ sashal: used outarg.size instead of bytes_copied ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b6b06f760162c..0c26b5571f625 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3153,9 +3153,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	truncate_inode_pages_range(inode_out->i_mapping,
-				   ALIGN_DOWN(pos_out, PAGE_SIZE),
-				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
+	if (outarg.size)
+		truncate_inode_pages_range(inode_out->i_mapping,
+					   ALIGN_DOWN(pos_out, PAGE_SIZE),
+					   ALIGN(pos_out + outarg.size,
+						 PAGE_SIZE) - 1);
 
 	if (fc->writeback_cache) {
 		fuse_write_update_size(inode_out, pos_out + outarg.size);
-- 
2.53.0

