Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.185.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887721;
	b=l8Qsv80WVfVHeJyGxpInxJojoCHolGPYgLuIteFSCqyDst2JoJI/zKZMlC4299Tw70Bg
	 E/O0+85gh5iXuSJ2WJ18zdLML2FPgtUYgwxf4+lnKicIN023i4zT2UHE8FbQjTnfR3s+u
	 FmpqMkcTY65MUXJFYdgAmR7HENfFWu6dzhqenUlpZLgsJGhJiwPfd3P6x+MM4BNqKtFnn
	 tEj/pP4Cl7RRWM2TbsRID4b16+CUkRiWmK/RZ9BlVL07KF83UGwCnqzCrHtXb3LwBlT7O
	 3FsRYKOIFlnbnNlH5VrEWAcHGhWMNBCMtu017RktRbwK7xMrHy06kORvM9zawE1mXgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887721;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Spamd-Bar;
	bh=7K1EA9md3lO2uzD1+1lDPBcZKKiPZ6B98DYU6Y9hvcY=;
	b=NzRgSb7r3Dqox9pquh0RoLPTkf9kieZ1hDX/3YxWQtNF9HtCnZCH4RlrlGZQMXJ/CfxP
	 W+iQN9vhRClzreFLtLvGDqFqTTl0Dmu1a0tiNOrQlGVcywau8wQmPxRn9Ki1KYmdEBN5I
	 80OPMf8IA10a0lQhXmDV03fwJ0R5x9vuMLJca5h3E9f7F8Kn0mp1FuHs65rhf2EitPB5W
	 ZRjQDZby8vKESFU1FDN4JUZGc19Zk62qKDfIqGmh9IM/f8dmRAJLp0SnVEPmyrbxHE8Lq
	 KyD+30SqnpiuXQOiEpvlGWlxM9jW9rd96FhacM3+D9+1Kicd6ApJv/i/GejeBr9SL4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=badcode.im;
	spf=pass smtp.mailfrom=badcode.im;
	dkim=pass header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=ItsO0zJe;
	arc=none smtp.remote-ip=185.185.58.180
Received: from badcode.im (badcode.im [185.185.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0162606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0162606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badcode.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badcode.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=ItsO0zJe
From: Alexander Ildiyarov <alex@badcode.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=badcode.im; s=dkim;
	t=1793887712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K1EA9md3lO2uzD1+1lDPBcZKKiPZ6B98DYU6Y9hvcY=;
	b=ItsO0zJe6HiOs+ZAHaVa4NlG/pskqE4WYUD98IbuEbh409D+nfMDBVTik16yYjuqU3k3UQ
	IR1+HoGyAFg8xLShlR4ErEsXF32coG81JZAslroEzu/DWuc5yEYl07z26K+Sd3Zp5oCvy5
	YDKktMNasJDTywN3ft791qifqvUKFSODiHLG3etnIeM7e3G7MuOOuhZ3NJFOv+tWidAhvV
	NHLcMhBb6U+W2YXRdVa9TnTwLEF9XONN+pdqKOyZAuVo6uLJdFwMdFp5YBqDi3L8kG3ziD
	HynGhueRbbnopx6eWuwjhznWsQtskozdZ4KV79MVReD5YkZC5/IoIdA9TckpjQ==
Authentication-Results: badcode.im;
	auth=pass smtp.mailfrom=alex@badcode.im
To: alexvancasper@gmail.com
Cc: Alexander Ildiyarov <alex@badcode.im>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] wireguard: account peer and allowedips allocations to memcg
Date: Thu,  5 Nov 2026 17:08:14 +0300
Message-ID: <20261105140815.92841-2-alex@badcode.im>
In-Reply-To: <20261105140815.92841-1-alex@badcode.im>
References: <20261105140815.92841-1-alex@badcode.im>
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
X-Spamd-Bar: --

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

