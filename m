Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273690;
	b=LMqHczp3pr1dayNzrSF0MHF9gcTrgxYi19CLuk9uBMxyGWQslAlHpeS/gAxgz47ovS+9
	 VfxCie/x7Vu7tBqGfxYT8zAyNWPueqNJ8I7lVcN0v7Zc1lGHPyazVxcqd4s8Z4PklGE/2
	 MjkI+J6BxylM5QurMJ1w0ZKl2JVcuiUaSF+EHOdylmM518vxMZT8ymaECpkNHID0vs3zY
	 DDitHbImMqTN6ws3T2++FgmSapmjWOwtMhuO1oCMsxRaQ+6euKsTU9r/XZJZNwXZZEFpR
	 hLUGYM/WoO/6YyPrCQxJxpf/bqMPlgHjubecpLRfu1Mw/3kRLN2RhEMXUQ6ur4+3QwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273690;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+a+zrWq0S1IlQXF/m503gTSo/ndPDhE3lJbi0Z+qYao=;
	b=u6F2K1IlybZxTOlDGQLUfRlGJt0wNHjKBIH/HO58exanvd9TSg9/CAYe330KxiqB3Vfi
	 UtedIXFd7zcsYSy8oqdIsGcRdWEgu5ssGXl8U0hW1xtPh6Qn3qi77mdMVSazYsyVgoa7j
	 Tf2vzpUc5mDahp4gxKrFsmVP7amJvJi2X7HGz9+L2lsWg0RIswG861wVp4UUV6RZbpBeq
	 ppYmHbC+2h9Fx+UJ4P2BUj084GWKCPOvLfSePtTQ9bFr8jZEEHIY5rbCfjYF5Sm9MM9HP
	 YOL0iu+nCKbDCgXfbJ5aOQSN4budNnwxbZpOAyj49NDSohWEaof+kaiVbHokoA1pdIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4GVanjN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4100606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4GVanjN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089301F0089F;
	Tue, 10 Nov 2026 01:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273689;
	bh=+a+zrWq0S1IlQXF/m503gTSo/ndPDhE3lJbi0Z+qYao=;
	h=From:To:Cc:Subject:Date;
	b=F4GVanjNQkKnZqacQiAVIEOEHu0AwbhM+OOuM4RGaULlagE5QyjuEIFopAI0OnuAh
	 iJ8E7BRhsH0IUHAxKgGfCWdoL6ub/LuXBbdJaTbzUXCEGPImfd24fH8ipSwNTVFPgE
	 nylNmK6e1lmJe7Q9Oln3QMXJcrgs2vzXb8EQrLfar2meT2crHVKf2nb104lni6beCW
	 MdZZHVf/l/eO2VD4IpujigGqazKLNRifQ+32XEa4cHgd2kIIN3ASd2PotmhmvYpY3r
	 Ps2+aG2oEKUxRTIIJ8N7pw8glTq4vcNWHseXtuMa4EgH+UUtuQ4q//uuXbOsxFzfGi
	 AZk9FAU7PYrHg==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	dgc@kernel.org,
	hch@lst.de,
	cem@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xfs: don't skip free extents of the longest length in a whole-AG FITRIM" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:21:27 -0500
Message-ID: <20261109202127-failed-5.15-5745f4f10a1a@kernel.org>
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
git cherry-pick -x 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202127-failed-5.15-5745f4f10a1a@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Mon, 26 Oct 2026 10:54:06 +0900
Subject: [PATCH] xfs: don't skip free extents of the longest length in a
 whole-AG FITRIM

Since commit a66d636385d6 ("xfs: fix fstrim offset calculations"), the
by-length walk of an AG in FITRIM starts with
xfs_alloc_lookup_ge(cur, 0, pagf_longest) and walks down. The lookup
lands on the longest free extent with the lowest block number. The
other free extents of that length sort after it and are never
discarded.

Start every by-length batch with xfs_alloc_lookup_le() at restart_bno.

Suggested-by: Dave Chinner <dgc@kernel.org>
Link: https://lore.kernel.org/r/ZgiJWxVcVwag0fIP@dread.disaster.area
Cc: stable@vger.kernel.org
Fixes: a66d636385d6 ("xfs: fix fstrim offset calculations")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_discard.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 8120f136af931..cdf660344c281 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -200,12 +200,12 @@ xfs_trim_gather_extents(
 		error = xfs_alloc_lookup_le(cur, tcur->start, 0, &i);
 		if (!error && !i)
 			error = xfs_alloc_lookup_ge(cur, tcur->start, 0, &i);
-	} else if (tcur->restart_bno == NULLAGBLOCK) {
-		/* first time through a by-len starts with max length */
-		cur = xfs_cntbt_init_cursor(mp, tp, agbp, pag);
-		error = xfs_alloc_lookup_ge(cur, 0, tcur->count, &i);
 	} else {
-		/* nth time through a by-len starts where we left off */
+		/*
+		 * A by-len walk starts at the last record of the longest
+		 * length (restart_bno is NULLAGBLOCK until the first batch
+		 * ends) and then where the previous batch stopped.
+		 */
 		cur = xfs_cntbt_init_cursor(mp, tp, agbp, pag);
 		error = xfs_alloc_lookup_le(cur, tcur->restart_bno,
 					    tcur->count, &i);
-- 
2.53.0




