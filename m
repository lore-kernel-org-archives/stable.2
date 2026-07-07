Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA96420895;
	Tue,  7 Jul 2026 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423829; cv=none; b=ejGzhD+x0h/vBmRLT5UKwD6yLbNJ/jY57qbnN5ovX530bD7YZtMsUM+VcZjP0VSsdqyzHK2HByT6O1SfUIn3FgGfQMjEOzrvobxhjvh+CInXo9y1q02Dm8cT9/F8YFMyjkJ3FfwGQkSXARQHUo/YAznHZ/cLhpp3CPwS6HIZSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423829; c=relaxed/simple;
	bh=+zGPXOYCvfxJTihvmkSaWo/Rym5shIwSJhrU/0R8Bqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NafOuxVLl3N41UuQGCVFEpBJtW22M7xZ13CIjF7iGOiGjjbxxpNJPtg+alGOZk2huOD3FSF4hUGQy/6bk57r2jqjNgRZHItJxvdvS7ftZdsgvNR19GZ1MKdATFRYMaLE+eaDD9ZSbj7xUjuAS5gu6AfuZZ2i1cP7geUBVhbwYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msIQtjYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msIQtjYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B561F00A3A;
	Tue,  7 Jul 2026 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783423828;
	bh=n1XdS7onZYEeFvZG7RnucjWcRH2GAwo687c+w+c14fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=msIQtjYvDu6X0GOO0Auxy3RaMpWwpA2zNI+L4JajkJj7cIkUgIiIFCxl7jgSAWYt/
	 jHJTnmfCzgI87SO2W8EEvc/shoe0CBzGbdEFcSMVvhjkgRPLLPN+/2hEnInl5RNipu
	 dLp07j0Fk1IMbtsMgcXBS9bv35RJlR4Sxiy+9E1E=
Date: Tue, 7 Jul 2026 13:30:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] staging: rtl8723bs: fix OOB reads in rtw_get_wps_ie()
Message-ID: <2026070712-gift-curtly-5f96@gregkh>
References: <20260625202911.26782-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625202911.26782-1-mokshpanicker.7@gmail.com>

On Thu, Jun 25, 2026 at 08:29:11PM +0000, Moksh Panicker wrote:
> rtw_get_wps_ie() iterates over IE data from network frames without
> validating that the IE header and payload fit within the remaining
> buffer before reading them. Specifically:
> 
> - in_ie[cnt + 1] is read without checking cnt + 1 < in_len
> - memcmp(&in_ie[cnt + 2], ...) accesses cnt + 2 without bounds check
> - in_ie[cnt + 1] is used as length without verifying payload fits
> 
> Add bounds checks at the top of the loop body to break early if fewer
> than 2 bytes remain for the IE header, or if the declared payload
> extends past the end of the buffer. Also require at least 4 bytes of
> payload before comparing the WPS OUI.
> 
> Fixes: 554c0a3abf21 ("staging: rtl8723bs: add r8723bs driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

How was this issue found?  How was it tested?

thanks,

greg k-h
