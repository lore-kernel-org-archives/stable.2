Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183672;
	b=Qg+ixnZa7GlsHgLoNIsDulXic1J3ewnhsrv7cee8g+q01Ilt+4i8ZpcIbuxLayaA5xlV
	 k3Atvm2uGX+UIADUNKZgJEze+bevEiTuvNnLDgC78VhyqujpX427jybB7vJBDTm04QowP
	 CbCY+IOcWypfl8EsyL6X78mjVXKHfxydM61LQQdg3Drv5XEAMmuoXEa0XkPvSm6LWkHR1
	 apvnP0DDdrV0maptNE+wCMH6h1uzfrJgOL3LxWH0Blu06gAtahE00SNy0cGDIsMaNUE1s
	 P0VnFR/jhLuOyMjsHAWySBSlNE2e12gYWXBMoa+LHUD1oyOlFWKRLFuXRoB2D/17srg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183672;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1ZFgTxowfzONgDDyjSqjbXBXxnyb4XAWB8ihAUlHnaM=;
	b=L4LTyf5vKTwxvAKtuoDGnA4JtK4e7hDNAwoQ8tnXbMTrw1y9CP7dJ4NTtbEZkfX5kPr5
	 uZsSJLAntTgOUhmH9FJ9bK8K4rL2EidERR3C6755/InmIs3QZstLIjqK1QhYNQl88bUIg
	 Gk/+MC+ZxM5q+GP5lbLhx4W2MttK/b5aLgX88qCc17VyvUsKCkU+FjDJsAzwiBv3kcdqg
	 mY4Ets/A8ivaoHJ7wB26EK8RF/9E4i8zhLRjPhc67o1r+MzIjAvswZdm9Utsk1tRTD9J6
	 zGbP0o2apWgj+czKxSGagEnAPESdEjR+w515HvYwcdqluQN4YFvouzD+4NgYKVXsIgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kwN7GNCO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9BD606A326;
	Fri, 20 Nov 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kwN7GNCO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF261F000C6;
	Fri, 20 Nov 2026 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795183672;
	bh=1ZFgTxowfzONgDDyjSqjbXBXxnyb4XAWB8ihAUlHnaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kwN7GNCOdrrouRLKwmfcDKXzruOkigesNmINxewlL+ne5g8x0vTI1b8voQ1AxFA3N
	 edPOlFcX8yuFQ74sAcqkq/OHoVs4pVnUmH/NDcMethM9OJE3hBAfNFwiRxvsHPQTRs
	 8NcWFA1MS2kMLvxjJ8s6Y4640QJOJxj/fmFBCjiQ=
Date: Fri, 20 Nov 2026 15:07:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Ardelean <aardelean@taladin.ro>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	hubert.wisniewski.25632@gmail.com, b-liu@ti.com
Subject: Re: [PATCH] usb: musb: gadget: mask the MUSB IRQ while complete()
 runs
Message-ID: <2026112008-dean-crabbing-a331@gregkh>
References: <20261118115435.49748-1-aardelean@taladin.ro>
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
In-Reply-To: <20261118115435.49748-1-aardelean@taladin.ro>

On Wed, Nov 18, 2026 at 01:54:35PM +0200, Alexandru Ardelean wrote:
> This patch is 2-part (in one).

What does that mean?

> It reverts commit 3fc137386c46 ("usb: musb: Fix hardware lockup on first
> Rx endpoint request") and implements the second possible fix suggested
> in that commit.

Please no, make this a patch series.

> Reverting that commit alone would bring back CVE-2024-56687 which it
> addresses.

That's fine, that way that CVE will get automatically rejected and a new
one will happen for this fix if it needs it.

thanks,

greg k-h
