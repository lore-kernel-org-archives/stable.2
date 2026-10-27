Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078283;
	b=xBvVpYXhNUbf2f8qxSgeDIFvKuuZufO8Fb88CSJe4zF0E+j1WE7DOsIFUF1Jqt3qGkwT
	 6z+3OG2fCuRvQKEcMMvW/pVxSoCzjzfDv2uCx1Av9zLr9tL1HUiSOe5cTkdMqk/Q0BH8I
	 8RD0GYePHGQ+NT7a3WaFVlC8DsH1Y4ZBANnUUUo1Q24oAg4qQgcmrZWhN2AnrKMRXMdDV
	 C9oxBHfBQPyZ9ydRaEniaNU8B+Nj/0ZeecsRipqIbonb6bKwPoSzK34R5Omg3r+xAGWKx
	 D9O0jd8y3hc1X/86VbVwSxSZ6O1adqR9BiIU9hoBgGG5CtfrMt5MMYyMe70j6Ysvbvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+uCDR7ARq9hwUSQpZmzeL9ODBMFv/c2hElI0jHGVpjQ=;
	b=hoSE6piZcfoHXv0H9pby7VwkSppnIV+NagJGpNSXH7qfvsYcI+1I9LTu0Gf9UTEyd+FZ
	 N5GmrfddTksVCFQIQhVX+eFQsJ2on627R6+S2MG2YXZ5vM0YPj1q3F0DAsZY1Z5sMUoib
	 C8WQH/Lm/5z+bvxtXE0l9D89bRrIsxIpD6IevksIAFYaF4BftDK5scehK2VLeEFY2RMc/
	 rUfuJa1xJD3yc9XlAR9jQBSJpedB1o4dShg6DikNrbJXcnOIG3Y18MUp2KwEVcsma7naS
	 Grdep36YVVo+q6xTZtYYLFFevE6mQQOOSk9qfbGGYjuuzx82oC+qskSZTCM72jGO2cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gF7Eblbs;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1719606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 05:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1719606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gF7Eblbs
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0592d4539so5477545b3a.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 22:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793078282; x=1793683082; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uCDR7ARq9hwUSQpZmzeL9ODBMFv/c2hElI0jHGVpjQ=;
        b=gF7EblbsH3ojBkdb6w6nq//fNkJG1k1aTP4FuBUkw2OmJ5fWxuho50V/jvnUG/ca3Y
         Soc25H7RWaK5dJCL/yNj+bxhrExQPbXaeupbyeyPrEd7hqdJ6olZvHmAIhhw45VjxRd+
         k1ZVEsqRXbu+JLlygpswvpHQ+hkV3iGcG1VZRQLFiZ7oGHS/P95ePr6lRM+AEH0czKgA
         8ioQjMZqgQwLSM/jBQXnbfYiCp0vP8PjzkQbaSrbxVdtc41uSlq3XGxLmzXeqS7NGxbz
         Ls68xd7P60C2QUeLVUVuYAhssNz/01hB5yzoFhHw6hqwzeRxAFZ6SkEhPjiIJ7FS9tTD
         rgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078282; x=1793683082;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+uCDR7ARq9hwUSQpZmzeL9ODBMFv/c2hElI0jHGVpjQ=;
        b=YeGQO0BVi7HwxymXLJBVjDGKuVrG1LGsUkCLVKF0BI5IX2DbaEuhad5tZxTXuAEy9w
         f6e8mb56QCf/KHu6T9Zv0j9lkSep0WUAH7xUc0fVBR11RwfD1EvRmqqO7U5Me1vjwJu+
         NOePJzH6pmPaBp0xj8D+MsGAdw59UjK1zRv393TXvB66VC0EGfTeh9x2h0Hhe8JSOktc
         iU6hb3+S7mw3OcrnkciG86mMWXmQYbCKeNEb1sG8woRh58hoND31s+PbC8sWUd8mpIJY
         XSGo12CfwFx5f+FP0zwMODbhd3IP5xOIfLGMz9+PPUjjCsJ5+Ht3X8DY7TKICncLAPKv
         baHQ==
