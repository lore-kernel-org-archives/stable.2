Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52DC3E2AAF
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646537; cv=none; b=mAv0qHFE8QWYshAWJ+AKWixnW0JZHPB3q/+8ix5fB+AZUPOpm/TmjuZHbaGgRrqctTlEHBJJq9UU/dB/zLi22Mz2n8U28Tj9m1oQpBIPXOqHlty6rVp1i4N+XUyT4Q4yLyuZtq9+lDLkAch8oIwgeP3qMvmmCrtzVJbQ6PIMUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646537; c=relaxed/simple;
	bh=mGH8Nwx572CTfP/1QDJsW/mggP9iIrflc0CYlU9qs4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8M8WgOIKFsd6qamwUrBVvqe9NlHkddT892Y2yoq3RlUVB0WWUEpVlL4g83quheAXWF3ISN0gvNWbNyFs9hCdd2/Ts81G2S0EZjnz5t6RX08msNsz6eEolAD0wV+dHjf3oUgMjrglxg50H2eWT04ZUZjjf759KS203gRtcGtCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2poeroJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2poeroJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9101F000E9;
	Tue, 25 Aug 2026 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787646536;
	bh=32GBGUHejytOR67gMA2DxitOVjIpWrKDqlHnnEwE1uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=s2poeroJsKI3dZUjtjYkNQkxchKhMfSNOOFmxETina8fmzSZO/mQ4xQRxHkCKelmD
	 rYyRHic6FrUAqI6JobCn576447GxWaoeEqT7QK9b4kko3bFDxQFTNHvx/jJuzA7Lta
	 lpihKKtw7FOymyQDMyEbc5uAoZ1DvCN2fhl4oW3Y=
Date: Tue, 25 Aug 2026 10:28:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia Yao <jia.yao@intel.com>
Cc: stable@vger.kernel.org, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.18.y 3/3] drm/xe/guc_ads: use uncached mapping for UM
 queue BO
Message-ID: <2026082551-promotion-liberty-83d3@gregkh>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825034224.642641-1-jia.yao@intel.com>
 <20260825034224.642641-3-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825034224.642641-3-jia.yao@intel.com>

On Tue, Aug 25, 2026 at 03:42:24AM +0000, Jia Yao wrote:
> On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
> if GuC reads the queue via GGTT (WB), stale data may be observed
> when the cacheline has been polluted by another agent.
> 
> To match the GAM's UC writes, configure the GuC mapping as UC as well.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Link: https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
> (cherry picked from commit 9daa302a82590eeee7bdc68023ddad302df4b88c)

Same here, invalid git commit id.

You all really screw yourself with the bizarre "cherry-pick backwards in
time" model :(

Please reconsider it as it seems to cause nothing but trouble.

greg k-h
