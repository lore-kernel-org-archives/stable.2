Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795262283;
	b=lS7GE8mKGvrM3OK74TFY2id0AFoGHjYvqrUMbJKP+HzHxGgZ82DTzvpUP9eRtt6l8O+h
	 DLCtxvaxedoxfdBm3tppHiVBesgOTvV1au0Ay/YNUFEfAPiRRtLLWlULzBETKfNH3aYgB
	 cHfMt4xf3OdxJnr9xEPyRL2eE2NiRAc7cR3t/oF48rP5EG5dPsHq0043aVEM1TFaot5nT
	 RYjP0+D+anohuu3S7HGA9QturXQ0Kv0PCmtFBTfYcbqjLQ3fyTM13mDakM1eexlVfUKh2
	 SidrxbroS2az3Aga3FeDSjTIoHdirs6MbtrE8u6YUYYFPD1ybzyK8p1DT/q+1LrrLIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
	b=DoB5QeZe7QSnTI30/jEsReL/dDkZIxyhp17gjY3VMbgbC78LAm81kqMPiDlSgzt/SWCq
	 l54o55lunMAGV2tiSxA3rjDWyO1mRHhOc2YxL5garvMcKR6oUBS3enUAWQhWvmtzJXijO
	 +R03qqtuo2lKupg9j9LZcmOkZMFT1msmtCxLJ8DrdaVjihK6d6WG+nLQ84MO1XplMi1c+
	 lIYrH9G10dXsgaaHER/8rB/LYXxV6n9HiVOYQMLM3aVLGaddGKM+PH7rHgs8x/Ue4p/Zq
	 T98EHma9botMT0UBhDwNKy6UoqDPu1qBvQ7NrTtsHbuqvk44gNQZW1KwvbzI7pKqe0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tGuwzQ0L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE8606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 11:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6BE8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tGuwzQ0L
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so834168b3a.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 03:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795262282; cv=none;
        d=google.com; s=arc-20260327;
        b=S81Xq5UpbDqBVIBMOoNyqe39PXPdTqlXp9hcyI6RaAyQL7JYyk7Y/mpiwQnl3ut9sW
         NILJIYdB88OZhQEvwJitUB+gEUtBfEW3si6fl/0WwTkt+LtxSPTSqSEY0Et44V9T1v+e
         a4ynih/+RKPZvG8X/g7MfJOcUb1aPLh82IT9aM+fOajVGgTAu54joE5KxD6LKffOrv8K
         8RiBjGd1s5k2H/Bl2mhShh6AV0zjKG1KWhzDa26zvYmTblV5Jji/GqcrE7jabf7kGpGa
         PR6iMJdh/Ba30GrbqfigJ9DKaicnv4iQ5XAt53Mj4mdQJGNlpnWJcZDkygQJns9NDLbM
         nKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
        fh=nDhsM0r3lgy22cYMcV2//8vPxs0udG9wgzhyu5YSvoY=;
        b=fYZrq1zMzdKLLRJ8ubaveu9n3keN8n/p4YEzLoUULzMUFm1yToO3p4V0nzq/UuEMKT
         V8K64YF9I8uUvndtDAo8zhQjIulsR5VpqKtBkDFYxXSSh3HkMbbkpYiQ861+nDe5/jpl
         e8kYB3eTMqoVcz5C+zfAO3zhRcCA1yqtX2VrYF8dAeg5mR0+gw4lo4Iqd7c61QUTKp+Q
         jM3vU+6T1zWtQIugB0C6HLnKgvi/8u7/o2sW7FDTUa+lhQ6dmhyqRbh9J4KlR2XEzHOS
         7/YZfdJMcUtoB1rCFw9/sTjWLba1yGfgQQ+23EjIyMJZPYQEEZ9pUFF4CaJqsCj3w5Q4
         diPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795262282; x=1795867082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
        b=tGuwzQ0LPZl1oA7DlU0y5cfAR3if15FhKZcT67HBYIgCFujoCtXIBXnTWc0K/OKoXI
         dxTHlJwRNwT0H8wTkjnUo6QjsV8k8Ue9qN9DTfnhxHLbt1R4+4lVCyqkpok0V0/zl+h4
         QKkDsPstBbd8/Fw50OiiRtymEzae8Ti4Cw50Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262282; x=1795867082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oeoFimhtJH2hxh44JdtBw3TK3noQY8/rbKIHHAErn4=;
        b=diNEuBYZTNtOPYrqMzcN2xfDmLYfZs7sLN6JCjiT4Q42H7dCyImdfR/e+3ok9NvWi9
         2N10CFYBNellcapvL+DUxTDajahbQ2EHfQW3Dc6U5S461TXc95oQHEHrLhyLfIv5Rt4u
         KtK4XrMNVrnXjOBc1SmPtz8uXHjHKaImkvPQHGfD40+iIIl9msfzuZ4Dqo5+X0Jf44F6
         JrkHpBPoypN0cZf0QUz7Z/Jr+jhfd60aIBcsKUfu8xDTdMZ41cSm1ZurcxkjCQI3xcwe
         ZVEJbMwsDmrfKPR4WM3zzovMHITyN5fYJArxZQbqAUuJx+/wakNSQrV09qS7ZpGST8+x
         Mh1Q==
