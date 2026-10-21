Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605745;
	b=4T959s4tlMSuSSmX/81ZGYlg2+CfpLc3dM0211bpogFVm40tqyJZN1WUvOBaUmbS6Ggd
	 VCPd+FlhwuDb34nhiJu6kxoTbRJZR7b3rh/SHbklG6dThIh24dCqKrU+VBrx/K015jY55
	 BO99Hqbiqr3e116Gz0gwFQgaQbtgU5ZwC4HdvI7gnnjJWN7kDJcTh3d7OBJXvP3+G3dga
	 AfJMNvAibA6PyD2kK8pFbjF8J3BRSZD0MIkN+1/rJCfNSfX7VpbUKqap4+pu3jqQFF3vv
	 oboUe0i3ZpAslDOdVi8PVU9Gl72WpOeR7sTJy/KKk7jQLtIqRRvp/SXWDVxaCiHoWPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605745;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UdVle99UHPOnQDVZrlgQuoY8sND5txv3KftTlTX9vcQ=;
	b=RkuEnKOpI9Bzuctm5iyuEsiJB7I6N/+Di9aifBBZF8AxEw+SV12cdrkwGWxhZ3zGB1h4
	 nj0zjzogEHmHTDq4djqORHlO11Du4Lrj0PzIAQbV40lD+uSCVWVAXpp9NwI9DEfoMct5O
	 xq7WlQrUEtjpRhwlVMRaBehHpVTbR+41PXbQjxBvqQ1c0v2IAVVnutqJ8TgCyiVYT+M8r
	 z0zG4SECbmKmjwludIcvV2rR1ZifX4ubKfbRWlBByx8sCspf8shTTG3gtDd6BNCBv8548
	 ziK65zErVxc8gNIm4bSJPdQAq8Vc2mvQ4k/xdNipsXCHzCGTQyN4phjak85goN/5paQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GoHBnTqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB85606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GoHBnTqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734CB1F000C1;
	Wed, 21 Oct 2026 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792605745;
	bh=UdVle99UHPOnQDVZrlgQuoY8sND5txv3KftTlTX9vcQ=;
	h=Subject:To:Cc:From:Date;
	b=GoHBnTqDIzUoDpuELLmGN4rc2K2ry8MPPi9+MLlC4nodJ8TNVjo6iixemBDOKfEDB
	 QBXJVQJCBwRCBgCsXLvajBWx1okLmhseNkjlZBQ3ypLJiXsWIqwJGVXM3qZCpCCeV+
	 AcfBIaaG7p9vpjfYQ8kjxRaetnAFeQGi266bts7s=
Subject: FAILED: patch "[PATCH] vsock/vmci: validate packet source for connected sockets" failed to apply to 6.18-stable tree
To: 4ncienth@gmail.com,kuba@kernel.org,pabeni@redhat.com,sashiko-bot@kernel.org,sgarzare@redhat.com,vishnu.dasa@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 19:56:21 +0200
Message-ID: <2026102121-anymore-operable-f7bb@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ad9a7da3fa39c2d616ec0dd3cf6e30531d032fe7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102121-anymore-operable-f7bb@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad9a7da3fa39c2d616ec0dd3cf6e30531d032fe7 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Wed, 26 Aug 2026 09:39:28 +0900
Subject: [PATCH] vsock/vmci: validate packet source for connected sockets

vmci_transport_recv_stream_cb() looks up sockets first by the full source
and destination tuple, then by destination only in the bound table. The
fallback can select a non-listening socket without checking whether the
packet came from its stored peer.

This was reproduced with two VMCI contexts. A RST from the context not
stored in a TCP_SYN_SENT socket reset that socket after it was selected by
the destination-only lookup.

VMCI can process notification packets in bottom-half context when the
socket is not owned by user context, or defer packets to a workqueue. Use
vsock_check_source() after taking the socket lock in the bottom-half path,
and recheck after lock_sock() in the workqueue path. Listening sockets
continue to accept packets from any source.

Reply with a RST addressed from the received packet before dropping a
source that fails validation. This preserves the existing reset behavior
for bound non-listening and concurrently closed sockets without directing
the reset to a connected socket's stored peer.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Vishnu Dasa <vishnu.dasa@broadcom.com>
Link: https://patch.msgid.link/20260826003929.966160-3-4ncienth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1c4ee039c166..1f186e8f8364 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -680,11 +680,13 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
 	bool bh_process_pkt;
+	bool drop_pkt;
 	int err;
 
 	sk = NULL;
 	err = VMCI_SUCCESS;
 	bh_process_pkt = false;
+	drop_pkt = false;
 
 	/* Ignore incoming packets from resources that aren't vsock
 	 * implementations.
@@ -765,17 +767,29 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	bh_lock_sock(sk);
 
 	if (!sock_owned_by_user(sk)) {
-		/* The local context ID may be out of date, update it. */
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		if (sk->sk_state != TCP_LISTEN &&
+		    !vsock_check_source(vsk, &vmci_transport, &src)) {
+			drop_pkt = true;
+			err = VMCI_ERROR_NO_ACCESS;
+		} else {
+			/* The local context ID may be out of date, update it. */
+			vsk->local_addr.svm_cid = dst.svm_cid;
 
-		if (sk->sk_state == TCP_ESTABLISHED)
-			vmci_trans(vsk)->notify_ops->handle_notify_pkt(
-					sk, pkt, true, &dst, &src,
-					&bh_process_pkt);
+			if (sk->sk_state == TCP_ESTABLISHED)
+				vmci_trans(vsk)->notify_ops->handle_notify_pkt(sk, pkt, true,
+									       &dst, &src,
+									       &bh_process_pkt);
+		}
 	}
 
 	bh_unlock_sock(sk);
 
+	if (drop_pkt) {
+		if (vmci_transport_send_reset_bh(&dst, &src, pkt) < 0)
+			pr_err("unable to send reset\n");
+		goto out;
+	}
+
 	if (!bh_process_pkt) {
 		struct vmci_transport_recv_pkt_info *recv_pkt_info;
 
@@ -900,6 +914,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 {
 	struct vmci_transport_recv_pkt_info *recv_pkt_info;
 	struct vmci_transport_packet *pkt;
+	struct sockaddr_vm src;
 	struct sock *sk;
 
 	recv_pkt_info =
@@ -908,6 +923,12 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 	pkt = &recv_pkt_info->pkt;
 
 	lock_sock(sk);
+	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
+	if (sk->sk_state != TCP_LISTEN &&
+	    !vsock_check_source(vsock_sk(sk), &vmci_transport, &src)) {
+		vmci_transport_reply_reset(pkt);
+		goto out;
+	}
 
 	/* The local context ID may be out of date. */
 	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;
@@ -937,6 +958,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	release_sock(sk);
 	kfree(recv_pkt_info);
 	/* Release reference obtained in the stream callback when we fetched

