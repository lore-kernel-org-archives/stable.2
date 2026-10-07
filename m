Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCA4AE8A3;
	Wed,  7 Oct 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382226; cv=none; b=nIVimD4sKeI7Txni8Z8rQBW96bR3zElodgjCNPKbAXdxMsv3w3eHgAIRXyjuSWLjiqY6y4OacGs1xqPfDqLSfwBAnHvdd0AHNsUBN4GmGMEFxwwZnvuts0NFLELtJWUucgi01jtYqQfcSy9ojn3K/zcBcF4oLl23c4bytujSOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382226; c=relaxed/simple;
	bh=Q3c5owD86ibBRfHuJGjqZgVcl2fUlJpcGaQ9CqlexIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBjj0XFDLt3T7p373kgiFPyhK61T/UB5/3KEjwlW264WqcDy8Sg0ghVKzlHNLPUE6cJYEQBxBS0SynswHLCa57ErbxKrnrr0W/tWFafdRJjiGQ2d6mCoLPs4i0+67p1Uto4dXNkv1jw+7k3EuLjLNAAl5ufhL1yB7kMgWubeTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDIm/uZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDIm/uZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E551B1F0089B;
	Wed,  7 Oct 2026 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382222;
	bh=y8OhnnSOAvSKrd+ySENWUqGQzpLRAh4QtiyM1j05nMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jDIm/uZgysp4hNl+n8VvD6VrUZOUj6kVvkIaRRp1STUS6lB2QIIlO2wqfqZBaDAOx
	 BinhUmjz8mfdBvKkrlvzs+fovKaxxudvtHs+Xc0XtJx6wTu4199PtXKjVpJEBlgnNA
	 x2Rkxw9KK9iQtmr3SO3bZH/ZXJIEYWozuWskuUve2tZZAJyy9oJSEfVVodK4hRSAyT
	 Qgpf29Zol2vmraDLWnqk60Y59r3hRr08EpFvXbQqBUvU+uDPIunyHds1JR5gzattZD
	 2Edkw33ZeYIBP4oLjXoiZgrYUY8f26DpKmnfkJNJ4UURQuuAZvEpCJDN//AxYI37+N
	 s/zZyQiSKTecg==
Date: Wed, 7 Oct 2026 16:10:19 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, perex@perex.cz,
	tiwai@suse.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated
 SET_PARAMS
Message-ID: <asZSywHEbx-u6uBs@parshuram>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
 <878q49obcu.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q49obcu.wl-tiwai@suse.de>

On 07-10-26, 16:04, Takashi Iwai wrote:
> On Wed, 07 Oct 2026 15:25:06 +0200,
> Peter Ujfalusi wrote:
> > 
> > snd_compr_allocate_buffer() unconditionally overwrites
> > stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
> > driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
> > is permitted repeatedly while the stream is in the OPEN state, so a
> > local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
> > previous buffer on every call, exhausting kernel memory.
> > 
> > Free any framework-owned buffer before replacing it, mirroring the
> > ownership check already used in snd_compr_free().
> > 
> > Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > ---
> >  sound/core/compress_offload.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index 7c397b1c9231..c0ed76e1c844 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
> >  			return -ENOMEM;
> >  	}
> >  
> > +	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
> > +	if (!stream->runtime->dma_buffer_p)
> > +		kfree(stream->runtime->buffer);
> > +
> 
> I'd rather put to the else block above (or even better, if
> (stream->runtime->dma_buffer_p) block above that point).
> 
> The code is specific to that condition, after all.

I would block calling snd_compr_allocate_buffer() for subsequent
set_params, it should not be allowed.

-- 
~Vinod
