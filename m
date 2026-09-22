Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9AD542EE8;
	Tue, 22 Sep 2026 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081318; cv=none; b=LTH3JHnT/n7nFp/L2vvHVfpfsbqa1WVZhPpwdes8f4V+EwWWUE/aH90WAPBp4UlNJpKU0FFq5AIJsRnE6+LRfXbTOy3jD/izfo5FWSyJDXNXu/eOGwH9BWRHFv86SDNsgmySMGUQa4kBF1w0BD/fYZ7pvq0iEmI9AZ8OA/eC/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081318; c=relaxed/simple;
	bh=NCFWg+kcaSwFg2EVbYFbZdOdpWQY1hayFPx+qEea7Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo0X0dSciphlvp8hHRrO9LzEC5Ba7dTXDaHaRt+HEwyLKZxBcd+ognRlveEINaN6R9Zdwgz1YFRuRcdpLNfwOmFDqb7ba+kX/i1+xFYzZsB9QZfIyQZn+duORVxxpEnafCrtmRDo/cRaCbQnH7xqn4iYZnFDcGu1pGY36QJ00Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4KD4mA5q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4KD4mA5q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s+Tv/KNbzYtfGmuVjgMSs8v9UCgfv8RtrNbqZ5747F0=; b=4KD4mA5q1dKLIxig9MDWVv82pK
	AreoaLLm95hrEZ8uKPfQIjKrL8Y8kNDiryoF2/LwGdT02Vkqn0moMnWjmn/96GmwCsc/IB1voy+4h
	TrfjXRbHDoVLUWb4GiyjDf6xEqyrWAN30lL/Kt0RGTGXz507hfl8kJOTS3FZco6N1+g6Qhm3EOGJl
	xJ0fnl2clupT0WibzdwaHAwOQ0/x3nalSR7+Xg0ONULFGT6giKCficVENkmdJpFKb6MfzASdlLCRM
	nBXjtay2/X4iXJhnR4woPZfLsEj1ymHXlqWrivZ0gGrHX7aZYL5MX7MPQn4gQ6XXGmXhbFdN8n/90
	paDQrNOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zvI-00000005MIQ-1XPx;
	Tue, 22 Sep 2026 12:48:36 +0000
Date: Tue, 22 Sep 2026 05:48:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org,
	Henry Hu <huhai@kylinos.cn>
Subject: Re: [PATCH] blk-mq: set RQF_USE_SCHED when the operation is known
Message-ID: <arJ5JISABWd7uahn@infradead.org>
References: <20260921212624.1942234-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921212624.1942234-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 21, 2026 at 02:26:24PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The cached requests are allocated for one operation but can be handed
> out for another. A passthrough command has RQF_USE_SCHED cleared, so
> using those flags for a subsequent read/write bio will insert it into
> the scheduler without ->prepare_request() and frees it without
> ->finish_request(). For kyber, this leaks the domain token acquired at
> dispatch and stalls the queue.
> 
> Don't set RQF_USE_SCHED based on the first operation the batch happened
> to be allocated for. Instead, set it after the request is claimed by an
> operation.

This looks generally good, but also a bit hard to follow.

Notes:

 - mq-deadline refers to blk_mq_rq_ctx_init in a comment that needs
   to be updated or removed.
 - blk_mq_rq_time_init is always called right next to
   blk_mq_set_rq_sched.  Should these be comined in a single late
   init helper?
 - AFAICS the op_is_flush check removal is enabled by this, but not
   required, so maybe move it in a well-documened follow on patch?
