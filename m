Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183131;
	b=uecIlyJI3MRutt7jhfK0CDF/oXkDzSLvaKMW/WGIAiJEgmsVdzMMWp4s0TfOdla4IW3t
	 bSFu9XihNqsEFq6xJwOKw4s6+3xu0vozHTtGUnokcDap0mRQG1hQoU53Hfji5BVVrgcih
	 0HqiuZiqdDDxHm5scXScQwrvV0Vb244NHWvTW0VvHX7zfFxS9OI6gJEDnmPdN6uHAej+Q
	 rsHLNamlxr/JuOk2dTaBTShXeLc5R4UTinMl51eU2Vp9GKD70sybgLCxIbRV9YeYB2ZmC
	 EgB4gS3SzlBQYfJZmn0U15wV4nIzCMSoR4LRbj2xD+qzm6KtVi32r+hs226EKKKUHlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183131;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nNheUa0aYoRrQSBs16Ly36vY+3Ibo/k8RtKCduo70eg=;
	b=NVELvbu3q9wxUKMAqhl+cMoCFzvXwEaBxAq759dXwp8fqaxNgMIekj2LhP0nTBqpFe0v
	 ACrkLDBprv0PtaIYK4cJrtB78aECBUgwB9V4qUs+LW1OVqge2seg7nnId+PcgfJhYHlTk
	 DAtRZRfLHDx0sBJ7m2yaBpaMKtmsyGk4PO/yvD27H7dxWD48tToHMgrGG89zTp7SJA4CV
	 E81XvoBgRcF8w6CziwIflgADHSNe20Umk5xeC8jK7DWdDNIyaE0+t6VLVM5/SHPgWm/Bg
	 1Ru2uqxJ4pZDIjkmVjCccZogWFIy71u/awVPN2PFy24HyoPUbesKtl0xTsrkM52G3/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vzLzVcrk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484E606A320;
	Fri, 20 Nov 2026 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vzLzVcrk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E0D1F000F2;
	Fri, 20 Nov 2026 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795183130;
	bh=nNheUa0aYoRrQSBs16Ly36vY+3Ibo/k8RtKCduo70eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vzLzVcrkQkW8KqnstggvnCieEbDhso7NW8M2zqgheGDAxyV/1Usl/J+PoWc7iibdm
	 aVj/snRnvwIV/zSux9brN6ip4+7jVECm1D2Nv6gk034HXc10ujRQjs8PhDlH2OmJgz
	 vKfnMk2OIE5u6GUEy3tN2vVyYtx0cHjX/i6QFj8A=
Date: Fri, 20 Nov 2026 14:58:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: neal_liu@aspeedtech.com, joel@jms.id.au, andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuwb@xiaopeng.com
Subject: Re: [PATCH] usb: gadget: aspeed: clamp transfer length in RX
 completion handlers
Message-ID: <2026112035-syrup-universe-504f@gregkh>
References: <20260917103205.3049861-1-liuc63@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917103205.3049861-1-liuc63@xiaopeng.com>

On Thu, Sep 17, 2026 at 06:32:04PM +0800, Liu Chao wrote:
> ast_udc_ep0_out(), ast_udc_epn_handle() and ast_udc_epn_handle_desc()
> read the received byte count from hardware registers and add it to
> req->req.actual without clamping against the remaining buffer space
> (req->req.length - req->req.actual).
> 
> When actual reaches or exceeds length, the subsequent DMA has already
> written past the end of the request buffer.  Across multiple short
> packets the overrun grows with each completion.
> 
> A malicious or malfunctioning USB host can exploit this to trigger a
> heap buffer overflow in any gadget function (e.g. f_mass_storage,
> f_fs) layered on top of this UDC.

We trust the hardware here, so how can this happen?
