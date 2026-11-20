Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188491;
	b=h2obWuszPCJoqzmwLhxFhqpFaWQCmco3VEsDGicHLbYywVn+Swcu6xUoDT9IabtoMgJK
	 u5THlcIawFlSPWw3PZ7XngpF1RWfXNBPptgavyTuoqVuz+Sb4UzEoMOpNmvoh3VPKgDoF
	 0V9nw+O9TCg9wC4z42VQ4r4h7yPC63Hy/kxyGCmfYHQBQeqz7eHyvdt8RX3imI0UlcrEP
	 9DbN9B6C7zylxbgf7ZtPRAMG+RsxKbkGhe6psqixtt0XCkVdP1ZOuVkUcbN9gy5Nybu02
	 RM2ZmQDTbcCeVOQfABnFZb18j6iBulmNDrDs1QvpT/BLPokA+haJVMsgj1RKUyoVcIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188491;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=Vmnslzco2VFlTAvIBJ5u1f30UOcTFAjsRmY4Ir9CuYU=;
	b=MueIWejbgNfwMgbIYy34Ccy7sVqtrEyz/k3xtWhyN9o6JJzxtYgBZv9KZrPza2K3k4+Y
	 Ip/co3KsGUg9bSGmc2I+vCiJLFpZQyzNehPK5cgXw0HOTkwLz/ACmDaBlD2PDMwQuv4F4
	 y4hNdV12RTRN384QuP031tjGDtZg+53O17cnGqOpbccTq9PfxX/Ohv1nV8EqnbfndRntu
	 Eptvl0IhtA+zo6i2w3annrx6Ju9eyoLPhnv8IGzXRBEE7naQNyeiJIcJEuYs5kkk/Wq8w
	 fnRAtmFNYabzbEalyecuZGw8hOVQdODH/Lgk/ur3kRlDUgU5ICQLmOOyCvKi5Qn5gPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CLzWti4m;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F33606A325;
	Fri, 20 Nov 2026 15:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F33606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CLzWti4m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vmnslzco2VFlTAvIBJ5u1f30UOcTFAjsRmY4Ir9CuYU=; b=CLzWti4mMgs1L0148e68QDbnFY
	obunPTpbdRcx2qLz7GW1hqsf1jh1wwLCTuM8wna5OT5YSdSGi202Nw0RzFT8cMlTuu+g2QoCXIOgv
	zhHTKkfH407sc0Zu+fvSxA3xsAhMxCNehsxhIoBgBEuZkeSz7Q0Xv53Y3fSskleNh1S6vbkBbURk+
	kXdPzaDjLpKstaZbYatqG8eQQDlXkscCRZ1JxMKZGsBjzYeNBgbz5FnhY1szcwHjhNJiSnqzVM9RY
	8lxvVdwheXvmuig5U0PJxcIdlTbR1B7+F0nCSW45VfxolXsJIYe3eatkKwPrGoQUVED+0skilThPT
	kFy2ZM5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQX1-0000000FQND-3Gp8;
	Fri, 20 Nov 2026 15:28:07 +0000
Date: Fri, 20 Nov 2026 07:28:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref
 tags are remapped
Message-ID: <awBnB-55HQ54C1x6@infradead.org>
References: <20261118154053.13218-1-zakaria.belkadi@inria.fr>
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
In-Reply-To: <20261118154053.13218-1-zakaria.belkadi@inria.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 18, 2026 at 04:40:53PM +0100, Zakaria Belkadi wrote:
> +	/*
> +	 * blk_integrity_prepare() remaps the reference tags of a write in
> +	 * place, so the PI pages are written. Pin them for writing.
> +	 */
> +	if (bio_op(bio) == REQ_OP_WRITE && (bi->flags & BLK_INTEGRITY_REF_TAG))
> +		it.data_source = ITER_DEST;

I don't think we can just pin memory as writable that wasn't given to
us as writable.  So this needs to force bounce buffering, at least when
remapping might be required.

