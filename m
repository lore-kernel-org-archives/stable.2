Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724E344DAD;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501415; cv=none; b=lo77byD7iB87i2zHn/VrI27LVmsVDiA7U1hFgVVPIhpv1eNeXZgxBo7pDAEORyQex4JWJzGpq5mjpg38tcM8/SmfX+a2sVHSig7qbUIRe/VNGgHviZ1S/Hg2Az1JwiRU9tH7ldowzwGyeOsE35q1NGFnzhla042PIA8Z3JQExtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501415; c=relaxed/simple;
	bh=J0GZi+6NbVpkFqO2Qu/YQNxbs1qAk3UJgajlm5nEG5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K97WNlFM838KcB7OKMnpmxi0VjfG1P9A9a18O84SNEa8t5FkTlK+eZURZHWnnz4g8jC99G1zuoiLcu4dIagd85Lyl1Th57vzPVLoRcgMm1o3ma5yhBjB3V83nU5AapnmXzBIOqauCvIrLwthsLcMrzj2ah2SKMB4xd2QAXtJ6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9quTQeQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9quTQeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 674F6C32781;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787501415;
	bh=J0GZi+6NbVpkFqO2Qu/YQNxbs1qAk3UJgajlm5nEG5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9quTQeQFE+B9xcdvjV1O6Ba5tMEsxTviaKT/V1UJXyn046RRpLXVuTFRGqAYOr2b
	 +JRuEMfmel2iiTZ9YmwBD1uClhPVpwZzYeKeUd8cRfSzzYUXKuvgdqOPa9phhB/zie
	 aS1aXFgsQmR/0zbOd3pGr6Do3V6W7Rywy04Gm/FlNPJH+qbtV6Wc8hE/fBnyBYUp9N
	 pIyuHThgpZ9KVyickzWlny4DOGC2B1bYJGYnxcOhJNtAxXD76Kk/6zlV6nGI9VGFzT
	 iN3+eOwfD3kIAIgjw0Gjh4ckOL+/KHVAVgOnUDzQlEpPk8fz1aFVy+SI5PrBLVN0Mg
	 iL/ynoP+DvRyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521DAC5DF8C;
	Sun, 23 Aug 2026 16:10:15 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 23 Aug 2026 18:09:17 +0200
Subject: [PATCH v2 4/7] thunderbolt: Don't access a DP tunnel after its
 DPRX read was canceled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-b4-tbt-fixes-v2-4-26a18a426c9f@kernel.org>
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
In-Reply-To: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, 
 Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3399; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=J0GZi+6NbVpkFqO2Qu/YQNxbs1qAk3UJgajlm5nEG5M=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1a3dMKdTxt3ZgendsYrfXa/EfH29MR1pzfIrjbMtH8aV
 8Wn9zqvo5SFQYyLQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCRTxmMDFdWN5zNMv/lLBjw
 IW4P/7RZ9d9F1dniP3sKX75uXOVXbsnwh9fqR0WtO3ezO1N7z4XfZ8K/WxdXLr2gX7naKsWpKYq
 dEwA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

tb_dp_dprx_work checks dprx_canceled before it takes tb->lock so it
misses a tb_dp_dprx_stop that could not cancel the already running
work. It then polls the DPRX capabilities and runs the callback for a
tunnel that has already been torn down while the domain is suspending or
going away.

This can be hit by cancelling the DPRX read from outside the ordered
tb->wq: During suspend tb_disconnect_and_release_dp does just this and
with a later patch tb_stop will do it as well. The latter in
combination with the Apple NHI where the DPRX read never completed is
how I hit this.

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
index ef4413581b2a..088323cd876d 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1912,6 +1912,18 @@ static void tb_dp_tunnel_active(struct tb_tunnel *tunnel, void *data)
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
index 00c5a1933544..5f536635908f 100644
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
 
 	tunnel->callback(tunnel, tunnel->callback_data);
 	tb_tunnel_put(tunnel);
@@ -1121,6 +1127,7 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
 	tb_domain_get(tunnel->tb);
 
 	tunnel->dprx_started = true;
+	tunnel->dprx_canceled = false;
 	tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
 	queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
 

-- 
2.55.0


