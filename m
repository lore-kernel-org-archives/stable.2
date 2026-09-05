Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AE231836
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623192; cv=none; b=XMKr7ObsIJq0JBy44s0ZdEIGX/WiCCwYTEHgZwqc/TZJKAVDgVz7SMSGk6rLHNOn6Ygrrs4jZZ94BNIAU46tXBldlSAhK2ptyC7ZDM2xob2rGUhjWxz1y+uaH5qlqztAcIjyzP2k7+BR1Ruck6pAWXWyJgzg2KcNrvuiX78EOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623192; c=relaxed/simple;
	bh=9HM2n0lv2We5NJrZeqFr0SZGq2QMN6h9YThtpDjcukg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG3NTYi0pbkByNN5gom60H+cWPDdb0ux4udgPSemCqpnC4GbklOKC+eBqhxBW4qA68yHRbjIugFD7EePJkpZxBYIYITKNe3z0xM6NoB+BlJgxy+fRdZK3pNyReb2fb0A5vuJEpIp8n9Zw9c8Y17zN5e3VQGEnIZ8VuHcQeuXCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIN6hrLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIN6hrLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0A71F00A3A;
	Sat,  5 Sep 2026 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788623190;
	bh=tGKZChPeGa+y2sQRsxNFaILJuopLVPtLD0El3VnH5Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PIN6hrLKxQm32QPBdWBgVwKZVdF18n4sZUGQvIKGGijgx1iBB2BmDBJq/Gs0Tm2y+
	 G1xeQ0yR8SC3ZOzBO+RvjiqukQ2xVyb+eIR+mdtsvm4/PRQxKzjq5tsgHFqnIDq0Gt
	 VrtpmMyYE7yGsxXQ2WNmvrNRchFOpJp07nHde6/0Lnhr8lNgX5TU/GWVPc0mp4epZG
	 Wvmq2lMUu+uaCPJwqYX/IaCsVgBgime29yRPpv1H27/a3NdOy9zDRt3FpjIRZLMB04
	 LhmZvqe9hp760oixZ5WZSbPAl1mSKQafgS8VSGDeWTi4Vzx8xBzWQ6lv2Q0nmJ/MDX
	 I7x/ZTyWcTDAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] nfsd: guard nfsd_serv deref in nfsd_file_net_dispose
Date: Sat,  5 Sep 2026 11:46:27 -0400
Message-ID: <20260905154628.397613-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090339-happiest-badass-03c3@gregkh>
References: <2026090339-happiest-badass-03c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

[ Upstream commit 9f1ddfc8cb9076592401a611eb3a44d36186d014 ]

nfsd_file_net_dispose() is the consumer side of l->freeme: the nfsd
service thread loop calls it to drain entries that the filecache
garbage collector and shrinker append via
nfsd_file_dispose_list_delayed().  During per-net teardown,
nn->nfsd_serv is cleared before the filecache laundrette is shut
down, so the service thread can still run a dispose pass that finds
more than eight entries on l->freeme and dereferences a NULL
svc_serv:

    nfsd service thread loop
      nfsd_file_net_dispose(nn)
        if (!list_empty(&l->freeme)) {
            ...
            svc_wake_up(nn->nfsd_serv);   /* nn->nfsd_serv == NULL */
        }

The sibling helper nfsd_file_dispose_list_delayed() already documents
this ordering and caches nn->nfsd_serv into a local before testing it
for NULL.  nfsd_file_net_dispose() was introduced with the same raw
svc_wake_up(nn->nfsd_serv) call and never picked up the guard.

Fix by loading nn->nfsd_serv into a local svc_serv pointer and only
calling svc_wake_up() when it is non-NULL, matching the pattern in
nfsd_file_dispose_list_delayed().

Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work queue")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20260602-nfsd-testing-v2-4-e4ea62e3cd5c@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: bbf13732f743 ("nfsd: fix fcache_disposal UAF by inlining dispose state into nfsd_net")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a238b6725008a..2258e7a59a850 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -471,11 +471,20 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
 			list_move(l->freeme.next, &dispose);
 		spin_unlock(&l->lock);
-		if (!list_empty(&l->freeme))
-			/* Wake up another thread to share the work
+		if (!list_empty(&l->freeme)) {
+			/*
+			 * Wake up another thread to share the work
 			 * *before* doing any actual disposing.
+			 *
+			 * The filecache laundrette is shut down after
+			 * the nn->nfsd_serv pointer is cleared, but
+			 * before the svc_serv is freed.
 			 */
-			svc_wake_up(nn->nfsd_serv);
+			struct svc_serv *serv = nn->nfsd_serv;
+
+			if (serv)
+				svc_wake_up(serv);
+		}
 		nfsd_file_dispose_list(&dispose);
 	}
 }
-- 
2.53.0

