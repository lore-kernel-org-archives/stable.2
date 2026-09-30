Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F34C4F54;
	Wed, 30 Sep 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769498; cv=none; b=H/hYSJd1l6ZNCfdSKFlOGkE/d02jY3cfYCh4cDbhFAc8c3AoDoBTRMtPgOow18S50TsxL6YazGcjhB9/lqmwE0XjrfOIX2AIBOngye3S2AG0m8jRp/Wlt1BEP2CBLn5GUAWAjuYxMcLHRLPbFLegqXKb1ImsjLJ9XQzIhLnyvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769498; c=relaxed/simple;
	bh=/GYVlqh/BLtFSwB+Na9jnR44kecPNLhhfZc2OHI3UfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APgAk7uzQIDa9Z52OXVCBsHFlyicSgw7udzdw4is8KDet9obWQg4nesNQc0dnjJNjQMC7OBaTXH0+EiMZiRYDbzvFXRH5bhThw/CiXP4BWlypH2z9hXEjLSkYiH2mYPmupMn+VI9T4t0imOPWEsf/bY2TSaJcMTu4OvSZEnkCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=MBb/LkPT; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="MBb/LkPT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=AaETdzOchPFTc9odpS3treoP+eVUfbz1VlctESvybfE=; b=MBb/LkPTMkOECQoJh33EuX61Cd
	EZzfuS3L9e7jtSjPy5BR2nIIU4dwRL+e3pCnGXoI+bQM72ad+bTtwV5PtlAqtbKNxq9xM6p4Avqpg
	MukLYLoWgz3QyI27GEQkgXPUmUHoxzm9hQL1oki8ArSmwRG719iA9ecLiLt92U6vxNFu9MRh97dd7
	MuQ0NuM7recJ5DLbKHih11HdUEhwRKGCzpmsDGH+AB42GwS9wZPkjoP+jNf6paIDPGOOwZzf6mocq
	/sjYbRkoswnBCSEv/vM9dEt5EOKYkYgEHoogTdKNTHbLBvqUBJE4U+t/8r8kpdm+ExU9fBWO4G3kF
	ODW5+EGw==;
Received: from [151.115.150.205] (port=60644 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBswt-000000022KL-0gMj;
	Wed, 30 Sep 2026 13:58:08 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: protect received keys from concurrent flush
Date: Wed, 30 Sep 2026 11:57:09 +0000
Message-ID: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

tipc_crypto_key_synch() can queue the RX worker again while it is still
using rx->skey. If tipc_crypto_key_flush() cancels that queued work, it
frees the key without waiting for the running worker. The worker can
then read freed memory or free the key a second time. Racing key
exchange with key flush triggers KASAN:

  [   12.986077] BUG: KASAN: double-free in tipc_crypto_key_flush+0x401/0x530
  [   12.987937] Free of addr ff11000002268080 by task peer/112
  ...
  [   12.991938]  kfree+0x163/0x430
  ...
  [   12.991983]  tipc_crypto_key_flush+0x401/0x530
  ...
  [   12.992152]  tipc_nl_node_flush_key+0x174/0x210

Mark the key as in use under rx->lock and make flush skip it while the
worker is using it. Clear the flag under the same lock when the worker
frees the key or leaves it for retry. Keep rx->skey set so the receive
path cannot replace it during AEAD setup.

Fixes: 1ef6f7c9390f ("tipc: add automatic session key exchange")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/tipc/crypto.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 16f1ed1f6b1b..6eb9de458902 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -184,6 +184,7 @@ struct tipc_crypto_stats {
  * @key: the key states
  * @skey_mode: session key's mode
  * @skey: received session key
+ * @skey_in_use: received session key is owned by the RX worker
  * @wq: common workqueue on TX crypto
  * @work: delayed work sched for TX/RX
  * @key_distr: key distributing state
@@ -208,6 +209,7 @@ struct tipc_crypto {
 	u16 key_gen;
 	struct tipc_key key;
 	u8 skey_mode;
+	bool skey_in_use;
 	struct tipc_aead_key *skey;
 	struct workqueue_struct *wq;
 	struct delayed_work work;
@@ -1219,8 +1221,11 @@ void tipc_crypto_key_flush(struct tipc_crypto *c)
 		rx = c;
 		tx = tipc_net(rx->net)->crypto_tx;
 		if (cancel_delayed_work(&rx->work)) {
-			kfree_sensitive(rx->skey);
-			rx->skey = NULL;
+			/* A previous invocation may still be using the key. */
+			if (!rx->skey_in_use) {
+				kfree_sensitive(rx->skey);
+				rx->skey = NULL;
+			}
 			atomic_xchg(&rx->key_distr, 0);
 			tipc_node_put(rx->node);
 		}
@@ -2381,7 +2386,10 @@ static void tipc_crypto_work_rx(struct work_struct *work)
 	}
 
 	/* Case 2: Attach a pending received session key from peer if any */
+	spin_lock_bh(&rx->lock);
 	if (rx->skey) {
+		rx->skey_in_use = true;
+		spin_unlock_bh(&rx->lock);
 		rc = tipc_crypto_key_init(rx, rx->skey, rx->skey_mode, false);
 		if (unlikely(rc < 0))
 			pr_warn("%s: unable to attach received skey, err %d\n",
@@ -2391,14 +2399,18 @@ static void tipc_crypto_work_rx(struct work_struct *work)
 		case -ENOMEM:
 			/* Resched the key attaching */
 			resched = true;
+			spin_lock_bh(&rx->lock);
 			break;
 		default:
 			synchronize_rcu();
+			spin_lock_bh(&rx->lock);
 			kfree_sensitive(rx->skey);
 			rx->skey = NULL;
 			break;
 		}
+		rx->skey_in_use = false;
 	}
+	spin_unlock_bh(&rx->lock);
 
 	if (resched && queue_delayed_work(tx->wq, &rx->work, delay))
 		return;
-- 
2.47.3

