Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB911474CC;
	Sun, 14 Jun 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429640; cv=none; b=jox89lp3AIRLUeuR8vGMG1eGnhR9VpMp1zL5Sk8hBhiiOXkGJHh1KIrdcmSJzYDuA7LYjHbSXqRdq8kalIn/HFxZkvY4Okh5uIrmxlmuEukUzOJaJKeixDqBpePA63DMzpbkLb+n3uk3Lj/mc3tCDbwH1d6zfihqVjGB6jRXoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429640; c=relaxed/simple;
	bh=39vi8RQyz3VrBoJ2dZQYUcftyCtehq+6tCngoyIN7+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewhUSKDCXCw5DqQABKD6HlGmcYqIGAdzQR21lrp0qozUzM2HqIUnewFrdvs5Z7qY33M+gvDgsbXNDt7bfzNHmkzPSOTObt1hCfjtjGb+dBQ/FPTO2se/lkhIQvGwW50uilOJy6Z53EuypZr/+uuYj1cFcEe4CuyaNDq0hKE2YcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=gd0IIxKO; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="gd0IIxKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1781429630; bh=iJ8ltjNQO3XwTSQDKP9JX7ThWnfsAAoNUimBE3TzqWM=;
	h=From:Message-ID:From;
	b=gd0IIxKOE72g+WvkCNozzMTHRRTmzMlYcmhZJodIT//28LdK6lWM5xLLbnzQ2ICTq
	 h/uKrrvpeoXr6ztQxG7GdHtCBC1z8GKsINRrHy6Z6K9rCbhWu4OgFi1KjyVjr4GDgJ
	 rJiWawvCuTMWhFZk+Yd53YlmlsDQUjXIwWgRYMzM=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 48101C0A1D;
	Sun, 14 Jun 2026 11:33:50 +0200 (CEST)
Date: Sun, 14 Jun 2026 11:33:49 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [RFC/PROPOSAL] Shifting the x.y.z Stable Tree to a Continuous,
 Signed Patch-Stream Model
Message-ID: <ai51ff9TcMOlEGqA@1wt.eu>
References: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
 <2026052444-unlawful-eskimo-9c41@gregkh>
 <5f62925e-0faf-40aa-a594-10ef6d50f24e@gmx.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f62925e-0faf-40aa-a594-10ef6d50f24e@gmx.com>

On Sun, Jun 14, 2026 at 08:16:06AM +0000, Artem S. Tashkinov wrote:
> A better model, in my view, would be:
> 
> * stable.git remains the canonical source of truth;
> * every downstream-consumable stable state is identified by branch + signed
> commit ID, optionally with a signed machine-readable manifest;

Well, you have stable-queue which is getting closer to that.

> * distros consume `v7.0 + stable commits through <commit>` or `linux-7.0.y
> as of <date/commit>`, according to their own testing and release policy;

what makes you think that distros will want to pick even less tested
or validated commits ? Right now we know that some distros cherry-pick
just what they see fit and they miss important fixes, probably based on
lack of trust of a well-exposed set of patches that compose a version.
If you refine the granularity, there will be even less trust in the
level of test of each commit and they might wait even longer to pick
fixes at all.

> * point releases may continue to exist for consumers that require them, but
> they become one possible checkpoint format rather than the central model.

This model at least gives a good indication of how late your system is
(the last number roughly corresponds to the number of weeks past the
release). It also offers opportunities to maintainers to voice in
saying "not this patch" or "pick that one with it" even if it does
not happen that often. And it increases the exposure on patches
combinations to more users. The finer your granulary, the less tested
each combination is. Here the current model sets discrete points in
time where many users deploy the same version hence the same set of
patches. This is particularly important and it has allowed many times
in the past to quickly spot a regression that would have taken much
longer to be noticed if everyone would deploy at a different point.
> 
> This decouples two decisions that are currently conflated:
> 
> 1. upstream's decision that a commit belongs in the stable branch;
> 2. a downstream's decision that a particular aggregate is ready to ship to
> its users.
> 
> Those are not the same decision. Fedora, Arch, Debian, Ubuntu, enterprise
> vendors, embedded vendors, and live-patching teams all have different risk
> tolerances, hardware exposure, CI capacity, reboot policies, module/signing
> workflows, and urgency. A single upstream x.y.z cadence cannot be the right
> integration boundary for all of them.

I see it the opposite way: those who don't want to follow stable branches
already don't wait for patches to land into -stable to have them, and
those who follow it will have even less reasons to trust aggregates on
which they have no feedback at all.

> In the recent 7.0 security/regression mess, the useful downstream question
> should not have been "which point release has Greg cut yet?" It should have
> been "which stable commits are required for the complete fix set, and has
> our actual distro kernel artifact built from that stable commit range passed
> enough testing to ship?"

So in fact you're just proposing to move the testing more on the distro
side hence to fragment it.

> If distros routinely consumed the stable branch as a signed linear stream,
> they could pin a specific stable commit, build from it, test it, and declare
> exactly what they shipped:

Given that nothing prevents them from doing this already, surely if they
don't do it it's because it's an extra effort that doesn't solve any
problem ?

> ```
> base: v7.0
> stable branch: linux-7.0.y
> stable commit: <hash>
> included range: v7.0..<hash>
> downstream patches/reverts: <list>
> ```
> 
> That is more auditable than chasing point releases or cherry-picking
> individual commits from intermediate states. It also makes clear that the
> distro package, not the upstream tarball, is the object that was actually
> tested and deployed.

That's already the case, usually they have different version numbering.

> There is also a practical artifact problem here. For long-lived stable
> series, publishing a complete source tarball for every x.y.z release is very
> wasteful. By 5.10.258, the 5.10.y series has hundreds of distinct tarballs,
> each over 100 MB compressed, representing tens of gigabytes of mostly
> duplicated source snapshots for one stable line. The real information is the
> base tree plus the incremental stable deltas. Git already represents that
> naturally.

That's an orthogonal aspect. Some tools are happy with the immediate
availability of these tarballs, and if they are ever considered wasteful,
they will probably stop being produced/archived or they might be deleted
after some time. But many users just download incremental patches.

All of this sounds very strange to me personally, more like a solution
looking for a problem.

Willy
