Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CE3BF667;
	Mon, 27 Jul 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136301; cv=none; b=EXXSFVy5u9nbax0/kNLA6h56uZnxlJbQ+zYm/uXZgQ188V/2l7Sl/FT7iIakGsUspJM60QeWcsLaxXnwoZA3K4K4aoxrbjG6tbIb0wqoD5oFjHldz9m/sLp0NoTrsAvhFWNdIr8bBugX5aYQAyX9TFyP+Kib5Zfwb/MBL4I/c5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136301; c=relaxed/simple;
	bh=C0s2eFAjgzRhE3+JjzuQJNvy+gPOyuBvhIv/luAsODE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQBbfK4qfKfY173qiIcgkYBh/3ofiN/W1UunsbSdGISx8ARBEzhE1C8j4SbkIpdD/usqd9oCVFeiHdjl9wrnzh9OIiP2uGj+ROR8dYttykp2nHfA9bCvYHjxTbbukxctrUlbxKyS3W5rlGKr0mAk0/Fc3OMghpTYG7PIFjdHVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BgcRkWFU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZXeGPSr; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BgcRkWFU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZXeGPSr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 53CCF13001F8;
	Mon, 27 Jul 2026 03:11:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Jul 2026 03:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785136298; x=1785143498; bh=Oau7zTBRfe
	BegPseqDZeDB212RGIQQLGKQmVFhznbEs=; b=BgcRkWFUH2cTGqyOJFRqaCdY69
	S/Exgl1z2l+FHhto0nJDiBsYtdJmu7Qw4DPme+W85EEXOxICs8Qox97f13xrjZXf
	Ch3MPSZYoUO8RnOj+yWbH+87c3FhYCYSzlj8piho2tmENk0z8pVoCWc5UVnLgOPr
	k+U/5MxVujDBwrfLAZfBOpG/kKN29Ue0szF6aBCbCMz7joj2uHalpOeAJxVXgoUV
	5jyOURVPXHxG3W1LZxre15Qr6yTdN0ila/+hysAdaUdEGrezqLboU330nnsfuWjG
	ek3WxEHnfrME4XWvRefx+hAS7ZjMOAa7NA8FVIGYPB/3hOTn3vTmwQ2WhhWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785136298; x=1785143498; bh=Oau7zTBRfeBegPseqDZeDB212RGIQQLGKQm
	VFhznbEs=; b=nZXeGPSrwXB4jWuArzgzSJBo1tVYTkRqPCqBOXX3bzoDCVrOmW3
	OstjmrQZmsy/Kw7WgylN9eCCD7kaD3NagBANj+gktbnVhH67gMZy6ZDGVgNFAko3
	NcgyVq/UCHu+zwoQ7+63Jffj++EOr5McyMaGguEh3wfj7zuafgcywsIklu/XDUmg
	Lfb1skb89DGVBy4Ua7zIkwXr1GMENLazQXFUvw5zQYK4sEp+5+2P8KLZ41HeFc2B
	5II7yg/O7h56SUKE1cYM9bQq7Vrx1V/bWygYea0rq79OEmBtR2LnAvWnEth61SSy
	HqVi6DxnQVuv+E7NQuUwEqGHUl1duUagMaw==
X-ME-Sender: <xms:pwRnaj5-ptMYOmYhc9EgW-ShQHlIl-5X4Rrj9Kh7J-J8GOWD57BAWg>
    <xme:pwRnahvkii9-kLUDF_iGnVJX0vfZGT9pEtEpOyGO7d2zBtOuw4ENywJcT5yG8S_Qz
    5-7eO3p5xP0dWBKRW4FDEpnO-IA-kh4nfM9XF6rh2Q2Ycw-NeI>
