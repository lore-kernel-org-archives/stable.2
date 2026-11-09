Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237659;
	b=Ftuhjh02yRus/uiHhD7zO8dOuyKqhdEs/VwlQUoLdHrdTYMl30/VdFCNg3WPT39gH7xL
	 6nxrcA0Saj9CrFuHjLkohgGjb0bt5awZBQlR7BYO/I8bvMLGNJjS49vvYfOt50HEYb7Jv
	 XduozK095y1xmZqu8O6yEnMCAVqH2fHi7hC8Z1RkjX4n1tW0iHqklTsFC3GxhhEEkRVF2
	 LjVmQcRAoOPTzIU/+od6B/JrRuaF2UZhCcMbGbW/lfXxs8vyNjV81ZBE9A422ZAhf9+g8
	 GG/aEX3WnFjNs6o0m8iDfp1Ht/tiPUdlUvn6huy1cwtbv7bZvdJcwG7dLVH2I8u81Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237659;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E1Cvk1qJ5V3Oi3LonWoUJFBXETfVTBe9b0DBMPd/tuo=;
	b=lK432C8qOETuTqeMjBSrJxFN6H8QR8oEsuIV71HRpT6VmImPCrqAXDmYIfFXCHPGArIM
	 01X9KDxmX7QfMh7sVt+pAyioFeHprNW3/zMebj8+puZqucYF6b9AyRJv2Mlpa3Yo9VjQX
	 xOKKGuFU8NbrUzf0xZdj7vhwxH1p2lAFM2er70KTB6e84FGTJsmisC7vgid5tAWj5YgTz
	 WOxlCk0b9kpOwh1arWEPGZ9ZQvcoSOm6w6jG1w9pN4lKwV/7aSZV1jwRzO5YXT3+m/srW
	 V+UuBbEvk7hbBO/pe84FQuhO4gKzeAFxZ5AT+YnPXHSxi55GRoPyCD5tF+a/BQMnbzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExXVTCHI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB496606A31C;
	Mon,  9 Nov 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExXVTCHI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90101F0089F;
	Mon,  9 Nov 2026 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794237658;
	bh=E1Cvk1qJ5V3Oi3LonWoUJFBXETfVTBe9b0DBMPd/tuo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ExXVTCHI4w0CKCk9ZyA/D+XAu71vp3kaL6G60JxLvBhGU1zxCBnULFLOCHU7rnuNq
	 2Bqxv0erTx9yMmvkAKRLiMG1aP1Yvo4/f3vBS81oBclTK42RGaX73swFYbQ/25Ht3E
	 Sixjcy9eWCtjxK29JhY9i0MGvjjvStp6UpBGYlMq6FlWMwCT5ImGNQdsNsVzcxvVdo
	 COU3IxYNxd/5WiTuv3J3HT/qBY16U/LJMwqo87NtW7neT1pqbQ5YeK4XalARS0DoSg
	 qg4aBVnCWeprDd2H52sgbeeaSf4gmRHzc6X+VN9Jzl3ZphfQZN3e1aIyTanP+pcDyC
	 YJ7749Mtqpzwg==
Subject: Re: [PATCH net 1/2] wireguard: account peer and allowedips
 allocations to memcg
From: netdev-bot+sashiko@kernel.org
To: alex@badcode.im
Cc: Jason@zx2c4.com, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 09 Nov 2026 15:20:57 +0000
Message-ID: <179423765728.994134.7015189164688136550@kernel.org>
In-Reply-To: <20261105141006.95083-2-alex@badcode.im>
References: <20261105141006.95083-2-alex@badcode.im>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: every peer still creates uncharged memory and a
  PID.
- [Medium] Incomplete fix: per-device allocations in wg_newlink() are
  still not charged.
- [Medium] The commit leaves noise_keypair allocations uncharged, saying
  they 'happen from the handshake worker and are bounded to three per…

--

wireguard: account peer and allowedips allocations to memcg

This patch creates the wg_peer and allowedips_node slab caches with
SLAB_ACCOUNT. It also switches the per-peer dst_cache and the per-device
pubkey and index hashtables to GFP_KERNEL_ACCOUNT. The goal is to stop a
user with a user and network namespace from escaping its memory cgroup
limit by adding peers over WG_CMD_SET_DEVICE.

> The keypair allocations are left alone, as they happen from the handshake
> worker and are bounded to three per peer.

[Severity: Medium]
Does the per-peer bound make the keypair memory small enough to ignore?

struct noise_keypair embeds a noise_replay_counter with:

    unsigned long backtrack[COUNTER_BITS_TOTAL / BITS_PER_LONG];

COUNTER_BITS_TOTAL is 8192, so that is a 1KB bitmap. The struct ends up
around 1.2KB, which means keypair_create() is served from kmalloc-2k:

drivers/net/wireguard/noise.c:keypair_create() {
	struct noise_keypair *keypair = kzalloc_obj(*keypair);
    ...
}

add_new_keypair() keeps two keypairs in slots per peer, plus any that are
in flight or waiting on RCU. That is about 4KB or more of uncharged memory
per peer. The now-charged wg_peer object plus the per-CPU dst_cache come
to about 2KB.

