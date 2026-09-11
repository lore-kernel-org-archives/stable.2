Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A9443C1D;
	Fri, 11 Sep 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142942; cv=none; b=EpOwIhAPRIkEA/V6Btd7AIxADPpc7cTXWrOJjDWIy3qIPEZuLl/UVeZZohJGnm+DYuIbQ5PYJKIJpfmU7/t4eTK/zisYMeUWjvM1PSRG8DJYl4tdBGYVxRuDDXXKw9ZOae4wAzDjpBWLXS4J4DjfYHJcwk7c89Mx7uP1RFoVGXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142942; c=relaxed/simple;
	bh=l7ZwQIXRs1wTsJ/AMhiYTm/LIe7A8SJn7O1pJPPm3Lg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZyvG2WG5foW+AgN0fDFtUhH6JtjWiyvgNn5K697OomEOaXqivJPy2cUbmXYJ6aC0TuoK8ZdPMtcfbgHpyOBEm/Hkj/2dc6H/wWxfKC6GlYEl/LhfW+kCezR8+aV6xMTWUmCa/5JQ4fI5KY/aNth7xd/R1ZRG1JIzHIlEykDlSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpsq8+aM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpsq8+aM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1741F000FF;
	Fri, 11 Sep 2026 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789142941;
	bh=AyOi5k+tnPsKor/4teUNFhqKXR8sSQM6O7+rNxOGpMM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Kpsq8+aMw7Bzzz0BdJZu/7nGJJC6IkIy1OrVTmU5IfAMv5Ta2E70dHX0CGIiBIvCT
	 +2sxcK0Km9u+WMAtESJL7a6pXlTi2TgQft/hgtrLSUB//hygBZgpAI3cAu4DeUd2af
	 s7YZny3XegZDHJnWBAb5J7zEnWwGSGaaAn6tAIEwAt8zHbYnNkdCagljx/GR6S9c/z
	 jVNlBIpvoFMc6IjnMPmPaWU2pWlroM15KG32GjEvIrAw5SewU5Ag8LPtkEEP5Nntcw
	 bqRvFq2dll6TLKUocR6noQ2yeLpsyC/HB2JfxweqdsyYHxW29iW/4M5uoQqO3leRRf
	 BxOGm7+eX4rjw==
Date: Fri, 11 Sep 2026 18:08:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: HyeongJun An <sammiee5311@gmail.com>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: intel-thc-hid: intel-quickspi: two DMA buffer
 overflows
In-Reply-To: <20260820111558.475304-1-sammiee5311@gmail.com>
Message-ID: <43o49041-0nr0-2298-s10r-032r566s3ps7@xreary.bet>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 20 Aug 2026, HyeongJun An wrote:

> Two heap overflows on the QuickSPI receive path, both from a controller
> that declares one length and sends another.
> 
> The first is the DMA landing buffer, sized from the device descriptor while
> the THC DMA rounds its packet size up to 4K.  The second is the GET REPORT
> response, whose length is checked against what the DMA delivered and never
> against report_buf.  Each has a sibling in-tree that already gets it right,
> named in the patch.
> 
> Neither was reproduced on hardware.  Both turned up while working on
> commit 035ec4a71cb8 ("HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
> response to the caller buffer"), which covers neither.
> 
> A fuller fix for the first would give thc_rxdma_read() a capacity argument,
> but that changes a shared API and touches intel-quicki2c, so this keeps to
> the driver.
> 
> HyeongJun An (2):
>   HID: intel-thc-hid: intel-quickspi: size the input buffer for the DMA
>   HID: intel-thc-hid: intel-quickspi: bound the GET REPORT response to
>     report_buf

Even Xu, can you please review this? Thanks,

-- 
Jiri Kosina
SUSE Labs

