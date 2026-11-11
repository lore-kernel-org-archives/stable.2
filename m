Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404436;
	b=LlOKyQl9DC83mCgXbwv38zAYHl3xQhfvbBykPdOPcXry/baDFtEL6xmfN2aaLkt11uam
	 OP5h+nz4nooit/yahkEk91ThfMNLT1Jx+TbaN+EzlGWFAQ4pvTlNxiYEHORAJNRaw6ixy
	 qLGXAGRMdvADGzF0uAdMEYfjE1FzFGEXUkS+PG4WyhPkZGMiUHTpoomIlI1GPMX6t2zXw
	 EhxPWyr5MwkiuEJHealb7VAZVUfu/DNDrfyxE/2hIoVyN9HC1y9Z8eX6hqsjnm5Wb+ggs
	 qVFF1BgQ21oracUW9v8PbQZYEJtpCdqULaQgmhD70pUSfjPjnhGsATdLidtelmQD7eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HOJ7wH5wyfTb+ceDz+kxuO8pmgHP+P6e+MxR3h1inoM=;
	b=vDGVj+zwkihl1YsBKKChDzI4gNdgvn7I4Lb9KpmqMJuoaz455l4yKmS0LF82xSYdUBUQ
	 tfY0WMe6HsBFATSi9IQ5kGqQ/ZkypHJudAUHMdyA1nkvTm1IX95L7Qf5itG9RwppdDbAy
	 L2s4wWySmj6Fc+g42NQ73O9z+77eVKYSbRQDOaRHQs3aDCCIH6bGWIYFrjBXhwvTa0OEq
	 5v64rR8o65UpnGJmTrhVDBZ8maGh0v+TsskaUvtXo8MUzBc30ThK+qMC3C883aTKjEOk3
	 7KC6yncEFDGhxn4hAbO98wd1ryWRTMcrZNi/wB8jK5Dnhm2/bKpwdJtDDNqbv1MQ4oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCw9LEjb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA86606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCw9LEjb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580D41F00A05;
	Wed, 11 Nov 2026 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404435;
	bh=HOJ7wH5wyfTb+ceDz+kxuO8pmgHP+P6e+MxR3h1inoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jCw9LEjb+mPj/CHhPUniKc2Syoa3ZAvKJlFgYk0n56IDx4P2D2pxiLvBHGfTFC0N3
	 gQW8bTFE/BVpzoU/i/Orhr8MbYUJpiigMrajxhwCqPnFco3hND5uwpBaIvAhkgKOeK
	 pB5/A9sN3npCxmr6rphyzxokLX3n9NFJbV0tDLe7cSzfIoMusTjWa96ubE6FzdgrOt
	 o8V8Sv7AYBkHLz3gRS1ccHa7Kaf/E2SPFD10C6hFtWL4NJFNaMupX+tPYuyDqITVJY
	 d+4l73ba15eVEliMGeLq+BA/UyM7cXhq74Uy0KM0A0t21eqcFLYDtkWMZz9IydnTiI
	 OAXqEXTUCRWOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fuse: don't drop destination page cache on a zero byte copy reply
Date: Wed, 11 Nov 2026 08:40:34 -0500
Message-ID: <20261111133944.1667204-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061705-failed-5.10-f7585e1ce341@kernel.org>
References: <20261107061705-failed-5.10-f7585e1ce341@kernel.org>
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
index 9b40d5f067abb..b5d62ae398d88 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3468,9 +3468,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
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

