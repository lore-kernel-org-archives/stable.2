Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73641443B
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494634; cv=pass; b=DSV6Lq0pQmujefi2LBQjmkMnFLWGywbheOynrDD5V6URlMhEWXZ3WKu3IvUEKPPLbXyyOP54msh1YhIC9vpNKifQawcreR2zvvAUeY6VG8L2OXLyrYJ7DsKH1Mb9yigkJMin2sownbkNdpMF9XOWrADvBn/3ZGxjB/lvHoGl8Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494634; c=relaxed/simple;
	bh=M6CM2xvKkSIlGXfDQ5IHgePPERx3aiPmGN8gZP5u0+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GF24L56eUQ2n24p7dU4mj22Lq3Ummi9r09L0oUB8fQuF8Vr0iZ2QLx4Hb+gIn0k8MqC1WpQzfBOYEawb0ZakDMkwBozsxx+89yrl4owz+6BOupE0A4jzUl43g6N55+9nhXLmxBlw1T2kMnbgrkujJ9nQCIBc1DqPbDcRiwEr5cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg6zPswR; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg6zPswR"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a771ad2a9aso8822751fa.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 14:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791494631; cv=none;
        d=google.com; s=arc-20260327;
        b=seHSLc44axPE/vmwhsj4xx7LzmSpXKJIo6nNeq3zGQ9Vd0Ovv8AIqLgkXheSc3DUKm
         Q27uez31GoAGK1PrR7cVvOj3CVfYgsfD4dfHR7vU3Wetc+iv7K0O1kXxG+MN61OiGHeA
         jEG2c1oDNfXI74a7Um+Km17Jz4v8XecEmG5LAWA1Msr6wFAQEueo4nfT3kLPH7cBr8Vc
         UqCjWf8ALX0UbpA66cBjlSNNmGH6qTqKs/DjfkzviCvTrab14K21kFv9t543EIl4h4Kf
         H3Rp5hn93iivBvtKyTkl2kiQHsPL1yj2+CNB1FLNhppT3lfx7b4PGMB87AF2qPZUk4o8
         oqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M6CM2xvKkSIlGXfDQ5IHgePPERx3aiPmGN8gZP5u0+8=;
        fh=lH8UMGpTthoX8KcDGgK/JeR874V+dKFAV2JZ97gqrJc=;
        b=oilsI6ahVWIMlc98YiWJSeDj1pndlFWrUvlWT0m+GoOi6DjHJmSygJch3TB5CT8n/o
         H48nl1HeQeocDD+QEWg16Db42fp+XEFMHKzv9ZAPnWBelOpb+SqZNhAoaLYjEyECO6l4
         oLmzio4LmOUX/pWCxhe6aMYM7dLwiuYN6U8l+z0WXyykmEZalI87w1JitLJJXsH1Phm3
         En2J4qy0uqvDtemZ/L9WgSbfQDJcfhgY3AU1nkfUIMTn4duqnbct7eSfsguxuCepXlJi
         EpxiQgsjk3q0vHeuyGNkW2CfhdJjHbsg89guGZEpph2+BXzOyNc6NYrNqrysEzPXmIGt
         YAXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791494631; x=1792099431; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M6CM2xvKkSIlGXfDQ5IHgePPERx3aiPmGN8gZP5u0+8=;
        b=Jg6zPswRk7LD3wZsJhgpW4eZOLFNFHVaJC9q7DLrP9cMsnLVynY0AiMQxOQAD/Hxzj
         gDp/NMiDTeAg2ce+GZTMcrD1HYArtanEzTdOMPe5gkSg7DzIbC3NmgwvIBx94LVeH3Mb
         qwDe9BM+GUthz2PW3BQVHce7VLFdfyanxMMoefDY05qu1KDfVXztfn5tZDpaRfvWeDVJ
         BvzfRKNb4aDEDtMD4sVPj7TXhj/nZhbA9irxlhrSiMOT1AvWG254rI5D02wdpn2IWGq8
         kC0ykcXH+0+K2Mco6XCYw9YPcL6u/K/B5UTyffxvCtTKq9/ndIvaVkcqzb1l6pRrzJfs
         IbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494631; x=1792099431;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M6CM2xvKkSIlGXfDQ5IHgePPERx3aiPmGN8gZP5u0+8=;
        b=mVIvQz+U9aY0ZeRE7s85wJPznBPPflN9GDljauOakQCme5yU9ItNqSXaYrcwI022ir
         h7TSwHdD9yrziYiuJ/5PhpQIIKN5dl0mF4+9hoYxDBnot1GLcbXZtTlPi0RQ5wrGmCAu
         caz30DykWPdmQoAyoI2WrNMYY7t0dchjpafBNsL5eZjthqXzipl4OMKszm7PmUdZ70aW
         YhieXL5yoMmPb1qvX0IUZCTWm1Ufb2cxuLdtpNyOYN30Ztq8WDOLV0uya76ZjVGB0AIC
         mX577BPN6VMERkEHv5+vAwmBj3EbHIVI3JH+EZET3tl5OlA3f7Z0HuE11o32GGKbyQKm
         WVpw==
