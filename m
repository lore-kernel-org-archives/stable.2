Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366338;
	b=VWmCaLVQSvD0+qERnRnz1pb9HmGdykZfGUInoOCX/HdKEWBy9dKCAWb+sa7q0nSsSPpA
	 okRWc1BubSdxrxrv7YCmcbzFTyGqn5F9wxW80RgqwRjimXkhcAlnr3dpw2MyfqXIWZVyT
	 qeUTebF06O22LyRqMRuPdNow/DkBStgsQ2dGSRlQNy3RG4kvSmjJRe5Ke29mYhQvZm1Lh
	 1rja/siyWvLV+D6m17s0WidjLr9PXNxY0DEyW00UuCSFvIviciibEbEk3d7XJKAI1gsLv
	 nCGfQZUkV9G2v96N8gWfqh+XDfQsuLVqweuPloawI+Vh56eXrZxlZdWAuhUlOM6qqEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366338;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CJY3sYm6H9nt7ZQcfdqW3cJcAfWqT5Ao4Yc8PP4Ak5w=;
	b=dRagUgAZOWwYT/7znFCAy1oC9G6Gysf7A8UkS35HdptJJFlhjrnliGcyfFbQQ+kLWiDS
	 /ZcAk/5KXFBPo19Ekef8ZxnpkSVWzanQ2Wu+a+s/SoHCHW8Txy23iN1bGFh8euXH91kln
	 j4RHRUqUXDw5EcK5WscJ2oq/0Rg0sFt3PTFxQRRoTmquQzsTkyyNMuiQha2bGj1zPi59L
	 QXwQrRo52DERgkOy4bkcE5/g4eScfhXBttVIoiQ/gpulGUWleghSfXY/uFcMvEqzrQPsQ
	 nPkQvyFlScvqsjPoUxlw4qS1wGnHIIeT0w/AcsenPyu9TF98X13TmK1UyV+qwXuNI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JP7uZ2nd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA0606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JP7uZ2nd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3111F0089F;
	Wed, 11 Nov 2026 03:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366338;
	bh=CJY3sYm6H9nt7ZQcfdqW3cJcAfWqT5Ao4Yc8PP4Ak5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JP7uZ2nd9u3WDMNJUq4CXCgdmD9MswNXqV09jPe/jf6Gqpi7VCFSdgeySXitJm4XP
	 jvgyMqUmut0cNNyPdtGBDCThfOqlcdRyFPoslHnhTiLqmY51zA6ZmEmSzWEBRYvSVq
	 SPILpYvKsPWRYct7Q6is0R2D0fdaeKSReqDualSWYHcLzbYM+v9JVqGSWEoDeXiIRM
	 xK4BV+Na6C4xcYNFLQVEQb0IuBW3lh+iSu8IETwfZLIXueqXb9K3xMSHYJN3GpCq03
	 3QeHPpnk4E1alqMg265d/9s/VdWqnxKG9nr4bxC2t2lDJfR45i5RmkKuOuWrLJ1MM9
	 727Pz1dl9G4ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fuse: don't drop destination page cache on a zero byte copy reply
Date: Tue, 10 Nov 2026 22:05:36 -0500
Message-ID: <20261111030525.832037-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051747-failed-6.12-f7585e1ce341@kernel.org>
References: <20261107051747-failed-6.12-f7585e1ce341@kernel.org>
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
[ sashal: Replaced bytes_copied with outarg.size to match the existing copy reply format. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d242613a1c8a0..d0cf617c36c31 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3344,9 +3344,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
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

