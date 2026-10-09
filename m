Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6F3164BA
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535611; cv=none; b=cnsE3nM/V5kk26DypkAmLwpkeaLS1h0Ed5DZOUr/QoOXbg/dmJ0IObf5h1qEFZ/yBNnHJRMwAZz0lwKH/Pm2uSbAWm2hmRZ+6x6PrWeVpmd4PknELIPgkHifpWflR3xQA4Z2SD0TftfiGDMse7xY1YcBaRcfmMtAVqh2XBEfFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535611; c=relaxed/simple;
	bh=EeRW7OuzFuwtX3+Xf56mlHirqXhOKUolGPXCmrOrm+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhShKTjOinMRX7xjRnN2hlDYDHtMHkK+BBCnSNeRIeAopw24Uq6Sz3s9PKjfTx0L9VEkIcIgP5XZvsrcrKWEh/S0fuOYJ43ev98BATpvGkWHMkrbm5OXcO75kqG/qZGTKbgZGn3LRvsIB14uX1LGQBdOHzw3ckoh95d6gMOiUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00448550d0471e54ea.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:4485:50d0:471e:54ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7770A1C77A3;
	Fri,  9 Oct 2026 10:46:49 +0200 (CEST)
Date: Fri, 9 Oct 2026 10:46:48 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>, 
	=?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Catch scatterlist length overflows
Message-ID: <asip2Nv2rCRE4mPH@8bytes.org>
References: <20261002053320.3145901-1-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002053320.3145901-1-krzysztof.karas@intel.com>

On Fri, Oct 02, 2026 at 05:33:20AM +0000, Krzysztof Karas wrote:
>  drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Applied, thanks.
