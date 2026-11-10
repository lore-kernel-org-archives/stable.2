Received: from badcode.im (badcode.im [185.185.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12434606A31C;
	Tue, 10 Nov 2026 18:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12434606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badcode.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badcode.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=badcode.im header.i=@badcode.im header.a=rsa-sha256 header.s=dkim header.b=TJsi6xOc
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=badcode.im; s=dkim;
	t=1794333893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFC1/zd3nxHzjRH04sJaqyMgJFbd+VOxt+WEsgK8g+o=;
	b=TJsi6xOcL7o4hwcc+kzuVE5bejYXgRcJ56IqTxiEJnkvpCQEfNnQ+wXZ1INo/lfio0uaxk
	0CjGdfdsqxuDUDBMWcJPaUXpfmBi65HVJLkHu7I4ssBLlDSfMko98bj2pQjxtcrOJJ1/Fj
	mPrOMkD0Of9bJDFCD9W/OnXzz+p6Zs2joWHLgewA1lrkXGuHHSKHkssZuhf41M8SUGceR3
	xmEKgJDBw5U/ZI/c1n/9IeqkbifTD60Dwik7rGV2Dw4j9oEsRJmkb8I6eqaCYJFOe2L/i1
	c8KQdPaMZ1LI+glSD3hv680+D6/YjduxBUb/tkzaKNVyTCV2ifQmBDJ6NkPnEg==
Authentication-Results: badcode.im;
	auth=pass smtp.mailfrom=alex@badcode.im
Date: Tue, 10 Nov 2026 18:04:51 +0000
From: alex@badcode.im
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] wireguard: account peer and allowedips
 allocations to memcg
In-Reply-To: <avNM9dfdW1uULJUf@zx2c4.com>
References: <20261105141006.95083-1-alex@badcode.im>
 <20261105141006.95083-2-alex@badcode.im> <avNM9dfdW1uULJUf@zx2c4.com>
Message-ID: <a979d36bb97608275f9f8884764afd41@badcode.im>
X-Sender: alex@badcode.im
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +

Yes, it is the documented expectation for long-lived objects whose
allocation userspace can trigger. 
Documentation/core-api/memory-allocation.rst
says:

     Untrusted allocations triggered from userspace should be a subject
     of kmem accounting and must have __GFP_ACCOUNT bit set.

Most hardware drivers don't need it because their allocations are sized
by the hardware, not by userspace. Virtual devices configured over
netlink from inside a user namespace are a different case, and the core
stack has been converted for that reason. For example:

     6126891c6d4f ("memcg: enable accounting for IP address and 
routing-related objects")
     c948f51c1654 ("memcg: enable accounting for net_device and Tx/Rx 
queues")
     a89893dd7b08 ("memcg: enable accounting for VLAN group array")
     961c6136359e ("net: enable memcg accounting for veth queues")
     33758c891479 ("memcg: enable accounting for nft objects")

and more recently:

     1beb81947eb4 ("net/sched: account classifier filter allocations to 
memcg")
     b0057c68df71 ("xsk: account ring allocations to memcg")

The fib_trie, ip6_fib and ip6 dst caches are created with SLAB_ACCOUNT,
and the netdev queues and VLAN array use GFP_KERNEL_ACCOUNT. The first
commit describes the same situation as here: a netadmin inside a
container adds many addresses/routes and makes the kernel allocate
unaccounted long-lived memory. WireGuard peers and allowed IPs are the
same kind of object, so they should be charged to the same memcg.

There is no functional change unless a memcg limit is set. Then the
configuring process gets -ENOMEM (or the memcg OOM killer runs) instead
of the allocations silently going past the limit.

Thanks,
Alexander

-------- Исходное сообщение --------
Тема: Re: [PATCH net 1/2] wireguard: account peer and allowedips 
allocations to memcg
Дата: 10.11.2026 16:57
От: "Jason A. Donenfeld" <Jason@zx2c4.com>
Кому: Alexander Ildiyarov <alex@badcode.im>

On Thu, Nov 05, 2026 at 05:10:05PM +0300, Alexander Ildiyarov wrote:
> Peers, allowed IP trie nodes, the per-peer dst_cache and the per-device
> hashtables are all allocated in the context of the process that
> configures the device over netlink, but none of these allocations are
> charged to that process's memory cgroup: the wg_peer and 
> allowedips_node
> caches are created without SLAB_ACCOUNT, and the hashtables and
> dst_cache use plain GFP_KERNEL.
> 
> The amount of memory is bounded only by MAX_PEERS_PER_DEVICE (2^20) per
> device, with no limit on the number of devices or on the number of
> allowed IPs per peer. Since WG_CMD_SET_DEVICE uses GENL_UNS_ADMIN_PERM,
> any user who can create a user and network namespace can do this, and
> thereby escape the memory limits of the cgroup it runs in.
> 
> For example, a process in a cgroup with memory.max=64M that adds 100000
> peers with 20 /128 allowed IPs each grows Slab by ~790 MiB, yet the
> cgroup's memory.current stays below 1 MiB and its memory limit is never
> hit.
> 
> Fix this by creating the two caches with SLAB_ACCOUNT and using
> GFP_KERNEL_ACCOUNT for the hashtables and the dst_cache. The keypair
> allocations are left alone, as they happen from the handshake worker 
> and
> are bounded to three per peer.

I wasn't aware of this trick, I think mostly because most drivers don't
use this. Does any other part of the networking stack do this? Is this a
normal thing?
