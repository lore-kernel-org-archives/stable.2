Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047116;
	b=McqbA5SHMadPki+xwiWG4601/xna5DriGkiCKQ0gU0Tz1hVriFTOv9uLRNXNATfLXxzM
	 Ht1oiF9I+35u8Sg6GcJ848D67v62x/68mhUqp8ZAa99ADNyZnWOsauBmrjXequVbzPhI7
	 ljLGhNo3JDZr+XcIIPZ/XQ3x0pVVfDuK5zkpkBzlBU6Yt7TqmaU3SCyqi80ZLItpjd4Pj
	 IkPtoHGfh7OFZPutN+9sw7CW1/ExB3dsS1YOCr/nHmfg1xXgENLwOkNiDsyKj2lJw/MvT
	 N1oLqxlEBw29k/xPaRARuxKmvlJX6uweyne6szZOMSJ/fHsYPT/akiSGbgon68KlO0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dZ0ee3LwcaMM4lKgHi+DrI5qXXXTNM4gWk7ZIXoeF+U=;
	b=rO2KHoe90d0tKe8+J4jxM1y35/njU/VjmB8spSLWHTsU/PnXzK6g721vMab3mAjntqo0
	 1+NNBVsh7OHg65gaYpBqM/wRpEKvZRrtCgPtFwOzHvfuwiLO7rE7sq5FhtjLuUrxLliX9
	 Ue0WYD4QEnLAJWpP+arpMpQRHg6jMwaASPb6APPJwKjMnHnbRQskuWotVT+kt9O2Xmpy+
	 P+E4GLd2EhnlzrwCzzzrQ+ZGxzdpAtd/AKm7KXkUEv5CIwMqukl5AToodF0LqH8rrnFJj
	 K2vl29TdWJppd0ujLTgwWAPDM7GlcvPPeYZSavYBdVzG32igfHKdclxEIR1bnd4/lrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adFwGAEJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adFwGAEJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9DD1F0089F;
	Sat,  7 Nov 2026 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047115;
	bh=dZ0ee3LwcaMM4lKgHi+DrI5qXXXTNM4gWk7ZIXoeF+U=;
	h=From:To:Cc:Subject:Date;
	b=adFwGAEJN7sdmaam9pedmz3xXpSEC3qa71NHmqrbDOexM/3uL7ncNJJcEGJEh4i8V
	 Gqsvpn2ScwCGyhSj2+A7Ojcsw/gYYL3hkqUiN7CqpACxM/hHF01/rGiwjEfyZngXag
	 c8IQlZTe35XrVmu3+lTj8fI+ZU3fnF4mFnwaruS885pHw6Yrzha1qsEVVna7U1A30i
	 EbtGPkzLIZ1fPJpb+XJwR15G4CAIe3s8fH8Vj1xl2IzXLiBU7X3aDYZOB2gK/+gwg4
	 sCn3OpzWPvqAFg6w0+83D2j/hJQ/xHT+cic3RHFWzbTdVkDMMggFyYrPTR7A8dLnnk
	 nzpttU1oVjPLA==
From: Sasha Levin <sashal@kernel.org>
To: qingfang.deng@linux.dev,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pppoe: delete session hash entries by pointer match" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:14 -0500
Message-ID: <20261107052514-failed-6.12-b5b8c81836e2@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b5b8c81836e2bec7b444dfa2b14fd14e912e9d63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052514-failed-6.12-b5b8c81836e2@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




