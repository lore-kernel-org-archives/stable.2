Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215772;
	b=rprm72P24Ya+FYe68ZTNMYxtFIpWa8xxc6fgXachW/Vwyn6UUOZNNQ/Ch+jMn0Lst+pC
	 JSLExtTpcWmULsjL/NRDSOaW8LFLFDSoI30uVvF9PPEV2/x+9tDEJwrAD1vtqxYPvItdx
	 2kDoHy0Y3ZuQ2yJgj0KdODmywe04WzaQv/mybSHae+DFMxXLaap6fpH2NbCzXvooWrgkz
	 wX5d5PddHx7lm0SorBYpG69MkZ11seH0scymdTzN4FfbTbKgEtWYnLcVpwDjHwnnzkiim
	 2gZah9bqj4kjwKeJS6r4kkkK8jmXy5fl67/v6dGrKEHXF51P8gJ+XqZUbnbztQSxHFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fhIxlpuFJcBXrphNeNwx+YcRvaFe0jopB+8JEZHNr+M=;
	b=CiL0YVlA/96l1pOGfaJduNYK0iqh1lN6Zbdln2jxnMZijhqWVVH/ArelZPvUbrzlCrhB
	 uOdTRqH18DK9JCczMkLW2y+oZ7bUeM6cPlxqEx0hqS9oeWnZd8tzou2eT/MrwUw2vNt0h
	 /+O+FTekneU6Ixjgn7RwIeUnTwF1mwdrOwPiPRz5W7rnzMh8i+C3df+fncSxSIyaoq0sK
	 hfbEv7sL8VOBOJRe6y8RPHv7ELhVuWScz+aukc2BJEnVJaSMVn1XN3t8zeR6b5Hb+RChd
	 EyOf7rqYrw16F6tspDrUpd3rCjkHWDnJfjRggG7A7wsd0v5s94Exq5PtS0W5e8egvIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nDyVVPpZ;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D065606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 19:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D065606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nDyVVPpZ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e93f67358eso12393825ad.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793215771; x=1793820571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhIxlpuFJcBXrphNeNwx+YcRvaFe0jopB+8JEZHNr+M=;
        b=nDyVVPpZ2XLMVcMcMfu3Ju2+6ZjLyfZ3SxeUgOM8o0tSDQfHLG1jgqSLCFvlis7uOZ
         wo1/C87w0qBPcfvh051AN4U/I9OnnvEZhF0Jwep420UsCNWlevoCr154K8dmYSBfTmmx
         XHhcoFj9eBHEsvE3CefF/Vyiuyo/+XOpSi1R0OFeX19g2CroLgDWu11IZUyTN6kqH7Om
         G+EXIQfNuZHLnlDEiLVdX/4+GIiZoT1r4ndYW0cMi7NcGxiajgEZbMOlxbacOCTAWEbp
         J6ZtvDRUsYzYQb/jJaoSuC7KS8zTLk8JspOkALI1Y1kUkqwoTwLL3QLe7Xkyu14EXDz4
         eULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793215771; x=1793820571;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhIxlpuFJcBXrphNeNwx+YcRvaFe0jopB+8JEZHNr+M=;
        b=ZZgTMWv1JWYLIi7wZKC92W90CVsHuBOQw0/WmfFSFCrzDZKK+rtGBt0shSqkZarzkT
         B80qvb0XkcTU+lS8XFdqcNUgGbuJvTNz5nKDpITl35jXfeJWaYVX1NjvxS9moCImvkfZ
         OVFPxF/3xTMj4AKGaa0u6v6v0ZqiuvbURqqXCx/V7VpaQCqsU2/w4nTT5h7LzeVX+m9K
         QT2Up8ts7YOvz6zBpH7Tx3W2XbqxPdKfKcxtSMvZOnlkbebbj85wsP0cORpOyMqwCMiR
         rpsI5i7CeS8BMk+polffFAYD61rJE1B1V7o9V8lKT0n20dHGzpi97cvVMjAX9kFp/QEi
         o3OQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2TiJJRmo1w+9xJM6hR73u/sWr2jyXZxIZwFeqJTBddwzH3BvLnyazuTpwIRY/mFkPLyi4H7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKIGa+RR7mnjElrM67F17NaVHRasON3FeCtsFLSF3V2QFwWz84
	hDbdFsNIcVw2FYf03vK5gbJX5XMeHubi8NO6kVokvXBV26RxxWdHGoYdIpg2AhQzYuBqePMreZa
	nG+a1QQ==
X-Received: from plic6.prod.google.com ([2002:a17:903:3706:b0:2e8:7c6f:de6a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1cb:b0:2e9:5714:608e
 with SMTP id d9443c01a7336-2eb00487c87mr32243115ad.49.1793215770650; Wed, 28
 Oct 2026 12:29:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 19:29:30 +0000
In-Reply-To: <20261028160226.2170244-1-edumazet@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028160226.2170244-1-edumazet@kernel.org>
Message-ID: <auJNDPw54Ojurqqq@google.com>
Subject: Re: [PATCH net] tcp: fix reordering addition overflow in MTU probing
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, 
	stable@vger.kernel.org, Wyatt Feng <bronzed_45_vested@icloud.com>, 
	Ren Wei <n05ec@lzu.edu.cn>
Content-Type: text/plain; charset="us-ascii"

On Wed, 28 Oct 2026 17:02:26 +0100, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> Commit efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and
> MTU probe sizes") widened size_needed and the MSS multiplication, but
> tp->reordering + 1 is still evaluated as u32. RTAX_REORDERING accepts
> an unrestricted u32, and tcp_init_metrics() can install U32_MAX.
> 
> In that case the extra-data requirement becomes zero. A write queue
> with probe_size - 1 data bytes and a FIN satisfies the sequence-space
> check. The coalescing walk can pass the queue head to
> tcp_skb_can_collapse(), and tcp_clone_payload() can produce an skb
> whose advertised payload exceeds the data in its fragments. Local
> delivery followed by TCP_ZEROCOPY_RECEIVE can then walk beyond the
> fragment array. KASAN reports a slab-out-of-bounds read in
> can_map_frag().
> 
> Cast reordering before incrementing it so the arithmetic handles the
> entire u32 metric range. For U32_MAX, the required size exceeds the
> 32-bit queue and window limits, so the existing checks skip the probe.
> The calculation is unchanged for all other reordering values.
> 
> Fixes: efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes")
> Cc: stable@vger.kernel.org
> Cc: Wyatt Feng <bronzed_45_vested@icloud.com>
> Cc: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
