Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C40254AFF;
	Tue, 25 Aug 2026 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637583; cv=none; b=C49blckMYumVkmszFPWbeVvo7GUdbn5VSBMNckT6pZvCQwyPOnDuwP1pTMcdvPIILvjpcRjV70FSs5FJgqxUp9gKayeHdw8AsvzNcvSywr1iUSoOPXGNZcApepZomq/I3PuRy8i8PekQ87i2WNk4V3mQY2ibgm6yHOiNUVpt4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637583; c=relaxed/simple;
	bh=cF+X8nrtOLc0S3a3jXqxYcBheuovs9d/mk442A9LfMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiRTAFybPsUFp6vceYtZJRE/Yr5+T5ic6DvklUHV9s1TyV0tNfEZvsnurnIjOq4Bto85gd1rMSG72CwSAqLhDxfuchJ2s2XcIcpF1ALUNCo3sSr8tD5pJ9wpuzRJJn5gjfKS8xMS2dXqiWLWskH519ymAk7+/PzrhiCuindAwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SiuYedWA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SiuYedWA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IR3Zm75E3ko+jggu/rLc8YgY9r9WUIC+1cB4Z43RoXQ=; b=SiuYedWA31qkaLMP1orR0Kj7/0
	ACtAFA9hestsD4rtRCzNOADP6T9vEIix2ZLj8kiCPTcLfRAYuYIkZ4vqC1f0KwzVSitnXrRpgnjJk
	/YCVdiKjhYrwIjF2I8ce1xZDP3+86zsoR6K/cXDG2C2UhsV81FBU3BNexqLmSgLp3OO9cfiRuhEMZ
	6X/82ARyhospkcDFbUcXnyEliSjqbt9XQ+uBt0B8MqebP6bbeL/aSN1m+kj58w4b9N9C0tjGLg9o4
	KRhi1jcZskQB+MJW2loiCd9Mf7lt1iuGG8bOxB6EoPayybY5WNveGmx1l8qBaPlHWEfSw0M9e10Eq
	TAZVZXAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wykC9-00000000CuF-3J2W;
	Tue, 25 Aug 2026 05:59:37 +0000
Date: Mon, 24 Aug 2026 22:59:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	usama.arif@linux.dev, hughd@google.com, akpm@linux-foundation.org,
	baohua@kernel.org, baolin.wang@linux.alibaba.com, david@kernel.org,
	dev.jain@arm.com, liam@infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev,
	ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com,
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
	kernel-team@meta.com, stable@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <ao0vSde26_Qar0IZ@infradead.org>
References: <aoXYh9EPF6QnlvIK@pedro-suse.lan>
 <20260820061337.24669-1-lance.yang@linux.dev>
 <aobp2CtWZBlw4w7E@pedro-suse.lan>
 <aob9PF_H6CCJMdkk@thinkstation>
 <aocFPRgqieScf_yo@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aocFPRgqieScf_yo@pedro-suse.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 20, 2026 at 03:10:11PM +0100, Pedro Falcato wrote:
> > Why? Write batching from large folios is a win.
> 
> For some context: we were discussing (off-list) the recent report that
> systemd-journald had horrible write amplification, worsed quite a bit
> by large folios. At the moment, there is quite a lot of write amplification,
> but _only_ on mmap writes (if you look at the write(2) paths, you'll see
> write_begin and write_end which tactically only dirty what you actually wrote
> to, block-wise in the BHs or iomap IFS). This doesn't need to be true.

So don't use mmap to write to storage.  That is always a bad idea for
many, many reasons.  We should not work around broken applications that
do this, but change them.  It only took about 10 years of bad reputation
for MongoDB to finally fix their act, so it should be possible for
systemd as well.
