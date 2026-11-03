Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701290;
	b=ywTGxx8Dp+W6jI9aoj/ZI9Iv/X0eXqKDpV3/gIu0Yd0HCn5k/EqtABE0puKz2Q+hU8b6
	 z7Ejka1B3MwteCzlC3hH3xMSzeTS5nNj0TCmmG+tWTbvmGAMYfM4LtKS4I3lpmE/nAmku
	 zgfCR40c/XVsktFhoSeiaOp36rfa0s7TipXjIrGz6TjI8V2IEyGC0N3V/lwUGSWdTOKTG
	 HnawbihQW8E0Q90hEiaX3T2Eo9d2CP2rciZCmP8echNnmJjWG+Ky7u6ZVACgi102jlNyZ
	 xG89wta1JO9PfKP2kwQTpyegX9gOcCysBK9PRZuioo5W/wSWPoOx76gHacwQf5BCY/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701290;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=D61LQm1SK94N39WtN9WApdso/cZfcqomfGKlZEuCgbQg7WtfMcwCji3tD07AS7e7c4vm
	 SAGHaRwW/DCycKlBgRnvcHU18f11GKgrka33sZlNIw5nhED/17xHf6F0txjbcmYUMm8nW
	 f5aaHcfVqPW2qPBEftoQDZA26T+vjIJ9fhPv9JfdZKgfBWsHphfHXkchwmJImbb9igMt4
	 Y5m716suhYJmfIYTZfgMTBCSaPaJlg2sHkINeqP5bFX+8ZubbLo3uysLnj9rVhhPKcVtw
	 BjXeCVIt+iQZxObh5qomrfnS2gTVvnzH1V+h8YEgaJVIBA+7ArkxC0gxaY/lQ5FgZWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DweTBmY1;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7703606A820;
	Tue,  3 Nov 2026 10:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7703606A820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DweTBmY1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DweTBmY1cNmyUPZugGftKb5dng
	HSj35TRD/5rNJM39kVgGN3vlplQHmifS91B5nbOYtVxVtb70SXCsuImxr+60dBKof8W+S/yCIAzan
	rngHgVkZr4FL5SRcYynyVFHVeGqM+zfB2ZyUore4tk+yjUCYQOw0tKliJD11NkqOngTBt/0JTOFZT
	pUDcXA4DUfrnSC79kyYIDquh+a5iGT/1/va7d9sS8XhwqHDfgKHVt2WcXQF5BC6ZFKHPOEPyQBJj7
	T7gsmIXMyvn772lrWUW2kYwfmci7esUy/O4DbC7GsnyBYeme5+UE6jQD8O2tN0xfhe3yMYZVKgUj7
	yEkbnGuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBdx-00000001yEg-1Shq;
	Tue, 03 Nov 2026 10:21:29 +0000
Date: Tue, 3 Nov 2026 02:21:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: end the request if getting a keyslot fails
Message-ID: <aum1qVK73tximkoI@infradead.org>
References: <20261029200110.1328103-1-ebiggers@kernel.org>
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
In-Reply-To: <20261029200110.1328103-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

