Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281944;
	b=VGbTDO9pHYqvWt63CLClVBrap5uYbokvVmDRHvynAj4lXolV5xD3F3Weabj+Mdl9YhO7
	 0QX2jk0yepP2jUAQgyODPQXeyMqVrBLIq7aKG7ImfmEs4Qmbhl6cgaU1f1tksHGRzyY71
	 WB32q8OXvj/TGNbH7nH67wI+saXhjX8v8e8krnAimCf1VPQQfm0s13a1AdkSUQE85rBic
	 wnUXcmd/5F/poPuvWqzEJpuNMcPhqArVtCXeFoKkgJ1YvMnJ8C8xnCAF2VsdEEnmMnPge
	 Es/E87CedkIF9Y705ThDXn7E+gRChxUOBvnzNwnGHzvwxs6XwsSFOL5fGkx2r3tKNOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bk+il3Feo1SWvFpZ0KT9JIrHLDIGMsjtf+8THiuKb8E=;
	b=YK7GDvnSck3Vsxb2inpKIzDDO05+LDfgf+Ws5VzAKhaDMNsS4wDGQ1kGpoEe61Fgpq/1
	 UJ2DUeeDwIhGW3XYrFzJ5u6nhNOi4gGn3Qu9/3o6liY0puDBT6U1tv6xoDxKIWXLgM0ck
	 y0ty1GkEX/0GM5FfHgWCwWxc5lgtYqQ6pa48fAeDr6pkQok/cqPdA9vzmg/ukr7L3y4Jo
	 Uu3hrDS9aZyjE7ZZx0xS8dUgGRy/eU6Gye/9bGzIvzN/Sxd8U4wLE88b5MUlF8Dnyu0wH
	 rY6mnuDRDBHHxMaFHSv16mDH2v1puiJbSXS8pedu+u4VmxnczcvY8KUMQ6rIAzt4jwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XTA7nR2h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E259606A31A;
	Thu, 29 Oct 2026 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XTA7nR2h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BFD1F01829;
	Thu, 29 Oct 2026 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793281944;
	bh=bk+il3Feo1SWvFpZ0KT9JIrHLDIGMsjtf+8THiuKb8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XTA7nR2hdQh8w8rEnNFwH8GARaUn/BIkTeQuYaTVHeSPh7LNzoW/xsAl3EJyAuwD1
	 PSQqvFhyKQhs3HT/7gYYgnMGw6TLfnQETZlMga3TUyQ3dV5uWTeZqpTCGAt4RetGzS
	 ooIJY+5ZhU82G00DmiKiUeWnSqaPvMmRLD8vpYqA=
Date: Thu, 29 Oct 2026 14:52:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Yingying Tang <yingying.tang@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>, ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>,
	Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH 7.3.y] wifi: ath12k: Increase RXDMA buffer ring size for
 default memory profile
Message-ID: <2026102907-ruse-tricycle-be1c@gregkh>
References: <20261029095541.685879-1-shengchao.guo@oss.qualcomm.com>
 <2026102919-confound-remnant-f133@gregkh>
 <auNKJ88kK1_QTPTi@QCOM-aGQu4IUr3Y>
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
In-Reply-To: <auNKJ88kK1_QTPTi@QCOM-aGQu4IUr3Y>

On Thu, Oct 29, 2026 at 09:29:11PM +0800, Shawn Guo wrote:
> On Thu, Oct 29, 2026 at 11:14:27AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Oct 29, 2026 at 05:55:41PM +0800, Shawn Guo wrote:
> > > From: Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>
> > > 
> > > commit 15f7603b69a83a0acc7fcc8992ecbea6110f9424 upstream.
> > > commit 643f0bf936176c114d5631da7547e991b5d99f10 upstream.
> > 
> > Huh?
> 
> Hi Greg,
> 
> These two commits landed on upstream as a series [1], which doesn't
> apply to 7.3.y, due to missing prerequisite changes below.
> 
>   wifi: ath12k: convert DP_RX_RELEASE_RING_SIZE to inline helper
>   wifi: ath12k: convert ATH12K_RX_DESC_COUNT to inline helper
>   wifi: ath12k: convert ATH12K_NUM_POOL_TX_DESC to inline helper
>   wifi: ath12k: convert DP_RXDMA_MONITOR_DST_RING_SIZE to inline helper
>   wifi: ath12k: convert DP_RXDMA_MONITOR_BUF_RING_SIZE to inline helper
>   wifi: ath12k: convert DP_TX_COMP_RING_SIZE to inline helper
>   wifi: ath12k: move dp_profile_params to dp.h
> 
> So I adapted them into one backporting commit. I'm open to suggestions
> how this should be handled.

Backport them all please.
