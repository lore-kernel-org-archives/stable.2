Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370088;
	b=DNTLWT0a7AG/n+x+iiu+3o7pnZtew0stRReip+xU7sQi128yPoG+CAVLRZIWdEFW3czD
	 8tDffOcBrYdTAFlYPAXoQzNc7VQRJ1uPQOL6zulJco01R4wKA2Vsy7/92cb7TkAWMnqv8
	 o7/2ZtLkbZ84WrsaF9mwt0v9YYHV4DaNKfmufvowPcjcdFpVD0ZNrwC6sHAniGXguZm67
	 A3yukzPOh2wHfWj0Ey4HbMw8VDxWRvWNFY0PMijVwSCEkmdqxkQjFpnoKUTX5lH+iNS6P
	 InFPdEi9W1OccDhXIliDYVrwzMeRlZFBoii3/KmcPFkJ4g0ZBJtNpc3t+8nVq+bx/Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=E00FdPkngk3Z4+CY6OL2kt07v6G7rAIhm8TLVIKRgo4=;
	b=1akEBLF5W9NkBWhK8UZyG8+gOd5iIkTUDtbU3slIY90FflKEx6J4dy/IK6EklfPXD+Nk
	 E+MGRQ+NXRyoMSqoHGYCQhSkgrtS1MU0mMLb9r2agyBTogBUc326u8ev46L92r2PPoPtX
	 xoa6mRm4Whl4w54GciMtZdnH71a7zC9HJ8CWttgOljeSqiBaYB4LKmj723tctl0k6uLiF
	 2Y5B5uyB53VY9Rm96F/gAh8lkyjRE4cGi55AQcrXo9MP9v4fxw45p3HazWG5LvnQTF5Ru
	 vcpeEFKHOI+3jQ0BLSLhvO/00x+Ubq8qLwgxEzXHdeOxnx9NAbnchqp1ApnCWfXDA4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWLQd2fq;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686D606A32A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1686D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWLQd2fq
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac01ff101so308911e0c.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370087; x=1793974887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E00FdPkngk3Z4+CY6OL2kt07v6G7rAIhm8TLVIKRgo4=;
        b=vWLQd2fqqRdj0tJghjKvE8ElecP40p5bn7552qu6aqe3YMlCAVn/KQL4XPskM021cn
         j71FtJbaxZXPll7uv0rxSoHi4SJcSwXROeJf19uEEMh55nexfnBjHGjfAM0Vsi6rz9o1
         38hfHchtdv/iuFst+xG0kmJTr9C1DGxnfgAzZbY0w20tkZ/QCbk/RIsbK8M7wGq9B8g+
         neOamq0Uqnu/OC4j6ymPmnn4dNT4AKNzg09qAgBJJZRnoZJk7WF5Q1iRap1KCdfJeYvt
         29bfhb3+W9YflALjjHEfXQyiiJl3VvgXS9ZGoGLumWdybj+JGBxoVyecBJfE5c2a4NKZ
         WAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370087; x=1793974887;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E00FdPkngk3Z4+CY6OL2kt07v6G7rAIhm8TLVIKRgo4=;
        b=JCaRhJJJjOF+XsWLWe3F2NN5XTBDVEAXpRBIOsK2htJipZChB8IkRwp6xtAtKj/BDV
         iTMDVuhSw/iUDE7mJzI7trljj4zQH2g7AzZzHx7/+QBazGK15B9cznA8zsip84n+y0++
         lUNbDsp9qLCCInbrqEhvSTYX5jr6+j2sgds82RSsKquEQw60Ee7RkUfVToLU7cQa00Bk
         MK5tHn5iDYa/ChPk0U0JN8BaNRPeKoyaD38cVlyiXpL09OiqciLCXK3MtpmgrLB0VujH
         LP+lWSketQpdDfQPxrVxNt2H1mrylotkb+U0+yQaRtkRPhUQ0fp9hu0z7yzIObC9GRr5
         X5PQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSIyk7w4cIHBcC3zdciRTpn/pPnWcC9hIsw3TrGFk0sexb/13SGNX2sxpGuXH7lt6UzN7vT9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmE45F2QKpmMFGflt5YJDiXJvK+gwYL+ZHfo1V/l9s0w+Zqlk8
	ku1sKLv1lRIC3B4bKdOcefvRXPXR5vmSmxJIj/zy2TWIx55csgqPi8O8
