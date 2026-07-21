Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543A36A373;
	Tue, 21 Jul 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640869; cv=none; b=J8SagCAmf9PiX0HwZXfTJQld9eiE0vF8eQug9By/Mx+QZQVRXGoYBe1WDOhCN+UfM8wPyGSei3DoDEllISUiBAHQUhKSTb1syl7H9ZCZUmCeyiEWpHDov7dkgQZiFva0ZkyN9Wh4PZgzJVZIjdLxK3ePvytHydxlk15P8djR5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640869; c=relaxed/simple;
	bh=yn6ZVZakS9dT+WonSQ4Mr3vwPTG5zimkBUg+261UX1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXboiasLt1WHn96ijVuXgrU/GN5uedbWnJGBaAMby6+Lzfp/o0EtnSfqCekxBUA+DyoMjsZnFFIsFR1vYMfXqIWhnxtcRhirjlPbW9ATv7eOxOZ4mxTfrCmUj0POsoeNv36uRmoPN5cLcCqILQbX1wzlO6D/19By2QTRfKoqt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON2CUQfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON2CUQfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628C01F000E9;
	Tue, 21 Jul 2026 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640868;
	bh=qbHrnIJvxngU/b3awjLCuG5dJU6CVhL3c6TMaGdlO/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ON2CUQfHFLwQzMMIsGrjKGIkRLnbxc0UBUQmSGS5j7nzzLgRmjAxCCa+ieefqwKdm
	 FSiCCK4vNA9i7Mzsnb9/3PUGef8YCtJ7Xz/fiwKID36Nf2ux0HtjFfgM61g+MIwdEZ
	 d1KO6ea0eGU5IFEgegMpyistgO6aFru+dxFuusg0EUgCDmp8swfuQrfAYDrtJNqvih
	 qIY1nIW/2+eDyHxLLO+m0uNg4G1WqJAyaFNFas22BJDLcqCvVPy+upd70O4fqNg7nH
	 ZbyiLQRKdLZ3bvnuijD/XBJH5k0v8LyGLGiXSKvrw3IuwGrCUdrEoT/gxAQtCcZCEG
	 IEitOPNn71xMg==
Date: Tue, 21 Jul 2026 14:34:24 +0100
From: Simon Horman <horms@kernel.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: netdev@vger.kernel.org, ap420073@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] amt: fix use-after-free in AMT delayed works
Message-ID: <20260721133424.GJ19108@horms.kernel.org>
References: <20260714072705.129262-1-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714072705.129262-1-shlomojune6@gmail.com>

On Tue, Jul 14, 2026 at 03:27:05PM +0800, Shihuang Liu wrote:
> When an AMT device is removed, pending delayed works can still access
> the freed amt_dev structure, which may result in kernel crashes or
> memory corruption.
> 
> amt_dev_stop() cancels req_wq and discovery_wq with
> cancel_delayed_work_sync(), but these works can be scheduled again
> from event_wq after the cancellation. This allows delayed works to
> access the freed amt_dev structure after the netdev has been released.
> 
> The following is a simple race scenario:
> 
> CPU0                         CPU1
> 
> amt_dev_stop()
> cancel_delayed_work_sync()
>                              amt_event_work()
>                              mod_delayed_work(req_wq)
> free netdev
>                              req_wq accesses freed amt_dev
> 
> Use disable_delayed_work_sync() in amt_dev_stop() to prevent req_wq and
> discovery_wq from being queued again and wait for running work items
> to complete.
> 
> The delayed works are disabled after initialization in
> amt_newlink() and enabled only when the device is successfully opened.
> This keeps the delayed work lifecycle synchronized with the lifetime
> of the AMT device.
> 
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>

...

This patch seems fine to me, however, as it was not marked as
being for net our CI tried to apply it to net-next, which failed
due to a conflict there.

Please consider resubmitting with the patch targeted at the net tree like
this:

Subject: [PATCH REPOST net] ...

Feel free to include:

Reviewed-by: Simon Horman <horms@kernel.org>

Thanks!

-- 
pw-bot: changes-requested
