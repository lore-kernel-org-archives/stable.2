Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047723;
	b=VE5XWREUamYfz5jY8QiokWjHr5AzZRJFxjZ5isIGMoWM4SK7cIEatf0SVCZVLG5TNGCH
	 97bNIumU53gekhcMyehxnowSV/VjI2mKjYVovEojrRDacuS+NenFRgrn8Bdf78chbcIc4
	 V0Gl0o6D/OLDgNmXkpwtURE+ZJokiXGHs8ZiQItZROlZTV2YoPRvLw+Z91tYdS5jVFREt
	 TUQjYzkM7M82R6JC1jAStatLb7oBmpkEv975QIBo1ZAUG+e6KTyQ7Lv76+Cuz+slYB6o3
	 ipbfqFmbXpgW9two9vpZ+E/QRCKWqsjgcHifrc/6kzSgYyL6SIr+EZdZm6bi+6carQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047723;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qbmmNfqx7kbrMGVBof8bb7+lnQQHM0VuQU94OZcyvG4=;
	b=TsX34LGp+ysJThaE11IifG6WlGZ/Pt76kLdVeiM3p2T9uHu9JRBHQh3Q6C2dy3gEy2Yy
	 ctMbONJSqbwsQ6bKj2W4oDfj437jkbPWATZWGqhWt+k9pPcRKsUV5fTa7A31Ii1Mf9v0y
	 4m8manf4JN0kyUniGML+rRBZrWCtkSsBwyARiPmkFi8Y2GIQW38MuniSLAop2+VannnnK
	 6O7IT8XziGuDVokPBgKA/8anMFul09vUG8k6v59k7PV2lkYir3N8vKf3SsIqUofSti4JM
	 +d7eIsMn37ANPL4j+261KUf7iVuVz8d16Q05UykpKgZQLvGdtC1sTOmrDJOVHt0olyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Iupkiq/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D16606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iupkiq/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA051F0089F;
	Sat,  7 Nov 2026 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047723;
	bh=qbmmNfqx7kbrMGVBof8bb7+lnQQHM0VuQU94OZcyvG4=;
	h=From:To:Cc:Subject:Date;
	b=Iupkiq/ZEAyCmZJExivFannM9FABTXN74D/8OrRpGBrR+KhYvn3QjSTTCu2o9cELC
	 4hoMFyNQ7c0c+gTc/Q/4wx+w5glazH2JL0XeYTDkugB+gWqR+KTB4Jvl93wcHYvEFJ
	 jHgKvHGfY8i7hmq8McjKjGBk41ywD0gwE88CgG4KRY3rWI462P9LsdC7EUsBaA/OHA
	 Db+kkYQxVauTck7zPuH8Lh58C7k1JknzW3ipL21oKxBbaidW5HiuVpWHQUkMdT7SXP
	 OeVoQTx5itgNCGYKBONDUYb7/2+HseS+ugnBTCH+YaPg7ocr+QKrUynZrNFYxQwz7r
	 XCKDp8dy5VGPw==
From: Sasha Levin <sashal@kernel.org>
To: oss@fourdim.xyz,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Only accept connection responses to outstanding requests" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:21 -0500
Message-ID: <20261107053521-failed-6.6-a518b9a9ef6e@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a518b9a9ef6ee3b18ecdf6ba5360c608aaf969e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053521-failed-6.6-a518b9a9ef6e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




