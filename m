Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402142315C;
	Fri,  5 Jun 2026 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644689; cv=none; b=CQ8RdNssMMog/R9zH1mTUvbqnajlUMZY0Og6w7azMnGamj/CXVMbWSvrS2/S/uCtsuXJClk5YhzaKebgxM4EGPxfkDTUZgAsMfO2MLSmZZKamQy7h/Nd7oQA8TAfoYTnN6KhHsLwYerxTjAgN/3oVMRBigjmuyqsG00DfV8swDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644689; c=relaxed/simple;
	bh=X/Uwg7EAprjn29vGoCPyrsDva4WLvnzDbK4puoRgW1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsN/PjR+hovBvAN/2Nz/jqG482yrohtbB/DYXkYiLOeJemwViPeA7TItvUxnW0KMDFWY9A4E2GkkO1VrIfxAlbXkuv9Kc5HU7O27udsPxf+l/iOxXI/JsxqBVEOduy8v7DgTOIwPSnqzp/DPn8+4JPSNQ2kwtAjXMou+N7dIOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CYx9P3lL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYx9P3lL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X/Uwg7EAprjn29vGoCPyrsDva4WLvnzDbK4puoRgW1w=; b=CYx9P3lL312mmP2nhMr0NfxStS
	rwYeMw8laC9guLknZ2aPOtNcMbLZfNb9W0WHoZUzZ4WUy3d7plRjaWB3ER7IeqsbP6slh4vtNCRJq
	Y/8q9URjV6BbwXkJLLWsJFqol1Yl6orYLyZWA2RmX30/9JoI6L8SHLlBdNK4iGh1jMii+Qu4Zx82A
	gZDwLHxRkGb6XU6HUYCEXXGc4jN6RmtVbm+8SxHNF/UWEGzIfbNojcJUbDGwsQO3kMY6UJIQO3GKm
	HyDoZ8GYwqrZayc3j/TDDxZVXndgMbkGBH1sNKXaLF7j8oznSLsK2FsOLku83NaJBfUapHDfwWGss
	NCOV/XBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVP1b-00000000EoY-36qG;
	Fri, 05 Jun 2026 07:31:28 +0000
Date: Fri, 5 Jun 2026 00:31:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block/fops: fix refcount underflow in
 __blkdev_direct_IO()
Message-ID: <aiJ7T7M2v7x9jGsJ@infradead.org>
References: <20260603021035.3690601-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603021035.3690601-1-vulab@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 03, 2026 at 02:10:35AM +0000, Wentao Liang wrote:
> __blkdev_direct_IO() calls bio_get() and bio_put() around
> I/O operations, but if the I/O fails, the error path may call
> bio_put() twice, causing a refcount underflow.

What I/O failure do you observe?