X-Gm-Gg: AYBFou3S/XkwFxy1Z7dBlM/Cg/as7SZQPKlyAZZM5bQW4Ixvf044n+Xox3zQo748j99
	iEMjstzAtFhR9LLg+j+OPHefZ1fjuKy+DjFPgOeX1q2+9/oBU/nIgINMFrmZ4NfF4C3ImocqyHh
	TqkmyYKg+1x4/8piz2yiV3Kzyc1aZH+xxwfge5DbLEQPKPbhv1oS/BHLy6MqZNWCSS/ak90prfg
	IoIl+phnP2FvGba6yNdNlibzYMBAcXS+ByNkVgPgGnVcYcxC08qyP5m+gXVwKrIUqEb+TXgn0cM
	nSTMBg2kbktYl3qqKZY2UU1CuxcQu/NFEogA5T1qyBAnwZP735rZ0bwgE4CGgVNnD8x0vvYKwef
	hz3MzbYckwCwzIsnWB40gUE1DwpsG8bMDTjX8PNvBiHhKIfIamErqXWM2Jl/3HSK32eQmlFPutZ
	Ab4YGPA3whtE2UJiwKt4R0suDeYVFY8CHgLPax6LOx9WVzjwtD4YBBO05o6Y9+3L/zco0wLkyAL
	siMCL4Z37gxvcx4MKIcnf27IWwtXOHvkjtxR0Nk8Tyfk1GTghKh+kWbjNftOMzRrs0zrOoThb+S
	spoKGPSsWoaeLoJEY7uGHsw2fhZik9AIjSsdcD7hbr89+zu2oiM9Ycrlc4275ThNK1nzOLjMqbj
	y822ozJO343hA99EpX5wCdIDbLtSocV8lsmUozyeUmNUVHYvtmzyf3vGFd0kFS6pOGeW/
X-Received: by 2002:a05:6122:512:b0:5da:9b81:1aa4 with SMTP id 71dfb90a1353d-5ec6870c946mr1146359e0c.5.1793370086742;
        Fri, 30 Oct 2026 07:21:26 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c99e3csm2476107e0c.15.2026.10.30.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:21:26 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:21:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ahmad AG <ahmadag1001@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Ahmad AG <ahmadag1001@gmail.com>
