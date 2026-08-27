Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620B391842
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826655; cv=none; b=lQmS6AvT1VvyydkT0JlrpvTvlYpo7mzLZe3p+aW3cQsO24pyWUYlTxf10mSVv6ra1Rquk4691/GvMnxhivr5mrz4fUb0FPUEMjSIoUFwoSfCjDDrTejJNZvLFuqPEALKq/MyBZ5ZhiU0VWnJGMqVLLy2Dy+0a8qqpkH7nrGRXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826655; c=relaxed/simple;
	bh=S6GhQVyUZGTnSl/ca8Rx2+Jo7hUuN+FEZGl+i0njXk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UANw9rIhy3iGsLZ3ryw5x2Y9Vk72YubeNP0pgf38SOX6JjJ40iNaFAwRV5I3qiZA51AXFI5cSEo+YIiLWlceGjpBvYhMel5xuxhG4e9speGwUkpr+cUKUnCCnWFzGR1EoPE5m3q+x8MF76bgKcaUnsRqEEtCnI6ryaWYEdJ/DvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsCG6qgy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n57NY5Pk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsCG6qgy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n57NY5Pk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787826650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KsgJELkcaTebKxgMzCShmGLeI9I6HcVeNbXES+/VH7g=;
	b=SsCG6qgykPFVmf0XYEgo4k01r6j0jJ+NObHUL3J8KGcX3zPvvnvi1n23W0OeMUqV8IKyhI
	LwxzthQHjdNNcListgyhfR193BWauzO+Yw71q3+7Bd5esk9VYL6mtuGtOJY1ZpgLocPWF1
	rXe93jd9HK3ye3HVwABL3aOX1kKZfiU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-yJydW6oOMcels_PlcmO6SA-1; Thu, 27 Aug 2026 06:30:48 -0400
X-MC-Unique: yJydW6oOMcels_PlcmO6SA-1
X-Mimecast-MFC-AGG-ID: yJydW6oOMcels_PlcmO6SA_1787826647
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499bd779522so10611245e9.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787826647; x=1788431447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsgJELkcaTebKxgMzCShmGLeI9I6HcVeNbXES+/VH7g=;
        b=n57NY5PkU+tv8ua1btl3whlpGCQ92GhvXhUoSNlKISAacTeIpfXxcF4m4lsm1geedg
         sQyXNG/Djmf3Iw7Ub4xJDu6wwiBOE8oZpuZpsNnLp7weN6lJ8M/KyxzbNwnZAvyRVmdc
         SVZf5hO5XcdZ9Lo3bVHqKDeN6bNUai8w5sKwH2MHkR54bIhAFg3eqnITZPA/hEQJhTwv
         mTUm2z6KqDrTLc/nK0fslJwxw3fpUR5wKeHicNmjoMREizv9eg8FD1e7NTwjf0Z6n5N+
         pWY4MU9eq4a8bPK+oTLVQ33HntLOgxFD2TvWtWi6v1tOVfWcjirj64taiic5powta8PS
         KiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787826647; x=1788431447;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsgJELkcaTebKxgMzCShmGLeI9I6HcVeNbXES+/VH7g=;
        b=pCoCUzGenjZKsHaf0aokkYaC3C1c3bVk+q92vha2Ks7KiLJReaeE7ig5e2COiqHY7y
         5lgPAuUMOrnGkMu4t0+rBsaOiq+zdEi17hEczxqmWHvXzJIHp8VSzNhrCKSuUwdWOCv6
         Fr9mg0Bm3iYIfdJ6ND6w03E3721+vqzVkguWKU/1dXz8nyiqOAfsmkEh8z6FFL/WtMtM
         EQpobOwBnT2CHky9mGNc5dAcGb+7VRF38HMFjZyQZRuzdBOxp+DQOrv68oQD/mn3tZbC
         g7lq0A4eWHgT5ohY29UXXag4Cr7/jZNwDbGZMcTMGoLTlQ1lEoBkQodkmoNkblh37ZTG
         XXeQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAMdsS/ht74YyVK4uvkpIMnA0Oo6k/s13KbMla4GYhgTxhW1ZWyU93hPt+b7pRA8hSqrDvqP8=@vger.kernel.org
X-Gm-Message-State: AFuF++lb9/nHKZXoS4ZJBu2fRYnOi1C7UJOIrmin0aePqKC7rHINM4SD
	vqteT9fdgqNbkpbngBx/gHaCOOk8kylXuKGi0TThiMd5JT6/qmWKtxlr4SV6VPZ/qT/Tn7lJK4e
	13WQfAWzg6clGnXf/7D7eq15c/kJ66HQSO2OP0iLn6N3AVi/EIzh3AbHydw==