X-ME-Received: <xmr:pwRnahYczLuKNA_I-VUBBZpb1ZtwQ1GFR5iO5-P062LK1F7d37rJ_SL_p-MuLFK7mun9vXn6mmh7jLNsmzgduwGrlA>
X-ME-Proxy-Cause: dmFkZTFcCLGTTvefrkqyt9VNZWvOW1szuT+YRFxeR6Dr6jH/9g5UsOuPfyZrUbiQrF/WJ+
    /VKHPD2kBMZJXxgQnQf9KjPNrvJzuZ7HTi8CUPSfgqe1SniCRgRJ8Im+viBrIWe+IfBKQX
    28WULmlcQfs8OtOg3Y/hR76pvBYBWYgK/iZBWfTPByuUXUZxl/kv8eeFGiCYqQcoJTYQF8
    1AWS8FLzAsYZ5gZ95djKtlAjBgHRKDpor3aM3+j+jSyYQqj1cNFbCYvhQ2kCR5kRTUh0ji
    YX/p35vDiAYJHITMQNTfIVV4FQ3EAReQyrP58zETvuhqEmHPfPsCRBWoEooogIOBVLOhXU
    I0UbsbAqoudV0tBUuBS9hA5tXCLEPAsnz12YdyHuBXcb/fWPv33Rhp0l5sYqKXR0Zrog3w
    x2kFSV1qjrnW/5L1/sVDJpRPiakF5wldTqRBHwptGHcrnAZa3GKEYZVXjruFdbhrnVTwJq
    5tZEXnapVIkUP0uS2a6XtEDLjlhgbRRHleQ76xLMbWdzi7yM/fuI8c4CZRXhG0e1dCDMnh
    eJaN6HGNDkkiKFmV2NSVBeo9oWMJJSD1EKH3agDBfpUBRO+jBCLUnvdm2vLDBdNbjjg3A2
    6TBahsdjg0LPNzyMaVXPSOOslc6C8C0na3qDRRsnaWxrt3F813uFfFn+ETyA
X-ME-Proxy: <xmx:pwRnatvu3hnOLiNCSXKobVLM0a7CQ6OzftoiAtOoR-5PpLnNRjYZqg>
    <xmx:pwRnagBtNsd97MFgSAQv442vM-q0S5Y9mxbJEcDNicoRvvHq9zm4ig>
    <xmx:pwRnasNLpxHfXdUisBvYyEwZuG08wf3uPjRawKnf3yHe_sxKlvjiqA>
    <xmx:pwRnai61ccNFkFvHMMLxoAFGphz1plw79-l9IFjHquwTgtlSyIPlKQ>
    <xmx:qgRnarQurDVV25Cj7AskAmnYyYp-otAIA1QE6g3WgUap69g5NvrVqjnq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 03:11:35 -0400 (EDT)
Date: Mon, 27 Jul 2026 09:11:23 +0200
From: Greg KH <greg@kroah.com>
To: w15303746062 <w15303746062@163.com>
Cc: simona@ffwll.ch, deller@gmx.de, tzimmermann@suse.de,
	ville.syrjala@linux.intel.com, sam@ravnborg.org, kees@kernel.org,
	yanquanmin1@huawei.com, syoshida@redhat.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>, stable@vger.kernel.org
Subject: Re: Re:[PATCH 7.0] fbdev: fbcon: fix memory leak in error path of
 fbcon_do_set_font()
Message-ID: <2026072719-kissable-antonym-d31e@gregkh>
References: <20260525082741.600003-1-w15303746062@163.com>
 <5b288246.378d.19e95d82602.Coremail.w15303746062@163.com>
 <726d129f.53bd.19fa2601661.Coremail.w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726d129f.53bd.19fa2601661.Coremail.w15303746062@163.com>

On Mon, Jul 27, 2026 at 03:00:34PM +0800, w15303746062 wrote:
> 
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> Hi Helge, Simona, and all,
> 
> Resending this patch as a gentle reminder, since it has been a while 
> from the original submission (May 25) and my previous ping (June 5).
> 
> As a quick note, since this memory leak was implicitly resolved in 
> mainline via a recent refactor, this fix is specifically targeted at 
> 7.0 and older stable branches using the legacy userfont logic.

Why not just take the same upstream commits for older kernels as well?

Whenever you do "one off" patches like this, it makes backporting future
changes/fixes almost impossible, and we almost always get it wrong.  So
backporting the same changes is almost always the best idea.

Also note that the 7.0.y kernel is long end-of-life.

thanks,

greg k-h
