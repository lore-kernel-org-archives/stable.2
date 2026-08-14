Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E033938B;
	Fri, 14 Aug 2026 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689293; cv=none; b=KOaCKPIE4ib6eaPbi4KSZo1jE5tU9gmSUnmRPK7J2jtjMLsXnutKI+i9Jtjz/tD8+PBX4Pb6yoQKuOUWVbCFH30nuSlr42QnU6HFUhzp9cHSX7/TCFesWuPBrKHar1qkAoir90aURQxx70GhxKNjnIR01RBS+GEhhnmcHugVbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689293; c=relaxed/simple;
	bh=gHahCirSyatfdeiBal6lEyG7D7PTbuLaQhkrydv74SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGflmnu/MmsPhijDnSFPgc5ZAGq/0IK/4XNCeqcxB3W7jRMJ3kIs838So8yyqqKCTGDMyDQFGnVv3YOmYQKIWNbtw0HcK5LOfIW70D8/NO3iAjFbErLrPB7zJScoUQdJfk26/pM4/BmcgJlHAL1i6SGsEi8Jp+OvubKSAmP0LX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JkHnwos3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkHnwos3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bt47sakA4MA7BnrCOsH2O/sVu5imfuvE7ni9rmvb6RY=; b=JkHnwos3lryoDJpMC78oYcTR0w
	caGnLUmWtBj5thAvGwG1uF7ssuzhry6LHNtrk3m8lowhgdTIAeIEie7INyLBZ/7v0qrkxanXIRtqp
	n/LQ88PS4L1GWuf3tU3GXYJ6Y8tccJUCTtzrBR+veuf+1qMn0rTfVI/FjROZm4VVIqihZRRARyl7x
	NxtDYWSa9Yra4VArbUYLHwleBRsstMnWC7eG/TmMV71O1MXZsd0qS6cvzGh2wj2KmksyEFr/xOyeV
	NBNYMLQmD2Cf3PZ1900LsVDsgorTI5U4CWn1hXiKPpx3Wo4Q7lcHvBLi7E15iQLdbpxybks1JlX/V
	/vQCa2WQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulVB-000000022lH-2KKR;
	Fri, 14 Aug 2026 06:34:49 +0000
Date: Thu, 13 Aug 2026 23:34:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-crypto-fallback: Fix deadlock when encrypting
 large bio in dm layer
Message-ID: <an63CV2_cS3VqPE-@infradead.org>
References: <20260811220318.58331-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811220318.58331-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 11, 2026 at 03:03:18PM -0700, Eric Biggers wrote:
> Encrypting a large bio with more than BIO_MAX_VECS pages can still
> deadlock, even after it was attempted to be fixed by
> commit b37fbce460ad ("blk-crypto: optimize bio splitting in
> blk_crypto_fallback_encrypt_bio") and commit 3d939695e682 ("blk-crypto:
> use mempool_alloc_bulk for encrypted bio page allocation").
> 
> This is because __blk_crypto_fallback_encrypt_bio() assumes that the
> bounce bios that it submits will eventually complete, unblocking it from
> allocating additional bounce bios and pages.  However, dm-inlinecrypt.c
> calls __blk_crypto_submit_bio() from within submit_bio() itself.  In
> this case, the recursive submit_bio() simply adds the bounce bio to
> current->bio_list without actually submitting it yet.  That breaks the
> guarantee that forward progress is being made.
> 
> To fix this, allocate the bio and bounce pages with GFP_NOWAIT if
> current->bio_list is set.  If it fails, punt the encryption of the
> remaining part of the bio to a kworker.
> 
> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")

No, it dos not fix that commit.  I "fixes" the misguided attempt to use
this from inside stackable drivers.  Let's drop the dm-inlinecrypt
target instead as this just shows up one more reason why that is a
broken idea.

> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> Changed in v2:
> - Switched to the less efficient approach preferred by Christoph

This is in no way the approach I prefer or even advocated for.

