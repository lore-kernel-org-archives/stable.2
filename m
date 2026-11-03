Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700342;
	b=HBaEETGG+tlU4ZlSeCePRj69h0ibHr1BbEoihP+9i2vx802N/gTqxRB0V/rT35AVbfmj
	 zdgrRvbNP0sH2Q/Wb3t/CLVdzyp7YLO+c4VSZNVvaTCIFRxYXdtIP8vEdcPh8rexfBJYy
	 JCaDIXq8fpzom96YDJG+OZK+j/Bkwk/uFCr8mSNxdN0dvIZ2X1EEyl3hjTvtIv94WY2fE
	 Rfbq73ZJQsIs3HL/RBDG1/1k2OW5LFSP2ynHEwdGQULrkDVWUrfpab7KEwQWHagihE9GK
	 jFuI6Pu/ZwZwdi8Nr8sBIbEw5fno+F3gZ6UHjaxbK1Teb+gteGosoZYilBKNtW9pMlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700342;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=sZ8iIiaepkG9ZzJ/n/c+7ROgmVKkehmYoWkgnkqIwTWamhYPELFWCPk2MhF0uYki3ycC
	 8ewVYQhlvHjPrpImqKu83L2uKDGqZI2Dbxc2vVkVP7oHs0/rMDM4xIXSbCqy8Y1JKlIEc
	 o99lNrLy8WF8FQ719U7F3trMELcUxtzZiMEhoGkEWC+KvVGcJdvcpJput18yxaGyYUQG2
	 dxGlkyx0/l7bwhurAyCBc3+Vyr+pSNfaVyAmiFMbtNyJ8yOiVsuB5+gkYifu6M5fqRoSh
	 B/7DOlUaMOXYcvF6vyL5ObgG4P857hghsd+sGE3nBXOB13pAJNfBr5yR1+GvUefeISw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="rBe/U6iH";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF160A6F76;
	Tue,  3 Nov 2026 10:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EAF160A6F76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rBe/U6iH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=rBe/U6iH87B0qY54XpJ15tczz5
	WjXEq5V2yu05cJftNIUkU56GDu3kh6sRGL8+ioilyfGpgpJeQCXlxWvsIuHpGDDllor2S+NENnQIK
	nMXcnWQ7IjltbuIsSeQ4iARBnaZVqFEoqNNzwSoBPFd7VoluptQ023hJTp7ZTqndlXaqB02t0exhs
	8H9zIgxSJVFmDkFUkizRU9Lc1EPVCgkPFqLLr7TYCTx/VeY5dlLY75n+qMDR+3XJGrYNdtvmUNQGr
	UJzVSo2pjUpprKXKpxbmDSlE8n8y2dQIriej6hX+mXTjbzL6Qqy2JLOkvmtufPGazrkuG/1YupW/O
	5J1QUnDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBOf-00000001sNo-2nyM;
	Tue, 03 Nov 2026 10:05:41 +0000
Date: Tue, 3 Nov 2026 02:05:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: axboe@kernel.dk, arnd@arndb.de, ben.hutchings@codethink.co.uk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Return the soft block size for compat BLKBSZGET
Message-ID: <aumx9cUHc82OE0zZ@infradead.org>
References: <20261023153645.37546-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023153645.37546-1-dennylin0707@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

