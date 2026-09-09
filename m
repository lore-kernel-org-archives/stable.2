Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51C481A97
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960439; cv=none; b=g8HDxXP38T4jElYoP7CC+neptUOgEBWVsjKVNuHYGA5otB5Me/k3F1TtjYtL0YfmEKEXRYkFLMIipBoaVm52p5kgVal6onkJyk7X++By4fT4l9RXJ/bF8Rxn0V3PkipRSfXK8mA6QqOBrp0g7fchJMMEFE6wwcwb0Bppi8S0KGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960439; c=relaxed/simple;
	bh=yZ7mANUqGmZSfjNBu8Ed2yeqsVD2FFfgvGjTK8gsVb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTkjiaU3/CMoFv4g7tw6OyNLfPqLJwNmluafmA+WEdiN2p8pV1cV9hAATQT/4TsGi0d+3x1HpVdQ8bEUx7VWgeKMwtf8LmfU1AnfXY/X4pvZCTiovaPjj0sdtByLRUqyC0bsGfiOC1wanNppx3MK/SoJtmguELk2O5hluay1l+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qc68A5hX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qc68A5hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01401F00AC4;
	Wed,  9 Sep 2026 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788960433;
	bh=3UAiTYPHOkkDm5m06H4uLgy1RfAhzvsdFHUvh81i4gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qc68A5hXQ18FBjuXLuwBXHmpCxMxOaBUf8vEMjoI2ajIcXZ7/PtXh+0lVHJu5241F
	 QQeQrOFqJk8/vXk8HxjofiMja7it6yUAdXHRVUS9TPYSzThzf55GcIsAA2x88QlwIz
	 0WJ7m9tWPNmUbZMeQhAsjRGpyKHcMEu2aR9U9ZjU=
Date: Wed, 9 Sep 2026 15:24:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Tinguely <mark.tinguely@oracle.com>
Cc: stable@vger.kernel.org, Siddh Raman Pant <siddh.raman.pant@oracle.com>
Subject: Re: [v5.15 PATCH 0/3] xfs: port fix unmount hang with unflushable
 inodes stuck in the AIL to v5.15
Message-ID: <2026090954-revisit-dowry-37ee@gregkh>
References: <20260904161002.51054-1-mark.tinguely@oracle.com>
 <ff3c3a3a-2992-4607-aecd-0821ce3c8638@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3c3a3a-2992-4607-aecd-0821ce3c8638@oracle.com>

On Fri, Sep 04, 2026 at 11:13:33AM -0500, Mark Tinguely wrote:
> 
> LLM flagged the need the patch
> 
>  xfs: fix unmount hang with unflushable inodes stuck in the AIL
> 
> for v5.15.
> 
> The patch has the following prerequisites:
> 
>  xfs: rearrange code in xfs_buf_item.c
>  xfs: factor out stale buffer item completion
> 
> The conflicts for v5.15 were minimal.
> 
> Mark Tinguely
> 

Can you send this as a proper series, AND also correctly send backports
for newer kernels at the same time as you don't want to upgrade to a
newer release and have a regression, right?

thanks,

greg k-h
