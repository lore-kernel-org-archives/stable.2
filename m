Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528529;
	b=CjPj/3Dd3hyqcNpgj9pzTaTpawR9bpfteEHVNBx7M2kVi3RXAoeNl1CfzGxMQsuQPUpA
	 U5jFjJrMzyOHhAkmxMcpxFd2qNRtftyS/SG71m4m+0rNpgynAZkEYaOqUO8K6JjK5H5Dw
	 8eFCLz+eKV/UMlwcdxIM7tHxyWo+HBfuF4/PjHu4ZUvpUMBZ7KHlfKSSoWGCf7w+pfejH
	 +olRwy+c+kgP9ruYMN1ClE6SUHys5Y39bJ/aWqHpd7kifPu1SLNiB9yPAMb+Jce6wxMIJ
	 d1zcqhOZu86jWrti1d8VNgvJsUZs9a/iHQjbmMC0NJRixf6fVHPTDA7QDDoUtbZPJvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=I1beTTuDkHcJrFtkrdIEDwGOge1ar4jfKSDiYm+SAes=;
	b=JNUM1ls3DJfAp/orC6x6n/qYc3XRPPazrT9zKs7XnT6VXlNNJNHj07WlBfnGdRDfC5UL
	 1Pn+IXCeXGvc7z1YVA/dKmVKitTuKz1F9IhzqenHsyN14CCVm/ndLD7MLGMYuiHD+UFRq
	 Kba49/znLNUhFbAvBrc1S524+juZNHDCpc2lyxwVSKVwpJ0/xUN8gmpNKX76iA2eRC9Yq
	 2n+O39vDVT/W3tTb3lYu6tZlUikoyWVxVmBsgPceiSaUgzXzxLINpdUSpX0pSJ8Q9ylVd
	 n1F0bRtzT2wX8RC9hQvgQq+nNHkZKkEywmc39/YipGPZZbz20FsdgDXP1vXx6twq4iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=Y2bsdeUG;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9795606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9795606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=Y2bsdeUG
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50686daf9cso77373966b.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1795528527; x=1796133327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I1beTTuDkHcJrFtkrdIEDwGOge1ar4jfKSDiYm+SAes=;
        b=Y2bsdeUGRkhvEwUU7zA+Ccwi7nQaUwSHzxZBaZ4811Twitth90vemfuauNp3AqPTj5
         FzQ2ayO2yIqj2+f5itd7nxfGgGmg46Y42OdYNwLVeKI1BvNLReA7ROzQg5P5QM1jfE+x
         ERu6bMFz1PNLPKVM/wxS0Z1Ggk2SW9lhivGplwZnVpSMC5fdYcuB/Cn9qGdq4URirwED
         van4HZN7J1SKjJ9KU/JspZfLnbHYMonP2cokgyoMnPREAQDWLkuFpvMwLbwyKFxv/WZy
         DH7TB2xui6Lg3bS8WmzuzW2wxpA7MXXUCrNaKcxy+XTz28I3PPQMyWL6amYPir4Ud9ax
         32Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528527; x=1796133327;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I1beTTuDkHcJrFtkrdIEDwGOge1ar4jfKSDiYm+SAes=;
        b=N2d/dhV6yKesZQRMhhSkqy7zOKdSrf4HvV+bvUk+ZlBjKKswdN3xaC0BBrYoTwckta
         k/bE1udbkkpxwi+bpvQqCeb8yW44eL7ScIWRtjQSSwu1HSE9vdVg4BIcAasPN2sbL+OC
         cU/KWDfIhTiJSYbEYGSQp0se2fcH6a+ro4vfT3Qc3m4QwpETGFowOpzili/N7BPWCDDs
         73qKtxAC/IiQXGrvN3xWeFFL1f0K+VZ/7dkjmVxjVQHNq67UTJqiCA3XlXK9rskkN98e
         /xhJpVTSQx/R6UQzyfPls8GdGOtx5k7fbqoQda/BcWxe+YNuciXBvkuSKQ/W65eApecj
         u4kA==
X-Forwarded-Encrypted: i=1; AL+hErFTP4TyUN01CzLTNpcLUcdjQbWTe/qL8GHE+C/1YxDssE4RXXO/ynbsuzp1slTsWECuq4MmdSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iGhdX9Fjqo0cYgV6rajTbaC4UT4FkkcWVgrnrqw8G7rNqwjdp
	O6yC/wrZR+qDCk8HvXq5Rphbccww0i1ip+iQcYSeOVuvknaZUU53A2FtlY7JsY74jPA=
