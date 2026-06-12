Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4187402BB8
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283859; cv=none; b=aa5LDMIc4QMZ/CpgjoUbV6TAC+nmUB4ubTibR0uTdXt4uDEWLiXhFSPdepP9iy8OarBSNUDN1BiudMHjyjhH0aNy7ZzNxvNgoTQ4l4UkyyU6M5m6Tp4mh9OXJkTs1D1M06PY+QO+bN1ZgjFt+tz5Ve8upQe2HHX1txlGeGzrlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283859; c=relaxed/simple;
	bh=x7JBV1YxVrPj4/1vBdgzqqKO1DpryrChHhSxeL1cbvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=joqdWzyTErKz8bh01PYmn7uWNkpTuowlbQxMx3GrCcuAzFtseW2b3X9ZI7oVlgIezjPgrv2n+5osMVanKuUVruLWXZr6IPjElhXoze3dZy8w97khvVNqt/LEugU6QiYKxpXHzTpYgZ8MfOVfdvKKSdESIwRXwfswcrok1pTr+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0XmpJfB; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0XmpJfB"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-48673dc56a8so1045600b6e.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781283858; x=1781888658; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+CzGFIuAycc3JTH3gFYPgt2Y0prLl/gqutaLhPH2tg=;
        b=h0XmpJfBN3aA8/I9MeOh7mZ22rIraPMCUXRe6Uo+/kmLDnY9rZbBQMd568HZA4h3ZQ
         gsbgQTr1ZOzAtsFlwOoeLGnJWH6s5sVqlCui/ppWHwNXmded1gzYe18b6n1ZkkjrsTay
         +8vWO01kLZCQk4QMFMae6yrQtiLSPg5vMOJ9QItqfoUxtoEMb430ANmT7CWRCtW7czJP
         EnjYHStfTfrmHOUUfMnKsZ9jHlCpUV3QX0DPhbceYjLSztdE4KUjdCSx9tIJdyEagyua
         hDl3djBwg5mRxvlSvSnk2gh+w3RuCKIi7bRW7FlM+BB4ZfoadunexQWEkMy64bKkT2+y
         JX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283858; x=1781888658;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+CzGFIuAycc3JTH3gFYPgt2Y0prLl/gqutaLhPH2tg=;
        b=ROZB7t/Wt3t05cF3nY1DScurqEn5BfFW/B9WB+uVSsmZdsF/MswQmu64KWPo/MfR7f
         u7kAnE8j6oxyuEW15uD445eng94tBHuevbKq4q4+wTliXI9YzKQ6+h6MisWwPCuCEDw2
         qwxxKLmDsrJtX0fDc5qZjRCiBAyLuZq01BCgPej38I3KWhEvWmO59dyJIP81KSPuQGlK
         LPA78Oq7zpZ8tO9LX0GcS5Yb+S05jjGmUrMLsNf3Sv+8Hljg2TJq4nXyJa98rf4nuLKt
         8Hde0ogpEYZBwK9GipHQsu9NwRu+aS5Hu33mqUaG+cSASKeay3nV6E4V/SZ5y+7X9+t+
         5BqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NOvNqkChVn0ietQUMsr5kDso587QxQYdrKlDJRwlAb3Pz/MS9wZAZruKlcxv+osvKJsSeEoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr0asoyHwfcU2OkA5pcvsjrwlUImBAcx/7vZEQa22G9o1a4PfK
	dfYeJqhl0jlFjI21Hef4MI2RvuUBUtoaeLRxw21RvJwJ3bpJ549bnlMu
