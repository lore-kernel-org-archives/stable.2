Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F29409280
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179833; cv=none; b=NyLurufkc+D+TlrLaEbCWp3gcO+KX48lqRdis17QpHRZ+kvL2ADofzz+hWjmhrZ5vo/WVXvQhl79ez1lk4SdQEnGth7gQcLBCybfuo+hKimhxjMIsohevWE9iSSspwazLc1cybVzJCHmfGq65QdrV3V0hBZ5ZXQZK83yFxe8x6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179833; c=relaxed/simple;
	bh=vU5Pm5j/kRRP83h0uEZ8fm34t1t9ZA6JsaLkvTmcYuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTuD6uQUOWrAt7Gj9+sIndHqa2rjOJW5n4AgHonn4uDrD+eH6pPWzj3pOLbaDnaqw0FMjzy1d6NSW0onglnzOwvC0Rp2mB4cvW3iJ8sx76kq/5ugIDbBL7zcLSxl4V3ThtHleC94AayC54Ci5sdZh63Uz0/Wld1hpRK44ujqyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Wn99pHxP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Wn99pHxP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so33849375e9.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788179828; x=1788784628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcg00jdxBoVgvjWMidECdjzP3FFCwSJCVtYTTaC2+bg=;
        b=Wn99pHxPlhXCJlkvMLXUCSJWukCpDSef0b1okPiHSsfXIdEIAwMOKynyJ3+UpydvHE
         nADaCp0zZ2idTUciid4cE2CxBip2ujUp6JkS32tnXaWlNk7CJwa1q1873dFaiA+sVepn
         nHhXonu4sC0MR5wBVGckTvxeM7gD7Pmx6WbXzsB5Ah7CBftRR7QdWcElQUcfr+bwRc/x
         +xamQ+Fce/6WQTgrr85yGgQrz/VRq01E2YdR7F1ATzchT2wTfeNl2r8/aenfvquNBaw4
         MCFoAiy6M2lWzr5yuHoXkngHdQ0zs0qxruercc40lt1c1XjU7k/FnFf6MgoV2abDdC/l
         Zfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179828; x=1788784628;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcg00jdxBoVgvjWMidECdjzP3FFCwSJCVtYTTaC2+bg=;
        b=PDu3WWcMlA2TqOdxWJdrhkCukUDbHa50Tvs00Hnc8pOl1qynxN2csf49ebIYk8Gk4F
         YNeN/90MHHTIQ6MqrS76F4s8d/PPqe/QgDE2u48XCNRJzJSlvitSmehZRULHzKUmuBMB
         pfwcDJD3kuzZ/n4Bgu4R1oCQjd1oSVgEFZaO3CXjXPkfgwbyaAxF1SyTQcZdaBfLeTY7
         pOH+IoaAnHIWBFy8HPFaGHIADzSTVx1PLiDNpLclnuYdP84i7Jk/PorH51y9m7EwblJI
         UDvG4V/KOFDHPdz0fmZRuYbRiHHHcdc4rbsXHJTZH8+FUMqkxNsLtqKA8D/g4zieFhl7
         0wQg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2e6mGc63gkpSL63WU5ElXYJSDUruO8fBaOTGoey4PyW/LaCwp6sFFUz2vz9v1bTUjeO6xcoc=@vger.kernel.org
X-Gm-Message-State: AFuF++kDGJBzPnUl2XWpO7RPzY7fpnKacbKL1sWS+nzX4tdLYNLXJpAB
	lo2ahDkkfObwZazyjSoSZKrYzCAAKNOmLrc+r91keN2Pk1oQKB7QVZWigOaKpxgDAUM=
X-Gm-Gg: AR+sD13J6v8F4HX4aDueJVIcK5Xr6Oo5YTiBmUcBzf+FQFgvpzD5kUg2ii6whZMrXOW
	/O5l0CTt85qjYami6RfADSJ1Fjsv0/PeBJaa8G9lNyS5xPv1JbqTN8tIk2KQZUOKBiUhG57n6Oy
	b2bSBJ1JnAAbRXk3cYaBOtDLRYN9mhzPy3YgnA9nrZV9wN8JlebAqRdcLZ4BHpUVf/5eVNhzK6H
	cEvBORw9TnvqHv308aMrlYespqlO1BoDXoV0PS/iM0EuhcE+zTmauiOst+rTWy81JmFas/b9Ms7
	R/UXLSDQjQaCADCr9cuUsX1UJVm4jCpwC41l4bHTqFSelMveOe3yqJzxbtjJbYojpr5hJak8Bg2
	ggtoI7vI2eDsRJl2R5faTLpFi/TZbB8gBr7Mm85Yncpwma+Kp5HiCet8IgL3HBPqqNkx/3mo3QB
	NcZwhFy+Llxx05RzUYhlpOO1TvkiBnvypLiiE21uK7dUMnsakdMgf5768Cl3yAAFGm2d3OhhJLI
	wVMjiXtRblEt6VMWbw=
X-Received: by 2002:a05:600c:34d2:b0:49c:cbad:1c44 with SMTP id 5b1f17b1804b1-49ccbad1cf1mr290301455e9.6.1788179827630;
        Mon, 31 Aug 2026 05:37:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48436e2af3asm12016571f8f.12.2026.08.31.05.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:37:06 -0700 (PDT)
Message-ID: <e9dfedbf-b49c-436e-b01b-cd9cc02618cc@blackwall.org>
Date: Mon, 31 Aug 2026 15:37:05 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: bridge: mcast: don't truncate the port group
 walk on teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>
References: <20260831111330.199543-1-junvyyang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831111330.199543-1-junvyyang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 14:13, Jun Yang wrote:
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
> Preserving ->next means a walk can now reach a group that an earlier
> iteration already deleted as a side effect. That group is off mp->ports,
> so br_multicast_find_del_pg() would fall through its port scan and hit
> the trailing WARN_ON(1). Skip such groups at the top of that helper: a
> port group is put on port->mglist when it is created and only unlinked
> when it is deleted, so hlist_unhashed() identifies exactly this case.
> 
> Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
> Cc: stable@vger.kernel.org
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v3: skip already-unlinked groups at the top of br_multicast_find_del_pg()
>      instead of in each teardown walk, per Nikolay's suggestion, so the
>      preserved ->next no longer leads to the trailing WARN_ON(1).
> 
> v2: https://lore.kernel.org/netdev/20260826014200.362304-1-littleddfu@gmail.com/
>      Use hlist_del_init_rcu() to preserve ->next, as suggested by Nikolay,
>      instead of restarting the walks.
> 
> v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/
> 
>   net/bridge/br_multicast.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 00aa9b2879d6..ea0a50eb8b77 100644
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
> @@ -835,6 +839,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
>   	struct net_bridge_mdb_entry *mp;
>   	struct net_bridge_port_group *p;
>   
> +	/* A teardown walk over port->mglist can reach a group that an earlier
> +	 * iteration already deleted as a side effect. It is off mp->ports by
> +	 * now, so skip it instead of falling through to the WARN_ON() below.
> +	 */
> +	if (hlist_unhashed(&pg->mglist))
> +		return;
> +
>   	mp = br_mdb_ip_get(br, &pg->key.addr);
>   	if (WARN_ON(!mp))
>   		return;


This should be fine, let's also see what sashiko thinks. :)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

