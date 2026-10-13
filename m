Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084A3A16AE
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878408; cv=none; b=lOP+y+WeXOwxKXSJtEvOYY8qcOxlDyzNtigMBA0roLmf1mH6TCUq2QWQdTyayIU9UjMKhGSlMTZ89O5o+om1fjgO0+0V96iaho138yVVAltlLWDhHp7ND4KP6WWw3f1luWIg8suhn4Ka5srjsI53oqIWjBNzEV4XraJYO60X/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878408; c=relaxed/simple;
	bh=/7snYSTLWtxiOrUiGydIr2lBpsv+T55XzFM83JywWDM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4V58osG0+vQpOzpwDPnf633eMVpOV0rYG8H32Y7ioPO3z5DElOv2cyi6v4F+iq3w/ytwSM5TmjUoTsplC7nzVrjtaK0AnToaicV/KIxTaD+jwU3Nkty5aSCkzxbOjvOpjBx1zUDU13GtLH9mwCkTC6dnYFIqdrQGplnDPAZVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=AmF14MgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OzI4tGHT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="AmF14MgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OzI4tGHT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E3EBB1D00141
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 04:00:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 04:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791878405; x=1791964805; bh=Isxc2GhNg6
	8SWDuxrkfLroFvPPE5nBWS3oaZ7ZEW5Hc=; b=AmF14MgUwx1zpVKiLEnz8IoMjY
	5mjKqGxE/sfabjmibRDPaZ2jhwj6G1QUQLuNAr3s511oMAsX2ZkaCAreJFexayAA
	YXPz1C53jiUE7S4nBgV3jagGcJmmvslxv05Z2GNspZs5fgHZN324OUsPPQlfbvIj
	ng1JVWyCPQOmgLn/id+k26kn9H2nBH4LtK+h16aAUCelw0Lc71LnUw7HBYZ25AuN
	FuTV0mWQSPY+OXOUaaPxF6jDwUR+3SHMxyeifkvblRtOrKU7lpmxfR0bIDgKobPS
	uk1NXOCwSOjjcaskkSaLTV5TKyZeCyGR8+DXzQtsM3FGoJBDqX9mQS9PEMpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791878405; x=1791964805; bh=Isxc2GhNg68SWDuxrkfLroFvPPE5nBWS3oa
	Z7ZEW5Hc=; b=OzI4tGHTLLSk588onT+uY9Y/L3CWGUB1EoSpUIWrAYTfs3AvW5d
	mcOGZWlPfnVD94oldXTKX9PCkwffr5TTJr8O3BsV6KMaNhAz1Cw42tSaKYBSXXLR
	kbL0zRMfONmYWQNqvFkMiBt5LXPi54od0nfXHoGxc3AlkTJL3s21VkYtip8ivOL5
	ktxXpuOzXC4ieyM+pS29c0Xq++qPZd9dVtpjRhc9qJHSYSqTv9d4RDQMGb6nQcyg
	TNfYlmop7yXibueRveLARj4jsF6ZddB8yHb7TrLO0AxgT+16dllNlC255PGcnoXT
	AJa2eIYG1mWzvXp6pbyuhAj7J8+jNZxgWug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791878405; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YqBUmL6tfERFdxtTQxsq1GMQ2n0UbmfIbSmxLBayR3TsVkx
	Atbwt1UWIMJ5pwb8iTxMGPsedxQRzvED9Kk++a+oYIaKViXfwWh8uMISlyYrVlO6
	bCbe5RKkjSiVEEDsPWR/IpXPe5wcRQCddqVboqFGSL7+omV+GQWEqNv+3Sq2r3MT
	PVEoti54gMstmImW8m3sm/p72OIupY2UGwHmzJ6Bt7Bg9Oma+v2W+KAofCP1uDhZ
	Am3CWV1PGH0Vuoq1XXNJpBbalBB3ci9NLaA5FP935J9XfmxzOLV0FFf0hfy7FHk1
	1kIHTUiz8snYe/OdxcSKZn7KIuMUgMTM4/9kwZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UKly7Djlsjae3Fc9uCiXVzNbMcEJOfneN++LH63ZKyo=:/7snYSTLWtxiOrUiGydIr2lBpsv+T55XzFM83JywWDM=;
