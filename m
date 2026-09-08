Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5335513569
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909181; cv=none; b=ubD58fDAZA1smZHF9r7mdA1n+WWrSeXAJStZcELyjGMR7AF4jnMwAl797Om9GeGrAEs1IzEklgZCffIIgy/FL4H+nOeYSTsdqdaOVNlm55lBmIXVa91YXihfdQTPEKI1zOO6FNO8tIrCsjBVx5DPRJMJG2XDiZxF4H7suc5dP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909181; c=relaxed/simple;
	bh=hJkyQkTdwQ7Pt3GfNwogEiYVQNBHEQt+eF6htoufwYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbteKsSfvVBZY6uubS7b702jRFDmNdXHrlPNG8aw17ouA292dJNBo0rKfgUf6m8AyD3VroKVHLWDHoMlLj5uOmFmtjmWXpsBjNoAGLUsUstmU0XqPMV+XN7tpQdkJ9EyUhAhorGTdCexN/qTPcwA870jA4Y7sqGYSolwXU9V2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fk34jfx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk34jfx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A531D1F00A3A;
	Tue,  8 Sep 2026 23:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909179;
	bh=eJ+YWeSNm7x5ucoL59nxiEYvYFa5cK/tMEhJSU+KMt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fk34jfx684XzTO13u6iRtXS5Tya31m9VR/cRK8wynDne4TG0YNroE+lF1bKUN4tsd
	 6zEDOjQo0Ott8pRjHN7sb12amRxEPhCTX/D3cXGnUtEWantuX66PQaYizSIaLor1ed
	 FSz/XmQvS+GopsutFuXc2P4qysIbuSTz0kYjqxH4+K36t4ey3Iwwr+pQ/4H2PhFBFH
	 8MKGpiTNRMG2CSfzWLiI/mobhNhAlPEICMmEVNuOLrMDrlrcPDx5AHRmWLnxZy2mYf
	 4SN4COqRL5NcUyNrkuL6n0P4Estl1ddozn0F/lavgtYgm0zpJe17mtYOEniMp4VFB1
	 d/DU6ufm2mnrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] rpcrdma: arm rn_done before publishing the notification
Date: Tue,  8 Sep 2026 19:12:56 -0400
Message-ID: <20260908231257.600031-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-duvet-guy-f5a7@gregkh>
References: <2026090358-duvet-guy-f5a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 5b06f706374c37375bdff9d21cc10e61df925a92 ]

rpcrdma_rn_register() inserts @rn into rd_xa with xa_alloc() before
storing the caller's callback in rn->rn_done. The xarray makes @rn
reachable to rpcrdma_remove_one(), which walks rd_xa and invokes
rn->rn_done(rn) for every registered notification. A device removal
that races a fresh registration can therefore observe @rn with
rn_done still NULL, because the notification objects are zero
allocated by their owners, and call through a NULL function pointer.

Store rn->rn_done before xa_alloc() publishes @rn. The xarray's
store-side and load-side ordering then guarantees that any CPU which
finds @rn in rd_xa also observes the armed callback.

rpcrdma_rn_unregister() treats a non-NULL rn_done as the sentinel
for a completed registration, so the early store must not survive a
failed registration. Clear rn_done again when xa_alloc() fails.
Were it left set, the failed-accept cleanup path would call
rpcrdma_rn_unregister() on an @rn that was never inserted, erasing
an unrelated rd_xa slot and underflowing rd_kref.

Fixes: 7e86845a0346 ("rpcrdma: Implement generic device removal")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260601201703.46078-1-cel@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/ib_client.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index 69166d5d99870..188f7a13397f2 100644
--- a/net/sunrpc/xprtrdma/ib_client.c
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -52,8 +52,8 @@ static struct rpcrdma_device *rpcrdma_get_client_data(struct ib_device *device)
  * is unregistered first.
  *
  * On failure, a negative errno is returned. rn->rn_done is left
- * NULL on every failure path (it is assigned only after xa_alloc
- * and kref_get have both succeeded), so the @rn may safely be
+ * NULL on every failure path (it is armed before xa_alloc but
+ * cleared again if xa_alloc fails), so the @rn may safely be
  * passed to rpcrdma_rn_unregister() without a separate
  * registered/unregistered flag in the caller.
  */
@@ -66,10 +66,21 @@ int rpcrdma_rn_register(struct ib_device *device,
 	if (!rd || test_bit(RPCRDMA_RD_F_REMOVING, &rd->rd_flags))
 		return -ENETUNREACH;
 
-	if (xa_alloc(&rd->rd_xa, &rn->rn_index, rn, xa_limit_32b, GFP_KERNEL) < 0)
+	/*
+	 * Arm rn_done before xa_alloc() publishes @rn: once @rn is
+	 * visible in rd_xa, a concurrent rpcrdma_remove_one() can
+	 * call rn->rn_done(), so the pointer must already be set.
+	 *
+	 * Restore NULL if xa_alloc() fails. rn_done doubles as the
+	 * registration sentinel for rpcrdma_rn_unregister(); a stale
+	 * value would unregister an @rn that was never inserted.
+	 */
+	rn->rn_done = done;
+	if (xa_alloc(&rd->rd_xa, &rn->rn_index, rn, xa_limit_32b, GFP_KERNEL) < 0) {
+		rn->rn_done = NULL;
 		return -ENOMEM;
+	}
 	kref_get(&rd->rd_kref);
-	rn->rn_done = done;
 	trace_rpcrdma_client_register(device, rn);
 	return 0;
 }
@@ -102,8 +113,9 @@ void rpcrdma_rn_unregister(struct ib_device *device,
 
 	/*
 	 * rn_done is the registration sentinel: rpcrdma_rn_register
-	 * assigns it last, after xa_alloc and kref_get have both
-	 * succeeded. A NULL rn_done means this notification was
+	 * leaves it NULL on every failure path, clearing it again if
+	 * xa_alloc fails, so a non-NULL rn_done marks a completed
+	 * registration. A NULL rn_done means this notification was
 	 * never registered (or its registration failed) or has
 	 * already been unregistered, and the call is a no-op.
 	 * Without this guard, rn_index == 0 from a kzalloc'd
-- 
2.53.0

