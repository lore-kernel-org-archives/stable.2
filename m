Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021273FFAA4;
	Fri, 18 Sep 2026 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789775758; cv=none; b=j2rk6JlNug/L2Fn4bISNXrH+h/vy95DyO3uDU8631k76lCy7Nf5Goe26OYVAd2mqJtpWgIBfpCV+zbD+pE5Gz0dkUvJbVhzT3FuJKuWob99y9gloRf4oXcWQ9M3i+pKZLcj6XQU88Bs75h8bDwgatdJFGu9CI2CUZInL7SEIH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789775758; c=relaxed/simple;
	bh=IZjgsioofP6mEB0HjIeoG/NJqCekguLttEz4/HPlwGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzBBt1TN6NQMFX9z2laYYG+zc5+1EQr7Og4cIcrYpdintga1Uh4gpfmn3PR2hn2fNpmFjZtddGbGrMYekuBbAQwQvzbaJA6vZLqmAXFjZRVhITe4nEYiaPgVlnspCYd3KwFoDqISmfEuKNqKx3Ya0NYAsHTyxLYchnSxyOzau9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoHFroeg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoHFroeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB231F00898;
	Fri, 18 Sep 2026 23:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789775756;
	bh=VU0n0fb/ImTWy2/iDVAElKp7yccMyh1tca355nHr6VU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UoHFroeg6L3WkLGMSF/bnNmcN3Xmhv3BakLwyl4y4TwzXPxF5YTXb449kzRLr79mY
	 uZitANbGjXX3x/rQXqlPTNvkZQ5GOtx6YX11P40A+djeG/cGJF8oPWvhWFWBzgbpTo
	 9UOeyig9CkoNWGZUGqhHw/XRwcborwt1UNf6z1l+f6D2zMb7SnFeJia3V73WMarWCy
	 gnDytR81u/NgFUZ0gyaUcZqkqPmUCUUJE22YXf4fhuU6GMMYJ28Jz3S3iSd866tm1l
	 fMcFTfiOrr75iN5IrYbTZ2K2SPBx0k1g86otqaZZfUHmKM8IisONJjJuE1bvi8/WbY
	 KoaGGPH6MEFGg==
Date: Fri, 18 Sep 2026 16:55:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Kevin Curtis <kevin.curtis@farsite.co.uk>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: wan: farsync: disable PCI device on removal
Message-ID: <20260918165555.2ed3bf2d@kernel.org>
In-Reply-To: <20260916063118.2924049-1-lgs201920130244@gmail.com>
References: <20260916063118.2924049-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 14:31:18 +0800 Guangshuo Li wrote:
> fst_add_one() calls pci_enable_device() to enable the PCI device. The
> probe failure paths call pci_disable_device() to release the matching
> enable reference, but fst_remove_one() does not disable the device
> after a successful probe.
> 
> As a result, the PCI device enable reference remains unbalanced after
> the driver is removed.
> 
> Call pci_disable_device() after the existing interrupt, tasklet,
> mapping, DMA and PCI region cleanup to release the enable reference.
> 
> This issue was found by manual code inspection.

Ancient stuff, no point.
