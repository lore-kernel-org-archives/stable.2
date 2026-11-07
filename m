Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047887;
	b=cSEeT1JkOOVBpHGem6wgRwU03GxtXgNI+RPX0BkxmfwmOVFQdlK7TWF4gkEZbXSg0W1w
	 4mO7CNv1IhonMC3RHNLO9SJmgTCEH8f1y+xJrDyKHl7rf6sMqKROn82y+GfUyyrcgbHaG
	 wDWoDcE/NzBjTePCX4Z3JYN9LOjd5fBTeEQyfCvlDET1AAB+6wjdrJCDJzn6/Jv7IX6mO
	 3q1lnaTpzXoZbBWZ151se9ojzCqE9ZQsX0h7Yhsow3yNn//ByhKlWVZCfaoMkNrwGv8/v
	 jCFrT+FvFGE4npgGm9JxNXy+iCTheDQIpgik/bVA5/4Wy/MgyKA3Z740xJqLkrVhj/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047887;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/7JkXGvzV6yWLuln5o1ebvuIjCVYYwKX+DnhDIp1tT8=;
	b=UbmoSUzs8jRbTKTvblpiuHEdqeR6b7JYUqEkl66Fqs92EBM3hdRQAOzqWr/cKdX7WQYE
	 tXwO0nT/k03fuwoU5XWwH942kjwFxUA8fUl4rf+7392NN/k6W+Ujvcwcb64+NM5QBFgVu
	 Wgl5n04LFTVrrbXeaeFQL1qwNbJqpRPYBWTUHYiJZuz8j1WPC6SqqH9QpSuSnpOLwxehT
	 /oVOJ6RSZglh9KO1xHoQAjgoPxyHRSMX9qrL+dyHXuQMCcsu60BZh4DJyJApxjWe/qcN4
	 0CKd8PwM7f6wUe2VgaUpNm9vHIMH20QdVLdSf5zveRyH2fWoD8x6pKm7LZ/B8gQ4Z8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNUwHtP6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64349606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNUwHtP6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33EA1F0089F;
	Sat,  7 Nov 2026 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047887;
	bh=/7JkXGvzV6yWLuln5o1ebvuIjCVYYwKX+DnhDIp1tT8=;
	h=From:To:Cc:Subject:Date;
	b=cNUwHtP6xVCHWeoHtTt9BUM9nODxsvVM+11p9J30YeBGv/UJ/FeDLDL9GI7TPsw81
	 3icO3mv2kvdLED//rqGXz7m2MeblpIBpCREMN6Ft8Jt68rEBpnwncEzlJLsoHzgIIR
	 zBrXmg31N1gkUn8bw5bGMjQLvfG0nj6h0qgw3PbeYF7nWJHKLc0cRtL+OvApSEe272
	 KFwShUKQ1yRbIF5uV2e7ozv6NMKZoG4NBSEQlK+CpT1oc8OYXY0BLHFL5tbS8F7Kvl
	 0UwSeO4TCmOoM6YYsTyhSjiSEGlKQ40vd1EldZqvoC677I1pwANQIqMQ6EaJGhc9zq
	 H3hh7JDHD7Asg==
From: Sasha Levin <sashal@kernel.org>
To: qingfang.deng@linux.dev,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pppoe: delete session hash entries by pointer match" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:05 -0500
Message-ID: <20261107053805-failed-6.6-b5b8c81836e2@kernel.org>
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
git cherry-pick -x b5b8c81836e2bec7b444dfa2b14fd14e912e9d63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053805-failed-6.6-b5b8c81836e2@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




