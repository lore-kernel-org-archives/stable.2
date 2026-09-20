Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F03932D5;
	Sun, 20 Sep 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896318; cv=none; b=N4UoKGOzcqVaCDZgMq9GEKZZ6qamOzXkc511z+4AngljhAy5dervnslUTfc+O+dtPXc8QrtvzphRsk7ItUGYtpeI3gnF66LT5CNw0XBGZrk4iZAiGPXLe9lhPzRDhNzjQjIzEl/8nzT8GrLb+GZH7YL8mVv5JpKigRqElp7wCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896318; c=relaxed/simple;
	bh=jj39UGmFAP1ATY1sjzFqXoZoMqUaZdi5Tqpaf1UuAX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9RPAFsw6usCQctpBZ/SktSAOKTRLw8GFStdyRgLiMyFXqnmjcOTl+p7a4iek8Vgxd9bwU4nmEkfK7mVfMjdaQW8xnB0lr0zO3/rCUVx1QTOg/h9CYiPVWY1V0Kg3ZthO7/c1aAGV/Zok4orvug9kXKUPpk7j+SrnuHylBTQiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk8bFvoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk8bFvoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9531F000FF;
	Sun, 20 Sep 2026 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789896317;
	bh=GUbaYNCOK/O2eUbWGPCXeD5NpWqv2DKIKRLqPhJXrTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uk8bFvoyKicjnKjJHGS2jiEwQtSpIkKs5qZl3DygCvAiP/sit6gB4xCbjKvow+O8u
	 nsYQcsdvpdlakNDV5xW1Tt9EFGxuESJgz3y4K1kSOmZNTkfrWjooZkAHsy/6Ks9ar1
	 FwtQobr1wul4EZUVYaSzWom+NpofgAkwFNXHlbpspHnmu73ltiLtIfa8wmLoRidZjt
	 m0HqadHn/5bWOxRZjPLo0Lw5wvsu/btC56FnBirRbodDEVEgvJBnqtA1cjBbX48HtM
	 wSJJjP4kQPaoJBoXdfn5e2ql7WRuwprpSoTbFQBGhy8j1X1x6ZlwOhQc/ZqMoeLG7B
	 z1g7UKGjnSzxQ==
Date: Sun, 20 Sep 2026 10:25:12 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, mchan@broadcom.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	pavan.chebbi@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH] tg3: Fix peer device double put in tg3_find_peer()
Message-ID: <20260920092512.GA13925@horms.kernel.org>
References: <20260917105104.2147646-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917105104.2147646-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 10:51:04AM +0000, Wentao Liang wrote:
> pci_get_slot() returns a device with its reference count incremented.
> When the loop ends on tp->pdev (which happens when the adapter sits at
> PCI function 7 and no other function is present) that reference has
> already been dropped inside the loop, but the trailing pci_dev_put()
> drops it a second time, underflowing the refcount of tp->pdev.
> 
> Treat a loop end on tp->pdev as single-port mode, just like the
> existing !peer case.
> 
> Fixes: 16fe9d74f14e ("[TG3]: Fix 5704 single-port mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Hi,

I agree with your analysis of the logic.
But I wonder if it can occur in practice:
can such a device actually be presented to the Kernel?
