Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3293F7ABC;
	Wed,  7 Oct 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382330; cv=none; b=dh2BA9TiIzNP5abj2ge3MEO6PZiI8C5uPk41n/sNxJwmUQy8r0g2emVdo0pnYV/EBRK8xO6NA0kyBw/N8XjFb06cTUD2I0nreP1MC5Usrhg7SM1ZrL00v98MznyyNsu7D8o69s2WoQM8r0J400vylwS/uMZ43YreCyl3sk2p4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382330; c=relaxed/simple;
	bh=Z+AAsBrFQadXiPpXe1DG2W0KfbBp2IL4KSP4txtEnF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv8NTyl2hmLiU5gI41Sd63iGQVTN4S7kW9946iwBwONDKtB4eSGSnkOY7lq6H8hgeQOUhRggOcDwxcA8D8xJzE+kMs/e+z4qf5RflXxuKxnA+qQyilr+dM9lVbbQI/5DJ9FZnDD0dq+S5S6lZbX6kIdox2PnF/HMC7MIVPj5Aig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F90llSAF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F90llSAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639D91F0089D;
	Wed,  7 Oct 2026 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382324;
	bh=Q8ilm3SRP9dDbtXW7SBgILjUx1aRVKWoncvoXd3e1RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F90llSAFPGxel9yU+RMfIs7QRgUx5Z80kyON4rekn2aFkEC1hWxv/25RPkt76HiLT
	 fYA/qA02RLr0irVMokqrpgoYj3+oqw3jEyYQThdHJTC/ICdCSXkKJXhgVbYZU3MRdY
	 9tCZ908DnwNK1N1VNmkd710APw/GWBGaBk2tFab4pjIN9Wv8HXCeF1H7TdiHre/+mX
	 Ro3TKA7aYWj55CL6e8pQVtLm47a6UPai5QFaLOX0Fv9hV5e4RHcs5wN7Jl3PTqQyKd
	 +zdAGVI3mqX3Ux05DZeCXkMFAnm6PbphYQVFykZh02krGiZ6co59AbsmHZBP1qgSXr
	 xT010oho2V+aA==
Date: Wed, 7 Oct 2026 16:12:00 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] ALSA: compress: reject buffer geometry change on
 gapless next_track
Message-ID: <asZTMBQP-LCpS0Yf@parshuram>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-3-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007132509.18237-3-peter.ujfalusi@linux.intel.com>

On 07-10-26, 16:25, Peter Ujfalusi wrote:
> snd_compr_set_params() is invoked from the gapless next_track
> re-entry path, which calls snd_compr_allocate_buffer() again and lets
> buffer_size change while total_bytes_available and
> total_bytes_transferred still hold values computed for the previous
> buffer. snd_compr_calc_avail() then derives an avail/count value from
> those stale counters against the new buffer_size, and
> snd_compr_write_data() copy_from_user()s that many bytes into the
> new, potentially smaller buffer, overflowing it with user-controlled
> length and content.
> 
> Reject a next_track SET_PARAMS that changes the buffer geometry
> instead of reallocating, since total_bytes_available/transferred are
> only valid for the buffer sized during the initial SET_PARAMS.
> 
> Fixes: 9727b490e543 ("ALSA: compress: add support for gapless playback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/core/compress_offload.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index c0ed76e1c844..e1cc34ba2c2c 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -673,9 +673,20 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
>  		if (retval)
>  			return retval;
>  
> -		retval = snd_compr_allocate_buffer(stream, params);
> -		if (retval)
> -			return -ENOMEM;
> +		if (stream->next_track) {
> +			/*
> +			 * total_bytes_available/transferred still refer to the
> +			 * buffer allocated for the current track; the geometry
> +			 * must not change underneath them.
> +			 */
> +			if (params->buffer.fragment_size != stream->runtime->fragment_size ||
> +			    params->buffer.fragments != stream->runtime->fragments)
> +				return -EINVAL;
> +		} else {
> +			retval = snd_compr_allocate_buffer(stream, params);
> +			if (retval)
> +				return -ENOMEM;
> +		}

better, i would go one step further and invoke
snd_compr_allocate_buffer() only once!
I dont think DSP expects buffers will be changed

-- 
~Vinod
