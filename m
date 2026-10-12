Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369A449988
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795868; cv=none; b=lUBkhOJZABirjHLDb7KoQcqCbChEE5bwSlPOWHS90LXxUfnm8K4HqG8qEISq98gzscAEzm07w6NvtkvugEJMDMGkIJBhDAlj64cEPtu3iLYI7ddjmkPqtcw/j2zgYtKBICrcriYB0GwfDOmKY+URuiLNX0d4A78lbJ/gRALFUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795868; c=relaxed/simple;
	bh=Z9sdoXZiCAvXUksggZN7Bwbtvi9NyuLIEb/gHrd8Sbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2We79/RVdIMmrukCD55hBbmKQM6tKhS3vLSkWBT/8bccmeQqBpGUbGacTFiQjMJAWRvxNXetvh9RQimTGb+H1a+c4sFRQBayr1hoFvWmCySzkSeycR5hgtfUPc2CB41tXj8duAWCth9ue0vxOfgeToDJqFJmGzA5o7F4ngooe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RqRZQvaW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RqRZQvaW"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so2158308a12.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791795866; x=1792400666; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lSSxuYb41ZPYRHGZDzePbKtEh17LW+nxXJKra7Xv65k=;
        b=RqRZQvaWT6xBe7H/A9rPcDR10OJ0lzcEhoftxyQHMqEMmm/Y+wBquD75iUQZdKrcHa
         34xDMG9TegiVuEpiCu032EoQiF6Ph6lhXHwpw8HB97VqlIvvVH7IGdMFqJ9K2A1VVica
         Dz+KfYa97gfH78yWoe9otJEtJ6KqAEc4UH2x8XqGiWZ87F0Ec9xJhG43cMTLl9Lh/3bq
         uUlfw997l/EHUeElgLCrYljXqq0v+R623wuUHZ5lioDpenb5sdCEj+67/RpWEkZ90m4m
         qUhgB0oDj8X8Vpwkg+NFzHkZ+qEDsKo+p2H1MO1n3xOUYch+lCuO5fxfDDm7sC06kkbM
         eC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791795866; x=1792400666;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lSSxuYb41ZPYRHGZDzePbKtEh17LW+nxXJKra7Xv65k=;
        b=ntN9JKDj8aVA73piA7/ytdZfsD+CP86eh13dh0fzel72lARRHbUrcH5BkAPv8HO1jJ
         1fSRc3s9WEp8QK3F25BXY/IFvHYy4pHqpP+KpEFkMN53yDftgeHTBTfv6bQX0vhz0UiH
         jIf/i85q2jJVyhBLl+P12MTOPe7xqSCNgR6hczHMDk3GmZm9yS/AL0cGJ93fopu9LbJN
         ep7jcVzE2Gk1KvpF4BPpJU4/n0/xzV4zWUGDHyHvhBD0hkDcTyJQn69PUTuoSvyJ+f6j
         gNh+7cpH05Ecp08wRYT23uNRwrdxpss8rpfJmpJcrE9oYvdp0sxeMisvpEswKfhOBYey
         kQqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6EVYLk/KPcftQCe8nvQ4DgI/6VX+KNRnK9/kfvtQSiNwiaxhi1LUtUOppdTJuHMcRiDYACFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0EIiDUaS79IltqCJu9elIyj+h0WDrCnrtvhHtgTMnpqcbQzs0
	HSFlyoOisKSVQoaUs9uFkCUaPEZDaaqpsvQFi3sAxpMQnGOeQWx3BacrY/qGqkCJkRs=
X-Gm-Gg: AYBFou3Esex79mxY9OfpHg5ZNxUdoCMRAmSaejsA0Gv9utN/ytcpUChk9q5CvTYvROJ
	Yyor5HL2u7M+wwi0Nr6THyapzFs1qHw2lRrLmMPsmBMuwUyFEt6MD++SltKUscK1gmZHzz9vQpH
	9yenNQugmGP/G5Vqsla8N8DeNUn2W7dQPxXOKk/p3Kf7J5aRZZ7KKZ8ZQp2aPT/SZ1hAt9yZxH4
	s9Eo0kAqIvSBW3jaMz2IkcDCO/xrftIukvWMGoOa54BRqEVQ/n9QM0s76zYcdAOdwJjVKv3LGuB
	BcEf/2xWv08P3NyihJ1VTPWdKY64XWHAoex2aw84CDIkqC3wU06pr09OYP6IPiweM22u6RM0bwl
	M3ApDB6FlRBrHdQOucKxU9p+RsG3/y0q+qKAPuTqZ5ZBoSwbQEy3jXFTXqnB9Dk7zIMW8FyJYDn
	ypD7GMDJ0ZJMeCFjjbFMJz7rzBn+xtdxdWX2UoG1dFM+GWkHFiitcFu1+qZoNHhRfuyBRw2+m11
	NVraYrOS0wB7BPdZ9snEODMQEPkJAk5MX28vhUJoXlX3T/dxALudoVwKM1si8HSPfI70ui9fOsn
	Huq19xMYn3vp7w==
