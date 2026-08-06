Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8D25A2DD;
	Thu,  6 Aug 2026 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785995039; cv=none; b=PhrIhhtlO8I29ZvC6F3TyMYIA16j2MoJoCIiSRmLgYs2VUt9i4wlOFMsXyYrgIGvHUi2jYoStjynkXNTjzdwsHg8bLXtf6TOT+THSMsqk1xwKLUrxUAczxO+jPhDmztjxnOdz9O/J+3svNIhufo79bkY73OniyprjJPz1cm9cCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785995039; c=relaxed/simple;
	bh=LOkxHs0oHmQ7c25/XT+lGBhrqHp+8i9RX3l6/QTv11w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOxsWHNv/b/KbQLtccMZRlbbWK7jA5r9eCjZJR5+PtJF+TG2vm/dfptAA7wijr5Y+lNpOQ+7NRsnjemNiDxKqLNB8K+O3FlXz7Z3+wZCa2yzy1/n1opmU9LTjR2Wz/yUoE/CJk1pFhAKkhWRCT4NBiPlydUDoRzSGmIxIXsJ6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q5lhR2gi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q5lhR2gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574E21F000E9;
	Thu,  6 Aug 2026 05:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785995037;
	bh=GybSwW/YXst5XBs/iAHScf7Hy6mCu4C4BngcbbU/NZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=q5lhR2gie4PWYYR84SXCwikjQAw/z33kF0GEA9labB00DuM7yUkkG39d82tc/1+cc
	 tS090JZW58E07+YdO+stPVW5CkMVzcGGB4y/4cUaYMknbFgzGOV6Uoo3y74PNUPIaY
	 RVgVAfTAcl2RS9x3N8fvi5u2W+RiGM+zuHrLN0kY=
Date: Thu, 6 Aug 2026 07:42:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: i@zenithal.me, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	shuah@kernel.org, stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH] usbip: usbip_host: Fix null pointer dereference in
 rebind_store
Message-ID: <2026080645-nickname-undated-d0bb@gregkh>
References: <2026080602-estrogen-dry-f499@gregkh>
 <20260806053651.25088-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806053651.25088-1-jeffinphilip14@gmail.com>

On Thu, Aug 06, 2026 at 11:06:51AM +0530, Jeffin Philip wrote:
> On Thu, Aug 06 2026, Greg KH wrote:
> >What prevents bid->udev from becoming NULL right after you checked this?
> We could use usb_get_dev() and hold a reference to udev when the busid_lock
> is being held and then release it after do_rebind, or would that be incorrect?

I do not know, try it and see!

> >How was this tested?
> The method to reproduce it is in the same thread.

How is this just now an issue?  What changed to cause it to suddenly
start happening, or has this codepath never been tested?

thanks,

greg k-h
