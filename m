Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC03DDAF8
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966281; cv=none; b=AHD7K28aZWzrzn72vJxMAyI3uOV01iXnkIE2XHaTjnXHa6aolgm1TfORUeuNi0nxHOdSCbLdzYz7+3hwgbIwN/ZmfOIqWdRqGKhUuSzCHXOWEPSS35SLLBo8YwvyEjjrW9+wOECsy1SwxxrGmPNuDj59BaCbJDq3a07XIT95+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966281; c=relaxed/simple;
	bh=11TQxKHrSMuT+iPYnB/80F5fBxYauviIeyDBqzZcZkk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CkWx5GSyyO1r/ZTkFva+7hy0jOzx+Dwc+W6E16veC82VoTW0NWc1rMm63zPucG0LNgcoiZXFoto45n6a1QGssy91P2IRy7jdiZOy7GUBianM/zBdy82Rd3OuYxfw2RCl5W7lfAvorbkuuJz9MXCLQJpUE4EnAeC+jCCsoLwgPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MNCL3EK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNCL3EK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BFC1F000E9;
	Mon, 17 Aug 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786966280;
	bh=gmgenDsAFgwX4aNdUQZ4l92Wo5czIcIypfMt19qbwB4=;
	h=Subject:To:Cc:From:Date;
	b=MNCL3EK5Sj6Q6B9b2RZn7x/PF2m2dAbwF6tfuBsiZKzJqvMVnvKTvY/f6T2sPrfyO
	 yoJZNV3wQGGAThrbSNB33X0jjcyF3cHAa2AkfZuMoo/PYfD12WoTXP+JH4X+Ua7Hsd
	 PfDG8Zu/l61s21ga5wwB0QKu07vNLm9Mj2Pq95tU=
Subject: FAILED: patch "[PATCH] packet: synchronize pressure clearing with ring" failed to apply to 5.10-stable tree
To: zihanx@nebusec.ai,pabeni@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 13:29:35 +0200
Message-ID: <2026081735-ardently-exemplify-6b2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 1a35da325cac4d5bcad76a2aa943408a6f1d9000
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081735-ardently-exemplify-6b2b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1a35da325cac4d5bcad76a2aa943408a6f1d9000 Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Wed, 29 Jul 2026 09:16:53 +0000
Subject: [PATCH] packet: synchronize pressure clearing with ring
 reconfiguration

packet_set_ring() updates the RX ring state under sk_receive_queue.lock,
but used to publish the tpacket receive mode through po->prot_hook.func
after releasing that lock. packet_poll() and packet_recvmsg() can then
run the pressure clearing path after the ring has been cleared while
still seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference
stale or NULL ring storage.

Move the existing receive hook assignment into the same
sk_receive_queue.lock section as the ring state update. Keep the
assignment otherwise unchanged, including on TX ring reconfiguration, to
avoid adding behavior changes that are not required for the fix.

Serialize packet_recvmsg() pressure clearing with the same queue lock
only after PACKET_SOCK_PRESSURE has been observed. If the flag is clear
and the socket has moved away from tpacket_rcv, packet_set_ring() has
already detached the socket and waited for synchronize_net(), so no new
packet input can set the flag again.

packet_poll() already holds sk_receive_queue.lock, so it uses the new
unlocked helper directly.

Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Link: https://patch.msgid.link/f90b5688311fa278d1361ea8c6be0bf25967d591.1785247446.git.zihanx@nebusec.ai
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 5ae0511e89e3..0e1355be89f6 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1315,13 +1315,25 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
 	return ret;
 }
 
-static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+static void __packet_rcv_try_clear_pressure(struct packet_sock *po)
 {
 	if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
 	    __packet_rcv_has_room(po, NULL) == ROOM_NORMAL)
 		packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false);
 }
 
+static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+{
+	struct sock *sk = &po->sk;
+
+	if (!packet_sock_flag(po, PACKET_SOCK_PRESSURE))
+		return;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	__packet_rcv_try_clear_pressure(po);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 static void packet_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_error_queue);
@@ -4305,7 +4317,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
 			TP_STATUS_KERNEL))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
-	packet_rcv_try_clear_pressure(po);
+	__packet_rcv_try_clear_pressure(po);
 	spin_unlock_bh(&sk->sk_receive_queue.lock);
 	spin_lock_bh(&sk->sk_write_queue.lock);
 	if (po->tx_ring.pg_vec) {
@@ -4545,14 +4557,14 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frame_max = (req->tp_frame_nr - 1);
 		rb->head = 0;
 		rb->frame_size = req->tp_frame_size;
+		po->prot_hook.func = (po->rx_ring.pg_vec) ?
+						tpacket_rcv : packet_rcv;
 		spin_unlock_bh(&rb_queue->lock);
 
 		swap(rb->pg_vec_order, order);
 		swap(rb->pg_vec_len, req->tp_block_nr);
 
 		rb->pg_vec_pages = req->tp_block_size/PAGE_SIZE;
-		po->prot_hook.func = (po->rx_ring.pg_vec) ?
-						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
 		if (atomic_long_read(&po->mapped))
 			pr_err("packet_mmap: vma is busy: %ld\n",

