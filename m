Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E573939B6
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244181; cv=none; b=ZKic7DjgyF6pfRP166qEXAW21ELAqnha62dzRewOJWUGFpcOtmLC3hjmp8g64S0GssWFwvNDj5dOzeZYX6LMgNdXH+uYIgXMeSZH0UN4qHD4msGW7jjl3OG2ZBBY9xZUEGk2h3SmCdzVDpqEQjfNxVMQh6MC6r+x7TdwNce9lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244181; c=relaxed/simple;
	bh=6RzFIdGudxTx8h17dyce85P9cpvFv2zSRZGFxRvlWWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJeOElpy3FtpOHRu2BBP8aDE7nNS7prz/H/VRFurqVQFuH4SSjuuDy163oHqyz+uEXm7AgQad7vjrWFMG6QEvkDOzrkhHAHFKK2XbO2tXCHGxj1goXu+YBf9wTQshU1/K+jt8sF9IDlAEPQa2MwlvNDib2zhNiyZxlcAKFPs1Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHYpVdnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHYpVdnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E8C1F000E9;
	Tue, 23 Jun 2026 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244179;
	bh=05sabeZwNOEIHThmaI+9BpqqhsMHzxqNBn+GvhIoVek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHYpVdnSGnVWvn3yJEV+VdEdjmMJpi9hF5IV6OsFZ134tJ3+AVGpE+EwA6kNux8bd
	 2MK6hpoJEIfq1ZSjlMQkb5JMPUuNXSYDNholGRAQExLXPG37ZLAcVmCNWyC6/bOcs6
	 Ii6KcyTbtAdm70kHEYbfB3bhBePbinlF94vED2550Hy3Qxp/s50RVqoViS/f9MCxCg
	 n4voSi37ztoCe9v/5DuuV2fOjqP0tB52A3iM4CTahCyJmC0LGrYrsyrxoxoBG9coER
	 FszVLdHixvVve3NlsYu30m9mn8Qh0PGNCee0R9O3CLni0l4Ylbt4GLCSUrtMP/cb2V
	 xk47RDXfRzPSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Lei Lu <llfamsec@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fuse: re-lock request before replacing page cache folio
Date: Tue, 23 Jun 2026 15:49:37 -0400
Message-ID: <20260623194937.1375846-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062231-sterilize-crisped-5ef7@gregkh>
References: <2026062231-sterilize-crisped-5ef7@gregkh>
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
index 58ec5bac6ce9d1..8e21bbfe65dc7b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -839,6 +839,10 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(PageMlocked(oldpage)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_page(oldpage, newpage);
 
 	get_page(newpage);
@@ -852,20 +856,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	 */
 	pipe_buf_release(cs->pipe, buf);
 
-	err = 0;
-	spin_lock(&cs->req->waitq.lock);
-	if (test_bit(FR_ABORTED, &cs->req->flags))
-		err = -ENOENT;
-	else
-		*pagep = newpage;
-	spin_unlock(&cs->req->waitq.lock);
-
-	if (err) {
-		unlock_page(newpage);
-		put_page(newpage);
-		goto out_put_old;
-	}
-
+	*pagep = newpage;
 	unlock_page(oldpage);
 	/* Drop ref for ap->pages[] array */
 	put_page(oldpage);
-- 
2.53.0

