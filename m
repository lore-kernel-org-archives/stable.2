Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865481;
	b=Nsh2d6twBs5GzFqTYowcRTKA88XvkYqa9XpFJ+CxXL2dDQpkad9s+jCYdc+4Lv/YHBvD
	 576F+JeAvqDqGI0pXzJwzL2PTQSRefLWayPpZSCzZ6+bu7QxNChFtyuKcNjADfEdEb6lT
	 npsjAkplhiPxxRGQJD0A5P/UgNH2G/9DfpPzlz6Uim2K1UObbENW5BoGUbZjsaaD274E6
	 O8lxJArrpKrdFmRltEb+h3yiBkJsDxlDcgaJdKKQRC3WXGB46B9aCIzNFgIbymr8EM95I
	 UZyhnFCuFqzCvirc+szMlzVbDdzcEDeldPrXZyXK4CcwdA5mL2FItHIsROC95pp3usA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865481;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=BQcU1b3Lzg9gPmx4by9SEdbMNxKX76HDoZEUeAthDpXxdx+VDEb8hvqeQ4ijaWtmkJb3
	 lfmTQMRPvZYN7CDcodZAeRzO5XH4613SYmDqtVmnNNtL+CeaMrhgSr4OZcXWUXBIgMwLb
	 RmR2YtbW3z+Msmlug+0bfdjQNnFrWkl/d6TF7a4/YZyS0OdCHYDRqhToFxuXPpqFmuX77
	 P9e8QRxDup0eyi0FQVjV9e2xpXPjGv64+070q3Npdp4INRWFvhGiRBRQX5MHYOxTRKhxm
	 1oz+5f5t4PtVNtQdLCEfKG7e2lTEA1tV0EPf63B9cCGUYi/CKpiEhtrvt11SrR4h8iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3911606A31B;
	Thu,  5 Nov 2026 07:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3911606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 380A968BEB; Thu,  5 Nov 2026 08:57:56 +0100 (CET)
Date: Thu, 5 Nov 2026 08:57:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvmet: take subsys->lock when forcing reconnects
 for tbkas
Message-ID: <20261105075756.GA18009@lst.de>
References: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn> <20261104030725983jzZdkZpfTBDh22QD5TL5N@zte.com.cn>
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
In-Reply-To: <20261104030725983jzZdkZpfTBDh22QD5TL5N@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

