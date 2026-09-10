Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04723A4521;
	Thu, 10 Sep 2026 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058008; cv=none; b=ZwtOO9Zu08zSeUCmaburiTRmU/SSED1N4p+/hDyDJ+2x2Fb1Qa5iRlNEcRGjTFDOv/yPVbea2eW+UFm96js4RBfauLwxMbDsAuGl39EJumv9R565rb7Zltk0IALrWxsLj/fi7XFdYj53lSi5FBIG849WWMuLOYz5niZ3RaRdWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058008; c=relaxed/simple;
	bh=M3mnXfgWOg4JQiLrdzu7yLIpUcS0bJKKhRHW9w50cnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt+H7V/19nYDVavOcrp5VygNNB9ROSrqbCG3x7Sk+9sofwCjMPMlYmPPM0QUgG5asW4gRK+UcEdFCvNq+2YNRwaxVoPajkZJ3bqQCbU7Q6ZPTb6n9iQ2lCCb/3sbMUcVDKu+arR+ofhwjbNThi8AkYzQ2OW87WJezRNMMU2iCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFrcOAu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFrcOAu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2671F000FF;
	Thu, 10 Sep 2026 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058006;
	bh=uSHre2gG7OZSqzyqB4xi1lJ7vlS1YCccHnyBIOXlf/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NFrcOAu2iTa8w/PVr2UFurrPa38N/EQOG4nRtgu11PGPHDM2w11m0HSM3xCm4pHAr
	 E2Cb6hIMSTmNewOxlBL6rZf+FezQDPKTz0CvyinkFaDolyTzZZ3F/j+EV8DAPQvsfw
	 bImZ8E99/pqGGLy4h1zbT7fTYDvLZjd0aCI/F8REtNNwgYxHsK0x4BLAMRD415dv8d
	 d8KI2jbXjIVVFMKzCNqazAYvau5IlwFaYO9zSwRhhbBGCBSTwjDJyVSsqfjnIIGIzP
	 s3P5JBoNUzbMWqkor3j8T38ukPrsR/kDgNtICkBaITaTA3/+D8XwcSzKhuXjLxDwZF
	 CUQEq746IAFaw==
Date: Thu, 10 Sep 2026 17:33:22 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas Tai <thomas.tai@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Heidelberg <david@ixit.cz>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: (subset) [PATCH v2] mfd: wcd934x: set DMA mask on parent to
 silence "DMA mask not set"
Message-ID: <20260910163322.GM1051768@google.com>
References: <20260903-wcd-dma-v2-1-189cff560a28@ixit.cz>
 <178905794984.1265903.6426238332027371571.b4-ty@b4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178905794984.1265903.6426238332027371571.b4-ty@b4>

On Thu, 10 Sep 2026, Lee Jones wrote:

> On Thu, 03 Sep 2026 16:42:05 +0200, David Heidelberg wrote:
> > The wcd934x MFD parent (a slim_device) never initializes its
> > dma_mask/coherent_dma_mask. When the DT-aware children pass through
> > of_dma_configure() this triggers the "DMA mask not set" warning for
> > each child.
> 
> Applied, thanks!
> 
> [1/1] mfd: wcd934x: set DMA mask on parent to silence "DMA mask not set"
>       commit: 5a5f978cf3cd2f50b9e123f851f5c6577519ee89

Note that I changed s/dma/DMA/ when applying.

-- 
Lee Jones
