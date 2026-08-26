Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707FF3B19B6
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730503; cv=none; b=CV2OoDnnz85pYIw6aaU/BuKYCbZYSVQJi9MCY/am4DrYOVQPWoJbZNqzYEpgsYoc5MDc6y5osZn1V2pdFHjKROECJx9pN2f1UkczBNUsJagI9meRVuDFdwqQrc1llGOxuG5N3SFC7qzeYe5caPe1QiMVqkg96R32jXkL5XPv40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730503; c=relaxed/simple;
	bh=WJ0uLwRr9UFmTPVr4jLczI4kM0DG/KFUsDWq0YyLYMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7LVASjqFwouPPB5vn/vk2DRyOUFfbBGSwz8JK1Avg5Xu3OpRBfymI6PKXZAi2JuQUrfY9JfFVX7RaNi7n7q0AqmkXE64hgmC2UOeMmD/yVI9jOROO5ffSRdGvzL6lEpoRreXoafegYABdaqUYRf0DaFWuINH6iRoLITGNp/KFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=W53XkLUh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="W53XkLUh"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c197eaaab00so101844466b.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787730499; x=1788335299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUoJaBU6v8Sez5v2j24ZHioeYX9zgLhvXZSZMCcMA/U=;
        b=W53XkLUhVgMm6LNHHTf86bz0YUT2pfoVLDwqydIDEKqmULuXFf4I1bgtiYkGsKyqOi
         K7GrOrGEPkEq0H2Spb3UBEK1GEuVm1IO+KA4DNgc21UDDlk6JvXHldc8LimEihZQU8Hv
         ibB/mgfP4xldhbGyZGUKSGON+fzyCqv7LSPT760ONbe+bfnHNrnrh12P/Sl0XZLp70YV
         zBkGtS/4K/EcdrWSgyRIef3S4TWqABQtujR0bzUyEIyljvu2BELdOO6gvAjJQTb7WuQQ
         gsnVZzP2AJqEMCIW1KisQQoCTMtIAC2O3SVW20l+PBuoVF1B3faJONtkhUvZy/24tSbH
         g+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787730499; x=1788335299;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUoJaBU6v8Sez5v2j24ZHioeYX9zgLhvXZSZMCcMA/U=;
        b=hhFfENcxZn8nzflILNj9iKjdNpF5fayBqZSXRs5dxmJoGGG/VcB/M74B0+A+696y54
         uc6zYD1eE9rtqVl74Y1tUyNq/5BuezFSm8FVWl6nOCbmpv4PAPq0YIS5MTXLyCrfLLKr
         c35o6NGKjVv1p8ix7NgcDX3Hjn6PP34FoPJMTSRv5iyvKJ+DHH4+p+wXdJAiAWvmSRv9
         xlfbPcpgLWQfGTGld4Vw4tKUBGQHtMmDxWGrleWqRIt2IwTbm8rHwkDUDJQ2K9p34oFB
         dNHNi7IQThivxVWKluc4c7KKMzJjt2Qy9L7U/heJL5CN7IlOjvcRO+e3BJaYA+rI0ERu
         vUAw==
X-Forwarded-Encrypted: i=1; AHgh+RpIM0J9sXPnuBX4kPk4XgPcCDKHGmsIwpSocvwF6TW5ttfL3i3hhFXT7X8Ec+iigH1Z8/5gnY8=@vger.kernel.org
X-Gm-Message-State: AFuF++kYt1LzII7EQ/B8SqFGWWRh7EE/AL3Zwi53PAa95KrvmiqFgNh8
	DoQf+b7GPleEpaU3axY4/sifh58FHU36MPfVik4WJntP0gBqCPU2N1hyWawjjmHywX8=
X-Gm-Gg: AR+sD13i+axpZTUcKzQ+5Pnzgriujuz98SqhI42DKQlCdQKnkLZ0hKVseX7/eP8duUj
	OksHdD3wrFz2OSUa0ii3KxdP6Tvz/Lh7Z+S5fHVbAkAQtkxLymeVwIiOHlifPcZP9AQAnpwiXbu
	b0N6APzKWnoA+tZK8ecMAFJr3648Bw+/JQCaB8/7IbJzkAMXEooqk0t6AjTJsNXfYytiLG4rOqT
	tkszj3eZX5gqNj0SjroG2nOAlq++d3aFFl4JCOui+XscwX4pFMoliQqkF7kzUaW7ApdWdgZSiaS
	05EOezj18biPB1QuViYgc2cAMCbbNNeyEG/NO4zkjxFeYXnnJcKW6Kw56bLqoqY96AwXORkxFjs
	WeFMC7N1B8OcBVU7k4wPmFhA4p8vOT7p5y2OUMYIRqwfmozKK00sVX4AtspDxP006AR6oW0Rc4F
	9lI2kLpF7j2tyQXRY8phCuBD/MSYy5x7i6qjlva486W9v0ZWNx3yqPEV1gteq7me7ukzz7BIlVy
	dE/GXDZXK9nYJfLGf4=
X-Received: by 2002:a17:907:6091:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c250c408972mr651961666b.24.1787730498862;
        Wed, 26 Aug 2026 00:48:18 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d62dfsm338649666b.4.2026.08.26.00.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 00:48:18 -0700 (PDT)
Message-ID: <86b735ff-6996-4ab4-96b2-6853fcc788a7@blackwall.org>
Date: Wed, 26 Aug 2026 10:48:17 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: mcast: don't truncate the port group
 walk on teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>
References: <20260826014200.362304-1-littleddfu@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260826014200.362304-1-littleddfu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2026 04:41, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> __br_multicast_disable_port_ctx() and br_multicast_del_port() walk
> port->mglist with hlist_for_each_entry_safe(). However,
> br_multicast_find_del_pg() can also delete other entries from the same
> list through br_multicast_fwd_src_remove() or __fwd_del_star_excl().
> 
> If such an entry is the iterator's saved next node, hlist_del_init()
> clears its ->next and terminates the walk early. The reproducer triggers
> this in both teardown walks, leaving port groups in the bridge mdb with
> a dangling ->key.port after del_nbp() frees the port:
> 
>    BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
>     __mdb_fill_info+0x1191/0x1320
>     br_mdb_dump+0x594/0xe40
>     rtnl_mdb_dump+0x1cf/0x5d0
> 
> Use hlist_del_init_rcu() to unlink the group while preserving ->next.
> br_multicast_del_pg() and the teardown walks run under
> br->multicast_lock. The GC worker must acquire the same lock before
> detaching the group for destruction, so the node remains alive while
> the walk uses the preserved pointer.
> 
> Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
> Cc: stable@vger.kernel.org
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v2: delete with hlist_del_init_rcu() to preserve ->next for an in-progress
>      teardown walk, per Nikolay's suggestion, instead of restarting the walks.
>      Tested on 7.2-rc7 with KASAN: the original use-after-free is no longer
>      reported.
> 
> v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/
> 
>   net/bridge/br_multicast.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 00aa9b2879d6..8022c7f12169 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
>   	struct hlist_node *tmp;
>   
>   	rcu_assign_pointer(*pp, pg->next);
> -	hlist_del_init(&pg->mglist);
> +	/* Keep ->next (held under multicast_lock, freed later by the GC work):
> +	 * a port->mglist teardown walk may have latched this node as its next,
> +	 * and deleting other groups of the same port must not truncate it.
> +	 */
> +	hlist_del_init_rcu(&pg->mglist);
>   	br_multicast_eht_clean_sets(pg);
>   	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
>   		br_multicast_del_group_src(ent, false);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

