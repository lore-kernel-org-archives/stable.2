Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809F3B42C6;
	Thu, 24 Sep 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259798; cv=none; b=Y7qY3X/u3jQKCmQQwN13ncEbh5+vj1CdR8r5D/+50YNt4X2/Erbk/xbRh9am8oABATH1qbF6A0REh4X8AYpUbJbWxQ3LyXT3x6xpKzEUnc/LVqRBbClAjpxcmwuEM/9ys3byXzflZ1rq2ymN+WJxvp7ld2PCgTbHNly+QUYQpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259798; c=relaxed/simple;
	bh=GPC1yr+ZTTPDV2IqY+Tm9zUxSqdHGv82/wq619yWX9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTcEtSs/WlBLYLp05C2I3pfnz3xCoU6EU5cBfq72F5vN1DG5ixWt7/myqKigpkSk82IYdKxmlMQHfpg5f94IEc1izQjsy1IHmMsoZrVZQn5zsQM9jdyqKGHUsQlDKbna+LMNWMclKybsvDaBA7dgPc3CkZBOmD8YJjXW4P7Wn+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yf9+62Dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yf9+62Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD851F000FF;
	Thu, 24 Sep 2026 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790259792;
	bh=pBM8yzJ1P/YN8g9AMJ+6Lw5x7cfNoUSq+jqBG8i0rrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yf9+62DrRhmwpUBlW+gMhbTsNOS1KTcXSP7BgKJPFGKHgHOehWO30BHv8nBA5C0Fh
	 vA3q7hz1P9J9n0lzKgLHRH10MhpSQ6pROQVg48/8Pm7f4WldMXdWWNATdWP2bSGUSD
	 pDq2K0m94tcjvwcTWhVwv3411a5gVgdJNmUqvbng=
Date: Thu, 24 Sep 2026 16:22:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ming Wang <wangming01@loongson.cn>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org,
	Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP
 whitelist
Message-ID: <2026092409-status-rocker-0fef@gregkh>
References: <20260920074500.826121-1-wangming01@loongson.cn>
 <4d5e2857-e6eb-43e2-b668-83e779aaa734@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d5e2857-e6eb-43e2-b668-83e779aaa734@redhat.com>

On Thu, Sep 24, 2026 at 12:24:06PM +0200, Paolo Abeni wrote:
> On 9/20/26 09:44, Ming Wang wrote:
> > The MeiG Smart SRM821 5G module (0x2dee:0x4d53) crashes and drops off
> > the USB bus when it receives a Zero Length Packet (ZLP) after sending
> > or receiving an NTB of exactly 16384 bytes (tx_max).
> > 
> > According to the MBIM specification, devices do not require a ZLP
> > if the NTB size is exactly dwNtbOutMaxSize. However, the cdc_mbim
> > driver defaults to sending ZLPs for devices not explicitly whitelisted
> > to accommodate non-conformant hardware. This default behavior breaks
> > the strictly conformant MeiG SRM821 module.
> > 
> > Add this device to the ZLP conformance whitelist (cdc_mbim_info) so
> > the driver will pad the NTB to avoid sending ZLPs, preventing the
> > device firmware from crashing.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ming Wang <wangming01@loongson.cn>
> 
> Before any other step, please read:
> 
> https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/process/maintainer-netdev.rst#L454
> 
> AFAICS this is actually support for additional H/W, just worded in
> very unusual way: please reword the commit message accordingly and
> drop stable from CC.

Why drop stable from cc:?  Do you not want it in any stable kernel
release?  Seems like it should be to me, we gladly take quirk additions
and new device ids in stable kernels.

thanks,

greg k-h
