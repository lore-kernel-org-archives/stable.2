Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4805317173
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939047; cv=pass; b=hSGhYEzQlbi87TZ0QWxxozmBTCsQkjNBTCr2A8KQCaTdveQ0blhTbs//qdYxOXem1tQDmPNTEvIAONaufD03LUC4uuPfGQelOtpwxy6Feie1aabsnE5XHIdSn5Sd35gNP/rj68eCSoyiW898ViJjy7B7ahpwHJQoMd+WNuIksGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939047; c=relaxed/simple;
	bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h81I4cNLgU22h0fhFHlq6VS3AlVabezYtYP9OYrd1A//aIf7tfbkO9+juRdzhNGmEp59b8+hkFMJbqA0YiXTU5H95jjuZ/bkcDgmkawkY/qFaJDRrl449nHi7pObbiK5EMX/dIgaKOzAIXIjtcGW8GchOCo9ApZSydR8/2aQRLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eCu2AqsY; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eCu2AqsY"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a49a022221so4840741fa.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 00:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788939036; cv=none;
        d=google.com; s=arc-20260327;
        b=kJHdRJckHJ9TJ+DENsFROGk85vjOUbocaYa063q1pgiOknn7ek/2ysp4aHoV1nFNLr
         fccOQQmMSYW/G/1oifA7UPjToV/LspHAlECbGWl3A2agimQZdkO3wZwdgJyGgKp+50On
         fMZtOjpy4f8Wosz3Hb8A9SUP+weeyccIOhEVpKeG2YHXGkmtwOOkGpYyQdU+LRoiPRLT
         nXDkj5GXAZ+XGqKMnqaG5qMYknffHyeWVqUPoflxpS6LIMGQGJPZ4aSVIUs4qbclRaKj
         QeJneW3nABFy6rU84A9aV26MgxfnHnC+xGaGfSFpmYu/gIBZv6Ya2/bpf+Zg/4C0DBtK
         cdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
        fh=c4w1Ik+ic9nv69Mckj3ZBTrzNlck1IxKgRDqUy8VhAc=;
        b=ifPsKrPJfm1wyB5h268u017h3eVW417AURrgsMbi+2l8kXOdc6rUxjP5NEumSJ2G00
         0DYfR0CbWUUoFA6tvNI1PTqHVn4fwki+48bNSVz+bnaFMYpuHEhiyARlpckNLqrZcPHA
         nV2QCJ6cG0AdEZSoBEXIjHO2bKNtsstu8Ty7gttE8LJczwZ6oTVFHduLDyJmi6z6vJm5
         VUD43jLl6XK5GTYDi/gIHBucX9U4zQBWN74kzEILjIMBzv7P3k6ppcjkfmipJJ6TxMNc
         r/gwwB3sRvUOnzFbSqFMGPKm0OWYPVvprlQK3dzg3zuN5zQHX3XC5MgdXOE9zHlUAvkx
         pUzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788939036; x=1789543836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
        b=eCu2AqsYjrV0XGwmJJOKres5OlXvJDy+m1zvLIJQT+pWHPtC7dbOc3QSwGdye6VkrV
         2QJv6XOcz/co0uMdQwMajykM8FmdUcfbOMYBwB8d7KBN6nd9ivt+oyQf6Gac0J44DNSQ
         WOiFNtjglS5uxM097OwcvQ3jy91/RcQCMjfpqZiNXFCaYYnjaAsGpBILChg72WyeOxnA
         Rx48G+tw1orswanXUOXryaKOo1sDMXXFk+Jdjgmt8X1lgcabkkTF/03+6mXmWSNYNHSx
         ALCEYkhU8NJlcmgZ3BNPHfRbR2rchhV++hr71hC8FyyP1b4KMm/8IH/rVLNAUGnFoZV8
         03Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939036; x=1789543836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3vf0lxPvj0VsYgM0mKRHGlkFAuh7BOATLuYkdiC0ks=;
        b=RdTmZDsKQNcQ3XoVKa1RwaUX/wMr6wxPzZkNBftqq/N4DiRNDt/ifUEkoVFgG3qUmh
         kKM6QrnWE6tGC4POMHqw9IFpToz6a7xTLwxb0v9MfcAjfnd+kpzqD53i7F+JW90fOsei
         S+3iOICxHIWf0W4tPgOdGHKVx/FaWaQhU/UFEZ7Z/eugCCCiNHSR+psxrGz+/KgcLHEb
         oKY5R1LGkgioyx0mX8b3JrJ9yoe1YPWwXc3oYgFoPTLCUXanuAB9paXV1UeS7e/Y1H25
         wVMZ/lVYtEta36IzmauIekBIYeesEjxSQ39rPk54iT2uy1MkXkJlZBC0y80kAwVD6k8E
         HuBA==
