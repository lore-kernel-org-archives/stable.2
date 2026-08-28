Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2A36F911
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907852; cv=none; b=U9iXzQsvJMg3VOS1dEhCIqfgghvEutFsW80XRiZdZs3TMLMfoNEAX21yChR+H0PEy+Ztz1XCPmKXMPvRGUwnr48p+b2TyLRnTuiDNq2mnEBPyBSoKQJygJPwsqTKumIV0XuMyKQdOuswHNgeMAq1IZCCaulq0ow3+IXQE/dglio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907852; c=relaxed/simple;
	bh=PbAsHecO1Ic1JzzAG5UP//YNYLWIUWHaXALDR5m00PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QP8/Y884Hmaf7Fy6XKZVnXn/0ebsyt/fGB7UrVdjqsTdnHTuMIoLM5WciRQXDD8g0iiEdpvwJMNtvocjbbngqJonkfmhAQ9HnwqF/O7JFoYm04+GtHImDQBcW5SgikK79oTWa3G5/PEnkbF3voXI++XXvpQTPAEtnCQ1zH076Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=XOTgRN6v; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="XOTgRN6v"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482e1bfcc63so505154f8f.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787907847; x=1788512647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FVVeGxFQZiJluzy1rO69TONBk8AF7s80qwGfb+Ej5mg=;
        b=XOTgRN6v+sCYp9D5fSnm2yUrHdt8Bz1ByAnnqyJocVLUPLKD3btfjqx7YG4e2M/gHU
         VXryn3Frl7PDG6hRz1pEbG4b9oxX3edXQ1slwTkFJax49TYnqbGTR6RNJlLrXbyoi4/y
         tJkXWJs49DcldZmUtyZjLPY04L3Z6hmcaRrX0UdTJNSUB/Rp0Qp2SdH4mYSOCdkkVYGk
         V/goxtQlNXyRvfTx1SWlm3yL4qqSQZBIEN+omRoSiL+4ktYzW4hrRMIdHH/hDthS+/cZ
         iMoXWuHA0IHH58LgjdZ/+YmJjeOUtcD2mcs2NFe5yKLsjAK194q4A9xojTspqrfj7RsH
         rerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907847; x=1788512647;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FVVeGxFQZiJluzy1rO69TONBk8AF7s80qwGfb+Ej5mg=;
        b=S/nC/ic6grvba/OXelf2R4Q1/LCBuwmKatxuCXH56sTAxvn9Q+8PW7KZUoK+k1dmww
         tWjmxZfmnEa0tmpkc6tsOavCBzi++jICSUnTOMeO456/5CneRJy4ut08OS/MW7hXL4Cv
         wOdoB6LOs9ewdpug0GJIZOzTD/14I8jUpNAtEwIzjLZ6J0IJe+bWCfxkmfVp+bWkzpRW
         ekCjsjLo67rJ1+23zjT4v0h+M3X/bJOvAZlopSRuP5vwrKIITczb6rHBBz9R/FTC6P8D
         FrHrOVMkdniDGwdTnWx5czjik9K2ozzqdfe6eLJlQguldLzFW0lawRUo2nwkkOEaxx4O
         smzA==
X-Forwarded-Encrypted: i=1; AHgh+Rr71pCs5cXQg7x/i1wDMUl0BExtntLd11puFbHV6yqmZuqK+BrC4cxY0u+NS8MOlnll6H3fZUk=@vger.kernel.org
X-Gm-Message-State: AFuF++ksMM3KmlEugZoGE+wKA4lajraGFDAPcKt4u6iawmNEfNWPuqd/
	58E/nd7eydiSxbCYGC43zeswQHJN6ll3S6EmWuVHy0s/tRWiASHvqrxpMpZjn5ujaf8=
