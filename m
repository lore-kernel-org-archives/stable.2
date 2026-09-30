Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AF4F30C3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782255; cv=pass; b=iP3mm9Ojeqz5b5DkYGckzSlCQYUE4XHyWJZrXFuxkjI6BaBkIAwZO3X8m7uDCCnWOtWl/m+MRH+1ZHr1PtNOts3XOY1RJ8MaSToQaOHk3Jq5hUzQZs5uY7ITXFHHI+/tnGb2CusBesPE6M9eyff3KPTLnWicbn3V9qaDmqMfQ2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782255; c=relaxed/simple;
	bh=00CT11zds5LLvEUih7SkHxE2iwVGb/CEnwh2GAbFAFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tySdk40qog7HBpm1DgOgZeZ0B5TwUhmpTI6zK4K6co1TxmWU46HqgXUKa90lo3DEvSGLoAQHzeTLaZpgP9vchrhRVKOrG9BelmXDRudm5SDhukSd627yBmhbzLCh7pPlzTEx9z5XQ7g+ffJjTElU14QHp6M6kITjtGLCyWg9m8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BH1dIPdw; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BH1dIPdw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018493d57so13615e9.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 08:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790782246; cv=none;
        d=google.com; s=arc-20260327;
        b=Vi3TXEvppzWWlNImNCGSIQOG2bAN62PIogO/SMPXZB+ZTZg4TDe63e0vBRD0Ff4HQs
         l6s2jzF+sAM7MoYQEQXXO2kVD6IQaEqDfcaC5TbfhNq5IQhprJ49N5zt3kgcImueqsYY
         sNfZFt1yYz65Ey8+udBactfCqGJLD9FkQPmZHMkHrAOgRti9+LzXrEeyWW8H4TvaUFyJ
         cYS7KFQFcZuMwbj6M4YK/UfdqUL3DnpAH9QuhlxFl8C1tcMhR0eK31Tqi6jI1sY3AHab
         R6eMG4uwkt3Yllt5FyChdVFx4moeX9aUvcrkdtfVzu2X+cJQBj3UlmfAvec0FGNHyfBA
         RhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=00CT11zds5LLvEUih7SkHxE2iwVGb/CEnwh2GAbFAFg=;
        fh=TaWe0PIqxP3qzlWlvhjjxLHX8ShZgt3cw8Zhqv3dGmQ=;
        b=pA5l67dfOU4jmIPKu6qo8DhAQlzKK+LiQzTw903DkPhN46pNRvM23qeANTAM82UWuR
         BUSWsv4uFvuDRjstJAc5bNGtttCR73krTLM4AuL/sYU+NTdUgPrWXolVc4cryUZfDV3M
         aCi6mnIILJXUpsXZUgCq0+BFUVkoamFx3/aW91yu5Ww2yqUzcYVpnAgl74GhYogBYv8l
         DuyR60hIn3XrUN1DMHauu9v+5iXS4k3ZsasvsCAoHB/eFkXiZX7GRviTE5u9pXy1lWi5
         kvSMHKbFm3OCzAaW+1czYFrDXn8hqeNX5OyXTbCDddUsgYv0LiVzbvJHQkw2cTS2dUUy
         gbHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790782246; x=1791387046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=00CT11zds5LLvEUih7SkHxE2iwVGb/CEnwh2GAbFAFg=;
        b=BH1dIPdwLOQI5jiwdl/+Y440AwkV/P9oDNq8vMeQG6+MDtNayf+QFybKW/MouG+Lvr
         +LpQ8MwTUSug85rMbjVIa2++rcVhI2sC89+TKeiQK0AwvrDsqlcc7t93zRD+pFrEEvcw
         BfSo3QrU28xenu9t29td6/OoD/ki/vdL5xqJvOsgIqdbVqV8LF3DG3eX2GAAzeRgBvdH
         SEPItpKwT0Zyx05VrrfyiLgZsuXw1cq69Ua/Z10N+Ic/J15Xa8OIXiXAA4Pls91sB916
         CLv3kXoIdbnX+/5YXfS/JPUWnyOIrP+/CYUhFQ4PZemW2kZlmU//wjoeWUwLLmQPkcnY
         0w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790782246; x=1791387046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=00CT11zds5LLvEUih7SkHxE2iwVGb/CEnwh2GAbFAFg=;
        b=O9RYAp//oh4bVNM99z96lX5lWDFEpsyh5gT2fFT0MbeS2HYcTUCcA2PJjmJAciRl8V
         5SsD7X9qFnpgXiwt9SlHepxhbe1t9Bl4fjF07T+yDdv3JfvTt92kWRPTdnG9C0gmtCi0
         xt57KBldURwjWT5b+mFY0nm9o1c9Yx7RAoL/8v8tEWdnR5mBs8r1gdipytD/rsvxwN+4
         VEtq39xdrWQP2uNo+qaiMEumuqdXDNGbWM87/Fo02W+sKOdfXeDzJyWjK3N5fjRMajmG
         kkGminq1KgV0nb1Tiz0jEgR+GgBqfaloZ6RmI9fDRJugb2ggQmWVRKZkx/DwLR7K3oEL
         9ERA==
