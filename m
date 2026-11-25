Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598739;
	b=XkIPSUxhtkanOeUPtdnZKnnGa5/O2jfASwBFdcXT7o3xkQA4ck8VN92KUTuWbqto6neu
	 La97lZOrMdYt9ljteXunc2FhGgCtn6osaqyiB0hS2CnZjYYTuaB1KctEcZ/nt+XkALvLo
	 pSY2X3dawHL+hIPuxnO46kyqrcgI2RHPWqtPkgRrskkeEnoKpMg0rvI2TXDUhMOQ8z01f
	 yGBrtic+7fAsZAwFap6fOT3hW3TQqbejUQKZRbiUrf4rtH1WCB3Dse6flQmPPk9nYKPZM
	 45wpQffpjVcqbvoQ5kFS8DYKZzjrgmyT25g6ESbpSxdcIv3mLOZ/R+xD1PB2ZV8LB9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598739;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o0KpCHqZCeSzmvkmOeYXBx6NgZi2KLv9uek8c1Roo1I=;
	b=2HqjkmONAziYhDK8/gm9lUBSuSqEgPI0jFdV3+xdBDfxfKVzzRmfUIqS9YIY2yoRhT+L
	 ySNdLDS/xUicjExhg1ZOGBNNzgeOx8kzTT5cE8LCXwuyWWK5zWaxoSGQZ/zEtBLBdsbhK
	 ZNenqawsa+xlSM7pJLu864jyh/shq2oofTdZngeWS8mJkTid9r5pwpottCmuT0oQQ+QWq
	 DInQC5ZO2nyzXR2KFAg7IGFHCmUHq/m1OE/48OCgSsJymd/kGaXEFj0S6UyLJyzV1qXmt
	 qk2pyOvnxpq5tg8MWV0CAUrF6cM3TBBZRsa7emBKc94u/wuLmUVr31CrcSnI0nZdOmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GDojAg81;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB99606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GDojAg81
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879161F000CA;
	Wed, 25 Nov 2026 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598739;
	bh=o0KpCHqZCeSzmvkmOeYXBx6NgZi2KLv9uek8c1Roo1I=;
	h=Subject:To:Cc:From:Date;
	b=GDojAg81qFCtTvPOPVq+8+QiyanL6twKoo25A2V7mNLJTkKbMojlFh46Vd92xqIxx
	 kNhgzB8eh+ljH8fV942b7+RFoyNuLQ75hyN0XNj3Y6U+rg1tYnf7r8l74Is/Ofr63T
	 akfu7tSHZUYWZTQ8yw6znhbrYluM5HmqRkTM/nwM=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel" failed to apply to 5.15-stable tree
To: enderaoelyther@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:18:10 +0100
Message-ID: <2026112510-dividers-waged-68f2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1f2ac56137c51be0601e18a163d817e02a15913f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112510-dividers-waged-68f2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f2ac56137c51be0601e18a163d817e02a15913f Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Mon, 9 Nov 2026 21:21:43 +0800
Subject: [PATCH] Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel

Reading buffered ERTM data after ACL link loss can clear local busy and
send a supervisory frame after l2cap_conn_del() has destroyed the HCI
channel, which oopses on a NULL pointer in hci_send_acl(). The socket still
owns its L2CAP channel, so its lifetime does not protect the underlying HCI
channel.

Require BT_CONNECTED before clearing local busy in recvmsg. The socket lock
already held here serializes this check and send with teardown, which
closes the socket before the HCI channel is destroyed. Continue to allow
buffered data to be read after disconnection.

AI assistance was used.

Fixes: 61aa4f5b9f43 ("Bluetooth: Use the transmit state machine for busy state changes")
Cc: stable@vger.kernel.org # needs adjustments for 5.15
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..e5c15c083c1a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1332,7 +1332,8 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
+	if (sk->sk_state == BT_CONNECTED &&
+	    test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 

