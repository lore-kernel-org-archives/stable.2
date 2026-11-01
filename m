Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553357;
	b=y0jJ86hRmOn84bg7aQQLxs4dBedSVQPW4wKjBp46ZbZUVFL/Ji/fI7T0jkpgt8jaSNM8
	 DBYARk3VACUcsYE9YnYp8a3+SetH8pJlfzloFzk3oaJIbpPK81pwixH1tzJ8xo9n9Lrl6
	 bnpXEr+Z1Zrb/KeeBIsy8luAJfAlvWA81730ZvB7CIntzru5lHCnHnSrGaPyfasdu62lQ
	 wvMi2MuOd9yb8eaOhUmKkT6oU6GR44kTblFiJnPdlvmtXPf6t9aBeHoltFHDFuVpOXdZH
	 NFS97aCAJEnCWmc8lqs0YrL2RZIurQuc8h8pn7zkP2AlIwQIEP9Ebss9DgU3UD8+Xig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ri6mm4g8aC/HkC6PYUflTSf+2uZxNNs5OIicG2gsEt4=;
	b=Nes7yg+QsTDKdEJPqnQi19+eGPCGO9ZzacXQUAGJCIbAZq5bvl7AYqfV3vv4EelgerKn
	 KPLGnk/A/3QpTRI1B6AWn/AWEBoDOQ3OhU91e8IJBNEuLSRD+c+KcJi5fx3s6iRnM1CrD
	 cXYuLBhTTxbw54XeYFamY+Pyz6Cm9yAyBL14i+OZFBt794y1EWSSTEMMFXF0ZQZCMYg6A
	 fXmnz4irDdC5AgRTXbWVT+RNAos5KhC1kRcWjnukAgPdOBOwM0Chpf78UBh0xWkpEumiV
	 M1MjLI0DjRBFdrneF9d1mQRxQYjugMKbLYTzQoxPgd3CuG+/o8odfde23nZ5VuN9cZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="QuEK/AwJ";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8A606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 17:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B8A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QuEK/AwJ
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9821ca96fso37332505ad.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793553356; x=1794158156; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ri6mm4g8aC/HkC6PYUflTSf+2uZxNNs5OIicG2gsEt4=;
        b=QuEK/AwJKi2Ixp3yIC2uwMEYm1rKIp/m4C3I3y5ZCuigDFWMM24QOGNikavpmDq+cu
         fNftJaeLqhSAaV2WDxpGWVzH9XDi2PTm00P4VxgSJMBI03FCfvAoF6wPLw/TPaZoaXUw
         4RrJpNvVAQQ2z7TLcHOgHKQbvahMnWiE9olc+BFh+pUTaHNO7Pcvl0ffStldf42JsmlE
         jUcJectpyHQZO2XmvmsiHSWpd1TvCN6ifJ80hUhTlYDAeDZXeEtFL7Mki1V/oHi7dQJG
         VUsKj/y+DdmOTWWZzOKPxu2dyx3iMJKVMvbeFPZiKsvYXZvH7ArriBxBKiqvUrs7oiUi
         y7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793553356; x=1794158156;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ri6mm4g8aC/HkC6PYUflTSf+2uZxNNs5OIicG2gsEt4=;
        b=rlQYYQJoL3deJWEUCLnr2KxrI7j4QN24x5/Cu1W00bhSZDgmgrpf67jNRfeYT0Ww4n
         Ov0w8rcUHRA+jkvx6aNvb1BsZfT36xC3hOrX1/2vOrMekO6t9ZgzozhNeGkGhL9vNQLA
         2r1HPispeQ+BXMEIE1aMlJwSAMAMSMVZCgnIrJZKqJsV6xAFQdyyco8Tn/dnExunbuMv
         ddls5EY4Msvm+M+Fghzb+yRLrGwccNDUaVEE32LjIRCCazJ9KHB+rFjzaJVUv83kkWZV
         NkPHiAIjNzjE0Ohaz0VujT7oECLu7zdm1CWY6mdAZvLlkqsLmP83YQK9uewmhdXvk1Ha
         5bNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmcPsvuqeEj82g4cxuZxEpdXVEy0xGNi8KS3xC1F0F+jZ0p4IsPqC6l+dp/Tt6MrvujyCJIkI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CIFCG2uBaTV0HKx2TgcaTzrua0YYk6pJRsJsJ583v+RzfPPdT
	4jwhzTfr8+BoHvot0PPfYW1+g7FgXZROZY7AI8jd5LarVIwH4qpYeh2ZrHRWbogsgaDKy7AVRkh
	v+gbhbA==
