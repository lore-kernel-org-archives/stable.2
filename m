Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152080;
	b=KZ0LmSu1/3jNt1BLQsULgrJsBAezA33zuGAD2vZPvoXv6pjUG8WTcniv6ua5Z1wTydgt
	 sTrCZVeanah6wHnrI9oQJ00WnDP+BS9UhVd4sWa04nUd1TgawkZxOl6JH894SyJUD68JZ
	 VK3EqqcrZF4Jej5vepROC9lieufTJ/YWbmLsUp7/IaZBpp9Akcq4spD9NMEr4SNP02xoz
	 XTpRWxPvk/E8kfabR3hMSBKZoXWCel9UhrfZ6JYUNxA35p55o9x+MuJ1pNFiKSoGfgXft
	 RyLZaTrSAMeXJUbEqB9ArrQiNK5IxgXfzZp2AEd4XH5exFgBVbMUS5ckCDi+tFzlSJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UrWtpTOaprLxw1pdrbzZEPDlusg55RRNNxdXSa9SbLw=;
	b=r3WCr8dVthY7oE/trQsjL00UfHhz06ck0EGDy/qDpZ5Rr8H9Lg1SqbyzVO2P+5SdGkTz
	 pGVMIBkq79cBM3wJsKxa/1WnPKveifMa5i2ol9XdJvU1lsBsb7oP/u8pukGBF6nuSMeeX
	 AQr6R5NJYqph+qpOsxq3sNa3/U3+PcpRGPiSG26HF8geGjsPxlKxfg1vZxaqjyrBB9yzr
	 82OLu/pHtsnVET23ONne72D6QufCOhBOq5c2LK5YZ4aFmgaeTlDlTuZxce+OTOq5SNh9T
	 AG7RjKA/bfTVrlkFzVpdyjoP5Da3xu3MuLD+6RY6aOn1gj+8p8HeiSEdACjhIbbwvhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hTgtj1yv;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7AE606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 01:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF7AE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hTgtj1yv
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so480057a91.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793152079; x=1793756879; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrWtpTOaprLxw1pdrbzZEPDlusg55RRNNxdXSa9SbLw=;
        b=hTgtj1yvC4cnaEZyDZLNmULuJLMpTdudv4MNafpl8PEdI0dtDP6Yvcuv95HqUodmoz
         0/v07TzgLkBpHujQnqXe73FzhMFE+m5M2oOdgCi42FQRT3vTvTk6V1wY4mq7aylhoOL2
         l2Hvh1WnGKS28Uad3h7Zolt5yeqarBv70gQ4vRzFbDMkac+R8O8mF402osj51PMoNwyF
         SGOTBKZWAOVCC5ONPFRvEq4GxgE1ycJ+v+1lvpYJf/WmwEJtM9clCd7Y7QwadmsQWjUj
         3ynluaSmAKiibe+kxq56ozzWwNLis+Wn+9Er8qVYa1YubgmP7tpOEzE7GH1sxnujEJ/i
         Bi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152079; x=1793756879;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrWtpTOaprLxw1pdrbzZEPDlusg55RRNNxdXSa9SbLw=;
        b=UhDo0vk7BNJDUA+3S6qinitNl17zYx4cVeB2uGExObtJY76SaL7WTnknsqJ8ocT7/Q
         /gr/ohsxqGCUG+9WWBF2CYEIh9elIigq5z2aFGGKAsbRgEzVJYJ2bPY5cWEDn3wlNgGM
         h0fYOfqKoxzZpJXuN4adrYeENfQchsbsEhguRiFqnHXIOdxqhd+vAp4wX3qWFDQEEXnM
         IQB8ZI73SisMd4HsovzpNKpSr6UygVmoP10OZ1n8WUIzYVZZwyb1wTqxgZbOuuwxq26q
         I6fLdA2xO7HWBG9kngSwf6K0fBmWSQMbF9ADZtrET6iS9Jp7sUVHXcF1BTYyKH2Hdyx4
         kLeg==
