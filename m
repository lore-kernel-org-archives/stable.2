Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793231939;
	b=0N8WRDcqOlBuGp58ZRkexEklRL4caRxdZIdnY1DOz81nLRJkKreezNuphNKiNN5NHtqu
	 NkOepSHcRNj67gNYaC7I/I/OalwEYO83ceUAzCyaBbO6PdD43BUqrFPVY+W7262PpBkiI
	 G6YUFaT7ksLuuadCw0roOgDdNS6jWHDufWaCEDTTqcKHCE0WWm9m19BZ2mqY5ObrWyMqA
	 TTRmnx9HrjvoUsaxTXnwPZiqFN2vjWMcquG9lW2RgkoDoo4asFqIo8VncLvwL757vomYP
	 MBLpxb6KNJkiKcm3d0VztMm1XdHM80hxMWd1TuKJn+lIkVS43XePzhfUl4ypopOz5tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
	b=BNEL1jLGo4oyDid/u+eWvcAnAcahG/4JsPyQv9MTm8PH/T4oZzZReeSWKriWcJ0dzxbi
	 uGwlQ34Ht/ymOxukDl2nmIJzxdqXYZF+kYuO+7G8mDDdD/MV5rmTQdSCdtHmhBt0Z2fU3
	 /bD9309qfwGp/aY8gu0q5f5F9joZdqkUqzSYjJki2y83u9w46n9ThkETcB1OJq13n89H+
	 IKHbOZy9LeB1zTEHW6p1FQPNiUYfXyRu2Saq/4N6Sp+RAC4eFo17yzEc5Fn4PQgH4x5Yo
	 NM2omKB8I6zRgfll1FxN2+bh6x+QqMWLC1dI3VGY0Fwy8kDvRNvEEeJLwWEg7h6I00Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p2ziaZ2z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF217606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF217606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p2ziaZ2z
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-14fc585291cso1402661c88.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793231938; cv=none;
        d=google.com; s=arc-20260327;
        b=lZ7lILSB5H7jD+qw/7oyDhxxFXw8Uz9jF6dEpN4/ieyKimqmkWZRctHPhBgYEsxYxS
         6qV3SKW6neLbFEaF9/wi8cJI1VZ+9rZhXsvrU/qNFyzyaewbOjzCs9MTHGmlye6X1dtw
         SPp7QL8jEh06N5ine0Q49BGQk94df2dd4VV8rZVHIzDwJ+QycSSzpxMfsWzwEJb9IR++
         n3G8WA0PvZ3yMBLYqiyA5EF/qu39mjtfXlcRLSnGDcqVYnpbDzJf9aqUmsj9738l5sNt
         jDDFXDFCYTaOP/Qrc9EkvRwtCNRaNWkIpst0XNPYovBJrC58UXrwOAk7vaX2e90beHp5
         255w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
        fh=HIzeY0btifhuMW6c+bOKtHY3DsWn1IyNaj87PFEEHSw=;
        b=XqsnZLRVBpSKLRN1NG0xvQOME9kTeCyEpxRaWQ4PUs9VmD6SNMVgIoS+9dTuUb3ttm
         3JvDwYkhr9B/cUOogUb09LdL5eq1MzYF5MYotGu5z5gb8kyvSeUQH3uVGJx9TVEOWQ6b
         RjT1nQ5QnMdFbDoDL5tlHGEjDLFQFFVA/SIFJ9VDNpQ32rFoZOBLe2DU6QiYKvm1oqdl
         KU6kN9VvxYcXuvSlJu+cXBnYIZa7VpIxztA9wx2t6a/YShIaTWYe1NuRwD+MnYA7LTzF
         lVKpfAV17LB7BI9G+nsxtiEfy1h43qhZTc2K1/1QRicQ8bEZL6qWDVLnB/ChdLXDM2rC
         ZoJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793231938; x=1793836738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
        b=p2ziaZ2zEj0tj51mo212n8y58ZhNJzQfl1SKvwtMXV1nveewE+zgf/2ouW2pTE72AE
         gDZRv0gWRgAG6IYa1/VulzGbUgzBwNgeqTop9deeLfCowuVESEj0j8ejqfpo5EXKg76q
         nkbP10H1WOarIQrmMvsTrvt4EyG7qe6KaWxl74tidv2sfzzDe6UBveK3Q8u9Qixoingv
         yqHqRjzTnMm9sAcAygv8pjAIkpwxyXuPn5aAeDE8duZK70B9Hf5k1pq7eKUm8KLAl+WH
         UlbJmjt1UZjH7yI3HyZzvF05GOoJZ2C5m/CUQLMyNFdn+3CMbjYKvMyC9NGSAezcKecC
         ZMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793231938; x=1793836738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkIauolFUP99goQic+ZO6OZzr0A9X9K2N+ri9gvCkgM=;
        b=MjB1b79jQGbBapMNPyO6OkFQyb1Y0LaHu+xRoKAs2WGhSMrZwo9cwsChia/tJOAwoL
         txSNeATmJo2ZKupLqDSTvWdjaSqV0v+NBXyWYqWAxjxtuelgDAXG+U3W2BDdf51qF61h
         Cnn8tRE3TLjpQFhyjdKD5nMc27qjsLRw1TjOC7XbKeiaoWsxOcTqx7FSHJZKSVwS1w79
         6yZWCrPdgNYT0Z/+nffsyXc6q8v9BuKQKkKdLoX5tVnSxTOjK/8V+k7wonRAqkrsVz8j
         SD1qOwlaVmTgQsEpzFU4uiMWRZwTGnOC/VmhTyIp2mvaNhLYkLkkZF8D03UX5WZNd2eO
         6LBw==
