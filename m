Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0B2E739E
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646470; cv=none; b=ubQ8ZbFslEap3iXsj26LHE8VTXt1qd6v+q6dhZx/zZWa3zgPd4F5Rl5xim5x6yNs7TjA7E5Qo57VQ74xaFwf1EjSJkwc2rexL1kHRXTYP+7jps8Z+XA7FLKPO0CSnUyae0CtmCCoQz9pK10s3XdULGr63c74tLyaUNWNLUH+zJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646470; c=relaxed/simple;
	bh=cY5b2o0JOVujLZ0tmi+SqF/nsp8ZQCFF/N/fLvvP/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mt4XfXncNe0LjVJtK1vNt2IIb1xFzlDFP0OJbKx00p8ZxBAPNk2hqltKVBET/y9SdH0PHJHQqQwDhMdrqyzSyX8zAFGWqsJSDewlh4s/84sU8vCl55wSTFBC4tiD5Bu79FkCSbX3ED/xjkKD4/D1kI5/TqFqaR2T3oS2rWjH6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2szZrVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2szZrVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A557D1F000E9;
	Tue, 25 Aug 2026 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787646469;
	bh=HNSpJ0wU8AQzpIeifBvBL7TLi09A6uUPHekDbHqA+U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X2szZrVsfa3RdX3ioOSH5fZG8oy97uNYdPEdysQUngq8oMh8NuaaIC+L2xKw/mmfN
	 It/NHpoQ3CD4PSVGpW+pNitjxXpQfKTqYEQTJ6jZFOmRyCZ/oCMwDMcuQSP8P+wGqt
	 og2muOtF8dxibxAgGnRqZax6jpqXjAMGrNthWaNw=
Date: Tue, 25 Aug 2026 10:27:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia Yao <jia.yao@intel.com>
Cc: stable@vger.kernel.org, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.18.y 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on
 dGFX
Message-ID: <2026082512-emergency-macaw-eaaf@gregkh>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825034224.642641-1-jia.yao@intel.com>
 <20260825034224.642641-2-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825034224.642641-2-jia.yao@intel.com>

On Tue, Aug 25, 2026 at 03:42:23AM +0000, Jia Yao wrote:
> On iGPU, the UM queue BO is allocated in system memory. On dGFX, the BO
> was previously created in system memory and later reallocated in
> xe_guc_realloc_post_hwconfig().  Allocate the UM queue BO directly in
> VRAM on dGFX, where it is ultimately required.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Link: https://patch.msgid.link/20260804165057.129529-3-jia.yao@intel.com
> (cherry picked from commit ace076ef0a854ab5940bacc539bf66afd61d118c)

Same here, this commit id is not in Linus's, or any stable kernel trees.
Where is it coming from?

thanks,

greg k-h
