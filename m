Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4C44C648;
	Fri,  9 Oct 2026 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549671; cv=none; b=nLnw9EA/tHaADje8ihlTjfbRbMd4S6jMT7mRfGytdSb0qgG59C0n8TY+PB390KGOZii0MB6lYXC3EHKwDEphxfXB2wWEOMyjMWWLIokzbBCokazcq3NJLk3AL30Escbqh1tmqs8dYotPq9k/ZMmFw90Eb7lizLKbkzR+69Mx1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549671; c=relaxed/simple;
	bh=UHVrq+I+KSBEzMAH/uApO9fqsh4KPkEjTlaFZB3w9g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx4+iRLw2or4Pcvcgf9iaDvb3W8JFMW5iL7GvfHIzpdPViypcp4MmapvHXBlhScdjQIvFGmmkHASYDhdQDjdIxKGixKi6aJZRtzOAix6f4KlFVIEF7KF8GaM7wC66qzhKML1bMHorDFNg1iyLxif3UTjD/Jk0zDp0T94HIdBPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBUDQDYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBUDQDYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F1F1F00893;
	Fri,  9 Oct 2026 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549662;
	bh=Psgr4KXFcCz+KML8rnciIALqUxR0nVRxU2EGq3dHPxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PBUDQDYI9DZ9QuVtpi02ucFDiTS/4syhaJgXXj5FOhbqP5/XgzzpC7281Brap8vgK
	 Z3oox3lSpkuuhGycvBNgwNhsG17a8+lD4PmmnmRcjy2Y9MOGSml+z55/8vf1H14U7m
	 40+DAo4KG4vftW9W4mkM/Tp8539Ftm33gMvCvzQb/P3WgwJFFNwyhom36V9Cve3Waq
	 yg7p/g39aqQz0KG8fZxo8oyi/d0/i6q13zFoGGCK8AAXmhWplDtMr+eiZWSuShHpl0
	 gfr0H3j9r0mxtX81KJSK0bFWq6iGUEpZYjPSbnHIXEg7NHVjONFILuMtjqofQW+rqD
	 aP9Xjv8BteIhA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xF9uF-00000001x62-3tga;
	Fri, 09 Oct 2026 14:40:59 +0200
Date: Fri, 9 Oct 2026 14:40:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, oliver@neukum.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: sierra: Fix urb leak in sierra_submit_delayed_urbs()
Message-ID: <asjg2_2pB0dOflW_@hovoldconsulting.com>
References: <20260916165352.2085480-1-vulab@iscas.ac.cn>
 <aqusRqksylvOi1UK@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqusRqksylvOi1UK@hovoldconsulting.com>

On Thu, Sep 17, 2026 at 11:00:54AM +0200, Johan Hovold wrote:
> On Wed, Sep 16, 2026 at 04:53:52PM +0000, Wentao Liang wrote:
> > sierra_submit_delayed_urbs() takes a reference to each delayed urb
> > with usb_get_from_anchor() before submitting it. The submit failure
> > path releases the reference with usb_free_urb(), but on the success
> > path the reference is never dropped: the urb is only anchored in the
> > active list and the USB core unanchors it on completion, leaving the
> > reference returned by usb_get_from_anchor() dangling so the urb
> > object is never freed.
> > 
> > Drop the reference with usb_put_urb() after a successful submission,
> > matching the reference handling in sierra_write() and the sierra_close()
> > drain loop. Skip the rest of the loop body with continue on the error
> > path, which already frees the urb.
> > 
> > Fixes: e6929a9020ac ("USB: support for autosuspend in sierra while online")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> This looks correct, but as Greg already asked you elsewhere, did you
> forget to add an Assisted-by tag here as well? How was this issue found
> and fixed?
> 
> Also, you need to start replying to feedback. According to the list
> archives you have haven't replied to any of the four mails commenting on
> your patches that I've sent you so far.

You still haven't replied to anything I've ever sent you so I'm gonna
start treating you like a bot.

I've fixed up the USB serial and cdc-acm leaks you reported and given
you credit for reporting them.

Johan
