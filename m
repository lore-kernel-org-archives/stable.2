Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9F2D7398;
	Fri, 21 Aug 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325549; cv=none; b=uCEcMebmcRI47IzuftyV8ep1Di20FU9rvcI9q4yGC/XA7Rq11i164pr/cCppTHegNqJIzVG7VW3O9rB7gI5waKABAKki1AcmMZEJCtQotV6ICGYmPTFlmlsnUTkqPxTSb345bn/1qtRrxbTcIRevT0aqJobCRzpHNK0ZD7Rb3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325549; c=relaxed/simple;
	bh=E3Rwjvw7g1nO61izb2mt5xQsxkEgH60UFktpJZImOnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfUfW4RNYk+bf6GenmUx7+iMmoYOOA8wfgV73BuASKidv/EHWGTH9KfB9Zcdjgkt5KV3uAD4K3U/Zi36ZNvy7mr2A3m2IEUAZPxqztVSb3fgQkYQbyBANT9VlBQqFbBCAdny3dVz8cA2TQIQJwCmjJkgDcyp3zPUQ80484pjuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lSMf3q6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lSMf3q6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEBD1F000E9;
	Fri, 21 Aug 2026 15:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787325548;
	bh=bfrXkGCXq7n0RPlebNTIuLeRaHZj4JieCGVh3d/AQ10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lSMf3q6uhd71x2D8nU4Y1uL2OzVh171PE2Tes8DDLNpWUcHpcu+Wk2Tw8kC07tz+1
	 FCLHF/REDFwZ7iWPcQfjbC1OJdZrx/GZN//FgZUJQciQ0IntF7xubNbDYrTxJiUoV+
	 znYcVGau8oaQZvRPpAxN/moqSkak+2PQipSa+/8s=
Date: Fri, 21 Aug 2026 17:19:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mika.westerberg@linux.intel.com,
	stable@vger.kernel.org,
	syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com,
	syzbot+520d7648a0d934061fb0@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: typec: fix null-pointer-dereference in
 wcove_typec_probe()
Message-ID: <2026082137-obscurity-french-4a2f@gregkh>
References: <2026082125-getting-upstroke-a146@gregkh>
 <20260821151107.19945-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821151107.19945-1-jeffinphilip14@gmail.com>

On Fri, Aug 21, 2026 at 08:41:07PM +0530, Jeffin Philip wrote:
> On Fri, 21 Aug 2026 17:00:12 +0200, Greg KH wrote:
> >How can a platform device NOT have a parent device?  WHat system is this
> >broken in?  Why not fix the platform definition properly instead as
> >something is really wrong here if this is a "root" platform device as
> >that should never happen.
> 
> As seen in the Closes: tag, this is a syzbot issue. It used driver_override()
> to bind it in an unnatural way. So, I don't think it is possible in a real system.
> We could atleast validate pmic like other functions using dev_get_drvdata() or it
> could be left alone as is.

If you call bind on a device, you have to know what you are doing, as it
can easily crash as you see here.  Just fix syzbot please.
