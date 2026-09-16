Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F944238C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543986; cv=pass; b=BnuSL1big46Qx0igaTLIMWMwQiwbJm0I3ws47qV4ss21j0v3g3Rg1diGesqrtj0xy7xsPWxR7ifFG4qzPDMwXHSXBNIE8Y/ZD9AdkxEbUi5XDKpHpoSR01mma4pV67mYws5EB4ph12oTKxAOpVb5Ytt6O8ASfpE0t74emMtIYm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543986; c=relaxed/simple;
	bh=mjR04Bkrj9erkkufpQlRwq76e4C529B6SDKCewiFrYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9wqWbfdJGoNf13U/LZ4RZPjfHKgI1gd4kf/hvpbTsP7h9aLS3tydXWFakfy5uKUoDFwr8+ndwxpXejW77Bn1NOkm5JgA4bsjLm33EWUNVHwQeHfBbUh9v4oVC2Mdmk7pxsPi1uVibr9rhUkpvqe6/AiT9/76CM6iX+dOPICl+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=OJIYvXnP; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="OJIYvXnP"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so465390a12.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789543970; cv=none;
        d=google.com; s=arc-20260327;
        b=T7n82wdT5GeaRIQm7Vbh3dvhBijZ4+ajbTsukCXzqx/rjU3LmYBurvrLWn49LMuYz3
         qHTI0mXUGlzHZBjVGYdu2rCn+2aagQT+g0gtcI2SDitORKOPpTxQL9pPfPvUgPgDtUml
         MYYKj+Z20yMLDzgNFOxFjo88x4WW8ekwmLGRH+AT+4HC0oXyWakt/YsQGV030n6sk3FU
         1oel4acLY/YLs6HisdvgdtQ+V4mTxHUYh6aCjnIVclVtD1BDlp/gxSSdvEnTXYQq0wJm
         udjYnfhAZ0SIPO2J2pXbakg0xMr5HW0lg9KONHPcZBvcnx/96dY8xPrhEhCQXDJgaqjA
         hNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VZpiE0+zzAEvG+TqmxLhQovdw7arxClPfA9bmtpoXjE=;
        fh=IFH2nab9RDXYdcyENi/JZPmBV8R4hokG23dXaQnJHcM=;
        b=dWSprl9l6pRgYZsoy9OOkfLOlb6lNfljZx4Dm6CWRFsKXjlw5hWVpDJRgSf/ptURqD
         fg2rBf0qmvxcFy7bg+d8OlbljfzjZHmF5GoggKJvTz0jFHafrgE7WhORku/sG4ofnup1
         IDGZJCr2X1BTGyvdns146KsbaNgiNdgbzzwlwzG/YZhjWjZqI9II4gnCrPaEHRjLHVKC
         daMbnXQYNpTiWmPN2gXGam51YAMljw0elar/SDLLWhxL0MjbX7LtGojdqZt2R/Mv+Ruu
         Gxdx2siStJnLrV9UBHY6MP8mj8gXkjxYz9RUU3MsRScf/hDhyNQsVUzjCeQNn5llzprN
         HMfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789543970; x=1790148770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZpiE0+zzAEvG+TqmxLhQovdw7arxClPfA9bmtpoXjE=;
        b=OJIYvXnPpF9Lju1/Az7OlaneV7iSXbgSm69SplH0kBg8jdVCwjt9Vz8RRxe1U47DC7
         +wRTs5dhS46ut47RPGJs7xtA0yzzbb9pEIxWn/yqgyhu0L/Bz1I73RiPbe+GYD+F7T5Q
         wDxYxCfFZu5bsIL4Thd6eJSAlbydMPVcUsyLuQalJFDJRlddQmbHKf7UD/axONPtOe/w
         JRa+6v0F8kq5P4Ekx4JZmzYWB7xLD1moz161O0GW5F6PW+RW5UjMSJ5ufEYr/3Vj4m9G
         BhEPsCJxxCvZtiOUdAi+0N+u3EueqbUeDsq0n3bUKO20Ew/oZLyzfBO0lh2oRw3+NO3q
         i+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543970; x=1790148770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZpiE0+zzAEvG+TqmxLhQovdw7arxClPfA9bmtpoXjE=;
        b=btukroprOYm/q+oOoYAxTxXnMGM4lZK0ADP85srsQaXs0DxvYC/P1ygv9cz5FbE10r
         F/PwK301cF+JznV+S0ZwUc1PBlHr+38Dt00mERX37dUgQkbuMEwQqQlJhkhlxzQjDNct
         se3airWE2LHAhqxow7/UjzcuXv/mDCmLOEUNyaOhqojqYJjZ8oLNpYZcDpDr0wrwkVWc
         dzCMiy4/7x3xwqwudpc2XOlNptdQAlxpUeeGa50WydVGbiX1JcOcmo2deti9EvprryYf
         1kQ9yC5qkHJ/kfKX8TwmGMlHl2Ep3Qt/WLBI0L89LrxVEP5ZT+42ERXczogzVVvRXsy/
         b+3A==
X-Forwarded-Encrypted: i=1; AKwUvBxFBWm1N8CDdluN6qktH2zMjQShRywcWAuSblezDdJg9lsOPbrah23cRnRXiajgh+EdcsEykR4=@vger.kernel.org
X-Gm-Message-State: AFuF++mC4Zcdco/fxVBxdv2BHmU9dNEh0y5xtms/KOHXFHiC1h4ZB5YW
	WMkDwRQvzWhxqjtLSY73xVRvFxIzb5sZGOjTQUL+i8PSWlXmZFVXis32xfj1QWu4A+zW/g5QDYD
	ZkxCvre/lxuCdVmrAIN4nOzTOL5KHfwz0ZkVNLHG5
