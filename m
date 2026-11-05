Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.185.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887819;
	b=hekcH/UgnHnygep1H+1mEGKKxVB6H1+GpoILzHkH4XKGtwgsSaafHF4Q6CKcBRneM12C
	 +hldtscLANjosqYZUuBWZjh0Jrf+ZK0s6IyjsnuGJdyrjoGE6MIEeNx9munBu/uJm+Ahj
	 cdA2sR/e80r/zGRwbntF+K7M63HBSJzHO6HNu8UrVh8lvCmP9Encmg2SzN2DnqrARwMiR
	 b/sPFu6R4bKvxqNUquvb+pwzFg2P6KL8P83adbyluoT0PLl1IDouiBX03KJGPRcJl9LNz
	 PD8NhwyXz0t2UoUvZ7gxCXP98EzJ+IUkMjg7UyvXaNBm450AFiFvsdys8ZwK7RCGhcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887819;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Bar;
	bh=7K1EA9md3lO2uzD1+1lDPBcZKKiPZ6B98DYU6Y9hvcY=;
	b=QTfsmtPz0h590tXMMwtklU6Ak4hIXkfOc1uVMFV8ySfYy+1w5nNWVvJqxEvNUFuk0SO1
	 xJix/etSbSBVWwq2tzIKnkt+OXg1a83Q5JNI4tNpo4N6MnmMTOpoE6HtRwFwLaxVkXnvf
	 d0qapV/Oa2ynXrhSlnRUs30oLXNgGUI/YjtY4b4Cv4iRZKRKMjy3CLs+d864e0oUiVhUq
	 1xTbYUE8RcUlMsrNd49fBa06bHOXAo3iIiI1NRi5riD40C6hwR20PQ0SMGApYT33b192F
	 k8wSxthhDeyVF/G4bJQF+yYaje/XZoW8CT1qkse14zxShyC5/ObxjPKY+BcQb04tCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=badcode.im;
	spf=pass smtp.mailfrom=badcode.im;
	dkim=pass header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=qPa5nXrQ;
	arc=none smtp.remote-ip=185.185.58.180