X-Forwarded-Encrypted: i=1; AKwUvBwYvrDt8SBLXeMj+gxajxPKQgzLzeyK8iKAKHKJ9sX6em33lt8wx1k+2oyHiBMT6cX/ZO/Jlx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBiI1fHqPfsrp7lKUle5OpEn0yvDb9YIu2DncAt/vmuf2/gcH9
	LcyCh6QVScVGRpmbOcTansHvdGODobh/Jc2vBiNO6Cqfg2XOR3wdC/XuHXbhNgQwl9pPa3vqXgk
	M9y7axQ==
X-Received: from plhx12.prod.google.com ([2002:a17:903:2c0c:b0:2ea:829f:27a8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5348:b0:3ad:25f6:1dd0
 with SMTP id 98e67ed59e1d1-3ae5817100cmr630595a91.11.1793152078926; Tue, 27
 Oct 2026 18:47:58 -0700 (PDT)
Date: Wed, 28 Oct 2026 01:47:58 +0000
In-Reply-To: <20261026003804.61923-2-imv4bel@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026003804.61923-1-imv4bel@gmail.com> <20261026003804.61923-2-imv4bel@gmail.com>
Message-ID: <auFUNX-pPwb9p8zG@google.com>
Subject: Re: [PATCH net v4 1/2] inet: reject unhashed sockets during
 established lookups
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, 26 Oct 2026 09:37:44 +0900, Hyunwoo Kim wrote:
> TCP established ehash lookups are lockless. The socket caches involved
> use SLAB_TYPESAFE_BY_RCU, so memory can be reused before an RCU reader
> that retained its old address has finished.
> 
> After a tuple match, __inet_lookup_established() and
> __inet6_lookup_established() acquire a reference and repeat the tuple
> check. They do not check whether the new object is hashed. If the
> address is reused for a socket with the same tuple, the lookup can
> acquire a reference to the new object and return it while its nulls node
> is unhashed.
> 
> A PoC that drives reuse with a SYN cookie request socket reproduced the
> crash. The new request socket is unhashed and has a NULL rsk_listener.
> A lookup that had loaded the address of the old request socket acquired
> the reference published by tcp_get_cookie_sock() and returned the new
> object. tcp_v4_rcv() then read sk_state through the NULL listener.
> 
> The resulting crash was:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000012
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   ...
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 7.3.0-00591-g0e135910deec #1 PREEMPT(lazy)
>   ...
>   RIP: 0010:tcp_v4_rcv+0x44e/0x1280
>   ...
>   R10: 0000000000000001 R11: 00000000024ca8c0 R12: 0000000000000000
>   ...
>   CR2: 0000000000000012 CR3: 0000000103d50004 CR4: 0000000000770ef0
>   ...
>   Call Trace:
>    <IRQ>
>    ? raw_local_deliver+0xae/0x240
>    ip_protocol_deliver_rcu+0x2d/0x180
>    ip_local_deliver_finish+0x84/0x100
>    ip_sublist_rcv_finish+0x5f/0x70
>    ip_sublist_rcv+0x12a/0x1d0
>    ip_list_rcv+0xfd/0x130
>    __netif_receive_skb_list_core+0x223/0x250
>    netif_receive_skb_list_internal+0x1d2/0x2c0
>    ? try_fill_recv+0x39/0x7b0
>    napi_complete_done+0x74/0x170
>    virtnet_poll+0x445/0x600
>    __napi_poll+0x27/0x1e0
>    net_rx_action+0x2fe/0x3b0
>    handle_softirqs+0xc2/0x2c0
>    __irq_exit_rcu+0x74/0xd0
>    common_interrupt+0x7f/0x90
>    </IRQ>
>   ...
>   Kernel panic - not syncing: Fatal exception in interrupt
> 
> After taking a reference, check whether the nulls node is unhashed in
> both IPv4 and IPv6 established lookups. If it is unhashed or the tuple
> no longer matches, drop the reference and restart the lookup.
> 
> Lookups racing with the TIME_WAIT hashdance, or with a request being
> replaced by its child, now restart and find the new socket instead of
> returning the old one.
> 
> Request sockets that were never inserted into ehash can have a nonzero
> refcount, and a stale lookup can hold a transient reference. Therefore,
> when SYN cookie, Fast Open, and request migration paths fail after
> setting a nonzero refcount, release the references held by those paths
> with reqsk_put() instead of freeing the request directly.
> 
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
