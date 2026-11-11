Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367033;
	b=bfoAXvDD0LVA4ZLfPgrgZhovDcnPyJfWUA591M4b/yoMYCosnIU8VlW6O0T/BJEXdQJ+
	 mSmnCoUfMNmHkAg0MWXpMABB+CUzluyRmt431FDI32DlxXAuUpEFvzCtdCYPFUS5T0ODZ
	 FNeLqtYpt8zEYjiS3OZjhYarfQxyxoRHyfD/FM9cyqlpxaxVgCzkMkbLmAHMIuzj8DoaN
	 S0veIcsFBpnMMba/7RHkZqyPmJDwWxIowlVOC9mSU5RDRopLSIc93jUbfUVX+gI962C0i
	 xX1v7Gof1gZmXaI85yUnqykIK8c/S9IivGdQ7p/hzWkWmPPETrcszBXFZVBeZyEC5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ds2aa3p1+lEpt/oSVWYs5FZp0McvCQYQvRKDkTPgjms=;
	b=Q5c1XkrmxPPXcn7f7DboECgQCCBLQzTINNOj/KUzYIny9rLvjMo3tQuexrfIXbiGVFNF
	 i2msxpvmdEk/8ETUb9WI7fQHx/ELV7uY9b/ZyGgdS2U4PC+troZMDixZb702J6I2fw2vk
	 AR5ts+8iTz4rkOjRRcGCVWrSQ0j3tBM/yfmu7tHvBJtPRkIiQtg1Rlu9vGoEJ7cBZL/Vg
	 UfNvtsw5F7AQq8tb3kRZJC3jR52p9DeOZAdWdSfMskQgSZQyrnF9NGKQIevqZgssizj7u
	 cdfxdbc+x7gaxhpsSeApkKqd88RF/A3SvMkZ7LJX+7K/0mmf/twikJ5ekVuq0gt8rxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhMHRttq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B90606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhMHRttq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3D21F00A05;
	Wed, 11 Nov 2026 03:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367033;
	bh=ds2aa3p1+lEpt/oSVWYs5FZp0McvCQYQvRKDkTPgjms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dhMHRttqIU+BuEcheBKPN4bp4v/x1x5Ug3351ZdRvavV63pHG8qguck2iVi4bQSqL
	 PiPwoJsbqllTgPJlHv+OtboR6tlUcIPAAmRayw/ECsFHAeVwyEttzWLZ1taNA8/mG0
	 zsJJvxXuQh31PY8VH9WPx+clVU9arCY8t40CpESr+pta07uSbfxpUTJt8Xr5Tr1Fhz
	 S+ToqkqMe1XkFt8nB62DhyO50uIE4CRLyTnC5K3n0w9xHIUuczqQx3/nLxKytl2ZrG
	 I6z6EmhEVQNb8xAfYGTyVQyyOEfLEkdLcSzoz3W4dLy4YzNvCNkTWXaVD4i/oolDhK
	 qpBZWgY4o9ZTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fuse: don't drop destination page cache on a zero byte copy reply
Date: Tue, 10 Nov 2026 22:17:11 -0500
Message-ID: <20261111031614.874265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054257-failed-6.1-f7585e1ce341@kernel.org>
References: <20261107054257-failed-6.1-f7585e1ce341@kernel.org>
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
index 56774b31d5ff6..2effa7fa2f832 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3209,9 +3209,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
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
 
 	file_update_time(file_out);
 	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
-- 
2.53.0

