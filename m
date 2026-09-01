Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31723B14D1;
	Tue,  1 Sep 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273356; cv=none; b=SMnOtoM2k2XAHVq5goltSHogUGOVeN0mObGp/TIpw54Fm3RwDA2Uae7MsDIS63x5sU/VS8qVQIbtJG2UBeLYBeBvfSSxCPAH1RQB1DcYurlOgsmuVSGBq2QWKYLj8P2M3MFhLHusf1LP3j3l38iV0Xndy/h+I0yVXC2uUvVn4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273356; c=relaxed/simple;
	bh=P3TjuBvFJPZemsaJmlsZMNrmTOgU63HvxnxZnqKM+SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/+gNS5zubyf3bTmBs6crGrl3nX6B6okdE7dAjoyw5CedHa36CO4aWNiWk/ihRTFNKlj/xZtu0RrvOdl6oMO8Cv7xgLCxqJZlwGS6n4x4gbuTKy8EzQq+FdSNBAxuHVSD8xGGXVc+E6iIQQ90m69nv/42yCjYmZpVZcMNRlknRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPY2+esj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPY2+esj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E9CA61F000E9;
	Tue,  1 Sep 2026 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273355;
	bh=tJ6+qdbPvdB1RAX0UEOl529lANAE5oQJvqgTS31ORE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iPY2+esjBbHHeTklWsZc3nDGMaPmGGNW7/yRN61qeBRi8HI/+MaKtcgI+Sj0UtgMf
	 Ltt5YPCodgw8akYWSDqoQfKgNY2tZPRrBc94SXf/4c5lOkFyO0/WSHjCkTAAXdxTFd
	 nVEEEeH/U8qDWAYDzu17b1XLE6+iLtRVMcljQATRJak3qDDrWSVqnwoT8GJpnBhpDL
	 edT+toWKFPu40SOzSFzJK2wyCA+YDfGGqx2E7xB+fIjAl+TomQcgLlVIRMWdvQpJvu
	 T8JcidDFqJkog7JCD8v22Da6nwyH7bQr6knJKdqzhfh6eTa6FeMX2IS8Hj8zUtUV6D
	 kulDogr4DLMDA==
Date: Tue, 1 Sep 2026 17:35:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: MicroFish <f13208471983@163.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Message-ID: <apbix3Qb-DD_KdrI@kernel.org>
References: <apDseLwm7saXAdbd@kernel.org>
 <20260828111141.1515-1-f13208471983@163.com>
 <apbLwhETZei6Lhi9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbLwhETZei6Lhi9@kernel.org>

On Tue, Sep 01, 2026 at 03:57:43PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 28, 2026 at 07:11:41PM +0800, MicroFish wrote:
> > On Fri, Aug 28, 2026 at 05:04:54AM +0300, Jarkko Sakkinen wrote:
> > 
> > > Cannot and will not move forward given undefined and open set of gear.
> > >
> > > There was also a corrupted email address in the CC list (microfish at
> > > kernel dot org).
> > 
> > Thanks for the review.
> > 
> > The affected hardware I have confirmed is the Lenovo ThinkPad E475
> > with an AMD APU.
> > 
> > This is the platform on which I reproduced the ACPI NVS and TPM CRB
> > MMIO region overlap described in the patch.
> > 
> > The incorrect CC address was my mistake. The correct address is
> > [f13208471983@163.com](mailto:f13208471983@163.com).
> > 
> > Best regards,
> > microfish
> > 
> 
> Please only claim what you have quantitative proof for.
> 
> Also this is faulty:
> 
> Signed-off-by: microfish <microfish@kernel.org>
> 
> I'm not happy with the code change but I'll try to propose something
> once I have the bandwidth. Need to think about it a bit.

This was the itch:

https://lore.kernel.org/linux-integrity/20260901142955.187856-1-jarkko@kernel.org/T/#u

Once that is reviewed and applied you should:

1. Remove crb_try_nvs_fallback
2. Refactor crb_map_res instead.

BR, Jarkko