X-Received: by 2002:a05:6402:321c:b0:6af:9bef:cf75 with SMTP id 4fb4d7f45d1cf-6b17c1e03e9mr7944049a12.4.1791795865570;
        Mon, 12 Oct 2026 02:04:25 -0700 (PDT)
Received: from cloudflare.com (2a01-110f-491b-1300-bcd0-2dc6-3ac4-45a2.aa.ipv6.supernova.orange.pl. [2a01:110f:491b:1300:bcd0:2dc6:3ac4:45a2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179e03428sm4548461a12.37.2026.10.12.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:04:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jan-Gerd Tenberge <janten@gmail.com>
Cc: bpf@vger.kernel.org,  ast@kernel.org,  daniel@iogearbox.net,
  john.fastabend@gmail.com,  jiayuan.chen@linux.dev,  edumazet@kernel.org,
  kuniyu@google.com,  pabeni@redhat.com,  willemb@google.com,
  davem@davemloft.net,  kuba@kernel.org,  horms@kernel.org,
  yonghong.song@linux.dev,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: Fix UAF when map user reference is
 revived
In-Reply-To: <20261008095656.92793-1-janten@gmail.com> (Jan-Gerd Tenberge's
	message of "Thu, 8 Oct 2026 11:56:56 +0200")
References: <20261008095656.92793-1-janten@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 12 Oct 2026 11:04:24 +0200
Message-ID: <87v777jnmv.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 08, 2026 at 11:56 AM +02, Jan-Gerd Tenberge wrote:
> bpf_map_put_uref() invokes map_release_uref after usercnt reaches zero,
> before bpf_map_put() drops the map reference. BPF_MAP_GET_FD_BY_ID can
> find the map during that callback and raise usercnt again.
>
> The sockmap and sockhash release callbacks unconditionally drop programs
> without taking sockmap_mutex. A concurrent attach through the revived fd
> can therefore publish a new program before the stale callback drops it.
>
> For a bpf_link attachment, this leaves plink set while pprog is NULL, so
> link release warns and leaves the attachment slot unusable. The callback
> can also drop the program between sock_map_prog_update() and the later
> bpf_prog_inc(). If the program fd is closed concurrently, this removes
> the last reference and schedules an RCU free. The subsequent increment
> then resurrects a zero reference and leaves link->prog pointing to memory
> that will be freed. A KASAN reproducer triggers a slab-use-after-free when
> reading information from that link.
>
> Triggering the race requires CAP_SYS_ADMIN in the initial user namespace,
> because reviving the map uses BPF_MAP_GET_FD_BY_ID. A deterministic KASAN
> reproducer is available privately on request. It was used to verify the
> UAF before this change and its absence afterwards.
>
> Serialize the release callbacks with program updates using sockmap_mutex
> and recheck usercnt under the mutex. If the map was revived, leave its
> programs intact. Move the map user-reference put in link release outside
> the mutex to avoid recursively taking sockmap_mutex when it drops the last
> user reference.
>
> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan-Gerd Tenberge <janten@gmail.com>
> ---

Please include KASAN report in the description.
That helps others find that the issue they hit has been fixed.

[...]

> @@ -1743,6 +1750,7 @@ struct sockmap_link {
>  static void sock_map_link_release(struct bpf_link *link)
>  {
>  	struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
> +	struct bpf_map *map = NULL;
>  
>  	mutex_lock(&sockmap_mutex);
>  	if (!sockmap_link->map)
> @@ -1751,10 +1759,12 @@ static void sock_map_link_release(struct bpf_link *link)
>  	WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
>  					  link->attach_type));
>  
> -	bpf_map_put_with_uref(sockmap_link->map);
> +	map = sockmap_link->map;
>  	sockmap_link->map = NULL;
>  out:
>  	mutex_unlock(&sockmap_mutex);
> +	if (map)
> +		bpf_map_put_with_uref(map);
>  }

In sock_map_link_release map->usercnt is now modifed without
sockmap_mutex held. Is that a problem?
