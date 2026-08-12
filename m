Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7013E8695
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537035; cv=none; b=J685XcHwYRsnIG+fVnw7aXxaNPuqg6KDhHy6XbzV+VnDCIYn97Jt4jAoPDlVZAMb4Rxev5xi/qBQ1ITAoxek2LpyLcBJhrm1KhKqqHM6OlXIMIuFfvQ/+hCOVKKmWZWzD5oRlp8cc7TcYiKgTzYMSarqhpEfthOsbCcWwlOMT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537035; c=relaxed/simple;
	bh=6wiDWXMEJCbp5MAnB3iLeOvQ8Ifz6/TEB24QRvVTxC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kq5ERwsXT8Z2+I9syuzlIsDmBVkU8fO5shKxraaQKlAj0H/caKinU81cBF5vp9BxUdguzVfrN+cNcnyzYf7FDN0Q8Ie2rRlk0JsCWU2hEn1LOnsmhp3jIsThJ5S2zK7Sy5AQJD87BxpgHVKeHtkevbRFv5tTeS/FPXzdln9uP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=goVBlah/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="goVBlah/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so8306855e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786537030; x=1787141830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBwafU5xy4gBpXZZ8RpOZbZKdoNHkxpt7OyTBRfCxbA=;
        b=goVBlah/afUA34qGWWBCpUJKVP2eNpaoQyAFZxI0UufeaKnFI6not4t7GNLa5V/ySn
         KRNjNE89KE2DLJhbWOI3nQXy5E9W+BOCRL0NIMpy3DGOzOVwTlXUlApQ0HlUnVgr8eos
         +d7DaKpQQhyV2sTGZE9wakMbURokwwQqoCzozV5Qkh70CLuOaZkl0YWcDoXw/z29qNB6
         Y/vKGGIo2JmmhncstxcH8GqzxD1qG2WwMa95PLJ0vL9K5xpuB/zAf03FLYdfb/E8zqij
         fObquBDWlJyrQ9ADJ8qsJqFJVZS1Y199krhc/ZlO7jBOcUoOxESaXc9hmoppT5470+Lh
         1zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537030; x=1787141830;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBwafU5xy4gBpXZZ8RpOZbZKdoNHkxpt7OyTBRfCxbA=;
        b=Dv2J+usJIh3plkHgiMuQVNIkzMnF5D2VfTY6ZKbKEbNXAtI0ATW/xy8PTM/0ajRP/Q
         pRNn+a3PXeJkHayCIndMQLaNI/k9kdzOQId9Fel3xhczddvqvnxJeO542OUNSZmIj83P
         OEaUP1Eamj0NFjJDAWA3Z9eNHlFE57DWwcMAkLvmZqHaGpBNI1jT9aIz+hr0bWXkXmBG
         ruETRtCaqG/7Xw0GJTAFg6A6ypIk/MXr2E1ZXFJxmBkFcAbx96amDK9Jb9YfVYnJJL40
         By87qmYBmYb+W+GRdGerrsbYyipuLhGI/g/Z6CDatvZ4BvWOHL7DnS4UoonwRBat7dW5
         4P/w==
X-Gm-Message-State: AOJu0YwMrILwicPLgV4rWYnEqFtyOmlM+Xbv4UsST8FSiqIey5ze4v3n
	Mup7BuS2KfFmivpqt+Nm2v7oON3k9yvcqbBYaQ8Zoo7j7kDvwiDnTcL/Wp7La4AMQzo=
X-Gm-Gg: AR+sD13r27cSj1pZ2v+72cnqOqDNgWTjuvlWDQmnCtqvtYyxWkSaNR+9/SpeoAJ+ywZ
	8iQzRab9OTUXc84KYT8uLRqKiX9T+N5kseGcoEkBsGVBJRsxdmwspGH+j/OeW2olwkr/7BKMwF2
	ej0FI9JsX0dSTAq5Iyrh2yuLq5tgbSIBITLuxqz7Fk78pxGAU2jnx6+05Vb4b+S9++Wqg5PWE/8
	E6HbazyDjekczYLlncHUj+U/h8N62h04bnH/VCOA6tsJ8IbW4QCUc22I2qe1BAUGmottDzge4jJ
	xYHHMLzqXC+bK1OIV2vIfErA5NPRSxo0b7WAhaaJMctSiMrMPfInTsmqMCrgrb4adRajf9MFiQc
	ssVqYToKE2IneR8aExbYKEl/4yQnL09mRGQper/sp25iajGdpfAc2grn47RfoI4XCfU0Ma/2Kxo
	jNi3Tv3oedR2W/o/l41Q2DkMgLH0RVmalLoOiaENCIxzY9PGTYW7ygYDE3PyYwyFiA/zVvFI3bs
	bEAgOaSqbp2Ijk+46Q=
X-Received: by 2002:a7b:ce0e:0:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-4997c149ba3mr41006275e9.14.1786537029670;
        Wed, 12 Aug 2026 05:17:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c94f4c0sm40120515e9.8.2026.08.12.05.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:17:09 -0700 (PDT)
Message-ID: <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
Date: Wed, 12 Aug 2026 15:17:07 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
 TencentOS Corvus AI <corvus@tencent.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812113435.1854275-1-junvyyang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260812113435.1854275-1-junvyyang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 14:34, Jun Yang wrote:
