Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005840DB29
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764878; cv=pass; b=mNx2jkYcED4fYbqbD5QgjjkDzNvAFkjutH8Oy+4GbTEtWT8dxxGkLN/rKxjuuki+P80SSBP2u9vxhjG7i/Haqqzib9Ns2ckWaqp5yBAmmr1WXlb9rhPpUxRHRv5rsdDQkZ287qlvBQMLpDlvujplELbypKIAqfhzX5+/tEJSOgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764878; c=relaxed/simple;
	bh=Y2ur+9djzyvL32htqpN4jDktQyKA4StfEKcENrbnevU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxgXiIIHSuN4OiZEq8eNNmZvpDOB9/wnUO5YC8M8KEdLTOn5BoYYTS5NOOnnZpmBPovwOdn2Q+emr4YV2HAcYif72WM+J/lCxLqISmn1vVsrM+wpRqEOdTwDGyGrfqJf6RXFCJYHxn/QEDvxOo1XKKtgoX2nyY/NZvup2R4hKLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5WmuwoE; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5WmuwoE"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5307898207dso11929721cf.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788764876; cv=none;
        d=google.com; s=arc-20260327;
        b=Sqht2usE6JJT5x+59bTxOLDIivR5XQNxtFVf0/IbRXRVgK6yKRN67S997trWu+2mRp
         4akrXygHlCjVtVF1u1uxCn7jd6H6r1Rbw0SNJ3c6QE7mci13dS/jHyYjs1DZ0tKl8N8I
         fmvQIycnQlp2OQHgCx9UXTwtA1oWqSzWTNKDL4WJjsbT+Pbb/k7lwumn2IKeRbPFTE1D
         f25BsC4voP2H7yPDJgTqK4XkG4pWet7RXKOrplcBDGD9ZB/3oe13o1uAailtAeAJtDW3
         IJx1gSQe35hp9xUCOll8au61sN4h1f29Morv1sEZvSKLpM+wxpNMBD1F0IZVBgi4Drin
         FaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hqvu5zoZvKKDOuz/BamMJAjw8ii3eTJFwC7iUaWUsFM=;
        fh=+ZIjBXiEm340FOtFoI2hQAl8umQQXYlhNkpafkw7YX0=;
        b=jsPJVtJIS0lI0DZ1PcI/6U2YfJViHmb5M6AiO625yEqvAhJJTlGpp/J59q6P/LVVHy
         ueF61BnY4mbQaxXbBrQkPRZvLk5karbB2xrLmv4sDe0xnsApnjSvLx+N92zM4M2h3Ak5
         hfo0BQNOxcCWyoq5AiPlRn1S2ZGjwlJ7VhwTBkmuhBO4z5tOo+K7egTIPJ/w9sfBX9Ms
         Bwa0axltM1mC7SW/oE6zO+oNYff5RBhUTd12UUcslqCm4/CRbxTGi4ymoMEVatIjd87a
         jUQkAYpT12Vb/qZfnto+ApKXf3I58va/QNiougp34gRj/LB9R3Yj/3rRUefXM1tHuKuC
         Px5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788764876; x=1789369676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hqvu5zoZvKKDOuz/BamMJAjw8ii3eTJFwC7iUaWUsFM=;
        b=T5WmuwoE2Wmkif6ZHlr7z75zgfDcYmcQejKwGE+psT7vyXnOrEs9W5puKXDeat0PNp
         fvicIfeALAW5jAcrtvsAomYPHv35SfUAQlCf7dTKVFkKEwLJoKgUkGgj2/iLsMUNEfBQ
         RuINvu/5htOfsXNvzOKPPOB2ihCv4PFBS3lK2NE2z/SSSUiTqCs0EHA7PEA41Q0moMwU
         Mz5wLGFmBJlZ0SK26WVihBEEkZG3RzoRwjMHB1DyVX/tn/NsiWI9HA7vaocARvMZ1828
         pcTRCLmY9ooj4sYd1gKHcnS3J1BhHZZ2Of/1HoDE5XcfCSXDuuIxeGMpZZ8ma8iLFuRc
         dhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764876; x=1789369676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqvu5zoZvKKDOuz/BamMJAjw8ii3eTJFwC7iUaWUsFM=;
        b=rJhyJupeS1sJClTPPzM3MCsfP5u6owNMErbWMAIXklQ9hBXR7NY/V8BvrHcIAmtNVK
         kqQ0ZpMLUwCuOTycbOUX3EZaO2x+gJmtVzuR/xIKyWkgDenCN2zzL3wiyNkUbHS7sThf
         j4wiEKkAfgTfaNI83Ed4kn2pGZwF3ouy77xgsc0aWGUa3OqxRKeABVSSpEWGQDRhyryl
         S4dVMnenIEO/1ZOeYNcOQ702o6snO/RcSjZHQZHktUCWH5XZN55+N1UWJLTgo5PTU8NO
         9y8WKQx9yZchPrn1kydtdxK/BNqbrD36UZAOVFABZ4CReaOhLJpcINv0Jp5xmyEfoWgp
         VOlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSIO8bkeWCABaGB96nQYVBG85xhA048DgOjyK3LpeSq4skBiaFWubUufuUvmAguVCr7ODb9oM=@vger.kernel.org
