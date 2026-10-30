Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383097;
	b=d2MGi63VmEsGTkYWejWWtPM7MlBKiy4GmLBdFw9GJXELBZdeIXeKMATZdmaHnoBvR+rn
	 RRzjOF0PUvkyyJSgK1iy60lb25eRtzMRnu+ssivEpcwWJCvi4Qmlc4c5dmOf9c6l29jlI
	 YYiQBUr/hfG/Sutxdyo6tI59GGn/41T56eQdMqghNrf4hvSGopFTKkv45R5W5JhrMyY0I
	 k6vo0I810Lw1+ahdYxVdn0C7U7hGtcxHk0Uz7X2cESBojUpuKfnXof0fmMn6ExCjgaabh
	 1xYrTGAEkSOu7P6UupMSEXTj/FJdMIcQXeURlzqyevm9D0f4wkHjCu6V6evJMsvpsAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aTzRns4P41LTvEjZitBtZ35u3x5iyyKI3BwYPIuLk0Y=;
	b=QvP95LzMInkiffrda4FvTWWUIWe6POwM+6KddXLlCDKrHJMweKvmdz82O9vP8aE6wHYH
	 /79uKXAZBfd3jpSfak45JTsSmqlpfCjF1jW5epG+Su9XZmDoc4keztbmpSBh1DLezuuvG
	 ujtbpCduvXsLcJVNHKuQfRfTBA+TYSOFXeeQ4Qm2QDha7yCycmOPZc80kh3uo+O/H+1a3
	 xixoQ/H2+9rYQx1toSWxC9sROJuRQ3sUW4cuKOyyfkkptZgdliKLCYfd+wV+DzK/uB2Lt
	 e75jeRfSQFvZ251/1vC5yWMySoneHvjeO+3LFvrcyT9vc+EDdnlpYu0X9Nku/RXIahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OH6REcCW;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B7606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA5B7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OH6REcCW
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1915586241.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793383096; x=1793987896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aTzRns4P41LTvEjZitBtZ35u3x5iyyKI3BwYPIuLk0Y=;
        b=OH6REcCWtn8nG/b0uztoyUtP7F0ry1Puw5O7NoS4qy2UmbvdtK8W7ZCkAIPQskbBQ2
         4b0LCW2YEN9QqyRpfuwgwsbRMnjGOr3UteVEZpp1V9uzo82PLbHMfFr43OT4BGlk7OTV
         HZVPPlolJu3NG1SCenT7OaQ2mvaPTVAo4BpQPg/6MkMKDy8pwZNxGkB7vZ0es4BEJw/D
         b5rj5AphjNxt/AAcAtwx2nz2XSJ376aThZv/cCzjLvw3JVdx5YZ7vlQxwAPB9D0O6N2u
         xU8MXus+rt1YKuHV6A7YBNwASV3R9mlFCpX+ovEDHw4lJGoHz1XlzYmzZ54GS9puxqKT
         /Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383096; x=1793987896;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTzRns4P41LTvEjZitBtZ35u3x5iyyKI3BwYPIuLk0Y=;
        b=ovoemuqAe4XZ0D7hRN72XRbWkut4VBA7FQEF9KmwF/0TVV/95AK7ZI8lV/gaaas+ZN
         pOt6LC8/dx92FJV71Utw4Y8X3dQBu++xc3KfWEwR6TGbWgv4glchaAgfK7IJPOx0CCk3
         JbgK/iSBerDn5tGVDHSQcQLaHQcVI7CDe4nMFYUt1T5fTcYPR/V7jrvTJGLJb+oO5rT7
         fPBbhMeoKEEd5Sr+Zc/Oku1Q/IItxA3Ev0SAKP/rwzAur64VfrnbXuTILXaxQsq/vn/I
         yYPj209OcXE/uAWtxWiJbTgaq04pDQZ9X9pAnlPbC6qvHG3PWGJ+eInWHiMzEQfA+LJK
         ofKw==
X-Forwarded-Encrypted: i=1; AKwUvBy26OdM3FfjPn0Pt6Hla+nc3gwCFdKmgshyTKchDelavmBc5x/qQdJSYF/KtifqRbxy9q/Nc5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKez8Dc/X1oC5vGnvi4EDLlEuV6aK0RxBLMHmy2C+A0NkxtjEc
	K1T3fhqoTHPxrIzKe4TdwHahrNSoDLO4Kudj0BbfoDBAXveYvX/Y8+HF
