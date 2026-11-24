Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515712;
	b=Cp6/Y+B5wR2fsVKWmGfoUQSnz82nsxc7CM4XL5p15NOcCryuVbIkxamPFet/N7X8P0iC
	 dgLVwXMgbNrcOT7F9doxxlniytUb8HxtFAo6i3Qzuu48PG8rA8YNzV++GII+veKDn1EC/
	 8/KKKx0C+lWvu00ROgewNMZhsQ2yUBuU2QxL8HcsjZD8mJTiZaI5FHj0ZSvv7YQ2dRWec
	 8sE6tUaZRXRZ79r5irztFz7ZemtU/Tu6ORvcpgByZCZygizNQs9ROu+EKLWF1GgDL24X6
	 a/Yet1qOWkEz0ialcMHXS2gKv03A/QL2Kd0vkirfuJG+kR8dPmflXX25Y6oA9eVIbPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
	b=IoyBm0BTRgNCoH/W//SO5fstDEn5IOVe5yYyYkiuUFg4sBF7zJVMYCOsXTLFjbXRIVhn
	 iAdkIlXoZugKVGXJfTnCjI1MsKqdi9dLcjWbJgpWPYEGd8YH8JzhI3aIaG28UlPa+BoGz
	 gg4u+VAfygnPJRNuCRySgbCyZp3sDh2TvXsBbKm08/7wRVxyCmtjr8fSm77MiWC7Sp3yq
	 hPCYtmh747WeLFAzKQp/YyfpnbJi8rNnQbsc5YWDCbzmcBSf3nH0tm8I1HxhBaFXaLGgl
	 lb4QUHWik7Ht1ntAPVnNvyLUhgbAv+sDgldJf9W2Ik0Y50rf15bfrIu8Jx4ZlhewuXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Lk1liJ0A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72284606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72284606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Lk1liJ0A
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so5273332a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:21:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515711; cv=none;
        d=google.com; s=arc-20260327;
        b=LBgtUwC+P1c8Y8HLvLpQLWjFo6m0uS+iGDZgYdZfjXaRqYn4Lr7fAgIdjsk3xPZu++
         p/5UFDomzO4XNoWqSDixnM91XhyCmr4JWlmirSY6fRGpODLnTLKDcwRKzmlRHdGq7OxA
         DBKCQ9WIAQc3RvKlian+378X5Wj6Usc19ZwXyy/yvrf0vs9rkOWUVwSXk2yW/8O+HcDr
         Q7QogQMaso/SjuKNxsWWVGBzaJunFJbFv7xcjasyWH/1E4bxjXKBWZ0CTjnG9qFA+w3W
         kTKvJAZLawximMKR0rVgINTuEole15X8/I+mgJMspviYe/lfuaaRqsX3G8dqWDOwYzLT
         hJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
        fh=RSogsY9cfYaeGuoB5+T04nqh+fCrwXr+ZqWF1sXqeCk=;
        b=qQQCqnQOS+kPR3g2PZGflX5yoMuW0fMNLMz+R3astoMJNuPAe4jFSbJAe0cBbwX6U/
         d6Tx/t7tRtg0p5YhA3M1WoZwh/bEPchT2xIs1H0fb9mA0dtA3EkbBHABZXkZzK0VM0ad
         Uv3gwEmW1EjimBRl+j4TTZfeEUt6OzGld7gipZge4paXb+OGPnPXXrwBBealxuNklRLH
         bKIVc168MWi6TLzqDV9TlrMibEjMZGLkIJjtOaoJwQ6QjoE/cEvIcX3I1+RIXvoUbYVA
         RTCzfm7NxFql5eMP99i47JkrZzmtDnMM07QLLG5VDdw3v+rIwGpShf8xt9esxepwcW36
         BBpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795515711; x=1796120511; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
        b=Lk1liJ0ACWNQ1ODfdqGHihGLN5SxGl+p1YIPb8cR57G5wO/7Vd65Ebrd962f+US2JI
         OfBHEVXzwnI3MPOKzqxv3x9ZPSdowaxWPlzIPGf3HXFsMk5+AOM1xLRgvc+xu2Ub1Htz
         7KHDW9KCGKJa6eQ9Mfdkw5ZrLOFo7Hq1NoplwonbgMpKWkyj55qUY4o4VxnhHdMaZJkl
         +q7loZOVP9Tl0ja1ijRAatcWybALqcPybHeP/xVsoESM0cxnnAFCS44ui1iQy2cD+2Gp
         1CnTU+xuWFxC/aIPFAlkdSbuNJNfLdMsPpfgEKq7E00P289lF5ZcT1ceZWTnpkHWzTPk
         OahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515711; x=1796120511;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EAb616aCFKaeCBuW+s0EO+gYz957AjGDpcMTSjjRJ0k=;
        b=bPbsKuZ0nA/QaYPIUy+gNgoqljfRdFVroQedBcIKAwBS+Q7oOLrF/ey5EbzYSx0Jwl
         RhyXPyXOjJzwb3PX4Th+UOJj+hUjGi7VuzqjqRGWcHPaLPbmBnwk7t/LIiAPakoYC72b
         HrPlWA4QUTTd5SgK0gdaq8mMUhKkiPrH4IY+FifNU9b8su1gRxHeZWOwpBGMeIzKb1LI
         n3kyAnFuJ/hMEfN7/PFXLjpReBgDIDuyZgaZ/aRLAyR4mPzcC5dephD5cPlrrKxS1PHg
         UzZdsO9hlBj4PutnXae5clrvpWFe1hzXyywHoL4tUobNmX57puIt/nNbMpdDqIwAq150
         4Ojw==
