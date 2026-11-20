Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199840;
	b=GyEztmP1yIrLbXHCxcYaGr9SS43FXAPNiRPmgjS/hq2tbKyzbhprxRImj1N/KfrsizZi
	 /vrCF47Blqb4DdgxZN2O5+aEvrUpIQ+KlWHN9jluHI0SV1DVn1ZmS5EGwZ0UgO+/nPqc4
	 X0HebG0N+pRZ4jXVptCVNiBCu5NuY+/uODHH/3etYx4jPffVsrSzW50ipRF+mX8pExIM6
	 gvgtSdM7izPGOP1I6WvibKrcs4xthWckgQX0qaQgSGIAGaZZ+AIOyOV2B/e6rGPjRcQ6v
	 JP1fBfXXuaX7t+nTdZwPL+m5OaPfri6h2pSoFH2KjwgSGipQKM/kjmOSyeN8Y2BS64A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wQl/JtE6qQZueMrPh3nuZAtCFAUhv4LS8vfk9kIDRRQ=;
	b=stbCiZIk3LcjTTFFdpF/JwhLV8PQR5H+/uosu5AvebN5rTZNY4yv82WlXo2NfctHpWIl
	 zjGZr8n1hSIa2y1oK5xxsp19x/02qpbPyjl7G/rVCcCfBPhCKiBmjZtHQCjLWHgL94Uxk
	 d7h0y6DJkwyfbYIDDcRUfqU7NGuCqb9xdlInyb8vRnvWvM6nxYtGtzoMESrvnP6NHG3dj
	 V5xLlNL/WsOaRPTaVfpQQfHPYfQbc+hS/91PpB3w+XJs4z4QJ4aM6BgE+53IrU5fMjmKM
	 jpVDFS1L9s/CeIjePQJ/iYU3YBVwQnr4WpJVMQpgoUFdHskSUQJhKUAcnuAP8zUfvSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpt+mBTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EBF60A2601;
	Fri, 20 Nov 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpt+mBTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741391F000CF;
	Fri, 20 Nov 2026 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199840;
	bh=wQl/JtE6qQZueMrPh3nuZAtCFAUhv4LS8vfk9kIDRRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hpt+mBTxzbdDIytY5Ra5HXawSDxB+VevHShWI3OUlzMIYTNgGwfy/WYbsq/dkjrkx
	 CLYw/IRUFX1JDiVLF0jGTwIjFo7+wKplSXfE9YuAxawRzElqER1I6ar2oxti0CgQM8
	 q1yovDnD2f5IhTj6eCnluGx0X/z9YF6wcFEUGfYJ4Q1nR1XKlZNieHmH6wjhsStrlA
	 x5ZP//q09dHkLi2GZHKmwUWc9OJOqrPsbNjh4MQGVIgO/MdBknDLKjmCnwDoDopVp6
	 4/VbLrBfvp7F+CEIEIJIj/caDZDUuj+epQ4bLIcz69Sc8QbwNwpJJG8rQG2AtFtfrm
	 vjkAoT5uuXQEA==
Date: Fri, 20 Nov 2026 11:37:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zakaria Belkadi <zakaria.belkadi@inria.fr>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr,
	stable@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref
 tags are remapped
Message-ID: <awCTXQYhwCdqgnuY@kbusch-mbp>
References: <awBnB-55HQ54C1x6@infradead.org>
 <20261120162257.498238-1-zakaria.belkadi@inria.fr>
 <awB8OODx0fCFGc5G@kbusch-mbp>
 <awB_xd60To4UawrJ@infradead.org>
 <awCCG3FWbMHHvYd5@kbusch-mbp>
 <CADUfDZqNM2=KzsnpA+R5ygAbS-SiUzQczZvgM_NoYrhR7Qyj9w@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqNM2=KzsnpA+R5ygAbS-SiUzQczZvgM_NoYrhR7Qyj9w@mail.gmail.com>

On Fri, Nov 20, 2026 at 09:44:13AM -0800, Caleb Sander Mateos wrote:
> On Fri, Nov 20, 2026 at 9:23 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Nov 20, 2026 at 09:13:41AM -0800, Christoph Hellwig wrote:
> > > On Fri, Nov 20, 2026 at 09:58:32AM -0700, Keith Busch wrote:
> > > > > Agreed. I'll keep the PI iterator as ITER_SOURCE. In v2,
> > > > > bio_integrity_map_user() will bounce the user PI buffer for REQ_OP_WRITE
> > > > > when the integrity profile has BLK_INTEGRITY_REF_TAG. That way the
> > > > > block layer can remap the tags in its own copy.
> > > >
> > > > Can avoid bouncing? I think the remapping flags can be tied to the
> > > > user's reftag check request.
> > > >
> > > > If BIP_CHECK_REFTAG is set from the user setting IO_INTEGRITY_CHK_REFTAG
> > > > on a write, we can map the PI buffer for writing. The user explicitly
> > > > asked to have the ref tags checked by the device, and partitions require
> > > > remapping them, so they've told the kernel to write to their buffer.
> > >
> > > No, the user did not ask for violating the mapping direction.  The
> > > whole remapping thing very much is an internal implementation detail
> >
> > Okay, fine. But can we skip bouncing and remapping if the flag isn't
> > set?
> 
> Currently, the remapping happens regardless of BIP_CHECK_REFTAG. It
> depends only on whether the block device reports ref tag support via
> BLK_INTEGRITY_REF_TAG (i.e. Type 1 or Type 2 PI). I think it would be
> a UAPI behavior change to make the ref tag remapping conditional on
> BIP_CHECK_REFTAG.

Right, today remapping is checked when BLK_INTEGRITY_REF_TAG is set in
the profile flags. My proposal is to change that check to
BIP_CHECK_REFTAG in the bio integrity flags. That is indeed a user
visible change in behavior, so that really hurts the suggestion.
 
> I don't see a way to tell ahead of time whether remapping will be
> required without walking the metadata buffer an additional time in
> bio_integrity_map_iter() to check the current ref tags. 

The flag is set in the bip_flags, and you can't merge bio's that have
different bip_flags. So you only need to check the first one rather than
walk all of them.

But it's a moot point because of the user visible change. I suppose you
just shouldn't use a PI format if you don't want your metadata to have
that interpretation overlayed on it.
