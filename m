Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793025128;
	b=O/yBgR85tRbMmTSb5HCHV7c8fp3DPr6DwAHKYmpK+a2ryLCDFLCxt9Uugm1UuJS2+Xfd
	 EDICQHYrlgJQEFQJGt2dfrI20whh/5UE7KE8bjkhkKEZFYL/QbC9FuDMlNzjqR+7PC9Vj
	 QKtbbgOZJ3SxT7Z91laI1oaxb/NATMvEfnNsOhOR2YDF1ofTLR7KzSVdW/qrf3qokejOV
	 Pq4sVmEftI+jxRyii5mJbTjR9zA969/SRT0UqQCgg/vvXwP78UAjddB6IrRQFEHABkvXS
	 o/I25tYqhGXRD5jLEt+bbEFi6YajvMSYKC2JFNe9cDbKI8IqlwaKZ0QZlmc3dv+pUqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
	b=kSNzp2m96PAA6/coK521eVMbhcygoIMw2Hu0Bbuz3SGnag30qiqAgcdOyNacbysmk14V
	 l5x69Z4guGUMLfECpuGTXtuDQFKjr03Fw9aTHfjeOobGMDfnGu0xAeudIQMyPmVZlajzk
	 Jmbk4ynMGFVDEqdi0JB3Ia/KPX7ml2XqufHdpcsNogr2AyAC40rkquZ6/fw79E5Qz9MiN
	 gGTMDWcgeFVRD7stIimu8OpNK/HMIJUun7zPYMEKRAwfAdTamlVP30ZO5XRqhuhPfaJRx
	 0jLX/4tKGP/oDKZLMh0E6I7vQESRRgZFjTuasd5j/903FtOwuOGoP+l4MVqlyyVxUQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvFl2JqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5F606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fvFl2JqY
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd69954c755so2069253a12.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793025127; cv=none;
        d=google.com; s=arc-20260327;
        b=ERIoAutwDoEji+FxEHR6vCUkR/cYcD88jftWRILdfoOkmUEZy1uiB3laVnmlEfC958
         JJMX7K1CsygjqAE9w4HmaFrSiQ8HbszK1ewNuocdpuLSQ/PFT6DMb59ajGLK97eGztjB
         lq2z8GlK1wDEDQzZnYku0ylvDtFO/lDToXcFOIXyQGXoYcAXF+f5wkalFqGEYvwcTAse
         rxJNjBawj+i9WwSxO5DgVLR+3zmCCVIwlrDYuEdzyJelsFtFNQ8o+m+hItapGivL675h
         FI8FphHgQcwOH7usE7A4ZSZl3+7tkGFAyx+3CpdW1GrnlhPcPQbsObfa5ZXQFzLVAaAt
         qj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        fh=WIZ2owM/C5VjmO+tc9aXz7GSH12xtQRuwLyXPagLQss=;
        b=UMjT9ZShGtTYnZ8ssL+6z4ulIvF+j1D+KHlIEGFkyI3WYaAXAbQC6cjMJ2gjiDO8yb
         RrH6Rq3dQAJYaDcULgkxICCsWYlO+t5KyWEVj2VSctk/CcS5nrf+5IeaGhpynvwLAlue
         C25W9+irOSllQzPyvnxuCsf34Ix1Sc8N/n415pQY8xTscT55oSXiOAJ5k3QxTDcPo8yZ
         YCuBPljtPZMl0Q1a/NUKc9mTjDXp7rFjlgwqPn7dB0/vw5HSp/0M2cfaekIV2MWsOoww
         rXeFiPLWl8iKys4yF3Yx8SGf2UOU2c1p68r8G6O1ffe9IHR8ygZYmHIk0u9sab7SxXQC
         dbDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793025127; x=1793629927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        b=fvFl2JqYiK++L9Zn0vfo8qjsAtt8ULXmy4jRMsZWyhMJnRIQKO5Rgi7jeprM6MVIy4
         /gpHjU/ILM64eE/DWyLU9CpYZROq10UOYB88q2H+bNRGWt/4itLRlgb7IHZmz254KEUJ
         uyBnRxmPFfHjF2N0bUVo2B5byPKdjvv7n7yrws+I97JBI3bkCFzeSNxO5vtbSRwE8MiE
         0HiZelCG6u9CtDzypVlb7C/Us/VsX4+woXWZYwOacQWphQIEBAJvEiYJ4K0eVNFK4BwU
         YE9lJnKghkc2gPV7RauLtKpoQWBEQz+XeynSq1pXEe+p1iupFPzxs9UqunTA7XvO5dcC
         ZFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025127; x=1793629927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VMmBhwH3f++U+Fny1silggx8Fp4rLIZ5/kJA7+I6Zec=;
        b=W27EWlIobY5F6XrA6iLVQZmBTtg0ciXo87cJMIz8DxfQNP1Tx0nb4WZPuyF4j9OeJn
         RoC9czXdTelu/1fUA/J/EJISjKoGDQxAc8poQ9/4LyCA+EdlBzJh7naRW2Yvs9c33LuS
         7vfccyVzGilGPL2NGuzyAV/4SCjnAgclHPyjtUMG1wMaJ4bXv52VG0T0t1gcfq31X8SY
         Ty5ENvs7UUio7P2Ptg7C8PstJrEl304jRhIhRcKANtCE201OS/Mlfp5QL03m5Te1Nje2
         1+3iiInU4F6g0SAzoqNvXr76uXctNouOxOTydl9z+o9+8QpYOCaS3c90a2aDj6b0Z0P1
         ajCA==
