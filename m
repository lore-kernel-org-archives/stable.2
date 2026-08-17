Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709D3B05B0;
	Mon, 17 Aug 2026 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958032; cv=none; b=eHoUeNeupvx5rEo+clLzgi0XEBkHSyZCrWlFh7rfKIfMLEoTV024PF78C6a1TP952HzcaksPURRF55kOWaOFoCfTN4XAVsB9zZAp8KlSqn3q49qavkPUcv9f+wqaVWNnD20oCszNCHd7UeWc3RzV7u+8uWRt49iYXJeCvLZ0Pjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958032; c=relaxed/simple;
	bh=8W3qdcWwX1cTmhpt+fmqY3bmyk9ycc7DShljIgk6EPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgIBR86cMzJ0Z5ZBAB5h1cmgk3/2lau5tbQ623wy3VRe40he/Cz+Q0lCaN6iHUQnrjgQCRnZRCINiRFYCLSEprnz1RK1tmQlJYM3xyfc/bgtu+BqBlw1VjAeJLjKbcBxB9qrx305vhCiEl8NdZVgQO23Igm39sNv+IYpyrHePKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y3bMDvrP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y3bMDvrP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GrRtdL7tMjigFfpzcDXOtrbxqbOC7K/d7mLEzjCsxzg=; b=y3bMDvrPrcrgnKD9ZWcAqqzKHE
	xnuvb+H6INQaqm+c/TRGhz0NIDpOp/2O2P0C6rneC2l7cmv82pdcjeVU6KTruE6beruaPqDplcaEi
	D3h2NMD028GsZAbNz0a66ktgwJSakWdvdXK7ASUAPZLOMWUAPZAPiGvE19MMmHvX0VO2OR1l3AxTR
	O6Z56O0xo4/OowNkyA5CfVxqxw+CDiOvbq8bTyOS1yURTlHiDiJCjhDNb4WSjMUsy1Bl2FQ0HFvQG
	cOpni7zwciHsbn/IsEj9rpPcGtOdQ/mZDmSg9DkPlJaTOxU4GontWXw03FOL4Xro33i3LG65Zj94b
	tHPwvhgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvtPg-00000005mtK-1Tdz;
	Mon, 17 Aug 2026 09:13:48 +0000
Date: Mon, 17 Aug 2026 02:13:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-crypto-fallback: Fix deadlock when encrypting
 large bio in dm layer
Message-ID: <aoLQzDNH90tdg0Cp@infradead.org>
References: <20260811220318.58331-1-ebiggers@kernel.org>
 <an63CV2_cS3VqPE-@infradead.org>
 <20260814194507.GA2644249@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814194507.GA2644249@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 14, 2026 at 07:45:07PM +0000, Eric Biggers wrote:
> It is what you asked for on v1 and you've now changed your position, as
> far as I can tell. 

No, you completely misinterpreted it.

> I can change the Fixes commit to e7f57d2c47e2.
> dm-inlinecrypt is useful and it does not make sense to drop it.

Well, I disagree, and it obviously missed this problem.