X-Forwarded-Encrypted: i=1; AKwUvBySQXe6xrZvDUhwfD7O7P3fdwzeKXLN9EBlVd3ym2yxVlHNWsiU5kQP9qCoBwydR5Q4CqgQTdc=@vger.kernel.org
X-Gm-Message-State: AFuF++lNq9qxIRuVByTtTj9yMjivc4DOa7A9cmy5J84XcxeGiK+n/Y8t
	h6dH6hJIHTax65q/Tkus3IKH0cZ40/8Njn6FC0Xr7h+wRrab9WdgXGxjrpSl7IEExqvvgQ0V7w2
	uB+1jlCCM9AGgAi5pbFJxDl35ERS2BdmNedLOWg8q
X-Gm-Gg: AYBFou39ocqpF2v+3LAaqMdUW2X9XFKnPhdquUGzog8wjwQ/6C4IRvWEAlXPtF8inTH
	6Jq1lSFysUQU/xC97JtIEHi8VT0wdeJGgOXnDJXLvzpIszBUjILInRZEzvf2CD0apvnODZa25Em
	2k27Q6aAM2AfdDDJkBcAUGfo9QKOEManj+uwutkoUQ6kEuco13q7FLgj8T/iK58qVok8nMYdp5H
	jCUaflpD1jcpgXh5KMGt+8IzF4k6X9EnnkxPIRDSkowAhw/o3VuCuGsxRKI6qX1XBtilREZCMXQ
	0tKJ4ofSsdUETBiD9fK6IFVG3DlUO2l+sZLQFoIyzBfzRW2eifQV3XlPq+9Tea4WQqq4SIXe2Fl
	xwnH/xgjzjg==
X-Received: by 2002:a7b:ce89:0:b0:4a0:1004:c2d4 with SMTP id
 5b1f17b1804b1-4a014a8ac71mr876185e9.5.1790782245240; Wed, 30 Sep 2026
 08:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928233743.3777102-1-stevensd@google.com> <20260929081004.GS4120091@noisy.programming.kicks-ass.net>
 <20260929081740.GH4121620@noisy.programming.kicks-ass.net>
 <ar0bPEyD5CBK331p@cmpxchg.org> <20260930151902.GO88198@noisy.programming.kicks-ass.net>
In-Reply-To: <20260930151902.GO88198@noisy.programming.kicks-ass.net>
From: David Stevens <stevensd@google.com>
Date: Wed, 30 Sep 2026 08:30:33 -0700
X-Gm-Features: AclHuK9iAsAIpzefYDTrYfo6uYpC5DrbFBPO-pYQ944j_YWb1VpgmqVfpwJuq_g
Message-ID: <CAOiLmNF7m96HVP0Wv+6+r5bYdXuyJ=mzOwg8iJd+aMdsdWmVbg@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: clamp negative cpu_clock() skew
To: Peter Zijlstra <peterz@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan <surenb@google.com>, 
	Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Sep 30, 2026 at 10:22:52AM -0400, Johannes Weiner wrote:
> > On Tue, Sep 29, 2026 at 10:17:40AM +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 29, 2026 at 10:10:04AM +0200, Peter Zijlstra wrote:
> > >
> > > > > When running browser workloads on an Intel N100 with a sustained
> > > > > psi.mem.some of 2-3%, this underflow is observed once every coupl=
e of
> > > > > hours.
> > >
> > > Reading is hard. This is sad, that's a relatively modern chip :-(
> >
> > I'm still struggling, but I'm under the weather so bear with me.
> >
> > That's a cpu_clock() implementation issue, right? "The value for
> > cpu_clock(i) is monotonic for constant i". Presumably violating that
> > would be a problem beyond psi?
>
> Yeah, although most everybody has a filter on top for some reason or
> another.
>
> Mostly it could happen that when the watchdog would detect the TSC
> wasn't stable after all, you'd be up a creek if you didn't also have
> this filter.
>
> But I'm very sad to see modern chips have shit TSC, that wasn't supposed
> to happen.

I ran artificial memory pressure tests on the other two devices I have
at hand - one with an Intel i5-1245U and one with an Intel Ultra 5
325. Both devices also observed negative elapsed durations. The
artificial workloads were much heavier and actually produced negative
elapsed durations every couple of minutes. So this doesn't look like a
platform-specific issue.

For reference, the negative elapsed durations I saw averaged a little
under 100ns. The largest duration I saw was 371ns.

If I'm following the code correctly, cpu_clock() on x86 ends up
calling rdtsc() via sched_clock(). The rdtsc() function is documented
to produce non-monotonic results when compared across CPUs, since the
rdtsc instruction can read the tsc out of order relative to other
instructions. If that results in get_recent_times() reading the tsc
before it reads the psi state, then I think that would explain the
negative skew. I added a rbm() immediately before the call to
cpu_clock() in get_recent_times() to match the behavior of
rdtsc_ordered(), and with that I didn't see any negative elapsed
durations during overnight testing. This does suggest that calling
through to sched_clock() might not provide strong enough guarantees on
x86 to satisfy the cpu_clock() contract.

-David
