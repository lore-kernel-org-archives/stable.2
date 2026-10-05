Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8D4ADD9E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211420; cv=none; b=qWxOqZhigE2V42wcwAVt8fY/djjpRx+vawDq3o4e6XAsFpY/JZzpZTPKpoSluvGxOlXKOwREBUI/wxbDOm3daY5Ss37aEkNQidIBFTBXAsJqYhg7cWw62FkpusepqeU+m8qzW8r7Fop8w7y0Jdjy/g7B+GBX/nox05p4PmCEuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211420; c=relaxed/simple;
	bh=FSOQbghMSvNXsiyK+nb1AKr0oWuFGUMrYS0ojEOpCmQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tSzi2wckLR1Ha9lBCeW/buB3PMEJ9ri8kiRrRBNvAKGd0hLW8gdo6h/Bc2jpWQwqhIGOK/ls3TWcllG4S3fYgDdtcE3KzRE5cdcR1wxW9dbM15+NvmNgCn5fgtbakbcs3oyQ3qd7EljVarXOMTCbAwIova7gwTFR19F/ZHDY4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NeSsTSVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NeSsTSVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21BF1F000FF;
	Mon,  5 Oct 2026 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211409;
	bh=mL3XrsYXEhunDYIL829y59lStO1lm+Ps4TAm1RFkcZ8=;
	h=Subject:To:Cc:From:Date;
	b=NeSsTSVf5LwC4IBp2RDHGJdQYoAmLRKEp6ddFWthqhHUMBoAadOUarOzQfCjuD2ZJ
	 QpPyJOwAUYCSppyemIx8dpb+BsFPPXQI9sKHpYJjl6JPw7qn3cUZ2lanoMMwL2zVpe
	 +WUfo1NRZteaR10oyys5kpPRRjFi35OJmOUskgcQ=
Subject: FAILED: patch "[PATCH] thunderbolt: Don't access a DP tunnel after its DPRX read was" failed to apply to 6.18-stable tree
To: sven@kernel.org,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:43:26 +0200
Message-ID: <2026100526-spree-unquote-9a23@gregkh>
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
git cherry-pick -x 419fa32fa5bc2d7fb9d0d15d5630b1c1090808b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100526-spree-unquote-9a23@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 419fa32fa5bc2d7fb9d0d15d5630b1c1090808b3 Mon Sep 17 00:00:00 2001
From: Sven Peter <sven@kernel.org>
Date: Sat, 29 Aug 2026 10:08:36 +0200
Subject: [PATCH] thunderbolt: Don't access a DP tunnel after its DPRX read was
 canceled

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

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 1c5e0c9159c4..70a1a585bd54 100644
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
index 4f3a3717e37d..d015e54abde4 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1093,8 +1093,14 @@ static void tb_dp_dprx_work(struct work_struct *work)
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
@@ -1106,8 +1112,8 @@ static void tb_dp_dprx_work(struct work_struct *work)
 		} else {
 			tb_tunnel_set_active(tunnel, true);
 		}
-		mutex_unlock(&tb->lock);
 	}
+	mutex_unlock(&tb->lock);
 
 	tunnel->callback(tunnel, tunnel->callback_data);
 	tb_tunnel_put(tunnel);
@@ -1124,6 +1130,7 @@ static int tb_dp_dprx_start(struct tb_tunnel *tunnel)
 	tb_domain_get(tunnel->tb);
 
 	tunnel->dprx_started = true;
+	tunnel->dprx_canceled = false;
 	tunnel->dprx_timeout = dprx_timeout_to_ktime(dprx_timeout);
 	queue_delayed_work(tunnel->tb->wq, &tunnel->dprx_work, 0);
 

