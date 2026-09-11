Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0036212C;
	Fri, 11 Sep 2026 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138996; cv=none; b=oRXUyx7yTNhODVU8btDB51g4wSsyZbf6Z3wPoYOOMwdAz74nci5LZ3MHuGUg41gz5Um8oiHfDOP5PvNphr/fUzGfO8yxZkmsY6jLgYdHFHn1PrByZoT8rJwbI93pysxikQ4cBWg4V+iO2MSUjJjzf7ruwlZdLo+t/KyIFn0It+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138996; c=relaxed/simple;
	bh=NtWTVquGIF6A3jVgsjHgY3Sb9j0F5MYubIQ9/EHOvQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6h0LOPiSePB24g4eNA/CH1AC8968IeqwxFeS8NCWmFScKD6bJZNQkRASn89qoLiLGF6PB1dpfQIR2qIIQJM2zEj/c7hFa0gxqrwTeanvNY/B1EDdK+mWVHGLokoeOEfD/vkz2vNjKZQPu/1GGskfPsiAq6JJbRjG0N88ZOECPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbeM/JGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbeM/JGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05841F000FF;
	Fri, 11 Sep 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138995;
	bh=NtWTVquGIF6A3jVgsjHgY3Sb9j0F5MYubIQ9/EHOvQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LbeM/JGDab4DkMoCpxVqado8u3MP6yLSvHpLbQ4FUMItpdQcRqigTnx8wo6TiVOZd
	 ThLZCyAvqZ3luvs/fQjZ2d91xu1grVyRt06tGtKGGnM0DGmNMW7Cucdl2mMse3ZprU
	 AO7BrUZ3/cl5ZIJ2ZT6amT3b5eWeV7CbuB2EamKsPAtMxSmKUPYDFebRTlupM3q4GN
	 ZF0dPrA4RRdB27/PhV0QsAxoEdq2NIcEuLqf1PBM+iPQ9k81nf+pRfPIvLQSMThdiJ
	 CyTi0jFugvJnKME8Ia1W1T1QeFvr+9U86Co11at3jOQfyl2ZiOn7U+yeqtCyZeRtG4
	 2qj8UZPVIMtlA==
Date: Fri, 11 Sep 2026 09:03:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bean Huo <beanhuo@iokpp.de>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, bob.beckett@collabora.com,
	Bean Huo <beanhuo@micron.com>, Gaurav Sinha <gsinha@micron.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron
 4100AT
Message-ID: <aqQYMR2uaKcHosYD@kbusch-mbp>
References: <20260904105155.1402065-1-beanhuo@iokpp.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904105155.1402065-1-beanhuo@iokpp.de>

On Fri, Sep 04, 2026 at 12:51:55PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>

...

> Signed-off-by: Gaurav Sinha <gsinha@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

I've applied the patch as-is, however usually the first "Signed-off-by"
is who the patch is attributed to as being "from".

Thanks, applied to nvme-7.3.