X-Forwarded-Encrypted: i=1; AL+hErGjwDukVnk/lowpow/78JHmmcdpKGF1N1VvgB+Z67y9DjUoRijEpxUPoms6ucabC16zo3/d/6M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8H9xFcVhW6g4oLjcfcIK36eIJJK46wlHmieVFyhJFVPgJH2vRo
	z/HUa+541aiz33w+BnZf4G6kTv3QyS1IMW/oc0CBwLehrTc/M1k+KUJIEL4Sgsix8sr32y+2EcO
	kXPM/5AZX1cFpKTD2STSk5pr+k4XAsXX/wRa8VjJQLg==
X-Gm-Gg: AZFdTZfl+CyER3ZRDOpprExLdMsFq9QKj87NM5eaFr/x5xuMqojFcw8jkpDt0H9msl2
	A32I25dFyksYpqY5hOvLOl6ZwsFABrWVs6uLw69ih/RqnOOwjB4RLDpBwzr5NdvXBy/XZLPM0DM
	3Gw622EFli1Pu9Zas1dLzxNO9aV5lG3hXD1JVARlqwX7B+lUhw3jK8IhI0a4pT9PavCabXJ+8lw
	9pXZygEkE9Xf+5t7HJ+gla6UptQDHddIEGVecZg6xg9PdhQU40QBVC99bKdLTYL6Vx1tkVDbdI6
	YDLy8x/2yepq34pH1nef062GhR7hXpKVLv8Oa9clNF+n5NAJS+sGhyCddRqABMnWh66wCWwOQ/k
	2bzox9JCUyZm8BBInZ9gr1ijKNor4SoAwzhFfVqOzDE/ZHVkzOEMT4hUJMHQLXJ3tZQTxhw==
X-Received: by 2002:a17:906:f59d:b0:c2e:61e:f4fd with SMTP id
 a640c23a62f3a-c513a47e316mr1137772966b.5.1795515710841; Tue, 24 Nov 2026
 02:21:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
 <20261123160934.2289260-1-penghuang@google.com> <861e8b931f99acf9c44cff722d5e94e7@kernel.org>
 <20261124004742.1248371-1-penghuang@google.com>
In-Reply-To: <20261124004742.1248371-1-penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Nov 2026 11:21:39 +0100
X-Gm-Features: Aa3M54poptazUM0JGKgFwqYCHNoqGw1XuVjKaJum1hg2U8ffwlyzLqavOvLaj3s
Message-ID: <CAKfTPtANtEnDDOe-PdLVR3BU5_cm9LiWTnU6eZJveUs4Py4qog@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
To: Peng Huang <penghuang@google.com>
Cc: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 01:47, Peng Huang <penghuang@google.com> wrote:
>
> Hi Tejun,
>
> On Mon, Nov 23, 2026 at 01:48:44PM -1000, Tejun Heo wrote:
> > I'm not familiar with this code, so I may be missing something, but
> > doesn't __update_blocked_fair() already do most of this? It walks
> > leaf_cfs_rq_list bottom-up, flushes cfs_rq->removed and propagates the
> > result to the parent. It just stops running once scx_switched_all() is
> > set. Maybe the helper can run the blocked load update once on each rq
> > from that loop instead of open-coding the clearing? If I'm reading it
> > right, one pass after all the tasks have switched would take care of #1.
>
> Yes, Vincent suggested the same thing, and I sent v2 earlier today doing
> that one-pass drain via __sched_balance_update_blocked_averages(rq) in
> scx_enable():
>
>   https://lore.kernel.org/r/cover.1795462673.git.penghuang@google.com
>
> > As for #2, are the leftover sums big enough to matter for
> > update_idle_rq_clock_pelt()? It looks like fair can leave similar
> > leftovers behind once the avgs reach zero.
>
> You're right -- for update_idle_rq_clock_pelt(), #2 on its own is tiny
> (< divider, i.e. < 1/1024 capacity per recently-decayed group) and is
> not nearly enough to cause an issue once #1 is drained. #1 was the real
> culprit in our reproduction.
>
> I only split #2 out as patch 1/2 in v2 per Vincent's suggestion to clean
> up the util_sum != 0 residual in update_tg_cfs_*() when _avg == 0 (which
> otherwise keeps cfs_rq_is_decayed() false and leaves empty parent
> cfs_rqs on leaf_cfs_rq_list in fair). Patch 2/2 alone already resolves
> the sched_ext issue.

If patch 1/2 is not needed for scx_switched_all() case, I suggest to
skip it. When fair tasks are involved, the *_sum will decay to 0 at
during update

>
> Thanks,
> Peng
