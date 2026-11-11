Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409456;
	b=P9o1kmu35vGmq1xTWroZ/prAdL2Y3v9oMG8dNcJy+mKpLrGn1dSRlQjMBxbL4OqyBJJ6
	 yC7kWXSwCE1y0om8i90mGrYJdEXqLEbkOUYY3pDWaE47E2P1YMfcRNRyQ6JIZvcL4OY8u
	 Uu4qtguIEt3GWHCFCgeo4/glRWHl9eZF3TsydOBQkQxPjlFwMwFZOegDeKFTx/3UQN0eT
	 bdk6gpmz32uadgCBQpOkILw71vX02xv3TxXkYVoj68CLibQnwjSIH3yspFcGR0tSZFp7g
	 gjDghkIc7GYxyG0gmlXV31ff+E62/QAQaSNa/nTLIt1RC15nul0wrxI8Lgw4C5i4SRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409456;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1SrMy78WN+D7w1ldPRMqbrq2PWQNKruxDxGSvs2zDKE=;
	b=mSpPDp4qT9By68hzHZnRO4HD4SV/GJcBxGo4ac4l8DCTQZgvM7xa27/wJcQjLHuwuyFi
	 cAsDwAUneZ3av0/gatziL6kqq6vJ8/0e+4TA94riX68SjTAQ5qsaOGPpjKX5UTwD2FfLF
	 ePVy+N2k0pgbof82tPub9j0HeofYtVd7xmj76y2RmI0znPZYWCL37pW4yUlmUqT9sZwOY
	 kVWZQuEoXIyhgJ5kEIKmgRA4DqgrJy8D0HCLu59btUBw1EVinM+A99J16Ajq+IELm8vOB
	 oP2QAio4b/4Xok/BFLnoKg6hZ4tq4Bm0hBcZBodt4NBvlhcy6hMMm5y8/6vZKzDGodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=co4noC81;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445D606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=co4noC81
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2964C1F00A05;
	Wed, 11 Nov 2026 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409456;
	bh=1SrMy78WN+D7w1ldPRMqbrq2PWQNKruxDxGSvs2zDKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=co4noC819ZVt0GXPCUvqgq9nBFLk8KForMwNnfKXq+WJt+TM+I5uCWoR8Mi1eBrwX
	 F/vvE6rgWp9x9ORTIyRv8plY20CAsk9EmfEiXxJ3XFkK2iGmF4oYWS91NqzCBFM0fZ
	 PQYzbX22A2a94Kbrq5QRXqrASPJ2U08ABwPr/oZro+9lc91Er75AjQpt0lHosI2PdV
	 qJfmnIX9TgFyErwoI3vHbmwA7pd1pP8KsBu2ShWUWiahcE/CshT/vO0qjgCNCXpLIv
	 AzZRNpdzEYQ6Gc/EoBHcdsbn+epUGqmet66pPoSmVTjeo/j8kPjoIgPKHZWi/9EHNX
	 MAbKeBX42wvUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iomap: don't mark unwritten parts of a folio uptodate
Date: Wed, 11 Nov 2026 10:04:15 -0500
Message-ID: <20261111150357.2481521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061328-failed-5.15-a4193b4af359@kernel.org>
References: <20261107061328-failed-5.15-a4193b4af359@kernel.org>
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
[ sashal: changed the iomap_set_range_uptodate() argument from folio to page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2d65616762ba9..6c7b3791c4953 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -579,14 +579,15 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
 				return -EIO;
+			/* uptodate once copied, see __iomap_write_end() */
 			zero_user_segments(page, poff, from, to, poff + plen);
 		} else {
 			int status = iomap_read_page_sync(block_start, page,
 					poff, plen, srcmap);
 			if (status)
 				return status;
+			iomap_set_range_uptodate(page, poff, plen);
 		}
-		iomap_set_range_uptodate(page, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
-- 
2.53.0

