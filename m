Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406841;
	b=n09gV1qfYb2eaoWG8DTmbb/eFjiOqSCXietfi0BsDu57qgdaHJ2J7YDLY5DP1JcGHxNq
	 ptAWqQfWHcgGfr5m1ZvRH9gthsGFq0HGgr7pQ2N7Q8+6d4Y1vd02oijExyg1SrMZcolZD
	 bEKPbquTIbmtZTUhAux8AZzkkd77KcnYPBHQHeTYLAewoVmXrJ4JwClAZOs4aimNwzEak
	 Yr/IHvuPoW/rD1XP9ja0oyhtNyk5e777kD9GWVwV3vjY5KPWZZWgW/+C1bmhcabGDw8/j
	 gnVTv1xSXadG+wxP0y7vI32iRlAZE4NoRhl1DrY6XVkbLZwuTJvXhhOdg12X+T0kdyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=388iknMKAMKvsECmw96U6sBJ2QgK7f4HusMxdZRh/dE=;
	b=KaV5i0xvDFbnctEoX8kW0uZH1b3oXP/lNxyU9zCg9Y1Yah8/MBnHRD7g0aieGbVjlSPR
	 WQjGf7einFpil+1nRxyQbvWfApABiakUozqj8T6Q5r46vDqmLJSGU52sqGud4PBzrs/Bm
	 ktr+2lXTbpkoO38DzN4IF/X8akhXP+plbPFU7CS88IyirnMeYtY2Jp4l3aa5otLYB4/tm
	 UYmBIoBtUwBinAuD9wjCfMFGDjqvlrTZDAhUyxKASQTAZY5mprZPEsksB2o4LofATyT9n
	 LQ3LjDN+0N/biz6TyNWXOz4CCBkHbeRQ+824djcXzDszGhVpOg6qJ8QaluoME0HGCPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKwAQNQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798E606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKwAQNQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C6F1F00A05;
	Wed, 11 Nov 2026 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406841;
	bh=388iknMKAMKvsECmw96U6sBJ2QgK7f4HusMxdZRh/dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKwAQNQl+1/OTkOMHjfn6TSn+PYA/C8K/PL0k6LMs3LQdfP7HCzvDOAJsyVFC37Mf
	 T+/OB22U3UjPRasoF/CsxZFG0e95JCsJExsLOvRWrEgssUIfDsJodzZ1vMVhLCcCn8
	 kgW/G27A0k/OSHWjpHzySXq+lwGUyHsQttK2Qy00YyTsxY8DKxMnqQApffPb5JN+1J
	 U4vfGdMVV5D+B0hE7uevzT6aGu9wzkKfoufR/yOoE00tKEvktmfZh2N0Z7/8jA9VK9
	 S8DnQ8qcLsXmOtbZOPZvEm5bD7hhIueEeEjDhT/M52ed7HLpkncWGORGGK1G0bVc/P
	 ve/+RWKT8jdHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iomap: don't mark unwritten parts of a folio uptodate
Date: Wed, 11 Nov 2026 09:20:38 -0500
Message-ID: <20261111141955.2307270-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052754-failed-6.12-a4193b4af359@kernel.org>
References: <20261107052754-failed-6.12-a4193b4af359@kernel.org>
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
[ sashal: adjusted __iomap_write_begin() context because IOMAP_F_ZERO_TAIL handling is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 02a5fc5105e7e..23457bdfc20d2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -760,6 +760,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
 				return -EIO;
+			/* uptodate once copied, see __iomap_write_end() */
 			folio_zero_segments(folio, poff, from, to, poff + plen);
 		} else {
 			int status;
@@ -771,8 +772,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
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

