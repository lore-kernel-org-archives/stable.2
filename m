Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6E2DECBF;
	Fri, 24 Jul 2026 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898169; cv=none; b=mzcF4ATafMOWo5YYj3+AQMdeON98Wl+390nBb7t5I004BaDSMzcfDUs0Z8sCMLyRYVEnOsNwBd8QGaUikHAMlboyq/N+dsTsD/82hHx03ZkbYnFZexByvGPawUsOq2v6yvmmpABOGY2//ne9JSn5z0HhteuEnFq5vYz1T35OK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898169; c=relaxed/simple;
	bh=R2UqG++24jMQjzZrMQYWmRTE4ea5ODAtoOaewwgP8jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtUUbltcif0eYnCqo6s1fL44U2MWYrNtW795tRpuicWg58ygnOkJ3fciB6SOlXvPq16TMFQ8PBhEhawe0dZKeirWXQG8NhwrQMSI1HqqCv+zw1419oG8jH3v55uWiNYMWmDKv9MbtMdj4N5hjhCPOzpRYZddJtloRnhLejjQoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCQkZCzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCQkZCzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D27A1F000E9;
	Fri, 24 Jul 2026 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784898166;
	bh=oT/PNfd+JGx+qNDUgOwGnXcHfrCthD9J7rAhQgiYYWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCQkZCzN2VcZsFW+ibYpqgzjV2LCJpHX7Z+naBfEyeFcgzghIXKsbYgnoHvy1+qBf
	 zGbd83udnTYbzmU18kkhVK2NVS8o9nqn2CkxBc8tGOrqnCQqbmALYbSusYIk5CdTtv
	 2OxTskLarAxw0muGtHLAxI38zLLbXWePRoanfgR28nhw4xIie5Vsv+S0xrE/Abpzcy
	 YbJkm7Ayo5gh9pwPb3eq0XlRa8lGDtVUkX8pf4Zio2Cd2ECac28ASoCYGtLKTm9vv1
	 ReXh+Nu7qnqIoanQOY3eMUCFQPyze9EBQAeFPnncPmSJtPhd9wVV6vk4MfFNqwhzqh
	 RAQddpANazwKQ==
Date: Fri, 24 Jul 2026 14:02:40 +0100
From: Will Deacon <will@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Weimin Xiong <xiongwm2026@163.com>, catalin.marinas@arm.com,
	kernel-team@android.com, robin.clark@oss.qualcomm.com,
	joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
Message-ID: <amNicHvIY2l7Rnd_@willie-the-truck>
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
 <178472575580.2876636.12194314237571577379.b4-ty@kernel.org>
 <20260723164944.hglmw7kgbikfgtcx@hu-mojha-hyd.qualcomm.com>
 <amNboRxbKIoi17eK@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amNboRxbKIoi17eK@willie-the-truck>

On Fri, Jul 24, 2026 at 01:33:37PM +0100, Will Deacon wrote:
> On Thu, Jul 23, 2026 at 10:19:44PM +0530, Mukesh Ojha wrote:
> > On Wed, Jul 22, 2026 at 10:39:34PM +0100, Will Deacon wrote:
> > > On Thu, 16 Jul 2026 16:53:12 +0800, Weimin Xiong wrote:
> > > > Move the list_add() call to the end of msm_iommu_probe() instead of
> > > > adding cleanup paths, which avoids the dangling list entry problem
> > > > entirely (suggested by Mukesh Ojha).
> > > > 
> > > > This approach simplifies the code by ensuring the iommu device is
> > > > never added to the global list until after all potential failure
> > > > points have passed.
> > > > 
> > > > [...]
> > > 
> > > Applied to iommu (qualcomm/msm), thanks!
> > > 
> > > [1/1] iommu/msm: Fix dangling list entry on probe failure
> > >       https://git.kernel.org/iommu/c/6bea37b176b8
> > 
> > Will,
> > 
> > By mistake you have taken the wrong one; it should be v2, not v3 that
> > should be picked. Sorry for the confusion.
> 
> Damn, so close!
> 
> I had already realised I wanted the v2, so I'd flagged that to be applied
> and marked the v3 as "read". I then carefully passed the message-id of
> v2 to my wrapper script around b4...
> 
> ... which invokes b4 with the '-c' option, causing it to check for newer
> revisions. D'oh!

Urgh, v3 is a reply to v2 so even without that option is still gets the
wrong patch. I'll just apply it manually.

> I think I'll just revert the v3 and try again with the v2.

On second thoughts, I'll replace the patch to avoid confusion with stable.

Will
