Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA13655CA
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643069; cv=none; b=praW68ebb6+3uSiogbhMKR1oZ5nLzzzTKGlg4yGOw8IjutQfzGbKwIUMidPqeaOmYtZioE2xU4pRkgBM6CymHHQqzTAqi8/ymGSPsLhx1npATaJrR/NsDQApkTOSKT9KKq/3AeNmPXeq6sa9Ao+F1+JHUC+7hZ8I2y4cwi8mqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643069; c=relaxed/simple;
	bh=/t4L62O2lkJU6oAtlmXjZps7K7MJG7x/rP5d50KtcAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCBJBlzyHw56QDmF8Z2nJlghzAS3WbSfQqJPZfTHG0fJ8sDwtx+6+c6Moa61qACs9WqZQg8+ykTh/YJtxmksHoF1sSN5nqAWOURzAMk1rx9GNSiU5jGBFlGD0qlj1tA/xwkdvjxFIYChqlr7Yz/Cuhyo7N5RBUtbyI+2WNMyJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BgI3vLPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BgI3vLPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA831F000E9;
	Tue, 21 Jul 2026 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784643067;
	bh=XyHikuOC9nWaWKAn+NSw7iThf8fJrsQtOY4LnIXDoEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BgI3vLPfcqLuqUjcFzOrlOgvUJ09LZr9SUDs/PnEhLNJ5Ku1PHSP0gVwLEwYAz0xl
	 Eu7yW81ZOjJ0v03yoN513lVuN9EupR5lZMHoj5IK1n2L2+sR6PcIu2QzOl8z7IifmU
	 UelTrFsP1DoNqV6SHxaCQ+kjeQzB0lLpMm9Pyy5E=
Date: Tue, 21 Jul 2026 16:10:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Wongi Lee <qw3rtyp0@gmail.com>,
	Jungwoo Lee <jwlee2217@gmail.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: RFC: How to backport 920f893f735e ("posix-cpu-timers: Prevent
 UAF caused by non-leader exec() race") down to 5.15.y?
Message-ID: <2026072148-saggy-broken-3ee6@gregkh>
References: <alVfR78eqdaRbOIy@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alVfR78eqdaRbOIy@eldamar.lan>

On Mon, Jul 13, 2026 at 11:57:27PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> 920f893f735e ("posix-cpu-timers: Prevent UAF caused by non-leader
> exec() race") talks about a UAF, and the commit was CC'ed for stable.
> While checking it I noticed the commit though won't apply cleanly. I
> was thinking of needing to pick 6fdb2677a594 ("posix-timers: Expand
> timer_[re]arm() callbacks with a boolean return value") beforehand as
> preparatory change, and then 920f893f735e ("posix-cpu-timers: Prevent
> UAF caused by non-leader exec() race"). Would that be sound/sensible?
> 
> At least that would apply cleanly (though not yet even compile tested)
> to 7.1.y and 6.18.y but then already not anymore to 6.12.y, which will
> need more adjustments.
> 
> Thomas, would you intend to provide backports from you directly?
> 
> The two patches reflect this RFC.

These look sane, I've queued them up now, thanks!

greg k-h
