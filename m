Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B228472
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644634; cv=none; b=WwfhpAQOX9RIsPxRn53bHtFyG13iB5BZmgoqMNoI9Bi1Q2UEKoOCiOA5ax2uU9sl6V4OykeVFKGmPqVpcg+K0rJ6JI10I7ikT4uJ3TwJcRtT35eg8X0kYePtHVj7gxifxc0LbCXdy5dyFBCa6ppZ7exOpR71i1mDZOH4l6lX+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644634; c=relaxed/simple;
	bh=KQVmryaZbFBMVQTDT/1tRUmXiSteX2Kgv9TOqE1/ixQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOLhvt3iY0lnAqy6RUyjg8ZvxCgnt3OuPsh1SJC6UwnW9IxJ/12Bs2so/GfVOoDP/+WsR0cV0KwM5a+isf7ID7+g4NBTDumSpvDL47/WZ23hoj5ny0eXjS+YpMnnIKbRxoleeM6tPQyR/HsSNol3VlLeIx6NRi5AEF+qFYQrHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQXJvQRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQXJvQRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCE01F00A3A;
	Sat,  5 Sep 2026 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644633;
	bh=0x8LArYZM/iCXbPjRgFMmnoynDp10PljFoKtjIP9GnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQXJvQRxD9Dxb3UtXEhNjGsxEIIlGg+iPQE0nBsmg3cytmF0loeVyrGsQy5swRLe1
	 t9u6OJtrf7BVqPKVbXixlfzRX514aNs6gd4NOjWKKbkKNRG71dlGEVNC5pl6xmJ8ig
	 4c4eGBpZ5sxYbzkH3pzCM5qlP0Tgbi+RoUp4yOE3SYD4hpU3yvhgXP/svWBnwsfCl1
	 Ga6J3VMlkevdacgP/hGfTALd3G8XAt50/jA4ynKviL9567fZWryAPTUCuC43XIIIfu
	 /c1JYcO9sMdiJgglHZEhiYuLgjaFzMjsPNm6e7gtFAAxAF01pZ6Cc3E4YP/UqxnvsZ
	 b0FbvTgGkKeeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] nfsd: guard nfsd_serv deref in nfsd_file_net_dispose
Date: Sat,  5 Sep 2026 17:43:50 -0400
Message-ID: <20260905214351.703039-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-amends-antarctic-06e4@gregkh>
References: <2026090354-amends-antarctic-06e4@gregkh>
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
index 05f0a4867673d..e3441cac74f97 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -483,11 +483,20 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
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

