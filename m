Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E430566F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541194; cv=none; b=K08ePmXr1kvA3nNKe07PUuOHyMNj0ztL46bEmTtZATRWhcmTMKdQHZZB6qPzFH9Cv9SuA2i1pFiaVWgC8Sqb1uWJjA34A3k1mQG4n5Y8/kukSU3yeaNEMzh12jZxR7Zn2lUIq7R99I5sFJyZr4XH0bGj61+yst7OwfHzHamkph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541194; c=relaxed/simple;
	bh=VCI47UWXScE+i5fsxMVrTKHL/edH8t/ufTpbYrSlnqU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fxaR5nDtKvsrwMrxeSHuQuNuskFNUJ3StXVkx92vtDBjhYvjc20ulznTN1MlklOMEPdBgzWmfVVcS42tfqFm09Ixz3UsmiqoL8DrKRoefVdnYVd+rlCdXs2OVVQQju9Xwk5MR4AWWtSaZx9nk8zHS0pOmTzFYIpKwpg4i/sUPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VlgSm8IC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VlgSm8IC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9EB1F00A3A;
	Mon, 20 Jul 2026 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784541193;
	bh=BQA6TUwXHmL5gpbzHAKL1p0FvDdhyzf/RDR8G9WD+vM=;
	h=Subject:To:Cc:From:Date;
	b=VlgSm8IC92lked5DLXPjaIBA8levgqsnDsLD4rZOZ4s39E9+NHb42d0IXLQTpK0IW
	 I3xM5yMqY8hHT2KoU+YhsyQQMDnkS2wU52lTgcSziQcizELDcOfPGOMUhh3Vpnn8AP
	 zG3xzglCvJbsora+XJdPq36UX2SfbbcgAoUOBlXc=
Subject: FAILED: patch "[PATCH] rxrpc: serialize kernel accept preallocation with socket" failed to apply to 5.15-stable tree
To: d4n.for.sec@gmail.com,bird@lzu.edu.cn,dhowells@redhat.com,horms@kernel.org,jaltman@auristor.com,kuba@kernel.org,marc.dionne@auristor.com,n05ec@lzu.edu.cn,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:52:54 +0200
Message-ID: <2026072054-disk-reassign-c317@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x dc175389b18c29a5303ee83169ec653adfae3e17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072054-disk-reassign-c317@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc175389b18c29a5303ee83169ec653adfae3e17 Mon Sep 17 00:00:00 2001
From: Li Daming <d4n.for.sec@gmail.com>
Date: Tue, 9 Jun 2026 15:09:09 +0100
Subject: [PATCH] rxrpc: serialize kernel accept preallocation with socket
 teardown

rxrpc_kernel_charge_accept() reads rx->backlog without any
socket/backlog synchronization and passes that raw pointer into
rxrpc_service_prealloc_one(). A concurrent rxrpc_discard_prealloc()
sets rx->backlog = NULL and frees the backlog rings, so a kernel
preallocation worker can keep using a freed struct rxrpc_backlog
while updating *_backlog_head/tail and array slots.

Serialize the state check and backlog lookup with the socket lock,
and reject kernel preallocation once teardown has disabled
listening or discarded the service backlog.

Fixes: 00e907127e6f ("rxrpc: Preallocate peers, conns and calls for incoming service requests")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Li Daming <d4n.for.sec@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260609140911.838677-6-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index ee2d1319e69a..47824120f1da 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -471,13 +471,26 @@ int rxrpc_kernel_charge_accept(struct socket *sock, rxrpc_notify_rx_t notify_rx,
 			       unsigned long user_call_ID, gfp_t gfp,
 			       unsigned int debug_id)
 {
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	struct rxrpc_backlog *b = rx->backlog;
+	struct rxrpc_backlog *b;
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+	int ret;
 
-	if (sock->sk->sk_state == RXRPC_CLOSE)
-		return -ESHUTDOWN;
+	sk = sock->sk;
+	rx = rxrpc_sk(sk);
 
-	return rxrpc_service_prealloc_one(rx, b, notify_rx, user_call_ID,
-					  gfp, debug_id);
+	lock_sock(sk);
+	if (sk->sk_state != RXRPC_SERVER_LISTENING || !rx->backlog) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	b = rx->backlog;
+	ret = rxrpc_service_prealloc_one(rx, b, notify_rx, user_call_ID,
+					 gfp, debug_id);
+
+out:
+	release_sock(sk);
+	return ret;
 }
 EXPORT_SYMBOL(rxrpc_kernel_charge_accept);

