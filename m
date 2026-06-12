Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D563603C2;
	Fri, 12 Jun 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284330; cv=none; b=r4qUcbCFZ6ohaecJFCxyz/l8BsryT9gZRoGdCWNwjep6ypW4lSWIFQhRKS77YS06qlGVLJvt0GVmD90AI43+cukVft3DoyCQ8vlTEty+OALtqNm6F1UoBa6d7/TKwKjKY52kILd/m6u87hlJu2BHQQqn+ez8iDWk1orMc3cbGBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284330; c=relaxed/simple;
	bh=bc18bAhS36XRAYC7QXisQiDCW1+OxMc13lXuzWt/c2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXb2FuupgitotqLau7zSvg/heNce4YcABx3Tb8wFLZJa7RF9Z9+slkg067+vDwGoxtY0FUAwHebkoQ6sTvrBjRN3oOhTfAChJkxTod1IXiamh39XhryIqYlfxUaFdDV3E9yCgpLs6pmIlnpEDF/r6D7D7rvf9W9YShVw9yPoSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfQdzHZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfQdzHZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E601F000E9;
	Fri, 12 Jun 2026 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781284329;
	bh=wxd21VZqQeGRt+phJQqIcHHa+IBS41s3vD59iytiz7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gfQdzHZmmtGbA4HG0Zl8teTV1U48VvfwbdR6UQ5kyDlq6woHLjA/nxXh71Q4rzJF4
	 Lqf6UHMgqavS/2KXqi/5U2yfSGGK1E1b+NzUgQHuYU2Rc0YfE7tQjdsW0wxzEouiko
	 GiR9eMMR7Q5rdifJkk9fUW2Xemm2mSi2MIntN5uVb82QsJxYAe3B8lvcA/QM5/Hpg0
	 /BYqzulauAF6h6PtdFwypafhx7jJXVkaGoOWmiIsZbgbW6io+pBg38gskIMK0q2AW2
	 k0sip6ycuLmSy5+PZLws8dvowu0MqU+vXC39ecTB9jj3ARAU1I0S38N0DoULVXahRu
	 dKl7XLFA5FNAA==
Date: Fri, 12 Jun 2026 18:12:04 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: fix 32-bit integer overflow in
 qrtr_endpoint_post()
Message-ID: <20260612171204.GK671640@horms.kernel.org>
References: <20260611125455.2352279-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611125455.2352279-1-michael.bommarito@gmail.com>

On Thu, Jun 11, 2026 at 08:54:55AM -0400, Michael Bommarito wrote:
> qrtr_endpoint_post() validates an incoming packet with
> 
> 	if (!size || len != ALIGN(size, 4) + hdrlen)
> 		goto err;
> 
> where size comes from the wire. On 32-bit, size_t is 32 bits and
> ALIGN(size, 4) wraps to 0 for size >= 0xfffffffd, so the check
> passes and skb_put_data(skb, data + hdrlen, size) writes past the
> hdrlen-sized skb and oopses the kernel. 64-bit is unaffected.
> 
> This is the 32-bit residual of ad9d24c9429e2 ("net: qrtr: fix OOB
> Read in qrtr_endpoint_post"), which fixed only the 64-bit case.
> 
> Reject any size that cannot fit the buffer before the ALIGN.
> 
> Fixes: ad9d24c9429e2 ("net: qrtr: fix OOB Read in qrtr_endpoint_post")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> 32-bit only; reachable via /dev/qrtr-tun (CONFIG_QRTR_TUN) or a QMI modem.
> Reproduced on i386 (a 32-byte write with size 0xfffffffd faults; well-formed
> writes are unaffected).  QRTR mostly runs on 64-bit now, so this is a
> correctness fix completing ad9d24c9429e2, not a high-severity bug.

Reviewed-by: Simon Horman <horms@kernel.org>

