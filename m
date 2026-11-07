Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050605;
	b=C7X3WDeAlqnfQnpYixbj/sEwWcp8nxS+2qT66qn7XFRS74hp0WfGrjKFrwFRKJ8quuvQ
	 vUzruGpp+2AblonvMqmLmtrfR7KzF20Cp7GaUir8SVYRvThvpyuIrgGbPqkL92vDdYXsl
	 kxGZrS4CoOu2aW6T/fT3rj1h412yz4WcayCmvKdYnV3RfrdKXEfGuVu6yK6+9cA5azFuE
	 RefAFa0atCGSQGdnbEOT5B0e6M9jkesg4XgHfoPjF11IJjczXJsNVRDXVkd3+X3IqcW42
	 OIIez0vADF81kvlmJfzV3ESIra9djjin6LUIM5yGRAK6A/h2VcqkBmVhJq4XR85A7tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sEOGXMSJnHRT6lb44/aN1IqBmzMHPLhjLL8ZVxsnhdY=;
	b=fbiLQnwUjgZYGpLNtbMo/UnOkIiC2rfao18PJZOW0XGFSc7vAUoiPDp4jYuDi0mZg716
	 +cnBjZgfv5DfDkyO5gPmMECzu+zzQaqJsym3XxKNeEydScF1yWHZeE+XMx9+hYFkMHoBl
	 PrAFqz4QsSev8cgz+TW9w6MiuQeiFnq3rgQtV2vsvQLC9xRwwE7Po6Il+ooe/+BZsTdKN
	 R14HNplLBDPFY4dDR6Tm/rW/mtx/ABO+tUIzaB1lJ75/yca4n6jaUInJYHxvNqO1ons0q
	 3F4Iw9dEzZz1TZukXZzWn8e7uzpeCGxyyiJ/9kazHZ8zN1zC4+aZi6A2zRUE/DECN1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8Io6IoC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8Io6IoC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28AA1F0089F;
	Sat,  7 Nov 2026 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050605;
	bh=sEOGXMSJnHRT6lb44/aN1IqBmzMHPLhjLL8ZVxsnhdY=;
	h=From:To:Cc:Subject:Date;
	b=n8Io6IoCAF5V4kPtAs4WNmPSGBGC8jZe+NTfDBJ5hCb36yGezbt7PRiIr8Tg3IjCd
	 nV3UUInRDC/EFlBWUT+Of5+rcpL4LixSxTItLluVzA68oruH1fH8DZitmAXWiwUlo4
	 tP1T1yDrxpRmJ1nYktSIE+T3xVHcaF3CN+eqk8xNN/DaZDfojJN0/XIPv4+4o2PXg1
	 fGXj7TDUaDdpMz2ZW4+IeCgTQzWgjpnvLEEn33FjPmYzv9Usf7dnWu+TcxhQYhMo4r
	 8eMjhHI5nSjXsmlJk84OIMkfr31jBWwuhvvM7B1MHlPYPYKjgFE2IybDqh5SGIHjo4
	 vRlsyAL38E9vA==
From: Sasha Levin <sashal@kernel.org>
To: oss@fourdim.xyz,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Reject signalling responses in invalid states" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:23:23 -0500
Message-ID: <20261107062323-failed-5.10-6320736af7dc@kernel.org>
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
git cherry-pick -x 6320736af7dcb90da6ee9fd651ecc11c564d45b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062323-failed-5.10-6320736af7dc@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




