Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68643231B;
	Fri, 24 Jul 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896427; cv=none; b=T1p5K2cBRGpnGTZkSdyPiQYd5BGrnFK8+BH6xZnAv1o5dwhEVPSQi495I8Z0mJBqbrayI0Ek6wTXD9PKjOAL1svr+Gw1gsERDeDB1+AZkyyiB8CF/A26Ln44eFkfKfj/4zXYQM3zo7QeEWK2vpKjBkvwZvd1g5ze13aHvfcO/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896427; c=relaxed/simple;
	bh=Kwb143STNpuN8Re3VlY9vrcwLH3bziffSBE6EG+CDzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4wn4/B5tVOOo9kY03EhXdSm1gYn4hLNt4mq5ndXqfzdS8NYDwWCCUJetCfsV/TnUPkM5HtZzcKjy5jai1B/nNzyT1ykX68MlXqVWBeeUNNFOAaZrGjv3MKteNltMC4xcd1aEFSpYETKvJGbv6f0WRfvvBeBF+iMDlxYhGkyCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJNVc5i1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJNVc5i1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6117D1F000E9;
	Fri, 24 Jul 2026 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784896423;
	bh=xeP3NKjCWLZdfOw+j9fO1wdvfdwucmsk9nIhtP2PnoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZJNVc5i1i69+a/Mc4Z49FMKrvQuR1LfO9Y5Jlb7aGIpgWDly00DPmJGTDM3w8V2R6
	 srrhviX3UnGz/eCu3hc1Y293zwTqXyUAp4eMmJXlhezMZNP0kHRpxDZKs5rCz4G97W
	 Cz7YFGQ0xy7ruf/Po91jtioCYHZoIeDBZx59cyobnGGHyXMNWi05V0ZBDxHQOk6NTN
	 VHjWYQlXD6GZffpEgSI6OCVlYxCPIZu5RIH2Zg61iFJlLpe/HRdd8y8mCau378RmNl
	 f6Ydc6d8C7c5Keo+UOUAlWYVTBgMMyLdIZsb9i3kMwurrQswVrDS7LWs8bwxh8DjlB
	 fQIm4BD8YEPww==
Date: Fri, 24 Jul 2026 13:33:37 +0100
From: Will Deacon <will@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Weimin Xiong <xiongwm2026@163.com>, catalin.marinas@arm.com,
	kernel-team@android.com, robin.clark@oss.qualcomm.com,
	joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
Message-ID: <amNboRxbKIoi17eK@willie-the-truck>
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
 <178472575580.2876636.12194314237571577379.b4-ty@kernel.org>
 <20260723164944.hglmw7kgbikfgtcx@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723164944.hglmw7kgbikfgtcx@hu-mojha-hyd.qualcomm.com>

On Thu, Jul 23, 2026 at 10:19:44PM +0530, Mukesh Ojha wrote:
> On Wed, Jul 22, 2026 at 10:39:34PM +0100, Will Deacon wrote:
> > On Thu, 16 Jul 2026 16:53:12 +0800, Weimin Xiong wrote:
> > > Move the list_add() call to the end of msm_iommu_probe() instead of
> > > adding cleanup paths, which avoids the dangling list entry problem
> > > entirely (suggested by Mukesh Ojha).
> > > 
> > > This approach simplifies the code by ensuring the iommu device is
> > > never added to the global list until after all potential failure
> > > points have passed.
> > > 
> > > [...]
> > 
> > Applied to iommu (qualcomm/msm), thanks!
> > 
> > [1/1] iommu/msm: Fix dangling list entry on probe failure
> >       https://git.kernel.org/iommu/c/6bea37b176b8
> 
> Will,
> 
> By mistake you have taken the wrong one; it should be v2, not v3 that
> should be picked. Sorry for the confusion.

Damn, so close!

I had already realised I wanted the v2, so I'd flagged that to be applied
and marked the v3 as "read". I then carefully passed the message-id of
v2 to my wrapper script around b4...

... which invokes b4 with the '-c' option, causing it to check for newer
revisions. D'oh!

I think I'll just revert the v3 and try again with the v2.

Will
