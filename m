Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013C3264EF;
	Tue, 25 Aug 2026 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636745; cv=none; b=JC54ozxpCLUflNLXHo6o6/e5iRsScVwvHKvOKIS/7h9YXLhR0HWFVk3Xk4l7pj+IPdNf4kPmR6m1WRy7LPMksXv8PaM2cj1CZGTzPatqroQX6PLJRf5QYrDaEzj5CskjjkCdj23hKB0SOLnjNkvAOAcoR7MGmV/zH2f4bWNsDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636745; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFScQvTWbKX+8wiemJkqxWsuSW/5Hdd4feYMJMfzo+0fqe7XfsbGSDrgLMOwD/4grcFJJ4Epg/3oNziiUzsESs8ZbW0qUC6IWyaxaH9hAXYw8Ea5lwxeanU8XAJ/Dh1aaktqnmVOd7NtmsmJo76o+kJY6K3TDHiBoQD7hL+2IpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1gBXtdUx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1gBXtdUx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1gBXtdUxee29dMEr2TkAvOTQnQ
	rxPKu3Mj01jC3UbBFRCcsWtAkXIlz5r1If0L8g77fYya6R5uD3Qalm11PlxZIz/Gb4TP+YVXm1dnF
	z2DN4umQJqFjeAttkvNCkF2VWPQLdBe2zZR+fE2IPtwUcTYelqlOMf6vOQirSW7nkB60e6cxGmxT+
	Tbmv3mmzJKaxBaEXwrjQiR/bGZSOxRzR4284ksNIMRimHdtvrYUSxA3BMBDKVwlCC8vJv01PP1l/k
	u4PAs+uzJ1DyTeQDaff7q7dIt1Rr/VKShdXK2StTlpG3ncDEk+lVCs1hghwqIP99qUFq0samxC4Mq
	TxvOlOWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyjye-00000000CZT-2hsQ;
	Tue, 25 Aug 2026 05:45:40 +0000
Date: Mon, 24 Aug 2026 22:45:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, nbd@other.debian.org,
	Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
Message-ID: <ao0sBMPPLvatG1Ao@infradead.org>
References: <20260824-b4-loop-nbd-stale-partitions-v2-0-9815a577cebd@amutable.com>
 <20260824-b4-loop-nbd-stale-partitions-v2-2-9815a577cebd@amutable.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-b4-loop-nbd-stale-partitions-v2-2-9815a577cebd@amutable.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

