Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84B3B058E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829971; cv=none; b=XA5CeArkiEX29opFZTJXJPgH35uygjR7npqIJ/gumFImjvLW1N6WpuSSFa3zZ8L5nE5NfhEOcosAmfXxwAYx8gKQ9R4qxDkKG7BBA6hRbwL8bWW4K4bH3zfW/Pfx8kXLDG9ZALjLVLh9VQT25cGFOrt/NuMj+k0i+oy4m/nDADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829971; c=relaxed/simple;
	bh=rDX9WXbfxVcnNBC2y1mq8NrM5+8QM5tPchi/0wPZZVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJX0xxnlrviZVvQYF54HFJNa/TIH323Fxds7i2KLy3B2qgmGFpm9dvRhVbrQXVdhOmhmQCZUxSAfrmncTFFSZF9T990jbxfX1diR1dVQYhpRvey+fz84OjBsuTJtBEMR6t0+FvVsfbiuwyJz0ibhWVleL1Vd8x3arWqPA1e7SB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uu8egR7Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYJ5ikkD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu8egR7Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYJ5ikkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787829968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmjuoTRiMtSdkbWE3sae32iC7Nxaisgq3t4UP340pp8=;
	b=Uu8egR7ZEvMZZN4OXEdDSK2s8C2Emc1NJWbSErg7CJz3hKXStx4m8FUxX3R2qF7w/oPkrs
	APj980Zm8BJenkCp4++Wgt2DWz4XOHy6H2cKGLWKln4mfD9BVjBKnuodn1UbcbjWqSEgie
	0Lf5hbTDRXcR48JL2gTOJAbISR9diH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-_0xIE1MAMjehG_GMIXPWgQ-1; Thu, 27 Aug 2026 07:26:07 -0400
X-MC-Unique: _0xIE1MAMjehG_GMIXPWgQ-1
X-Mimecast-MFC-AGG-ID: _0xIE1MAMjehG_GMIXPWgQ_1787829965
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f835ac1aeso1077774f8f.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787829965; x=1788434765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PmjuoTRiMtSdkbWE3sae32iC7Nxaisgq3t4UP340pp8=;
        b=BYJ5ikkD5qVthhc9o1P9+oyD44Py508kPzlM8FENr2fcXOTMmcgCBi4ItBeI/tWtX8
         J+kJ6JWhwR8pV7QJa9x1ryYQtSxUIJ3ybCBP/Dp0xE307HH8BfbiWcb5bnCddBG3Xivd
         ruRmAz8boplHUPpY6WzuyTJHVpNd638lFYDlApQKp4fIgeld+25b+r1PuCTn86ps58/2
         d4fcbLGh7J7NukZPEorw9WULyXZO2INvhoAO5gbHvZ3yPsKnxW6HZn3ttaVW7u8dUZcR
         mCpk6wFkkNSJrzhMY9JqL32qoVlkTDbJTmDLCpVLiYqAq77zXUhJ8XuuN2ofO4dCk+6K
         K4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787829965; x=1788434765;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmjuoTRiMtSdkbWE3sae32iC7Nxaisgq3t4UP340pp8=;
        b=hvVEJy++fGArQAagy058mVRf9b1XcM3pURY22DZhyNUly18MuneITlR4FXQymU78TJ
         z/ZpbVL8El158HzOryPmbNfBcc0IcNuKXVVc48mKFJyctPs80dWlx6tONw1w9WgIPbOF
         tYRlZWPWSYb2ZrAP9T9cW1pBCXnJO4wN7U6XJA1BWdzeZ7Xmiha0l8yf3q8CY716z1Qi
         Q4MRaXsBOAuNLNtJ/plSpV0BKsMZgo2wCsn/99hq5AshiR51c9kNtKR9RTOmTM/QzwA1
         VuRSP/AK8HPqMHvDGn5eAXiLkxET0RToZCDITxksLo8j/Gmidp3e3bqU79LbwFaA7Ia+
         Nw/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoRj4h/9sz4b25ihEmtfWMt+apee5dmHsxT056bqf0MS1cMLgbZq53LAKqTwOcemyZVXFda6aw=@vger.kernel.org
X-Gm-Message-State: AFuF++mEIuL7nLxI5hQj5pS1xIqnipQll643n1OInS4PHq4g6uUITKzN
	ODrLee+Pvd/rvwsGJwV0BF2vFqrm6bE36QE9eXcrSPU4OkSRWY4Ci6S+kR2hUyq2co2Hjv0JqmP
	8Tk2mvk0V1XJEAfZ1GsdqyseNcBp8fUu4GYyocIxY9fP36VLnP3yOW52/Tg==
