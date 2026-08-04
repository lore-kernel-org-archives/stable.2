Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3B3DD861;
	Tue,  4 Aug 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848753; cv=none; b=r8baJfTc67qoTIJoBgLTbT2FGjQlGNI6zJWRMF32sOFKtfh4da+MphYx/T+8w6QAynhawyQdFfzRtntmmjHboWMfC8HNat4WQaJGrFoL+AI1Vfkn3j1+6Zlu2gkZTAIa1usEviOyEeKpw3B+Zz4I9mHn4rMJaG63SMdGJk05E5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848753; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI4LKDxFkwbEE/iXoAmr1TTDBjntrqHl9KPdXBcnHePbbRILIONyjBZBfuSM/nqrS+BYruORD1UEwspY6GWccmXGXhfCfoUeSRSParaDWM93rqAK2HtOWGT6r9h7k0SjDiCud+RUQGiAWkRpi+8/R1wCEV/77a7RkGea1ngRlqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C59B68C4E; Tue,  4 Aug 2026 15:05:48 +0200 (CEST)
Date: Tue, 4 Aug 2026 15:05:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: dlemoal@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: block: zloop: clarify capacity
 alignment
Message-ID: <20260804130548.GA7606@lst.de>
References: <8da2a239-e074-41f8-8d8d-552b1652edfd@kernel.org> <4659F8F0C6C328EA+20260804052942.1186727-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4659F8F0C6C328EA+20260804052942.1186727-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