X-Forwarded-Encrypted: i=1; AKwUvBxTEfC4Pvq1bB0HwTNyzQYl3Wd8vDL0fUeeS9Q0a0i5IScp6PITg6COzIwDGXdwL1tA7GJiX1k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqxuvCYvlK5InvoaV0BhQFsu6Gw7760wdgpLux/gSRSleo8FFt
	JyvZfeFWan2xsYSwX8sPjiC2gCq3UAL09ZM9BFl6CQv4IJT1lM2lAfurvJXvp3NQMbchLJz7A2b
	wW9S0pjMbvCZy+b/OE4GET4ECbJ/LPAomljD45P21
X-Gm-Gg: AYBFou3fiumAikDJzgfdtriOIzRQKOCpzef0W5uYXDqSvyXRA+PSyCHVN/tTLWr18fn
	/Eki5rKGR0dNYHZdlykkFSWJGxP1o4YNsf1ylPO5/5TqUhJCK9ZO5B/+myrPKYywP7z37FXqeWz
	O2mRoZ11X95JGEkscorCufqW3Iu/xj3PNoWOaMceHPnzJ7cAjwgDGWam9UcHryI2NkENN2Z1Fsl
	iQa1tDkl/bBmwDB3LuIy/PKsruuNFn6MVhbb34UCYti9PMrRWFVkQPbRNZ9KhomwjclA4BRKpaf
	1N61zMR03kW5Of8spGSJupXFarClzE5iZmEQAzXKErwLC2Kz7JCDh2cmdzLPMqgixAPFQ3A6qTi
	sAj/xyekPeIR8353vpit42Qt3hW3JcSSvu1Xz0r3fpOUQHRUCt7TzDiBbgIcNeXKoQ/GXmF5iTK
	xTbVVIGbWY19SWySXB9oTZCcm2vnev28aCNzmYwMl3BDNekTOeFkm7fH3SbsKXuluwHLmZeKCdI
	xdFpi1djg==
X-Received: by 2002:a05:701b:2515:b0:151:94a6:6f5f with SMTP id
 a92af1059eb24-1a6cd3a138fmr4261057c88.10.1793231936824; Wed, 28 Oct 2026
 16:58:56 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027104701.296240-1-jiayuan.chen@linux.dev> <20261027104701.296240-2-jiayuan.chen@linux.dev>
In-Reply-To: <20261027104701.296240-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 28 Oct 2026 16:58:45 -0700
X-Gm-Features: AclHuK8KBdIT6N-DIpoNdJxwSjtvtUNtTI2wH9Yl2XvO51fbaw005XBERgZQ6aU
Message-ID: <CAAVpQUCBBaVmaZUv+D+a4anSbGSR_pKukYVXvRJRzSGVnjb2kw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/5] ipv6: restrict gc_elasticity to 31
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Willem de Bruijn <willemb@google.com>, 
	Maoyi Xie <maoyi.xie@ntu.edu.sg>, Jiri Wiesner <jwiesner@suse.de>, 
	Gerd Rausch <gerd.rausch@oracle.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:48=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
>
> ip6_dst_gc() reads ip6_rt_gc_expire into a u32, but gc_elasticity has no
> bounds at all, so writing >=3D 32 shifts a 32-bit value by >=3D 32 bits, =
and
> a negative value gives a negative shift count. Both are UB:
>
>         val =3D atomic_read(&net->ipv6.ip6_rt_gc_expire);
>         atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elastici=
ty));
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
> Make it a u8 and reject writes outside 0..31 with proc_dou8vec_minmax().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
> Iwashima.
> ---
>  include/net/netns/ipv6.h | 2 +-
>  net/ipv6/route.c         | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index ffda15318be59..aefce37c04a4f 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -25,11 +25,11 @@ struct netns_sysctl_ipv6 {
>         int ip6_rt_gc_min_interval;
>         int ip6_rt_gc_timeout;
>         int ip6_rt_gc_interval;
> -       int ip6_rt_gc_elasticity;
>         int ip6_rt_mtu_expires;
>         int ip6_rt_min_advmss;
>         u32 multipath_hash_fields;
>         u8 multipath_hash_policy;
> +       u8 ip6_rt_gc_elasticity;
>
>         __cacheline_group_begin(sysctl_ipv6_flowlabel);
>         u8 flowlabel_consistency;
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 94e5ef1c4f83e..abc8b811cd423 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struct c=
tl_table *ctl, int write,
>         return 0;
>  }
>
> +static int ip6_rt_gc_elasticity_max =3D 31;

as you need v3, s/int/u8/


> +
>  static const struct ctl_table ipv6_route_table_template[] =3D {
>         {
>                 .procname       =3D       "max_size",
> @@ -6625,9 +6627,10 @@ static const struct ctl_table ipv6_route_table_tem=
plate[] =3D {
>         {
>                 .procname       =3D       "gc_elasticity",
>                 .data           =3D       &init_net.ipv6.sysctl.ip6_rt_gc=
_elasticity,
> -               .maxlen         =3D       sizeof(int),
> +               .maxlen         =3D       sizeof(u8),
>                 .mode           =3D       0644,
> -               .proc_handler   =3D       proc_dointvec,
> +               .proc_handler   =3D       proc_dou8vec_minmax,
> +               .extra2         =3D       &ip6_rt_gc_elasticity_max,
>         },
>         {
>                 .procname       =3D       "mtu_expires",
> --
> 2.43.0
>
