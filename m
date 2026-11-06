Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934896;
	b=Nv3nF5/Dg8m3Uw03nwtTuBP2Ei8/oAj5dI/P5yxiPIqqaBSuGgB4flUXI/j8di+Mbda6
	 Ow6I9ZHZuJxfSMbxDh+7hrVLejbo6DDg7IvAhH55injm6sQmDnrzJSbXIOGhpx2kL0aX5
	 GapVz6UthllnClvV20YJXVbHbe/vzpZugXevr7LVRLlk8tYDWMVX3xVNJGH/a/dSH33VT
	 0M8EQmO6ur98x/u37Ka8sCQ8cbllXHhqsv0+UG677DsoIOsBmQuv63+KHCAOnHnvRWbar
	 K96juz9XA1/0XZUvTq9I7LtPcxIj4sXZvDdi6g8eBesUa98hd8ncC6msHEuliNSIl5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wJj0oR2pSKsMay/M1e8Ih51asYPlBe9zasBmF6ztsDo=;
	b=3GWD+VzOqHcnVnqdwiW6eJFVe0ZAUZ8VA1Zwu09ygfvwBo+QF0QDjX/zNX7KrfxQztEm
	 JIS9b7Xr71Wjl/O1iRqcx079SY67P4RbVC8UTXX+VSEYdS7Zu+GkV0+ojE+9qLMS8Hr5q
	 BUi7H/RIujP+sokVwODA4DEvXyPo/w2OGaEFptHtf04rJ+QWvvaW9H/lUn8XPqZ/JN+eZ
	 kfPAPwIBnEWJZwzRycSerle4rBovHFLYGKgDDOlgH++3ajN31E5eJc3V+kBzkBS3HwoHH
	 BLAHyofxK5mxGhc3nYLefOK+lnHVyYjk/pCSKo+AkZRTMp12cpjQ85BAyOsgatnDmgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2gj7zZJ;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77048606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 03:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77048606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2gj7zZJ
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eafa528803so76320e0c.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 19:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934894; x=1794539694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wJj0oR2pSKsMay/M1e8Ih51asYPlBe9zasBmF6ztsDo=;
        b=y2gj7zZJ0s84u8Y3vAQA6OUE3k6+rRtGJ8LpvPBLcpePX2omhpXxg5HJV5wz5jodfw
         6Zz9Ondu5uJBs0o0jaDhhgOVSCpujT6TiBFw1OBCN9+LBcZkhH11J2CltoZbCEj11ytS
         tcSyV4q8ap42K0iPksccTp7UMzX6jMkZdygmrx+mgjw1tapU4z78oDH1tokeDA3dHFdR
         HP4Kt6YqVDtbe9r7OwpsfRF/dIIJw9lPEqkPdWbw03xjxM/Dz3m9fMAwwj7n2mUeyrWI
         65F5Gs01U4R0z2zvaup+YqCw+iU+jjjK3WjNHAXuMoKcK35Uuiyqlm/OKBtMPgJJaEQY
         5BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934894; x=1794539694;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJj0oR2pSKsMay/M1e8Ih51asYPlBe9zasBmF6ztsDo=;
        b=JzNsvwPea73ct/wbZ6MEJJsPcpROpAgNz/pjOOBGEzeEDp9L6OLM4Ta7Hlo/Kuu11d
         KisLX29JY9v8qoKCcs/Dl9QnYnovLC5L+/gypkKS+A85aoybx2L5sisOiXgo3cUIj/+z
         AqVpS9dCTbGLntrOJf2t7r28HEV8LNChoj3BPILBt+HRHT8Don6L4sley1kIgqIz6jpu
         AQjNX0IUm6I1Rgdk0jZ//BLudfHJ4E3V30FSU2bstsrkoI3SHq7tM5E75m62Z3qJ6BJi
         nJ9F9rVMqJvuCl6K7S/Ut4i3FopdEsZf4EYtjjvq0d6bGY0Kwf3bzRihPGmG+nj1W/aC
         O2dg==
