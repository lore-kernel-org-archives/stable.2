Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD83CBE6D;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996450; cv=none; b=TrLrtG7/fLNOUjKO0QzyL7LlLKJ8sguG8mfNw34ZW6/NyXGubr7xnpqxcieDxN1vk7SLo6uykc0uWIy2P8VnTzCLrRFRAHiKnJsDWI4IeybeOY5NckNXYN1XjLW/tPqdRNBpnPkOBsnqPuAXQk7sS2si17fgS84lDoiD9eaoikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996450; c=relaxed/simple;
	bh=Wvk/GoG5BUNG7j62FvnpVbC2KSxj9mBYK7LX+M98XUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAUYTk/z+ORQIejskrxUzb0DhVJBH/24KAYNJKvbaf+bGPzxuuFLFLs2FeTH9FKi4n4dbAYSUOhbEi9Rtf4O5MTv6FQyUgC7zAhSIXaCbEw92camP2DyvpIVAxlI0hoGtAqb8tqgYZc/2ozmQyF5CIRBa0uezzzCJKoS8rECnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ/H/Fs6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ/H/Fs6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D3DDC2BCFC;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786996450;
	bh=Wvk/GoG5BUNG7j62FvnpVbC2KSxj9mBYK7LX+M98XUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GJ/H/Fs6QggOUmmy34BTXEShCg8Aw5WBF/rfLsuAa2ho21zussWee38eG/YO9+Lto
	 PHj/JDj42kGnr01kVGBppRHdS4UtzEcVQaOJPZouwo+wlTyJhAcg+G6O2lYviZ0jWn
	 UTC0xVEQ6B0fGdL1604bNslwTg13OOBom6Z2ksCCeGzx5yYBeQZOaWRMLebrkTzbsA
	 HkjExn70iR6tEUtWJU4eR16IT60DcyACWYkh67Z/7VNK3fOuQlIr053RP2+9yJN7AC
	 du8yfNlvoMEpkaxpzvQMocv52veTYeET4+RtgPKrRW0/x61C3doLFrMyJ8XoLsHkVL
	 Oz3hOjjXpyq8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47445C5DF7F;
	Mon, 17 Aug 2026 19:54:10 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Mon, 17 Aug 2026 21:54:01 +0200
Subject: [PATCH 4/5] thunderbolt: Don't access a DP tunnel after its DPRX
 read was canceled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-tbt-fixes-v1-4-eded2461f5fc@kernel.org>
References: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
In-Reply-To: <20260817-b4-tbt-fixes-v1-0-eded2461f5fc@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: asahi@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Sven Peter <sven@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Wvk/GoG5BUNG7j62FvnpVbC2KSxj9mBYK7LX+M98XUw=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1Zz2j3RWz+WHPqf/6gjIbvVb2nfokfamiHuEz9eZrsZv
 eNjavTZjlIWBjEuBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBEwr4yMjzta3nyKXDTgU3l
 m9vftK2Li+gyK79/VWZlmuaxjc4nN+9nZJgoVvZEoOTMUq5m70MH7T4sXPRF0/bYvJ1/Us24BDq
 l73ADAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

tb_dp_dprx_work checks dprx_canceled before it takes tb->lock so it
misses a tb_dp_dprx_stop that could not cancel the already running
work. It then polls the DPRX capabilities and runs the callback for a
tunnel that is being torn down and touches routers that may already be
gone after an unplug.

Check the flag with tb->lock held instead and check it again in
tb_dp_tunnel_active because the callback runs after the lock has been
dropped again.

Also clear the flag in tb_dp_dprx_start so that it only ever describes
the work that is currently in flight.

Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/thunderbolt/tb.c     | 12 ++++++++++++
 drivers/thunderbolt/tunnel.c | 11 +++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index fb9da53fe391..e368a6b53f64 100644
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
index 82d9c0b556dd..52fa90786ff8 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1090,8 +1090,14 @@ static void tb_dp_dprx_work(struct work_struct *work)
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
@@ -1103,8 +1109,8 @@ static void tb_dp_dprx_work(struct work_struct *work)
 		} else {
 			tb_tunnel_set_active(tunnel, true);
 		}
-		mutex_unlock(&tb->lock);
 	}
+	mutex_unlock(&tb->lock);
 
 	if (tunnel->callback)
 		tunnel->callback(tunnel, tunnel->callback_data);
@@ -1123,6 +1129,7 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
 		tb_domain_get(tunnel->tb);
 
 		tunnel->dprx_started = true;
+		tunnel->dprx_canceled = false;
 		tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
 		queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
 		return -EINPROGRESS;

-- 
2.55.0


