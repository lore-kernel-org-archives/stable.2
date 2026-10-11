Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D2396B70;
	Sun, 11 Oct 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726167; cv=none; b=GqiUXnDvzcItims9yWBR/FxdyTKSbKdquIY2EIe9Rkuq7SjuxTNRTWZI/gBA5f+AQy+8Tye+NgQHOd1vqODL/FUoeRgtzIWcoDZ5aftlWwJNi3PJs+mT4iaVphqE/EtnfgkqxK00drLpYMofdjc3niak2Hw7d6QX3FQz60nDH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726167; c=relaxed/simple;
	bh=WthbUo2hHOuuJv2c0Y1nz+IXc1NX39G4TY+LF1sdrHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGEvLSgG2HPSdcuiKcYSK0HLIGn1B5yrWnlwKmySyCwFtu6XXz6x6IYoDSkI0E9pe0WdhkpnQmY6G9priRU0AkguCn/EjNNJSekYFdEJNIH1c4YcBRrK6y1XcQUyUwuqRLx62H0cnmF2jtVblRUuugeh4hvqPbZsXBDP0uTrUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390321F0089B;
	Sun, 11 Oct 2026 13:42:45 +0000 (UTC)
Date: Sun, 11 Oct 2026 15:42:43 +0200
From: Greg KH <greg@kroah.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org,
	Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] USB: serial: sierra: fix urb leak on write completion
Message-ID: <2026101134-alkaline-qualify-61da@gregkh>
References: <20261009123359.465071-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009123359.465071-1-johan@kernel.org>

On Fri, Oct 09, 2026 at 02:33:59PM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken by usb_anchor_urb() also on
> successful submission of delayed write URBs during runtime resume to
> prevent them from leaking on completion.
> 
> Fixes: e6929a9020ac ("USB: support for autosuspend in sierra while online")
> Reported-by: Wentao Liang <vulab@iscas.ac.cn>
> Link: https://lore.kernel.org/20260916165352.2085480-1-vulab@iscas.ac.cn
> Cc: stable@vger.kernel.org	# 2.6.32
> Cc: Oliver Neukum <oliver@neukum.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
