Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430881;
	b=WbcSg3D04iY4+N5k0n4xdSLWBLB33izqdKLV7Vp+SsutiZ89+NjrpFYaxVhYvRlD8IZb
	 ZpXobOMJnnqxSCaNancCVnohicrqUk7ITJvxju/cUWJ2Qjtc9K/TWO+k6j3lAt8Lu4Wl1
	 mDPZeYGOgYc8uIEnZQIFt2iUlSwY5KwSfneKiRTIXWKSxNAbZqT+vdLV5KSsnYreH/fh6
	 ywdjrW6TIn7UZJjCKnaMR7gdHr22DMp4CH4NORE8MEXnCX3cKbjClZd+AOwalC9uN/Vyn
	 bF0Q5kp8ZUhcMdK7xsP2iyM7KBn8IacMsqd/Cv3xXTVOao6al/Xk2Cq8Su4+Kh6YaHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
	b=ElJ/ZpmeCaHtm9A9veL8DxquP3WWaHQTAkv5m5v0ec7z9v2V54CThnvrRyEQJGoujhiF
	 hQmA3t7nT8r2+Pm5sMXkvHqE5oUQal409DGIANlbJCx9EkLtDKDA79v3S2iDqa26oO0Yo
	 5IJkuB2vLHE0BQH/HZRK1T3z7UhhYHQbmg+3ckl/8U3tgeHEuXzWSbO6lia7UscmK1m0V
	 bLU3aMarSQ0/Yvevz8OVgDVS7mkeIHg65mHzzw7l8n99JcatgREePBv6N0kFx44Tez29C
	 KKIhbh2uiYYdCH2Im+vTbpJ1eRuP92HNNSkXsKQm/VedSpJ7O+a/Xc03gTrkmivU9Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EzvkQHYQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DC606A331
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C49DC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=EzvkQHYQ
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c5126505cb3so394786666b.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 02:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795430879; cv=none;
        d=google.com; s=arc-20260327;
        b=Gh1ws7m2E+PbMAad4G7j5+PMeXo8QbaE8VgauPGtNwVW0lwG70xFEO8rZ48SjVfmun
         xuqeOcWdZzL1nONu7HHESP9SWpv2yH2F4slxPKAaUOxfJQrjoLZ5i5BkENOYwkQYRU1c
         hTKOzufkJ6wAsei9Y7E4mqObl/8nGnfYqtv2kZCPRpDJ+2akBM9uUr+RdT0JLj/FKpOy
         7eGIMQw/8hUua3cAVRSdxnhxdhbbjVbatVzmyrigyIJTMzxXh0aLhchpm+m9M5jpDXyJ
         EyvSFwy4y85fYzF2JwL3DCbPx0xLqZEq8lf4LUoGgnvWbrVL/svPWy9PhuLOi80SR4yM
         mgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
        fh=4PbhyjMK7E4cfKExrSYTKwiTSs4MKePNN+aS2XPLuOI=;
        b=JMsXTVaJ001bfr3eujFN7oYRaiX/ZAwApvN9xYRhJttKwZwDVV+gQmvvSoJQiSzCA7
         7aKubSBlMyEbvW6miSSbGiBeTYHQ0GsTGNvia89idAZe1RD6xBzgJ3f4Uq7Z3EWKVtYF
         7BWk1WkZIH+27ZN1kq36TrUUCnM/gjWWUKYdDNKHQvjv80ukHAeVihM2Ev/trMunT9eg
         tkF6dEVW5wtEbE5uV6l2WRz8SjHnYII5CEsTWUdd9inUwBA7ryU5x1TYxyhGTNvBuJZl
         rYEFTt3Ja5CiqtJhukZUdLI599BIMTsdZktzRVnSd2XapFk3uVuvpDsEbjTlkJrApXhg
         wxIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795430879; x=1796035679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
        b=EzvkQHYQol/Cq4j4qvyk4vT5eoqfh3xOMREdIutC7U43kJ7WlRjGjF1QiKiIeZJhhT
         64/scM0R5jqI4nP3Cl7VAamQcExdSP4wQZWh+dmW2P/DvguXnTf+dVwIhv6KUwoyuYDv
         hpDsMHO1YE7d7nmO5Z/5Wy7oLFz9SAwph9v0R49R+NWbwEzOp8qWwZLPgXOxijnOg4Om
         Pzawc3hy7N+Qzj5xWP1ar97rK9hEBX8dCLPDYqP/gFaUiFVS4LqiH5c1Eair1rnX4pBs
         XJJdXJJetOW9jxQ/fGnl7WiQGdZKrvqKFqzQpnbCEHv3DLTiQrdJvARCD6DRK88dZHt3
         3Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430879; x=1796035679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvoT7Anl9hphNmVfzcXuCYVLME3jPhO7743SpeB5e/o=;
        b=MrEScD8jv1OKp+jt8ly5+q+s1wi4pMcWN4/PHpH31qDj14OmRSLJryxuOWtZe17u03
         w01RUa1gIHmgXtPmtBweuRpoPx51LVK3tEYQoKuUhzboAwR8rZud9illw8jOuV5sM4uu
         PZfSh2j4H4vE9nCtH2SdpCT0knFZvnsiMLqVd69Xs/eZsoHi9tO0ZWrTnH438i97JdWp
         1zfIgcMJ2x7mFAArOoR9pCDrKegDi0KydK739mmcdGQBLoeP+aoTKECs64xiL3lYwmdk
         p9FdkGwBE/XlZ1wafWoQfJhWjdEuOLpJocjSXmb7QhTFMo41QW6yyV2NG4C9royqLp+O
         e7cA==
