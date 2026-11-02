Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643911;
	b=3A2AhfBl7vt6ctcOUsRAkv1BwMSVM6uBplRbO4vvz3aMU0Wl0z+ndaLk/gVzCKh+1qVw
	 oXDRB0+XTuaGD4DIRpGGOz2ZGQa7+b8gYrtwwQ5D1ZxjgHLWp8m9iNLQqeJGXmlLr1PPt
	 azmMXhxbOZNrlgTFP8rv2DIgxoKmmcGrLkySPlwP1IKomLgfTSUfFwe08OJgeEtRgPCjE
	 Bbtgq4+mvciVAtER7haloJ2rV8Oe1/zrOc+c1+KG3JjIc6cdtFFvRZWQXQwz1hkkOZyGf
	 MxEK12APSWrvV2Yej29zMTODnYDSnVlu7D9/HPrLawOT9Tay+0pk8AumCnppOZGnctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
	b=Jgnvqih4paH6SxDGNGQudi1FziP/0RzBXUtERi4HT2TiL2ULcJjy7HGnyzpacC/EyXTQ
	 6PHHoHRw3RwQ+7whJtkCTjOrCk7LwpHXkwWSU4rpEpc3ybt/VwejP8e8fiSbmonFLdN5A
	 nmSGVDgDTZ23ZE13AL2h4KGmyIeneTyjc9FEVU/Ma25CBYNGoYfonVv6xk1WdGKE2vmX/
	 r4KX4BUT3rR7oUeN6L2AfWUJsSHsmsbrmWWHFMLpVb9VYo05J9vOyqu69fHMWXOiNa8bE
	 oDWEiYyusO+A1i0wJmQl1vaFxLjyFlwYP94xbZSuVinQ5Mlme4UCrLGLVJrAjLCUQrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRJX0RF8;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D8606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 18:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 696D8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wRJX0RF8
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so1350489eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643909; x=1794248709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
        b=wRJX0RF8HzOJ5vHpbUCAKfZVjV3IC026OA9dQPQiz8FmPUdyqsaFHt8LcpZ43ExlRJ
         V131kcsJQSQmh60QT+FT7u391++5YsW/YO1DbR+WV8QL6E8eYBo3gGcPwCrAgWVG5rBl
         xPlLnxQ9m5+fvTxjr/g4bwZc0JGUnpU3natXbNrqN3XDX/Q6L7zzd4F6iGzyKrsPQItj
         Xqx1Ed0Gcr6oSkwDipSu2F2AE2yVj9CdZEI/GzDD2emXcMnfxaEAOEUnQ52JLAyxCcTe
         vMadz6FaT/RD/UTS6WJ220Qt5fRzD49ZSypC9hgqQxdy3e/lboRbOgyp1bUDlnQ3/dgj
         PATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643909; x=1794248709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z41mKtHOm7Mi5CS6B12EWoUXhaoVqMrutmZJokfP2gM=;
        b=PoRFRDfLX8+VYj4QvxpHA4x2nzfsvelFixUOBa8v/q8eGmQaT/X9z/x5XgyeXFA2CN
         kHFUZKAC9x6XlFwNBAiciEZMMEqYx/Z7EYVL1Oq49yhv58EsrSnrQMUSIdm8nADJvOCO
         VCeNHRDL96goomW8cgt+TNH7grloOTIeBN37XnyfEBqD9N3Y5Iu1tzTza9eHCKCJ9o/N
         bb9UvX8t4hm/ru+do4lS1HXlyyF66jACe+HpTZDW3KzNQuSwXLez05zSPDEW82zujxWO
         2ZHu2SmptFz4kFOPSyupyDWrxVe3qnVK9F+FYHFhKowoOwOGX6VXh8aHCuZfFbstCNQl
         CEjA==
X-Forwarded-Encrypted: i=1; AKwUvBzY6yyepxyMvoQMpuGDqTUQss+/SmEujcrNFa+RBPbbTtAfPb5kQGoqQ+HsMkNpADEdcChh1K4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRvk7T6Nsc0a7knu/+JEyiKs0gIxIk00FiCL1cgDRuu4uv7EWM
	YXCGmNYQ0VfMEPBBp0HJZ2EME2TpPSg+fkvSgtK68nMztZhjVsg5Of2M
