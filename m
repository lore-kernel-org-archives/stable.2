Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882967;
	b=tM8LgsmWWV/ZGwEa0jGpUuccWYV5TbIfJxVzMRpvWo0Vof7e1+s5NbXtLbFM4GtQItS3
	 41t+bQSm4wtvqtT2v8daaRxENxou0J79A9NzOfYeaU5EkfoH10nBPTt5zOGrAlQr7MWNh
	 jcIlbQslgjzTgP0GGZpgZXqiF1cvZV8t485CeErv80FS+vtHXvrDD1kYwL4DXhZuQl8Gy
	 bHgw9edlNY1b9ylAnZriedrGDS1ZvMb3x6Y6ct8HQPxfYyzLtQSYedoyTRTmYno+SgaYE
	 Cz2JsorH/eRmI7fdDg8f9N7WedBk30Yivm57I2HWyymhWIdMGA3bfjZtN1DPuBdxTIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882967;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jm/wpw0aBzb0o0AOc3jfnmw4DQX6HAAVWZR9EuNYLsE=;
	b=ZIVbtQlLEh0ZVa9YClgVGtTCsvG1F0ZQdzH0fASmWRc/CRm9bGGJKtCYmoW7//awRAMA
	 poaYPVlhyPx6yXp33SYraBbjuiOfV+J3SgTeI7Co7BbhiZGdfcr+7BHzk/77sjqMtKTdG
	 nOz9j9xseKHpmbLx2ekJvN1iEwo1ZdJgbHG9IhO+TYTX+0XgWb8ZMTuS8q9O0JRFYKCRY
	 SXEBJmMF/lnoyGUCMadIZHNn0d7HFHB9GAWpX757YQop9Ubxcnx3wdzuYriK8FH6kTBiL
	 JvX0WCrRaYp/rXvrQ1J4wfkURBsm7/VzeSs3TdeCBUMQaKP3Yp/NZRyF7wDzUgiijXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLWHo9b7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2044606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLWHo9b7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7799E1F000C1;
	Thu,  5 Nov 2026 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882966;
	bh=jm/wpw0aBzb0o0AOc3jfnmw4DQX6HAAVWZR9EuNYLsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hLWHo9b7hGosYSZW7trOle1t4JGK+lOuRPHSSG2ne8QkE8RxORZgz/3ScR/mCd2NY
	 h4x0RAkm3nAKpJimuuuZNFst2I0wlcVKPd9C3H8o1ZlG88z0q32xfuIRl09+T0hymM
	 02iY45Rq4Iz9PPnlIJQdwDBnQiAqnoGCt2Q9E4My7WZ+jOZgXT6sVvUBPcnCgA3QkO
	 R63JJQQ4ALhdm4ZoSLQ+trtZJKWSmaG3b+ELBuyu7Fskp8LXuzheAoK5YOhjbl2OZF
	 rQ1FK5kT9Ia2+DOVQKMDOaF5dIo90ieLAZjIb1NU/BVZmxs/9LNOkGjNHAEIzv9rVv
	 3ZWIE3NaexvvQ==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.ams.internal (Postfix) with ESMTP id 875C5198003A;
	Thu,  5 Nov 2026 07:49:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 05 Nov 2026 07:49:24 -0500
X-ME-Sender: <xms:UnvsahYHfhfuowuo7CsP8DI_Mq629tzha1V6duSqF3d2rOoPSMOv2A>
    <xme:Unvsapt5IHWqJRc9M1sDyX7maYF_aTnvkF3rMU-NZSWrWQAwToH4sJh1chBA8zN9S
    vs5PWUD70Qqfv5gbjKLksaFf6psAS_xzlGAl-EQFYJgCyqCRlGupGA>
X-ME-Received: <xmr:UnvsaokNKCzaNhhvvjKtVP_uXeFX2Ktxdm7UD05Mw8QsKXMyVPjJI11dUpQ>
X-ME-Proxy-Cause: dmFkZTEW4JllTt5Idft6CjxHmeLyHBmFga2y1IuhusNWLkk+RuUzgi27fIRUkj6zehD73Z
    qXCwJB+LL25tnZ7MVvsM1jJdiEBmACdZ24JuSELrb7onelR59Gex48EX9ZAQtwkYfzKv6O
    uaYpMi0+N/MMtqlBvS8vtGqvcrtbxioqnmLvVVrtYt7ftIUJbtV5gX1DIVLeAqEZt1hxdV
    1+ToEn+FZOdUeh1da2rslwkQZ+AzZG7c40X/kdHTPxPibTU64dnYA36koXg0Tlz8Wztmyv
    SwnwNjIN0SiiiHU6wxG2euwX+lZfIbFsB8NG0sjX2VL9xr9B8DML+aHpZRMo5jzBfq1zPR
    ktSIxz93afPY52xXAJMQtDa6ryeGSkd99uQQ6HftCDK/5lq4A4EXG6248hlloaD1dqQXli
    ZfBqDxP6dPOx+dZRQ5Ewmf0owbcmym2T/DPtrd1oHh+5f0JrozQg5Z3q1nnwt2feob/tEk
    u4jNZriHcMDhzf+vukSoUlT4TCc8bTEwt3z1Ad0c8X1v6VONQOnV2MwVoZxOFNxVbqAT1s
    uTKzMC5Z5cFTuo+YI/c5cGoRfBKchT5UlKqB4cs8vwCsJf5yvPg+fHKtjE73dCphA+JD6X
    4lrlpVaOJ6xaw9/S6Ce8EuGV+CFGCBHfLl4DzEOInSySvMg3qWI/C/CplHqA
