Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048568;
	b=JMbvughMQO7cpqkzxVE4405ACRmQMwQTdE/7la1Wo8NXhzyHxLAOdO8o4APv0lnN2KuU
	 DqmJOGqvzEPZ+ScfALxVzEiDRRPuez8GMpkY+iyrmYoAbHaZ1JHXfgNJS80lCl4njyo91
	 aha0UW7iV/FkXvjp47My6eP/tSZ/GGhSFT3zNAkinSwB6BPIK7z2zirQp/YrQRuYZ2QpN
	 i5jF+jYxCSEQSDrbuaJigas6wfmTXgYbiC3S7fgxW4JjSZtWdECmz9uXzyVdJlfuBcU0P
	 W4wL0YJF06FBHGVwaHGtLxG0dfM78t0MgXm0vWggEG4mGWy2bUW1BdO7KhuUEHqWrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ijl3zu7xg9LbsfUrPMsTfmjJYbclcEsBY9brEacfNns=;
	b=VJlZYXxsBHqMV3Ti0ZhHHcjY5N/ak3r7o5kQj6Ml5VtigmTflRDRRpVNnHIllmJUycff
	 sf3AxIYQgOzcJCUYqi165bSFREc2zlzf84CCkp9GQFMdg/ZfvYjCNWNxM3k26Kv82LQdg
	 wkqNe6sfHHREJqTYR96WJip8c/SwEo9ZeOdZTs3kUQMTdT/aMzBPRUpVOQ9hVJ6JRJKF9
	 9lrhpmGFCkpOJdwsdeHF0lw+n6nO7YXZwqXD53xdGlebPWzpLxIXxaeFALUcG3g5sFYB8
	 ULiqty+dKhj819jEzW+Wbh5d0DQx22zeTzVlqQecrYVAyd9PIP29vjC8xOv0F49Thtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F73TBTb/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957A60A261B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F73TBTb/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2691F00901;
	Sat,  7 Nov 2026 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048567;
	bh=ijl3zu7xg9LbsfUrPMsTfmjJYbclcEsBY9brEacfNns=;
	h=From:To:Cc:Subject:Date;
	b=F73TBTb/NuZkjPyIDDcalXuqOzSPhvi4JctvxFodtInZiKMpVRQxtwe0bKCZ8j2v9
	 qIG/u4/hz2S/0w0XIVQZabe95aRDwjCokVuhIqRQFv12E50Cc1Ag3Pe6HeopHlHyLO
	 ZoV3A1BdYrHdyFCN0s0iyoBaJ2QkyQuxPZaWT/1p0wvTHR8ldxecGAVPePw2JYJXsY
	 TF2xN5mmXPYh8EGDVPjWYSYWgSX6UqWOJGerxsyVf4w7fh/BFX/iIVuSUxaZeUJHMm
	 Rr+ddSs7ErZygvborj6Wu4M2RFlp/T9WfGxLZqfu3yUWCa2EXLYWCuBWKq0UPKzuUU
	 OnJ4QkaXH9RRw==
From: Sasha Levin <sashal@kernel.org>
To: oss@fourdim.xyz,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Reject signalling responses in invalid states" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:25 -0500
Message-ID: <20261107054925-failed-6.1-6320736af7dc@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6320736af7dcb90da6ee9fd651ecc11c564d45b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054925-failed-6.1-6320736af7dc@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6320736af7dcb90da6ee9fd651ecc11c564d45b7 Mon Sep 17 00:00:00 2001
From: Siwei Zhang <oss@fourdim.xyz>
Date: Tue, 13 Oct 2026 11:36:34 -0400
Subject: [PATCH] Bluetooth: L2CAP: Reject signalling responses in invalid
 states

A peer can send configuration messages while an
incoming channel is in BT_CONNECT2, before the
security or deferred accept gate has completed. A
configuration response can then promote the channel
to BT_CONNECTED. Configuration responses can also
act on channels that are closing, and a late connection
response can move a disconnecting channel back to
BT_CONFIG.

Accept connection responses only while waiting in
BT_CONNECT. Answer configuration requests in
BT_CONNECT2, but defer our own request until
BT_CONFIG so configuration cannot complete before
the gate. Ignore configuration responses outside
BT_CONFIG and BT_CONNECTED, and only complete
configuration in BT_CONFIG.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c730da87734b3..eb55c16760a7e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4442,6 +4442,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4471,6 +4475,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4608,7 +4613,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
+	/* A channel in BT_CONNECT2 has not passed security or userspace
+	 * accept yet. Answer the peer's request, but hold our own until
+	 * the channel reaches BT_CONFIG: the CONNECT2 -> CONFIG sites send
+	 * it. Connected channels may also need to reconfigure.
+	 */
+	if ((chan->state == BT_CONFIG || chan->state == BT_CONNECTED) &&
+	    !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
 		u8 buf[64];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
@@ -4661,6 +4672,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4728,6 +4743,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
+		if (chan->state != BT_CONFIG)
+			goto done;
+
 		if (chan->mode == L2CAP_MODE_ERTM ||
 		    chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
-- 
2.53.0




