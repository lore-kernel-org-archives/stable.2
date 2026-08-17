Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D538DC7C
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944947; cv=none; b=KrDRUY9pbvI6GKyYZGmKME8Yx4i0S7HmVtGWd19kc4g+o3duOyZ5KX4H4a1YuJsC6wrRu6asBwBgbF/kMqVuENOnQq5eAfzT/7qO8QCacKQJhtO2XwwXwbWmabldB+/YIu57bahLPE3zIdQrsVQOsEWLy/wfWDPqtgtHh5CuV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944947; c=relaxed/simple;
	bh=AYrdc+ugrky3fz4zQSL+qRiyWt9rgaJeI5Rd2wUwzAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcl164GPNACi8ZH70deI7scksIOOCM/JSaX/5STm9X7lTX9OqGmbYcCKXlQrPdE0cWHrNRi+qu9tyKXjlZvUlj/oUM95Nbu0GV/3Xa0UtYEV0h5sf4L1uC4d4ao01tnPA4bL+RSsKJJh882NaOUus3rPTWrn+AasImt05QccprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I2LpD1Ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I2LpD1Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A100F1F000E9;
	Mon, 17 Aug 2026 05:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786944946;
	bh=SwrXPaD98GipR3B2RTvvmTtOQm4cAu9mtpeRNPem0Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I2LpD1IpFeZVjD56l2dQzc85/TUJqu9TiJhOib4GoZI9KdjaO8fcopf2yhFkiSyFq
	 npDu11qfVZDyRKjXUeXE3OR5m/dzyhgN0H9jTDJ/Dc8KxJ3w2jVxfTKR8v50Q8915b
	 iKW7MYxxgM0/Pn0qN8DtfLRCrd1UtMjQgBAbFwpA=
Date: Mon, 17 Aug 2026 07:34:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	dmitrii.omelchenko@cloud.ionos.com
Subject: Re: [PATCH 6.12.y 0/4] crypto: ccp, KVM: SVM - missing SEV/SNP
 platform-init dependency + 2 bugfixes
Message-ID: <2026081740-vice-ranged-4243@gregkh>
References: <20260814100652.225499-1-jinpu.wang@ionos.com>
 <20260814193000.15@kernel.org>
 <CAMGffEk4a8cF4utrMYpNvbcxBvuEhPnTY33_3GGs3RU4uy52vw@mail.gmail.com>
 <2026081730-denatured-spiral-61b2@gregkh>
 <CAMGffEnmhVpdLmtqFjX0OFWEZtEenCT1mbRm4DdmJDiaBnhNtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEnmhVpdLmtqFjX0OFWEZtEenCT1mbRm4DdmJDiaBnhNtw@mail.gmail.com>

On Mon, Aug 17, 2026 at 07:22:36AM +0200, Jinpu Wang wrote:
> On Mon, Aug 17, 2026 at 7:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 17, 2026 at 06:51:27AM +0200, Jinpu Wang wrote:
> > > On Sat, Aug 15, 2026 at 4:33 AM Sasha Levin <sashal@kernel.org> wrote:
> > > >
> > > > > Patches 1-2 are the missing dependencies of commit 3f8f0133a5fc
> > > > > ("crypto: ccp - Move SEV/SNP Platform initialization to KVM"), already
> > > > > queued as of 6.12.97 (bb1c8464702540 on queue/6.12). That commit
> > > > > dropped SEV/SNP platform init from the CCP driver's probe path,
> > > > > expecting KVM to take over, but the counterpart commits that give KVM
> > > > > that responsibility were never queued alongside it.
> > > >
> > > > Queued the series for 6.12, thanks.
> > > >
> > > > --
> > > > Thanks,
> > > > Sasha
> > > Hi Sasha,
> > >
> > > Thanks for queueing the series.
> > >
> > > It might be worth adding a rule for the stable-kernel scripts to
> > > ensure they don't pick a single patch from the middle of an upstream
> > > patchset. This could help prevent future regressions like this one,
> > > where a commit dropped functionality in anticipation of a counterpart
> > > commit that was left behind.
> >
> > How do we "know" a patch is in the middle of a patchset just by looking
> > at the git tree?
> >
> Hi Greg,
> 
> I agree it is difficult to know purely from the git tree. For my own
> automation, I have added the following rule to my Claude.md:
> 
> Before backporting any commit, check whether it's part of a
> multi-patch series and, if so, pull in the whole series rather than a
> subset:
> 
>   - Look for series markers on the commit and its neighbors:
> Stable-dep-of: trailers, matching Suggested-by/Reviewed-by sets, same
> author + adjacent commit dates, and a shared subject-line topic.

Stable-dep-of comes from us, not in Linus's tree.

>   - Walk both directions: check commits immediately before/after it in
> upstream history from the same author/topic, not just the one commit
> named in the request.
>   - If the commit being backported removes/changes behavior that
> another sibling commit is meant to replace (e.g. moving a
> responsibility from driver A to subsystem B), verify the replacement
> sibling is already present in the target tree or is being added
> alongside it — don't land one half of a two-sided change.

Nice, but given you are using a non-determinisitic tool, odds are it
will not always work :)

We need reliability for stuff like this, not LLM messes, sorry.

> The reason for this is that we queued 3f8f0133a5fc ("crypto: ccp -
> Move SEV/SNP Platform initialization to KVM") without its counterpart
> KVM-side init/shutdown commits, leaving 6.12.97+ with no code path
> that initializes SEV/SNP, which causes a host crash on SEV-SNP VM
> start. A series-completeness check like this would have caught it.

But does it actually catch it with your tool?

Does your tool catch anything else we have missed?  We often see stable
tags in the beginning of patch series, and sometimes at the end, or in
the middle (ok just about anywhere), because that's ok.  Just look on
lkml for loads of examples of where this is just fine and if we were to
take the additional changes, that is not what the original author
wanted.

thanks,

greg k-h
