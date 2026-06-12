Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2816D37756E
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259533; cv=none; b=SLOeH3BOIYYjpUZiZs07hCFXujmjUV7HdLXZoM40clfbHfjF5gT+EWC742tulJwWL34unlGmxWMU6cmdUCX+tb25keDpS2sEFHSzvES4WZGieZOor8brymyCUKqj1yYAZkS32Wqy4rayYTqV/kl+oP03CqUSQVhUUSVO++0wKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259533; c=relaxed/simple;
	bh=Iu+WsPA3d5zC/vpm66sf0PXFm63IcdCvAGgoL0vzIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiwB5xuKSX5v9NXOPRz3ezuQBmVOv81h/gP2K1heFdXIm3Pf7trS3RM65IvugnaYCAEYx1q2raPjnlQTvdAJl6GB5jXPdpMT+hFrbCWlBEj+FnfzzUeshTrl6Z6p1H9o+e0xz3ZBs80Z89CWBsl/osrtrsPS6k3CVk2PdJ1QCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bBME3aOj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bBME3aOj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so9319215e9.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781259530; x=1781864330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZYS51t2QXr2ZWiJCJ2esfR2JgSuWZes3mVwU5icUks=;
        b=bBME3aOjy09Ne3TOuJciwQgMQrD3QA56oZBnha0V1aiAml8vZFjlLytwRDLcbAjTfK
         gs0paoiXwr+SoduVvkIUms0MRhDY4psKxnYztyMXaCgHdKmYEU1TrRrQrbGmf78LFKLy
         Nb7MwXBQq6cZ5ahJc1jkRoGezwCEYiQdNVic+lM3Sq67OQ6+JDEzb5aqGGVaMTwwdG8l
         Y1dVVIssm8yet7XPKGHJgxwSWw7e8nfefziTDbuAI1WXNifv4/FxN7bnwKl7QZznlsK+
         /L52yU+EIT8vhOhbInFxE4932yW9o6b9QOztuVi07hqQf1r1TUk1zeLIEwTU7TKGdYaS
         IVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781259530; x=1781864330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZYS51t2QXr2ZWiJCJ2esfR2JgSuWZes3mVwU5icUks=;
        b=bmj6/lSjj/1sjdij1Z6uk9ITGbqmIUWtRxsWsIFoYRpfw3ARSXgTaZqhvKx2NNJWWi
         WL6WqFJ8BbBCQCJnEHYXukL+HUuqWN2IKCKa1Duz/7H9iGitm3F+5ZzHy41YeAhYr9dP
         H1CffSaFZJlowJ6oi37doprRhg/Vk7hussHtVs1tSnJP2ZWSRFPTJJlQWKmvHs1e6mAZ
         VJoszgASOL7H5Bh/ncztEiFvbDKVDQfPKEnM9ZRVVUWchNC/POitLuVtFh0yRiUdkA14
         xEy+aQnZQcbHmXnOwPEuOsGUPdChm6n7noSICPVObr/4AJH0Ahm51i5BJUz4Qs301baZ
         x6EA==
X-Forwarded-Encrypted: i=1; AFNElJ+7PDmQ8/E1NrQqLvc8bCOGdwseX3SaxWSAEhPzGDnoUulH+5fk2K8OmeSTeuu6kDaQSZkQSL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUw0T0shuc58A8MCMGFrd0ZEJWoNVQTU4SO3hH71gcddOCJsB
	iLthwazs5psXwStZXO894zx5oSH+ClrqELsi0KRMhD7bobgM1LCg8L/QNS9CgxxJWd4=
