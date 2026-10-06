Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC34AFE27
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329101; cv=none; b=uWxFxg6gOe6+M+hxoRQkr6SBrvumc3ATp8e+m7lhnC3X8Tig++G3XdDasAABeGppw7/ZJnucuLYju7SGcrMqnZQwnGaYie/IWTPaMHYwz4XZE5pEC72W1ttDauN0FY34NYKiXTZ2aiXeHgLeruubDYfOzhdWw3CbHkj0oIi4aO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329101; c=relaxed/simple;
	bh=VNYfm0j9bnJxuw/HfcOLuSuh09V3UvN/XmiJ71Dp1rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzIYvL5d7Tnxa8DCQBrIPKc7x7oRrQ7p7i0iFxaeTGWIcN4VjdNGEakGicNPf2DkGtalj71GwaQOrH92hJ8xp9sYkXOyiA3P8QNtPUrXSsLlOEJQ5/Mp5JfGTO80cx1GtTEC4T4sIft9aVTaiQpKlezP2swtqYDLLsp+s2oNXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuDmBU1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuDmBU1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B42F1F0089B;
	Tue,  6 Oct 2026 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791329092;
	bh=5X/7CUF/Qa+XMW7wPiBW0aMCYmsEbmBWPrAG5DMHXUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuDmBU1Tj1hizfgYeE3Unhblj+8CC0IG9SD9w3LE6m6VUV16BWXPHaDiIrW828bVN
	 lbdsM+RjapywRMQ1ichmMciC2qPHbp2CrCRg+u6TJ1Up4SmWp8wVV3vMPu5KJPDNHU
	 Yf0wc73k8iszdH9Q97Qks0fQj+LQim46t6j870ISZHxWmzrbWOl9CCMc+WM1mBe0q0
	 jDcdkDilD38FI8YS3dD4YR8pwK4/FxXu8FLsKx7XwHY0UbPWm/4dOrh9ep7rE3/Wlb
	 b7BTyS6VzXQzHZAhw30Ip6I7TnYJpRpt52orsrJdMrEUupwjYJw5ok8G0AZbcH44GQ
	 tk4JVlbc0PI8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sven Peter <sven@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] thunderbolt: Don't access a DP tunnel after its DPRX read was canceled
Date: Tue,  6 Oct 2026 19:24:49 -0400
Message-ID: <20261006232426.1193916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100526-spree-unquote-9a23@gregkh>
References: <2026100526-spree-unquote-9a23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Peter <sven@kernel.org>

[ Upstream commit 419fa32fa5bc2d7fb9d0d15d5630b1c1090808b3 ]

tb_dp_dprx_work() checks ->dprx_canceled before it takes tb->lock so it
misses a tb_dp_dprx_stop() that could not cancel the already running
work. It then polls the DPRX capabilities and runs the callback for a
tunnel that has already been torn down while the domain is suspending or
going away.

This can be hit by cancelling the DPRX read from outside the ordered
tb->wq: During suspend tb_disconnect_and_release_dp() does just this and
with a later patch tb_stop() will do it as well. The latter in combination
with the Apple NHI where the DPRX read never completed is how I hit
this.

Check the flag with tb->lock held instead and check it again in
tb_dp_tunnel_active() because the callback runs after the lock has been
dropped again.

Also clear the flag in tb_dp_dprx_start() so that it only ever describes
the work that is currently in flight.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
[ sashal: Adjusted tb_dp_dprx_start() context to retain optional callbacks and synchronous reads. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/tb.c     | 12 ++++++++++++
 drivers/thunderbolt/tunnel.c | 11 +++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 0625da3066842..51b56a304ae8e 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1910,6 +1910,18 @@ static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data)
 	struct tb *tb = data;
 
 	mutex_lock(&tb->lock);
+
+	/*
+	 * If the DPRX read was canceled the tunnel is already being torn
+	 * down by whoever canceled it. Do not touch the adapters here
+	 * because the routers may be gone by now.
+	 */
+	if (tunnel->dprx_canceled) {
+		tb_tunnel_dbg(tunnel, "DPRX read canceled, not activating\n");
+		mutex_unlock(&tb->lock);
+		return;
+	}
+
 	if (tb_tunnel_is_active(tunnel)) {
 		int consumed_up, consumed_down, ret;
 
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 7bc5516f1e2d2..466e9da029356 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1097,8 +1097,14 @@ static void tb_dp_dprx_work(struct work_struct *work)
 	struct tb_tunnel *tunnel = container_of(work, typeof(*tunnel), dprx_work.work);
 	struct tb *tb = tunnel->tb;
 
+	/*
+	 * The DPRX read can be canceled while this work is waiting for
+	 * tb->lock. Check the flag only once it is held: while the lock is
+	 * held the tunnel cannot be torn down under us and the adapters are
+	 * safe to access.
+	 */
+	mutex_lock(&tb->lock);
 	if (!tunnel->dprx_canceled) {
-		mutex_lock(&tb->lock);
 		if (tb_dp_is_usb4(tunnel->src_port->sw) &&
 		    tb_dp_wait_dprx(tunnel, TB_DPRX_WAIT_TIMEOUT)) {
 			if (ktime_before(ktime_get(), tunnel->dprx_timeout)) {
@@ -1110,8 +1116,8 @@ static void tb_dp_dprx_work(struct work_struct *work)
 		} else {
 			tb_tunnel_set_active(tunnel, true);
 		}
-		mutex_unlock(&tb->lock);
 	}
+	mutex_unlock(&tb->lock);
 
 	if (tunnel->callback)
 		tunnel->callback(tunnel, tunnel->callback_data);
@@ -1129,6 +1135,7 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
 	tb_domain_get(tunnel->tb);
 
 	tunnel->dprx_started = true;
+	tunnel->dprx_canceled = false;
 
 	if (tunnel->callback) {
 		tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
-- 
2.53.0

