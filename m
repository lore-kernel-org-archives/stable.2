Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B331E830;
	Fri,  2 Oct 2026 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974903; cv=none; b=mX7F3Awpq+qqM0W1wvhnLDOIN8XhPzmqXSIn/byCP2qEeFcyFKo9rDJyBTnvcMw66yeQl7DxJcI/mSszDLIx9l62dT9d0cIRSeS/0p4zLCVbHDpyDldxXVuToyu2kQPx/fF0J63vHlIuSWBVbEaH1h+iaytOBAdETiR041oQpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974903; c=relaxed/simple;
	bh=DTnCHGveCZoyv5lMH51mgVw1NzppD4KOedC6oFVEBww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VTFTBzPJSDw99dyFw1AAE+GB8MqmqOzVn9eQ5J4y2f8+HoxokMVnALn7NCFZTF7LewjusfCPKrKXIy5X4fbH4fgScyT1haU4nxPUfHbKHgU0fKjlFcS5HNWdNjQ9p+NJUdrL1zxvQEVBkw3uxRE7zQ7ClxvJ+sa5BJFrS24sGJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=U6fB6auA; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="U6fB6auA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=iVMSjh39IcMJGSdhqEZlpNo3sxCisu+5FOeH42vr4W4=; b=U6fB6auAex9PKdj857nwKrNi7n
	vTp7miyDnQJu4jHqOqxKwQovFk76zz0zjxfQkGfoehLNsg32uGjhOf6NEJBnaCsRNu+lMttAKLETx
	9b4+Mupkr0T4X844D1lOOR2gJcc6JIDt3TOEvVD7yMRqLKHz/+mXjybREp8YJ7M/Fel6+xVMKE9Qa
	EKxGCfmC1CWzx6JJEzl3lrQvgOi979mEz3SVLDCbZHMmHqwAg/fpSQb5KbXD8Bcfufj8wZRXUXitN
	Dt18ulZTj2QHZyNlL++Gk3/5BuaIiVcx/b1Yid+2RDYVfHE0o5ZXh8W4GcZhSzWW/bN5FGeILXZ51
	F4ApIwAw==;
