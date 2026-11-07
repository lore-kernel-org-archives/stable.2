Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050608;
	b=2aRlrRPQin0V2avmCkzDkPK+gzZZ7EGwluG1/JH1aumz4AiykoGJYYYctvmubRbX2/UK
	 uo91DH6QP8mF4lQyDrfXfgR5Eq+QeKJa8Q8idh6i7/7ISczBqlFzHoU67VxEALEp3zKyE
	 J8ZLtW5IGgod1AnTZFOHzkKdvRSd44rcivmnj87GyyrCutVXdbnjA3pDR5VUj8DvvOiAL
	 cGwyQd2kjIwi67LVbO0HHQeh54YE07fjyG5RWCaeGXEsW0KDg1jtznZBrHyqHORe+eLYI
	 OanrPm4f6lhsgm4nzYEy0D1AleL3bfTBFq0h0lGsLzGHc3nEYEiujJ7n0+LaMeaWD0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FLtx3l5nXx88NMSR0uNfU5wGMbgnVqC4RmU3TrFDkxA=;
	b=34lZnWVJ5NLbTHAZIEuYibHXxINwqI9MR2dUvAF1kJVgAWk3TWLs2xXgleJct262QL/V
	 9enVon5/2PPBPU2FByx24ig4SjKQQBByP3C7rkxBDT9AQhm104r/PvDN7SMhpVuJFEklB
	 xi20x7eFPRcB9Yr6Ekul8d5qBuIBXkjDKkMwwSdPomq+VK65HQE5xaEcdZD/FolZxYLSs
	 cNpdCxduV1Qvu/fSyFAsAB5T8pAUNEZZMVfiBE4VyFTv00J3IdY5yyXgBxDmy+Gb0WvT4
	 csYM8gl26RB7s3K3DBxmYZ9xhSMksxbtwKql7CNvqrmLIlOQTe++pg7xqaIK2cGvOgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOcfkJom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOcfkJom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985ED1F0089F;
	Sat,  7 Nov 2026 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050608;
	bh=FLtx3l5nXx88NMSR0uNfU5wGMbgnVqC4RmU3TrFDkxA=;
	h=From:To:Cc:Subject:Date;
	b=nOcfkJom/n9dHmWKuPhXaTSIB9eThaGVrT2wFC/aq/n64jFsgQB2Xu744afTXr1pj
	 TmGYgGdXRfIQozImWGB/Q0G26tyi8oO1gavcxnRj1N6h1PlfFFLxDqk1cD//K1XVZj
	 wMtc+yl6ZgdKAaznZBUPzXWeGC60I2wH64jFPDaMYRuy/7LwUdmL5w71TtijZQIm+4
	 F7pQqeitbFElobI5JkUrYYVZvsQRHxACGe5qoLTtI1/c/9InQ/Ra8q5+ba2I+O6m0f
	 C+b+VwR6n2xZyjEyWlArqW7b4i1rmw7fClqYwgscuAT2+Df94DqNtDEoohSHgrmRwE
	 ZzLVCGX+Ur7DQ==
From: Sasha Levin <sashal@kernel.org>
To: oss@fourdim.xyz,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Only accept connection responses to outstanding requests" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:26 -0500
Message-ID: <20261107062326-failed-5.10-a518b9a9ef6e@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062326-failed-5.10-a518b9a9ef6e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




