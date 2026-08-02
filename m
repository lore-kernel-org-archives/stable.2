Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E30184;
	Sun,  2 Aug 2026 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785691741; cv=none; b=N6DPUrxi3S1tnQe9Wd+R2lSP33UXQq5zzoinBRjq00p0Pf1PZM04k9g2LnvuoBp+0XT/WA73VUShMNnYhLmX3ZBGNDloz52rWGGqRT8eR1DwdpzycTw/wmlrwvyI2GABQgUr+MSwv2Onv+EhtPTxBAs47YpDKMNevp4Jii16fG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785691741; c=relaxed/simple;
	bh=mXJfnifbB3h3/ia6ckHTFTYSaGsTEciq8XcaDUOcJZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy0W/90iA3UbRc1rTaV2G2pzxdK7Uk7yw6jObSqvxPx2umlTeFOVgQhSiaCFp2VxKeVjz/q+8KvexQZwhwOD1ieOrZa8CjIlL7imxf2tBjsh1Mjb6axQoPmKUVSJiC/AhojH1vMZcPUTuCFWUqWRpgNAZPLythCpQDx6ZKHT+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cREnuwSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cREnuwSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1889F1F000E9;
	Sun,  2 Aug 2026 17:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785691739;
	bh=iuqXc+elRzj+nXh0kLPgziWoNK4uEBzlUlNWnA02QxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cREnuwSaVp9mjNkieNG+QvbDsFCIWsofHLD3CJnebZZgk/tAyRvrArhqMYMEkQ9v2
	 UQPibetn/wuj25JX9Wkd7ZR/4aQq/d0QohfoK4+O5ieEpnEIWMcbawGP/eF0gFyJ2l
	 pEhD5UCA9ZRs7L7Dnylh2HlMAfvDNQ+tEaYjkzFbiOP4B8tLnf1AkXGj7pC6q7JNuF
	 QdT1SitYMvxIA37erkwC6xE9eENzgDkBj9UGkdR9voYJd7NwC8qZGDq1BSGaNkmEkN
	 /K1w6v0JyYWS1/D47DVRbsNb0WXdeoFi3GzLxWCHtOFsHjEw6nRxhGPv5mYXhHdGL4
	 2XG8+wzt3qhpQ==
Message-ID: <b27d0b13-ea24-4128-bcbd-1bd5fd8c414f@kernel.org>
Date: Sun, 2 Aug 2026 11:28:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: fix use-after-free in fib_nhc_update_mtu()
Content-Language: en-US
To: Chengfeng Ye <nicoyip.dev@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260731162938.3388534-1-nicoyip.dev@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260731162938.3388534-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 10:29 AM, Chengfeng Ye wrote:
> fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
> RTNL does not serialize this walk with PMTU exception updates. The walk
> uses rcu_dereference_protected() with a constant true condition without
> holding either fnhe_lock or an RCU read-side critical section.
> 
> The following interleaving can therefore occur:
> 
>   CPU 0                              CPU 1
>   fib_nhc_update_mtu()               update_or_create_fnhe()
>     load fnhe                          spin_lock_bh(&fnhe_lock)
>                                        fnhe_remove_oldest()
>                                          unlink fnhe
>                                          kfree_rcu(fnhe, rcu)
>     <quiescent state>
>     access fnhe after grace period
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in fib_nhc_update_mtu+0x3df/0x410
>   Read of size 8 at addr ffff888107d49000 by task poc/90
>   Call Trace:
>    fib_nhc_update_mtu+0x3df/0x410
>    fib_sync_mtu+0x7a/0xd0
>    fib_netdev_event+0x229/0x3f0
>    netif_set_mtu_ext+0x33a/0x570
>    dev_set_mtu+0x88/0x120
>   Allocated by task 89:
>    update_or_create_fnhe+0xa80/0x1110
>    __ip_rt_update_pmtu+0x8f2/0xcd0
>    ipv4_sk_update_pmtu+0x49e/0x690
>    udp_err+0xd92/0x1080
>   Freed by task 0:
>    __kasan_slab_free+0x43/0x70
>    kvfree_rcu_cb+0x12f/0x420
>    rcu_core+0x509/0x18e0
> 
> Protect the full walk with rcu_read_lock() and use rcu_dereference()
> for the RCU-published pointers. This prevents reclaim from completing
> until all references held by the walk have been dropped, without
> serializing PMTU updates against the entire hash-table traversal.
> 
> Fixes: af7d6cce5369 ("net: ipv4: update fnhe_pmtu when first hop's MTU changes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/ipv4/fib_semantics.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