X-Gm-Message-State: AFuF++kFMlIKBpmjz6tCAjMRYJacow+6x64GO3JwzyjBa094QlWY2LPa
	zETJFdUHXRAqekVx5Y4iUQn8vsNvSuQy/VURV08YvDhPxGoBoZ9NR0ZL/mudvYDgpY4vz3dR+55
	C3exT3U+Jzu/n8wtlgZh/RuLw1dPjg9mXsqLF+2Ed
X-Gm-Gg: AYBFou0PQUKHbVJXyE1/DEkdy+Ga9lcWYWTEc62IGlVuQa0qZVrJVg7v7eGagF2H5qD
	UT1czzR1pVxJWnuhQh6dbuC5fuwgRPzLortGSnQCha5jU2YKupR+K84Vds0KvKE+PFiyH9jm1bA
	tYNazo6cUfDLXJOzExJmjmVIz8P0EHPGRK9Ne3x9C07uLKSCbTy9aWmwVewAoJby8bGvhTB9Xw5
	UoiCBffHho2a15bUefySILQgDCzpnrMGGSpstQcPVNV7CDf6Qp88AcU560RHH8eW5McdfgnMcG6
	hJW4tXMT9SOqKYzdj89NMeNwUbq7JS9xFzx0F3iDu7CMUsTc3lCzowBseA4BG7W+a88cI7yDDFU
	Shwo1ZOr/GKO4kXNXFfkF6QtcEkuCGnYF2Ni/gCnSh2gf1XYB4z69s7Rckw==
X-Received: by 2002:a05:622a:48e:b0:530:42e4:f280 with SMTP id
 d75a77b69052e-530549f0484mr242761321cf.41.1788764875411; Mon, 07 Sep 2026
 00:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788668475.git.zihanx@nebusec.ai> <e8782427d0b3cd1854ab8d141eea224b53db55b9.1788668475.git.zihanx@nebusec.ai>
In-Reply-To: <e8782427d0b3cd1854ab8d141eea224b53db55b9.1788668475.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:07:43 +0200
X-Gm-Features: AcwNN1V6FVySmL5DFqzL_7zCey1PZNw_Qi_Gx6_T0FzTqcJVGcZG-fCSLd-LjtA
Message-ID: <CANn89iKdX2-a+VhWa4CyDODSZByk=r5VRq38yQhLYBFRQ1Wy3A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] udp: diag: bound bucket lock hold time
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Emelyanov <xemul@parallels.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 12:35=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> udp_diag_dump() currently keeps the UDP hash bucket spinlock held while
> running the request's bytecode filter and filling a netlink response for
> every socket in the bucket.  A large filter and a heavily populated bucke=
t
> can therefore keep bottom halves disabled for an attacker-scaled amount o=
f
> time.
>
> Collect at most SKARR_SZ matching sockets under the bucket lock, taking a
> reference for each socket, then run the filter and fill the response afte=
r
> releasing the lock.  Resume with the existing (slot, s_num) dump state so
> the next batch can skip already-walked sockets.  Leave bytecode filtering
> until after unlock; unlike tcp_diag, a rejecting inet_diag bytecode progr=
am
> is the expensive part of this walk.
>
> Fixes: b6d640c2286d ("udp_diag: Implement the dump-all functionality")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v2:
>   - Drop the hash-list cursor, dump_done callback, extra module
>     reference, and inet_diag core changes.  Dump state is only
>     (slot, s_num), so the existing handler get/put around dump() is
>     enough and udp_diag no longer manages its own module lifetime.
>   - Batch at most SKARR_SZ matching sockets under the bucket lock
>     like tcp_diag, and run bytecode filtering plus netlink fill after
>     unlock.
>   - v1 Link: https://lore.kernel.org/all/133b6aee9e2c908c9da37d5585b3d2cd=
016906cd.1788187473.git.zihanx@nebusec.ai

pw-bot: rejected

Please limit the complexity of filters.

Anywone needing complex filters will implement them in user space.
