Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409691;
	b=zUWFd3EIIISCoKyvpI/OW8OHPmog7WqjPqcXJAO/DXzVmAEpCCC6saUpFL1Xld0pBexc
	 V2/u5w4rIbO+KmSoNRbqmw1D9v9yh/UxA+mAmDbTZ02cbTlR4B8yh1m6ekHYXn+iR+qQD
	 IHUvjPv6fOFbOty79eiZnYw3PoceqzetM8aZsvLNylCFU+YPJXxAeZq20POPwMpfGIDQM
	 rj28CtzU3DHmg0xnF7HOEmgM95d3X8GI5mMtXpUc7hU8VbjPtfJm6s56E4hPVMjA3LV3u
	 7Du66SPtAKmwB9lVSpoiI1+xnUzTkqj+UHDSmC0oa5KpQvOgqgdm7bKXPSHjlyyiMKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409691;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FvJzox++Vr9rqn+r0wGp9yA1pXcCJ28CkqGuvOQFGLw=;
	b=vEdVJM+FN1ACsC1wrnuDhYuX2noKqkpsYWHj8B6Bie4vC9SQh67+d/po9B47n9ydiIOL
	 W5z6B8YMDwGz8SJ946lM4GV4WiTmWZlnS9FK8r7VZ1SJly2Tn3e0hoaWaE2WzKmvkWWnm
	 84AuUrWcoJ7LdhSCi3jfvwba3GKuuqIN6lUU6yqndz58jpAPCO5k0IyS/lp7mFpjQ8olx
	 RCb3rb/w3taGPJaSOxNYhGKb3NMLcW2IC94pF4DuwvoSo4n0vq45JZghAtdPPHpxgNGQz
	 d8F5aRoRDLLBUfd7U6T0H6OUzpWoK8HT+m5dl4oR4Ggpezk08fsWtfuk4ap60RNS/RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h376NfOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01540606A33C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h376NfOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E421F00A05;
	Wed, 11 Nov 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409690;
	bh=FvJzox++Vr9rqn+r0wGp9yA1pXcCJ28CkqGuvOQFGLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h376NfOLDXse7IGT6fw6IBFSV7qhsFs4LjMeH7flPgwHIdRnvmO+jz8QlM6mHabFU
	 MpvWC9ELPAmhsUjXfeC5QFRBRfyyGrYH5XzL3pNH59w9pXpHXH/kBibKlT29RX/xNT
	 7YjRSuhQ7mc46QRMV1kSnXObBZ8WtpZgASMkNxPgsB9Pi0MCHRWKP31b9xMHXykYkX
	 EibIJImojP2mdomHrKxRM4mTXlzG+N2UOSXJUcyDGM5mXlJnlzeWt2SHPvYqXNVEAL
	 7jIzd4BnOuICaZQ2vGlN3/EYeyZsbQBBtQkJKmGabZkB8QPQbCFqo2VvwFLZThr/i3
	 kbF1bsV97kyPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iomap: don't mark unwritten parts of a folio uptodate
Date: Wed, 11 Nov 2026 10:08:09 -0500
Message-ID: <20261111150754.2593002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063037-failed-5.10-a4193b4af359@kernel.org>
References: <20261107063037-failed-5.10-a4193b4af359@kernel.org>
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
[ sashal: adapted iomap_set_range_uptodate() to use page instead of folio in the older __iomap_write_begin() context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d0a141816f125..8756797f224d0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -582,14 +582,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 		if (iomap_block_needs_zeroing(inode, srcmap, block_start)) {
 			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
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