X-Gm-Gg: AR+sD13jMLrTya1oNGYZ1vW0+3FZU8pPfbz/DdC6V5bbedhX2arbxfxPfthFx6x9cjt
	9PwuOlojPTuiVaKx2aWZHkfvgC5qI/8xZxkiJYkHO/d64dokgIk4QFPWeM9OJ/LZi8jlAbzOZcF
	9YA6gXy6mFO2RcRcYzlKRY2xk/I4T7Kpd42RgpN5PoAcbqs5O/LA/tQ2B9OP2QHN3yUT2Ibmaku
	8i+H/1I1JUUe5/Q7xs8iVTO1e0dqHIJg1xf9jU6/hqZZigURTqptlg1JHYPQQFJdC17tYTreVz9
	zcVcEgE2rLDBJg5Zo4tTRk4PFH/mkfvQ0WQyGaJ2gUYY/jRcuT1wxMRBGpOYStpDpJM0XTEuiJs
	NlZU4BQQC3zcOOb8jUGF2mp73XC57HNWnxnD8t7Q2fyJKjSzhK/bTBIk5QYGU3RCRcG2vLssvxs
	uomTf7BdasTrg1amjlmZ8sgh+HeNsr8oEuB+Z4rdUQjvaYh6e4yo9bXpcKRPNcr9UyO5r7UHeR+
	oG10AyqUMGKHArOhkU=
X-Received: by 2002:a05:6000:4541:b0:482:f270:6a59 with SMTP id ffacd0b85a97d-482f2706f1cmr10904206f8f.1.1787907846748;
        Fri, 28 Aug 2026 02:04:06 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f16sm2607143f8f.1.2026.08.28.02.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 02:04:06 -0700 (PDT)
Message-ID: <49a065c1-737f-4968-bde7-614bf53f0628@blackwall.org>
Date: Fri, 28 Aug 2026 12:04:04 +0300
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
To: Jakub Kicinski <kuba@kernel.org>, littleddfu@gmail.com
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 corvus@tencent.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 junvyyang@tencent.com
References: <20260826014200.362304-1-littleddfu@gmail.com>
 <20260827193137.4015557-1-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260827193137.4015557-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2026 22:31, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: bridge: mcast: don't truncate the port group walk on teardown
> 
> This changes br_multicast_del_pg() to unlink the port group from
> port->mglist with hlist_del_init_rcu() instead of hlist_del_init(), so
> that a nested deletion of another group of the same port does not clear
> the ->next pointer that an in-progress teardown walk has already latched.
> The intent is to stop br_multicast_del_port() and
> __br_multicast_disable_port_ctx() from terminating early and leaving port
> groups behind with a dangling ->key.port.
> 
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index 75e1e2a8fc83a..452ac68c4a835 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
>> @@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
>>   	struct hlist_node *tmp;
>>   
>>   	rcu_assign_pointer(*pp, pg->next);
>> -	hlist_del_init(&pg->mglist);
>> +	/* Keep ->next (held under multicast_lock, freed later by the GC work):
>> +	 * a port->mglist teardown walk may have latched this node as its next,
>> +	 * and deleting other groups of the same port must not truncate it.
>> +	 */
>> +	hlist_del_init_rcu(&pg->mglist);
> 
> [Severity: High]
> 
> Preserving ->next keeps the walk going, but doesn't it now make the walk
> visit a group that was already deleted as a side effect?
> 
> hlist_del_init_rcu() only clears ->pprev, so the latched next node is
> still reachable by the iterator:
> 
> 	include/linux/rculist.h:
> 	static inline void hlist_del_init_rcu(struct hlist_node *n)
> 	{
> 		if (!hlist_unhashed(n)) {
> 			__hlist_del(n);
> 			WRITE_ONCE(n->pprev, NULL);
> 		}
> 	}
> 
> Taking br_multicast_del_port() as the example, all under
> br->multicast_lock:
> 
> br_multicast_del_port()
>     hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)  /* n = A->next = B */
>        br_multicast_find_del_pg(br, A)
>           br_multicast_del_pg(mp, A, pp)
>              br_multicast_del_group_src() -> br_multicast_fwd_src_remove()
>              or br_multicast_star_g_handle_mode() -> __fwd_del_star_excl()
>              or br_multicast_sg_del_exclude_ports()
>                 -> deletes B (same port) via br_multicast_del_pg()
>                    rcu_assign_pointer(*pp, B->next);   /* B off mp->ports */
>                    hlist_del_init_rcu(&B->mglist);     /* B->next preserved */
>     pg = n = B                                          /* loop continues into B */
>        br_multicast_find_del_pg(br, B)
> 
> In br_multicast_find_del_pg() the mdb entry lookup still succeeds, since
> mdb entries are only unhashed under br->multicast_lock, but the scan over
> mp->ports can no longer find B because br_multicast_del_pg() already did
> rcu_assign_pointer(*pp, pg->next) for it:
> 
> 	for (pp = &mp->ports;
> 	     (p = mlock_dereference(*pp, br)) != NULL;
> 	     pp = &p->next) {
> 		if (p != pg)
> 			continue;
> 
> 		br_multicast_del_pg(mp, pg, pp);
> 		return;
> 	}
> 
> 	WARN_ON(1);
> 
> So control falls through to the trailing WARN_ON(1). br_multicast_del_port()
> applies no filter at all before calling br_multicast_find_del_pg(), and the
> filter in __br_multicast_disable_port_ctx():
> 
> 	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist)
> 		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT) &&
> 		    (!br_multicast_port_ctx_is_vlan(pmctx) ||
> 		     pg->key.addr.vid == pmctx->vlan->vid))
> 			br_multicast_find_del_pg(pmctx->port->br, pg);
> 
> doesn't exclude a kernel-installed, non-permanent S,G group either.
> 
> Does that mean the reproducer described in the commit message now produces
> a WARN backtrace on the same path instead of the KASAN use-after-free, and
> a panic when booted with panic_on_warn=1?
> 
> Would it make sense to also skip nodes that are already unlinked in both
> teardown walks, e.g.:
> 
> 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist) {
> 		if (hlist_unhashed(&pg->mglist))
> 			continue;
> 		br_multicast_find_del_pg(br, pg);
> 	}
> 
> or otherwise restart the walk, rather than relying on the preserved ->next
> alone?
> 

