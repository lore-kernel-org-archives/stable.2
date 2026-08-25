Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F23E1200
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646603; cv=none; b=Ooobmn1Wml8yygCUYzkNW6Z2HXDNG5M2ScUOwwHwohbLLk/NeUNuoDhrg38H42Rmpyi1W92TVbdV+0g0cQyENlbnXqSi3TmFbli8gv/xRHNatZWI2BpltY5s4h6iWRiGhIbsDgtBVh4IpFer4LKW7bx+lcC5PHWIuDyfcHdJGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646603; c=relaxed/simple;
	bh=KzedHY4T3qrxHUMMH9C4xYCKsl0hcoePyhwN5u+d4w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjD5xOCRZi6EmyPAKuBggPdbwotTzolqgGXcOGPY+GQgFxxVW+henzQe/ndhi6p7nOhU+YU1NvkvnlwTDYGXcGRij8adVDuwDUPgC31sH0C58bR3Xi1faHZ0ZsgKjbdRer0miTuUlTvHbD0teXHLD/DeEpmWSuAaDzihmveIrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDU+S95G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDU+S95G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A7A1F000E9;
	Tue, 25 Aug 2026 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787646602;
	bh=fjgw2HDMlD43P85TkJZ3dqxD/I7rN6wt9L8mNORFhSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TDU+S95GBRwLZUxgyeIUb39EmOMfDCIpLdCKl4ms727UrCwQ6+EzYJpkjKICGRURg
	 cE4QPF8LM0pFtKDbkZPwF/RUtIyfdRhRdD8cjsC1TJ+TB4KIOTeZfbnnKPcrcMpJlz
	 94k3hriDoSeSa9CD+If3aZEcoCfh6VvTReQxMedk=
Date: Tue, 25 Aug 2026 10:29:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia Yao <jia.yao@intel.com>
Cc: stable@vger.kernel.org, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Message-ID: <2026082537-porridge-banish-b3bc@gregkh>
References: <2026082037-mutual-coroner-efeb@gregkh>
 <20260825034113.642528-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825034113.642528-1-jia.yao@intel.com>

On Tue, Aug 25, 2026 at 03:41:11AM +0000, Jia Yao wrote:
> Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> CPU memset operations on it, which eliminates the CPU as a potential
> cacheline-polluting agent and helps maintain consistency between GAM
> writes and GuC reads.
> 
> We also need to ensure the base_dpa for the queue is contiguous on hw
> where this is used instead of a GGTT address. Another good reason to
> split this out to a separate BO.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Link: https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
> (cherry picked from commit 6af05de0dc19bbf3aaeec2020fe48b37c834b811)

Same problem with this series, invalid git commit ids :(
