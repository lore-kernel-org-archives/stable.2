Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183963;
	b=wk/fKbFGkcM7O41wT0c76juhL760bOg84FH4BdVr1dpYun8nYmaOHg3Irl1sgIrT2CLq
	 Bred6nKzyXblUExXv3CTXzeplGylTi9pYUMXgTi/8883OQ1F3b/z9MBXhvlZaunuz7fox
	 7R2QhNKGEX2IK1f1pWobvaoNX7fGXJvQo6g6ufVExaHlh1XFvP12jCLdKGns2u8YV3SXo
	 LcTIj+LqVZTGHzEAL09mBLGTAp1adnWUz9EMh0ZUY2GNWDKWvBAuI3tJesRCYGqyXf86W
	 4Br9gthz8YnElCJ8LmgTw6nrO27aA6LS7GJZlnFkVFVxYHQCi9UvylK96ZJQimcoc7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183963;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LxcUDiNfgVZlLBkTJZ/peRaTOqYje0NP16TBE+dlTFE=;
	b=E4BBY6hLRbHP2Xao4EjwtvxZPlMnbQIOCQLWg+jxuGs7O4aqwHSgdVrZpi2Iaa85HzBd
	 7DENPFFrT3/TUiYzUpA+VziIOaDr1ErZrfIlX7mabjwqwfH4OFtqO/+y4DYGD61H6OmwE
	 FESVHguUAycYt3Rf0VHR+RG4M5wfwDKOgEyqEk1lvIn1hne3wB28T65L3NHp2HISrycI7
	 /M63b9RV2MZv0NuotDRKrRfGEH+GIF474LlBqmDTf/EkPvFycJ8wdC+D1prCRZIOKNguq
	 eBk0g6IQrzN+WXzpzxS1lJjTz5/WFECivP5ZjxpWaxdOnUO03Dd2BBrJPkWHpHzX2Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NRToHVYu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FBE606A326;
	Fri, 20 Nov 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=NRToHVYu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E891F000C4;
	Fri, 20 Nov 2026 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795183962;
	bh=LxcUDiNfgVZlLBkTJZ/peRaTOqYje0NP16TBE+dlTFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NRToHVYuKubrqs6oyN6rHACRIwpKh6wnwDL2+Qa/1vbZJZ7ISv0BWR4v7vFzB1bY/
	 LPj4A6Ujfp/PxTK5fY2TPj0sYUBbmeFkrNVGfcELWta8CRd//OL2ADuERhUjYX3Yhj
	 Jbr5UYHz91Rhi6/GiJb8bxBZZ9Kyz3UDcGUFdI2E=
Date: Fri, 20 Nov 2026 15:12:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: michal.simek@amd.com, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuwb@xiaopeng.com
Subject: Re: [PATCH] usb: gadget: udc-xilinx: clamp bytes_to_rx in
 xudc_ep0_out()
Message-ID: <2026112022-babied-unplowed-3ede@gregkh>
References: <20260917123111.3757737-1-liuc63@xiaopeng.com>
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
In-Reply-To: <20260917123111.3757737-1-liuc63@xiaopeng.com>

On Thu, Sep 17, 2026 at 08:31:11PM +0800, Liu Chao wrote:
> xudc_ep0_out() reads the received byte count from a hardware register
> and adds it to req->usb_req.actual without checking whether it exceeds
> the remaining buffer space (req->usb_req.length - req->usb_req.actual).
> The same unclamped count is then passed to memcpy_toio(), which can
> write past the end of the request buffer.
> 
> A malicious USB host can send more data than the gadget function
> expects on a control OUT transfer, triggering a heap buffer overflow.
> 
> Note that Haofeng Li's recent patch for the non-EP0 path
> (xudc_read_fifo) explicitly excludes EP0, so this code path was not
> covered by that fix.
> 
> Clamp bytes_to_rx to the remaining buffer space before accumulating it.
> 
> Fixes: 1f7b0c6d8e34 ("usb: gadget: udc-xilinx: Add Software data structures and APIs for xilinx udc")

Don't make up git ids.  You did this for many of your patches, I've
dropped them all now.

greg k-h
