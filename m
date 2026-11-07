Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045891;
	b=V0bpLsIOhotEef3dH+5vBqDVrZVPn/90iOtPc+DbjK1JF9m3FJl4U9gAjreR3oeLvZ9g
	 dtDsrq587wxn+7wo3DM9u41ExRpqDW+pHTQmczRJG5t67eXlQ8rTX4MGlwsMakv++/yhY
	 3w1XBvuyAGDm+MLNaAWT/TgoNHGVRwf6ItyuZAOYsf00QeXGp1IDM698Gi1CDAJAjkrMP
	 oM+rhJ5qc/2f90XVVeMBqNhjwK2adkllnFslthe3vH+7eVXBkB6pQXAK3BpQe+0vrnR94
	 x3gTAcfLmsBEGB5gWHDzIdKFYpkRiIzSM+JK/amdbUVh3TBV6CJt94q/Ztdpbu+WcaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045891;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yOCv30S+tH6j0ZoosZ57dfwo0OpldydsakI0PvLYQx4=;
	b=SqMW5ZiFWn4IuCeE/agOLN2Oke2UnvKdeOnsZRLYykM4q4rJR79nx4kfai4hLki4/x/l
	 VLDTAe1pnR1pJGxDbtWTwz4V7ZAF/Ce9lDfFde22wsMW+mt7N+x6wnPLeUpfXUPn60pWn
	 WK4wCwmGdWsPJWDrhIuB3VTxl2s/0an5iorX9/ezzu+aixwLG12UAnLH3Ay4L3zhdIFg4
	 u2SKmrUV9FVE5eWvWXSAz8G8kzAgfuEaiNEOgFmgDbx6R2aucQ52KQ+wMD+PtgOVHYG+d
	 HDciTrlfmOnjp+bQuE1vlqvFlnPnTZe3XtQQ5BV+Sz+haIem3oYAE9UeK+LHjeShPUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZgG1loN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C513606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZgG1loN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F7C1F0089F;
	Sat,  7 Nov 2026 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045891;
	bh=yOCv30S+tH6j0ZoosZ57dfwo0OpldydsakI0PvLYQx4=;
	h=From:To:Cc:Subject:Date;
	b=FZgG1loNpDguCWf1J3uyQLyxuLPoxbWVmi3lUYOUwoV6mUzZaBTWIpCWQMcnZHhX7
	 ESBlEFin8K5kgb3/mBLbHjnFkLemPKdIjE4rB1B3rChM8kl1TvuiPbkhPvfQ9w/pwm
	 z+RSjQnwZ34O2bYmYq4stiOnVl+aXkA1P8j5zQdDB0a5ypFeEuXgbVH7CMSaNst00Y
	 CmkN57eA1iTDGDrGoAyBJcHFvjAyHg/IRg716U11wBT1YMSsrS9FguBcmOaWDVD/Z9
	 b/yl+nWJkxUfPfbC6aq1SkiaKc1EtAmVSUg6OjiNzb0ZuBryvS/eIz//FUl/rYH7Ea
	 hrP3ZHt0b9ouA==
From: Sasha Levin <sashal@kernel.org>
To: oss@fourdim.xyz,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Only accept connection responses to outstanding requests" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:49 -0500
Message-ID: <20261107050449-failed-7.3-a518b9a9ef6e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050449-failed-7.3-a518b9a9ef6e@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 Mon Sep 17 00:00:00 2001
From: Siwei Zhang <oss@fourdim.xyz>
Date: Tue, 13 Oct 2026 11:36:37 -0400
Subject: [PATCH] Bluetooth: L2CAP: Only accept connection responses to
 outstanding requests

An outgoing channel waits in BT_CONNECT until security
and the feature mask exchange complete, and only then
sends its connection request. A peer can answer it
before that with a connection response matching our
source CID. The channel then moves to BT_CONFIG,
completes configuration and becomes connected before
security has completed. If security then fails,
l2cap_security_cfm() leaves the connected channel
alone, so it stays up on a link that did not reach
the required security level.

A connection response with a zero source CID is
matched by identifier. Another channel can hold the
same identifier for a response it still has to send,
so the lookup can pick the wrong channel.

Only accept a connection response while our request
is outstanding, and only look at such channels when
matching by identifier.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7ea13c0fad447..210d1507af7ee 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -157,6 +157,29 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return NULL;
 }
 
+/* Our connection request has been sent and is still outstanding */
+static bool l2cap_chan_connect_pending(struct l2cap_chan *chan)
+{
+	return chan->state == BT_CONNECT &&
+	       test_bit(CONF_CONNECT_PEND, &chan->conf_state);
+}
+
+/* Other channels may hold the same ident for a response they still have
+ * to send, so only look at channels waiting for a connection response.
+ */
+static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *conn,
+							    u8 ident)
+	__must_hold(&conn->lock)
+{
+	struct l2cap_chan *c;
+
+	list_for_each_entry(c, &conn->chan_l, list) {
+		if (c->ident == ident && l2cap_chan_connect_pending(c))
+			return c;
+	}
+	return NULL;
+}
+
 static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src,
 						      u8 src_type)
 	__must_hold_shared(&chan_list_lock)
@@ -4446,7 +4469,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		if (!chan)
 			return -EBADSLT;
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EBADSLT;
 	}
@@ -4461,8 +4484,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
-	/* Ignore a late response after the channel has left BT_CONNECT. */
-	if (chan->state != BT_CONNECT)
+	/* Only accept a response to a connection request we sent and that
+	 * is still outstanding. A channel waiting in BT_CONNECT for security
+	 * or the feature mask has not sent one yet.
+	 */
+	if (!l2cap_chan_connect_pending(chan))
 		goto done;
 
 	switch (result) {
-- 
2.53.0




