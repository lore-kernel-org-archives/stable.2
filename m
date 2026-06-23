Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F1346E72
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216335; cv=none; b=C84ZM7/IJ5ImJnNyubOERLYlg+LIBjx2ATfTSJnTFQVKBbsMBByx76DMzxjVp95/2qhKXQp569ELiWRnZFgNTt1UPOqBbVQQgyc0l2fZ94J9P/esrLfoDD1EkKnBmfa2a9aMHh/606q3stwr+gpsFeJEjYldR+cKuU5zPNk393k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216335; c=relaxed/simple;
	bh=cwGhMhdjIhgq4GSIW/JMOtvQU5zMIuo1CpGAx5NIgKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwfvGBrfdXEpjfhysAULq60vyAlUjTVf/VPp5YfiSEOVTw3NzlCWB46cqjvVzfAuyrCbJVuksk8RZDgxnOrtYHTMJf6SvyuBzMdihUuMAnoBL1QpubpbawVFJnHOh/JROuo/Ue4A4ZCjrD57PPp9X3onSn8Z0oapdnMUE8C9IrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd7myrmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd7myrmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05D11F000E9;
	Tue, 23 Jun 2026 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782216334;
	bh=KFCShWuWsAg94MRiOGl00DJjE7Tm+LQXmkyC+JJcWwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dd7myrmRRSZM8bjJsEdgsQuBVxNIIa6Tpx5FvPUUKSD0ScW4y6h8JOTJDdKqdJBgB
	 aPu04dkMxI0PT0g4GmZ6tTvMtBYFzShaK/xH3ScNREOi2dgTAhyxp3WxZFQ35JzvKJ
	 EJI0XzxaMORX6IlPwCk00KBxwoskOyRhCYj4bGPPKJ1T6PPX76B6qqesgkaV1Z3lFa
	 9HrrZBESwWn9RNK4TYucyndlfBPx4sNMlmxHQloi7O80gp71DVe1v/bc0SFxX9eFBy
	 8VD2+dGCi22Xnc2iJSfErwMW5bzvAxe1LkRzx1ejMn9jYKSFbY/rH66imACmv7l6rF
	 bENhaOMpPuWkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Lei Lu <llfamsec@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fuse: re-lock request before replacing page cache folio
Date: Tue, 23 Jun 2026 08:05:32 -0400
Message-ID: <20260623120532.1152295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062230-operable-mushroom-1659@gregkh>
References: <2026062230-operable-mushroom-1659@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit a078484921052d0badd827fcc2770b5cfc1d4120 ]

fuse_try_move_folio() unlocks the request on entry but does not
re-lock it on the success path. This means fuse_chan_abort() can end the
request and free the fuse_io_args (eg fuse_readpages_end()) while the
subsequent copy chain logic after fuse_try_move_folio() accesses the
fuse_io_args, leading to use-after-free issues.

Fix this by calling lock_request() before replace_page_cache_folio().
This ensures the request is locked on the success path which will
prevent the fuse_io_args from being freed while the later copying logic
runs, and also ensures that the ap->folios[i]->mapping is never null
since ap->folios[i] will always point to the newfolio after
replace_page_cache_folio().

Fixes: ce534fb05292 ("fuse: allow splice to move pages")
Cc: stable@vger.kernel.org
Reported-by: Lei Lu <llfamsec@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8f4a2ff56cc3be..42c8d57fca12b9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -891,6 +891,10 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(folio_test_mlocked(oldfolio)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_folio(oldfolio, newfolio);
 
 	folio_get(newfolio);
@@ -904,20 +908,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	 */
 	pipe_buf_release(cs->pipe, buf);
 
-	err = 0;
-	spin_lock(&cs->req->waitq.lock);
-	if (test_bit(FR_ABORTED, &cs->req->flags))
-		err = -ENOENT;
-	else
-		*pagep = &newfolio->page;
-	spin_unlock(&cs->req->waitq.lock);
-
-	if (err) {
-		folio_unlock(newfolio);
-		folio_put(newfolio);
-		goto out_put_old;
-	}
-
+	*pagep = &newfolio->page;
 	folio_unlock(oldfolio);
 	/* Drop ref for ap->pages[] array */
 	folio_put(oldfolio);
-- 
2.53.0

