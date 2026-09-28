Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667235DA61;
	Mon, 28 Sep 2026 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578643; cv=none; b=HBJbe3vvrBP+kt/q1HWAjigZ7dpY5yzJEiKHO6ceF2L4GTJWyDfxer+lPbAO9FgzorFwCoU7GDdABp+oMfvy/LEN5XsVTzJ6TrHaeihNRqUvlml6SNP9JmVf1FY9XbkM0Jc2/B52h/7GXQcrfwL0rJPCyxCQzqgaaKt2ODkR0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578643; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3Y/NfkKFqXVq07qyh501tFp+GNKjw7pp03jm7Oz66pqPnIJAiAE+cDFLyMC0vTO2fOdbgeuupmzzDgJxEq//LVJ+thbDi8C7VtnMUewAUOVysphcisIzBg3AA6jSpQXkPLGEeyT6RX3X5GFAifTNrZ3JWJo41v6NDIY/o7yH40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3dw4dRPo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3dw4dRPo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3dw4dRPoG9nMb7t53Ao+OKUWDk
	+3oHLlzs6blkum2/7S+i+kRSA29V5HcoLET/wFUGx3khd8lNsZw/CaIts7M+eQmKG1uuBj0EqD6SB
	epkPZszCLkhaAhxqRS2eRZ5Km7QjNlFzY2+Kyzf5QDTtep4GLnxXqCH92O6f/hbfNb9pQv9tHoc1Y
	ftQzeObjCnbTJOLJaDJecDiMtom8D+oL8t/d/JkiaVc+H5w4BKSt4+MDZEyQTnU8zoea2NG3GMWTJ
	1NMjQXmemir/gqRZrmdJkTavt6bYkQn7dHQkIBXHUoRTrwPfx02STfj8VLrRCcrrEa7cqhlw1cRl8
	AmJW736A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB5Ie-0000000HV7x-3K6f;
	Mon, 28 Sep 2026 06:57:20 +0000
Date: Sun, 27 Sep 2026 23:57:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.com>,
	syzbot+afa7aef0c237038586e7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: make blkdev_fallocate() zeroout killable
Message-ID: <aroP0D-aLyqI3dVa@infradead.org>
References: <20260927051528.34698-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927051528.34698-1-ngocthang2710.1999@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

