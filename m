Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364530BF4E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244363; cv=none; b=fWRwC5HCzUBPxIJ8QcG8ZpXOgniyOA/6UZOIgca2D9kE9dqgro9X7oEN2chz0f92ZZnaMim4ZMYRjXmUilgouOlUsgCsZ+iTbIBDbonj6uXkrT0msthxFC+8VLnNc4HEALXWdobVEIUvaOOqQt3eu1m5US2+p+twKZamr8BjT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244363; c=relaxed/simple;
	bh=jpVy0QVc2BGEF8kHIQbOvoc1+4joSiGrA7UDy2tep8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWuuxXWPtVykzxpH30kwqdhXUUejPUP7ZQ5YH4K/HwObb/mfxuq48a0NXqkMJuFqhkv0CV+4kb2j2QwIaM9WtCgGtPUi1b3hp7bN/bUbyrt5CAOo2EZPShd8nAlpc4Xb9ndOqKLhHgmIxN8KmBZKT6UwSum5H0WrjPnwCpLYXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVuAgQDm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVuAgQDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB951F000E9;
	Tue, 23 Jun 2026 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244362;
	bh=SCtNyAccqIG1mBViTpaZCxe142RZfiD/rltBGNu9ZkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVuAgQDmITmoZZgLvFrP1XOZPFb8h36UaALS3Sm6Lm/XGu8xwakchM9y4S25zj8yC
	 BnhLZHqcDRKVu7SpaZv22drcrE1ZY4UalQwx9hju7ksIOpYubT0osMMaqiFXJ8XhK2
	 WBsInkpnVfaq/CCnL3prH9iPSkD42UGb/yC6a7EgZxjc57j31Zr/OiWhwfmCCfRPDf
	 hE0Vk3fcHhIKsJ3WgM2FaO9C2xA4FIwlG6qaNwGL1hhf1JwtBVGXQQuEbaeOl9WLi4
	 Zxc2pQfjeECe+RmMX/JdtHSqm9pkdTAvK80PFMtLtl1+U5YuzsXeV45TQ+fIhuyzpx
	 TfoFnh8ukZ2lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Lei Lu <llfamsec@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fuse: re-lock request before replacing page cache folio
Date: Tue, 23 Jun 2026 15:52:40 -0400
Message-ID: <20260623195240.1378610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062231-impale-afar-8694@gregkh>
References: <2026062231-impale-afar-8694@gregkh>
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
index 231b1c14b76778..618f3a3b1d8f65 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -845,6 +845,10 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	if (WARN_ON(PageMlocked(oldpage)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_page(oldpage, newpage);
 
 	get_page(newpage);
@@ -858,20 +862,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
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

