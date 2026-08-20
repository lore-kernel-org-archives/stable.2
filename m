Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD3442375;
	Thu, 20 Aug 2026 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229641; cv=none; b=ENqFsQ2jgXsYPxHlg0IMmxZ+iwK2bdD5m4EqO7v/Gi0KwtTtTeWH2fJMTkIncB/FY4FmjzALCUTygr8/4idwmbkyOPjQCcM9S7djZSxOe4R466EaysgCAWB0hvgbJ3kUbPjJULMRxd8ROevx9RfwdjSylitAkoE0Y888YGg3hos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229641; c=relaxed/simple;
	bh=+CLrnI6QozE3Chi0jE1AKG2QhdYDt9tGJmR+l0Tqqps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjq31noa5pCAYgw3qQxxkDYMHmYXYFGeAwgKs7R+rIyKIB0YrG+swzpyjlIHh+kYaclnkFOV+GXoK/rIMuIJ+hJnNM/PmVlWXHgNzT1nl/rcFO+aAHNz8ACdGJ3o6hJA8OAK/rxMP4C+T3YwgVK1sndgM0Sa3Llr3VxUymI3RqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Oio3762m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWs22ZRG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Oio3762m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWs22ZRG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1883C140019E;
	Thu, 20 Aug 2026 08:40:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 20 Aug 2026 08:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787229638; x=1787316038; bh=HHkMYMnPke
	eakbHaqDKa97BPRup14XFlGkMtZPGbznU=; b=Oio3762m+xJE6Vou0Y1Z9Eo82M
	p7/zBFTKmbr1LgM8GtAsPcdxwoxgaWz/51qusLRlTj19A6dZ4G87P21TRrnirR/O
	74y5Uf5BUN2uiB9IV6C6T9IhGJ5JJcsDyzpRt3nxEw2hc0txd/fq3bXscJj5zho6
	MLHfV2pGQVXejDtDYu7iq7IZO86Ff5v/H38xn4mniYsnF/PmRvzu91dJGFRby7PB
	ofvpdyTtJC6dbIqYu8Qf3qULETFavQQt3Mpm/TKW1I/j69KPexGPId7UKkR76112
	aYIoJ58heXnHRc9EhWP1aBxIdM5d16I0AWL/8SoFVC5SmoC0soS36HPB7ILQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787229638; x=1787316038; bh=HHkMYMnPkeeakbHaqDKa97BPRup14XFlGkM
	tZPGbznU=; b=ZWs22ZRGrhQI7GxltBC79wqrZ64c9jOqXS2cEvJzI3fpOXAqpES
	uVTdYC5H088nGus/IEcn8xEvAcCbIucZZfbr0lFxPlEqPkWRwLZ/IGvbrNWJYvph
	w6pHNSSyQAVsoD/W7gFddc/kWbJSnLnM2RwHO4DszanY5UaHZahJqpN5wxO5ARJr
	w4ProwuTRISDpC1ZmzJINzzw/3+ptK0EGvehE2DZCce20NUukuAdXRHcU/RJCqov
	/N8OSqMxyeUxBlfSe4z1yIQQxhZ35Bbzh93zmvrsCD2YGrp6BTg8u7say5yblP+i
	0kxZ26TjV4x5xk4xBAMoOv6KJwal2/diM5Q==
X-ME-Sender: <xms:xfWGatRxgT523weMose7njlNqJywhDjBDVCcxeDagsHpCYi5TX4Fqg>
    <xme:xfWGairCtqc_vmzDwwOdwX2qZ9rOBuc1O1dFJoykK8wI1e-ROArgjEln6Nt_TxwVx
    Gri_rwgnvp5hyhiNYAnVXmIxaVcgjrZLdrrLSotqA_6-k609oo>