X-Gm-Gg: AR+sD12oC7bk+QPoUiSyonph0+TcACl/uzxvoPWFW9lDBWhQLbpulJe1J8RnfnZLySh
	ySkTfRADzuSdMa1F20o082ySrP2DiUdSIxM4v00m7Tm8uvarQcQr0FmshLvxNJXjhJ4suyWDTE6
	bjVkyCDTxL/dufj5YvKhWNDcN46rhz8zdrsUk2J29x16tnFL6RPStCVxTC9Y2SPfXZyUqlj1UqB
	5+LZ6h62ubBsHvqJErSJe9JgbZssoHzT4PP0NX/X44JWNHD92SaawVcPMPFK8Z1sKv6j6v3/NT3
	+T3uV8NkChxTS3rPxjXABZ9vC9bShqMgiihGr8h3PFOAA/vYfxz+6daH1OHA35V/z3zozyJUdKX
	HFNqQA637cjAawCUIsZaSes007zmYyNikmcGiSf+E5OXDcERFNIePQttYS0tZ1Oe/lyK+QJQ=
X-Received: by 2002:a05:600c:a12:b0:499:dae2:c613 with SMTP id 5b1f17b1804b1-499dc81cca1mr157369995e9.12.1787826647244;
        Thu, 27 Aug 2026 03:30:47 -0700 (PDT)
X-Received: by 2002:a05:600c:a12:b0:499:dae2:c613 with SMTP id 5b1f17b1804b1-499dc81cca1mr157369265e9.12.1787826646760;
        Thu, 27 Aug 2026 03:30:46 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dbe1dsm8545317f8f.22.2026.08.27.03.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 03:30:45 -0700 (PDT)
Message-ID: <81ad3c6c-85d3-4ba0-b36e-3db21138416d@redhat.com>
Date: Thu, 27 Aug 2026 12:30:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net/sched: cls_u32: fix duplicate handle when
 node ID pool is exhausted
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>
References: <20260825081052.133898-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825081052.133898-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/26 10:10 AM, Jamal Hadi Salim wrote:
> gen_new_kid() falls back to returning max (htid | 0xFFF) when both
> idr_alloc_u32() ranges are full, instead of reporting an error.
> u32_change() trusts that value and inserts a new knode with a handle
> that is already live in the hash table, breaking handle uniqueness
> within the table's node ID space.
> 
> The handle was never reserved in ht->handle_idr, so every later error
> path that does idr_remove(&ht->handle_idr, handle) removes the
> reservation of a different, live knode, which is then reused — one
> failed add compounds into further duplicates.
> 
> The 4095 limit is per (table, bucket) — ht->handle_idr is per hash
> table and the range is derived from htid (bucketid), so a table with
> divisor 256 can legitimately hold 256*4095 knodes.
> 
> The sibling helper gen_new_htid() has the same silent in-band failure:
> it returns 0 when the tp_c handle pool (1..0x7FF) is full, and
> u32_init() publishes the root hash table with handle 0 without
> checking.  Two root tables with handle 0 alias in u32_lookup_ht(),
> allowing cross-tcf_proto knode add/lookup/delete.  Add the same
> exhaustion check that the divisor path already has.
> 
> Return an error so u32_change() fails with ENOSPC/ENOMEM when the
> node ID space is exhausted, and so u32_init() fails with -ENOMEM
> when the hash table ID space is exhausted.  The extack message
> distinguishes pool exhaustion (-ENOSPC) from a transient allocation
> failure (-ENOMEM).
> 
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=y, CONFIG_CLS_U32=y (or =m with module loaded)
> - Create a clsact qdisc on a device, then add 4095 u32 filters with
>   auto-generated handles to fill the node ID space for the root hash
>   table (single bucket). The 4096th auto-handle filter add triggers
>   the duplicate handle (fh 800::fff reused). Reachable at Level 2
>   (unshare -Urn, namespace-local CAP_NET_ADMIN).
> - For gen_new_htid: create 2047 u32 proto entries on the same block
>   to fill the tp_c handle pool, then create one more. The root table
>   gets handle 0 and aliases with other handle-0 root tables.
> 
> Fixes: 7801db8aec95 ("net_sched: avoid generating same handle for u32 filters")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v2 -> v3:
> - Fixed tdc test that sashiko (correctly) pointed potential security
>   issue on.
> - extack: condition the "Hash table node ID pool exhausted" message on
>   -ENOSPC; emit a neutral "Failed to allocate node ID" for -ENOMEM
>   Introduce small extack helper. The v2 message was misleading for
>   -ENOMEM (Sashiko nipa gpt-5-6-sol-1-2).
It looks like that sashiko was able to think more about this patch and
found new stuff:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825081052.133898-1-jhs%40mojatatu.com

I'm unsure if that falls under the 'same bug' category and should
addressed here or separately. WDYT?

/P

