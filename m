Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366669;
	b=JSq4r7MzzXzewTtvktfcp1WVfWF/nPqQfTgrSoDpVO0fM/Z7mmThbMkLsRq6X8+g007q
	 ABJxdnJg9jx8Il7dpPGaIshWV/k2JXABxHuNcarTauCcrxzyWs4vsq3yCRP4Cd9wxca8E
	 cqD+k2GlRdfOhdfZY8eLWtRIQjLHIYDWl1rt1eXz8ME0vKS98hRtinLXcQ3X3Dm9LWqQA
	 6XqvJ7AgaHN3+D7YuL3DtZ4y46jls7AFbfQPiYalJ+P41vjQYgYdtNY5LsqVv1sHS/39p
	 IJqb243uLefxd7tnhXeyT19o663r7Z3jpYJ87wceGwuZE8V1wIY4A/9KSZaqZPDfGJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=89bWGzbad0ztQHLRwpDqaawhnj8cR1EXXB5WyhpTrIc=;
	b=BZfEfECYxpqHgJ+U2/v0Up5xebq+h2dr0O3sqjJuoE2aZjHYk1h+XAqotHIATGiB4HJk
	 4VJM16ayA03MdBlgIkZez0+Gw63cD34oki9BdTan43bfVwAHW+gjVYoBBqUH44xOMivIE
	 az8k19UCSE5qwiBmS1W3yIrxGts5GCnVT9vHfrfAWxdwXuFfR7+VegbZDmJl0OJ5ybHBe
	 fgFHjO1cTMVnrDd9VsJQSNdA3nfubU5IUTqNxzpOchNuvKwAFVRjGT4/ZgJ5C7+zz8A/2
	 l7gPXuHqyBG2jvhDmvqkEW+MdQVnAr2mf6UKnVFpyvGr15XULsRalXXWPX2Lckqre2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N61yJWfr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A1606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N61yJWfr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48691F0089F;
	Wed, 11 Nov 2026 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366669;
	bh=89bWGzbad0ztQHLRwpDqaawhnj8cR1EXXB5WyhpTrIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N61yJWfrloMsCwj2ddcP142QaOnccmyKK6mfbznodnKwp8peqn5SvWiEEMMUBiRG5
	 mTZdk/6W3bjNwGfElLua6YacCQTvpzHyTPSKkt3J5cl116VbqLZzSI7ZXtuBWywE2/
	 2iW0O+woIkqHQ65xMN/ZsApdIZ7LOfdeE2a7im1v91zqmzcW/BTj3GkjeBMee1SoAc
	 xqooJ+A7CrSi8mtVrUv46S7mSyz9s3y6r9bR78EqF1QxzWcFCV0QpZClBP5DoArbVy
	 69j1ZevvzuF0RWjqG+hUBzMajgq/M3XYRgsasIjmKqzWUe8Ob/ZMKxX1vk9cd4yh2/
	 dhzK2UYOE06IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fuse: don't drop destination page cache on a zero byte copy reply
Date: Tue, 10 Nov 2026 22:11:06 -0500
Message-ID: <20261111031003.859453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053016-failed-6.6-f7585e1ce341@kernel.org>
References: <20261107053016-failed-6.6-f7585e1ce341@kernel.org>
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
[ sashal: used outarg.size instead of bytes_copied to match the existing copy-length handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index aa8c93b38601c..223012fc17891 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3259,9 +3259,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
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