Received: from [151.115.150.205] (port=38464 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xCkNy-00000008zVx-1Dnk;
	Fri, 02 Oct 2026 23:01:38 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tipc: protect received keys from concurrent flush
Date: Fri,  2 Oct 2026 20:59:33 +0000
Message-ID: <20261002205932.1874012-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

tipc_crypto_key_synch() can queue the RX worker again while it is
still using the session key rx->skey. If tipc_crypto_key_flush()
cancels that queued work, it frees that key without waiting for the
running worker. The worker can then read freed memory or free the key
a second time.

Track the worker session key rx->skey under rx->lock and clear it on
flush. Check for a flush under the same lock before attaching or
retrying the key. Let the worker free its own key without touching a
replacement.

Fixes: 1ef6f7c9390f ("tipc: add automatic session key exchange")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---

Changes in v2 to address a review by Sashiko:
* Ensure flush revokes received keys.
* Preserve keys received after a flush.

v1: https://lore.kernel.org/all/20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr/

 net/tipc/crypto.c | 65 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 16f1ed1f6b1b..a315ff3d7f80 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -184,6 +184,7 @@ struct tipc_crypto_stats {
  * @key: the key states
  * @skey_mode: session key's mode
  * @skey: received session key
+ * @skey_in_use: received session key owned by the RX worker
  * @wq: common workqueue on TX crypto
  * @work: delayed work sched for TX/RX
  * @key_distr: key distributing state
@@ -209,6 +210,7 @@ struct tipc_crypto {
 	struct tipc_key key;
 	u8 skey_mode;
 	struct tipc_aead_key *skey;
+	struct tipc_aead_key *skey_in_use;
 	struct workqueue_struct *wq;
 	struct delayed_work work;
 #define KEY_DISTR_SCHED		1
@@ -1136,7 +1138,12 @@ int tipc_crypto_key_init(struct tipc_crypto *c, struct tipc_aead_key *ukey,
 
 	/* Attach it to the crypto */
 	if (likely(!rc)) {
-		rc = tipc_crypto_key_attach(c, aead, 0, master_key);
+		spin_lock_bh(&c->lock);
+		if (ukey == c->skey_in_use && c->skey != ukey)
+			rc = -ECANCELED;
+		else
+			rc = tipc_crypto_key_attach(c, aead, 0, master_key);
+		spin_unlock_bh(&c->lock);
 		if (rc < 0)
 			tipc_aead_free(&aead->rcu);
 	}
@@ -1151,6 +1158,8 @@ int tipc_crypto_key_init(struct tipc_crypto *c, struct tipc_aead_key *ukey,
  * @pos: desired slot in the crypto key array, = 0 if any!
  * @master_key: specify this is a cluster master key
  *
+ * The caller must hold c->lock.
+ *
  * Return: new key id in case of success, otherwise: -EBUSY
  */
 static int tipc_crypto_key_attach(struct tipc_crypto *c,
@@ -1158,20 +1167,19 @@ static int tipc_crypto_key_attach(struct tipc_crypto *c,
 				  bool master_key)
 {
 	struct tipc_key key;
-	int rc = -EBUSY;
 	u8 new_key;
 
-	spin_lock_bh(&c->lock);
+	lockdep_assert_held(&c->lock);
 	key = c->key;
 	if (master_key) {
 		new_key = KEY_MASTER;
 		goto attach;
 	}
 	if (key.active && key.passive)
-		goto exit;
+		return -EBUSY;
 	if (key.pending) {
 		if (tipc_aead_users(c->aead[key.pending]) > 0)
-			goto exit;
+			return -EBUSY;
 		/* if (pos): ok with replacing, will be aligned when needed */
 		/* Replace it */
 		new_key = key.pending;
@@ -1201,11 +1209,7 @@ attach:
 	c->working = 1;
 	c->nokey = 0;
 	c->key_master |= master_key;
-	rc = new_key;
-
-exit:
-	spin_unlock_bh(&c->lock);
-	return rc;
+	return new_key;
 }
 
 void tipc_crypto_key_flush(struct tipc_crypto *c)
@@ -1219,11 +1223,13 @@ void tipc_crypto_key_flush(struct tipc_crypto *c)
 		rx = c;
 		tx = tipc_net(rx->net)->crypto_tx;
 		if (cancel_delayed_work(&rx->work)) {
-			kfree_sensitive(rx->skey);
-			rx->skey = NULL;
 			atomic_xchg(&rx->key_distr, 0);
 			tipc_node_put(rx->node);
 		}
+		/* Leave an in-flight key to its worker, but revoke it now. */
+		if (rx->skey != rx->skey_in_use)
+			kfree_sensitive(rx->skey);
+		rx->skey = NULL;
 		/* RX stopping => decrease TX key users if any */
 		k = atomic_xchg(&rx->peer_rx_active, 0);
 		if (k) {
@@ -1940,10 +1946,13 @@ static void tipc_crypto_rcv_complete(struct net *net, struct tipc_aead *aead,
 		if (tipc_aead_clone(&tmp, aead) < 0)
 			goto rcv;
 		WARN_ON(!refcount_inc_not_zero(&tmp->refcnt));
+		spin_lock_bh(&rx->lock);
 		if (tipc_crypto_key_attach(rx, tmp, ehdr->tx_key, false) < 0) {
+			spin_unlock_bh(&rx->lock);
 			tipc_aead_free(&tmp->rcu);
 			goto rcv;
 		}
+		spin_unlock_bh(&rx->lock);
 		tipc_aead_put(aead);
 		aead = tmp;
 	}
@@ -2381,27 +2390,35 @@ static void tipc_crypto_work_rx(struct work_struct *work)
 	}
 
 	/* Case 2: Attach a pending received session key from peer if any */
+	spin_lock_bh(&rx->lock);
 	if (rx->skey) {
-		rc = tipc_crypto_key_init(rx, rx->skey, rx->skey_mode, false);
-		if (unlikely(rc < 0))
+		rx->skey_in_use = rx->skey;
+		spin_unlock_bh(&rx->lock);
+		rc = tipc_crypto_key_init(rx, rx->skey_in_use,
+					  READ_ONCE(rx->skey_mode), false);
+		if (unlikely(rc < 0 && rc != -ECANCELED))
 			pr_warn("%s: unable to attach received skey, err %d\n",
 				rx->name, rc);
-		switch (rc) {
-		case -EBUSY:
-		case -ENOMEM:
+		if (rc != -EBUSY && rc != -ENOMEM)
+			synchronize_rcu();
+		spin_lock_bh(&rx->lock);
+		if (rx->skey == rx->skey_in_use &&
+		    (rc == -EBUSY || rc == -ENOMEM)) {
 			/* Resched the key attaching */
 			resched = true;
-			break;
-		default:
-			synchronize_rcu();
-			kfree_sensitive(rx->skey);
-			rx->skey = NULL;
-			break;
+		} else {
+			if (rx->skey == rx->skey_in_use)
+				rx->skey = NULL;
+			kfree_sensitive(rx->skey_in_use);
 		}
+		rx->skey_in_use = NULL;
 	}
 
-	if (resched && queue_delayed_work(tx->wq, &rx->work, delay))
+	if (resched && queue_delayed_work(tx->wq, &rx->work, delay)) {
+		spin_unlock_bh(&rx->lock);
 		return;
+	}
+	spin_unlock_bh(&rx->lock);
 
 	tipc_node_put(rx->node);
 }

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.47.3

