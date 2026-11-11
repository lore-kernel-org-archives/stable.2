Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407230;
	b=m+w6DD8tgfWvbyI5UHqBpj5y8abBdV46kPuy3++34ucnKh/UmAhkBMNV/oiCZM+oHeja
	 6GkF3Tfj3KB+RYsGrQ6LxvEG+vDTbtjvaACE6IArUsEcmiS38Na0ba4j2VvrRk9aOP3bN
	 QQ4kuaDzOImD9vHtzricLPkMRwC0e50Z30wETBLr6gmXNlrKgi1rG+AhuNspx5TsXeedF
	 FX5s1//0T2H7uTjJq2Btm0PqPhVHzbLl861I8oAS3vGMb6paj3kWxxlH1mIAsO7+sVj1X
	 B85ksGcv4IU1NBvW7jr0EUEFl6Fp/0/CHmr30f9cWDvA/vvqiW/6MNL0Ul0dwgYZA2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hC4XzJ0eUqkgr+B+WEMlqWX7tReu9jFxSdB4Xg5S/zc=;
	b=F5LNUxIfFRJ9YDjiL03CCJYYu1LPbuGItIqh6OQaVHa22iDyp+/OE9zRqvhet+iZMLyW
	 3WL/kV1L964IlKadVTH2ablgQYQXR5ReoX6gsIETLvKv+6u/58PpxfZZUZrQ9zOzxPWwU
	 Bg7N1hXoHiFQyER49MttnalcVeYe9j5Dju1CLbQnrjHhnp/VnmRJsJI5xy8vhsL79+nkA
	 Fw4pk+kQ25Z13yrUkxc7yoAhmQ878/yPKfthI1XbGoXkYj2jdERCFUjYqiq0d7j19Wqtq
	 4ZzfpppNRdPRsGXd01uR5zqexMAHv1YsiAPxU/8HcrG1fodMye/gvkM7Zf0z1sIob3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKCCESWk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B577606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKCCESWk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C121F00A05;
	Wed, 11 Nov 2026 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407230;
	bh=hC4XzJ0eUqkgr+B+WEMlqWX7tReu9jFxSdB4Xg5S/zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DKCCESWkuwcQlIGx4NOqYQNziAtuVfOJukrOnkhJhIxbtrzsLpqQaPiezY4OX32Vg
	 ZND4MV8v5dXkM4eKGRLRoDJCZIzVr8eNl9ytRXPxVjuD4NBvSW/+toxqytOsF+CnWY
	 6mIKAGoWd1wECg+AxSMBX6LpTgSi9hflstuWotcltJrv9N+jobTEMZ0VYeVFsQte1e
	 RnfloEsTeFxoCJzh3bJhmex8tPg2pHGasKSQ8cXkSA9gNJW6H0lxCm3oMwB/fEhN3S
	 972TLfEfHc9iqDKsC6zi3KaPG/r1qRNu6CvdSyTsLPhtyKlqY/yvIlND9tpjaf79Lx
	 qKOmeuIeib4/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iomap: don't mark unwritten parts of a folio uptodate
Date: Wed, 11 Nov 2026 09:27:08 -0500
Message-ID: <20261111142631.2341945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054034-failed-6.6-a4193b4af359@kernel.org>
References: <20261107054034-failed-6.6-a4193b4af359@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a4193b4af359db84b2cdf3a040752861984c636b ]

For a buffered write into a hole, an unwritten or new extent, or past
EOF __iomap_write_begin() zeroes the parts of the blocks outside of the
write and then marks the blocks uptodate. That includes the range of the
write itself which still holds whatever was in the folio before. It only
becomes valid once the copy from userspace has filled it in.

But the copy can come up short and __iomap_write_end() only rejects a
short copy if the folio isn't uptodate. If the zeroed blocks were all
that was missing the folio is uptodate by then, the short copy is
accepted, and the rest of the range is exposed to readers and can end up
on disk. A source buffer that ends in an unmapped page is enough:

        ftruncate(fd, 4096);
        pwrite(fd, p, 3000, 100);    /* 16 bytes at p, then PROT_NONE */
        pread(fd, buf, 4096, 0);

The write returns 16 and the read returns 2984 bytes of whatever was in
that page before. If other blocks of the folio aren't uptodate the short
copy is rejected but the zeroed blocks keep their uptodate bits and the
retry with the copied length leaves the same bytes behind.

Only mark blocks uptodate in __iomap_write_begin() after reading them.
__iomap_write_end() marks the zeroed blocks uptodate once the copy has
succeeded and rejects a short copy.

Willy reported this back in 2024 (cf. [1]) and Zhang Yi posted the same
fix (cf. [2]) but it never got merged.

[1]: https://lore.kernel.org/all/ZqsN5ouQTEc1KAzV@casper.infradead.org
[2]: https://lore.kernel.org/all/20240812121159.3775074-6-yi.zhang@huaweicloud.com

Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
Reported-by: Josef Bacik <josef@toxicpanda.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261029-work-iomap-ai-fixes-v1-1-7eda63bc1b13@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: adjusted __iomap_write_begin() context to place the uptodate call after the status check instead of IOMAP_F_ZERO_TAIL handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 549490acb229e..d74a8f38612ed 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -710,6 +710,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
 				return -EIO;
+			/* uptodate once copied, see __iomap_write_end() */
 			folio_zero_segments(folio, poff, from, to, poff + plen);
 		} else {
 			int status;
@@ -721,8 +722,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 					poff, plen, srcmap);
 			if (status)
 				return status;
+			iomap_set_range_uptodate(folio, poff, plen);
 		}
-		iomap_set_range_uptodate(folio, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
-- 
2.53.0

