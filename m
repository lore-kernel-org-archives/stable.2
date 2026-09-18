Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39E3FFAA4;
	Fri, 18 Sep 2026 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789775680; cv=none; b=FF+J5an2WLQPp/DYvQDpUjhHJJFeG5Q6vk5gsil9pVcWJGcOah7jfBlC5MDbIFHDUnMcvJYDie3BkDtAThzoxKrEXatoZK0zlupc488BUM+K12ggTPXj6ns66dW93SO4gBm+JbqMniwqm2W/fIrM92dDL7dI+wu/JWkcjxdt63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789775680; c=relaxed/simple;
	bh=KkYrC+VyJ129vVG0c1M+e94Q1PA1VVhgobo8fdnfE3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSQKrI1MCr2e0sJoA3Xe5QJRIBENOX1gnhjt/TIPBNUTkoGFg3varCd9FC8c9bD4UYY/WGPIwUsEefXEq/RikyUTUkm8bT/IFYo8wEffDf6jO5VncMaDIQkTSySSGjHR/7Q+KWi8B+qjGd+8e8HIn3H6hA/2nNHTqFHe1WuHLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI+BCSD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI+BCSD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C24C1F000FF;
	Fri, 18 Sep 2026 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789775679;
	bh=5n3Ww3R4PYb3U2Dik8qAMEL/ILunEErkQeQHnRuKj+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aI+BCSD+hUEz0Aihjmq5s63q827T45f0dU4SlX6R8/M3q8lD84o7W4C4dfexkp7ac
	 kr92EctSd/ww3fyDMk19LSbJWhXgRqLA6XHL5dJpgdsFjCPdXdNJ73UnmUgwNVgntb
	 ogN4aSRUFqWpI8ou4zL5+U3FJ/5Fg+ulEoGvyeMtGGVWhZ7ar9ZRG0mkbJApEjavIa
	 Yk1M7wbHdBQbNtoCU9w71iLzUeifHFKIDkJuDdajLt4y0LeWIkvW1ZqfhBcSzqy+li
	 Jciov+dziR40MWdkiYswQY62sJ0xWYG9D2Llbxs+7TQ3W8SbUj58gtnQaTBXb+mewV
	 gmE+SIIg6lzXw==
Date: Fri, 18 Sep 2026 16:54:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Petr Machata <petrm@nvidia.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jijie Shao <shaojijie@huawei.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Ruoyu Wang
 <ruoyuw560@gmail.com>, Jakub Raczynski <j.raczynski@samsung.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: sungem: disable PCI device on remove
Message-ID: <20260918165437.196b057c@kernel.org>
In-Reply-To: <20260916055913.2910349-1-lgs201920130244@gmail.com>
References: <20260916055913.2910349-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 13:59:13 +0800 Guangshuo Li wrote:
> gem_init_one() enables the PCI device with pci_enable_device().
> 
> The probe failure path balances this operation with
> pci_disable_device(). However, after a successful probe,
> gem_remove_one() releases the PCI resources and netdev without
> disabling the PCI device.

We don't accept trivial fixes to obsolete drivers.
