Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722F48425A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389088; cv=none; b=RHXojBAhtw/KwbAxYc/Gsq+TY/QbnUESPDGVb1cIeLlztUNy9CgLZCcK+EBSGdHxvO5dxnGRNj28vELAm0N4Wa118jhOBUlpDRUB0IEkziUv4IDwRQIZIHAWkORdjWG2ALL2vcHaODVug/pR2aTVJb/IaY3rrvO8/Vpn9aJiaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389088; c=relaxed/simple;
	bh=kYTbflMU/7X74RtThYfLNiNHageIxp+Ua/noBxhtIok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFwV3Cer6xqXOxPYFRQNM7eCXtZmvhEh03tSX+7qJf2hbRaJ0J/venXh/wx07NA/admafPvntzSh1xrvoRz5wHRs8YbRtHHHmqJi7z+iIKmkR9SYsY2yV1ybWKiSOYUsgICqZxrkvLSlF6TxRBux3FXVauY72+Yu0T17YrwbCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B43F260272; Mon, 19 Oct 2026 07:48:48 +0200 (CEST)
Date: Mon, 19 Oct 2026 07:48:48 +0200
From: Florian Westphal <fw@strlen.de>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, security@kernel.org,
	Willy Tarreau <w@1wt.eu>, stable@vger.kernel.org
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Message-ID: <atWvQFXJzJ434qGd@strlen.de>
References: <179235055956.10524.6485282696272965887@gmail.com>
 <atU2brRgmeb6ght2@1wt.eu>
 <179236182769.4914.3317139682579833845@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179236182769.4914.3317139682579833845@gmail.com>

Abdifatah Suruur <suruurism@gmail.com> wrote:
> Mainline closed this only as a side effect of bb061d3de4170741 ("netfilter:
> nft_byteorder: remove multi-register support", 2026-05-12), which is marked
> Cc: stable+noautosel and is not in 6.12.y.  Was it left out of stable because
> it is not backportable, or because it was judged not worth backporting?

Because of potential nft -f restore.file failure.
Very unlikely (it requires a buggy nft version trying to load certain
		rules that won't work).

nft 1.1.1 (which has a fix for this...) is now 2 years old though.

I think its fine to backport bb061d3de4170741 to 6.12, but your explicit memset is fine too.

In case stable maintainers prefer the memset:

> Subject: [PATCH] netfilter: nft_byteorder: initialise the marked destination

Acked-by: Florian Westphal <fw@strlen.de>
