Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0437F30E;
	Fri, 24 Jul 2026 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784871924; cv=none; b=PbR013u0nOAXjrDGMWQQcmQeANmD/5bfKeTLnIMz647zLJ3p2W6dDKVluGcWAWdElO+e/VC2pQZb9l3uLos4UfPkOnLaN1FAwb+IeoIZU7DDqbDpU3eT2OJgZr5rhsiStfE/oUBtCvf8cePPTGBcsLUW6y2fOpvVLWlc2IJ4IoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784871924; c=relaxed/simple;
	bh=VWQuvLUdHnUIfFjVkDwwmhiDSfBGhOCh4XfiLpnOWug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am7Xd0ET20s2EjcxgWd+5iLSoxqyUcwCEy3qUyqS4Sd3FdfMO1Fb1ORJ8CkQ+/w8txUjUAyp+pDArClREwBiZeS53ylEky8lmsvDzzGTMu6lRNmSlEeggfzRIbmb67DnXvB8i/2sAG3U49gYSaI4MZdzdMWInxCTA0v7f+fU470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxceDsOK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxceDsOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8600D1F000E9;
	Fri, 24 Jul 2026 05:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784871923;
	bh=9W49wCiUtUsxSZl3vgQVxAfrXzgxmvwrpLdrp3Zt1J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cxceDsOKvwI+KOD5GiGUyJIvCuB0g8VNLxYy5xTgNTD8cSublsT0fKIX9sJIyrTeI
	 2v49Ohew/D+eB5nRE4lZtBEpS1+QZ+ZTuQFPn92IgB5t09WmWs9GPNRGK/+vQtab5h
	 3JMLEF4df7tc4WRuxaWzbCTYhdKGcvuLjJ/Tvg2U=
Date: Fri, 24 Jul 2026 07:45:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: sashal@kernel.org, 3chas3@gmail.com, stable@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [RFC PATCH 6.6.y] atm: he: kill tasklet before releasing queues
Message-ID: <2026072445-delicious-uncrushed-b854@gregkh>
References: <20260724052710.1126-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724052710.1126-1-getshell@seu.edu.cn>

On Fri, Jul 24, 2026 at 01:27:10PM +0800, Hongyan Xu wrote:
> The interrupt handler schedules a tasklet which accesses the device queues.
> tasklet_disable() waits for a running instance, but leaves a scheduled
> instance pending while he_stop() releases those queues and the device.
> 
> After masking device interrupts, unregister the IRQ so the handler can no
> longer schedule the tasklet, then kill the tasklet before releasing any of
> its data.
> 
> The affected driver was removed upstream by commit 6deb53595092 ("net:
> remove unused ATM protocols and legacy ATM device drivers").  This change
> is intended for maintained stable kernels which still carry the driver.

Why don't we just delete the driver instead as obviously no one uses
this.  Unless you have the hardware to test these changes?

thanks,

greg k-h
