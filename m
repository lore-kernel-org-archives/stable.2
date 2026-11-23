Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795463215;
	b=tDIgUWqwUuLy8PkRaVNIGkWUjSSL+FMA1nXlFxdSNrZyWwr7R2jmO816N8tG1Y7U4eoG
	 2vg1TNuhd59VyOOoZIePEonNE78uLKxZaX/a4llrU82QTT9OrUlTPlXEdTctsYp+1lx9v
	 vQIbRg6ZyxGhwjntWOZ7T+dBDOq+7GKkYf9qOACkN2Mu07Jmb3IPCJlkZj3Eqc4IcGnJj
	 Xcnpf6vJ7s6vGl7S+9a97f/Ndw1nkppx5JysVOfzXIGhivnoR0BComcl9oM3+mdiQAoD/
	 KZONcj3tLH+XlzGKk/v1rqy0DoE1goTwY8SOFkJBiC2g5GYRkGJvknHre6Ew3QXz1JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463215;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=68msumE9ER+DmiSRosq40jxym27XxyiCjqWMWovmiXU=;
	b=akXR8cvIo/kgDiFUkRLca5A7ykt+3B8f/oCMEZqS7iRKUaESGZmNVdhATlEFzriXgJLu
	 yie4PFm7Dz1GucA+UujzmDwbTssEhrr6uTeFCYLxcP576mf2sI676hcfZ9MAcyjYDpftG
	 7hn1fPnoOTP5mT1XGShBl96phZrA2I2DkjYSX65LRXHSQEovSgIlr/5Dv5BZ4EhHtitHX
	 Wo1WyM7FvK3ZfzHY/tcpZfPjR8+WwfFH/TJIzmEkUSMLLcoPALu6OLBP5seTP20NA0Fv9
	 FkrRNdr0/09I36yQdBDl4cT6b6x/v5YNNm/rOyyGVpqPrCj52FhYjcLsd9aouU1LVIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NxH5C50a;
	arc=fail smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B59606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NxH5C50a
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGIM1s2369123
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:46:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=68msumE9ER+
	DmiSRosq40jxym27XxyiCjqWMWovmiXU=; b=NxH5C50am/nw4X0MHjqFCQfQQj4
	A2bOT7e7cLabU4X+Sd7THNtQ0jl6lvyPzgQ8aOft1isWuisGo+XJ7aIXM51vLROc
	qpPpnDmrvZlB8yc0yB5YrixgG5RHYMlIFX3nTm0V5JBI7PU/MIOOByEkhJAKUVFE
	xX1gXF3waa+WEhGm7iKHLHJZFkp1lLYYn9mdCJt0+YUM1GX8VUH5jmf31nNw7S/w
	SpQlGDrlIaO9LC8fxFlZXyX7bNpQpgNXsQ+ra+V5OEhX0O0WIXkynG53BtDhqIBb
	CzlqPIM8Xakrj0S2g1MP02M7rJZAtx5Csz52FYEb/yWEZbOe7LdyHCAJxCw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j3bfmubbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:46:54 -0800 (PST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b3b4208826so2479367a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795463214; cv=none;
        d=google.com; s=arc-20260327;
        b=Vf42oBGTcZSmkBr19cL6/tuzAUSiIsodEkrHjZfCQsR0TtXIBW84ZeWdOK7TAQRXgS
         SRfHzMT5y47+dDTFiT24PdL277ylXX+nqYYMm8AKLrMZ3gdy4cs6xTnuipECPL74JSQ8
         KcN52yIhYG04tWwUMvsc8+edlRmgM3/QGOXpJz6e/mWCfh+p4DcBorw4J09FaaqSOoG+
         Wy2yb/cQumMynKtbaN3wvB8yqSeebY5iCoRm0cb6DhPiAvuRojtn5foRl9HpagCqW5PP
         vZC85oXbi2kZenoRJPB6TTJ6KcsKc1yaZnz2Z+Dz3U84yZaS2+Mk2DMsfABXf3+UGGit
         PMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=68msumE9ER+DmiSRosq40jxym27XxyiCjqWMWovmiXU=;
        fh=EPNAENSkNV+K7qZMsNdgoDKGzTFV4wZVW0XVOMoDSeE=;
        b=ddqqI8hy/+CJ//kIpoLfSt5UVP1E6veZv6hQ9OcYkTZDY7y/r4zjqZe3HG6AMILJp/
         gBkdEU/GQgvTJMTyne4vHiOn2e4eCy1L5KauaT0wAxLruRbF8dE1bjFM+cJQ5Mh0xng4
         XaMLLz6aF6iGhiR50DypgbYzE4BUUmYZYKAHRsgaAVNyNbPiY24ZpLhZ6fohsJapQxir
         d78D+mZvL1IG/Dmsmfw/s6ckaHjZfaXBx/j6o7OhN7H3cQJ1IzMMRAKleYc+y/j783fv
         aPhINxDHNjlgFLxIs6mIlKGESzfSJzeQiVDBPcj41jSjLI4ZVKXpJ4wQ7THtqb5HUy4s
         WvoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463214; x=1796068014;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=68msumE9ER+DmiSRosq40jxym27XxyiCjqWMWovmiXU=;
        b=Qyq1pqgNb5HK3yuKbfev3es0uW2VPHZQ+Y+W37ktvbKr3s/pcEuk5FzU9a8ZXXCvSP
         wLDPVa0fW2By3zU2lIhGA9a7AwaSUP3u/w5Fj8aNfBmgudL2q9cItbHtYf5gN47uyx+h
         aaaVvKdCN0cV9JwQeaDnNw3e353t4p0JNaFhXBQAHCsITnAVAZbFKEDRIZMmZ3/d+GEk
         1hpvE5+Gwg/GQSxI80myGdICNnpEiQ5I0BTGNhFKbn0Lsy9NXIrAIgqLAApBruTbjV3O
         ryAPl7Hoj7qYSiR7E7PDVOXmTv2/4GJNehjUx7DFSz/2rYFSxQ5aJXxZiqD011BfrOKj
         nt1g==
X-Forwarded-Encrypted: i=1; AL+hErF7x5fuQgJIX+Lt0EdZO6NCSsB9HsnJwxWUu8MRWQ4AXzEYfb6KTnhDY+k9znKCfMrJq3Zxbfc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/49lUnBruL5rw7Rj7EvpsOSku4+xlYEHFNbZsGdtc9u7cNYG3X
	xExCiqGglqGkd6EZqxgm71TUTAoC9BJL+OPJKZH1SIM2XC42Q4BnEg7nNYtAtF621hiRCvt4060
	j+bVxyjIlc2BEwLvTmDZMy9WOAd3DJ+giIniwNQRKwmyKzgq65S0IHyykMaREPyT17zPTYdWxgD
	ELa8q11KypjRHfczLqNZsTl+T7x3lp8Lg=
X-Gm-Gg: AZFdTZfcbdVEObatGKvA75xwyXz3qPMoG8ys8koTKv2YWKWu9FSqv16gFdwAhr7JlJh
	WcLAq56ZmaFhpr1NDoAt2Xsk023sABODhB8cYa+LMdqtkFnahtijj7CC1pEeVczRW7H8/S3i2YJ
	bGHy9IwhR2CmBg4FJ5UmOYolWoBahnbxD/ylAv1UnQ7k/Epr+YwsuJ1/ejnrlbbOMvIj/jkFggd
	7YYCvRU+yNzBc9I7NOyaBCwu8sV6vrcMKwDkcYh6aHjqzL8SDg=
X-Received: by 2002:a17:90b:4483:b0:3a4:b509:88bd with SMTP id 98e67ed59e1d1-3b41c7bc7ccmr7276184a91.2.1795463213786;
        Mon, 23 Nov 2026 11:46:53 -0800 (PST)
X-Received: by 2002:a17:90b:4483:b0:3a4:b509:88bd with SMTP id
 98e67ed59e1d1-3b41c7bc7ccmr7276167a91.2.1795463213335; Mon, 23 Nov 2026
 11:46:53 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117203137.804424-6-toddfreed@meta.com> <179529586258.3135.12190616828136497053@kernel.org>
In-Reply-To: <179529586258.3135.12190616828136497053@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Mon, 23 Nov 2026 11:46:40 -0800
X-Gm-Features: Aa3M54qNBs9m9dMGH-6cVdsrK_G87ANBZo0TyGs0hmoTzNiwaEmGoS1Z8U9eLXY
Message-ID: <CADh2yMys__9M11pgtxkMQHuhjvM8DzZr20t7W0aEVNqEmABEnQ@mail.gmail.com>
Subject: Re: [PATCH net v6 5/8] ipv6: icmpv6: don't quote decrypted payload in
 icmpv6 errors
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
        bjorn@kernel.org, borisp@nvidia.com, cratiu@nvidia.com,
        daniel.zahka@gmail.com, dsahern@kernel.org, dtatulea@nvidia.com,
        edumazet@kernel.org, idosch@nvidia.com, kuba@kernel.org,
        john.fastabend@gmail.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, mbloch@nvidia.com, pabeni@redhat.com,
        raeds@nvidia.com, rrameshbabu@nvidia.com, sd@queasysnail.net,
        saeedm@nvidia.com, shuah@kernel.org, horms@kernel.org,
        tariqt@nvidia.com, weiwan@google.com, willemdebruijn.kernel@gmail.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6b04982e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=-7il3XB7buBOucKm-QsA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: cCOQVMtIzcz3vuoRyhfrET4OobcUKfhG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfXyA7tDibV1eWw
 aDimYbcNGIb5VJgnOiozkLy/Gad0WJUNexUqA1DbLk9g++yC6AExAZ2+nXEtW9HomAMXCX6/G2b
 r3Tu33jbWDQp4qqqzp2zUfcSN/0P5E0=
X-Proofpoint-ORIG-GUID: cCOQVMtIzcz3vuoRyhfrET4OobcUKfhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX2HjGoR6ORHKu
 ejAuBpNYuQvpWtM0IBvsiH457Jht/QFKxcgcF/ejv1tfmbtBXxblxvYXh1OOJnjC4Vvgd4mGZIv
 dK7ymIvp3/bok9oTCYL0iEa9MTl2N4rXi7NB7bew8ttjIY0mhtAMn1uOMXBp7jMAsrQGXe1ZwPo
 SuJUVkZVZ9N1MX9WW+gHSut7U517wvlsBmyHz6nyQBpAOBPasjvfGkGj6L8H1YZkyUGyprmOXS+
 ribrLaOnL5pfj/Yafk+Y3X83SzwNeAFU1PvtE8xanGGyeLKode07sO9vB3dl9CVV0MWGyxgSeZ6
 s4yTr6EXpMfz9bdOf9l2KtnrrMwPYCczldnSJpo7BG2B2amUkI6MnOVEFRGic0552CNXhDeHqWg
 bVPHtdQu73Mmi7biCSMiKXGNNiGIBwszn32dz6LjDZ1SaSPc/SwEe3hF1Q94FoZX7fB/ZtDIRt0
 VvV4aogIfW3eBGp9bRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01

> [Severity: High]
> Does this cover the NDISC Redirect sent from ip6_forward()? That path also
> quotes the invoking packet, but it never goes through icmp6_send():
>
> None of these conditions look at skb->decrypted.
>
> With
> forwarding enabled, a PSP packet sent to a non-local IPv6 address would be
> decrypted and then forwarded.
>
> kTLS RX offload can also produce a decrypted skb whose destination is no
> longer local. One example is when the local address is removed while the
> offload is still active.
>
> The !skb_sec_path() condition already keeps redirects from quoting frames
> decapsulated by IPsec.

I reproduced this on CX7, with both psp and ktls offload sockets. It
only affects
ipv6 (or rather, this path is already addressed by patch 4, the icmp fix).

* server enables forwarding (force_forwarding=1)
* client connects to an on-link address using the server as gateway, so
  the server forwards the packet back out and sends a redirect
* the forwarded packet itself is dropped because of skb->decrypted
* the redirect quotes the invoking packet which had been decrypted and
  goes out

I will post a v7 with one additional patch that addresses this.

-Todd

pw-bot: cr
