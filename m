Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998803;
	b=FafYRQ2xNolBF5HdrJYCcvtrd2mZNHckpIDqrexmlW9yOTkNHs1tnK+Kb69LMdqXca7q
	 HR/0iZOLqrohwdmztpIgMmEcxIK9n5sBQtpX9XXTooPGyKTvumhOWcDxGTMM8ER73GCYA
	 VMqq+xrXpSzELbWZV/o+VnV8UclF2TTnPZYmnuo+aPtbDl93TuHd3CsW7SpXyhf/ozt3o
	 XboXiThaz9psKOeJ3rbGc8/Vh94qQOWaZpCuQPtFx2NA+UjfQ9wMYRwKSYpkTtaH6hdaH
	 GG2dytUwegDYdRTj8ioDfjOTs7xtPjMqr8iiZkoT+kQBwnjFi2XWIPvzKC89qRB6s0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998803;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vJ5ver2802ITJrb6myqMByf64p6DzbictE5BmLykn/g=;
	b=XzABCwjmjp2jl4jt1X1QMbjkjKMbPEp1duMhTc9x2HFUXFtMdXdu3+d8VvFIcZ6lR7wx
	 pBwo8jnFwwcrdYjD0bY3uX7OZqZnPjQ89rmHvnxKCvo1CXPijSqXEwpQzeyT97Acjcyir
	 Zax32ZOCT0yjxhbovhKkglw3hTtN1ZK/FitWe1EcuL9Z1K86f4AMgmY2P6f4U8CCXmMtn
	 0lBblszQSQnwoPs6FsHqiRQZgN9X/dZHdBvIzyNbEpjsw0Q8PV9oHnTivA74Fb5CUZL16
	 mqycGBPehyMlNOkDmX0jI0WXybnxUkGDXmaf3OE8x9HjyBxrv6DYH6yknbIPdzPaPdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ML0xwu+k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADF606A338
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ML0xwu+k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B291F000C5;
	Wed, 18 Nov 2026 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794998802;
	bh=vJ5ver2802ITJrb6myqMByf64p6DzbictE5BmLykn/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ML0xwu+kLAr6h0Da7ofNImobJZys7ME8S8YwcWYn0k6nUN0g1Y8t3T2UWoC5hZ6AU
	 DqxDfbyFBSNfECVx7L7LQ01wMK+os5V3Dk5OwIQ9Nt41UjGs4cR0cVFHekq3SGc8bQ
	 UYVhiXgXfiTsOi60ZREbxw+cp9Qm3yRF869K4Dlk=
Date: Wed, 18 Nov 2026 11:46:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Bundschuh <mkbund@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 0/2] netfilter: nft_ct: move custom expectation
 support to helper
Message-ID: <2026111826-nuptials-sculpture-23e3@gregkh>
References: <20261117234631.165899-1-mkbund@amazon.com>
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
In-Reply-To: <20261117234631.165899-1-mkbund@amazon.com>

On Tue, Nov 17, 2026 at 11:46:31PM +0000, Mark Bundschuh wrote:
> Also in this series:
>   - 6fb421bd07f1 ("netfilter: nft_ct: expectation timeouts are passed in
>     milliseconds") from v7.2-rc1 is included because it fixes the
>     timeout unit bug this branch has, and the fix's moved code uses its
>     jiffies timeout.
> 

Did yo uforget to include a 6.18.y series?

thanks,

greg k-h
