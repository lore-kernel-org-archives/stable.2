Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF33486E71;
	Thu, 23 Jul 2026 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832169; cv=none; b=Ev8COYjukfdenLFjNBL0nURrWCnQ17Vq7QJo56lnLi3aHQKU8GjntmHgfR0kV2rWy2kmMOXCAvGRwLJbu/y0Bo+hyrKHsNvlBeWfrZVSlExNvd6t/Z4DARDTncacnxPgBh+jV8+wPnqfmnOaWF82fTWkPpYq57O84GyttDy6sxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832169; c=relaxed/simple;
	bh=ardEq7yeuDVzjAWmhKvljSKRY5cuItCxKLd2Lrcc7PI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5rbw5mLwiNGQCIrC+LLVDzuEuhUTArmwQFepWlcqIvXu5GzcYIgV72O+SSmBRtwAzmuyzIHSk/j1rfkYR/CwfStLOCWaqiGTT6/2Kqyk/8WNHNPLOswJ5e8V7uRzB12Lo07zAcxynIHWBOPhsdFk/jYlO5kRg5t8j5vyws8RPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG6UZfKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG6UZfKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78591F00A3A;
	Thu, 23 Jul 2026 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832160;
	bh=6OrJ4LQv/v/rwfPFYr9xGGbCbOXjpbIbPh1WaZGU/mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nG6UZfKey64+plhmre2Deoah5H6u1LVm/R6xWw45qqTdNMVWlOfRxr5Zn3apLOtvt
	 Hs0L++wdaKAiSn8ZT0Cr22vgn1n2ACN629CeAjOWqBhIVHaNo741R6yheTy7SqfmLA
	 pi0rw/7zk1dOabRqvCGCFa0HkSRE4Pb7STbkrZPtyk/7TSGhV1jgwCxz3cCa2NzZvM
	 W9R6NQpjMwjKFW9nc7fXwSMTknBM2PXCT0bDMMZFaCiEKdjLSOJLH8/M/U/P/RExKd
	 7G8CvVw4dzl+cQq0sswH7PP2YPTZ4k+ZDYQTo/y80hrXs5EirhWHCSDC9kQFaEk64y
	 5vF8LsWf/byZA==
Date: Thu, 23 Jul 2026 11:42:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>, Oliver
 Neukum <oneukum@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] usbnet: cap max_mtu for drivers without bind
 callback
Message-ID: <20260723114239.709d2477@kernel.org>
In-Reply-To: <ce31de54-d46c-4738-909c-91ef229b7d9e@redhat.com>
References: <20260717151626.2913171-1-lvivier@redhat.com>
	<20260723084319.40fee97f@kernel.org>
	<ce31de54-d46c-4738-909c-91ef229b7d9e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 19:20:30 +0200 Laurent Vivier wrote:
>   	dev->hard_mtu = net->mtu + net->hard_header_len;
>   	net->min_mtu = 0;
> -	net->max_mtu = ETH_MAX_MTU;
> +	net->max_mtu = dev->hard_mtu - net->hard_header_len;

But we assigned 

	dev->hard_mtu = net->mtu + net->hard_header_len;

two lines earlier, so this is just:

	net->max_mtu = net->mtu;

is this the expected max_mtu for most USB adapters?
I suppose so given the patch under discussion?
