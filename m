Received: from mta0.migadu.com (out-120.mta0.migadu.com [91.218.175.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6063783AD
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565465; cv=none; b=Pkz2hBoOhnydVuWxBvbZ13/CZKPTdDjfyvxSFB3jSb7UjqccXc5WhdsmAZytMDAWcXssvrOnPtGlIhEEQ6vjL5bTy/3/dPWcNCD/a7x6QfwPRINOW9D/Jy7i0upX0wCzP/ryCfLKdBxbPfA0RISldaifsjqkYi96C7laVJ6Dw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565465; c=relaxed/simple;
	bh=a9FuRuSTVAaA/hxz9AGglU6q0ELlpGP3rsg2MrpGW+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQo1hBEp3BdVXCz8Fy6W84LTv1MTMEvUQGKUkVoDz9YEGV11SuUHDS3qEZFd6WTFe604W7h4/OfE8HT4Gd8czvDmfUNVmC+4O2/rMG3nvQ8l4QMvouuwUnnupV1in64HI9lPJnRx5WarXvgkqSJPZtN3h9tdKzhSONOcVGdjNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bYRQ248A; arc=none smtp.client-ip=91.218.175.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bYRQ248A"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=a9FuRuSTVAaA/hxz9AGglU6q0ELlpGP3rsg2MrpGW+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790565460; v=1; x=1791170260;
 b=bYRQ248ANlm1ZHtvmQ9GtlNqkDy9tl2OJq89ZQQGlptRB0AlBKfoB/f9uKqPf4Y1wZGPTAx7
 oSb84sxks+JPGh5i5iwC5b/CKo4wiLfwfKDo55MryVhGnMScFChR5Ch1ICV2ocCuoZGhPxCsKCL
 AabU7aL1qWAxUwzyCBvR9tnU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 98874dbcc62e0d42;
	Mon, 28 Sep 2026 03:17:40 +0000
X-Mizu-Trace-ID: 98874dbcc62e0d42
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 11:17:30 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, John Heffner <jheffner@psc.edu>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ipv4: Fix device use-after-free in ip_skb_dst_mtu()
Message-ID: <arncSh_Fk0ITZ82H@fedora>
References: <20260927071051.3693368-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927071051.3693368-1-nicoyip.dev@gmail.com>

On Sun, Sep 27, 2026 at 03:10:51PM +0800, Chengfeng Ye wrote:
> When a socket ignores the path MTU, ip_skb_dst_mtu() reads the device
> MTU without RCU protection. The multicast and broadcast output path
> through ip_mc_output() can reach this helper without an RCU read lock.
> Netfilter releases its internal read lock before calling
> ip_finish_output().
> 
> A sender can load dst->dev and then be preempted before reading dev->mtu.
> Concurrent device unregistration replaces dst->dev with blackhole_netdev
> and drops the old device reference. After the grace period and remaining
> references drain, the device can be freed before the sender resumes and
> reads its MTU, causing a use-after-free.
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
>   Read of size 4 at addr ffff88810921c038 by task poc/98
>   Call Trace:
>    ip_skb_dst_mtu+0x634/0x740
>    __ip_finish_output.part.0+0x22/0x2c0
>    ip_mc_output+0x287/0x930
>    ip_send_skb+0x11d/0x150
>    udp_send_skb+0x63e/0xdf0
>    udp_sendmsg+0x1235/0x1da0
>    __sys_sendto+0x32c/0x3a0
> 
>   Allocated by task 97:
>    __kvmalloc_node_noprof+0x1d4/0x620
>    alloc_netdev_mqs+0x81/0x12c0
>    rtnl_create_link+0xaa3/0xe30
>    rtnl_newlink+0xabc/0x1f70
> 
>   Freed by task 99:
>    kfree+0x131/0x3c0
>    device_release+0xc8/0x240
>    kobject_put+0x14d/0x280
>    netdev_run_todo+0x4cb/0xc70
>    rtnl_dellink+0x362/0xa90
> 
> Protect the device lookup and MTU read with RCU and use dst_dev_rcu() to
> access the device pointer. Keep the MTU limit and headroom calculation
> unchanged.
> 
> Fixes: 628a5c561890 ("[INET]: Add IP(V6)_PMTUDISC_RPOBE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  include/net/ip.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/ip.h b/include/net/ip.h
> index 6f602df72ee6..14d6f77f3bb8 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -543,7 +543,9 @@ static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
>  		return ip_dst_mtu_maybe_forward(dst, forwarding);
>  	}
>  
> -	mtu = min(READ_ONCE(dst_dev(dst)->mtu), IP_MAX_MTU);
> +	rcu_read_lock();
> +	mtu = min(READ_ONCE(dst_dev_rcu(dst)->mtu), IP_MAX_MTU);
> +	rcu_read_unlock();
>  	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
>  }
>  
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
