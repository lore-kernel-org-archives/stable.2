Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376336;
	b=Lr7ydV4ms/ZyOGJ+7WZbvhszuloEFXAhQUbr90Fjki4OELryOvKItpjDcz1EcL5CzHgN
	 g8KMOwE+L0+qmJe/2rYoO9IUksmL1y5yb45VJhuQ+GpibCT9FDyf2Q8s7XWRnf4vgVKxb
	 CmSqdYgYnd6pWeqz5uC5/CefFv/x1kJr+tRMYnJIIBiliXm0LLa5gvKzJhnnvhKynkuJk
	 UNEdNXc7gOJ61R7GkSOTlbomWuKQMSDVVJUqb9ix59HwT2zj9lLrj8FPCPyTIJkEsi1rR
	 7898PCspSz3pA6On1VBLNuvi9+aK420nGrW4wL7gO1FohVly7Jop6NNmxrOo8hggLuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UVN9g4RWdwp5/he8LF058qsOA18MIA0nq3SVY0VenDU=;
	b=AX4SUmapEYZRHNtGTGtwP6vfdt4cRx36WIasNCMdY0DTX43Wj0dFz8yZQ3BTqnp8Nj2S
	 CCTxXNgJfAKbxq3JG/sPVsNLNf+vDr2OK4fb+gUHLE/JFG21z+M8QUGZ2Rjuqf8gtksjO
	 b3gPhc9CUlOr6ZkYKqCBCb9pxTYKuZcwzoU71OiaR/NUCSJdMmzDSE0UIw6MSFffOnZVT
	 agp6LfvQm8Cv/8cCnIQrWHheh4z/0kgpRRgJODK1OshoO1lt61Pd+K6wmLu5KRKkGahuK
	 YI+f5fslVcdVUiSjcn0lv1IWC4/j6cZAUVgWh65JwZlXW9US8El8wo0nGhwWxzkopDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/b6FOCz";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B570606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B570606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/b6FOCz
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e20edd106so740554f8f.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793376335; x=1793981135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UVN9g4RWdwp5/he8LF058qsOA18MIA0nq3SVY0VenDU=;
        b=g/b6FOCzOFlOpRQPAWM7QQdQwfA/v+03wjKewq/H51+O3q089hlqictJUYXPfi7F4t
         fON86ko4exfQhOzHAkWFRwIZplM7VlN2tpOEkLMCOIThqhO0XVrMoGcXlIVpPT5+cdkc
         sV3GACLdrhk3fr8IOW00299gkrCyhuG15mrAFWXCnMDnfjt6bAHRLiC5LLDxebhHn1fd
         vuE28u2nYX55IGHqqO+55MqcAWtlefC5QB83vV0XJz3k/6d12b9W9QoZyagAJ6v3FKQB
         HaTsvZCQ4UgcxryKdADU+XTi1uvu7lcSz8VrD1CKxf4pnYY2yhQJ61ZAJJgi6szEgZZI
         idIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793376335; x=1793981135;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVN9g4RWdwp5/he8LF058qsOA18MIA0nq3SVY0VenDU=;
        b=SNA9MEdpY0aAoA4oiOxPxbzFObnkAd4eVYtp8D/+6yPZ/4a2sG4lzbeyErCCTPRfsh
         iKc3jjaRKhPU5OzSscEMfO6KbxKg+EH0M8Ww1bD3yOftq769Jj8iw5C4f2vQjC1JQdjm
         Z0kibCIW/kBDAJxXZA8VpFYDyeU+/7LepjIoX5g5nnIPJULr6bhIDFhSjVZB778ZBMQ4
         txAmTTpOnKMWfeu2J2f6wZDEmwp2d9EGY1HF6PG/4klMt4B3D1AzKV2tt8iU0cQotgF3
         tu5/OY6InLgwkcO75/FHxiiAMwEWSJ6Us583Vv5gpaiOf7uYlBq4/xYRjRGK7+nE6Y+X
         ZI9A==
X-Forwarded-Encrypted: i=1; AKwUvBz001elktMy3gq8+r72JRS8x1MXGBA68z8PYpob+TkLSKJrYWJ36IA2VhRGsHMZSRM+CC0YT90=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMhSKHf37ZxYT7z3Zc1GfcFg0JCrXOJE2NW82WwUMzxiFGbSuY
	MsqFM6OTSw2H2715p0d8Hui8rF4HqIXUiW0Bovp9AzmZqttzahaBzOka
X-Gm-Gg: AYBFou2LRRxdN4HtrgK3FnrAenLSMN/BCTA8bAxNpGm1zkuDzD/hpg4CsuIUzL2Vefd
	In9jNZ0odn0RXSjdPOYtDLUKIsWnVcy4bM+e5+gGYzEl6dvaCCocN9pc0W8Q303nulKbG5pI1QS
	hgcZK94qD2ZB+CNfCZiVgA4iP2uOUzLwc6v6OirI0ZCCee/jOE2c/MDm0kz3Da736EfU7ZCrM3t
	57ICPq9OBGCoai1GI7JhFISI2t9OqilbFXK2vfnUL9o0KBmjII9GM9dQ9qdgCXHisEA6ABRuHwg
	/TinfpmSrgduwqOvTN1iitazZnPOaz0DIWd6IzmPx49NRZOgu84zrHIGeSLOEO3W3Mghye0RIC0
	jNiVuNc7jn0xqCK06KDkDpfBLEG6Dv7wexSnuyj1923yB3OS77bg/jibefVJYNnjGC7sUmB11JU
	J4JzTLc1p+sfH5MPc+ykRk76AzaqPbsqI49j1aRPIxe3yloakt9BErRSsFQRz0DQ5JfZcf+1PmA
	zUp51lwgnpNrMOAWevSF90CllxLRfA1MQuav2S12q6bVs1lHN1TdnFHcdNsAIffRTZFeLCaLqSs
	oHp45JYqR2qMssuGiKDDZVmIwR7+5Tu/ZRDFG67K23JasSUoJnF+YeGzIjTa3JJM2OJ6x6FqCmV
	eGdTE8lCwUbM=
X-Received: by 2002:a05:6000:4284:b0:48e:3678:5112 with SMTP id ffacd0b85a97d-48e6e2ef7b0mr6204489f8f.21.1793376334674;
        Fri, 30 Oct 2026 09:05:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b77f06sm3987846f8f.21.2026.10.30.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:05:33 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:05:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hangbin Liu
 <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
Message-ID: <20261030160532.4832d994@pumpkin>
In-Reply-To: <20261026044808.613-1-n0ps1edzz@gmail.com>
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 12:48:08 +0800
Zhou Qiuyue <n0ps1edzz@gmail.com> wrote:

> rawv6_send_hdrinc() caches the route before handing the skb to
> l3mdev_ip6_out(). The VRF output path may replace skb->dst and release
> the original route, leaving the cached pointer stale.
> 
> The function later dereferences that pointer for statistics accounting
> and as the output device passed to NF_HOOK(). Its RCU read-side critical
> section starts after l3mdev_ip6_out(), so it cannot prevent the old route
> from being reclaimed in between.

Doesn't it also pass the wrong rt->dst.dev value to NF_HOOK() ?

> Reload the route from the current skb destination after
> l3mdev_ip6_out() returns.

Have you looked at just saving rt->rt6i_dev locally?
The rcu free of the temporary rt_info is expensive.
Last I looked it has to kmalloc() a little structure and later adds
latency to the softint code.
The thing is some applications can send a lot of packets through this path
(and I mean upwards of 50000 per second).
So even a kmalloc/kfree in this function would be better.

That might even save the rcu_read_lock() being needed.

David

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