X-Forwarded-Encrypted: i=1; AKwUvByRY3qYtsLkkk+ZE5ou8qHpAphkAGWvkmOa4Nks5/UpeWzcmCBizXB2LvZj+86d5/ZEp5NIHuc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WTAlsixDHUhyiY7KW/aUr+VWLjDwLt0fyHv5hZDFEipHbxRJS
	xgzonOF/0m9QoX6sRwTd3gfr39lD9uopJVMos4Ee66yviSLhEmgob409
X-Gm-Gg: AYBFou1BZpiuBooMevr6lPqflyWGE7UQ52Bzh0Xqv64qDz+ayUz0tAZY0gUaWtQbrR7
	FTeCkZs93tmGPNqMPdhKGSlYB+KyuaoCLisb6r0Mip1DPFB9ezeFs1shtRn/t0miRTkewFan9hX
	BjVEu4TJD+q26wCkvgsW423ej7jOCRRzvTFzOeL1jpk7NHW1lWGpMXbLyZ0xN+56VpaQGUWMzRk
	HsMEuK5dOb9LgzBF1Oja7XLpPPXnF+6ZdmrDFq43PRqMLjYfVv6YBGKiz66XOPmdBphBaOFwRt5
	xwC9gFCzkQF7Wb16yVFe2kwhvPuxD6prwl5PCmo1vEJgYP8emaP5rsX6jsfbH8S8lEO3zhl8uz8
	Yc3J4MsX+OYW5L1ntHziYifTa+WK1hvSAUR/s99ySOMeQxtmQeTfAFrftLwoV6KkSDMHhp61bsU
	udFVUaq9lQtA1hGeJFlPshHEjoBisAH5VOpQE2RJNYa5fk2TCqqOn+TmboGiRgg6w0WeDHLmxjq
	jWOfvZsUL9xzwa6xshlpCvUq+r2l7+FA+ph27E+z/8suq0hFXcD8QYqTnYCvtbnAYNPusjZqsq+
	qTA//4c0DqQFF54mqOhKWkO0ylfvJz/dO3XUvVX/ACpFQpZp2AieRd3NGkdF3pLrghcqmW+6FUi
	+Cw9G55uD9VktRjju4kUE0BIFvziGSJ96IVfCq+0ZCkbiWyxeSt76H8SYy1coo5Fuf0aSlnQ=
X-Received: by 2002:a05:6122:ec5:b0:5ea:dbae:3cb1 with SMTP id 71dfb90a1353d-5ecc4431e09mr715241e0c.19.1793934894431;
        Thu, 05 Nov 2026 19:14:54 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64cb602sm473888e0c.7.2026.11.05.19.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:14:54 -0800 (PST)
Date: Thu, 05 Nov 2026 22:14:53 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 netdev@vger.kernel.org
Cc: dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.1e0038bcc3ef8@gmail.com>
In-Reply-To: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net v2 1/2] ipv6: fix cached route reuse for SO_MARK
 control messages
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xia Yan wrote:
> A connected IPv6 UDP or ping socket can reuse a route selected for the
> socket mark when an SO_MARK control message supplies a different mark. A
> packet can then bypass a prohibit rule for its per-message mark instead
> of failing with EACCES.
> 
> ip6_sk_dst_lookup_flow() consults the socket dst cache even when
> connected is false. That argument only controls whether a new route is
> cached. The cache check does not compare the mark used for the lookup.
> 
> Record whether SO_MARK was supplied by the control messages, including
> an explicit zero. For UDP and ping sends with that flag, call
> ip6_dst_lookup_flow() directly. Keep the cache handling for sends
> without SO_MARK unchanged.

The extra cookie flag is unfortunate. Only to handle mark 0 as different
from not set?