X-Gm-Gg: AYBFou28e49mF00uElKwvi7wlEbDSIMu1EQXmme8HbDNOv2OtB/nyacTIPKYUkSRIme
	lB1hWwHwu8Ki27fgaZqjh+Wn3bOYGioELmxJpYIAOmcuJxLNNmYLWL5SX9gJE7ufkVMEV8KYfI3
	Wrsihq/MZ7QvJwNwUtPFCjh6MLdYt5FM6OBfXISnniclvSj8EIgyBMHnmGKcffVtCHiy0MR4UA4
	m3KkISA7FzeiLZwmTvsurzVrXeA/aGp4jXIWVxVMrwIIrfqwr6eRnxkVXyYiFFdiuVHAufa2wa+
	LiFJPlBvtGoAXTGWDgax4Mn4iXls9wjER5lhmRmEcxsAYAD+obbK9sePz8+Q2E7Rk8pTUxwHjHx
	1b2wd5tjqaqLUzO43youQOGAtH7/I5BZWGPhkVumxRtTH0jQXulGrXtH9mejF1yg04xrC5E1iQV
	qgq3ds6cDfMRmvlFRDcI5tAl1mescYcMGjWs/jIj8m5aP0/gGNMb4dU0ZU8CrSC8ngFdwVdljVV
	Qe3/euRj8pl9ll53oo0PPapp0AWWLH2tZLdpSBQE88HSkPe917/foQ39jJbxMcQ/NNisCkS6ig8
	qJi55Qa9J3opCXKKv9CZR6BoIHPZuZ/yf3Q+QtmevQYFz0utDRoqspqfZe4qw8iD45ujVL15KxB
	63F7vKwE8/84JeMCaHeDXsZQEpf7ILJLTGC3mPn2tgUGWRNXQ3IFCfHte4T2z7jLD3Qrj
X-Received: by 2002:a05:6102:50a5:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7d072c2b96amr883485137.6.1793383095802;
        Fri, 30 Oct 2026 10:58:15 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d0770b28e0sm3198299137.0.2026.10.30.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:58:15 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:58:15 -0400
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
 yana06070@163.com
Message-ID: <willemdebruijn.kernel.6ba984cf38a@gmail.com>
In-Reply-To: <20261030141435.779302-1-yanxia@cmss.chinamobile.com>
References: <20261030141435.779302-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net] ipv6: fix cached route reuse for SO_MARK control
 messages
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
> A connected IPv6 UDP socket can reuse its cached route when a SO_MARK
> control message supplies a different mark. The packet then takes the
> route selected for the socket mark instead of the per-message mark.
> 
> udpv6_sendmsg() sets flowi6_mark from the control message and clears
> connected. However, ip6_sk_dst_lookup_flow() still tries the cached dst;
> connected only controls whether a newly looked-up route is stored.
> ip6_sk_dst_check() checks the addresses and output interface, but not
> the mark.
> 
> Commit 42dcfd850e51 ("udp6: allow SO_MARK ctrl msg to affect routing")
> fixed the mark used for fresh route lookups; connected sockets still
> reuse the route cached before the control message.
> 
> Reject the cached dst when flowi6_mark differs from sk_mark so that
> the packet goes through a new route lookup with the requested mark.
> 
> Found during code review of IPv6 UDP route caching. Reproduced in UML
> with a connected socket and a fwmark rule pointing to a prohibit route:
> marked sends succeeded before the fix and return EACCES after it.
> A two-interface test also confirms that marked sends use the selected
> interface and subsequent sends without a control message still use the
> socket mark. cmsg_so_mark.sh passes before and after.
> 
> Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> 
> Tested on net 5838f10563d58afca6711edb5e4eda968ca181d9. The relevant
> send and route-cache code is unchanged at the base commit.
> 
> Full x86_64 W=1 builds completed before and after with no new
> diagnostics, using configurations based on allmodconfig and
> allyesconfig. WERROR was disabled for both; allyesconfig also had
> KASAN disabled. Both used LD_ORPHAN_WARN_LEVEL="warn" and
> DRM_WERROR=n.
> 
>  net/ipv6/ip6_output.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..843bb95e635b9 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1125,6 +1125,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
>  	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
>  			 np->saddr_cache ? &np->saddr : NULL) ||
>  #endif
> +	    fl6->flowi6_mark != READ_ONCE(sk->sk_mark) ||

Asides, not expectation that you fix the following:

The same is probably also true for flowlabel and dscp.

Not net material, but ideally ipv4 and ipv6 would do the exact same
thing.

>  	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
>  		dst_release(dst);
>  		dst = NULL;
> 
> base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
> -- 
> 2.39.0.windows.2
> 
> 
> 


