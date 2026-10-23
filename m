Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756527;
	b=TX2y4LxQoMN8CgBCQRRnuD3uYQanzDt6HdFU2Hd4IG5bLzGZoiwanaZQnXnQYqW1RnBa
	 ZAF2jZ0KAHiwembn5ATHYsBs0FNJ6xi3huz4UE1mF6eoMiLgDmIQlsmUuybt/m9d4cSRV
	 7O4qxn+GyVCt0Nea8aRbdaT7+7EirtYUuJA3h3WiOGOFc7Rz+aDNlc8PB49gZO3yQjrK4
	 nMQD8GUzHMhdN1HsxUR19mfmAe47Ob3OZJZgle+uyAy70z6gbhscERcea/JFP5k4n4hY2
	 sm0CNiFr4hLEcZN4G0DGXsU36I5GhaAdQk4ldzvikqBlvy3kgMCsV5nFwlwH/tPe9aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=j8yx8MHMvq3picZ6FejOsjo0XQHjNiSaAE6rAN+gpXs=;
	b=pXdXO5Ke1D7sOnxiy2IqmrY68UoDgFUpsjb7S7DNpDlrqF83n0gyV4voC+1oSovMv6HF
	 +hh0v5TCwCrt9wleWAHWw798sUsYrehGE6h0UfUXlxJOqzibDK5R6Vgr0UTZzzYnlc35F
	 VBTj+F+TmFD3U9777x5ZBq5m1Em1X++G9JzYv59cVotVRwYvRg5H18+I0S8siI5hI1Ej2
	 Kt3Itoke1MQ6QdHf2qJTHTwl+9BUMHUZqkYHn/SW5w8vblxAWHfuLUPZGKydioo5xbWQN
	 iDSntgM1pCGf5YurAQQPV1ZUCSgM8OWPP5VTz2DhsQz4euVAIJW5vN/AX6GBWnqKKbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PFHvA544;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA4606A322
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97FA4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PFHvA544
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso497115f8f.2
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1792756525; x=1793361325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8yx8MHMvq3picZ6FejOsjo0XQHjNiSaAE6rAN+gpXs=;
        b=PFHvA544qyvx7w23MQzVC74QWW/SRzZ620CxgtB5Lzfts/kmVLTK9LVu/PbiUqtpmQ
         fR6SuJXzgDBWYoMN7OqDs+CmxiTblqUxWpUQB7tSj1GlX7ylAnRSILjXSkLCdUmsFban
         /T4jZP5o9Tcbq+DZj4jdLX8JGj9YBQ+txlhoGdsx8nByhZNxj9hBy7jdrc5TIdVsaptn
         HQl1EynC6kjNPhBihCrE6XueQBipApHotswqnWp0psjcqm8nYlIak5g6Lp1QgA3vFRl0
         QcHle9PEatWJcP5XNeld+S5KWxy0om2BibO6CQY/aWvEDSShhmPCdGtAchjwYvNlHAvu
         Aucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756525; x=1793361325;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8yx8MHMvq3picZ6FejOsjo0XQHjNiSaAE6rAN+gpXs=;
        b=WoY+E7oB5eFT7u22r6jQm6QX2ijD6RV9AXnDxJ5Yvbj4f/E8hemM+dw+WipVQr/g+D
         /WqTzqdAgePzOfQIBSbQdS8wZ+fdOc4/gClb3b07gdm8T31J1kmYkrC29FB+kgXlG+wb
         3Mm9aZuChm/O1IHzU862v7ndcl/QqKEZNkdCAB7wyJNOwoDlMIM3VyJJE7pTGfT8QbwE
         N6S/cL0kjVDkh2pkKoGfAHihNywC6q0BLBQFsaj1lmSk+pqn9iKB92aCjBqGBAWCf23E
         65dwoXOsckOIWLSPQD3SUmO2pts3OyvXQRGsU2P2KbYP2DKoTNsepf+2KsLt7p3dLipH
         T+BQ==
X-Gm-Message-State: AFq9FYIQTAX8NNuDlXm++4tbT4m/oZfzqIUjZV6SyFVFCNcKnxV0/hUQ
	naLRvk+IKJvG/EBuSjkRqrcEsv+qu5WpE/6eIeM5lIDgUlJtAsbFU9fhMTQY801fq8c=
