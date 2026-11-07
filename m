Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047276;
	b=THugyTBXDcqFJFrpvdoq/dw8kgtrpLX0FdiNcMp+pomLUk4DuZIP9+60HxC7Sdxm9hvf
	 jDyR6MHUfRfCoEINeOwxhMbaw/cTxpSd6XdUzD0qOiEdXDsoQmsWrbvXYlsMmmZlA69d5
	 eWxC3d5LSr4WgYPRv5VhMzjsrNhpkMwQTv+UPuHcXyrn7FS3V9/qyPnCAMPtTQeky0tQS
	 r45CkqNlAR1Uk7tig2CYHYv7IvQI6Y0KEzlXAG3huLlOReXUb4NvTR3ew5wkvYrgSI7EW
	 5xD58Su3ZYWRxNyOiVHPErClIRJx8zkV67otQXgeYDIA/z4Jq/oDoN9Wr25QYjM69WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047276;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jV6w4yRt77CrHVbSMBb+IQvPvBwpIA4QRAUOwgyFw2o=;
	b=2Yxc1q5v1+p9U/PI1U7bP1BxLypz3autb5mWCi+UaSSfYwgH4pkJwe281gqXEOsbiYcW
	 2uAr29/lxUvagmt1nPJaIaZ81I+firt1KBTD6hSgYDIO5lkblx2WfrfniWmdYx1Yz7hmj
	 i6Sgml7WQs+gFcjhtMc/L9BxRvMBpBmShLpxJWnG/FEL4ntVsOQxPv/RsAfwcrTZfHJ4+
	 ET6zB63/UwPVqMUiZw3f3sHvOkurY1sk8fTXIL6y339jvLSglgzMOv6z/mngaYyZ4Nlpd
	 z8Qea5kc47+3psrNKQ5BQsoHGmENC8IU4+ZjQUWYcnE02EzIcS+CKAkiqHyAIY6WYsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNDa30RF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNDa30RF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E45E1F008A1;
	Sat,  7 Nov 2026 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047275;
	bh=jV6w4yRt77CrHVbSMBb+IQvPvBwpIA4QRAUOwgyFw2o=;
	h=From:To:Cc:Subject:Date;
	b=iNDa30RFEaC5CXQECLAsQT6QzbEh1y3/vPnk2tCt6lnOeXUU866hjPXK4MuShDMWL
	 1lch7+ft6tGz53lLxnP0Nl5hOaSQDq1Dq+vQEz6a+TXiWFD1vrjzMbTAWDc0UCtUZR
	 iRGotgxXjir/jYvbyY5RTjQMlldyPtkviR7m4wN0REwRmqK+gjCX28F8N6B1+ly+P6
	 7Ta7SLiZBn1my4qZCl7nsPBRHoSUXJUdtGWvt8ZegMPJviYXwIF62MYlkcUHPqQlSt
	 R30L9K+y+rfcEDEtmbxucxlrPM5GaQ4xSMlgn1KX7bMj4PSA6A/T26SE3+QOmMVuPM
	 4aPe0bmCJFN7w==
From: Sasha Levin <sashal@kernel.org>
To: brauner@kernel.org,
	josef@toxicpanda.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iomap: don't mark unwritten parts of a folio uptodate" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:54 -0500
Message-ID: <20261107052754-failed-6.12-a4193b4af359@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a4193b4af359db84b2cdf3a040752861984c636b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052754-failed-6.12-a4193b4af359@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a4193b4af359db84b2cdf3a040752861984c636b Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 11:34:48 +0100
Subject: [PATCH] iomap: don't mark unwritten parts of a folio uptodate

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
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 678f4c5329e79..a6ab6f31cbbf3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -920,6 +920,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 		if (iomap_block_needs_zeroing(iter, block_start)) {
 			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
 				return -EIO;
+			/* uptodate once copied, see __iomap_write_end() */
 			folio_zero_segments(folio, poff, from, to, poff + plen);
 		} else {
 			const struct iomap *iomap = iomap_iter_srcmap(iter);
@@ -943,8 +944,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 
 			if (iomap->flags & IOMAP_F_ZERO_TAIL)
 				folio_zero_segment(folio, to, poff + plen);
+			iomap_set_range_uptodate(folio, poff, plen);
 		}
-		iomap_set_range_uptodate(folio, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
-- 
2.53.0