X-Forwarded-Encrypted: i=1; AKwUvBw7oj8aayE/n9EWH/bFYV547SqNq1xUFvitV2W6bY3rdWdAGxhhqF66bZIAiWw/pyeRRregOL8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZjXx3EfXHRrhendh1ShxEoT+fKvG1jJhFrPyF0G+8wSt806h/
	pTI99/SNjXWnyG8bq/lFJalT5pISh//ZZ4kkm2ymA/pZoubOoWempYjt5kSHBzV4ffMLZWTry/D
	oc9TaOHHlEOK//bZFK+EPVnEiZ2JsOnCNugdbMbM=
X-Gm-Gg: AYBFou0yEnM+p7ZzH043SsEN0BZp/uu3NdmCaxgfChNuRcn9jSa82oG3zM6UjRQCMvA
	fnRgfyKwTS8KuOzXvw4QSmoZ7ZHTvK9rkPpRARrtDs5/w9C2Cv6fUhzCRnuOJYK0TDecPPUFj5u
	Ip8LbIARRGxIZ+nE8NRHR8sNbWojsxo+fo4kqy7lavj81J39HypETkZBQ94ySUtCN3j0BROa4c9
	7uELKFMH4kcZztND4+MMf+67oAi3w/e1RKQhVWjzMn9zVQb3VVBWVXW8YEzg54Z6rtKdhlc2wKx
	K7h/lDqfLKJURl/wP274QcAMIo8BqHhhUJmknnyEvEJy1BLKrMW1/doKBrjLpkbeHgjI/PJa9qE
	imLwOi3WgBr7Mmwc=
X-Received: by 2002:a05:651c:542:b0:3a6:5b56:8106 with SMTP id
 38308e7fff4ca-3a9c2c3095fmr906041fa.22.1791494630493; Thu, 08 Oct 2026
 14:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008195608.965266-1-linmag7@gmail.com> <20261008195608.965266-4-linmag7@gmail.com>
In-Reply-To: <20261008195608.965266-4-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 17:23:38 -0400
X-Gm-Features: AclHuK89eYiVBvE5Lrwb__hHWrXIWel0f50BxkAl9nePVtCBE9ELUZ7tgaAtMas
Message-ID: <CAEdQ38GMc=aH6yQpSGFvXpNZSmvrU7uzKqDN+T2W8GfqDchQMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] alpha: do not skip TLB shootdown IPIs for
 kthread-borrowed mms
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 08, 2026 at 09:55:18PM +0200, Magnus Lindholm wrote:
> A
> CPU that does have the mm active keeps its slot, and that is the CPU the
> IPI is there for.

That includes a CPU that only holds the mm lazily, idle since the task
migrated away. ipi_flush_tlb_mm() and ipi_flush_icache_page() test
active_mm, so it takes flush_tlb_current() and publishes a new ASN
every time. It stays visible, and each flush_tlb_mm() from the
single-threaded owner sends IPIs again until that CPU runs some other
user task. munmap(), mprotect(), fork() and exit all go through there.

Testing current->mm in those two handlers, as ipi_flush_tlb_page() now
does, would send the lazy CPU to flush_tlb_other() instead. I have not
measured this.

> A CPU that publishes a context is in turn ordered before it goes on to
> access the mm, by two different barriers:

check_mmu_context() is a third publisher. Its __load_new_mm_context()
takes a slot from zero to nonzero after finish_lock_switch() has
dropped the rq lock, and nothing orders that store before the return
to user space. An smp_mb() after the WRITE_ONCE() in
__load_new_mm_context() would cover every caller.

> So a CPU either already holds a
> context and is seen here, or it allocates a fresh one before going on to
> use the mm, and a fresh ASN carries nothing over from the previous
> context.

There is one way for a CPU to run the mm with its slot at zero. When
ev5_switch_mm() allocates a new context it does not set need_new_asn.
With the stale-TLB series, finish_task_switch() enables interrupts
before check_mmu_context() runs. An IPI for the mm taken there sees
asn_locked() and calls flush_tlb_other(), which zeroes the slot.
check_mmu_context() then finds need_new_asn clear and does not reload,
and the task returns to user space on a live ASN that
mm_context_elsewhere() cannot see.

Setting need_new_asn in both branches of ev5_switch_mm() closes it,
since check_mmu_context() only reloads when the slot is zero.
