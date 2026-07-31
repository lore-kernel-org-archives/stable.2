Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25144C641;
	Fri, 31 Jul 2026 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523654; cv=none; b=BsOZ+K41crfOcgR3BWXgXU22Y126MZRUOZmVt4+tizNf2O9HKPRSwvc7+IODNxpcX8yIgQz1orpINvpdEbohfT7MCEnA8m5oZ0iLYQVySez6w+bwzk//4t2RnpQ1qrge3PTw62l8iZ1qllk4SCUPeRlqP26pU7Vln2JwA6Cgm+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523654; c=relaxed/simple;
	bh=MVmUN6cvQNR9Vik+aqrg7gfIKX4sgnXQNCiuhrBNk/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnOGYwINgCsEQGWAYoBg1wrl3YOliz13kF13VVMQJM2ecUHuAiQeUcyGLSaKhTqXRsX4QGCGuiGxFy+rj4uzULCxU0mW2Vyfml4sTcuZEs2y9o+OMv1YvH+Bxd5S6coZfWh15iPU1xnzq5xciXGAQsn7QbcuBQOnEg5Y+KhSDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Ym4loQjv; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Ym4loQjv"
Received: from L30177.local (unknown [81.201.198.134])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 62D8FB00539;
	Fri, 31 Jul 2026 20:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785523638;
	bh=MVmUN6cvQNR9Vik+aqrg7gfIKX4sgnXQNCiuhrBNk/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ym4loQjvoeC3iUm0F6Dyn4Kb7pOQtbk0EFQFprKVCIXqQ3Ia37tPkyitxmf04+V0R
	 bzAPvOFxZ7od2Lp6qNhVBmreC5hcWAi78Sey0he5KtGHVQINS82wKVLoyKQkl9LgbZ
	 65YA+Sdy2QhbnTd9PW2GjO3yUEkjXYz0uP/039ZVWOnaKYsIucaGJ84vxpiTcWfEJ8
	 zymFLyawG7FsC//P+WJhwMewo4w3brQd8Er0ebPbMiBsW+2AvDv/Z+goPuLkNypGnu
	 TU3KzrWEN52uIGES5oafinoKCeulnbJGac6EzUPjg/l1GLQPtyYm3Fko4kKNkt5+Fq
	 o5jTCHlwUAXbw==
Date: Fri, 31 Jul 2026 20:47:09 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bogdan Purcareata <bogdan.purcareata@nxp.com>,
	Stuart Yoder <stuyoder@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: set dma_mask for the root DPRC device
Message-ID: <amztrR-CAHlMN49T@L30177.local>
References: <20260724-for-upstream-fsl-mc-dprc-dma-mask-v1-1-6f08af883195@free.fr>
 <smvzffc65xr23fyozcahv4ifj643hxd6rj6uu6pi6ikc2tfvqx@ik4vkhhjytxh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <smvzffc65xr23fyozcahv4ifj643hxd6rj6uu6pi6ikc2tfvqx@ik4vkhhjytxh>

Hi Ioana,

> > Fixes: a259ed1618d2 ("bus/fsl-mc: support dma configure for devices on fsl-mc bus")
> 
> Is this fixing an actual bug introduced by the blamed commit or are we
> talking only about the warning message?

It is just a warning message.

I did more test today. I reverted it on my LX2160A with the SMMU-less config and rebooted.
Then, I get this notification:
  dprc.1: DMA mask not set

Still the DPRC binds, all DPAA2 children (dpni/dpio/dpbp) probe.

In practice, it is more a cleanup warning/notification. I do not remember why I did state
this commit log that is few month old.

I'll rework the v2 per your suggested common block, I'll drop Cc: stable and update
my commit log accordingly.

Best regards,
  Vincent

> Commit 4d8bde883bfb ("OF: Don't set default coherent DMA mask") is the
> one that added the dev_warn.
