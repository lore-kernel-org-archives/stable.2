Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3364C67F0;
	Tue, 15 Sep 2026 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499134; cv=none; b=WVmyMiyB7c4MbHbpsGCrjzPVRrh79xSuTKxbDdCXIYpMbXJA+mAJ14xNnuf8E+IBc4LphHi/hUjVQdc9G/PrP8XOMtac95L+DQA5MfsYqkNqmwx1qeA6pWshcnmr0gIufqQSYTIue5ruegnTXT0hh7ONHCWcDlIug2cWuTETUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499134; c=relaxed/simple;
	bh=fYzTFMrWjdctrrJ27MFBf9XX8xJCRIxVFzRkxLXBs48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtI+mM6c1v5LrWXdsSUOjM+ojMbxpofynCJrYKd2gMDTOq6qcAq87VRt96J+Xqy5eSArDWUnpRm9sNvPheF0gprPbrsHWlCd5lF0akpW4aE5cUz8+GDIih0xt/XhJGakkMFByroB8AL2PSs7h73zlfUwjGYimuTUr4u60OaL3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Q+ahwNiP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ve/JUjLV; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Q+ahwNiP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ve/JUjLV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id ACA8E1D00225;
	Tue, 15 Sep 2026 15:05:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 15 Sep 2026 15:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789499130; x=1789585530; bh=X6nMFbOQ3D
	HbDdO6G3T8ctqV7op+vn9hbFndcI/EdSU=; b=Q+ahwNiPmmTANd1rlqkNl2vcjm
	/HucwzOM6bRqCRa4kQmszpdRd4921Db7ZdkI/x9vM1dVeZhUp/c47w48sdPuVtux
	rmBJeIpTrQmMGYP92H17xyK+NTm8qO6dNu84bhDmcZxTsbby4FxISc15ZiA62bpk
	b+WCwU1Vwval8GJqaeh5/APBfS13cuENeuWx4Zm8llR6WnAiDbypONRrKqzMA7sD
	da8lEUl+7szonIe+Oxw/nPn82Uec4XQrPXhTuw1hnpQVVyfjI1egwMmVK5NbcJTW
	T/ZOKofGOqyPfUmloHKKXTTVCUbwc96Y2FyeGJ0HYrONwag2zyzyexXE9eZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789499130; x=1789585530; bh=X6nMFbOQ3DHbDdO6G3T8ctqV7op+vn9hbFn
	dcI/EdSU=; b=Ve/JUjLV32STQI+5isIZiKCBAID9hsD1QZVO+MVyPl2UttSDE9d
	Lg4LZN1qxLXLU8nLk16ycKZZUeAskcJdUfBVvB102PD7vA9PZKkwHLexd5/GB3yt
	h4ua2p0UYjf4CNyJwbeMBowNJuCGQhJgj65yyZaRmVXXHLAb4odWz2h7xV5tObeh
	+KxLf+hlM2gNXnjmQu5AR8eZ9/HZ4LcpANGaR6nNGzppV4Zzc65ZQX8KY/YZ+fRS
	8uQjFw0lDAsDRC48jzW0bRFs+NM8KBsZIak77s4UF5q54GTfAJ5Zad6G5DXZEJaS
	A17NcKkj1/RO1svwYLmWQt0N3WYvT34y4CQ==
X-ME-Sender: <xms:-papahtTpArAllUFUG51inEl_yhPtljfoz7EWOpKLo-Ws7wRkPGtXw>
    <xme:-papavrrBWIXD8GvVX3GP3TOBMygOAxHwIqSAXHBglNrUPGIJ3PBbILeog2YyxYdz
    4bckqf8BC540ATT4N1QM7u7u3Zwx2kqkzRspyh7otrXMuJcPAJjtgQ>