X-Gm-Gg: AYBFou0zb/nWCd6FkYyrcpP75P3T6RBVLGNFZA5vB3DAsME3bVcZvkSuLBUFYt8ymmX
	ShTTZkLk3+/fqXro/gAQnuxiWgSPrdPmctSThVBMQoaMaUeF7ikIK2ckZZ5F792rZdYQ3U7ksh5
	y7O7f0VG/dLwHWaMI364Xr+FEsu8s/wdvDGB7nbGaqr4NFIw6aon/rMMKe2Dirf4ulVC4FuRazm
	wOEichSCQuCj7i8vvUr0IQbwFnDyPNWfMonR7TQJdgPeSdFljMRfdf6EppeajEGzAt704W4h5xe
	btZPyi2cq0wO+lZTQkyGmNQhFyyMf7m6gPs1xN3HAE02p6xUnNFiKHxMHr1PWLq+3VsJyzk/mlh
	c6Yx56KJmsptbtV/qFhX8HzfG2cjgSGI9vSAroZQL7BjkChj4KNHqSZS20y5D/zqskRzFkMfMLP
	E4De+/lLgqgXgLLGewxzoCDfIhj/6lVEqlxP8hCjidzQjBEkyWpd0oj4YP01ErkH+0XD2JyD8LD
	0TgAZn4LGjEs1vo7kxYv6Y7+AkGbqt7gnY42N/ObFv6bn1P1BxfaXOoZ6GFAmw7YkqWbnc3UnGy
	03S0CdGnbGbQVzmaLgZf1fQ=
X-Received: by 2002:a05:7022:ef12:b0:14d:ef19:246f with SMTP id a92af1059eb24-1ac5f36d5cbmr18049891c88.45.1793643909092;
        Mon, 02 Nov 2026 10:25:09 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm46557054c88.6.2026.11.02.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:25:08 -0800 (PST)
Date: Mon, 2 Nov 2026 10:25:04 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Message-ID: <aujU8-MBZ9LrhFMd@devvm16445.scu0.facebook.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com>
 <20261030023248.78802-3-testwrzwrz@gmail.com>
 <auT51NbSPvKJwgiD@devvm16445.scu0.facebook.com>
 <20261031013143.42509-1-testwrzwrz@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031013143.42509-1-testwrzwrz@gmail.com>

On 10/31, Rongzheng Wang wrote:
> > Any reason you're not reading the real value from
> > /proc/sys/net/core/max_skb_frags ?
> 
> The test wants to exercise the maximum supported number of frames, but also
> needs to run on every build. CONFIG_MAX_SKB_FRAGS ranges from 17 to 45, so
> using the minimum (17, i.e. 18 frames) gives the largest bound that works
> everywhere. af_xdp.rst documents the same limit:
> 
>   "For copy mode, the maximum supported number of frames in a packet is
>    equal to CONFIG_MAX_SKB_FRAGS + 1."
> 
> xsk checks MAX_SKB_FRAGS directly (net/xdp/xsk.c), not
> net.core.max_skb_frags. I also set net.core.max_skb_frags=4 and ran
> xdp_metadata; it still passes, which confirms xsk does not consume that
> sysctl. Reading it in this test would not tell us the xsk limit, and would
> only reduce coverage if it is lowered.
> 
> CONFIG_MAX_SKB_FRAGS is compile-time and has no userspace interface, so 18
> frames is the portable upper bound. That is why I used 17.

Sure, people can set max_skb_frags to < CONFIG_MAX_SKB_FRAGS, but I
don't think we are gonna do it on our runners. So for the purpose of
this test we can essentially assume CONFIG_MAX_SKB_FRAGS ==
max_skb_frags.

I'm just trying to understand whether on the builds that have
CONFIG_MAX_SKB_FRAGS > 17 we want to exercise all CONFIG_MAX_SKB_FRAGS
or we are ok wit just 17.. But we probably aren't going to bump
CONFIG_MAX_SKB_FRAGS on upstream kernels anytime soon..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
