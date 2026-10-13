Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1F477287;
	Tue, 13 Oct 2026 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872556; cv=none; b=K6Z/Jf2ar47QxhxZ0b7FWhxXAjIMRszrO55ud/j2L/xvOq8N8Ktyflnj+YsudLOSIiIWLAQCwu26fJrJjd5aqnatroSZ1CDzL0FVJe2JlPuVthJBJhxvHbqELGONA7UKC9StqVjtiMM8nGGLGpIC87w+GHBCcN4LC0orzWYRMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872556; c=relaxed/simple;
	bh=3qaAa5zGPO24LeLrjopRSkS/EZtYF62PercQFLuvjhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaf7mZygxzRxDW9OHIxTbJ172RAlWzrBSj2YWAiMBO96KiEI1L9gLj8a+R3ypFPD8BMle7fb1FiHVJcDXJ7N3VVV0ePRvdfvk0y6BWIAYDUPbDR8w6+twSHvBl4LcgEduT/621F5g1nFylaAaNSTPbRS3+99nxUKT0j6TsjxBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OMX7gyYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OMX7gyYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F4C1F000FF;
	Tue, 13 Oct 2026 06:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791872554;
	bh=C8c6Txdxw+cte+FO23D3cvmyqWjzFTyReCgrOZvsTWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OMX7gyYfmiHQsN3JV47EVZ9TLb3bPWlMGzoquFnR9YRxBbGCgw5chbe/eltq3DScp
	 M+nQ1n/pxC7k7R5vpoGH64nE2uU6d4iWVtLAfAM8qrzgDpi5aZxKf1fHWgK0Q5MRgl
	 LPYFMDsirePTuT0KIjR04I3BL/bj+X81PySkOdmM=
Date: Tue, 13 Oct 2026 08:22:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: sashal@kernel.org, kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] wifi: cfg80211: release locks on error in
 cfg80211_wext_siwgenie()
Message-ID: <2026101331-bullpen-carnation-3533@gregkh>
References: <20261012154246.1233496-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154246.1233496-1-guanwentao@uniontech.com>

On Mon, Oct 12, 2026 at 11:42:46PM +0800, Wentao Guan wrote:
> This error path returns while wdev_lock() is still held, so one
> malformed IE request can permanently block later operations on this
> wiphy. Route the error through out to release the lock.
> 
> Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Closes: https://lore.kernel.org/all/93db0eae-f479-4343-a126-59987ae0dc22@oracle.com/
> Fixes: 8b921a899346 ("wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>  net/wireless/wext-sme.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
> index be121fa36c514..ba6d8827f64b3 100644
> --- a/net/wireless/wext-sme.c
> +++ b/net/wireless/wext-sme.c
> @@ -352,8 +352,10 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
>  			/* nothing */
>  		}
>  
> -		if (!for_each_element_completed(elem, extra, ie_len))
> -			return -EINVAL;
> +		if (!for_each_element_completed(elem, extra, ie_len)) {
> +			err = -EINVAL;
> +			goto out;
> +		}
>  
>  		ie = kmemdup(extra, ie_len, GFP_KERNEL);
>  		if (!ie) {
> -- 
> 2.39.5
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