X-ME-Proxy: <xmx:UnvsaiWBPrxsObXpEfarSHjcZGtPcIfjWRAQTuI4KwVlYpuTuVT4jA>
    <xmx:UnvsajnY5bhdHIG9jufPM0V3sE_xvLSab1AQ3GDusGs1dZGlzkyHiw>
    <xmx:UnvsanQNGRjIVbPM2n1URzuw1Dv5PS7K8oFUojWmDZegXctMcg26AQ>
    <xmx:UnvsavE1b5ie_x4Ez0D48lT6jS7Xz-4pnh1JAvyrcmsJuSzP25PwqA>
    <xmx:UnvsapjUNKB-WYf_Z5-t4A4Z6DmdPTQ_jrkdSpcEREnYB4Kk8P0E7FuG>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 07:49:21 -0500 (EST)
Date: Thu, 5 Nov 2026 12:49:20 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Hungyu Lin <dennylin0707@gmail.com>, willy@infradead.org, jack@suse.cz, 
	akpm@linux-foundation.org, dave.hansen@linux.intel.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] filemap: prefault writes starting beyond EOF
Message-ID: <aux4uyBHKsFo5bTd@thinkstation>
References: <20261104071002.49693-1-dennylin0707@gmail.com>
 <aux0ruR5HpMBMPI2@pedro-suse.tail5790ac.ts.net>
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
In-Reply-To: <aux0ruR5HpMBMPI2@pedro-suse.tail5790ac.ts.net>

On Thu, Nov 05, 2026 at 12:33:16PM +0000, Pedro Falcato wrote:
> On Wed, Nov 04, 2026 at 07:10:02AM +0000, Hungyu Lin wrote:
> > Since prefaulting moved to the slow write path, a buffered write can reach
> > ->write_begin() and ->write_end() before discovering that its source buffer
> > is unreadable. Several filesystems can extend i_size in these callbacks
> > even when no data was copied. For example, a one-byte pwrite() at offset
> > 4096 into an empty file can fail with EFAULT but leave a 4096-byte file.
> 
> I've been following this discussion rather passively on the other thread, so
> I'll ask my stupid question: Why is this a problem? Yes, it's a bit of
> weird behavior, but system calls are generally not expected to behave
> super sanely in the case of bad input/weird errors.

The input does not have to be bad. Write from an mmap() of a file that
another process has truncated: write() fails with EFAULT and the
destination file has grown anyway. I see it on ext4 and tmpfs. Before
665575cff098 the file was left alone

> > 
> > Prefault the source before ->write_begin() when the write position is
> > beyond EOF, and return EFAULT if no source bytes can be made readable.
> > Overwrites and appends continue to skip this prefault. Keep the existing
> > slow-path faulting for forward progress after a failed atomic copy.
> > 
> > This also leaves intentional zero-length ->write_end() calls used by
> > generic_cont_expand_simple() unchanged. As with the previous prefaulting
> > behavior, a concurrent userspace unmap can still race with the later copy.
> 
> Ok, so it's still racy? What do you do if you can't fault it in at all?
> You still get a hole?

Only if the buffer goes away between the prefault and the copy, e.g.
another thread munmap()s it mid-write. That is userspace racing with
itself, and every write had that window before 665575cff098.

> > Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> > Reported-by: Kiryl Shutsemau <kas@kernel.org>
> > Closes: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
> > Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> > Link: https://lore.kernel.org/all/at-XtWBQg3jv3H8Z@thinkstation/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> > 
> >  mm/filemap.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index b74bc1e5015c6f318333427f223b9f42061a6213..30414d55412b84f11ebe98b8eea607ee8c04eef5 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -4389,6 +4389,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
> >  			break;
> >  		}
> >  
> > +		/*
> > +		 * Some filesystems can extend i_size even when nothing was copied.
> > +		 * Prefault writes beyond EOF to catch unreadable source buffers.
> > +		 */
> > +		if (unlikely(pos > i_size_read(mapping->host)) &&
> > +		    fault_in_iov_iter_readable(i, bytes) == bytes) {
> 
> I say this doesn't matter, and if you pass insane inputs you get
> insane outputs.

As I mentioned above, it can happen with pretty legitimate input.

> Even more so considering this is racy, e.g races
> against munmap(), mremap(), mprotect(), memory poisoning, and other things
> like truncated memory mapped files sending out a SIGBUS (or uffd) :)
> 
> I don't think it makes to add random prefault loops in hopes this makes
> for saner semantics.

A buffer that is already unmapped, PROT_NONE, poisoned or beyond EOF of
its file fails the prefault, and the file is not touched. Only the races
in your list get through.

It is one prefault, not a loop, and only for writes that start beyond
EOF. Overwrites and appends keep the fast path.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
