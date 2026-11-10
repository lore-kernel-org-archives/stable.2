Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350851;
	b=m/9R8GzuAICqJPb9xV9px0zIIsYh2B8zFG8DST4l+SWpa0B4tkmlovdpUiwRr2e9zCqc
	 FGoHA6ucV71jSwf2k60ZnSSlaoEBro65fZGGOS3oYvNOzgBtX9tlRNAdgrjsBatYwTi4A
	 AAft+dbOaPaklHcm8oXD0aoielbRDeIg1kj4i2QFCV1bN5VzeL6CSb7P+3wGKIfRAqbqN
	 2sf9iohHDZu1LYHjU09ZrtX0ff2qi9tHZnLdkthvTe8XWM8rwXBgWK9sjUGCOh04vV7wt
	 ATf7yK/DVjKlCzDR5HiL7nACpVfQT4gzc9gV/c7ER6APH8e7S1aIHitqKvbGveLDrMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iMsgkDlXltx/+TR6cw2Xj/ZYXteD+Dovm4bDK2Usvn8=;
	b=JB8qKCoH+rv3dfE2B2iZmJt4zsFN3JqROxRRawXDTgON0uzrrZE4haX2MuXUvRbEkz7Y
	 xwtVqecLbwNq7QmYzwVuRIiMIQRPBajON31QZR/Kddt5F+tjIBvI5jXLA65vp7dKVkfy0
	 XZRZae5hGb/ppnYaUtTLZBCFr4ssHXDyMf0MXRk3TaoG3PRG5BNw9GCAZGxgA3mLRt4Te
	 BfJCMC9Bntor2W+zWHHhdI5BVIurKQk++sVS0C7s0LK5+RV3hhYHxqDLi3HUg+DTMi9sb
	 Y1/rOD8rE5cLdVJJCFugnmP4/0YdhOYnDcofpbelNmhMCmedpdKzsd1rkLEKLIQesOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShsSojXg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShsSojXg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931971F0093C;
	Tue, 10 Nov 2026 22:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350851;
	bh=iMsgkDlXltx/+TR6cw2Xj/ZYXteD+Dovm4bDK2Usvn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShsSojXgBV9gZgrfvqE+QT8BK9rBaOMSUM703J3jugiIaxn9A2Kj9mgNoZVTJ4Hfr
	 vUpvg5JnUGROkZwfpApf9CUplH5wR/VhMP0qnyfIaHWH55Sj7AZbROO65/b1Bq8Axi
	 ThKX4Jj4mML+uwor+X/Rrn1hUJORxna3YJim9tbzU6JifHCCwFi7jJOGlZ65b9C6nm
	 s0HSnIrHF9YzEXfzZvp6HNo77UQ4b1p/1XPe9b8fa2zQsOb7+7NWESao6wJMP/+fvs
	 zhd0BAObpXACBGg5zzLiWtIlQO0lE6cArwZKeSGZBDo6Zc07EsNm2p0u38eJG40Yl4
	 KlwKQ8DPrueGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Tue, 10 Nov 2026 17:47:29 -0500
Message-ID: <20261110223554.4048044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062326-failed-5.10-a518b9a9ef6e@kernel.org>
References: <20261107062326-failed-5.10-a518b9a9ef6e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siwei Zhang <oss@fourdim.xyz>

[ Upstream commit a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9 ]

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
[ sashal: adapted the checks to chan_lock-based locking while tracking pending requests in the existing AMP create-channel path ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index de97a746bb38c..564eaa1b3e24a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -185,6 +185,29 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return c;
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
+	__must_hold(&conn->chan_lock)
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
 {
@@ -1355,6 +1378,8 @@ static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 amp_id)
 
 	chan->ident = l2cap_get_ident(chan->conn);
 
+	set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
 	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
 		       sizeof(req), &req);
 }
@@ -4461,7 +4486,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4478,6 +4503,13 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Only accept a response to a connection request we sent and that
+	 * is still outstanding. A channel waiting in BT_CONNECT for security
+	 * or the feature mask has not sent one yet.
+	 */
+	if (!l2cap_chan_connect_pending(chan))
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4507,6 +4539,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
-- 
2.53.0