The configuring user picks every peer public key, so it knows the matching
private keys. A UDP program in the same netns can send valid handshake
initiations for every peer to the listen port. The responder path then
allocates keypairs from the kworker:

wg_packet_handshake_receive_worker()
  wg_packet_send_handshake_response()
    wg_noise_handshake_begin_session()
      keypair_create()

Once the peer count is limited only by charged memory, could the
uncharged keypair memory still reach about 1-2x memory.max?

This runs in a worker, so GFP_KERNEL_ACCOUNT alone would charge root.
Would this need the configuring memcg to be recorded, with
set_active_memcg() used in the handshake path?

> diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
> index 1cb502a932e07..05b80521c7061 100644
> --- a/drivers/net/wireguard/peer.c
> +++ b/drivers/net/wireguard/peer.c
> @@ -33,7 +33,7 @@ struct wg_peer *wg_peer_create(struct wg_device *wg,
>  	peer = kmem_cache_zalloc(peer_cache, GFP_KERNEL);
>  	if (unlikely(!peer))
>  		return ERR_PTR(ret);
> -	if (unlikely(dst_cache_init(&peer->endpoint_cache, GFP_KERNEL)))
> +	if (unlikely(dst_cache_init(&peer->endpoint_cache, GFP_KERNEL_ACCOUNT)))
>  		goto err;
>  
>  	peer->device = wg;

[Severity: High]
The peer slab and dst_cache are now charged. Does each peer still pin a
larger amount of uncharged memory through its NAPI kthread?

wg_newlink() turns on threaded NAPI for every wireguard device:

	netif_threaded_enable(dev);
	ret = register_netdevice(dev);

Later in wg_peer_create(), each peer does:

	netif_napi_add(wg->dev, &peer->napi, wg_packet_rx_poll);

Peers have no napi->config, so napi_get_threaded_config() returns
dev->threaded. That spawns one kthread per peer:

wg_peer_create()
  netif_napi_add()
    netif_napi_add_weight_locked()
      napi_kthread_create()
        kthread_run(napi_threaded_poll, n, "napi/%s-%d", ...)

kthreadd forks the thread. Its task_struct and kernel stack (about
20-30KB) are therefore charged to the root memcg. The PID is also taken
outside the caller's pids cgroup and RLIMIT_NPROC.

Each peer charges only about 2KB for wg_peer plus dst_cache. Could a
cgroup with memory.max=64M still create tens of thousands of peers and pin
hundreds of MiB of uncharged memory? With a larger limit, could this also
use up pid_max for the whole system?

More GFP_KERNEL_ACCOUNT flags would not cover this, because kthreadd does
the allocation. Would this need a per-device or per-user cap on peers or
NAPI threads, or a design that does not spawn a kthread per peer?

The next patch in the series ("wireguard: noise: recheck replay and flood
under write lock on initiation") only changes the replay checks in
noise.c and does not affect this.

[ ... ]

> diff --git a/drivers/net/wireguard/peerlookup.c b/drivers/net/wireguard/peerlookup.c
> index 99651a86ac953..f333e906014ab 100644
> --- a/drivers/net/wireguard/peerlookup.c
> +++ b/drivers/net/wireguard/peerlookup.c

[ ... ]

> @@ -82,7 +82,7 @@ static struct hlist_head *index_bucket(struct index_hashtable *table,
>  
>  struct index_hashtable *wg_index_hashtable_alloc(void)
>  {
> -	struct index_hashtable *table = kvmalloc_obj(*table);
> +	struct index_hashtable *table = kvmalloc_obj(*table, GFP_KERNEL_ACCOUNT);
>  
>  	if (!table)
>  		return NULL;

[Severity: Medium]
The two per-device hashtables are now charged, and the commit message
says the number of devices has no limit. Are the other per-device
allocations in wg_newlink() still uncharged?

wg_newlink() calls wg_packet_queue_init() three times, and each call
does:

drivers/net/wireguard/queueing.c:wg_packet_queue_init() {
    ...
	ret = ptr_ring_init(&queue->ring, len, GFP_KERNEL);
    ...
	queue->worker = wg_packet_percpu_multicore_worker_alloc(function, queue);
    ...
}

ptr_ring_init() ends up in kvmalloc_array() with GFP_KERNEL. On 64-bit
that is 8KB + 8KB + 32KB per device (MAX_QUEUED_PACKETS and
MAX_QUEUED_INCOMING_HANDSHAKES).

The per-CPU worker arrays come from alloc_percpu() without
__GFP_ACCOUNT:

	struct multicore_worker __percpu *worker = alloc_percpu(struct multicore_worker);

wg_newlink() also creates three workqueues. packet_crypt_wq uses
WQ_MEM_RECLAIM, which adds a rescuer kthread forked by kthreadd:

	wg->packet_crypt_wq = alloc_workqueue("wg-crypt-%s",
			WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_PERCPU, 0,
			dev->name);

Could a user with user and net namespaces call RTM_NEWLINK in a loop to
create wireguard devices? That would still allocate per-device memory
that never shows up in memory.current.

Should the ptr_ring and per-CPU worker allocations be charged as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105141006.95083-1-alex%40badcode.im