X-ME-Sender: <xms:BOXNagKaRpqQ5J4x8pdhtfFdeb-i4_e3qm9CjNJALVogYHOwnAgfOg>
    <xme:BOXNagQ_TUJJWLZRxy7fuqJ7vSpNNQSapQmm5W5dLk1ijpYZg2-yo9tnxrsGPsX_E
    6lffitPpLyKptXmkg8sTI06H299wAB_uNGKzniKgV9KjwffMg>
X-ME-Received: <xmr:BOXNaujKBywu9yU9VXJlrqIGZchwfprbAOPXJa3aYGJZnS6FBQDP_KilwPvxsYJSAOsIOpJ1JDs4lqNDQpp1a-Ll6bPJlDukbDhblvXTJVI>
X-ME-Proxy-Cause: dmFkZTFfGDd9W11BJLdxFv4xbErCKSp6wRpGJcghIbCjfi6mf8yzPlCQBZdU+faI/Cf6sN
    KC4N0oPPPtIbqIGmYxdMBJOdFXQt9UyljN0kaL3yQmPoxFzAaL/XvpiJJMQ9PA/6J2R0gJ
    NqEMyLorSAaA6+xuVyzMh5n2tujVKyUg1hlwnMU3TFWaEVhCTRPzOpedsIcYlzSMGdT/ni
    fehLGQJK+kqC58P6BpDBUXJlHQrc0hABYFI4DYC5EKet8/zVUWRUaAmafuMxr74HqGihDR
    IBc28waRrL5OwyT3sfoRhuZgTyqJT/r0pPrD198udBE4AKTnrQPAYsd5pOxTZZmJ1WGndf
    8qKSEH32v9afZpT6mq2kGsRBtvZQNXrhAzXVfGCwQk5AHJVMmF/LhS3cVq7YeBVDXLDzAS
    hmeaN2HKA6dTJ7Fw7NqeFhooxA/xKt1C4Rndu8IeyzouFwq1W9bI2vK8CWSC0CtlKV3psB
    rC9ZDkjzuR3NH/IKM2yDrdeU55IGk2pvDhZfv9U9ZocZfPAtg3asyKD1Eo0JDTjMNh1AXU
    fV3UblEOryY2esgiDr5ihzTKDFjXqHa2dDvky5cPCSQ9+tnt48KNib2HNsd+HxMDlb+wW2
    MWVeWYicr6Lt8Vv7fmc0BIUfyX6rZE0uE6GOlhkGi7RRaMgcs/xWRQauzNIg
X-ME-Proxy: <xmx:BOXNahoUc5GoyikHTdw50F-1KlZs0E__lKdQxFOdcP_1zSYM9EtdpQ>
    <xmx:BOXNalmZIMDGVLHUFgX7V2MDNsrPUGlu4JO8EoiJ-njGcB8MDyCtqA>
    <xmx:BOXNaok0OVOcsZIicdpuXQO0nTqnnyZzDWsfmp2aEG50fcXKj39-Hw>
    <xmx:BOXNaqOaTPS3OW0JoiW6JLWMxR0MMzLEtc-_o0hrPP2ZvHD8h-EKiQ>
    <xmx:BeXNajJiJkDF7fyfLIjgrPFKx-Vzs9LX2kzncKH_bUNKficyaedVbiiA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 04:00:02 -0400 (EDT)
Date: Tue, 13 Oct 2026 09:59:58 +0200
From: Greg KH <greg@kroah.com>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org, xiang@kernel.org,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-erofs@lists.ozlabs.org
Subject: Re: Patch "erofs: remove fscache backend entirely" has been added to
 the 6.18-stable tree
Message-ID: <2026101352-subtract-deflector-a77b@gregkh>
References: <20261013020044.2527207-1-sashal@kernel.org>
 <as3drCZLoTUPS_oC@XiangdeMacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as3drCZLoTUPS_oC@XiangdeMacBook-Pro.local>

On Tue, Oct 13, 2026 at 09:28:44AM +0200, Gao Xiang wrote:
> Hi Sasha,
> 
> I'm not sure why we need to backport this into stable kernels, as there
> are users who use EROFS over fscache on these stable kernels.
> 
> The functionality works and it's a breaking change.  Could you please
> kindly tell why?

Why would you have a breaking change in Linus's tree?  We never break
existing users, so how was this ever accepted in mainline?

As this removal fixes known bugs, isn't that a good thing for those
older users as well?  Why would you want them to run broken systems?

thanks,

greg k-h