X-Forwarded-Encrypted: i=1; AL+hErENR1gmVbMHTz85LEBRnaefKPBiPzb3Qpq3xzDGuFsyw2IWy8doX6P4xLqNafe6GKi5mBYo390=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cL8akWa8kIT7uxaycTB8nBVG4DiVdSFYoqbKaxme3ZZLVUFpJ
	pMWnU8ze7vUcF5WNAi43ZMyrhN5ZjD+2XoUJAKQ+QHVgY7foo3SGDbATu8QChiblzjtN02aLV1w
	o5ivef9xp1xAZyGJ82r3ycuY6dl4wBImeOXDzLukbYQ==
X-Gm-Gg: AZFdTZdwlFPF9NnWpGkDPeCDvnNCfSAAeUV+w25UcIsEmHKka1hPA/bk06fB4EQGW4W
	4KBGPJUrnH2SMnmIjS3U2AN+6IsWpGVZJP4hKjIjEpIEg85ewYbA5ghDu2G0iY6W0C/oy1AJbOK
	6shQSEe4/1Bvu9xFnLkLG+r2CjPP50hHIpULiixi0+GAs7SQ92RZL5bsOGT57Ss2fwuu51USYj7
	UEVwHxaZDCYx0xpSw4HrE9xpzCCsqAb0zM1LrjB9Iyzg2zVwFEqXYbB+/3AYyIlYCxF5dsZyC0T
	0wPqeoaypigBYTD9TwIjgpiXbr067hC5M/huE2GASFJ+FGj2x2VZ2OZasBRAKicu9RsThwD45je
	o3tF36Ga27Zwh/f3zvBM9OObJvRWSySipMZiBkgUE8r6kjfiwJXhX3suG1bMOIQ2P+pQvbQ==
X-Received: by 2002:a17:906:1304:b0:c4d:212a:192a with SMTP id
 a640c23a62f3a-c513acaff9fmr662453266b.48.1795430879222; Mon, 23 Nov 2026
 02:47:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121235203.811792-1-atomlin@atomlin.com>
In-Reply-To: <20261121235203.811792-1-atomlin@atomlin.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 23 Nov 2026 11:47:47 +0100
X-Gm-Features: Aa3M54oo137bS41nML-swPW4_-JFZpCl2eqix2NZRtkklgargqyy1BBEeTkW998
Message-ID: <CAAofZF5D+ycbtMxsnUgZjhUbfD+_ZD6kYyci95OTdXug_aw-dQ@mail.gmail.com>
Subject: Re: [PATCH v5] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	emilne@redhat.com, frederic@kernel.org, tj@kernel.org, sean@ashe.io, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Sun, Nov 22, 2026 at 12:52=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com>=
 wrote:
>
> [...] In real-time environments, an active SCHED_FIFO workload will
> starve this SCHED_NORMAL worker and stall hardware dispatch, whilst also
> introducing unwanted latency jitter on nohz_full cores, defeating that
> commit's original objective.

I would phrase this differently. cpu_is_isolated() checks HK_TYPE_DOMAIN,
so the jitter argument holds only when the nohz_full CPU is also
domain isolated (isolcpus=3Ddomain or an isolated cpuset partition). With
nohz_full alone, or isolcpus=3Dnohz without domain, this patch does not
apply and the behavior is unchanged.

> +static inline int blk_mq_hctx_unbound_cpu(void)
> +{
> +#ifdef CONFIG_CPU_ISOLATION
> +       if (static_branch_unlikely(&housekeeping_overridden)) {
> +               int cpu;
> +
> +               guard(preempt)();
> +               if (!cpu_is_isolated(raw_smp_processor_id()))
> +                       return WORK_CPU_UNBOUND;

Since preemption is disabled by guard(preempt)(), you can use
smp_processor_id() here instead of raw_smp_processor_id().

Thanks!

--=20

Marco Crivellari

SUSE Labs