X-Forwarded-Encrypted: i=1; AKwUvByqLvf5JAr7FRAG6A+RF3WM3qR381U3r5fHZrXB5uItNnaAa0qxaqtcTbX6RLwa3/EEYyA8Glw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUjtk3aqv9u53TTqr2ME00R49KJfxjN8IGXt552GupadixSc+1
	7nVscpsr5F1b0Uhs3AjDKa9DERqwFNo4AXlUlQ9eCq/zivgXYtey3SpZATmZm2CsA+MwfpoaZ6R
	xMfS0rA==
X-Received: from pfoh11.prod.google.com ([2002:aa7:86cb:0:b0:89f:e0c9:a666])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d99:b0:8a0:3483:51ec
 with SMTP id d2e1a72fcca58-8a367e17451mr7352130b3a.58.1793078281782; Mon, 26
 Oct 2026 22:18:01 -0700 (PDT)
Date: Tue, 27 Oct 2026 05:18:01 +0000
In-Reply-To: <20261023091419.167088-2-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023091419.167088-1-jiayuan.chen@linux.dev> <20261023091419.167088-2-jiayuan.chen@linux.dev>
Message-ID: <auAzkt5o37MCjPFU@google.com>
Subject: Re: [PATCH net 1/5] ipv6: restrict gc_elasticity to 31
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Joel Granados <joel.granados@kernel.org>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Yung Chih Su <yuuchihsu@gmail.com>, Flavio Leitner <fbl@redhat.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, 23 Oct 2026 17:13:27 +0800, Jiayuan Chen wrote:
> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
> 
> ip6_rt_gc_expire is a u32, but gc_elasticity has no upper bound, so
> writing >= 32 shifts a 32-bit value by >= 32 bits, which is UB:
> 
> 	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
> 	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
> 
>   UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
>   shift exponent 32 is too large for 32-bit type 'unsigned int'
>   CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREEMPT
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0xc1/0xf0
>    dump_stack+0x10/0x20
>    __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>    ip6_dst_gc.cold+0x15/0x1a
>    dst_alloc+0x4e0/0x620
>    ip6_rt_cache_alloc+0x189/0x7e0
>    __ip6_rt_update_pmtu+0x68e/0x1160
>    ip6_update_pmtu+0x30c/0x3a0
>    icmpv6_err+0x1fa/0x330
>    icmpv6_notify+0x303/0x770
>    icmpv6_rcv+0xc12/0x1670
>    ip6_protocol_deliver_rcu+0xb4a/0x1520
>    ip6_input_finish+0x19c/0x400
>    ip6_input+0xd4/0x240
>    ipv6_rcv+0x1fd/0x330
>    __netif_receive_skb_one_core+0x118/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
>    handle_softirqs+0x204/0x9b0
>    __do_softirq+0x10/0x18
> 
> Cap it at 31. 31 and 32 are equivalent anyway: ip6_rt_gc_expire starts
> at 30*HZ (~30000 with HZ=1000), and such a value shifted right by 15 or
> more is already 0, so val - (val >> rt_elasticity) stops decaying well
> before 31. Values above 31 add no new behaviour, they only hit the UB.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/ipv6/route.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 94e5ef1c4f83..6f2efc219f39 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
>  	return 0;
>  }
>  
> +static int ip6_rt_gc_elasticity_max = 31;
> +
>  static const struct ctl_table ipv6_route_table_template[] = {
>  	{
>  		.procname	=	"max_size",
> @@ -6627,7 +6629,9 @@ static const struct ctl_table ipv6_route_table_template[] = {
>  		.data		=	&init_net.ipv6.sysctl.ip6_rt_gc_elasticity,
>  		.maxlen		=	sizeof(int),
>  		.mode		=	0644,
> -		.proc_handler	=	proc_dointvec,
> +		.proc_handler	=	proc_dointvec_minmax,

If you need v2 or as follow-up in net-next, please make it u8.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>




> +		.extra1		=	SYSCTL_ZERO,
> +		.extra2		=	&ip6_rt_gc_elasticity_max,
>  	},
>  	{
>  		.procname	=	"mtu_expires",
> -- 
> 2.43.0
> 
