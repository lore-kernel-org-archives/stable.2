Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176885;
	b=tMWRGgyXw8gWpYkXG1458pfHVn6j/qoo/TEEMXOt1DtRatCVf9RRhuM1S0yArUlUVHE5
	 6t2DbeW13lBfMy68lF+4/1ArZH4dLVOX11py4l8CYHYro1ixFM9nUVxPbLlqi0hP1/Agp
	 hTUqjFE82rLhgjZSXcOaOmi7QrwyjiTSLwdD5l7Nd7I9GzfDauI15UA6H5guDwz2AtNMt
	 vWXwTa/cg1R+9MjWS0RJsvy+YNhh8VdH0nNkHKQfGWn2iDQ71qpJAUH4Pj5YxSn4wtpB/
	 MMxG7hSpsKWm1A5Zk1Jsud8k9+ZDUTfULUCXg4AA72LcnftHRp2lQv2CpsPAGS8YPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176885;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yfVhfgGK1OedUEyPydQHT3KhIaYnblF9DmvN6Za45Rg=;
	b=rZrSvymWrtKZMVk5aC+otFHOS2L29h9+RZ8iszgJVwE3PES+Bz8loQn/djWOw2Qngbg9
	 nzUywSha6sUGMyAwLVx+yK3qo+0zUk9dyvTs+D6/feqangokyElkeR4iUPqK0wvyz60mn
	 naZ17VyS+071L1wKGz/l567shxOSY0MaitcC5VrQhyAFfWoWXBxHIeSLf4nRgdtjVzhcr
	 ihaM+ame5ijQH85/NjTRtf4CckK7m0ewziwEaKqmpC/rdCB8/IqJjEU0HV1zUGVamQRE8
	 ZB5S2fLTNNj5Ir4Nf3Gtxx7y7KQzu1vpPM9TszlPkA87JsctsdR5XOSI0qDN6lp7QQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HHs3PO6J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D0606A320;
	Fri, 20 Nov 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HHs3PO6J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291D31F000D2;
	Fri, 20 Nov 2026 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795176884;
	bh=yfVhfgGK1OedUEyPydQHT3KhIaYnblF9DmvN6Za45Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HHs3PO6JY+pilipPqKehSJcCqz7dbnMnVi0GVGnI54PrcUo6xTaYUmBoy+5kqpcrq
	 E5CGl1dRRPoDGUlDobGCK9K7SHCipGokU4zf4La70QAuDGF0Da1ETWVpNvAwA+u8l6
	 7m2ngaNuV9rMuvkwZ8IDC8L1Nm9Zx5+G/b/OwLn8=
Date: Fri, 20 Nov 2026 13:14:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	liuwb@xiaopeng.com
Subject: Re: [PATCH] usb: gadget: fsl_udc: validate pipe index in
 ch9getstatus()
Message-ID: <2026112032-cotton-hardly-d8db@gregkh>
References: <20260917123133.3760392-1-liuc63@xiaopeng.com>
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
In-Reply-To: <20260917123133.3760392-1-liuc63@xiaopeng.com>

On Thu, Sep 17, 2026 at 08:31:33PM +0800, Liu Chao wrote:
> ch9getstatus() uses get_pipe_by_windex() to compute a pipe index from
> the host-supplied wIndex field and then passes it to get_ep_by_pipe()
> to index the udc->eps[] array.  get_pipe_by_windex() can return up to
> 31, but udc->eps[] is allocated with udc->max_ep entries (typically
> 8-16 depending on the hardware).
> 
> The SET/CLEAR_FEATURE handler in the same function already checks
> 'pipe >= udc->max_ep' (line 1431) before indexing, but the GET_STATUS
> path omits this check, allowing an out-of-bounds access.
> 
> Add the same pipe >= max_ep guard to the GET_STATUS endpoint path,
> matching the existing check in the feature handler.
> 
> Fixes: b504882df105 ("USB: add Freescale high-speed USB SOC device controller driver")

Not a valid git id :(