Oh, right, I missed that WARN_ON() and it will fire, yes. But instead of
sprinkling these hlist_unhashed checks around, you can add 1 to the beginning
of br_multicast_find_del_pg() with a comment why it exists

> [Severity: High]
> 
> This isn't a bug introduced by this patch, but the same list has a second
> deletion site that still uses the non-RCU helper and frees immediately,
> br_multicast_del_port_group():
> 
> 	void br_multicast_del_port_group(struct net_bridge_port_group *p)
> 	{
> 		struct net_bridge_port *port = p->key.port;
> 		__u16 vid = p->key.addr.vid;
> 
> 		hlist_del_init(&p->mglist);
> 		if (!br_multicast_is_star_g(&p->key.addr))
> 			rhashtable_remove_fast(&port->br->sg_port_tbl, &p->rhnode,
> 					       br_sg_port_rht_params);
> 		kfree(p);
> 		br_multicast_port_ngroups_dec(port, vid);
> 	}
> 
> port->mglist is also walked locklessly by br_multicast_list_adjacent(),
> which only holds rcu_read_lock():
> 
> 	hlist_for_each_entry_rcu(group, &port->mglist, mglist) {
> 		...
> 		entry->addr = group->key.addr;
> 
> That reader is exported and used from net/batman-adv/multicast.c. The group
> is already published on port->mglist by br_multicast_new_port_group()
> (hlist_add_head(&p->mglist, &port->mglist)) before the only caller of
> br_multicast_del_port_group() runs, the err_del_port_group label in
> br_mdb_add_group_star_g() in net/bridge/br_mdb.c, reached when
> br_mdb_add_group_srcs() fails. br_mdb_config_src_list_init() does not
> reject a duplicated source, so a MDBE_ATTR_SRC_LIST carrying the same
> source twice without NLM_F_REPLACE makes br_mdb_add_group_src() return
> -EEXIST; an allocation failure returning -ENOSPC is a second trigger.
> 
> spin_lock_bh(&br->multicast_lock) held by the deleting side does not
> exclude an RCU reader on another CPU. Can br_multicast_list_adjacent()
> then read group->key.addr and follow group->mglist.next after the plain
> kfree(p), and does the hlist_del_init() there also truncate that RCU walk
> by NULLing ->next?
> 
> Since this patch establishes that port->mglist deletions must preserve
> ->next and defer the free, would it be worth converting this site to
> hlist_del_init_rcu() plus a deferred free, in the way
> br_multicast_destroy_port_group() uses kfree_rcu()?

Ouch, that is actually a separate and valid bug, the cleanup shouldn't be
using hlist_del_init + immediate kfree(). I will take care of this one.

Cheers,
  Nik