X-Forwarded-Encrypted: i=1; AKwUvBxiv1b+IdVm0uXcOXzupztKBY6G5VyNw/zdQ/ljO40bV9RdV0ciph3wx0zuHhL3KM/SofXOpSA=@vger.kernel.org
X-Gm-Message-State: AFuF++lUBcdAnHbn9I47enaCQE7spZ6uJLxeq/NXjFchkd/rQiv29MWA
	/RQWP4nHLmoHu6PyBNDfyaV+4jxFazr0PZEnw1fp3AYgxFYM9UeOrVYtxvXoE+e1Zzgmg3FXqw7
	39vdMgvCPFLlgR3IRFMIzSbNkTOrbYAg7anxVNi2hQwpRSG6+ugm7RxFKeE852A==
X-Gm-Gg: AYBFou3F+vcKPoKmbW0ndg2OoBjf8KchANltFnG4fDCdcy9mVRSSf087pqL4l9EOqJe
	IJI86j5isU3UUIJLsq81dRjeiYo48ygIoPOVO2y4X5GWBoDH9CnsFaFPtQe7q2GqySKYv35jHdL
	nEnFOA7kXbcr+tfCyuWOMSfMQgRM/5YFwKoKiGPkym9DtTSPBSO8Tv/kn6UsBVjjSoJZJQt0jGT
	Cv3rQOm+AmpX/mVb4gKiQ3uNdiqGsH32AfbUzAbDYW9zreMW78ElCIj0PON2VQx7L0acpLH/6lZ
	40RWTUsb2Y7RlXmYN0JQOWcVTnkahkMqHYcs02tdGckiMwXQ/khiET1qsdV4e0c4l5ig1ouEHKB
	A4f5T/tRbmEKj0OwebDa2
X-Received: by 2002:a05:651c:a385:20b0:3a3:74b9:8a7b with SMTP id
 38308e7fff4ca-3a374b98b05mr21405141fa.20.1788939036180; Wed, 09 Sep 2026
 00:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788784801.git.zihanx@nebusec.ai> <050b58f7fc6b45da0fb12768ebb62d18fa46133d.1788784801.git.zihanx@nebusec.ai>
 <20260909071000.GA1211770@shredder>
In-Reply-To: <20260909071000.GA1211770@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 9 Sep 2026 15:30:24 +0800
X-Gm-Features: AcwNN1V4-uX6lZ4IPXnkjG6wL-P5CzMbMzO8E1lpdYuY4e4s3sGr7gx-JsToyKA
Message-ID: <CAANe3eQA-eGdUdSZaFNpcuibnqTxNxmBfckoaH8fP5m4y7YuHQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ipmr: account multicast table and route memory
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:10=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Tue, Sep 08, 2026 at 11:58:39AM +0000, Zihan Xi wrote:
> > A netadmin in a user+net namespace can create many IPv4 and IPv6
> > multicast routing tables with MRT_TABLE and MRT6_TABLE. Each unseen
> > id allocates an mr_table via the shared mr_table_alloc(), links it
> > into the per-net list, and leaves it until netns teardown. Those
> > objects were not charged to memcg, so the host unreclaimable slab
> > grows with the table count.
> >
> > Account mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
> > IPv4/IPv6 MFC caches SLAB_ACCOUNT. This matches the established
> > handling of IP addresses, routes and alternate interface names.
> >
> > Unresolved MFC entries are still allocated from softIRQ with
> > GFP_ATOMIC and are not charged. They expire after 10 seconds and are
> > bounded by the socket receive queue; see commit 0079ad8e8dc3
> > ("ipmr: remove hard code cache_resolve_queue_len limit").
>
> Not worth a v5, just noting in case Sashiko nit picks on it:
>
> Unresolved MFC entries can be allocated from process context and in this
> case they are charged correctly.

Thanks for pointing that out.
>
> >
> > Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
> > Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks for the review.

Zihan Xi
