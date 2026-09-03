Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758944CC260;
	Thu,  3 Sep 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448723; cv=none; b=SbpHMDVKEBY03aqnlhNZ03JZBEk4lmXbeWGEEpMC0es1j//l6LRSSw8czOcFYw8ewxqVzbZdry6n1NZO7GvIS5Dy1hUDPGgaezD2uzg4wBtjGXCnsVhCnbJfOUxwkOgZqVoTbmq31FakcSMcz/gIvQ4Ku/mrMKNlCxPGD+2lEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448723; c=relaxed/simple;
	bh=HKqlLttVIwUrLyzTvvPELvHWUyhfDdplC1frc32mtlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niG+tKnNtEPcZiwUv/rooXQbCL0S6/wQgC68dVOJmdD0248sbF5pppAq7Swn+a8Jlkx1Qkj+pQryiDuTIQWt6pNb4HlUoTMPSLSe96/52Ey2S0gmk8ouqS2DvAuvOzSE7c2Or1QRmzWUD8KYh1oh3JQ4r4e67AyenGpa1of+fFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf8Si0G7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf8Si0G7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AB61F00A3A;
	Thu,  3 Sep 2026 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448722;
	bh=HKqlLttVIwUrLyzTvvPELvHWUyhfDdplC1frc32mtlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qf8Si0G76ZvPOHS7O9XLo1nNJZCQ0CwUIYbtbfJBxWBV6cHJgotmPlN/0gV2DeWlg
	 ORNL0Iy8ZBpTR/nqjAqVJzX6SQHMKst4ThlSelIrmas3ii1mKl5bOOaMCq4uiUhjfb
	 ySyJz3AiCnBa0d9b7TURRFmDlp3FvGXcv25gtB2dRRmpbMAI4JOjnkU+3itTuFGMVA
	 ampEU0FrsCyGGOen7ZrOy7BBcVtnVH3AvjBWBR5DkQzfvNy4tzzit/c96sdwGjpH8V
	 BNhcSlZmfOlWneb80PbdyEShtLOHGOTzU9b32cqhTY7k0GrPA9BY6wbDSdppTFOmjX
	 gdHINj0sYYzyg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x29D5-00000006E8e-3I7q;
	Thu, 03 Sep 2026 17:18:39 +0200
Date: Thu, 3 Sep 2026 17:18:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EG060W
Message-ID: <apmPz_kVylw1NJSf@hovoldconsulting.com>
References: <20260812104228.802711-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812104228.802711-1-github@szelinsky.de>

On Wed, Aug 12, 2026 at 01:42:28PM +0300, Carlo Szelinsky wrote:
> Add Quectel EG060W with product ID 0x6004.
> The three vendor-specific interfaces are DIAG, NMEA and AT; the CDC-NCM
> data interfaces are handled by the cdc_ncm driver.

> Cc: stable@vger.kernel.org
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Now applied, thanks.

Johan
