Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F684039;
	Thu,  4 Jun 2026 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536765; cv=none; b=TYcX2hYmXFZPBiAxq+8Ji1tHrz+868eF/pIbm/wuSjhv0WSArJCo9BedPCXtqgBvUKI5uz9i7L344MUnb6M+/gvjxuA8v+hcqHPPdNXe6wqaGDRU0SwTTR6K38L3UIc/JAtr6ZbFOuxEcxN5YfFBZ21nWr2a9r5ErmzhqFB9x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536765; c=relaxed/simple;
	bh=JrPAuF6Bx0GCy03Bn6Lda9pgU3so8otvBU8bcZMRmec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6pR6VtkXfRdWQDLkGcj4sLp29qjB7H1bpQwWAh68j9stskTWJETiLf27kRfAgoCmgyDoydP2JbPt5uxr15nQ3X70iW6BpWY30ruN79CnIjymzeaX51t9y7mJTmDs4NGTKFhsfTstER0Jo8PVH8elAjVYWxCSNtCUWvnBtgPZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFcttJ6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFcttJ6c"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 85BD81F00893;
	Thu,  4 Jun 2026 01:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780536764;
	bh=FWaNtcYcWd6QnubDm56ZHIxbcReuP8NBSl9EATws+Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFcttJ6cm4G+lExsy6YguY6a89aFo33fH5A05Xs6yzq/OH34KvV0EbmTDRzDI6dfr
	 4owFQzGXKSEG+QprOCKkHgJC63kT6Ajnh+KJoNrvoeguR0iTVUmpGHdbv3xZ0w9JWJ
	 uaIaMIz33zfgU4jK/ZjT7QDlex9RBy3Tuz02nzVdmOpVF5iW3LAnU1mqxdToTM8W3C
	 B085KP8zvaCRN/RTUGuiQe8PP0vXu683QffJEjsh++8ZVNJaB55TbKeDemvcfcqY3p
	 W8mY9ivx8jXvvaM0Ot9EG4cgjP8qHcYknhhov2J10Q8m1troJXpvMtnD3xUYaWXbQj
	 j/P6hFXecYKkw==
Date: Wed, 3 Jun 2026 18:32:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, samsun1006219@gmail.com, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid potential null folio->mapping deref during
 error reporting
Message-ID: <20260604013244.GE6095@frogsfrogsfrogs>
References: <20260604011858.2297561-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604011858.2297561-1-joannelkoong@gmail.com>

On Wed, Jun 03, 2026 at 06:18:58PM -0700, Joanne Koong wrote:
> When a buffered read fails, iomap_finish_folio_read() reports the error
> with fserror_report_io(folio->mapping->host, ...). This is called after
> ifs->read_bytes_pending has been decremented by the bytes attempted to
> be read.
> 
> For a folio split across multiple read completions, the folio is only
> guaranteed to stay locked while read_bytes_pending > 0. Once
> iomap_finish_folio_read() decrements read_bytes_pending, another
> in-flight read can complete and end the read on the folio, which unlocks
> it. This allows truncate logic to run and detach the folio (set
> folio->mapping to NULL). The error reporting path then can dereference a
> NULL folio->mapping. As reported by Sam Sun, this is the race that can
> occur:
> 
> CPU0: failed completion      CPU1: final completion     CPU2: truncate
> -----------------------      ----------------------     --------------
> read_bytes_pending -= len
> finished = false
> /* preempted before
>    fserror_report_io() */
> 			     read_bytes_pending -= len
> 			     finished = true
> 			     folio_end_read()
> 							truncate clears
> 							folio->mapping
> fserror_report_io(
>   folio->mapping->host, ...)
> 	      ^ NULL deref
> 
> Fix this by reporting the error first before decrementing
> ifs->read_bytes_pending.
> 
> Fixes: a9d573ee88af ("iomap: report file I/O errors to the VFS")
> Cc: stable@vger.kernel.org
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAEkJfYPhWdd59RKmuNLJg-bkypHz7xiOwaWyNVu3A8CUqQCnvg@mail.gmail.com/
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

That was my bad, sorry about that. :(
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d7b648421a70..d55b936e6986 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -400,6 +400,11 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  	bool uptodate = !error;
>  	bool finished = true;
>  
> +	if (error)
> +		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
> +				  folio_pos(folio) + off, len, error,
> +				  GFP_ATOMIC);
> +
>  	if (ifs) {
>  		unsigned long flags;
>  
> @@ -411,11 +416,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>  		spin_unlock_irqrestore(&ifs->state_lock, flags);
>  	}
>  
> -	if (error)
> -		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
> -				  folio_pos(folio) + off, len, error,
> -				  GFP_ATOMIC);
> -
>  	if (finished)
>  		folio_end_read(folio, uptodate);
>  }
> -- 
> 2.52.0
> 
