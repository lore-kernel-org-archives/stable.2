Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146179;
	b=n775lWW01gUjmIlXpZ0QiCUttqk+31ZG68h847TFr1EsaDsUmiRmaSv7Gf8RkA/1qG0Z
	 cvKutJ3HEHdnJdY7VjS8FEYmD/+wOIJgS7YEGXGfRqE6UEXZy9L4cUJzwCunBSsqC8G5d
	 4XIvA5VkUgnK55R+hRDkKGg1zrPVEtY/c3KrQ2hwvMijokogLz1wPAdxYzSjLecQkHeqp
	 4W9nuZO7C7a+eOrHOJI87Yk75eLeZaHORl0NuZafzGY1kOtp1iBjv9IxTId5jTRNJXu0V
	 U2F/bSPZGFR1XkuCTBPAyT8sZj0oDIjAtYxe1Q1/ldxW+35ul/OblhBF1XvRh+ODBYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146179;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sqtBH0a18GoP5swPUqLodYJqXwzpxujEm07G1oy5Qjg=;
	b=jnZXhMEQX0wuA3tHsNCaOBJmuiJF9BANihWKzY4Qq/crd6eDFz99Sh8FrWTdjVkQx4aQ
	 /+gsm8cQO4O//xKQbTIQYj0CTMFTmZw814nNqEfV3kITr8QAtitkfI6DlTzbqGGAs10+r
	 mw8IlaGTVTYX95b+62lbrRJrPiyuoEuBdKRQBpsd9TbpABelkPzdEPoAVTUYJLgagO9co
	 NqE+ZanFCcNt3Dp1b0ZOx3Da/A5n3X2yuEzYfURWsZmup5FstUDnGrVKgK9TJ8zi2x33u
	 SiYbKrm3nmrZL8CEvMBBrAyfbCZxMX3rqiXHgEEk5vuPWY+RZeNkmBfOtZ9Xmyj+e/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MwxDtmUj;
	arc=none smtp.remote-ip=95.215.58.155
Received: from mta1.migadu.com (out-155.mta1.migadu.com [95.215.58.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045E606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0045E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MwxDtmUj
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0YQTFfo6Zx+bnkQmwhR7F7qwZFMAvWmY7FYm8gNBzfY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794146174; v=1; x=1794750974;
 b=MwxDtmUjXQQ9yh/gx6Urw71F2U/rZWSdRjMOozocxnRQiYCNY4V/a7KB5Co4PISzXjZwxrqA
 emVoGpihW4txZvJ/R2OmOMoKddUu35V7XzSLsI+ColwdlOVI3PPSxdoz79rxspr4DbyqAg8ds+L
 i1oTziYP4RyN72+Li2cIEvLs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1156377d6fda6b04;
	Sun, 08 Nov 2026 13:56:14 +0000
X-Mizu-Trace-ID: 1156377d6fda6b04
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y] pppoe: delete session hash entries by pointer match
Date: Sun,  8 Nov 2026 21:56:09 +0800
Message-Id: <20261108135609.889-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107051334-failed-6.18-b5b8c81836e2@kernel.org>
References: <20261107051334-failed-6.18-b5b8c81836e2@kernel.org>
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

[ Upstream commit b5b8c81836e2bec7b444dfa2b14fd14e912e9d63 ]

pppoe_connect() copies the requested PPPoE address to a socket before
attempting to insert the socket into the session hash table. If the
tuple already exists, __set_item() returns -EALREADY, but the copied
address and ifindex remain set on the failed socket.

Closing that socket then deletes the existing socket's hash entry
through pppoe_release(), preventing it from receiving further session
traffic. An unprivileged process in the same network namespace can
trigger this through a duplicate connection attempt.

To avoid the accidental delete, pass the pppox_sock to __delete_item(),
and unlink only an entry whose pointer matches the requested socket.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Link: https://patch.msgid.link/20261020092118.47416-1-qingfang.deng@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Resolve conflict, and remove const qualifier of pppox_sock to match
  hash_item(). ]
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 7ee63051a161..0bfb048c291a 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -195,18 +195,16 @@ static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
 	return 0;
 }
 
-static void __delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void __delete_item(struct pppoe_net *pn, struct pppox_sock *po)
 {
-	int hash = hash_item(sid, addr);
+	int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
 	struct pppox_sock *ret, __rcu **src;
 
 	ret = rcu_dereference_protected(pn->hash_table[hash], lockdep_is_held(&pn->hash_lock));
 	src = &pn->hash_table[hash];
 
 	while (ret) {
-		if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
-		    ret->pppoe_ifindex == ifindex) {
+		if (ret == po) {
 			struct pppox_sock *next;
 
 			next = rcu_dereference_protected(ret->next,
@@ -256,11 +254,10 @@ static inline struct pppox_sock *__get_item_by_addr(struct net *net,
 	return pppox_sock;
 }
 
-static inline void delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void delete_item(struct pppoe_net *pn, struct pppox_sock *po)
 {
 	spin_lock(&pn->hash_lock);
-	__delete_item(pn, sid, addr, ifindex);
+	__delete_item(pn, po);
 	spin_unlock(&pn->hash_lock);
 }
 
@@ -602,8 +599,7 @@ static int pppoe_release(struct socket *sock)
 	 * protect "po" from concurrent updates
 	 * on pppoe_flush_dev
 	 */
-	delete_item(pn, po->pppoe_pa.sid, po->pppoe_pa.remote,
-		    po->pppoe_ifindex);
+	delete_item(pn, po);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -653,8 +649,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 	if (stage_session(po->pppoe_pa.sid)) {
 		pppox_unbind_sock(sk);
 		pn = pppoe_pernet(sock_net(sk));
-		delete_item(pn, po->pppoe_pa.sid,
-			    po->pppoe_pa.remote, po->pppoe_ifindex);
+		delete_item(pn, po);
 		if (po->pppoe_dev) {
 			dev_put(po->pppoe_dev);
 			po->pppoe_dev = NULL;
@@ -705,8 +700,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 
 		error = ppp_register_net_channel(dev_net(dev), &po->chan);
 		if (error) {
-			delete_item(pn, po->pppoe_pa.sid,
-				    po->pppoe_pa.remote, po->pppoe_ifindex);
+			delete_item(pn, po);
 			goto err_put;
 		}
 
