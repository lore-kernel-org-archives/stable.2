Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EB443A91
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512714; cv=none; b=QpJPPWQdFgd4j5H0mQVJz+kOHbE7yKu2EIMPPwybkiyIEKltgg0QV5/Lon7yDGzOK4OhZv71gRDzGL+jaUvb1f0YFalScBeM82uzBLTx4OBRAaVJz+0okblSttkkSLulcGnnIa9LIULCwYqzFvTv59tLE0I6A6I0rAT0TieoqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512714; c=relaxed/simple;
	bh=QljyVPFlAv4h/ZzcE8C+5GE8/id8T+aE6aMhZzBAF/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lt765kq3fsF+q1eDyPnvAKvp3HDih87TntEgvS25JLLb3vx5wcqzTM4noE7ULxBG1gIK5TjV3v5kIKhYg10ir7yza/3zDYbhKJG2IvcP1yVIAVM2I1guGJGznfBrJEvsxKhdXMhAzgHzqttl0r1utc2RllKI5FLllXLK2GX08pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3QvJhLH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3QvJhLH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1069246b3a.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512712; x=1786117512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTr+FVEJek8HJ3HeYCgl63RHoNH7nCzt1TWIIYAYrB0=;
        b=n3QvJhLHSax0EIgAg31zVsyiaA3GFTOThr/sKnIwk1AlNJYzy703rz1ByL5pGsEAAb
         KnZNUfLuX28RGcJq3klfQbDv+JPv7DUVp0L83hTf/3o992ceY4u/wQo3H5vOr0f2IH18
         G0h1/U7AIBhqotS6F2zMBzIhCCFUugoMc5L0S4uSBe6PPL6XReLHlCwndBE+21iXW4YZ
         SHaU3OnRa70Qfkcg/aadOPBOhtqOh6IBWEpKKM844v0RUR8DY81ig7B7mZqk4yeB0d5X
         hXGSY41kXXDS0RyvRvgEIV3pWLYXfsB4AAr79YNlqOTBYhAOxTzep2yj9yWU6Y9UFn8v
         w/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512712; x=1786117512;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTr+FVEJek8HJ3HeYCgl63RHoNH7nCzt1TWIIYAYrB0=;
        b=QogHjVr6lBnImAs6hamTZHO1jMrCHEEFuhdvAqcWrkS6SlnNR3b6CfDE3zoJN16Znk
         5J8V70GW77PMNBI1UiNKddLlcQZ+0CcifZlOfW6Vlcuq9E70dq1756kpqYKds3Y3R4p6
         c1Av4ryBYP/cjKthX2Fer6YvMUgTBLCiH8gUPhoBNKsrUFw6R7bFYRX3Uge4mI+9323g
         LAxIZ1a7qs9PWzpNHj3PZ9V3WRMivIvFfalZt+GX43+sRgUOkw7rJq3KSRwwWBifE1V2
         ZQ1FAlfgSQjMtr6UoAQyDmaom9tLp2u9+W+ZK4ye2JRjRQ394sQw8vAbSgtnCvcYPwxS
         gAOQ==
X-Forwarded-Encrypted: i=1; AHgh+RoF2gs3Yg+mIc7wGksW2Hi3GPNec4UDBO6zIYTZeI7trWeQ67IwSPCdmAwo/CycEFLWDFcYiIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sQhxDpIIHe4+vteMq+fMBLWyueoYex7HV7cOQS6UsfW+hl2m
	lf8BbLkSMOO3b/r5ud0Oc0BP6JVk68txvQNIHsJ8LrcamGjJYc2LgDdw
X-Gm-Gg: AR+sD13AnViKr6qkLaMq2Plcguu9U9ARnCHF7k7EQc0FrWZHh7KmxlMv5bfxqOlV4yS
	mJeCTwmq7OkYP6BC7Yn9iMUahaHhKngarO+cN6AS7C3fpAY/IQWYVwiQ6C2nJ3RnaY5tDiz2qFa
	GiQpwfmrVxaykufBmLivtwoL6LKi+SCF2slrNjAiBZOVuAW2m0ZchP3sc49C0Hlf7+GAg9WTv7u
	WU+mH8dD4zJF0eVxC4jIuIi//Z7dBZdgO30V1+kG4++9Kdr9Lzf6cfRsN1E8V20Ff5KrNhzUL/T
	kPTQolfnQ1EzlyI7f6AK+KYaSb/6jJMfZQAZE6YRvZiO4l4Ji7tk3LIe9v64ofBgOi5v3N38XwV
	w3zfZ4DUQr1GhD+GpBI7RIqzRkLLCbZrcnki6m9rganqMlOrrWbqXhb//0rzFZROkAm0B6qj21J
	uVTkqTFUaxBBiHqzssy9rl62/Gr1biBAthDcM+EEymEoNJGCQG3MtGTLs/lnmuSx5o3OVLVYlFH
	9uXySflvl51wa+4XNe7za44wHFoQ3Ktawjm1hHPvLOWY0RglfpmfZltf38=
X-Received: by 2002:a05:6a20:6a21:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3c92a75b25cmr258440637.8.1785512711706;
        Fri, 31 Jul 2026 08:45:11 -0700 (PDT)
Received: from ?IPV6:2601:646:8f02:5350:ce4:701d:f6e3:3a6b? ([2601:646:8f02:5350:ce4:701d:f6e3:3a6b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm7821146eec.31.2026.07.31.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:45:11 -0700 (PDT)
Message-ID: <6fe86a50-34ec-45aa-b2b4-52429a72369c@gmail.com>
Date: Fri, 31 Jul 2026 08:45:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: fix skb length accounting after generic
 XDP frag adjustment
To: Sun Jian <sun.jian.kdev@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, stable@vger.kernel.org
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-2-sun.jian.kdev@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260731032357.6114-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/26 8:23 PM, Sun Jian wrote:
> Generic XDP exposes non-linear skb fragments through an xdp_buff. If an
> XDP program adjusts the fragment area, bpf_prog_run_generic_xdp() copies
> xdp_frags_size back to skb->data_len but leaves skb->len containing the
> old fragment contribution.
> 
> After a fragment shrink, this makes skb_headlen() larger than the actual
> linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> copied 1024 bytes past the actual linear tail to userspace, starting at
> struct skb_shared_info. The copied bytes included the affected skb's
> nr_frags, xdp_frags_size and a kernel pointer from
> skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> amount and truncated at the end.
> 
> Subtract the old data_len before replacing it and add the new data_len
> afterwards, keeping skb->len and skb->data_len synchronized.
> 
> A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
> 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> corrupted payloads. After the fix, all 10 runs matched the expected
> payload exactly.
> 
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>   net/core/dev.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5933c5dab09e..5c37cf6c4aa1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5517,12 +5517,16 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>   	}
>   
>   	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
>   	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -= skb->data_len;
> +	if (xdp_buff_has_frags(xdp)) {
>   		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
> -	else
> +		skb->len += skb->data_len;
> +	} else {
>   		skb->data_len = 0;
> +	}
>   
>   	/* check if XDP changed eth hdr such SKB needs update */
>   	eth = (struct ethhdr *)xdp->data;

Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
