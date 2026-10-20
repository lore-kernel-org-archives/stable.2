Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509797;
	b=WkC16pI9aHVWP6PZsljMDZE7Ok8c7dgv5/KDj9D+G8ezl4gL5bYK6IlIvjU07rQ97T7q
	 wvi7GabnUI6zDEmVGP+k272APgbeEzb3SRfWzOmTTcNtw/GkRzjK01YKUuIgGgln5a45k
	 zuSABBPWnLQUl/z0l1fiQdSnkQ1lxKv7BSCMIJumvnXTz2k2waeXHmSqueXf21KNptXvq
	 A8x134RkHZYDAk92KHRRwncol6HLlAF4R0ggN/kVhCYGl36hP4XUpBeFq9UdxZvgqJxH5
	 tyt+x03iZ7iM4W8stL+SDTyStGV57tsDzMQC7339/S4BhTCzRlJXwQn72PL4xIgPulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gRK1N06gC7y4lklCZOXSgRG5jNtEwJRUHirNfgb2kAs=;
	b=ikkRxgCtTI81cnHSDgFlP3Z3SLUIpk4LLBaX2EAa8PiDlj8lU3sCisvbXEqrh+xS5lrN
	 lZDsez30fap8A/lwAYLntI+boFVB2tC4J7nIfyjORgpv0QCyUz75i2PNXZWzfciVYDJOy
	 Zxeuv+CUiEo1kz73zHRTks25bCDGvpPdILSrMqW8oZnxniLkYk0IX2b+crPb1fLrLnfxg
	 3OfiK0tz1XeuVKQJEDd9Bo2i0IKX63d+8dqvAFEt+yLmS/KMYIXWqn60jCQ5h6N/E2NZJ
	 PAqQfj0slOFnJSat5uiDDmor8sIrVNQcMyD6zOmDY2Goxz+Z39y0XYUdHf//uB99Oug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=dkPslbGk;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5C606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EC5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=dkPslbGk
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35f036b17easo1302646eec.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792509795; x=1793114595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRK1N06gC7y4lklCZOXSgRG5jNtEwJRUHirNfgb2kAs=;
        b=dkPslbGkC1nueqKNXl755MPhADryHbix1NVdewPX8G0v9UdD7ZfloAWtp9AAN7zC5/
         vaYuCEQu3zOAobsJcIgqUtf2wYzeZwthITqkeWWuj15jPJASH2wlHWmNoxpvWu6LHzWX
         pL4Cz7cFTpzkQ6kEDymUiK2vJpxXPX62Ob7r7tJb5oqf5bHEiNDpj+vDwbTRL6iD5CnZ
         +/vTZ6N4iowAvPU+hwW3vGLftpHfs7Z8U8fOkmCqAtbeN7lyo1IY8O4KrI1pJ4k4x21k
         tPgoO+JyoZSiG5fgtaAFynGDBmqqeXrNIOYbilx19pq1K07EMW5CyFNpGsVuNdmFuf8Y
         tGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509795; x=1793114595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRK1N06gC7y4lklCZOXSgRG5jNtEwJRUHirNfgb2kAs=;
        b=aKVsi5URu+eYjwmgZBHnceBq8NOQ/l/Sc27rm/0ritf5GXV+c6jWfM+XKowwh+fLqi
         XY0JNVGuSM0qbBLffOqTWmYCIqp5ERmHSxhsmnbahGcMSt3xnL0qHP8arrKlhmBOtAi8
         zkUpxKzgwnT6kDx43eC/iTrTFZeOfsmVbz9QGhiO1s3K8jvxHc09iVQYrPpAKDt1ADvY
         NRgELehLvqY2Xy7ERYAVx/gC7pbaTfkqTduYaKGRcu2QHW7NCXOKIZdI9yeDlS4K3ewS
         psbFySI9OnqSdcrH2sMHqgWd4NH/ubQXllsKVRVfDeEh8ZHz+cLC7Y7ty3Sqdw4vtfqw
         hlqg==
X-Forwarded-Encrypted: i=1; AKwUvBxYlSc7kKv/SVbYTngMuA4syIKurgzCTM3YqYrZxvtGSKA964SuMKFBeFVdXUHZ+vbGNzHdBbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIu6gAMs2JlRDLpfuOwI/Vn1BnHBfa848DYuk9UBrIHw7dBc/M5
	e8s7Xb/Qk60HAu31D6627cB/GAEI5ER2eGNSDSonyZVRWOwMj52+uXf7EeufFQrMbKzH81x43mS
	sHFxfox8=
X-Gm-Gg: AYBFou21QIWDH7JXUcGciGoArPCcJCQ54NMyrfLpXz9+5gJz1I+FZX/RFqH01+tZ0xb
	WQLRVO5i9DgLT/MbQOOg1P2OXvHMVTIi2oPrrDMuXq1yuGhWkq3LbI2y8pHlN48Eh7APrJJfku6
	i/OwcIW3AUETgONDTUcSitul0s8+P3YuenE9FuuKHE8wvqWcZGxvj/jrqiau5W/X5r21vMxoN2D
	WJpX33D1s8AD7soJNrLWBaiGZSyODENHKoHcFp/lPjtCgyYwCT1Mx3/Dxfi1MPjUQIlOBUztamx
	lPLRNgU+XpRdv6D9jAHoo8e9qMo2gv87zqLYWweirrXAXdT2WzCjT2x/shf8IKsmxXY6IzDLC4T
	tcVaLpivTjiAm6u1OX3JnXPWGt6UXn7aRnmvby9qcTQzSgrTaSA8LzE8i/nhxDq855lk5NPyG2M
	txtfLzsDV574mE0lquIC/jGF0KbHC//kQoddvo5ujzioAECJXmA3B02HfPblqFMzC7C72j/P0xz
	1gZ2Rc7sbD8LnRzZWRVw5mL0V0lofwoEKETmWagCU8qb8URu0u1A8etwEiPwAhq3vRBqO63gGYV
	IBkRLb8ih7i+AeuxZj20tjsoPpZLuyYqBdAqgyLhUUU2fNAHljQ1QAc/qFQLoJqrkzxfZUxvHxn
	r7nw0
X-Received: by 2002:a05:693c:62c2:b0:35f:f0:8ed1 with SMTP id 5a478bee46e88-361a2a3f147mr13596612eec.36.1792509795251;
        Tue, 20 Oct 2026 08:23:15 -0700 (PDT)
Received: from [10.61.8.29] ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm39540410eec.9.2026.10.20.08.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:23:12 -0700 (PDT)
Message-ID: <694b548c-5f34-48f2-8ccc-5aa020c76939@kernel.dk>
Date: Tue, 20 Oct 2026 09:23:10 -0600
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
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de,
 frederic@kernel.org, tj@kernel.org, sean@ashe.io,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261016052203.489760-1-atomlin@atomlin.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261016052203.489760-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/26 11:22 PM, Aaron Tomlin wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 025a799f35b9..1a113679f15b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2241,6 +2241,21 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
>          return hctx->next_cpu >= nr_cpu_ids;
>  }
>  
> +static inline int blk_mq_hctx_unbound_cpu(void)
> +{
> +	if (cpu_is_isolated(raw_smp_processor_id())) {
> +		int cpu;
> +
> +		guard(rcu)();
> +
> +		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
> +						 cpu_online_mask);
> +		if (cpu < nr_cpu_ids)
> +			return cpu;
> +	}
> +	return WORK_CPU_UNBOUND;
> +}

Not opposed to this, but let's please think about making the
common case the fast path. CPU isolation is not the common
path. That might mean annotating the hctx itself.

-- 
Jens Axboe