X-Forwarded-Encrypted: i=1; AL+hErHNlIOcUNmpPpUsU2IGlJBF892YvqD9xCoILMndMoD5yieWi6NGYxQL/Awr7RjFn+hvQtN1n4s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8biF6e+h1ZxezpUHfngqMTLdshmDIP6ABmaj8HyUwFwD3Ehe4Y
	xL9wyiaLt5Qy1XC14au7PAZDg2xdxLbYzSaL+BaRD4mSe1f0phMvcOFuDOJ5y+4N8X1bdJONHLD
	5aPQz7s/Sar0mZu97LDSomlZjH+OdNF/B+zrKA9sY
X-Gm-Gg: AZFdTZegbHmB02CHAThveBXA/YNgTcjKUC1aiHH1TsAgmE/53I3EiUZRCF1K8YTqRY8
	mIitIKL0rwEvmEBry+I7Q5MkXiGCOP13EiWro50zUXLbVM4u+JC020RF8Lz3pvYxNVQrRKJBPeV
	XpRLeF8mQil3sLEhhYSyZnw10QpzlrO5X1W0cTlyX/fI6j/SPe6yG2rP9cBjgNYZALtEieBHoAQ
	keCzs4KVlqzohK7zHWHLA+He6NmxGcR1jerVfTQwLjMsA0m7bgiFlKQ1ECXdKwuThzNQc4HS0HS
	PjqILB+0suBafJsl7BLW2qMwM4+C9gAA6Dqr5ZNrwWbO3XqbdYdiJZdWmuIDjAK0INvWqiUS0mc
	RhA8AkY9XQ4vnP43OzL1GJUKoC+LT7zHe/GowPsyyq0ZK9yOve3Nxlgl0WEQgnhKoRBYMN4m4kQ
	mpqcaG/zjSXWoFBpy4ky/C
X-Received: by 2002:a05:6a00:928c:b0:8a0:20e0:b131 with SMTP id
 d2e1a72fcca58-8c87bac50eamr5921526b3a.19.1795262282219; Sat, 21 Nov 2026
 03:58:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com> <DN09YRKU82D1.1QHV2CIFW2C6H@gmail.com>
In-Reply-To: <DN09YRKU82D1.1QHV2CIFW2C6H@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 21 Nov 2026 06:57:50 -0500
X-Gm-Features: Aa3M54qnMKfTBVbIV7vSbL5S723ov1v1Vl5x3Mva5Jl0ckcThjBjDhbh4ZxcYw0
Message-ID: <CAM0EoM=Panth86S2_RcG6Pt8WA-nyR=1P7GDM0sPsPrOrwjyeQ@mail.gmail.com>
Subject: Re: [PATCH net] net: xfrm: interface: restore dst_orig on every xfrm interface
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eyal Birger <eyal.birger@gmail.com>, ipsec@lists.linux.dev, bpf@vger.kernel.org, 
	stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:11=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 20, 2026 at 06:08 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > with skb_dst_drop() before the route is installed. The helper allocates=
 a
> > metadata dst per skb instead of a per-cpu one, so the route it records
> > belongs to that skb and is released with it; the per-cpu allocation is =
no
> > longer used and goes away.
>
> kmalloc per packet should be ok here. xfrm_bundle_create() allocates a ds=
t
> per packet already.
> It also fixes the route leak, the double put and the if_id mixup
> that Hanxiang reported on Oct 29.
>

I wasnt aware of Hanxiang report - so i went looking. If no issues
found the final merge will catch what you prescribed below. I am going
to track Hanxiang's bpf_skb_set_tunnel_key() note as a
separate/followup net-next item unless somebody else wants it (in
which case i will remove it from my list)

cheers,
jamal
> Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/48129353.1960c.1a1859496bc.Coremail.x=
uhx@hust.edu.cn/
> Acked-by: Alexei Starovoitov <ast@kernel.org>
