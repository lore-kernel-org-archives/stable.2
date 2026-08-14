Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6EF3630B7;
	Fri, 14 Aug 2026 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736710; cv=none; b=ECL5xcnDx/HdBfh8wF4SsPBZxVP2ynr+uN1dtozYoSPTFoUwelFrREpt/Ldz+PqbT2WU+Kyh5JckbGROFpKFt/BO2ei34XRBNabxLnM+E2S5ZfBOnkaqm5RPAOYlg2E5iQDu1+YnEJQJ73hHQS4ogPckpu8/T/GFs9jSW2BLy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736710; c=relaxed/simple;
	bh=3MyQl4wJgu7ROdZ3CfxzcNvbKwIp/cC1gFY0F1d8qtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWAzM0p2BWID2FaS5S2aC0WTJ1qyRT42LdzCtmNwSUtxtfhAXoAlEUrcKvxiEsrT4LSlPYQXksvoTWODWo1IS+tDcAqDBWMgJjja7+tg1aVYdthZVHdjWzsqISzCp7PO3mx8Jn8y1z5Nb6SsqQIYtYp4DSjlIFStjj/cbe64xU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKju9zwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKju9zwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902581F000E9;
	Fri, 14 Aug 2026 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786736708;
	bh=npc598iUFDBk93SNBYPj3uUy6PeDDfOU+Bj+owwxRcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RKju9zwCpBAX9U5ddZN10ApU6++sqkdd2H6la+dMXd/w2Y522GVlW4PBzOYS7iLDq
	 qqVgGANoTplV4VyI2cGUKnr+4xU2iqWuZd4WOtMeybrGohiqYrbXPr9vuE/0IU8neU
	 YZ2iyZKCtjex+fCzXVIVengd6M95Qm/HzZ7KQRLjEynS2tuEUWd7p/0HIoVhszYjx9
	 7hduW0b5W1vE/ut/oR09dFHsEJbaaVzKoCFonMa6PJpLtruFXpQiWVgtJHDtFaLrDZ
	 uBepRCOv3bVcW/lvQoLRp6HBj7E+ZORdZTpXxQltAnEhDtrjvg+SUMS+vgap+BBOYw
	 N1eQsc+aRn3mA==
Date: Fri, 14 Aug 2026 19:45:07 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-crypto-fallback: Fix deadlock when encrypting
 large bio in dm layer
Message-ID: <20260814194507.GA2644249@google.com>
References: <20260811220318.58331-1-ebiggers@kernel.org>
 <an63CV2_cS3VqPE-@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an63CV2_cS3VqPE-@infradead.org>

On Thu, Aug 13, 2026 at 11:34:49PM -0700, Christoph Hellwig wrote:
> On Tue, Aug 11, 2026 at 03:03:18PM -0700, Eric Biggers wrote:
> > Encrypting a large bio with more than BIO_MAX_VECS pages can still
> > deadlock, even after it was attempted to be fixed by
> > commit b37fbce460ad ("blk-crypto: optimize bio splitting in
> > blk_crypto_fallback_encrypt_bio") and commit 3d939695e682 ("blk-crypto:
> > use mempool_alloc_bulk for encrypted bio page allocation").
> > 
> > This is because __blk_crypto_fallback_encrypt_bio() assumes that the
> > bounce bios that it submits will eventually complete, unblocking it from
> > allocating additional bounce bios and pages.  However, dm-inlinecrypt.c
> > calls __blk_crypto_submit_bio() from within submit_bio() itself.  In
> > this case, the recursive submit_bio() simply adds the bounce bio to
> > current->bio_list without actually submitting it yet.  That breaks the
> > guarantee that forward progress is being made.
> > 
> > To fix this, allocate the bio and bounce pages with GFP_NOWAIT if
> > current->bio_list is set.  If it fails, punt the encryption of the
> > remaining part of the bio to a kworker.
> > 
> > Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
> 
> No, it dos not fix that commit.  I "fixes" the misguided attempt to use
> this from inside stackable drivers.  Let's drop the dm-inlinecrypt
> target instead as this just shows up one more reason why that is a
> broken idea.
> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> > 
> > Changed in v2:
> > - Switched to the less efficient approach preferred by Christoph
> 
> This is in no way the approach I prefer or even advocated for.

It is what you asked for on v1 and you've now changed your position, as
far as I can tell.  I can change the Fixes commit to e7f57d2c47e2.
dm-inlinecrypt is useful and it does not make sense to drop it.

- Eric