X-Gm-Gg: Acq92OGZG0Oa9/iq/bsMMU1h4Uw3QUjzWp9ii7hqb4rSpD211gIaeQhJwKmDtWwM8AW
	tnfDuoQjsXbrz5Q6wWBAE1QdMFVPE9A+WDd0Ewz8mplyUSUbPS1Dmr9ZVtlyVA7C7DeXGp9iMi4
	id4b4Akm+j7xhcnAwSJbzAhcMgVbWe4ZtPrqQnX9o3o2Nv3WmjL7V73ka13UaM180XbhuSK1BuY
	DbdRmNG9RVeQy8UlifgZCfUv5Qmnv1YtfgRMV/vsdRZJoxuiQ4wudQUNBFiYYrkHjv7QyGjInfF
	sU4cbH9a2OyBY5z8F5tFhsn1QM63kDVfmn1ury61Q9dH4BJkXb8XEG8KvQ6iYmV85t6LnsWS8at
	ERW6mlMOigJqwqI0TYF1PYJ56WQF6kpBkzr9hn0gJO5GtJllRp4UwXglLI943dnnRJm0Y2BXNEq
	xml2ZCCGI2Fwj3etDVVtrogBh7RutHQDfe1y4NSlXclf4bYzQN3klYQ4wywMs1erg01J18uaZ46
	IWVAleVJjIUDJYMnw==
X-Received: by 2002:a05:6808:c413:b0:486:a606:c6b5 with SMTP id 5614622812f47-4872f50eab1mr2764073b6e.23.1781283857489;
        Fri, 12 Jun 2026 10:04:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:18::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-487313bcf8asm1337937b6e.2.2026.06.12.10.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 10:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 10:04:15 -0700
Message-Id: <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
Cc: "Zhenzhong Wu" <jt26wzz@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <haoluo@google.com>, <jolsa@kernel.org>,
 <menglong8.dong@gmail.com>, <eddyz87@gmail.com>, <stable@vger.kernel.org>,
 <mykolal@fb.com>, <tamird@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shung-Hsi Yu" <shung-hsi.yu@suse.com>
X-Mailer: aerc
References: <20260611160749.391279-1-jt26wzz@gmail.com>
 <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com> <aivZ9jYGw6QRxLQQ@u94a>
In-Reply-To: <aivZ9jYGw6QRxLQQ@u94a>

On Fri Jun 12, 2026 at 3:18 AM PDT, Shung-Hsi Yu wrote:
> On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
>> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
>> > Add a verifier runtime test for a branch pattern where a helper return
>> > value and a related scalar stay live across the same control-flow
>> > sequence. Rust/Aya-generated eBPF can naturally produce this shape whe=
n
>> > a match on a helper status keeps data derived before the helper call
>> > live across the same branches. Such code commonly uses the helper retu=
rn
>> > value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=3D=
 0
>> > branch shape.
> [...]
>> > +SEC("tc")
>> > +__description("helper retval linked scalar pruning")
>> > +__success __retval(0)
>> > +__naked void helper_retval_linked_scalar_pruning(void)
>> > +{
>> > +	asm volatile (
>> > +	"r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
>> > +	"r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
>> > +	"r7 -=3D r5;"
>> > +	"r2 =3D 0;"
>> > +	"r3 =3D r10;"
>> > +	"r3 +=3D -8;"
>> > +	"r4 =3D 1;"
>> > +	"call %[bpf_skb_load_bytes];"
>> > +	"r0 +=3D 1;"
>> > +	"r6 =3D 1;"
>> > +	/* success path keeps r7 independent; failure path links r7 to r0. *=
/
>> > +	"if r0 =3D=3D 1 goto l0_%=3D;"
>>=20
>> this exercises linked registers with BPF_ADD_CONST logic.
>> We already have such tests. Why do we need this one?
>> How is it different?
>
> BPF_ADD_CONST wasn't what was meant to be tested.
>
> The main logic is r7.id =3D=3D r0.id only happens on "if r0 =3D=3D 1 goto=
 l0_%=3D"
> fall through, and does not have such link otherwise. I only check tests
> added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
> sync_linked_regs() precision tracking"), but it doesn't seem like such
> conditional linking was tested.=20
>
> The other rational is that this seem like a common pattern that is
> genereated from Rust-based BPF program.
>
>> > +	/* success path keeps r7 independent; failure path links r7 to r0. *=
/
>> > +	"if r0 =3D=3D 1 goto l0_%=3D;"
>> > +	"r7 =3D r0;"
>          ^^^^^^^ conditional scalar linking

Fine, it's a regular register linking without BPF_ADD_CONST.
Still the question remains. I believe:
"We already have such tests. Why do we need this one? How is it different?"