X-ME-Received: <xmr:-papaoKdaoRBsGRD18yo_KzS9GwSQP1Nc4HxKHp_-es0vt42YrWz13i269u9pVlib8R7AWBQa3VszWS77b55W4nhuKG95K-Ji-Y>
X-ME-Proxy-Cause: dmFkZTEGgQbWaHIRRSDCL3gI1/7EEOGapo2YIjCR/0kOQE6wrTf9EILXR9pQXcv8fTF1w7
    apfnInKjO6WmimIaasWVjIFziJM4E4rZjx1vKC+zSUFUNFU7V/xSeAllcWfVRLJt2wGVgL
    WwQ4bM9mAvi6DcXEP6tp7fyfgME5WH5Aj5ZqnbjF/uzPesRulMx8A6nj4ajgGU46BhjtXx
    rIp1cTZ1nWfj5YjTfvZurOllIqk6VtBaKSu/IFCfH6rXFeEgCScB1nJeLv5arBFjgXZD1g
    6exQpmhzes5SN8e+kms8+EB9PMrMcwVbZLuV8sudiG3zZzWyIPE+lwDvFAtlHnigk7uoZE
    98+OBS+IYA0CZPhWkv64CvCe/Fx/mmmH4hASBC+aMKXzLr60qTGdN7nTnWnOzrbQ5oOGDK
    OEak/l8uuJ9LZnhiWMypwcQhsNetlCsvjmOPpDGETsjsNi01mccgPU2ddGejNm4AiXxgf+
    gCdaH79VRZfqVES8mM98hUoSmp+qHYrBTqe7MdvWj+HmChVVdVHCQoIHQXuCTzOxdx3ZaY
    t0uF2wvoOj7jDf+9/r98QLsIjJZnO1HOVobJrVU0txmgBjxapP5j9vQCncLGHTPg5TC0Zz
    TH/6AYmhoIdUEnO2DvhUYLkQ3saiDiyoBFSsK4AiXq62WRtvff8/SCjwjZrA
X-ME-Proxy: <xmx:-papansb3rhHQo5jw-Rjiy6_gPT3kLm7WfCwT5MyV-GqLqrgrRpwaQ>
    <xmx:-papatDIISXcdf4DF2Avkm9MEb8IOgBioSgzjk59pFubQ3BgLRjeSw>
    <xmx:-papan7gbepKbCdq4wy7mdf7wgBZZdYtqBvAlwUbLCDzLT23Ke-GwQ>
    <xmx:-papatBaXQP3kZvSujq6bSlrrqpIl7jy1qZVuwwwzEQun5sGS3nIIg>
    <xmx:-papaleOfwieA4a4fce8odzP0kcbCWpUv5xegy7aFmAFy0Ij8sKcX49E>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 15:05:29 -0400 (EDT)
Date: Tue, 15 Sep 2026 21:05:27 +0200
From: Janne Grunau <j@jannau.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	"Gautam Shukla (Gautam Kumar)" <gautams@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Jason Huang <jason.huang2@infineon.com>,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for
 4-way HS offload
Message-ID: <20260915190527.GA212312@robin.jannau.net>
References: <20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
 <3422e0b3b7d4889d2a728c41b0b02f6c80fa71bf.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3422e0b3b7d4889d2a728c41b0b02f6c80fa71bf.camel@sipsolutions.net>

On Tue, Sep 15, 2026 at 03:22:50PM +0200, Johannes Berg wrote:
> On Sat, 2026-09-12 at 11:40 +0200, Janne Grunau wrote:
> > 
> > This will conflict with the "brcmfmac: add FT/OKC roaming offload
> > support" [3] series but is written in a way to easily resolve the
> > conflicts.
> 
> I ... no, I'm not going to take that conflict, and I applied the FT/OKC
> series to wireless-next. Please create this patch on top of wireless-
> next, if needed at all, and then you can backport something later to
> stable if needed.

That is very unfortunate. I hoped this change could merged as a fix for
7.3.

The change is required. wpa_supplicant 2.12 (and unpatched 2.11) will
run into its authentication timeout and disconnect WPA2/3 PSK networks
on brcmfmac devices with firmware offload support.

I'll rebase onto wireless-next and send a v2 but I think it's serious
issue in the process that it will take until after v7.4-rc1 (7+ weeks
from now) before this fix will land in stable kernel releases.

Janne
