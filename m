Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E4442FAD;
	Thu, 17 Sep 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635668; cv=none; b=uL6uvtevCeuSEHx5xRxyHXdkHEgWLgbegHgc4a6jqp8SnlPMZsM+bwhRHH6kIe0kTUnzciXNQtP/yM0lHHdn3iADbIYb4HMREkA4ov/qw61wfovvuVkfZNgqpn0ejxrXoGotY9HghcJlS6VqWlhuDqnCDUVO0Di6z2w3pzEFK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635668; c=relaxed/simple;
	bh=UzG5I5JZfuswv1igyFVwrCu63bFTmfmuzS+4wGcU1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPPFMAzFuqJ+lXd5xphcxMTgrrepDG4thwh8eR5LHov7ctfZLkmWaugH37Fkl4yaPZsjMZh2N6jgQ2BHMQrRTaoiPb7GSKkSWDfxinDjhaIJaXJJoPc42BV1TuWlHbf1ZNnzvrjp3NW3pZ2ybXGv+c6/g+WXlPWOMe+sE1vJmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChuM2QjG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChuM2QjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DE21F000FF;
	Thu, 17 Sep 2026 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789635656;
	bh=ol5sJv8Hdw8HlU2JP5qiBfKt4etnRP9G6Nu/I0ez9QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ChuM2QjGDVc1iSouzIxSl6HT9Ciz25v0CHFGSP3Rk85zEDyYl1afAWtM4EPGNUCuo
	 dLhVRGMhg08KQocAZL+ddbkaRtZj45AFSTJeo4W1ZbX5RmrtpGSlnAHVT3lIjxHwVn
	 HuC72Z01HEf4+i6jHcmIUnYNG4hXom0dM2r8qDT2J/0myU6zeJJeXYKu+CGNAP3jpd
	 usQxHjyUQ2WHquus8n2hXSdLHF6uQ7vWamKqwuiei7pp4aAyN1WD2Y0n+aNn1HW/4T
	 MVNTl+ZXPd12FG+z0SqV1jRpMZujm2Gw0Y/WBnCVutwhI2vJ4H8VbE21j0R91MpvLN
	 bx3NGjkWQMxIw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x77zC-00000006PxB-03uT;
	Thu, 17 Sep 2026 11:00:54 +0200
Date: Thu, 17 Sep 2026 11:00:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, oliver@neukum.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: sierra: Fix urb leak in sierra_submit_delayed_urbs()
Message-ID: <aqusRqksylvOi1UK@hovoldconsulting.com>
References: <20260916165352.2085480-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916165352.2085480-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 04:53:52PM +0000, Wentao Liang wrote:
> sierra_submit_delayed_urbs() takes a reference to each delayed urb
> with usb_get_from_anchor() before submitting it. The submit failure
> path releases the reference with usb_free_urb(), but on the success
> path the reference is never dropped: the urb is only anchored in the
> active list and the USB core unanchors it on completion, leaving the
> reference returned by usb_get_from_anchor() dangling so the urb
> object is never freed.
> 
> Drop the reference with usb_put_urb() after a successful submission,
> matching the reference handling in sierra_write() and the sierra_close()
> drain loop. Skip the rest of the loop body with continue on the error
> path, which already frees the urb.
> 
> Fixes: e6929a9020ac ("USB: support for autosuspend in sierra while online")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

This looks correct, but as Greg already asked you elsewhere, did you
forget to add an Assisted-by tag here as well? How was this issue found
and fixed?

Also, you need to start replying to feedback. According to the list
archives you have haven't replied to any of the four mails commenting on
your patches that I've sent you so far.

Johan
