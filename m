Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949B456DF3;
	Tue,  1 Sep 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247110; cv=none; b=VhwH4pP1bMYeast4+kqD1v+F5gWCkO+8wVXObC1JDXT/n22Rx/w+l11ZB2ggnG3LzM2TfBACeh859YWy0JQXne1VMpwbtRGWcZ38ya7c7uv73V5rkCSZt7D7CF+k3Egyb7x0F0GoSt6dCBvVl7psnHAAFY/kYr7X5YO3SQE/rO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247110; c=relaxed/simple;
	bh=D5X5hp0rLD200qNbvd/0WTpE/bHAqMjL1dE7N4Uad30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFn6nP810jJjRh0TWmBztAv7R+5Yvg/CinYSfdNO9gqgOEcMb/+c+MwtR0kOVRAVzHmmSpLK8j0s4T8FXc7dV5Wp9BVBx6jODOU7ncDr94oG+2iV/7a1p+FIY/GK2YDJWMJvt3X06L86BHTI4XRRxeNPBcRp6VtEQKYOpqSIMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvoXErb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvoXErb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9692C1F00A3D;
	Tue,  1 Sep 2026 07:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247108;
	bh=BliBlBY/rE2XXAfiz114Pf5LOVvfEPyRfjJ0ncDHxzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CvoXErb2sAbM5eo5Z8hj41LsJXMSJ3CqDv9mbfoKuBKkC9Yiqxk0zhn0sOE2VHMx1
	 +huckBkdkUb+v8BvRj2x6LSaexGExbNZXJQ387B/KCcLUPvI4rsPl1JwrLMe3+g72i
	 bzGN6XjaNRoTT5SgvmllYakS2peRE6aocqfD1jHEKxpaWrSC9sv9B/a0hp9QoN1WfZ
	 oBuibsVlhSIeJCSUk5lccBQcQ+QnIiT4n2DFPqG1YTfO1/CABLx4tG8JjBoXyqExbZ
	 xT3uUaDK2BXqfMV1USdT9voFU1Q61JPRETne9TrLoNxHeNCtH5vLZZ7P2USZ/20Ff8
	 I1eSZk8uLR++Q==
Date: Tue, 1 Sep 2026 08:18:22 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Steffen Dirkwinkel <lists@steffen.cc>, Pedro Falcato <pfalcato@suse.de>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/alternative: Exclude text poking against
 change_page_attr()
Message-ID: <apZ8AXqJBeI2BztN@gremlin>
References: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
 <178821524520.3717435.12731475498671524229.tip-bot2@tip-bot2>
 <4201eac9-297b-4672-8e7f-62e99dd13eb8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4201eac9-297b-4672-8e7f-62e99dd13eb8@kernel.org>

On Tue, Sep 01, 2026 at 08:16:28AM +0200, Jiri Slaby wrote:
> On 01. 09. 26, 0:27, tip-bot2 for Pedro Falcato wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> >
> > Commit-ID:     1c4d1c070d734b241728378c0f79950c23a10883
> > Gitweb:        https://git.kernel.org/tip/1c4d1c070d734b241728378c0f79950c23a10883
>
> Was it dropped in the meantime? Gitweb says:
> Object 1c4d1c070d734b241728378c0f79950c23a10883 is not reachable from any
> reference in this repository
>
> $ git rev-parse tip/x86/urgent
> 477cf5cd1f698053df7426b7b8d9339e85e00946
> $ git branch -r --contains 1c4d1c070d734b241728378c0f79950c23a10883
> $
>
> Despite I managed to download it at some point though:
> $ git show --oneline -s 1c4d1c070d734b241728378c0f79950c23a10883
> 1c4d1c070d73 x86/alternative: Exclude text poking against change_page_attr()
>
> What's going on with tip today?

Yup, I can't see this commit _at all_ in x86/urgent. Something's very
broken here.

>
> > Author:        Pedro Falcato <pfalcato@suse.de>
> > AuthorDate:    Thu, 13 Aug 2026 12:01:26 +03:00
> > Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> > CommitterDate: Mon, 31 Aug 2026 15:17:35 -07:00
> >
> > x86/alternative: Exclude text poking against change_page_attr()
> thanks,
> --
> js
> suse labs

--
Cheers, Lorenzo