X-Gm-Gg: Acq92OHEBk2njsjDabrUkYzVJGRjUtLUeQbB8tC4m25aUhRkehtPeLSHou2LsWSJAJ3
	9NrIEfp9C1HNyXm8T5wPH4INw5+cVLa3lhF9MAc0QjKtVgsG6vm+7RDAmKk0liIpxY9y0rDDlBQ
	xUQkmhfOuuW2utL466cCZ4rp7x+JFRpBRuYEJesZRxSI9BAuXhp/84rRj6+m9GAJECgLNvkzWUR
	SNIsKmjEy0V2q9eTuKQHQc9tHRg+5e38eJIBAiMl5luFF1zad9JcS0NCT8g0/wxfI0wZQR3EoTS
	/g/n8HlxZoGsTKf4cXVWsJDgfI2NaKCp0n+cNSISLPXo/PTE3HdxLFxa23cmPGNxMORwbwzZklg
	rcc3qJfg9aobVMu6Lcoc6rjna+UVuZwl+a2xV7UpIfHBNbVq75oedi2adDuB1UVo1HI67x4QmUS
	/o4X88s8Upfbsr0UJ+oaFL/aal8u4/c9ioyTcWSZXs
X-Received: by 2002:a05:600c:5493:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-490ec4f26ecmr26968165e9.19.1781259530302;
        Fri, 12 Jun 2026 03:18:50 -0700 (PDT)
Received: from u94a (27-51-56-85.adsl.fetnet.net. [27.51.56.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95342sm2857806eec.29.2026.06.12.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:18:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:18:39 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zhenzhong Wu <jt26wzz@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, eddyz87@gmail.com, 
	stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
Message-ID: <aivZ9jYGw6QRxLQQ@u94a>
References: <20260611160749.391279-1-jt26wzz@gmail.com>
 <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>

On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> > Add a verifier runtime test for a branch pattern where a helper return
> > value and a related scalar stay live across the same control-flow
> > sequence. Rust/Aya-generated eBPF can naturally produce this shape when
> > a match on a helper status keeps data derived before the helper call
> > live across the same branches. Such code commonly uses the helper return
> > value in r0, where 0 means success, producing an r0 == 0 / r0 != 0
> > branch shape.
[...]
> > +SEC("tc")
> > +__description("helper retval linked scalar pruning")
> > +__success __retval(0)
> > +__naked void helper_retval_linked_scalar_pruning(void)
> > +{
> > +	asm volatile (
> > +	"r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
> > +	"r5 = *(u32 *)(r1 + %[__sk_buff_data]);"
> > +	"r7 -= r5;"
> > +	"r2 = 0;"
> > +	"r3 = r10;"
> > +	"r3 += -8;"
> > +	"r4 = 1;"
> > +	"call %[bpf_skb_load_bytes];"
> > +	"r0 += 1;"
> > +	"r6 = 1;"
> > +	/* success path keeps r7 independent; failure path links r7 to r0. */
> > +	"if r0 == 1 goto l0_%=;"
> 
> this exercises linked registers with BPF_ADD_CONST logic.
> We already have such tests. Why do we need this one?
> How is it different?

BPF_ADD_CONST wasn't what was meant to be tested.

The main logic is r7.id == r0.id only happens on "if r0 == 1 goto l0_%="
fall through, and does not have such link otherwise. I only check tests
added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
sync_linked_regs() precision tracking"), but it doesn't seem like such
conditional linking was tested. 

The other rational is that this seem like a common pattern that is
genereated from Rust-based BPF program.

> > +	/* success path keeps r7 independent; failure path links r7 to r0. */
> > +	"if r0 == 1 goto l0_%=;"
> > +	"r7 = r0;"
         ^^^^^^^ conditional scalar linking

> > +"l0_%=: if r0 != 1 goto l1_%=;"
> > +	"r7 <<= 32;"
> > +	"r7 >>= 32;"
> > +	"if r7 != %[test_data_len] goto l1_%=;"
> > +	"r0 = 0;"
> > +	"exit;"
> > +"l1_%=: r0 = r6;"
> > +	"exit;"
> > +	:
> > +	: __imm(bpf_skb_load_bytes),
> > +	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
> > +	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
> > +	  __imm_const(test_data_len, TEST_DATA_LEN)
> > +	: __clobber_all);
> > +}
[...]
