Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE63E171F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249962; cv=none; b=hmYtUzwK7b/nL1hGTacmu3c092k4QoFYig3egI0TQcbz0AS6yQWRrZaOc9W7+/SE85ws8+kD/yEuUEDgP4WDiiH4A58oQ+l8f90Hwgk5V2idU7EPscuOJRnIYBEhpbO3A5bk4ypw0OzTt8rKMNqFDlW83c+c9f29xVZM76plKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249962; c=relaxed/simple;
	bh=2rgUav12Rj9lvJhtrsfA/UmwOZaNrAeAdtJ+A3GSaCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVGTfutSdO7ntxfSESc9HjGG77dBZyu4QCTKaSMPErpleXB6cR/aDxpPxXMoGplK2mIjj5Lwr6aoSKFq+9t870B1o98LZXaAcWeXs0doaXrghHZPR6rOIl8zgAM3ojSwgHoh4oLOGspzzu7j1s71uP8iMrmtukSh5YYdXemlhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aksgN5F2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aksgN5F2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F831F000E9;
	Fri, 12 Jun 2026 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781249958;
	bh=WbdSxAPr7LvFZGaMW88nAvqMlgGrpjatoEXO8sux2To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aksgN5F25pWWHrrDWL8v3Cl24ZXsqtba1+1WhhOtcsiBqIKuYPqTTrXBxO+kqX5tV
	 /4UUGgOA2UgfSAAbud9q9Dlw1u8+h2f3yQl2FbCbh37qHUlPdIgjopTfuP3ztpjgIr
	 DxfQO4Xl6TDuoKh1Ktnu941iUlU8zCTTXhx+J3v0=
Date: Fri, 12 Jun 2026 09:38:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Zhenpeng (Leo) Lin" <leo@depthfirst.com>
Cc: security@kernel.org, stable@vger.kernel.org,
	disclosures <disclosures@depthfirst.com>
Subject: Re: Exploitable reuseport cBPF UAF fixed in mainline but not
 backported to any stable/LTS
Message-ID: <2026061225-brisket-quickly-94b2@gregkh>
References: <CALPOzVk0gD2GnBjiPDQBfjsrf4b0hY3++KcOiaTV8gSFEifV6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALPOzVk0gD2GnBjiPDQBfjsrf4b0hY3++KcOiaTV8gSFEifV6g@mail.gmail.com>

On Thu, Jun 11, 2026 at 03:01:15PM -0700, Zhenpeng (Leo) Lin wrote:
> Hello Linux kernel security team,

You also sent this to a public mailing list for some reason...

> Fix
> ---
> - Mainline commit 18fc650ccd7f ("bpf: Free reuseport cBPF prog after
>   RCU grace period.", Kuniyuki Iwashima), first released in v7.1-rc3.
>   It defers the cBPF free with call_rcu().

That commit has been queued up already for the next round of stable
kernel releases.

Next time, if you wish to have a commit applied to older kernels, please
take a look at:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h
