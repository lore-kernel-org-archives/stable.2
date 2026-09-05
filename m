Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF83375F82
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638742; cv=none; b=HGAQdnYYFP7mwrFX7GMeQ0VbihUTyLDZiEK1TVZaKDBANmDsnRxavlNCTRKuvF5APoTczZ7jQmmzKUy6LT3EijGKogOiRszajlLpM5f3Ug1xTEWFyee1w9jTgvBaIw0r2iGmzg5kVdeu0fsIeB/bnTv/Caa/7AL6LXu3JHbE0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638742; c=relaxed/simple;
	bh=kN/0bpU4pGbFhW5YapI45LfGrBS17uLtkRoSFxfvsh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3SYxu2nLAo66bGxAtUOJ253vTA4SM+7442eSUvjyMxOt8m9fVeI7DGYOrmrQf1wvDik2MsZeiEgk4zTPCGu6yrsyDocKX2bLrz7ufQ2iSF7uJavSMnWBHjRuIJF8BD89CIQH0jZDmUwokIYyNVO+5H3ws2blif5lG4zD6+0+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Watgvyln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Watgvyln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF31F00A3A;
	Sat,  5 Sep 2026 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638740;
	bh=s/Rm+xZufeDiI/gRRsO1wAGkq4D1LxmUPz34Ge7KTTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Watgvyln6QNb8+mmvHwR27OiC1kXyFZHgIwcUbuNO0vgwyRxyJXdqUTPabrraLgHl
	 GW/Mp4FcAuXaoytedShJXU6yfTHoXhEBs8WBzxB2LxaryPLpDOY8XdN8+0BxBt/PUV
	 wXKDEBA6P2zPhKbhkRgkz+5RX3RlioJh3ckQwJ48Q3Og21TNe9/vPElT56dYh4DYTF
	 Y1mijbdgopKR7WnYm3B4lKkiNUq3lAoFjNDDLYkQJpRm0psXMHJrbI3b7KUP8hXVYB
	 euNoHG87I7HtLc4NC8gGgqPuA7Ta9N91C5hILZhH8ny3ZcEP1vkC6EzOzAkC4zlMh5
	 7Nqr9rYi7547A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] nfsd: guard nfsd_serv deref in nfsd_file_net_dispose
Date: Sat,  5 Sep 2026 16:05:36 -0400
Message-ID: <20260905200538.608334-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090353-raft-script-514e@gregkh>
References: <2026090353-raft-script-514e@gregkh>
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
Stable-dep-of: 40162cfea79b ("nfsd: close shrinker/GC/fsnotify vs per-net shutdown race in filecache")
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

