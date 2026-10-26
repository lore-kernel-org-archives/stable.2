Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994980;
	b=x1l1o74uR3niCQJT5E1SH4CLrzi55o9jB0m/GqNeITNqMV6n5BHY2C7ptGOOGCkAdOzf
	 Pc5FMc4ClZA0a6L3W1MC1UOhGIDMZNyKROpy1Hz0dVM4o3z82SbHPigBxiArDa3b/Dsdh
	 xIijqyfVSj7kt7Yef6YwOU/LXqWd0dy6r7UdFQHm7anaCYIl2WMrs27eAQk1Wi4Jk4ZGE
	 QjbGZ03C1uQyxBX4LGq47EXzNhMyj/rP5vZExHjP3Xk9cEf43EPp4sDwiU4R8JVozTjTZ
	 a/205YH1ihrLTOVT1WPb9snr/lGMrRAcmtpLxYCk06DQ7m76dw/pcfChWXf3F/8YvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994980;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ScUwDrCxcDY2Tg+t0+W2UwFl6cxgpHFmAE9XOo7zw8g=;
	b=nbMjerLkHRc9Of0aRW2gPwjPbgY0PxWfFLnSrxnwkwQUTdqFKLVdF97BgWzdejQR4SUP
	 v39/LYEoX+sF6WlWdeNR2MzebpQqsAK+YhrCj23QO6Isvu3cYqxM+TIl+zakJT5WYJjha
	 1Xt1lqNU3uosG+Q66kb0A7nbSrXrd9J/B0CDiEvFrxgR/ThomYlMK9wXoAkoHrTwKVeUE
	 OmvQ4/kri35rZnOt8MtpvR7ie218FLPhNMJGbjXgcVixg2jc86Hx5P8kBjy2AM3BdutK3
	 qwnm10rzb5uCX1q4DOm2Jb1EmCQf4FHZtOpTXg9zHSg5T9ZXdg8FN8VtvrJYhuGTylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZJ87ng0A;
	arc=none smtp.remote-ip=95.215.58.209
Received: from mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E196606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E196606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZJ87ng0A
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HVI1rhJAjlA6hwOuxcxfPrgx9c8vnckidjUuhN7LrGs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792994977; v=1; x=1793599777;
 b=ZJ87ng0Awshfd2qAvlXjnoYCpo/685WZn3yvyRHt4/IgTUhKjohacDBgrda54qYzp5EEu6a3
 j+5Z9V0ZA+ZvdslvqtOa0+tNlccVk8FfUpTHuYtkfVkkcwXZsifiFeGE8StoTGNJmjxarDN8IYO
 pNYB1P4Ax4eCxk58aoUyS7rA=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 5076e146843fdcaf;
	Mon, 26 Oct 2026 06:09:37 +0000
X-Mizu-Trace-ID: 5076e146843fdcaf
X-Migadu-Flow: FLOW_OUT
Date: Mon, 26 Oct 2026 14:09:23 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <at7uk8gXtzNufuQF@fedora>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026044808.613-1-n0ps1edzz@gmail.com>

On Mon, Oct 26, 2026 at 12:48:08PM +0800, Zhou Qiuyue wrote:
> rawv6_send_hdrinc() caches the route before handing the skb to
> l3mdev_ip6_out(). The VRF output path may replace skb->dst and release
> the original route, leaving the cached pointer stale.
> 
> The function later dereferences that pointer for statistics accounting
> and as the output device passed to NF_HOOK(). Its RCU read-side critical
> section starts after l3mdev_ip6_out(), so it cannot prevent the old route
> from being reclaimed in between.
> 
> Reload the route from the current skb destination after
> l3mdev_ip6_out() returns.
> 
> KASAN reports a slab-use-after-free in rawv6_sendmsg(), with the route
> allocated by ip6_dst_alloc(), freed by dst_destroy() from rcu_core(), and
> the related RCU callback queued from vrf_l3_out().
> 
> Fixes: 4c1feac58e06 ("net: vrf: Flip IPv6 output path from FIB lookup hook to out hook")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
> ---
> Changes in v2:
> - Rebased onto the current net tree at 7076f684d513.
> - Regenerated the patch with git-format-patch so it applies cleanly.
> - Corrected the Fixes tag to the commit that made the IPv6 VRF path reachable.
> - Shortened the code comment and added the required recipients.
> 
> v1: https://lore.kernel.org/r/6adad51d.8fc0b0c9.1ec657.1868@mx.google.com
> 
> Thank you to Hangbin Liu for reviewing v1 and pointing out the submission
> issues.
> 
>  net/ipv6/raw.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index b965258cf..bdea82543 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -654,6 +654,9 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
>  	if (unlikely(!skb))
>  		return 0;
>  
> +	/* l3mdev_ip6_out() may have replaced the skb dst. */
> +	rt = dst_rt6_info(skb_dst(skb));
> +
>  	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
>  	 * in the error path. Since skb has been freed, the dst could
>  	 * have been queued for deletion.
> 
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
> -- 
> 2.50.1.windows.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
