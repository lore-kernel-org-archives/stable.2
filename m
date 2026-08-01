Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38221A42D;
	Sat,  1 Aug 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599663; cv=none; b=eE2CSNOPKPh+w1vEq/H4BxRGaIf7kLEw3Cg0VK20Z5/9vGFAqQXOeCDWset4/wqNKEe8P2y/cQSPs9TCqJqxlinxj7Go0r0ceSrdMOGVGcp7WZ4oOijswV2F8Eg3naRL4kNHrvIoEBjPAxfjS0v44CUAdH2mcWvAQRnwrtvRZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599663; c=relaxed/simple;
	bh=SKisw8tkG/fCavr5Xi+e0zlbvz9q5Fw69Dg8+N0Lbos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2ZZI8oj0hgkq8owQeBsOlJasYvjrX/hHMV0BHvacsZbQmgkxzbfv+IfSDJMQE2RK5HA1Lq6s4jpgbn7GFK7QIMB7J9fPYFLrgzPT9JampLWzjIEujFMWc0iM10nDrS6FFFlgxEll5XmU5ATWKG5d7Br0PReKAKdDgmBfhTpwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cu4Jgqbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cu4Jgqbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90BF1F00AC4;
	Sat,  1 Aug 2026 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785599662;
	bh=SKisw8tkG/fCavr5Xi+e0zlbvz9q5Fw69Dg8+N0Lbos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cu4Jgqbq94QxFzsn6m3gSqr1QE8+h4HEktDAivusulQQ03Oa4fdjsroeaQk8kvX9O
	 qO56H7da1+NqFcRQxbE+YGhsZyBExGuDltn0AF0/GaTohw5BBh2ArUT/wIT/2j2ps4
	 yVyOfejNsDrBP5fo9Hv3pazGaXF0vDjCIGjpjaLU=
Date: Sat, 1 Aug 2026 17:54:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dongxu Su <hj117@sz-huijia.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add Voyetra Turtle Beach PC Rematch Gamepad
Message-ID: <2026080135-greedily-showplace-116d@gregkh>
References: <xpad-pc-rematch-gamepad@sz-huijia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xpad-pc-rematch-gamepad@sz-huijia.com>

On Sat, Aug 01, 2026 at 07:30:49PM +0800, Dongxu Su wrote:
> From 4be43c8ce8bfae20bc6126f8c6a4aa4f8444812a Mon Sep 17 00:00:00 2001

Something went really wrong here.

Perhaps use the tool `b4` to send patches out properly so they don't get
corrupted?

thanks,

greg k-h
