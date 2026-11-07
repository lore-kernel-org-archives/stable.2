Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048797;
	b=DPVPdHWMjxqZwVJOaO1XpTCBj3Gx68b7BR3qlGjKdPP5sc0Wp+shmbj96ESDQThYVsHv
	 2QAXkuI6/d7/jcRNBgZ8oy7glFcns1DIgsWmRZUj3KvtJUaGHezdSUjHlDNuUTLGd8o/f
	 8URHz/ofd0GQgCHcN1hrHGOn4LtgdVOgTGSGUAiqO2m1VLTXqQmAEcug4pWC4K1zTa/+C
	 TMh1m1Ux60RiWaj3J3+smrvoS4vZOw6XjgjwLwhWCtaJjbktdS8lDREUPwUKWj++XCQKy
	 SMC54vvoQ2qXTGa8KmfFg0z/fMOz1Gh8Fjs0yMD8sjs7VmHrmdfLahLID/8+xzrc4zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BU3YkqZBtttaKvKCBlvIDsVNphVQHl/Xc/sn3+6Zb1E=;
	b=Nb9pvi6J8KfLjDdXN6WNI8t5zleOexPihMm+eRWet0gKYZzDZj4Rwk3cg1Zm8463hNdA
	 c0LUx/LNncfq2VdC7f15IZzom1fQweHFvklpMLKJprWJP51f3eiV0qXZ0NAnhqIBVard8
	 wQ1mIa2pGcos0n4c4QCUhnlx7d0nxb/29hkOCKmub+MrKVO0nT6mkAUoSOe2SrZhuRFNG
	 dMlIYNMV7tkphgBtDbiXQJb7/6SoDLbFb74Sz3eKEa7B5AC1THhbdLEf/hRTr9WSOLzfd
	 M9FTrL5+dBtkh43WWDmBKC55eA3PsoNIkYu/jrr85/+pkNmXvu9fJ2hl6Cb8zgb8qug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBniBQk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544E606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBniBQk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04FB1F008A1;
	Sat,  7 Nov 2026 10:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048797;
	bh=BU3YkqZBtttaKvKCBlvIDsVNphVQHl/Xc/sn3+6Zb1E=;
	h=From:To:Cc:Subject:Date;
	b=JBniBQk0Y1OKHL+wbVGe1Vx71TV9G8uxud0JROvEQlicHT1MLvjcLgVGO77BmqW9Y
	 PJKVinIXQWe+LL3Zhm2BTLwn45ITWe5CPQ7Q4aq94e26VyQkDgYypcs9UGI7kDq2iv
	 V0JCZvIwBIldBiauqYSSr9ZXzDo6fsOwq6RMhPC6IBKJ6bAEwN9hEPBkbDaANd7JO8
	 P655Vg0OIpicPrRbNDfQPwR2LYSrut3xQ+eM+2zTnrjQUJEbdeH3Bb9VuiB9v5VAqm
	 BwQdyX+4DI6fZERBzB+qEntr32KriR1KXA1PXTpk8H3gZSV0wasPJkqikWip8LekOd
	 TwRCiYaZE57ZA==
From: Sasha Levin <sashal@kernel.org>
To: qingfang.deng@linux.dev,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pppoe: delete session hash entries by pointer match" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:15 -0500
Message-ID: <20261107055315-failed-6.1-b5b8c81836e2@kernel.org>
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
git cherry-pick -x b5b8c81836e2bec7b444dfa2b14fd14e912e9d63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055315-failed-6.1-b5b8c81836e2@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b5b8c81836e2bec7b444dfa2b14fd14e912e9d63 Mon Sep 17 00:00:00 2001
From: Qingfang Deng <qingfang.deng@linux.dev>
Date: Tue, 20 Oct 2026 17:21:11 +0800
Subject: [PATCH] pppoe: delete session hash entries by pointer match

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
---
 drivers/net/ppp/pppoe.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index bf7414b46a260..ee0e318d6a2a4 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -194,18 +194,16 @@ static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
 	return 0;
 }
 
-static void __delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void __delete_item(struct pppoe_net *pn, const struct pppox_sock *po)
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
@@ -236,11 +234,10 @@ static inline struct pppox_sock *get_item(struct pppoe_net *pn, __be16 sid,
 	return po;
 }
 
-static inline void delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void delete_item(struct pppoe_net *pn, const struct pppox_sock *po)
 {
 	spin_lock(&pn->hash_lock);
-	__delete_item(pn, sid, addr, ifindex);
+	__delete_item(pn, po);
 	spin_unlock(&pn->hash_lock);
 }
 
@@ -570,8 +567,7 @@ static int pppoe_release(struct socket *sock)
 	 * protect "po" from concurrent updates
 	 * on pppoe_flush_dev
 	 */
-	delete_item(pn, po->pppoe_pa.sid, po->pppoe_pa.remote,
-		    po->pppoe_ifindex);
+	delete_item(pn, po);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -621,8 +617,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 	if (stage_session(po->pppoe_pa.sid)) {
 		pppox_unbind_sock(sk);
 		pn = pppoe_pernet(sock_net(sk));
-		delete_item(pn, po->pppoe_pa.sid,
-			    po->pppoe_pa.remote, po->pppoe_ifindex);
+		delete_item(pn, po);
 		if (po->pppoe_dev) {
 			dev_put(po->pppoe_dev);
 			po->pppoe_dev = NULL;
@@ -672,8 +667,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 
 		error = ppp_register_net_channel(dev_net(dev), &po->chan);
 		if (error) {
-			delete_item(pn, po->pppoe_pa.sid,
-				    po->pppoe_pa.remote, po->pppoe_ifindex);
+			delete_item(pn, po);
 			goto err_put;
 		}
 
-- 
2.53.0




