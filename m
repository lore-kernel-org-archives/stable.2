Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598742;
	b=EP85BWEMM1OH+Na5uiurSuiO6auEoJNniYuB5g9Y1zLrDRYozGmyUqA1fur/myUzEWlB
	 r5cRegLV67ITLtmMInD8c5d1T9UuLyRNUAMBHS3rWJ2df58IjXKyH5LZ7jXlw4Wtm+HQh
	 JoB6RP2UaevWduIZIpy9Ed8/SndOMRztbXiUqGM7jR77VbaWCZ/RuDSlMLSAKuuxfYzRR
	 vNR6asum7WfUWRvsJeFXUw0ayVHhhDjHBvupd9nxNX14ZaA6evcrrMPIPFvC/IX4fvqxW
	 L4rhvcHuVLTrM+odJABRcj0s9etS8BOQSzyEzYr0BZfGrPcvKMAHgRD3hmYf0EVeLyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598742;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1b4dfd5qK2u7BSWYOe8L5RUnwfXOLKKDIRBHWrQEeb0=;
	b=pG81Bidp7EQr8bfWXeJh+8lJ/Ty+azz66wP6ofl/wnq3mPYzPdolKejPva38nbWPIXId
	 lyEex8QzNkBT0Ala3RFZpJNdf5zA1sYTg3usDCM9dBZhyBei7rhH6+P4uAQEllit87jdS
	 Mgt9cRqdenA4vDoPRPd1MR9kDG/dd/iW50thvqnYYtI85KjxPjnGgfenao16vLrjAEl2F
	 5AWvgvhQQQayONZwJYMuZjDD+Ic1KZrWhKfdhCGd2pfF4jFcJF9Of2B2+olJLevW4+rJ+
	 aDMfrM3LnpjJH1pSPTdstOQuYs8VJZ14pMU/hcWREd96qSPEnOM+U2U0SDOW1+2KfAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K2iywP8L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AC606A686
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=K2iywP8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E00C1F000D4;
	Wed, 25 Nov 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598742;
	bh=1b4dfd5qK2u7BSWYOe8L5RUnwfXOLKKDIRBHWrQEeb0=;
	h=Subject:To:Cc:From:Date;
	b=K2iywP8LoLVmOGTng59hi8clylQni5hPZI2XDBLLlk/oU2BNwLgf6KjUUGfgLdr82
	 T9OjiJITJTYt2uiYvEB9UM0MsnJNa+5cEe2fTTH6aky9CO6Sl7qJXhhsc94PxNuhSv
	 GNZwmB2M/eUM1+8kzYWowbbeNur57e4yvCkeEs7k=
Subject: FAILED: patch "[PATCH] Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel" failed to apply to 5.10-stable tree
To: enderaoelyther@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:18:11 +0100
Message-ID: <2026112511-quarterly-collapse-7f08@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1f2ac56137c51be0601e18a163d817e02a15913f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-quarterly-collapse-7f08@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

