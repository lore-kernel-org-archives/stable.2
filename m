Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195422;
	b=ClVANX233hU8Igt00yfVttcR/GiP8ErJNJnXAOoZyO6o1y9eRDKsk4Q/ezGDgpGPJ64R
	 7O8+lW0H/SnlKKABxjhFHJ0MjNkyXito10OnR/bgZEKsZnkJMLTsszHoGIDyP2cv4XsAf
	 taDO2WQ9kTbJJnZpLCRjF0W08xefG74mHrSNtEZABi/8e/ogFyATwTh9p1scgDBDwF36D
	 kQEqdkSh3pZEWk3usb3B5JaLSMRSX+BtgevcchqKxxov8dGvyF5yC27Q4GZ1U8jmg1FhS
	 IUBn8HdmR/lrd+QckT959Ids0tQQcyxAEgBrO6wHIDi2yho3d/oEPy5Ks0nvBGcN8Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195422;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O8lAAmJYNMttRCbkLCxzVsiSYY09/k9hIKkOCQQsnn8=;
	b=jJgyyIobRVMwAQHzO7Ll7g3HK60pBYgip4nvytaHbCwPl09QPdKUoMoKeb+z4tW6NBQg
	 nAZRiy7FYiltYtXGxvTSOIElFhjTIF6JZU+hg/kzVXrgLpAuJWcf2Auu2wWhizlEcsxls
	 RpqaJTnzMIxUVoJOEBjlW7/jGSp21OuxNEokMfkDcEeuzRVYRAwatQa9049mDhFs0Upt0
	 cvQqc6aNxJJZsPCVbx5hQnSKUBUtanl0Hfiir0+uRbr04HE/oDI3Fcxudh8ozl5+rFZRt
	 wpJt45e3i4b4s3aQqT4nBOtW9tL7bIhnV/KFJerMGphho0lwq81hqeldFQa1G05+gWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ2wJEGy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83174606A337;
	Fri, 20 Nov 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJ2wJEGy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF8D1F000D0;
	Fri, 20 Nov 2026 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195422;
	bh=O8lAAmJYNMttRCbkLCxzVsiSYY09/k9hIKkOCQQsnn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJ2wJEGyK5nusgibaGTC4VYyj94/Nf1swjR9aXI2aqsYshYgEnS1EkGzkUFxrEe+Q
	 0EENSoVtFSuuI1djJ7gYG+1y5YzXnuRpkcUZBtnwRnEZKHwJGCO+hbXXcdi8a35/Yk
	 YX4z5sgeaf4PspnnX3uKvvSF3nC9RmAk1+jUHG37PFbomiU+rehF7oPbW0HM85Avrz
	 NPUGyEPe3tns+QA7GZWTHdsGXa927opDKxM6r0RK1CfWTcl7YGTaYb22WpeiScPuO6
	 S2AT+AiG/e/3yKM5jFlwOMZflLi7KljpG2XejhY+G4zNpOsckaEYuCE0F5zpkHtqUH
	 mzLKWfS0I803A==
Date: Fri, 20 Nov 2026 10:23:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zakaria Belkadi <zakaria.belkadi@inria.fr>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr,
	stable@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref
 tags are remapped
Message-ID: <awCCG3FWbMHHvYd5@kbusch-mbp>
References: <awBnB-55HQ54C1x6@infradead.org>
 <20261120162257.498238-1-zakaria.belkadi@inria.fr>
 <awB8OODx0fCFGc5G@kbusch-mbp>
 <awB_xd60To4UawrJ@infradead.org>
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
In-Reply-To: <awB_xd60To4UawrJ@infradead.org>

On Fri, Nov 20, 2026 at 09:13:41AM -0800, Christoph Hellwig wrote:
> On Fri, Nov 20, 2026 at 09:58:32AM -0700, Keith Busch wrote:
> > > Agreed. I'll keep the PI iterator as ITER_SOURCE. In v2,
> > > bio_integrity_map_user() will bounce the user PI buffer for REQ_OP_WRITE
> > > when the integrity profile has BLK_INTEGRITY_REF_TAG. That way the
> > > block layer can remap the tags in its own copy.
> > 
> > Can avoid bouncing? I think the remapping flags can be tied to the
> > user's reftag check request.
> > 
> > If BIP_CHECK_REFTAG is set from the user setting IO_INTEGRITY_CHK_REFTAG
> > on a write, we can map the PI buffer for writing. The user explicitly
> > asked to have the ref tags checked by the device, and partitions require
> > remapping them, so they've told the kernel to write to their buffer.
> 
> No, the user did not ask for violating the mapping direction.  The
> whole remapping thing very much is an internal implementation detail

Okay, fine. But can we skip bouncing and remapping if the flag isn't
set?
