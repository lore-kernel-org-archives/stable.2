Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050855;
	b=cEdaac5RSxwKmnELDRCaRfA1Jc5abFqpRPkyJcP5Qk5F7of09MoS4UKrbz2aRTVk6uo4
	 o3Zp7PSAQv77jQdN/LtRdxONUH+2mbE+IwvyjNiyUM38/xjjH3oeIS+6/lWRf/QLTQpEe
	 +MYcTZUDaEqxoJ9xghCU68CZbpuxI9cWD9HHwGb+gztomqXthkTr6mqUGx/DiglU4Ai52
	 nqIUher0RZ9eW+pFUAwz3GnncdLz5fveUp3a+yYM6s8I/331KcdzgC1+5+TDeRzP+HLe9
	 haEowOn04ItnKPZh5IccU1gdSNS2H5+EQW8od2U83dKno07YUIhr0OCoVbvBU1zhSdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LCE6ZjfLuHNNdfWhcUhpFFHqDHZ3ZRZr1aK7kg/Zibo=;
	b=nLawjlA1BQ+KFcTaQ6ri5zeVa/3BU4y7fFAa+naBGLA118KyJoIKtom41WrN0AH2F0Nm
	 vr06AKfU71UE7Qi3tvm70oDt1onhfTko0MxSALLOyjudQ+ccdJP6beHWgkEToZCKNJQ0G
	 672qkZXooJ9JCeAckrzeLPtohj9fbnQ1E2RmZim7aB7Xug1uo5VNm7gNuf6W13kjC45KT
	 EB89pwI37sCo4UqatOxDB5dMwCmgX33HMj9uv6GQk7ZN7J58kJc1TzmDL/i0cFeT32yqs
	 6iRG9/V8AYoo/Eyj8BEIU2fEKpaZaVIyju3A/AWus5H+6UGmNatgkAGwSWaL2jQUcZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcV7QJX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B27606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcV7QJX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090D51F0089F;
	Sat,  7 Nov 2026 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050855;
	bh=LCE6ZjfLuHNNdfWhcUhpFFHqDHZ3ZRZr1aK7kg/Zibo=;
	h=From:To:Cc:Subject:Date;
	b=BcV7QJX9ZQ5Cu6rJroCwW/t9h9gThqFZ7RpC0DU0xnnzq8MCNAs6TeyaeDU7/6udx
	 wFRsJhjyJQ0dfA9rO1c9PR6KV/OeXTa1iiYLxsfu/z94yXPXDibUPScVoSpZAX1aLs
	 S7Ejl6k1pqvCjqQ9TVW9wyRr0QmGRK7KOKRdXBihlWdia65Hzdacd9FVWBcjeLSGxw
	 h8dlzMOa6V7nZ0/a8SCuuz7KP5i7tzsAhFD1Q0+UhZJkoYJqZuGQ3o6BbI71aXq/bR
	 htplq3Bg+E9PSBJKYEr/16URIXiCVWoHz5qY7Wp91eifLGGgjv8+mPCYRazpdPMYRR
	 kNpUtjeJbU16w==
From: Sasha Levin <sashal@kernel.org>
To: qingfang.deng@linux.dev,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pppoe: delete session hash entries by pointer match" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:33 -0500
Message-ID: <20261107062733-failed-5.10-b5b8c81836e2@kernel.org>
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
git cherry-pick -x b5b8c81836e2bec7b444dfa2b14fd14e912e9d63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062733-failed-5.10-b5b8c81836e2@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