X-Forwarded-Encrypted: i=1; AKwUvBwIkzHQZFs7zd+EIb2NnGjxTKhsKCSoJe80DKJoUr+vnI31BPWRkPNw5/yQODprBDVW0mftoQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRduUfCk5MdNDx1oq+8drmS5xCwWJxWoLSrACg+xIPDz9d2YEf
	ojUc2hEzhpqtHek+pgOiHak4+EhYc8hW2sBq3EWKYIUOO9DnJSotbIVvqi8P/FNqFdMXrh3CjFn
	Z2ngqLwnA4DbJXCHQnZRLA1Tj5vdYRO4=
X-Gm-Gg: AYBFou0SKrAtjIHbpD5TnXMmqMOOTDG9Rnh+ZZdsCj78K4OHFl5IlYWmJ6JnivJ/PQ4
	t2bC+DiN9cCi2BCa4jsOUbr8wwFJVa3VQ7w9T40+LAt+annX1/YcBVbATVQUSif71JLFWGbZ2y7
	22cYh+VcgcUkiKu/aKerUZzfp2+MuZkz8s6t306qZkBRaKJkW8Ssbvh2lsT6DvfTuuzVW5JwGDe
	X1tZxxV/hbPSrJVsUQGlNPlrdB2UJ5lQ4ksns/2RN2KydrgLyI9DyKmANJw9aVBvylZqo+QC2q0
	atN/jB8MR9bTRhuBLHNsXa/ph8Zun91f4zkUwk9bxbosZUkCT/TOGCbTwVPj9E5IXkqsTtbUNPe
	i1HVyPBzkzMdYbsCoGDkTlYS3KoOhM6882KlIl28=
X-Received: by 2002:a17:90b:5644:b0:3ab:d45c:59da with SMTP id
 98e67ed59e1d1-3adeafd21a8mr5767380a91.40.1793025126904; Mon, 26 Oct 2026
 07:32:06 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer> <20261026142705.4564-1-testwrzwrz@gmail.com>
In-Reply-To: <20261026142705.4564-1-testwrzwrz@gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 26 Oct 2026 16:31:54 +0200
X-Gm-Features: AclHuK89CEpPcFuQ9Zkf80L7rIP62d6arcQxEpIyB7BJW5pfRLgwLFs5gMXbiL8
Message-ID: <CAJ8uoz0XZg8K2g3eBXOajV3TsA-1Sz3D6t-G2+BYw2YX7A4K=Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 16:30, Rongzheng Wang <testwrzwrz@gmail.com> wrote:
>
> Hi Maciej,
>
> Thanks for the review.
>
> Yes. xsk_skb_metadata() is only called for the first descriptor when
> skb is NULL; continuation fragments do not call it. So
> skb->ip_summed == CHECKSUM_PARTIAL means the first fragment requested
> the checksum.
>
> I'll preserve unlikely() around pool->tx_sw_csum like this:
>
>     static int xsk_skb_sw_csum(struct sk_buff *skb,
>                                struct xsk_buff_pool *pool)
>     {
>             if (unlikely(pool->tx_sw_csum &&
>                          skb->ip_summed == CHECKSUM_PARTIAL))
>                     return skb_checksum_help(skb);
>
>             return 0;
>     }
>
> For the drop path: xsk_drop_skb() increments tx_invalid_descs and
> consumes the skb; sendto() returns the error from skb_checksum_help().
> Since the descriptors are already consumed, retrying is not useful. The
> current metadata validation makes the malformed-packet path effectively
> unreachable, so this is a defensive drop.
>
> I verified the propagation in a local QEMU test kernel. For the test
> only, I temporarily changed xsk_skb_sw_csum() to:
>
>     static int xsk_skb_sw_csum(struct sk_buff *skb,
>                                struct xsk_buff_pool *pool)
>     {
>             if (unlikely(pool->tx_sw_csum &&
>                          skb->ip_summed == CHECKSUM_PARTIAL))
>                     return -EINVAL;
>
>             return 0;
>     }
>
> and ran test_xdp_metadata. It failed at the first generate_packet()
> sendto:
>
>     generate_packet:FAIL:sendto unexpected sendto: actual -1 < expected 0
>     Summary: 0/0 PASSED, 0 SKIPPED, 1/0 FAILED
>     TEST_RC=1
>
> The normal kernel still passes. The test harness does not print errno,
> so I can only state that sendto() returned -1; the injected error was
> -EINVAL. I restored the source after the test.
>
> Magnus suggested a distinct counter for malformed packets. I agree that
> would be more precise than tx_invalid_descs, but I'd prefer to do that
> in a separate patch instead of extending the UAPI in this stable fix.

Correct. If we decide to do anything like that, it should be a
separate patch for net-next at some later point in time.

Thanks: Magnus

> I'll address the remaining feedback and send v3 as a new thread.
>
> Thanks,
> Rongzheng
>