Received: from badcode.im (badcode.im [185.185.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5B606A329;
	Thu,  5 Nov 2026 14:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F5B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badcode.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badcode.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=qPa5nXrQ
From: Alexander Ildiyarov <alex@badcode.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=badcode.im; s=dkim;
	t=1793887816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K1EA9md3lO2uzD1+1lDPBcZKKiPZ6B98DYU6Y9hvcY=;
	b=qPa5nXrQdBtCE3ZbBqpeKXWTis3/ceb67Z0mAcp18PAfO3brNX4P2DDjmvGH/5g13+7Ao9
	aH7mNPmh0iDlpsMH9M2D3xEUzPnvMPZaxZ653o+1ojRk932rBoajykOEYZ9SjijFHS8fVG
	Ngw26zch5Ct+pMP28jrrMS+QrpvulIY3XXa8XkuQAisBcQ85VjLMBHq3E8jxRwLN3IfCss
	edZPV88BRFedFPAaf3dFD8MidwZQZCatY2rmaXeBm4TXeM6EQ0pzZv6moU43SNRhjRBHNK
	Jmoq3YmQE3i4Fn1y/0cp1UyA0ccHTHuK2EqmDSBHy3xvl6cn0phU1fDSzFqoWQ==
Authentication-Results: badcode.im;
	auth=pass smtp.mailfrom=alex@badcode.im
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Alexander Ildiyarov <alex@badcode.im>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] wireguard: account peer and allowedips allocations to memcg
Date: Thu,  5 Nov 2026 17:10:05 +0300
Message-ID: <20261105141006.95083-2-alex@badcode.im>
In-Reply-To: <20261105141006.95083-1-alex@badcode.im>
References: <20261105141006.95083-1-alex@badcode.im>
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
X-Spamd-Bar: -

Peers, allowed IP trie nodes, the per-peer dst_cache and the per-device
hashtables are all allocated in the context of the process that
configures the device over netlink, but none of these allocations are
charged to that process's memory cgroup: the wg_peer and allowedips_node
caches are created without SLAB_ACCOUNT, and the hashtables and
dst_cache use plain GFP_KERNEL.

The amount of memory is bounded only by MAX_PEERS_PER_DEVICE (2^20) per
device, with no limit on the number of devices or on the number of
allowed IPs per peer. Since WG_CMD_SET_DEVICE uses GENL_UNS_ADMIN_PERM,
any user who can create a user and network namespace can do this, and
thereby escape the memory limits of the cgroup it runs in.

For example, a process in a cgroup with memory.max=64M that adds 100000
peers with 20 /128 allowed IPs each grows Slab by ~790 MiB, yet the
cgroup's memory.current stays below 1 MiB and its memory limit is never
hit.

Fix this by creating the two caches with SLAB_ACCOUNT and using
GFP_KERNEL_ACCOUNT for the hashtables and the dst_cache. The keypair
allocations are left alone, as they happen from the handshake worker and
are bounded to three per peer.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Alexander Ildiyarov <alex@badcode.im>
---
 drivers/net/wireguard/allowedips.c | 2 +-
 drivers/net/wireguard/peer.c       | 4 ++--
 drivers/net/wireguard/peerlookup.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 5ece9acad64d..2f2b8a94c8a7 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -411,7 +411,7 @@ struct wg_peer *wg_allowedips_lookup_src(struct allowedips *table,
 
 int __init wg_allowedips_slab_init(void)
 {
-	node_cache = KMEM_CACHE(allowedips_node, 0);
+	node_cache = KMEM_CACHE(allowedips_node, SLAB_ACCOUNT);
 	return node_cache ? 0 : -ENOMEM;
 }
 
diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
index 1cb502a932e0..05b80521c706 100644
--- a/drivers/net/wireguard/peer.c
+++ b/drivers/net/wireguard/peer.c
@@ -33,7 +33,7 @@ struct wg_peer *wg_peer_create(struct wg_device *wg,
 	peer = kmem_cache_zalloc(peer_cache, GFP_KERNEL);
 	if (unlikely(!peer))
 		return ERR_PTR(ret);
-	if (unlikely(dst_cache_init(&peer->endpoint_cache, GFP_KERNEL)))
+	if (unlikely(dst_cache_init(&peer->endpoint_cache, GFP_KERNEL_ACCOUNT)))
 		goto err;
 
 	peer->device = wg;
@@ -229,7 +229,7 @@ void wg_peer_put(struct wg_peer *peer)
 
 int __init wg_peer_init(void)
 {
-	peer_cache = KMEM_CACHE(wg_peer, 0);
+	peer_cache = KMEM_CACHE(wg_peer, SLAB_ACCOUNT);
 	return peer_cache ? 0 : -ENOMEM;
 }
 
diff --git a/drivers/net/wireguard/peerlookup.c b/drivers/net/wireguard/peerlookup.c
index 99651a86ac95..f333e906014a 100644
--- a/drivers/net/wireguard/peerlookup.c
+++ b/drivers/net/wireguard/peerlookup.c
@@ -21,7 +21,7 @@ static struct hlist_head *pubkey_bucket(struct pubkey_hashtable *table,
 
 struct pubkey_hashtable *wg_pubkey_hashtable_alloc(void)
 {
-	struct pubkey_hashtable *table = kvmalloc_obj(*table);
+	struct pubkey_hashtable *table = kvmalloc_obj(*table, GFP_KERNEL_ACCOUNT);
 
 	if (!table)
 		return NULL;
@@ -82,7 +82,7 @@ static struct hlist_head *index_bucket(struct index_hashtable *table,
 
 struct index_hashtable *wg_index_hashtable_alloc(void)
 {
-	struct index_hashtable *table = kvmalloc_obj(*table);
+	struct index_hashtable *table = kvmalloc_obj(*table, GFP_KERNEL_ACCOUNT);
 
 	if (!table)
 		return NULL;
-- 
2.43.0

