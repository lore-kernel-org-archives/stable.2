Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAE830E85B;
	Thu,  3 Sep 2026 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410486; cv=none; b=KR8R6A6m5oDeSm14J8MNVTx4nE86F+irnt4cEFB4xUHROA6UZJuX/i+igmCciV0c6tzNL277ozewvVp2So5mxiKE/XegFi6H2nz/hNVGv6onNh8ZFBQ97Zz3X6zllv3h0RgIvRBDFYdyp1u5XGEc9BME8zONvrjy9Zt7nC3lQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410486; c=relaxed/simple;
	bh=xgVHrufOoHG8lpUoZyUp4rVPlDde/1OpZuCtLyKtK24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPbzLylLIlPGsvmQuaLL3umR7qc7FecGIQnpQKA2yTHN7dpqO4B2oUKap6XCwlaB6F2NNY7ByzV3tfo4jSPCOj5B9Pg99GP+u7zWZtRNn9qmXT5K875HssNbqjttZCVlwr4YXjpW7Pq2ZJe3798i3nlK9vbmwoDxHm84NSRGW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ucJVBwBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ucJVBwBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E96C1F000E9;
	Thu,  3 Sep 2026 04:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788410484;
	bh=xgVHrufOoHG8lpUoZyUp4rVPlDde/1OpZuCtLyKtK24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ucJVBwBsE8l/qVyxMK4dxUDpHZyYBWQMKl2C7EX7NxAjiPdOWPUWKRX12suoDOf2T
	 tSRgCIDl+rFAwUant+zRgMyZwp7c2xuIigBnnZqhfXnkLAMZiv/ozd14s2TbEvhzcy
	 KjItYqv/6YC20OyxgwkgWtX/aniKU8fIyl9U0M2Q=
Date: Thu, 3 Sep 2026 06:39:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yudi Yang <2000jedi@gmail.com>
Cc: vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
	elder@kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio_codec: fix stack overflow in
 stream name parsing
Message-ID: <2026090352-remission-amusement-d8cd@gregkh>
References: <20260901185600.2725678-1-2000jedi@gmail.com>
 <2026090219-democracy-chip-87fd@gregkh>
 <CAN3V2YU0a7Mj_Sdv5VLLO6AOCbTYXJZkRwfKKyZtB-yPb5COOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN3V2YU0a7Mj_Sdv5VLLO6AOCbTYXJZkRwfKKyZtB-yPb5COOw@mail.gmail.com>

On Wed, Sep 02, 2026 at 10:17:00AM -0500, Yudi Yang wrote:
> I found this with an internal program-analysis tool that I cannot disclose
> yet, then manually verified the finding. intf_name and dir are 32-byte
> arrays, while the unbounded %s conversions allow tokens from w->sname
> longer than 31 characters to overflow them. Using %31s limits each
> conversion to 31 characters.

Please read our documentation which describes how you need to identify
when you use tools like this.

> I do not have Greybus hardware, so testing was limited to building the
> affected object and running checkpatch.pl

That's not really testing the code :(

Please resubmit based on the documentation requirements.

thanks,

greg k-h
