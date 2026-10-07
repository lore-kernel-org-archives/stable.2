Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEF455619;
	Wed,  7 Oct 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383855; cv=none; b=ng3GD6UwHiMBP5/KUtjNcmJISpjkXmqv+JfdhDJKroFVciISTLaEmFZyVKP/lPH8D8LvWNNvf/xCpIDWmNaNsKJR8digMUpHjBWiISETAFAlUSFiLVXuhxe8ImDtg3rAyUE6NZUhMPnW3pD+yI6d9d7XP70Yz/FAJdOG9n30qVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383855; c=relaxed/simple;
	bh=xRzZceDIr9iEVTLoBeJ/kzV6A4SoSe+JdhozoxZ2xd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/cir9v2/4/7qeguQnVfdFJkSWhKILXg9sU8dgTKPDK8QOgZjzXCEwfNtvDAcYktByICKxX5O0qc1qtnnNoxEDIsTZqpCT803zUNCclydSr5bg45XpHK1L+1fPHxZz96G4rCkQi2BfjnEnXuAL3cB1lSCYugW5g9jJJzsdYEcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl/IxSa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl/IxSa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49D31F0089B;
	Wed,  7 Oct 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791383850;
	bh=UaLNkRVJ7NjxsJUHYXTswR8hqNFuX8vUbeKs9V1Jff4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cl/IxSa9JbJp9WjViEPSEQSr8xS3ht20rypI6mdkYx7MG/LygIM6Pke1pxNk8L2Zy
	 RjT6TWLeI2BaHdftokk29G+WLVp6FMlu938ApHu6jLA0KB4EYnLGuTxekztA37V86D
	 ufQ+zivuD0YEBJzI0FGgzSmIuT3VauTSCkGKh1KwQXqN1hrc+FezL+gTeEA9ymE+QQ
	 O25STdJSrCyaLkKZGwPIQhijZoA7bzMdP8SHppUw6yCLRzBi9Z0IyFAkZbV8zuXuR4
	 ukbo/L2QHe3AoScmXE1wJcSq+9hPux+k9HHX02D5GIsBvXRB96evQlknqpdEygRaJ0
	 Ub0YyejnpFUdA==
Date: Wed, 7 Oct 2026 16:37:27 +0200
From: Vinod Koul <vkoul@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
	pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated
 SET_PARAMS
Message-ID: <asZZJ--dC9M7jx4A@parshuram>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
 <878q49obcu.wl-tiwai@suse.de>
 <asZSywHEbx-u6uBs@parshuram>
 <6e27af41-1ba4-4d3e-a128-c2d1402a8f6e@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e27af41-1ba4-4d3e-a128-c2d1402a8f6e@linux.intel.com>

On 07-10-26, 17:25, Péter Ujfalusi wrote:
> 
> 
> On 07/10/2026 17:10, Vinod Koul wrote:
> > On 07-10-26, 16:04, Takashi Iwai wrote:
> >> On Wed, 07 Oct 2026 15:25:06 +0200,
> >> Peter Ujfalusi wrote:
> >>>
> >>> snd_compr_allocate_buffer() unconditionally overwrites
> >>> stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
> >>> driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
> >>> is permitted repeatedly while the stream is in the OPEN state, so a
> >>> local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
> >>> previous buffer on every call, exhausting kernel memory.
> >>>
> >>> Free any framework-owned buffer before replacing it, mirroring the
> >>> ownership check already used in snd_compr_free().
> >>>
> >>> Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> >>> ---
> >>>  sound/core/compress_offload.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> >>> index 7c397b1c9231..c0ed76e1c844 100644
> >>> --- a/sound/core/compress_offload.c
> >>> +++ b/sound/core/compress_offload.c
> >>> @@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
> >>>  			return -ENOMEM;
> >>>  	}
> >>>  
> >>> +	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
> >>> +	if (!stream->runtime->dma_buffer_p)
> >>> +		kfree(stream->runtime->buffer);
> >>> +
> >>
> >> I'd rather put to the else block above (or even better, if
> >> (stream->runtime->dma_buffer_p) block above that point).
> >>
> >> The code is specific to that condition, after all.
> > 
> > I would block calling snd_compr_allocate_buffer() for subsequent
> > set_params, it should not be allowed.
> 
> OK, let me see how it should be done. I'm not sure of changing other
> params are permitted either, but imagine:

I would split it up for next_track and open, so that we have clear
flows.

> the application calls set_params first then after some deliberation and
> before starting it reconsiders and wants to have bigger/smaller buffer.
> I know, they rarely do, but if such application assumes that the second
> buffer setup is valid, while we kept the initial one, things might break?

Hmmm, do we really want that. they can tear down and reopen in that
case?

If we split as above, in next_track case we can apply codec params while
ignoring buffer.. wdyt

-- 
~Vinod