X-Gm-Gg: AZFdTZefFyThVXLR5M+c8rXXogR1mu0zsLXHebbUKnq6xZ6FccfnWAZr2VXw3b/buqz
	PL9T6M9Gt2RlyV8ZY/7Hz/ald2iLa+EN85rhLiIsUr7Ag7nn5fVmRX74wjZQbd8x/OWtdzc5bS/
	/t5uy4DrW5ccTNP0GVzMOOzWhcZecyeR+CkML00thf6TJeBMo169Y7f+N1LilXzihSrUoLLl+Pw
	lGD+rRSEsalZVhG1WjWIq7OZXAgX5hmxDbRuRMTbKYAibUCH873GBnDta5fkV5ex2yfIc0R+u8n
	2K8lFLot1pBKrPNhGqiuty9uHIipHcuBT5h0HR7eauiak4us7V7BZF1qp2W2vZJwK6z0dQcA+FY
	VK/lHHHpC5FjaXzHXVJnPhMEIq0gnCaf/uy7LDZ3m4udB5+3aOHn1GntMYjDV7wRan44mi+p1wP
	/wgdjChAXLvZhoHuZtkhTA2wUCx3sZz0A6XJzwEt4qYGTw2wA84N9tLCXG7oNRyj0CFRP1Incvb
	/NHQM45O31zMYBw3W8e/pgRqqNUgkhIB/FCzB6k3NdhuowKapLqEsiWKgJaUHAgh3XbB7G6lZim
	x0Lv2V8fYZbNDw9ds57PC8Md3yfaX2OW9O1rFjRtvJ8cn7kuXjuBWoH0WgC+ochdDYNMcXgOqoC
	cJGMfPIZQT2XbbULXKQjzHTda8f8=
X-Received: by 2002:a17:906:2b5b:b0:c29:4634:5c8f with SMTP id a640c23a62f3a-c513a284994mr1056327766b.0.1795528527042;
        Tue, 24 Nov 2026 05:55:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01afbsm518330366b.5.2026.11.24.05.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:55:26 -0800 (PST)
Message-ID: <8f0c4cb5-8754-4636-abdd-ccec7ad5d932@6wind.com>
Date: Tue, 24 Nov 2026 14:55:25 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/2] ipv6: check the scope of the best source address
 candidate in a VRF
To: vjardin@free.fr, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
 <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-1-f667ab150ade@free.fr>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-1-f667ab150ade@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/11/2026 à 15:30, Vincent Jardin via B4 Relay a écrit :
> From: Vincent Jardin <vjardin@free.fr>
> 
> When a packet is sent through a device of a VRF, ipv6_dev_get_saddr()
> first checks the addresses of that device and of the VRF device.
> It stops there when the best of them has a scope that fits the
> destination.
> 
> Since the commit abb9a68d2c64 ("ipv6: take care of scope when
> choosing the src addr"), that is what the scopedist of the best
> candidate is tested for.
> 
> scopedist is only written when the rule scope compares 2 candidates.
> With a single candidate, the rules stop at the first one, which only
> tells that there was no candidate yet, then scopedist is read without
> having been written.
> 
> It is 0 with CONFIG_INIT_STACK_ALL_ZERO, which passes the test:
> a device that only has an IPv6 link-local address sends to
> global destinations with that link-local address,
> although another device of the VRF has a global address.
> 
>   # ip link add site2 type vrf table 30
>   # ip link set site2 up
>   # ip link add dummy0 type dummy
>   # ip link set dummy0 master site2 up
>   # ip addr add fd00:91::1/64 dev dummy0 nodad
>   # ip link add dummy1 type dummy
>   # ip link set dummy1 master site2 up
>   # ip -6 route add fd00:93::/64 vrf site2 dev dummy1
>   # ip -6 route get fd00:93::1 vrf site2
>   fd00:93::1 dev dummy1 table 30 src fe80::5cb7:13ff:fe96:87ac metric 1024 pref medium
> 
> When the scope rule does run, scopedist is negative, whether the scope
> fits or not: the test fails, and the other devices of the VRF are
> checked too. One of their addresses can then win on a later rule,
> the longest matching prefix for instance, over the address of the VRF
> device, which the first lookup is meant to prefer.
> 
> So let's compare the scope of the best candidate with the scope of the
> destination instead.
> 
> This issue was found for a development of a UDP tunnel device with
> IPv6 addresses in a VRF selecting an IPv6 link-local source
> address for a global destination: then it was confirmed with the
> fib_tests.sh case of the next commit, whose first two checks fail without
> this fix on a CONFIG_INIT_STACK_ALL_ZERO=y kernel.
> 
> Fixes: abb9a68d2c64 ("ipv6: take care of scope when choosing the src addr")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
