Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408485;
	b=fqca4qn3j/oE1jEK2CrC+qRv6CrRJF1Wc19T/s4+KfZJJJWdnMzFB5fqpol9Zj95hSP9
	 GzrRIWU1I/tBielu4GY46eo19zdfIAAXXcLCS1DeglFKc4XkoZMYp03IBxKOgTlo/E1fX
	 8Ko6uqVz9uNRI+fNl1iba4PvuPpzJzaX84DWsL9wB4lWb8svTnXKOx23hFVXjrXnyPFDW
	 +XaXEZErUHBl2HtjY/89thJQixFG02U4UzGty2ovbiqENMwqG5BlEyJlBzf5UUmJOBtMy
	 ZhAxTb5fQ+Mu5Jvs7z4ev57YifB2U2fUXHDxzohCJAD9UEVoX5KdKTC5gx42DFj4blA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h5ujBcBbYLwjrcrzb8U97L3Chf9bNsYxYwtvASK0RoU=;
	b=sh23VTFJwhYn0MZPZwbfDFxiTNJ9eqtxnK+7OaBQG1hVjJxDwpiM71ZZjsA6+B8WtopF
	 HYMg8GAIynKY83bi3ac3xx2qZ01fwogeZiCkMwP6H55IndV25njwJsPr+/8PJdtpMG5A/
	 NKrLoVmo+T97qWVtRJD045LWN2X9yek+MG5cn4x5QP/E/7WwR7e65pSjwWzF1YoHXbczA
	 d5vz8P3lMHBI0UlnSt9JU8asjBn9a+5fMBBx/BukrPLJKq4Ey+2kLDeLUqhd3hEfBrxIZ
	 Qu9n9dcfo7y81PNwtNUxZDUg5xvniqkw9LG5sNnDFvmAmRRCbqLMWll+ANgdYwTgoFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkhxNAFz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68526606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkhxNAFz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F35F1F00A05;
	Wed, 11 Nov 2026 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408484;
	bh=h5ujBcBbYLwjrcrzb8U97L3Chf9bNsYxYwtvASK0RoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkhxNAFzvh5e67s5oXwAv2eJIAzLwGmV//nRH5X2RERAsCH6snGd5t8uH7NuP2O11
	 Mw16G+YmVzBQO6NUDQW1S01idK1qHpgipckldK9qpvTQ0Vl66EodWcCDwvp5T/90iW
	 0J6HmN2YTEbj7A2WNMmPdKeqqc1L23jcfAem3+4oQFkXvtjS7laNadcE36h79lGnqX
	 6CCbD1pW41Pg3RmjuTxoMIBf3X7b6Rq6navqiWuPVrqlDEITDo6a9ZQo8Tcfdd/GGs
	 qcuNF5oJwpbJEeAGeXopyKkEQYdsCClvf1E22wx0CRbRaUCpytl7bkQ0AXNQQ4Kwnf
	 kfpuOhEJhc7kA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iomap: don't mark unwritten parts of a folio uptodate
Date: Wed, 11 Nov 2026 09:48:02 -0500
Message-ID: <20261111144715.2370479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055638-failed-6.1-a4193b4af359@kernel.org>
References: <20261107055638-failed-6.1-a4193b4af359@kernel.org>
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
[ sashal: Adapted iomap_set_range_uptodate() to include the required iop argument. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d0cfc4c3389c7..9b22279b5c685 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -560,6 +560,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
 				return -EIO;
+			/* uptodate once copied, see __iomap_write_end() */
 			folio_zero_segments(folio, poff, from, to, poff + plen);
 		} else {
 			int status;
@@ -571,8 +572,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 					poff, plen, srcmap);
 			if (status)
 				return status;
+			iomap_set_range_uptodate(folio, iop, poff, plen);
 		}
-		iomap_set_range_uptodate(folio, iop, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
-- 
2.53.0

