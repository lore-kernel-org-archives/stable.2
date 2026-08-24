Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C413EA97A;
	Mon, 24 Aug 2026 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564303; cv=none; b=SKUuzaY0ZZ7Qo+ZnOOP5SE495xOIo4YcrV7SqeadW8bt7vdj71ythy/7u0oDiNskTrVsnyOF/Cv0XxG8bD2/sbcTO45penEPrrcr/bveriKgCi2YuhFIQN2MEJCoWBYGohJQK9/F7ti4x9tMJ9Kpe+u4XBvqOV8RHFSd5AjvPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564303; c=relaxed/simple;
	bh=9ZX9lErtm1dnL8LYPDEHzMJJTBB7cYtGKgCB+2huD98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3YsfQkdRV3YGo+zkTz/ciaPVeJaK4KhsOvPcT3T9xTgq+jJbYN+aB9AEyV4FzXDV5MckMvPXpJakb6wT9u28FOe2+x5rHIccI6PU+jo/iu76ZDXHZaVyAe3V9bPTWbrnQJHnxIiBJfZmSF5ZvKpx0yd/vm4MeBPekM1T+jdN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sNLETQHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sNLETQHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A4D1F000E9;
	Mon, 24 Aug 2026 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787564301;
	bh=whRaf89LfdoLj802Q5NG9+203DhxvWBYpS03UuIROgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sNLETQHxs5rq73ZTYMq5ETvx6QFp/0+Z80nNeoLnteWkdMS7Mpi7tRUbD7/WZBRDn
	 4l/WRipDus+wsYK/fYXb4XXGYFFE5zvsQLzxeIYIE88CpbTS1mUURYkIAJRPJThA+Q
	 Mbo2OKAqzVJ+6YdcyLgNLeluIVZOVcUaRm8IFWK4=
Date: Mon, 24 Aug 2026 11:38:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Dynetrex, Admin" <admin@dynetrex.com>
Cc: PS10 PETER HONG =?utf-8?B?5rSq57m85r6k?= <peter_hong@fintek.com.tw>,
	mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <2026082401-letdown-fervor-ed79@gregkh>
References: <20260824082758.9118-1-peter_hong@fintek.com.tw>
 <2026082433-dynamic-overspend-8f32@gregkh>
 <597D8628-7241-47FA-B692-FEB66360EF3D@dynetrex.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597D8628-7241-47FA-B692-FEB66360EF3D@dynetrex.com>

On Mon, Aug 24, 2026 at 02:14:26AM -0700, Dynetrex, Admin wrote:
> Hey Greg, 
> 
> This issue was reported by me about a month and a half ago, however, I did not have an environment setup for kernel development in order to submit a patch.

Great, a reported-by: line would be great to have added here to capture
that.

thanks,

greg k-h