X-Gm-Gg: AR+sD126j2H5sp2Z1/zweHAl3ideuzg0CujKiQUlT4hxFdR/x7xZYlXXoU8EfVxL1nn
	4CeoFQqX7lM0aHrJEFAT5uK00J40Htg2S8I21E0+JNCczB28BS+so4KhYHYbJjRzxVW52zjVJTc
	j7Cdp3B153I0NnEmjujJijNXQQ8RD9mLRffleyKZj5JaWHHFaSDGV3vMv68kgdrY7qshcWAY/X0
	zO7rzeS2pjsrBhsUL/TBsiD01kh0RqrAP2miaqgHBNNGYWJClzwN2CC7iIAPvD6hjaoUQZv3OaZ
	meZtUhGgOLFRn5R3TGIZc5rCX6lf198tLUMyuPw/nV1w8ZWSwTU9KYceiD8PCtbYSxdhmhAUI3f
	Ht3gBHTxWCR1prOGQElFCgS2N4dDXsWJK92YTXjqcyTAQt/8LxY6ti3Pe5pupPtKFk64hxfA=
X-Received: by 2002:a05:600c:8b75:b0:499:db6d:bc97 with SMTP id 5b1f17b1804b1-499dc6a4a85mr163496145e9.0.1787829965244;
        Thu, 27 Aug 2026 04:26:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8b75:b0:499:db6d:bc97 with SMTP id 5b1f17b1804b1-499dc6a4a85mr163495265e9.0.1787829964751;
        Thu, 27 Aug 2026 04:26:04 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4dfdf00csm40532385e9.14.2026.08.27.04.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 04:26:02 -0700 (PDT)
Message-ID: <daceef26-eae7-49c3-acd8-0908bd6a31dd@redhat.com>
Date: Thu, 27 Aug 2026 13:26:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net/sched: pfifo_fast: reject oversized ring
 and account to memcg
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>
References: <20260825081751.134086-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825081751.134086-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 10:17 AM, Jamal Hadi Salim wrote:
> pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
> ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
> bound. An unprivileged user (via unshare -Urn) can set a huge
> tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
> memory, causing a system-wide OOM.
> 
> Reject tx_queue_len values exceeding S16_MAX (32767) with -ERANGE
> in both pfifo_fast_init() and pfifo_fast_change_tx_queue_len().
> Note: For the init path, NL_SET_ERR_MSG_FMT_MOD reports the error
> via extack whereas for the resize path, the error propagates to
> netif_change_tx_queue_len() which rolls back dev->tx_queue_len to
> the original value. Use GFP_KERNEL_ACCOUNT so the ring allocations
> are charged to the allocating process's memory cgroup.
> 
> S16_MAX is the virtio virtqueue size limit: the virtio specification
> stores the queue size as a u16 with a maximum of 32768, so 32767 is
> the largest tx_queue_len any in-tree driver can meaningfully use.
> 
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
> - Unprivileged user in a fresh user+net namespace (unshare -Urn).
> - Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
>   while the devices are down.
> - Attach mq at root, then replace each child queue with pfifo_fast:
>     tc qdisc replace dev veth0 root handle 1: mq
>     tc qdisc replace dev veth0 parent 1:1 pfifo_fast
>     tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
> - Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
>   rings of tx_queue_len entries (~12MB per qdisc at QLEN=500000).
> - On the unfixed kernel this exhausts global memory in ~28 iterations
>   on a 2GB guest -> OOM panic. On the fixed kernel the oversized
>   tx_queue_len is rejected with -ERANGE.
> 
> Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 -> v2:
> - Replaced silent clamp + pr_warn_ratelimited with reject (-ERANGE) (Jakub)
> - Changed cap from 65535 to S16_MAX (32767), matching virtio's
>   virtio16 ring size limit.
> - Dropped the doubled module prefix in extack (NL_SET_ERR_MSG_FMT_MOD
>   already prepends KBUILD_MODNAME).
> - Added resize-path tdc test case (Sashiko nipa gpt-5-6-sol-1-2).
> - Fixed tdc teardown to use JSON list form for acceptable exit codes.
> ---
>  net/sched/sch_generic.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index ef2b4bf51564..eb5c0d3f67c2 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -910,11 +910,18 @@ static int pfifo_fast_init(struct Qdisc *qdisc, struct nlattr *opt,
>  	if (!qlen)
>  		return -EINVAL;
>  
> +	if (qlen > S16_MAX) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "ring size %u too large (max %d)",
> +				       qlen, S16_MAX);
> +		return -ERANGE;

Sashiko noted that setting a large tx_queue_len to a down
interface gives an inconsistent behavior:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081751.134086-1-jhs%40mojatatu.com

(all other comments are IMHO noise and should be ignored)

I don't see and effective way to avoid that, short of falling
back to v1, WDYT?

/P

