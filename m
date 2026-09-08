Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4A39794E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909672; cv=none; b=gUBRulsxvqKz3+7g5RfwTSSled2ljCYnXF/LmKIF1LsTBpODvq9Vj8KbCv0b2DB04RjKoZybyOvbY8VbbeTTrvuDXQONnTXkDo7scX+F65wK5gci2u6v9EussEBOcLVFw9Vi9IGO/4qXq1iH6T2cNcmC6c9NA6k2xVl8UtMEmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909672; c=relaxed/simple;
	bh=RMBLlQsSuPNQ2TJ1bbptzWouIQo7GGBAdq9Nm6z1sa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKKMNEdFO0y5vHwq64D3AZDweMDCNk31XPjvyfDco8dt7SHCqHhinpipqUDxoA4Q4xRFDlmcyC/xpqitiAlXKodlcuX6w40LYP/nzhZOvCtKjuyykp34sHcREMRamiwndYGQMnCBTfYl9WOSlHDuYfYAMWS9qFa04jzYwZfIhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPBw6D/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPBw6D/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DFD1F00A3A;
	Tue,  8 Sep 2026 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909671;
	bh=fnluLFQRgZTePeEzd6yh5Zg499/EVmQBRdGWkPtdWgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPBw6D/Scsv12kegF9bWLlidwqs7ByQT+7mGDdaTik1WVo0FFiSJyJKuvuCyIO+8T
	 j6BJ6m28pY6Gm2WkfzRCKLPJdRFFhgFEUMdlGMbF1NfRCoQscs6/F55OT6I1cEumen
	 RysBcpNJxEurgwTEo4TRDrwSY4AVB1c6sBkFT7XOkYuhAwdVgloVgbRe/RiZj8H2n8
	 a2pr5sfA97s0vOuqeHx2WTZLV3DLG8dDHZHqp/lsoAkXbKOkkNVu+NnTVZ5t/vaWtJ
	 ZTfoYCB+W1XMgRws2sX02WsgT+NG2OBcKpkID+sFokN2WEiJbPbQ1w/9G+b5zCSNLx
	 Pf0QgsBUCan1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] rpcrdma: arm rn_done before publishing the notification
Date: Tue,  8 Sep 2026 19:21:09 -0400
Message-ID: <20260908232109.629807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-lingo-expletive-e654@gregkh>
References: <2026090359-lingo-expletive-e654@gregkh>
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
index cfc24e21d260c..888638318b6dd 100644
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

