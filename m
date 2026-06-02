Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E93D349A;
	Tue,  2 Jun 2026 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395516; cv=none; b=icJAGs7RYjd+zMF7MmIH3OiNZF/WSszYlKV2kKfoTmEp+Xp8shEoCe20HP6x4z9x2XWFuOz5heVtOCGqXOOI4+96DErgSTWZBZ7XR7eRT16EPl3TafJbxg/zhju8KGk1HUlakujT67EVM+4t+LDCWE6CfWQPaIFXGVI+vtIQH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395516; c=relaxed/simple;
	bh=0CwGFvg6msXZHsPhvYki0SBF0WQtGa73wA83lE4DqsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl7DUPyDjzq9g5T5U0Wsq2RYSKYGzKHguXbNONI6iSE/Y0W8Y8GztvaLlzA8U8nLzS7Cis84bLFjEmLFHJwK9QcbvFkMP25ka2l6ECGUWS12gctTlVvTqALBMfG7HotN4pYqHh6mk5O4BjyAsmL8L9zBf0lsMaRO4Zqbmgo5FWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UUVbMuGv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UUVbMuGv"
Received: from ideasonboard.com (unknown [IPv6:2001:b07:6462:5de2:520d:d7a3:63ca:99e8])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48307802;
	Tue,  2 Jun 2026 12:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1780395483;
	bh=0CwGFvg6msXZHsPhvYki0SBF0WQtGa73wA83lE4DqsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUVbMuGv5ok3OC/BscovpMISUUR/RwkgrZx4eJmeOtddPzKNeJvgO9jmk5gsr9v2u
	 3q4vlH4RKtudjte204arqRNXDz9fyl/P6BzgwolQyBpBMFtXVzuP2qJumCLUKxl3cZ
	 gnWMgmom656pJZoM33ARQp0EpQMVWMxtsBwwNUco=
Date: Tue, 2 Jun 2026 12:18:23 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Nayden Kanchev <nayden.kanchev@arm.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: mali-c55: fix integer overflow in scaler
 factor calculation
Message-ID: <ah6seVCMzk0JODrf@zed>
References: <20260529024429.6942-1-devnexen@gmail.com>
 <20260529050649.14109-1-devnexen@gmail.com>
 <ahqh3Zv8xXNENzHb@zed>
 <CA+XhMqyhpn0kHgz=i9WUS+1rFN4kWW3DpUYubBN1k-qcKo+RpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+XhMqyhpn0kHgz=i9WUS+1rFN4kWW3DpUYubBN1k-qcKo+RpQ@mail.gmail.com>

Hi David

On Sat, May 30, 2026 at 11:02:40AM +0100, David CARLIER wrote:
> Hi Jacopo,
>
>   On Sat, May 30, 2026 at 10:55:59AM +0200, Jacopo Mondi wrote:
>   > Have you hit this issue ?
>
>   Not on hardware, I found it by code analysis. The sink format is clamped to
>   8192 and crop is clamped against the sink, so crop->width can reach
>   4096+, where (crop << 20) overflows 32 bits before landing in the u64.
>   I don't have a >=4096 source to reproduce on, but it's provable from the
>   operand widths and the clamp. UHD (3840) is just under; 4096 gives a
>   zero increment, wider values a garbage one.
>
>   > Could we maybe first do the crop/scale division and then do the Q4.20
>   > conversion ? We could maybe save the below do_div() [...]
>
>   I don't think we can - dividing first loses the fraction the Q4.20
>   factor is there to keep. E.g. crop=4096, scale=1920:
>
>     correct:      4096 * 2^20 / 1920 = 2236962  (~2.133)
>     divide-first: (4096 / 1920) << 20 = 2097152  (2.0)   -> ~6.7% off
>
>   So the multiply has to come first, and that pushes the numerator up to
>   8192 * 2^20 = 2^33, which needs a 64-bit divide either way. BIT_ULL()
>   just does the existing multiply in 64-bit. Happy to switch do_div() to
>   div_u64() if you prefer, but that's orthogonal.

Oh yes you're right, I think using ULL is certainly better.

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j



>
> Cheers !
