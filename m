Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349340;
	b=rYF/cuHeyp8jFks8A3aBpW696d7IrUzwaPPUg/Ubgg0Z8eiaaWyxxGTv71pRFqXCPwE8
	 Ve+xf0JqQtuNUVErw988g5TPxeMVAqAQh87RT6ZmpYoU2zZYME+dJ4GZzOPlGDGi8UEl1
	 hAOnsNxAHJTbci2NC1bykWY3t2StYzHKRNoNATtshmCMHR5yCvbnE3+WxhINg8nEx079G
	 CwT9bR2W2mTu/+//eS5PLPMNU1R6L7MygH9oaBP6wupeKgEbCgO/ntNH/msxsE7g2M/zv
	 itFFH40bDZINPnGuXBHkGIX9exrEGSamDJyFeVX8HDaOb8lVBjBktYN5SbWBFU5Ne2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349340;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UrHQX0EELLsoDjvSsow8NBdNNHiydiO18vGVLCW2rdY=;
	b=QVJov8PvUHgggEj7aPQccUV2iONZ0JZ6jAq83lkCkNx12oF4uHlrd3ET5ZxMhyQD8LyN
	 7hqiGADAM+3iDkXfoBSmax3E8WkmaUusmgzk3iEzBvB6K9IouI1fJyBNYMIR6iSWfTzRE
	 LX9+LP8FZ+W43f/4Hp8kBFAM8nOtw4+kjKL+916jmHQMVE403FbDSCi7UOs39xHdMyyNT
	 VNC4j+8OUk5YiYNmD63NT0DCy9AvpzYpAbmNkAhGIjRu4icpIncFrd35wAzL/P81N4zHs
	 11Vh8Lppo2lJeKZJiA//SYwKpkTgBqm2+E7+4sQK0HrxtqJ1NO8fhqkHaYbJHHMpEvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H37B+jm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H37B+jm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4297A1F008A2;
	Tue, 10 Nov 2026 22:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349339;
	bh=UrHQX0EELLsoDjvSsow8NBdNNHiydiO18vGVLCW2rdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H37B+jm015LUcO5iN2576ZZBDWW9HRjsIMerlX6J7+ZzXkCjo3oRmwaf/Q6Q2k6uL
	 to1gKPkfD1/jQOh4Cb51wUi0D3jQ1Vhsl5NSNaa4sJfbWBf94qV8sXbrRZ91W/CdNG
	 JxN9IhejmernJivwYTYnsmYW9p4GBI9qerEEh40HXzLZn8QNoTI3/o0FsDFOWL0xui
	 kKKonM8lBcn119zj8mwP3GrQNsHRFX485uSdgphm2HoY2+njyZ0AUi9OVgDj7RI4XD
	 B12//A8M5xqXT1QHzBHv2utIjOFp6fQU+pizKSx2GUFJKhxESL6bDAyhd3kA4N1dRe
	 OBkzg7jmXdefQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Tue, 10 Nov 2026 17:22:18 -0500
Message-ID: <20261110221646.4007568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060634-failed-5.15-a518b9a9ef6e@kernel.org>
References: <20261107060634-failed-5.15-a518b9a9ef6e@kernel.org>
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
[ sashal: adapted locking and cleanup to conn->chan_lock while adding CONF_CONNECT_PEND tracking for legacy AMP requests ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cc49e651907d8..3800449643866 100644
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
@@ -1329,6 +1352,8 @@ static void l2cap_send_create_chan_req(struct l2cap_chan *chan, u8 amp_id)
 
 	chan->ident = l2cap_get_ident(chan->conn);
 
+	set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
 	l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CREATE_CHAN_REQ,
 		       sizeof(req), &req);
 }
@@ -4426,7 +4451,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 			goto unlock;
 		}
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan) {
 			err = -EBADSLT;
 			goto unlock;
@@ -4443,6 +4468,13 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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
@@ -4472,6 +4504,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
-- 
2.53.0