X-ME-Received: <xmr:xfWGav2CxdX-jjEV8abNzwSM7imLl0TyNSy-mrwhEdWihEhN-hlbDD3qTX3OzOStNROvXyZ5ZZDoscajfh6octsGXWOhp8GIrAmRH26nnJI>
X-ME-Proxy-Cause: dmFkZTEhFlgN6PeITnv6jMsb0ROMIICe2s9VxzKVNf0KZZeawpQRU2MmHCbwl5HSl4rjm3
    UoZ784peHLIV8y62ZWHO+szmj9FZhOFaGQoGec7yTzPIr1HiMc2l7NIP7AMwmfq2tcZqHC
    dpf0gcadd6eiALfSc7lbJ3YQrhNCz4+aRFz3N9soV9i+H1QrGbvJTLY1tmOLHKm+X502Fr
    6lB3yoVs5PWkSOrHIigY2a5QjKmodkgqnhbg2pdagK5zDs2Jj6OuAJRdqf/w0pQ8sE0KuE
    lHUio9vqJ19KtQ+LowA6fe7YK2pCno95B4j4bh3s8PE2LV0Fp6zHSGWJQtR/sLqcV9ymMc
    ML7g9xVsbBwkdVnGzYDzXJxgKQ4qW+2XVLimgvZ0bET/Qkt+pVAYH1iJv5slxAujoeYEiO
    6qdv6fZopRfCaEu+roSH5aF8aODvtI9HjHdHdz9m6OUqIvAzEt52ZkaEniJPGJNAjfld+I
    340P66xwBSE2Zp39ucqVW/EXu4BD2pbaFCpEoGAS1EXPOX/Mr06T6bW9e/+Kb/GbuEGKf8
    nmnYhxcbQEgLHyd8FJn+H24mTMza5bx7OtorGBtbA5pW5xShDI60AZPlM78DG1wkLCXTtW
    HNuDhkWXoweL0k8QUH0hO/2X60FGH3ODIZo6KMlPVr1KYWt+hWIhczz6pbIw
X-ME-Proxy: <xmx:xfWGap5-NV04D_k2Q-KEO6Qr00lS6nNzPp8Y4TjXojuqf8l2yBbQNw>
    <xmx:xfWGarQWgkXsr2sAHrOKwZjGnVgPOd7ToDPBFF9fa9Kr1CWRDGpahg>
    <xmx:xfWGauWfZ7G6EjvDzAuF66hyiIJq1gnHDPbG0vHHe72r_b4wha7m1A>
    <xmx:xfWGagFpbeZ5K9BvzvviM9tpj-8gx9oZeJxSuXNir2hdGrMxl-xJrA>
    <xmx:xvWGakdNaTbQ2hzKYjAW4I_V8qfOiLNaefajEhboJAKRBtlNn5bfd-LV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 08:40:36 -0400 (EDT)
Date: Thu, 20 Aug 2026 14:32:14 +0200
From: Greg KH <greg@kroah.com>
To: Artem Dinaburg <artem@trailofbits.com>
Cc: stable@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 6.1.y] net: bonding: fix use-after-free in
 bond_xmit_broadcast()
Message-ID: <2026082028-curled-try-e7c5@gregkh>
References: <20260819165924.1184-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819165924.1184-1-artem@trailofbits.com>

On Wed, Aug 19, 2026 at 12:59:22PM -0400, Artem Dinaburg wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> Please queue the attached backport of upstream commit 2884bf72fb8f. It fixes
> CVE-2026-31419 in 6.1.y.
> 
> An unprivileged user can create a broadcast bond and dummy slaves in a user
> and network namespace. Racing ordinary packet sends with slave release makes
> `bond_xmit_broadcast()` give the same skb to two transmitters. I reproduced a
> KASAN use-after-free in `skb_clone()` on v6.1.182.
> 
> The attached one-line upstream fix applies cleanly to v6.1.182. The same
> workload completed over one million sends and 299 slave mutations with the
> patched module and no sanitizer, oops, lock, or BUG output.
> 
> The fix is already released in 6.6.143, 6.12.95, 6.18.22, and 6.19.12, but no
> corresponding fix is present in 6.1.y.
> 
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>

You stripped off all of the original commit changelog info :(

thanks,

greg k-h
