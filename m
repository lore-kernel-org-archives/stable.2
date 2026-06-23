Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CBB3D45CF
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216518; cv=none; b=O2w+V2QYOgeuNJFYZhdTvJehTdUoXaFZJ94B60NJJ3Ki/UIV72rrS5NrDLHF+cHijXjB85PRvSEl/5cMokhqueWsY0ukfbkr4hkVI/NXdU6FoIzqOs6UAqEw1iMvT7iilL1mefqmvG+JJz24Zwablkk/wfFF+0uRypJwsAm69hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216518; c=relaxed/simple;
	bh=7X7Pgxli6e0Y2NQXu6YbdOUFj/xrPqp+AMUc/UiBScw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdIftDHGL3hWDKNzU9eDZHKpn5yWNzZWNd8XmXqq/uiY3OxoT4/wcpgAQsA4KVn6MU1CpRSQEkWhZJKYFiNlS5xYRl6kot5OR+htMk/o4VYPyi594P92c2IaLKag2nLaAmOkzKiA2VlCa3Ws3RUf1utRLd1oLHrx1bmVLp8FNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr8ANlj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr8ANlj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A5A1F000E9;
	Tue, 23 Jun 2026 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782216517;
	bh=qZhBOn0UMx9FZMAbhXtwxhUQ2Qt4Qfa8lnmIE6btLzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pr8ANlj2RQooU0Ulkj/4vVzt4MuF+7MqbAS8GORwRzX1iICgFRCdgWQ9ccag4bHKj
	 /DJG+O/dePCmt8kPKQb58Bhp014ZPgcYD4MRTxdblikveGufYtuH4QTiRLBK9ByZQR
	 8BlLqx8aAf/RdSwh3i7SYQQBmjLBIuIGzZAIyHqH/fFHWN+0Kf4x96WQipIlKe6JVE
	 u3y08BdcKtWdiXLU9yCQpoBgsDfyR1tFHP/wqqkUi7Lx4FAClEiSZWuOvpIbblN08I
	 RSd6U5/UNnxA/arN20Sl5rFiNBaSDcMIiX3fbM77lr1FTgIaDYr/JRXqEwYDWwJtUF
	 /gCT644iv5Upw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Lei Lu <llfamsec@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fuse: re-lock request before replacing page cache folio
Date: Tue, 23 Jun 2026 08:08:35 -0400
Message-ID: <20260623120835.1156432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062231-fraction-kissable-8842@gregkh>
References: <2026062231-fraction-kissable-8842@gregkh>
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
index 29a6c3a5829d83..cc16f809e5ce54 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -843,6 +843,10 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(folio_test_mlocked(oldfolio)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_folio(oldfolio, newfolio);
 
 	folio_get(newfolio);
@@ -856,20 +860,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
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

