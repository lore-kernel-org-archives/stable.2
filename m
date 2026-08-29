Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDBC3F107A
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787996930; cv=none; b=b3Bf17qnpzohys8dNKTSW0/ecVe5lP1jGVVOuZzdcM+x8LyyeczYuamsX191KTZw4Kjxxs7CNCgulZX+CrOdI1tE1t0ZYRtImKswPEhVKqMQVtPoQkX4H9v9mR+tyQQ6WoJohtwU3soqIACOd78R8JYL4+qZJthfoRRwqTdb6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787996930; c=relaxed/simple;
	bh=sJE1Lu+VkII/oeATMJcgxTonbFJZG5j/XJ1HnoRrxQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQO2D4fgxEMVIKlLsImDpzVEIJMquCJv5PNag6lQsHZg2/QjgfR8WfUCg+oHkqtY9AGaQtYvMcU0PISPF7eoWe2+V35fZucPfgfTsVaDzl5oy3FnLE+f8sgal9z5D8h5csknFJX8TuKKIZu8NzloJXwC8EaMGZix93UB0i6B/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vhKnwaHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vhKnwaHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12421F000E9;
	Sat, 29 Aug 2026 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787996929;
	bh=ndqW6K6z2YX/z4AMr5X/caw2mdo6ukEQCF5lYolDrsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vhKnwaHN2/3c6B7T/eX8KblmI0YukeYdgJd2YcSVi1LGWamO/8HwzAfVSUCn2YF1z
	 ejc5OOf38fxorJ817sb6jIAqOez39pX2k5fAqxzb1SVAgULZDG/+RjQr8/mlg3MvlE
	 pYgxutEls8YfJd23ehB3SzB7o6g8/KuQAnktkmzg=
Date: Sat, 29 Aug 2026 11:47:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: Stable backport AI reviews question
Message-ID: <2026082947-grandkid-landfill-6df7@gregkh>
References: <ab4f47f6-9232-4ff8-83f8-ec96e7e19e14@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab4f47f6-9232-4ff8-83f8-ec96e7e19e14@oracle.com>

On Sat, Aug 29, 2026 at 02:22:44AM +0530, Harshit Mogalapalli wrote:
> Hi Greg, and Sasha,
> 
> I hope you are doing well.
> 
> I have been doing some AI assisted review for stable backports. Few examples
> are available here:
> https://lore.kernel.org/all/?q=f%3AHarshit+AI-assisted
> 
> Sometimes I am unable to complete a review within the 48-hour review window
> of rc cycle. Would it still be useful to report any problems I find after
> the stable release candidate has been published?

Sure, it's great to report issues, and even better to submit fixes for
them if it's after releases have happened :)

thanks,

greg k-h
