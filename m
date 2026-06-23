Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5137B00E
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198293; cv=none; b=eIL5iHe0Fg6Jk9Ex4iifhMgRTDZF7N8zmaWb26yHcZjbnAFiJjIZ1ytqXG+h3MkXp/huNHjND3AoaDZ7kmGBdCgP97WBhyfFP84D5LLy4OLUDNadk260FsibBgCeYggj/eS1t0nvEag4m42EHBRDUlmVQC6xX/H3S5FAHEOePvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198293; c=relaxed/simple;
	bh=f9uRVhHYU17B9zzfziL6bvgeh49xE1v1kP5gfOKA8C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUdCgr5PRUrapoJ76aawrLgPAYn3/sq17ziwCNw1sCI6W0I2i7BpKyuFguzxyVGtFwFzLEgbgihiPbiSzcAXv5iF7YjUpGDt7fim4EOElHmGC8h/bkCXblBjUkB0hh9+rKtIltCbE8fXB9YXJeBBtGc68cIzgoDrAeWQ0NulhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kSxQbX/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kSxQbX/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD4B1F000E9;
	Tue, 23 Jun 2026 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782198292;
	bh=SZslgiHYIytRgporNs6J4T5vY52BKPX+0IjbDd6qEXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSxQbX/VFaoz98tYc03cuG7rUhhIUuq+N6okmdVdoJAg/zzqjebuoo1NWC4s8lRW9
	 XV6gXXe/MAFiZS96XTKH5MYs9r81VNwY2qddwRJKDuc+xNkvwjdAYLFEdiKFnoMqI0
	 av0vi8vmM/InyYxp4c3gh86HIwe2n9UGj4UeWBsU=
Date: Tue, 23 Jun 2026 09:03:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Faicker Mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: need the upstream commit to be merged to stable kernel
Message-ID: <2026062331-bruising-wimp-74a7@gregkh>
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>

On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> Subject: net: net_failover: Fix the deadlock in slave register
> Commit: b84c563
> Reason: wish the upstream commit to be merged to 7.0, because Ubuntu
> 26.04 (LTS) uses this kernel. Thanks.
> 

Sure, but note that 7.0.y will go end-of-life in a matter of days :)

Also applied to 6.18.y which will not go end-of-life.

thanks,

greg k-h