Message-ID: <willemdebruijn.kernel.2e53c121ad9ea@gmail.com>
In-Reply-To: <20261030100504.23498-1-ahmadag1001@gmail.com>
References: <20261030100504.23498-1-ahmadag1001@gmail.com>
Subject: Re: [PATCH net v2] net/packet: account user-triggered allocations to
 memcg
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ahmad AG wrote:
> A packet socket allocates memory for its user that is not charged to
> the user's memory cgroup:
> 
> - PACKET_RX_RING and PACKET_TX_RING: the ring blocks themselves
>   (alloc_one_pg_vec_page(), both the page allocation and the vmalloc
>   fallback), the block array (alloc_pg_vec()), the deferred-free work
>   of a TX ring, and the rx_owner_map bitmap of a TPACKET_V1/V2 RX ring.
>   The size comes from the tpacket_req passed to setsockopt() and has
>   no limit other than available memory.
> - PACKET_FANOUT: the group created by fanout_add(), about 1 MB per
>   group with max_num_members = 65536 (a 512 KB array, rounded up to an
>   order-8 allocation) since commit 9c661b0b8544 ("net/packet: make
>   packet_fanout.arr size configurable up to 64K"), and the per-socket
>   rollover state.
> - PACKET_ADD_MEMBERSHIP: one struct packet_mclist per distinct entry
>   (packet_mc_add()), with no limit on the number of entries.
> - socket(): the per-CPU TX ring pending counter
>   (packet_alloc_pending()).
> 
> A process with CAP_NET_RAW, which an unprivileged user has in its own
> user and network namespace, can therefore pin kernel memory far beyond
> the memory.max of its cgroup. With memory.max set to 16M, a test
> running as uid 1000 took 525804 KB of system memory with 64 sockets
> each mapping an 8 MB TPACKET_V2 RX ring (1 MB blocks) while
> memory.current grew by 892 KB; 264640 KB with 256 sockets each
> creating a fanout group with max_num_members = 65536 (memory.current
> +512 KB); and 46664 KB with 100 sockets holding 2000 PACKET_MR_PROMISC
> entries each on lo (memory.current +256 KB).
> 
> Allocate all of these with GFP_KERNEL_ACCOUNT, as other allocations a
> user can make on demand in the networking stack already do, for
> example the AF_XDP rings since commit b0057c68df71 ("xsk: account
> ring allocations to memcg"). vzalloc() takes no gfp mask, so the
> vmalloc fallback becomes __vmalloc() with __GFP_ZERO. skbs are bounded by
> sk_rcvbuf and sk_sndbuf and are left as they are, as is the per-packet
> zerocopy state in tpacket_snd(), which lives only as long as its skb.
> struct packet_sock itself comes from sk_alloc(), and the
> netdev_hw_addr entries that PACKET_MR_MULTICAST and PACKET_MR_UNICAST
> add through dev_mc_add() and dev_uc_add() live in net/core; neither
> is changed here.
> 
> With the change each of the three tests in the 16M cgroup is stopped
> by the cgroup's OOM killer. With a higher memory.max the rings charge
> 525436 KB for 524832 KB of system memory used (1G), the fanout groups
> 262656 KB for 265128 KB (1G), and the membership entries 26880 KB
> (1G). These figures are from a KASAN kernel, which inflates the small
> objects; without KASAN the 200000 membership entries are 20480 KB
> charged for 26412 KB used.
> 
> The missing charges were found by code inspection of net/packet/ with
> the help of an LLM and then triggered with a small test program that
> creates the sockets, rings, groups and entries and reads
> memory.current; the numbers above are from that program. Tested in a
> QEMU/KVM guest on this tree (x86_64_defconfig plus kvm_guest.config,
> KASAN, MEMCG, PACKET), running the test as uid 1000 in a cgroup v2
> memory cgroup. tools/testing/selftests/net/psock_fanout, psock_tpacket
> and psock_snd.sh pass before and after.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This predates the introduction of memcg accounting and indeed
much of the code that is being instrumented.

I also don't think this is stable material.

Especially on the actual ring buffers: retroactively enabling
this may break existing users.

Consider net-next. Else, net still needs a Fixes tag. Review how
important each of the conversions is, keep the important ones, find
the oldest one and use that as tag.

> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code
> Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> ---
> v2: cover every user-triggered allocation in net/packet in one patch, as
> Willem suggested on v1, and resend with git send-email; the v1 mail had
> tabs replaced and lines wrapped by the mail client. v1 changed only the
> fanout group allocation.
> v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com/
> 
>  net/packet/af_packet.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 823e0911c91..06386db4c8e 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1233,7 +1233,8 @@ static int packet_alloc_pending(struct packet_sock *po)
>  {
>  	po->rx_ring.pending_refcnt = NULL;
>  
> -	po->tx_ring.pending_refcnt = alloc_percpu(unsigned int);
> +	po->tx_ring.pending_refcnt = alloc_percpu_gfp(unsigned int,
> +						      GFP_KERNEL_ACCOUNT);
>  	if (unlikely(po->tx_ring.pending_refcnt == NULL))
>  		return -ENOBUFS;
>  
> @@ -1735,7 +1736,7 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  	if (type == PACKET_FANOUT_ROLLOVER ||
>  	    (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)) {
>  		err = -ENOMEM;
> -		rollover = kzalloc_obj(*rollover);
> +		rollover = kzalloc_obj(*rollover, GFP_KERNEL_ACCOUNT);

Is it worth accounting even such small ones?

>  		if (!rollover)
>  			goto out;
>  		atomic_long_set(&rollover->num, 0);
> @@ -1778,7 +1779,8 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  			/* legacy PACKET_FANOUT_MAX */
>  			args->max_num_members = 256;
>  		err = -ENOMEM;
> -		match = kvzalloc_flex(*match, arr, args->max_num_members);
> +		match = kvzalloc_flex(*match, arr, args->max_num_members,
> +				      GFP_KERNEL_ACCOUNT);
>  		if (!match)
>  			goto out;
>  		write_pnet(&match->net, sock_net(sk));
> @@ -3773,7 +3775,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
>  		goto done;
>  
>  	err = -ENOBUFS;
> -	i = kmalloc_obj(*i);
> +	i = kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
>  	if (i == NULL)
>  		goto done;
>  
> @@ -4494,7 +4496,7 @@ static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
>  static char *alloc_one_pg_vec_page(unsigned long order)
>  {
>  	char *buffer;
> -	gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
> +	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_COMP |
>  			  __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>  
>  	buffer = (char *) __get_free_pages(gfp_flags, order);
> @@ -4502,7 +4504,8 @@ static char *alloc_one_pg_vec_page(unsigned long order)
>  		return buffer;
>  
>  	/* __get_free_pages failed, fall back to vmalloc */
> -	buffer = vzalloc(array_size((1 << order), PAGE_SIZE));
> +	buffer = __vmalloc(array_size((1 << order), PAGE_SIZE),
> +			   GFP_KERNEL_ACCOUNT | __GFP_ZERO);

Consider adding __GFP_NOWARN here too, similar to the pg_vecs, to avoid
excessive warning when enabling memcg accounting.

>  	if (buffer)
>  		return buffer;
>  
> @@ -4523,7 +4526,8 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
>  	struct pgv *pg_vec;
>  	int i;
>  
> -	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
> +	vec = kzalloc_flex(*vec, pg_vec, block_nr,
> +			   GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>  	if (unlikely(!vec))
>  		return NULL;
>  	vec->order = order;
> @@ -4532,7 +4536,7 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
>  
>  	if (tx_ring) {
>  		vec->deferred = kzalloc_obj(*vec->deferred,
> -					    GFP_KERNEL | __GFP_NOWARN);
> +					    GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>  		if (!vec->deferred)
>  			goto out_free_pgvec;
>  		vec->deferred->vec = vec;
> @@ -4648,7 +4652,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
>  		default:
>  			if (!tx_ring) {
>  				rx_owner_map = bitmap_alloc(req->tp_frame_nr,
> -					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
> +					GFP_KERNEL_ACCOUNT | __GFP_NOWARN | __GFP_ZERO);
>  				if (!rx_owner_map)
>  					goto out_free_pg_vec;
>  			}
> 
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> -- 
> 2.43.0
> 