X-Received: from pjbft1.prod.google.com ([2002:a17:90b:f81:b0:3ad:cde0:ea04])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c08:b0:3ac:8741:e2e8
 with SMTP id 98e67ed59e1d1-3ae8957cb02mr6841418a91.8.1793553355750; Sun, 01
 Nov 2026 09:15:55 -0800 (PST)
Date: Sun, 1 Nov 2026 17:15:55 +0000
In-Reply-To: <20261101075145.698399-1-sgzhang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101075145.698399-1-sgzhang@google.com>
Message-ID: <audwphXNeZhVItS0@google.com>
Subject: Re: [PATCH net] net: count last skb of each sk_backlog pass in __release_sock()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Ray Zhang <sgzhang@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Decotigny <decot@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 01 Nov 2026 00:51:45 -0700, Ray Zhang wrote:
> Running 500 concurrent TCPv6 streams (neper "tcp_stream -6 -T 1 -F 500")
> on a 2-core Cortex-A53 (CONFIG_PREEMPT_NONE=y, HZ=1000, LATENCY_WARN)

I guess you tested it on 6.18, but note that CONFIG_PREEMPT_NONE
is no longer selectable on arm64 since 7dadeaa6e851.


> triggers resched_latency_warn() in __release_sock():
> 
>   [ 3655.311821] sched: CPU 0 need_resched set for > 100006892 ns (100 ticks) without schedule
>   [ 3655.311889] Call trace:
>   ...
>   [ 3655.311944]  resched_latency_warn+0x7c/0x88
>   [ 3655.311958]  sched_tick+0x1c0/0x418
>   ...
>   [ 3655.312578]  net_rx_action+0x238/0x438
>   ...
>   [ 3655.312641]  do_softirq+0x4c/0x90
>   [ 3655.312651]  __local_bh_enable_ip+0x84/0x90
>   [ 3655.312663]  local_bh_enable+0x1c/0x28
>   [ 3655.312674]  __dev_queue_xmit+0x4a8/0xb00
>   ...
>   [ 3655.312782]  tcp_v6_do_rcv+0x240/0x5f8
>   [ 3655.312793]  __release_sock+0x9c/0x188
>   [ 3655.312806]  release_sock+0x150/0x168
>   [ 3655.312817]  tcp_sendmsg+0x4c/0x70
> 
> __release_sock() can loop past 100 ms without calling cond_resched():
> 
> - Each outer-loop pass drains sk_backlog, but "if (!skb) break;" runs
>   before "++nb", so a pass of B skbs only adds B - 1 to nb (0 for 1 skb).
> - With 500 TCPv6 streams and NAPI sharing two Cortex-A53 cores, runnable
>   tasks keep TIF_NEED_RESCHED set on CPU 0.
> - During spin_unlock_bh() and TX softirqs (__dev_queue_xmit() ->
>   local_bh_enable()), tcp_add_backlog() coalesces arriving pure ACKs into
>   a single tail skb.
> - Repeated 1-skb passes never advance nb or call cond_resched(),
>   triggering resched_latency_warn() after 100 ticks.
> 
> Restore the do-while loop and drop "if (!skb) break;" so every skb
> increments nb across passes and calls cond_resched() every 16 skbs.
> 
> Reproduced the issue and verified the fix on two 2-core Cortex-A53 hosts
> (CONFIG_PREEMPT_NONE=y, HZ=1000, LATENCY_WARN, latency_warn_once=0) with
> a userspace reproducer over /dev/net/tun:
> 
> - CPU 0 runs a TCPv6 sender and a second runnable task while CPU 1 writes
>   pure ACKs to /dev/net/tun (~30k TCPBacklogCoalesce/run), sustaining
>   1-skb sk_backlog refills in __release_sock() for ~400 ms (ftrace).
> - Before: CPU 0 stayed unscheduled in __release_sock(), hitting
>   resched_latency_warn() 293 and 275 times on the two hosts (> 100.9 ms).
> - After: cond_resched() yielded CPU 0 inside __release_sock(), with
>   0 resched_latency_warn() hits on both hosts.
> - Also observed no regression with the workload from
>   commit 16c610162d1f ("net: call cond_resched() less often in
>   __release_sock()"), "super_netperf 4 -H srv -T,10 -l 3000 &".
> 
> Fixes: 16c610162d1f ("net: call cond_resched() less often in __release_sock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ray Zhang <sgzhang@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
