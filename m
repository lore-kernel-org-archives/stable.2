Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDC41BA77;
	Mon, 14 Sep 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377282; cv=none; b=NEWyuPgEklWGC2ySaX7KCqy0STVij45aEyjql3pNZIuJWDq7+FqMbuBy9IHLxTDI6BjhurXgGODxDkD1UOEX8w645x0ca+AwM7F66QLbvYxqfMWc+lZ0X2aykb5l4XBC1r4nHY3Wb5Q4gZGzjETxWpZ+e44wxGNy35IXKYayMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377282; c=relaxed/simple;
	bh=PhakHlGjaVQGTEFzESiU+KVATNhiNdZ8nkBv9rrMXV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfcCweM/aIFlAW36u4gg2EFMgv1kGNZsHtVymJeYv6EmvcNwf/baVIZOMXjQr1gMqE1of/+hBcQggVqsk9gF3cXtXeVOkWMpuhWNz3lSQTNjPI1VgY5ntxbwpwuHnB+6Dng90EXcNJu4+6Pru+T5Nzxz02mXNU9KrS4AXWk1UHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3oLFUPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3oLFUPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3110F1F0089B;
	Mon, 14 Sep 2026 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377280;
	bh=bg0XSpRqtkXAb1dpOB08jYY4v5A/1Q5EDf2qQrxc/JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P3oLFUPqmj91t0/zRAHyzYparU02eB5mPQzscMbJlnQ17I/6E9AUvSYjouizAajGf
	 I9kTUdNaTwsT1Vehpas/3hMv9Tm78Jst6QsPEHK9OT/ZHc1hWerCXP+adJovCCJr9+
	 EwYpx8mT4FhniIsfUoTausqKcMTRW6wYKregPbdT8hkIDpAQ6uhYilJt6xbyjgPUSU
	 TjnzGRkvyllOBRz3pghW8kSy5A/NpUbWRIrWs46O/btV87HtG7XZ5iLAQOnooWuTis
	 8msYJDAOt/U296sGrHADNDOkvSYwnq1piDqb54lgOYJKvRnCW5EVnX6UoXN/W/kYJJ
	 IJCDMrBBVHAPA==
Date: Mon, 14 Sep 2026 10:14:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vtlam@google.com, stable@vger.kernel.org,
	victor@mojatatu.com, hybris@mojatatu.ai, sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net/sched: hhf: cap hh_flows_limit at change time
Message-ID: <20260914091435.GN48209@horms.kernel.org>
References: <QDISC-B855.v1.20260911153152@mojatatu.com>
 <178924538361.3125.3706649335976216385@kernel.org>
 <CAM0EoMkMCM92WBrt7v+2Ov2xSGGAqen-YTZj4irJzNcArrQjDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkMCM92WBrt7v+2Ov2xSGGAqen-YTZj4irJzNcArrQjDA@mail.gmail.com>

On Sun, Sep 13, 2026 at 06:34:15AM -0400, Jamal Hadi Salim wrote:
> On Sat, Sep 12, 2026 at 4:36 PM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 0
> >
> > - [Medium] net/sched/sch_hhf.c: the new `[TCA_HHF_HH_FLOWS_LIMIT] =
> >   NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT)` policy entry (line 530) is…
> >
> 
> These findings by sashiko-nipa are accurate but as in the previous
> codel thread they concern changelog and selftest-robustness nits.
> IOW, there is _no code defect_. The -ERANGE behavior change on add
> path and the changelog overstatement are worth a one-line fix if/when
> the thread is re-rev'd, but IMO are not a revision blocker

Reviewed-by: Simon Horman <horms@kernel.org>

