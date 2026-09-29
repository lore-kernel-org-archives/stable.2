Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159434B1A2;
	Tue, 29 Sep 2026 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721293; cv=none; b=VBNYzbm4tVrlFM4D/z7Y6/ICBbk/rLELKxS6mUxoP3v8+EYO6T+swOgElsqD3bozmweS9wFNYxNKjohmq1ObFT/fdI3etbFY/0Vf/IGm6Dz0UCv/GatDnoGveNqEpJpnUenxvT3R4zPir/OV48aSOy2gs+dTBvExeybzvGtZ1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721293; c=relaxed/simple;
	bh=A3kJlSFdcuOCiUm4bW2a0Z+0tSREzC6TX9OwAb3V5kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbT6dfyliYfUjKfEss3XK6tLDkJ72yTCi2k9ny30CE9MMs4c05sd6fXBG8csmOZM5ODqcI0BHn2DDW3v4BjkZ0fArdjVPNj59IagKfPDOBIKMb1ZgZEo9jd5uIZ0G8CHYIx6y2xWV88vEL7BY5p8Hp+MtF4BfqReQGtiTrwflkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5h736SE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5h736SE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8DEED1F000FF;
	Tue, 29 Sep 2026 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721292;
	bh=7Jv9I+GMANQP9pLmot5B/d4pg1K6Q2hX7SaokF+WT1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d5h736SEn23ntG/Au/8e1Mbm1+gX2izYZqg1tBCMtSOlhCpZ1hTRXFtHKeBy47NoH
	 QLaAaDkUoC5D8FsctjLAKBDYosYM7vyhxB4D8L9byjv800G7f5JEdiZ9zFOfrSMLKj
	 IoLfARj6hsHBmu8i6PkXuMI0DvdaUZJc+hlnu/VM80AJ966WHZp6lSJ93SIuZb8fhR
	 4FP48jyp7qGgsSz3zaKbU0pbV5xfbbeZT4kDeScqH4bbIl91gttcRwHlgOfiRy+ZwS
	 7/aHHmfxFmVZ8HtjeaB6PWt0eTZImPMZo4EbHdDxShk+l2XQt2nOZI88VJUmHUNca2
	 JOWTra2EFrMJA==
Date: Wed, 30 Sep 2026 01:34:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH v2 1/1] tpm: reject duplicate PCR banks in
 tpm2_get_pcr_allocation
Message-ID: <arw9CHc4mIOm5C6Q@kernel.org>
References: <cover.1790568982.git.xuyuqiabc@gmail.com>
 <9d27c4513a3c6fc32f9574ba192cd3bfcb2bac98.1790568982.git.xuyuqiabc@gmail.com>
 <arwssp0czGg9XKv7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arwssp0czGg9XKv7@kernel.org>

On Wed, Sep 30, 2026 at 12:25:06AM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 28, 2026 at 04:27:00PM +0800, Yuqi Xu wrote:
> > The TPM2_CAP_PCRS response is external input. tpm2_get_pcr_allocation()
> > adds every active selection to allocated_banks, while
> > tpm_sysfs_add_device() has one group slot per distinct hash algorithm.
> > Eight duplicate selections can therefore write past chip->groups[].
> > 
> > The TPM protocol does not allow a hash algorithm to appear twice in
> > this capability response. Treat a duplicate as a broken TPM and return
> > -EIO so the chip is not enabled, instead of silently dropping the
> > extra selection.
> > 
> > Fixes: aab73d952402 ("tpm: add sysfs exports for all banks of PCR registers")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> > Reviewed-by: Ren Wei <weir@nebusec.ai>
> > ---
> > Changes in v2:
> >  - Return -EIO on a duplicate PCR bank instead of silently ignoring
> >    it, as requested by Jarkko Sakkinen. A duplicate violates the TPM
> >    protocol, so the chip is not enabled.
> >  - v1 Link: https://lore.kernel.org/all/cover.1789800840.git.xuyuqiabc@gmail.com/
> >  drivers/char/tpm/tpm2-cmd.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index ae22295df798..a94f4395c198 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -527,6 +527,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> >  	u32 rsp_len;
> >  	int rc;
> >  	int i = 0;
> > +	int j;
> >  
> >  	struct tpm_buf *buf __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
> >  	if (!buf)
> > @@ -569,6 +570,23 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> >  		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
> >  					       pcr_selection.size_of_select);
> >  		if (pcr_select_offset) {
> > +			for (j = 0; j < nr_alloc_banks; j++) {
> > +				if (chip->allocated_banks[j].alg_id == hash_alg)
> > +					break;
> > +			}
> > +
> > +			/*
> > +			 * The TPM protocol does not allow the same hash
> > +			 * algorithm twice.  A duplicate means this device
> > +			 * is not behaving; do not enable it.
> > +			 */
> > +			if (j != nr_alloc_banks) {
> > +				pr_err("tpm: duplicate PCR bank for algorithm 0x%04x\n",
> > +				       hash_alg);
> > +				rc = -EIO;
> > +				break;
> > +			}
> > +
> >  			chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
> >  
> >  			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
> > -- 
> > 2.55.0
> > 
> 
> Yeah, so in some places like this some of the TPM driver code does
> return -EFAULT but I'd like to progressively refactor so that any
> corrupted traffic is always -EIO and use -EFAULT for memory related
> issues. 
> 
> Thank you!
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#18:
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM

No need to resend a new version but I'd need a link to the *report* to
retain reported-by tag here.

Br, Jarkko
