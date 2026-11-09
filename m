Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235510;
	b=co/U+Vuw5fO0hKpq0RKz6ixwuflmF58SCY5TMeDqDKGC0dyHGBkfuJyWGzYbaNzaga2o
	 GRbwaDQeP3g2RUqUOIfTfwAoFyjE5n087PEYfsFQbDvp8Jmym3okfrrb4Lq310Jzk1daG
	 WFK++vKIhYvr/9kh7YoQVcQ0II8Ju5PG1cG/3JH5NYdF/BF1jAFcqkIH5QehQcFKU/0WH
	 YrxLFJ+bzdKqJRilDS3zE62cxVbo/1OerxGPqcBBdCpNsGIAEZgLmqWUiYavyzn+VXEgv
	 5em31yZp6igQJPvcbYmCwVaKi6i1oyx5oI+UP5UOHXmA96lKVDWyN9Rp7up35w8gTjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235510;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7Qt+bdQBMRgfyzqEjWH55cwhWUCf0OmGYF56lEghc2Y=;
	b=DGqjY/6Sl03OtcadxVC/XDSDKuzQCLcufXfiOEvenwFxmdrVR9Q8LOzZ1A1peojcd8uB
	 ilZjg5kwNm97xj1szKZlSGVwKT2+psGM31HOK8uLDfDmwIfDxNgAPQSuh9WBF0vlMXtNJ
	 wZAI09CuJArv7aTlGdlZ3tZBmiiS3NWvPPQyXjnv834scG3pa5cnhIWDe36i9IAVWd7qP
	 6Z79NmQgYkXY8K7UTzV9q8yQshCq6U7Ws+LWgk10c8qXSogjqMc0eA2r6xboGjXHomlFt
	 1WEmOFn9mbQNKf2g5r5jMZcgNwnZ4ESv8A+IonOc2tXDrZ755V82274HonCXEAK7r3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeaPzbmF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 86B58606A326;
	Mon,  9 Nov 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeaPzbmF
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8F88D1F0089F;
	Mon,  9 Nov 2026 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235510;
	bh=7Qt+bdQBMRgfyzqEjWH55cwhWUCf0OmGYF56lEghc2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NeaPzbmFsMfpsCQ81QYV9ORbpTNns7tXzpR/ckGodStlgh6uDj14wOJE2Qk++rpOn
	 zCGyJ7Q0dd8fzufvIvEw0oDX8GIDdxmZ3T5oXgS1cBUux6RF05CZF6zAmglXLANsR6
	 Sg9lDOt3+5sgVTUuUFsA8I8p++VzkLb39eVVTRylmEVHG8GD0ha3f1tbufAyc3u/TG
	 zakHb6wPnHExtPPzSYIXX2XrdwmwQKdprKbfoRZYhihw7VPfBAQMBxhqM/bVviCHUz
	 1obwYqLGSm7Fq3L78NK5Rvdkfl5qy944r4irWD0NNJZkYmGCWO/rsjONY3skabCnAM
	 MUiSjrJo4jqwg==
Date: Mon, 9 Nov 2026 16:45:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	Matthew Garrett <matthewgarrett@google.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: efi: reject a final events table with an oversized
 preboot log
Message-ID: <avHccmVUV9Wki9bC@kernel.org>
References: <au3xM-7onNTtgceh@kernel.org>
 <179418897414.2773996.1582380807629789288@xiaopeng.com>
 <avHcB5IOQHomIvEU@kernel.org>
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
In-Reply-To: <avHcB5IOQHomIvEU@kernel.org>

On Mon, Nov 09, 2026 at 04:43:23PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 09, 2026 at 09:49:34AM +0800, Guo Zihao wrote:
> > On Fri, Nov 06, 2026 at 03:24:39PM +0000, Jarkko Sakkinen wrote:
> > > Ditto.
> > >
> > > For all four address validation vs bug fix intersection. I did not
> > > check throughly enough to be exactly sure of all four.
> > 
> > For this one I'd like to argue the bug fix case, since the data being
> > validated is not something the TPM reports over a TCG-defined
> > protocol: both sizes come from EFI configuration tables written by
> > firmware, and nothing in the TCG spec constrains what firmware puts
> > there.
> > 
> > The firmware data is already treated as untrusted in the same
> > function: it bails out on an empty log (log_tbl->size == 0), on a
> > missing final log address, and on a wrong log format version. The
> > unchecked subtraction is the odd one out.
> > 
> > The consequence is also plain memory corruption rather than a
> > graceful rejection: final_events_log_size goes negative, the
> > following devm_krealloc() gets a wrapped size, and the memcpy()
> > appending the final events log runs with a negative length.
> > 
> > And the out-of-bounds write was introduced by 166a2809d65b ("tpm:
> > Don't duplicate events from the final event log in the TCG2 log"):
> > before that commit nothing subtracted the preboot size, so a
> > malformed table was harmless. The Fixes: tag refers to that
> > regression, not to the malformed table itself.
> > 
> > Ard also had a look at v2 and only asked for a pr_warn() on the
> > rejection path, which is in.
> > 
> > So I'd like to keep the Fixes: tag here, but I'm happy to drop it if
> > you disagree - your tree, your call.
> > 
> > Thanks.
> 
> Let's take quantitative approach instead.
> 
> OK, so does this actually happen? I'm weighting this based on that
> mainly. Usually bus corruption is not very common when it comes to
> TPMs because they are usually either soldered or in the firmware.
> 
> Is there something I'm missing out? I don't think bus interposer
> type of security scenario is common enough to use it as a rationale.

I do think that the change is for better. I'm disregarding its value
by saying this :-)

There's so many bug incoming that we need to be just somewhat rigid on
what we consider as a bug fix per se and what not.

Br, Jarkko
