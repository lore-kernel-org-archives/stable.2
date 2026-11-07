Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050011;
	b=nK/D63k7Xdx3lDZuAF8GS+pmFuRzvxAXqiWzLM63uh1H9fbYYkBIbJU7Gv7yojZEMfmT
	 ExwWkQBexT59zwKc1xiiMW/qjzQ1g1AUmLUcOfE8IDqnHsfo0oYByINNIXYa7fStpdRoC
	 XacVD2F9uaHo//xmVjLMVr5AW/2aHlsBQCeMC3RkrKvx0bIHwtOeVBB8ykn9/cp/rAiSF
	 CeSfvoCcOphTRtVt9qhiIhbgFtcgh86EUQBjgeJj9ba50mt3w+7sMkifDlAN/ulovIh3u
	 QNFQsFsI+hkkL1mY8j1BWDyTex2MPkgtLtOA9R+f79tQ+kaNda4llxKgqpZ1pcNcXUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SQYaNEsPaiiUobkSNt8rhcTK1JNJ81FBMAzrx4NtA5Q=;
	b=wcQMB4yqP9dDDW/0cMPf3N20SAObts6outGeuMlEtMFtA5IoFYvDlQ2M44MX+KB3VRvE
	 L86SaC4MaEuM2mGdgIvqpllR4AINnHG0gDgH9N3AyqhhHOrM++DJuRq3Vui9QrX+LSrsH
	 osBh4vBw+uIN4HWAt7IWCAVQ9zhuesP0NoujKv5QYdoXP8su69xtsFJbZCqsTk2pEAURi
	 2WdN91HraHIv8eGxkUN0kqHuwo+w/WZ86ersjnEd0UPqtFqZkBO39lTuk/gm0OhMGax6t
	 gqXOrOOtX73PJNzf+0LXnu6MhYBdEtxiAnYZSxwe10rph0hNg+glT/14n31B2DPyNuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGZ6O6oX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9014606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mGZ6O6oX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254C21F0089F;
	Sat,  7 Nov 2026 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050010;
	bh=SQYaNEsPaiiUobkSNt8rhcTK1JNJ81FBMAzrx4NtA5Q=;
	h=From:To:Cc:Subject:Date;
	b=mGZ6O6oXNASYvehgxZEMLM9x1FYjIkXyx9xorDUSrJIVeu8D4RiKgvGZ4JmQH+poN
	 jdoV6HCsIw4qTj2gA2u+A8Bq3xbgDxlz1OHA4x8i1Kbum2QvSyW11UVN5KUri9iibf
	 9sHdQyIaprpw8TxMJABpicuO+9whDIqelrk/TXSpsoodHhCM4WbXy55AdUILwhx7mA
	 JqbSqCIG2y3u8LpguWXxJ9BnlrtBqBKnmjqdU+dzNYPYrrDof21hYrV4xISn61oH1i
	 cgvxMP90laTH+T6YwkC72zQkC89aCsh1a/7g/uGlp8EsmeGncP0b/nJmMI3gioQzxN
	 U5D5iss0YYuxw==
From: Sasha Levin <sashal@kernel.org>
To: brauner@kernel.org,
	josef@toxicpanda.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iomap: don't mark unwritten parts of a folio uptodate" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:28 -0500
Message-ID: <20261107061328-failed-5.15-a4193b4af359@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a4193b4af359db84b2cdf3a040752861984c636b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061328-failed-5.15-a4193b4af359@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