> __br_multicast_disable_port_ctx() and br_multicast_del_port() walk
> port->mglist with hlist_for_each_entry_safe(), which only guarantees that
> the *current* node may be removed by the loop body.
> 
> The body is br_multicast_find_del_pg() -> br_multicast_del_pg(), and that
> deletes further port groups of the very same port. br_multicast_del_pg()
> drops the group's sources, and br_multicast_fwd_src_remove()
> (net/bridge/br_multicast.c:583) deletes the (S,G) port group installed on
> that same port; br_multicast_star_g_handle_mode() -> __fwd_del_star_excl()
> (net/bridge/br_multicast.c:330) deletes the automatically installed
> MDB_PG_FLAGS_STAR_EXCL entries, again on that same port. All of those sit
> on the same port->mglist.
> 
> When one of them happens to be the node the iterator already latched as
> "next", hlist_del_init() clears its ->next, the walk sees NULL and stops.
> Every port group after it is silently left on the port. port->mglist is
> head-inserted, so this needs the cascade victim to be older than the (*,G)
> entry owning the source - a user-added, non-permanent (S,G) MDB entry added
> before the (*,G) join produces exactly that ordering.
> 
> Hitting it once truncates the disable walk in
> __br_multicast_disable_port_ctx() and once more truncates the flush in
> br_multicast_del_port(), so del_nbp() goes on to free the port with port
> groups still on port->mglist - and still linked in the bridge's mdb, with a
> dangling ->key.port. Any subsequent mdb dump reads the freed port:
> 
>    BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
>    Read of size 8 at addr ffff88803065d008 by task bridge/9527
>     __mdb_fill_info+0x1191/0x1320
>     br_mdb_dump+0x594/0xe40
>     rtnl_mdb_dump+0x1cf/0x5d0
>    Freed by task 0:
>     kfree+0x265/0x740
>     kobject_put+0x212/0x6a0
>     rcu_core+0x5c6/0x1140
>    Last potentially related work creation:
>     __call_rcu_common.constprop.0+0xb7/0x9e0
>     br_del_if+0xdd/0x260
> 
> Don't rely on the pre-latched next pointer. br_multicast_del_port() deletes
> everything, so just take the current list head each round. The filtered
> walk in __br_multicast_disable_port_ctx() keeps its iterator but restarts
> whenever the latched node has left the list; port groups are only freed by
> the multicast GC work, which takes br->multicast_lock, so the node is still
> valid memory for that check.
> 
> Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> A KASAN reproducer for this issue is available if requested.
> 
>   net/bridge/br_multicast.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 00aa9b2879d6..624dfca4066b 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -2065,12 +2065,17 @@ void br_multicast_del_port(struct net_bridge_port *port)
>   {
>   	struct net_bridge *br = port->br;
>   	struct net_bridge_port_group *pg;
> -	struct hlist_node *n;
>   
> -	/* Take care of the remaining groups, only perm ones should be left */
> +	/* Take care of the remaining groups, only perm ones should be left.
> +	 * Deleting one can delete others on this same port->mglist, so
> +	 * always restart from the head.
> +	 */
>   	spin_lock_bh(&br->multicast_lock);
> -	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
> +	while (!hlist_empty(&port->mglist)) {
> +		pg = hlist_entry(port->mglist.first,
> +				 struct net_bridge_port_group, mglist);
>   		br_multicast_find_del_pg(br, pg);
> +	}
>   	spin_unlock_bh(&br->multicast_lock);
>   	flush_work(&br->mcast_gc_work);
>   	br_multicast_port_ctx_deinit(&port->multicast_ctx);
> @@ -2126,11 +2132,23 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
>   	struct hlist_node *n;
>   	bool del = false;
>   
> -	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist)
> -		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT) &&
> -		    (!br_multicast_port_ctx_is_vlan(pmctx) ||
> -		     pg->key.addr.vid == pmctx->vlan->vid))
> -			br_multicast_find_del_pg(pmctx->port->br, pg);
> +	/* br_multicast_find_del_pg() can delete further entries of this same
> +	 * port->mglist, so the node latched in @n may be unlinked by the loop
> +	 * body. Port groups are only freed by the GC work under multicast_lock,
> +	 * so @n is still valid here; if it left the list, restart.
> +	 */
> +restart:
> +	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist) {
> +		if ((pg->flags & MDB_PG_FLAGS_PERMANENT) ||
> +		    (br_multicast_port_ctx_is_vlan(pmctx) &&
> +		     pg->key.addr.vid != pmctx->vlan->vid))
> +			continue;
> +
> +		br_multicast_find_del_pg(pmctx->port->br, pg);
> +
> +		if (n && hlist_unhashed(n))
> +			goto restart;
> +	}
>   
>   	del |= br_ip4_multicast_rport_del(pmctx);
>   	timer_delete(&pmctx->ip4_mc_router_timer);

Thanks for the report, but instead of all these restarts and checks,
can't we just do:
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 75e1e2a8fc83..62c4008c5bb8 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -808,7 +808,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
         struct hlist_node *tmp;
  
         rcu_assign_pointer(*pp, pg->next);
-       hlist_del_init(&pg->mglist);
+       /* use _rcu to preserve the next pointer because it might be in use */
+       hlist_del_init_rcu(&pg->mglist);
         br_multicast_eht_clean_sets(pg);
         hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
                 br_multicast_del_group_src(ent, false);


I have old patches that remove the mcast open-coded list implementations, I must
revive them and clean all of this up finally. :)

Cheers,
  Nik

