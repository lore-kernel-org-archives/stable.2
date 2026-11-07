Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047205;
	b=zE/F9i30Scx/kbymgZbby8iSZHkqsuYCenidDWVykjjnYHDBs+jmaftEUxirQoyGd8Cu
	 I8kHt2VZIL6DyBHEr0ngws2s5EEWCRgoELBTKhT4ORA0x/buIgUny5D+YZ7d/Fo/shKT6
	 k13wmdelZ7YbnTzOWt0SdbH1+myxdMFufRB7aJymHgqd6vO+7I6d9VimNsV4SMYG+l7Vq
	 s1XryfOm3BeH+KrrhjbBoDNY9tag/DmA1Hj5R/jO/pMvqXOitGvw9aintt+454HOt90E0
	 /0bxkhbsgpXkiq5NOpDMp6EZmHQiCFzFiYVGGmtOPz0J9LG4549sS+Pdt2TxS3dBkaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IVEOp9sz1hps5m7tb3/ZtA8A7AfpaNcbc1wT5V852mU=;
	b=O7EH/iZt2G/5MSOH6SUtmETrcdSGkCRd0BaGq0y/zgfhdJklGlC7NCSzFE3ZJ+Uf10No
	 j2xk5zZpjdcrwKL8L2h/sSZ+u2CspIJlfngg7zFIXz6oceGHo4yzl6Uw6d3/GY8SKvofi
	 Of2QfY5XVlPsIiY36zkCeN+3woSbBIe9vf55Wp9o7jHNUpDM1H0lVUGlLPzh0WKo/1R1I
	 a1pzB82pY07Q7LvWw42RTMvSTCYKCmKwDcwdOZSB+MGI97vxFN7uJ3vG9Jmd9E7mhc20U
	 2ug1LPiG6koQcmNZ4qKGWTNUX6xHYLnH7KeTIzIbbNmlVw/ptQofXxHl+ER8nYVllMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8aQDdCe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676C606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8aQDdCe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970671F0089F;
	Sat,  7 Nov 2026 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047205;
	bh=IVEOp9sz1hps5m7tb3/ZtA8A7AfpaNcbc1wT5V852mU=;
	h=From:To:Cc:Subject:Date;
	b=M8aQDdCeXtblPCPSqjGBEfoBerT9/gujggiClxkvxQpBPb1kS8MCVJXyJUA+wUCbf
	 0hteedALTwOEN1g7mpz5uyLCRYzAgDw8UYUC65qJGFuUM5izUtUeQdLffxBEOHmWyX
	 z/C9q6nPfO0RT2BmV6PdQ+g03ncbpQ/hL03FnP2986HVzvnW7m0YFRtAkWyJYRffMG
	 fPkoE78CCBIYBbogP4DhMpS6+izJEyuJPjrWLzzexlM3+Tkl+0XphlxBn0iiB+Ir1R
	 /sppqnwXCRwU2BQSf/Cb+JvgumRTscy9Ejxmw1QxmMK1OzMIkObun7h0uBXRA2dzzz
	 eb7BefzLV4DAg==
From: Sasha Levin <sashal@kernel.org>
To: zhugl3@xiaopeng.com,
	amarkuze@redhat.com,
	idryomov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:43 -0500
Message-ID: <20261107052643-failed-6.12-9c1d14d3b66b@kernel.org>
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
git cherry-pick -x 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052643-failed-6.12-9c1d14d3b66b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9c1d14d3b66b3e1dd96ee664c0dd2548f2b77a52 Mon Sep 17 00:00:00 2001
From: Guanglei Zhu <zhugl3@xiaopeng.com>
Date: Thu, 10 Sep 2026 11:00:35 +0800
Subject: [PATCH] ceph: clamp the inline data length in ceph_fill_inline_data()

The MDS decides how much inline data to attach to a reply, and the
client parses inline_len without any upper bound: ceph_decode_need()
only verifies that the message actually carries that many bytes.
ceph_fill_inline_data() then copies the data into a single folio
with no length check, so a malicious or buggy MDS returning more
inline data than the folio can hold writes past its end.

Clamp the length to folio_size() so both callers, handle_cap_grant()
and fill_inode(), are covered.

Cc: stable@vger.kernel.org
Fixes: 31c542a199d7 ("ceph: add inline data to pagecache")
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ae6aa9db5eb24..86fe0e76cdf07 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2245,6 +2245,12 @@ void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 	doutc(cl, "%p %llx.%llx len %zu locked_folio %p\n", inode,
 	      ceph_vinop(inode), len, locked_folio);
 
+	if (len > folio_size(folio)) {
+		pr_warn_ratelimited_client(cl, "oversized inline data %zu\n",
+					   len);
+		len = folio_size(folio);
+	}
+
 	if (len > 0)
 		memcpy_to_folio(folio, 0, data, len);
 
-- 
2.53.0