X-Gm-Gg: AYBFou0a3iCXDcZd2qSIlLT4AK3LgdixXX0Mya0bK4rb0mK4TiNMM1GsozVilVMWuK7
	CpxkjOQO68EJOnzGaG8IPd59sWs8AHyAsnz+KhL22fESUUFD4k/gos9jRpmtiRxnXXhHwteONKr
	cotqa8t90yK/mw3hbJ65dIe09kvWfTbMC3fUO1z5LIoA2BXybuIuYtASZgWd0/eOPdvgjX/0Wug
	C/7pjpqQIBKex5Ipzkw11i39gMoQYSsOk2+eP4DvQPZehLIKWQil9ntOhWcbbA0tO+AfHPMAV8T
	5VEQX1qUwuHFU0bpDhlQYg6SqNCE+XZ2OeC1vOpus+d9DhHnw3ruwOdUIO/W2Ih8tbDb5DbWLJn
	wntEYkva6DWzuYdSPLsmdEH2eAsszQzcBM1Ofs8co6BGLqQ==
X-Received: by 2002:a17:90b:524d:b0:39d:eca2:5c81 with SMTP id
 98e67ed59e1d1-39e1e2dea05mr3829092a91.8.1789543969709; Wed, 16 Sep 2026
 00:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916041102.1914333-1-xmei5@asu.edu>
In-Reply-To: <20260916041102.1914333-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 16 Sep 2026 00:32:38 -0700
X-Gm-Features: AcwNN1Xljv2HCFLUQMDufNtEairMBCo-H1BK8G1-p5r5dXNC6bE7Jd1RDn7HVDo
Message-ID: <CAPpSM+SpeOa5uo5rffXejDa4g9VGphp1GvirJgUWze-O+cQyzA@mail.gmail.com>
Subject: Re: [PATCH net] bpf: lwt: clear stale IP control block after pushing
 an encap header
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, co+ff13a35f73bb7891@bugs.sh, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> bpf_lwt_push_ip_encap() prepends an encapsulation header and calls
> skb_reset_network_header(), but leaves the IP control block describing th=
e
> inner header. Its offsets are relative to the network header, so they now
> point into the encapsulated packet.
>
> On an ingress lwt-bpf encap route a forwarded packet carrying a Record
> Route option then reaches __ip_options_echo() with a stale opt->rr. It
> takes the option length from the packet and copies up to 255 bytes into t=
he
> fixed-size option storage on the __icmp_send() stack. ip_forward_options(=
)
> writes at a packet-controlled offset for the same reason.
>
> Clear the stale state once the outer header is in place, as the tunnel
> encapsulators do and as seg6_local.c was taught to do in commit
> f967455fb2a5 ("seg6: reset IP6CB after IPv6 decapsulation") and commit
> 44930446dde4 ("ipv6: seg6: clear IPv4 control block on IPIP
> decapsulation").
>
>   BUG: KASAN: stack-out-of-bounds in __ip_options_echo (net/ipv4/ip_optio=
ns.c:96)
>   Write of size 255 at addr ffff8880bee08930 by task exploit/150
>
>   Call Trace:
>    <IRQ>
>    __asan_memcpy (mm/kasan/shadow.c:106)
>    __ip_options_echo (net/ipv4/ip_options.c:96)
>    __icmp_send (net/ipv4/icmp.c:949)
>    ip_forward (./include/net/icmp.h:43 net/ipv4/ip_forward.c:176)
>    lwtunnel_input (net/core/lwtunnel.c:465)
>    ip_rcv (net/ipv4/ip_input.c:612)
>    __netif_receive_skb_one_core (net/core/dev.c:6264)
>    process_backlog (net/core/dev.c:6728)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>    do_softirq.part.0 (kernel/softirq.c:546)
>    </IRQ>
>    __local_bh_enable_ip (kernel/softirq.c:473)
>    __dev_queue_xmit (net/core/dev.c:4961)
>    packet_sendmsg (net/packet/af_packet.c:3143)
>    __sys_sendto (net/socket.c:2281)
>    __x64_sys_sendto (net/socket.c:2288)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> Cc: stable@vger.kernel.org
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Reported-by: <co+ff13a35f73bb7891@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/core/lwt_bpf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec63d..17be476b5717 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -649,6 +649,18 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>         if (ingress)
>                 skb_postpush_rcsum(skb, iph, len);
>         skb_reset_network_header(skb);
> +       if (ipv4) {
> +               memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
> +       } else {
> +               bool l3slave =3D ipv6_l3mdev_skb(IP6CB(skb)->flags);
> +               int iif =3D IP6CB(skb)->iif;
> +
> +               memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> +               IP6CB(skb)->iif =3D iif;
> +               IP6CB(skb)->nhoff =3D offsetof(struct ipv6hdr, nexthdr);
> +               if (l3slave)
> +                       IP6CB(skb)->flags |=3D IP6SKB_L3SLAVE;
> +       }
>         if (is_udp_tunnel) {
>                 size_t iph_sz =3D ipv4 ? iph->ihl * 4 : sizeof(struct ipv=
6hdr);
>
> --
> 2.43.0
>

I just found Weiming post a patch solving same problem:

https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/

and that patch covers the cases I didn't consider so please ignore this pat=
ch.

Thanks,
Xiang