Another approach that may avoid this and simultaneously also solves the
other inputs to policy routing:

    IPv4 udp_sendmsg() avoids all of these with one rule: if
    ip_cmsg_send() ran, connected = 0, and then sk_dst_check() is skipped
    entirely. udpv6_sendmsg() already sets connected = false in that same
    case. The only gap is that ip6_sk_dst_lookup_flow() ignores the flag
    for the cache read.

    Simpler and more complete: consult the cache only when connected, e.g.

        struct dst_entry *dst = NULL;

        if (connected) {
            dst = sk_dst_check(sk, inet6_sk(sk)->dst_cookie);
            dst = ip6_sk_dst_check(sk, dst, fl6);
            if (dst)
                return dst;
        }

Would this be a viable alternative solution?

> The concurrent SO_MARK case was identified in the review of v1.
> 
> The issue was reproduced on UML with connected sockets and mark-based
> routing. A separate test kernel paused the sender after it acquired a
> cached dst reference; another thread then changed the socket mark to the
> per-message mark. The old code still sent the packet. The fix bypasses
> that cache path and returns EACCES. The 50 UDP/ping route checks and all
> 54 cmsg_so_mark.sh cases pass with the fix.

this can be skipped

> Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
> ---
> v2:
>   - Replace the current sk_mark comparison with a flag recording whether
>     SO_MARK was supplied, and bypass the cache for those UDP/ping sends.
>   - Add connected-socket regression coverage in patch 2.
> 
> v1: https://lore.kernel.org/netdev/20261030141435.779302-1-yanxia@cmss.chinamobile.com/T/
> Review: https://lore.kernel.org/netdev/179371875338.488856.4546363285391899557@kernel.org/
> 
> Tested on net cb284914e749388eef402938bdb3115fe1f6d337 with GCC 12.3.1:
>   - UML normal: baseline 41/50, v1 and v2 50/50; the same extended
>     cmsg_so_mark.sh has 2/54 failures on baseline and passes on v1/v2.
>   - Test-only pause: baseline/v1 retain the old cached dst and send after
>     the socket mark changes; v2 skips the cache helper and gets EACCES.
>   - x86_64 W=1: full vmlinux, bzImage and modules builds pass on baseline
>     and v2 using configs derived from allmodconfig and allyesconfig.
>     WERROR, KASAN and KCSAN are disabled; KUNIT_ALL_TESTS is also disabled
>     for allyesconfig. The unmodified configs fail on the same existing
>     GCC 12.3.1 Werror diagnostics on both sides. Derived-build diagnostics
>     are identical on both sides, including their occurrence counts.
> 
> 
>  include/net/ipv6.h  | 1 +
>  net/ipv6/datagram.c | 2 ++
>  net/ipv6/ping.c     | 5 ++++-
>  net/ipv6/udp.c      | 5 ++++-
>  4 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -353,6 +353,7 @@
>  	__s16 tclass;
>  	__u16 gso_size;
>  	__s8  dontfrag;
> +	bool mark_set;
>  	struct ipv6_txoptions *opt;
>  };
>  
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -819,6 +819,8 @@
>  			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
>  			if (err)
>  				return err;
> +			if (cmsg->cmsg_type == SO_MARK)
> +				ipc6->mark_set = true;
>  			continue;
>  		}
>  
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1693,7 +1693,10 @@
>  
>  	fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
>  
> -	dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
> +	if (ipc6.mark_set)
> +		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
> +	else
> +		dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
>  	if (IS_ERR(dst)) {
>  		err = PTR_ERR(dst);
>  		dst = NULL;
> diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
> --- a/net/ipv6/ping.c
> +++ b/net/ipv6/ping.c
> @@ -148,7 +148,10 @@
>  
>  	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
>  
> -	dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
> +	if (ipc6.mark_set)
> +		dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, daddr);
> +	else
> +		dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
>  	if (IS_ERR(dst))
>  		return PTR_ERR(dst);
>  	rt = dst_rt6_info(dst);
> 
> 


