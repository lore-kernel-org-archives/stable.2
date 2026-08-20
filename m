Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A1401A07
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223775; cv=none; b=leeKiUgRc6CzlgiyPrag6V5hyMPHtRLVXAAx89L3lXwU4681UtKlQjpkH3donQS+J7j06DdWQX2zUr6iaNn18CE7qmYPSOlmogVqHNWh0a+m431tZV1Ae3ysfeR3jlETF73GgNugrAKu4i5eK3TeLbDmlPtq8jDe9/+VfNUAUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223775; c=relaxed/simple;
	bh=gEwaIAtS/G77VsaBKawQRN539y9YvnrPwwtuJ7SGXA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Yw3XfR2BceSYTx6MDVzkhvC0kM9nZRMQZgSMLMwrC0dPzx7E2LTdgPXonplO1USJUexc51MHGmM/hdHNVhAN3hyh3wQSTsF/VA1DZ8LUQNSHCiiAh0q2rU5PNC2XeOqZs8JvdCM9Y1q/JpEgdxUEEtV4hyOVurTvmFe8ghajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JH0hWs9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JH0hWs9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C81F000E9;
	Thu, 20 Aug 2026 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787223774;
	bh=stf0y1z5yVO1FlxvdLzXsRqCuyG5VwrQNNecR3Zdheg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JH0hWs9k8E2vn/uhDW32mLjlhGvDboTBaGxU6T6Di7vH+uPTCeciEmlFZTymjzRHo
	 CFas2aGMSfAkoSyykT37gM6AdN4umehL6t+dejnStjNPdCSYKY1gOw4/l+w37l8i18
	 3xic+bbAPzA+Z9fdm52Im2t0JMvvuwrvIiSKAmkM=
Date: Thu, 20 Aug 2026 13:02:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: stable@vger.kernel.org, sashal@kernel.org, deller@gmx.de
Subject: Re: Please cherry-pick commit 81cc73be40c6 to stable
Message-ID: <2026082016-deviant-freedom-9205@gregkh>
References: <6a7c009c-8e26-455d-bbe1-1afc3381ed76@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7c009c-8e26-455d-bbe1-1afc3381ed76@stu.xidian.edu.cn>

On Thu, Aug 20, 2026 at 10:21:41AM +0800, Mingyu Wang wrote:
> Hi,
> 
> Could you please cherry-pick the following upstream commit into the
> active stable trees?
> 
> Commit: 81cc73be40c6f028f1ee3f438ace46afe666dbae
> Title: fbdev: core: Fix pointer desynchronization in fb_io_read()
> 
> It fixes a deterministic out-of-bounds (OOB) hardware read caused by
> a pointer desynchronization when copy_to_user() performs a partial
> copy. The commit has been merged upstream and contains the Cc: stable
> tag, but it seems to have missed the recent stable queues.

This just landed in a -rc kernel, please give us a chance to catch up
given that the load on stable kernels now has exploded.

It is now queued up.

thanks,

greg k-h
