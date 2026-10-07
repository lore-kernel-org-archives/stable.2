Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFFA3CFF44;
	Wed,  7 Oct 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382118; cv=none; b=sQsG0q7sunmwY0xNp+RO4BHvA08nl0mrtiNP55eb/+S3p1+vZECzxcGijler+dXkYU3SgKKg4F5k9pwmmx4v4GVn+tc2Ql8n/LRo+SjyM/p1+x9Ci1QtZFrmqnYbQ5JZwvNm4e5dKAsolGiE3eh7dcs9jGZriLw4Qv2QCGcq5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382118; c=relaxed/simple;
	bh=ly9XlIWO7SNAZRIqp2lxz5hQox0nAIyJA1JKW7wN+7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URekgn0g0wWhEmToNOxVOhkAti3qHL7TR5bkAUnNrOMlmf4tqf38O8wTNIcQpn8Dc0CbvsZDoceIk/YepYKDakNAL+XQHrEHEeLe7dxGutIG0ohv+qLQM/ayDtX6YhJEwJUWse3/v2KTqMV//0G2sFldsFQ8B0nMVT2/Xoze9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmxEu2so; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmxEu2so"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CBF1F0089C;
	Wed,  7 Oct 2026 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382112;
	bh=wdGBnmJo0G8e6Ec+59NfLbmqPYZR7HHVL+Briols/fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HmxEu2soBRSJ08Q2ySLT0QTkrtQCPKkAiKoQy9sS3JRyJSD8sVb3Dh5V3BUloprh9
	 AMpNmoWnlIOUzZ3mwneM9/mp4EVdQMPOGyDaf1cyAcbBa9aLy6+717zOnW2YQEnVw3
	 1QQCBAgqrJKxpEVVHGIzSbWy4XxDIFzYcam99AIBfYdHFA6h3UwJJ739/LGk+EDlY7
	 rlHEoWnRxqXtDMvT3GyLEVUX6dGQMbGBLq10656toec4OO/J4fae/jLOyzUnzIyQbl
	 PkEdMoVC3FZjXOGIBWD7Tu8xY+Di2WYX2KeFDOnfqbEa5SQ137RKCuUrDBXiQfHOwp
	 tMj7wMUNki3TA==
Date: Wed, 7 Oct 2026 16:08:29 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated
 SET_PARAMS
Message-ID: <asZSXcCLvucipgWs@parshuram>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>

On 07-10-26, 16:25, Peter Ujfalusi wrote:
> snd_compr_allocate_buffer() unconditionally overwrites
> stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
> driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
> is permitted repeatedly while the stream is in the OPEN state, so a
> local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
> previous buffer on every call, exhausting kernel memory.


Logically this looks right but then I dont think we have or we would
want a case where we are allowing buffer changes on the fly. Set params
on the fly would set some params like code properties etc and not code
type or buffer ones...

> 
> Free any framework-owned buffer before replacing it, mirroring the
> ownership check already used in snd_compr_free().
> 
> Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/core/compress_offload.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 7c397b1c9231..c0ed76e1c844 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
>  			return -ENOMEM;
>  	}
>  
> +	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
> +	if (!stream->runtime->dma_buffer_p)
> +		kfree(stream->runtime->buffer);
> +
>  	stream->runtime->buffer = buffer;
>  	stream->runtime->buffer_size = buffer_size;
>  params:
> -- 
> 2.56.0

-- 
~Vinod
