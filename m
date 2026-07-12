Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC23911BD;
	Sun, 12 Jul 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846091; cv=none; b=nsRaYrT0gAb61A8VUUuv73fPAV/qIalny05Py53cENkYCg5cnhl2Q/o/06433OuXWW6VXnXPcWfUfX/tKHgf573t9yzqAg+BHuPVpHwwUlFdW06SJPnhh8bd2lzBveV5jNwMWrRSsks/wpJedjFVV/ieyRYx0oUvu0WMo21p4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846091; c=relaxed/simple;
	bh=ZkyjpDqrWdvfwMUcrfYmdLjQP5+16g0L/5qIe/eNu3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl1P6khT7qqS1OGHe5eDWMcKcT/9lAepWkRGKTlHP6l2NMR9Zb5MLHFDoj2GkzkqpzfxWOXCfg3BDFdXAujbbeLOGz2Wunxwt6X7w2PoxRrsgmxeZcN1n7GDUTvmii01+bJyNrlUiU632XqerQbYMWH8SEZrljCDox6BbGVqQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sPZGcGHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sPZGcGHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0381F000E9;
	Sun, 12 Jul 2026 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783846089;
	bh=93UkhWmVsF8wMaPVfNf6QBnSfb7Bv1GOC4C6bbohh4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sPZGcGHToM8ZZz5fvWlQiC7Gew6EPu0L6zHuBo37qS7W+nd7xhjvAR0KGdvH04/HQ
	 N/2U4ehvHvYR0Me7vn5UGlj2eO7kg4ZA5w36w5qRqdeYFnYljvL4yDM5fUx6CryQB/
	 SmyZ1rgl9HVXOaEOQP5X2S2mFAYyMRtW4MUSha+g=
Date: Sun, 12 Jul 2026 10:48:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Danyil Demchenko (student)" <DO.Demchenko@student.han.nl>
Cc: "jose.souza@intel.com" <jose.souza@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+
Message-ID: <2026071225-valium-carbon-5b62@gregkh>
References: <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>

On Sun, Jul 12, 2026 at 08:46:08AM +0000, Danyil Demchenko (student) wrote:
> TLDR: on kernels v6.12.x i915_gem_mmap_gtt_version() should return 4
> 
> Hi,
> 
> This patch shipped with v6.12.20 introduces GPU HANGs on Intel UHD Graphics 620 
> (8gen igpu)

What is the git id?  6.12.20 was released well over a year ago, are you
sure that something newer hasn't fixed this already?  What about looking
at 7.1.3?

thanks,

greg k-h
