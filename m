Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6B3515D5;
	Tue, 25 Aug 2026 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636726; cv=none; b=cVHb9Wel1CuVc4t3QvoZf+GKnKNLs81Ml4t11NI8movMMF8zkNxd7QzSTVL7rfEP2kkHZrDjCnUfhM2hSaocuAMl73Xub9d8qAL3Ng/thb7QZaTThghgglmTQMXgE4867517zm/3DqymOZb7z3wK6uPyNq2EoDA00gixt/ZOtc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636726; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6N5qlPNj1jPapVUyLPhq0xb3gkdl/h54w74vd+5LT9ur16DQmig/Emrgth/IVctEfdq0KfEybFDaD30MCyifI7UqJ9BViSh4vVFXVTDfsC7JxLEyqcHJRCdzfnQXUTf3/BNhos9gjiAXlkCIt33RzNPO3AiAFB9i427FyqaWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3581k1gJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3581k1gJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3581k1gJ+HRv5KbrMWhsvR4HFq
	pXomKGTUi/u/WR5tL3z0pYEhZY3OdIT8OWQWvN+RIS0xO5a6BU/5NcwUeQ2dW8vZ+xudNwhj5tsW3
	iprekBR2M4Mycfuw4pq2cDxdeC6D/oOUk/HKCKmffiJpsoUEEZ/Ce2xtxd866dfVncKmq+ZKFSHNJ
	wjUyI/2BFLDyRavOc1fr81Ryja/FVbmX8UF0aoKjcxOI2NZjzVbWFO44we/zDPYkwG8uX2m//xFP8
	ztJ48JnjwbxP/3YTPv43tjxlH29wgz6/BBI5YS8DrjguDUqt4Df7KdzFSnIxyqNgDzudHFSLQNEJL
	r55JId4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyjyL-00000000CYb-2RBg;
	Tue, 25 Aug 2026 05:45:21 +0000
Date: Mon, 24 Aug 2026 22:45:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, nbd@other.debian.org,
	Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] loop: drop stale partitions on LOOP_CHANGE_FD
Message-ID: <ao0r8dN2TXGopyWC@infradead.org>
References: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
 <20260824-b4-loop-nbd-stale-partitions-v2-1-9815a577cebd@amutable.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-b4-loop-nbd-stale-partitions-v2-1-9815a577cebd@amutable.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
