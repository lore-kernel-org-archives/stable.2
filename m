Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15743F0A8C;
	Wed, 14 Oct 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998533; cv=none; b=pZTfCO1V5ptapRmkf43Ev8uX/fz3oCoU93tqpVsIc7rSse7QFNJIYhI87Pvevi8xEnicdD5J77vK4EIpkvYKcS+UehHKkmc2xy8aekG1LiYA9byk4vXJmQnsWtBEiiMqjOEN096VoH6bMXP2R4V+vlSnX1wC0jsz1DgHZ8BEnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998533; c=relaxed/simple;
	bh=qzJNuNpMKvuxOlZcT5ytuboFTfMltpMjxYdDolzKAxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uhEP4jn9iVGCmcBi+yzP+T59xkIoH3feQ9trp9J/rdJeDZoq4FjhpDWRx8n81AHeoepLaR04p8iqfPMmzC7nKwrfr3KcTNB5W788RThGR7xF/tkB9O9NcTnZM7AWmyt2h7ef1c22Vfn+Mn4q17uUeNRoVO0RcqkY0BRVzOrmza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2jIYNTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2jIYNTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1A11F000C4;
	Wed, 14 Oct 2026 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998530;
	bh=G7jrd6j2HHfccrTcJR2XG8qaTSUyrv31pIwKA0CdgsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=o2jIYNTg7CZm0lP1ImMbD/jymsXzmeamon9/JXrDnmuoPS9A4NotRW9YnBcQR0Yju
	 cfUTMOkzPt2pb81Skqw/C5J+3ueluOv5WqHf3jUESp6PIqXt8qbC76U2hwo/WMmDpi
	 aEVG6TcbwxJbziOh/0vuzMAKVUZsxMEqfG7zRw1QbXEKmivTzcMzFDmFzhcOy+x1tY
	 BJzTqmwHQadc3VPpa5813Bb3dJjnJCOcwL+qaW0Bs+5HbxxO4rQXZ8ug7qm2PKrO0Q
	 vG1h1Pu48JI3ik1Vq8/Whe4poOwK3Ixjr7SQkIdod3UgaOcCEgltj6ZoKEDpzvfLUM
	 XtD8Jj80PNW+g==
Date: Wed, 14 Oct 2026 12:22:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ma Ke <make_ruc2021@163.com>
Cc: davem@davemloft.net, andreas@gaisler.com, o-takashi@sakamocchi.jp,
	u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] sparc: Fix leaked platform_device references in archdata
 propagation
Message-ID: <20261014172208.GA1641958@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011103544.3237228-1-make_ruc2021@163.com>

On Sun, Oct 11, 2026 at 06:35:44PM +0800, Ma Ke wrote:
> of_propagate_archdata() walks the children of a bus node and looks each
> one up with of_find_device_by_node(), documented in
> drivers/of/platform.c:
> 
>  * Takes a reference to the embedded struct device which needs to be
>  * dropped after use.
> 
> The reference is never dropped, and because the function recurses, every
> child node of every ebus leaks the reference to its platform_device.
> 
> Found by code review.
> 
> Fixes: 5059625ed886 ("sparc: Add OF archdata propagation helper.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

I assume the sparc folks will take this.

Do other callers of of_find_device_by_node() have a similar problem?

  irq_of_parse_and_map()
  of_address_to_resource()
  of_iomap()
  of_create_pci_dev()

> ---
>  arch/sparc/kernel/of_device_common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
> index 7f2f9972b59b..0aae21c4b62c 100644
> --- a/arch/sparc/kernel/of_device_common.c
> +++ b/arch/sparc/kernel/of_device_common.c
> @@ -70,6 +70,8 @@ void of_propagate_archdata(struct platform_device *bus)
>  
>  		if (dp->child)
>  			of_propagate_archdata(op);
> +
> +		platform_device_put(op);
>  	}
>  }
>  
> -- 
> 2.43.0
> 
