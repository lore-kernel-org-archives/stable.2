Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C84B66F6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445876; cv=none; b=D9xupmG3ozEjeHxUPKPl9eWZ8wxkEudXmqSE1lmyVHLxzFhG5tt3b4/cno2Tjmd2gsrHtYZN+fnHS/MJA5MKZlhp5HXXoYtl2FH4WVDXQaLBkJEUd01VeSXEIFRVKoUsMHsMxnQDRn825KAKxkGskP9XRbIa5Q+7LxPWsfZFmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445876; c=relaxed/simple;
	bh=rlsw/duALCss7tu01VH4VirXKCjFLFiTsEVDG9faf4A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HMLyK8e+X7jC9hymiIz2+6vydjXFmKVQDr/nTO0nhqT35nz6dMLTSEdjw88Cjq+Pke4bilWm3XAiXMxpmPisImmFYZkvxPVOcck2mlxUuJwDNpO203cMNvPMyn0k4+ifM7NvPKEy9yEyev76ZWqEcND6yHrlfp8A9vrkAJAO2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEDi124d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEDi124d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02321F000E9;
	Thu,  3 Sep 2026 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445855;
	bh=HiUOeRQO3h/eVYz3Uj7Po5o3b6QfNv7oZX9eNv4xwGA=;
	h=Subject:To:Cc:From:Date;
	b=nEDi124d6rH/WLByg5nNJurz78hZrvUYZ2RmYPrA+hdtKANGcN3hkBrIBbWlOBSMv
	 PXsMLLB4mpCvQU26j3NwvOZMxRJoOFRzO+oNqV+IIiTiODqV+SY5USxp1GrYR8nG8F
	 O0a9i5FbLuRUihzzNE8yxcdaD5D4cc0OoUyVIbrU=
Subject: FAILED: patch "[PATCH] rpcrdma: arm rn_done before publishing the notification" failed to apply to 6.18-stable tree
To: cel@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:08:59 +0200
Message-ID: <2026090359-lingo-expletive-e654@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5b06f706374c37375bdff9d21cc10e61df925a92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090359-lingo-expletive-e654@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b06f706374c37375bdff9d21cc10e61df925a92 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Mon, 1 Jun 2026 16:17:03 -0400
Subject: [PATCH] rpcrdma: arm rn_done before publishing the notification

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

diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index 69166d5d9987..188f7a13397f 100644
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
-		return -ENOMEM;
-	kref_get(&rd->rd_kref);
+	/*
+	 * Arm rn_done before xa_alloc() publishes @rn: once @rn is
+	 * visible in rd_xa, a concurrent rpcrdma_remove_one() can
+	 * call rn->rn_done(), so the pointer must already be set.
+	 *
+	 * Restore NULL if xa_alloc() fails. rn_done doubles as the
+	 * registration sentinel for rpcrdma_rn_unregister(); a stale
+	 * value would unregister an @rn that was never inserted.
+	 */
 	rn->rn_done = done;
+	if (xa_alloc(&rd->rd_xa, &rn->rn_index, rn, xa_limit_32b, GFP_KERNEL) < 0) {
+		rn->rn_done = NULL;
+		return -ENOMEM;
+	}
+	kref_get(&rd->rd_kref);
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