X-Gm-Gg: AYBFou2HptgNtbo38v36bDsJhHLw7HjjbXKsr7m1jXT1Ggrr4A5cyjEPmavX9lIkR6n
	1kuqjK/DNZqO4/rQWr9kTznwUbOaaTtirInMQGT0Z0AfDtCO3xl8pEmmZ/pfYkrHRDp8ahjd4tu
	PhDp51S7331TRYVyRnkQmIMHQme5Vt2RishLjuOq/l66BWLJ1WixzlhoLYXslq1YN/B4RBLNbQx
	TqE3+/jRqY4IZUmw4bW0/i1fnZGT53XZZ2XaeZzQZK6gXsG8+jabmrOcoZU1TDalajCBB/o71jh
	7sEuLBj6veP9b7DYclfJPBKMSCOAHS5I+Mlv5rofs8Wym13NgFLks9awksf2QVKC0e2UuWh6yLL
	+jKmF5SYRwn5BQbsKXMiqFSrpioxx8uH9TlF/swI7pMPy8PeRYVHjnPf+DzeKG6O5cmZTjL9iWU
	yYCi+3DjuRvEsYksl/M+rmYwGzhR2h88aLwCrDeqTvPWmcpBy7h3KTRJn+YgagqRzNQFHzi6Dey
	hFz1xQn0aarTdbaqiseqadgcBvtE9CQHOworylFoSn3fkJ8RXRNpbRTycpacEcHqN7ugND+Qs52
	aNoAqB9Ppqd/vgEclQaHOrR78pMgkhk=
X-Received: by 2002:a05:6000:2407:b0:48e:3fc:e393 with SMTP id ffacd0b85a97d-48e38546abdmr3350412f8f.6.1792756524809;
        Fri, 23 Oct 2026 04:55:24 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e380314aesm4238717f8f.28.2026.10.23.04.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 04:55:24 -0700 (PDT)
Message-ID: <dac940d7-ac2b-41ea-b362-9c95edb5bcb6@blackwall.org>
Date: Fri, 23 Oct 2026 14:55:23 +0300
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
Subject: Re: [PATCH net] bonding: fix out-of-bounds read of arp_ip_target
Content-Language: en-US, bg
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261023104528.232427-1-jiayuan.chen@linux.dev>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261023104528.232427-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2026 13:45, Jiayuan Chen wrote:
> arp_ip_target is a module parameter array with BOND_MAX_ARP_TARGETS
> entries. In the loop parsing it in bond_check_params(), arp_ip_count is
> the number of accepted targets, while i is the index into
> arp_ip_target. Invalid and duplicate entries are skipped without
> bumping arp_ip_count, so bounding the loop with arp_ip_count lets i run
> past the end of arp_ip_target, e.g. 16 targets with one duplicate:
> 
>    BUG: KASAN: global-out-of-bounds in bond_check_params.constprop.0+0x1148/0x1440
>    Read of size 8 at addr ffffffff96e9ee00 by task swapper/0/1
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x91/0xf0
>     print_report+0xd1/0x630
>     kasan_report+0xf3/0x130
>     __asan_report_load8_noabort+0x14/0x30
>     bond_check_params.constprop.0+0x1148/0x1440
>     bonding_init+0x13/0xe0
>     do_one_initcall+0xe7/0x5b0
>     kernel_init_freeable+0xa91/0x1120
>     kernel_init+0x24/0x220
>     ret_from_fork+0x5b3/0x820
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
> 
>    The buggy address belongs to the variable:
>     arp_ip_target+0x80/0xa0
> 
> Bound the loop with i instead. arp_ip_count never exceeds i, so it
> stays within BOND_MAX_ARP_TARGETS too.
> 
> Fixes: 5a5c5fd48e3b ("bonding: arp_ip_count and arp_targets can be wrong")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   drivers/net/bonding/bond_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 09aa45d71fab..7019e5d8fdc8 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -6273,7 +6273,7 @@ static int __init bond_check_params(struct bond_params *params)
>   	}
>   
>   	for (arp_ip_count = 0, i = 0;
> -	     (arp_ip_count < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
> +	     (i < BOND_MAX_ARP_TARGETS) && arp_ip_target[i]; i++) {
>   		__be32 ip;
>   
>   		/* not a complete check, but good enough to catch mistakes */

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

