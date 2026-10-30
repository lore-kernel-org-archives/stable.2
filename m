Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361804;
	b=sSmqyQ9+1mRVjVQ7B2e3Uo0EwNGl9yNoDHQO9FmUMjxGRCiRVv21LJRNm/q1oGNwufLE
	 d4h5kcHPShC/U98ljUn7Wtmw+vHc5KrPMGXHur8vYfXNw4oII7Se8zFnnTn+8kbiWLNd3
	 EIa5LAtoJrAeDJoFo7vzO4e+NNq9Ao9oU5crQSIVeb+9HataMbpe/EqOiPdygMN4id9vA
	 R3V0hWv/W0ddGU7mDoyrDt+lZkSueYJlGDJ8PgB2TGDywN6LO3kbqlS52vEWROKlrQ4O4
	 PSqR6EH5onJFJHwj47mPw5p6noh6hO9Nqr7Tzz1fjLpa+rkMkONG77Y7jq7vvs09vog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361804;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Vqc7d8nLnDH6SY/NwLMA/pExq5fJsVoXKB0ewbpvcqM=;
	b=iwO/UCC0LbAywH1woxgwPbuYXKZLQLj0sEJER2rCCC0gE/jOY7BvPNjlr/SQ7c0/I59n
	 0WyxrTIAV76NmEZApRPBbIf1A1fgnYzg1JXDYBVCe9rxomGR3YrYeOG4tEfWQu9BiWTpN
	 nz/UHDPsjMG+yPKSbFBLYhaXI7jXEFk5fHMt/WrivhERmePOu++/QQZw6FHKPGjGd1owB
	 F4ZQUer3Y8SdiC4KHnjlgumK9tER1HAKJM/KoWLT2HMXmxbJ9DfWCHjDShy7bmT45y4Gi
	 J6wu9dO2eXNnuMupoSl3/h6VB5vX1+Bl7VpNCkOZ1ci21l+IVJwbYwuZ+29XHMv/B/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFMIIgK1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940E606A31A;
	Fri, 30 Oct 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFMIIgK1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896C11F000C1;
	Fri, 30 Oct 2026 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361804;
	bh=Vqc7d8nLnDH6SY/NwLMA/pExq5fJsVoXKB0ewbpvcqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dFMIIgK1M1mF2mOACmxTUlj5DoA6aQ1Aw1ZyneFIrhT4Uyv5hLRkiu8xrVE+w35TD
	 qzsXddwh5530k5ziDengdcVX3TT4gaNkXSM+K75K5Lc7d8w8yV5VFOh22c2zrRigTB
	 ADp+sHxXDvdChNR7K7P7fvXtSK+8IfNYIxaBb8nFK9A71NfRfTYAIIbtIiDWKXeJ0s
	 lRk5bqUBeqHFwYv+OBtbtOdXmLaFySlvYZiOoEJfKhqXoFDTABmZdWwrRJsHKfbe7X
	 njZ8+eQKGekemCC7hxMuJekqBDJYLqCExb5Z9J9/IlueST9lFWWz4pifUSkNw4r2++
	 09lPUxXxpyh8Q==
Date: Fri, 30 Oct 2026 12:03:17 +0000
From: Lee Jones <lee@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/21] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA
 before closing BPT streams
Message-ID: <20261030120317.GF3774906@google.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-6-lee@kernel.org>
 <c56e07ba-3038-466c-9eb6-1cc5e23afe2d@sirena.org.uk>
 <auSBwzvJaWyFmVio@parshuram>
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
In-Reply-To: <auSBwzvJaWyFmVio@parshuram>

On Fri, 30 Oct 2026, Vinod Koul wrote:

> On 30-10-26, 11:14, Mark Brown wrote:
> > On Fri, Oct 30, 2026 at 10:46:44AM +0000, Lee Jones wrote:
> > > When sdw_enable_stream() fails in intel_ace2x_bpt_send_async() after
> > > hda_sdw_bpt_send_async() has already started the TX and RX DMA streams,
> > > intel_ace2x_bpt_close_stream() invokes hda_sdw_bpt_close() directly
> > > without calling hda_sdw_bpt_wait().  As a result,
> > > hda_sdw_bpt_dma_deprepare() tears down the DMA buffers and BDL while
> > > the DMA hardware is still running.
> > 
> > Does this actually need to be in with all the Soundwire stuff?  There's
> > no immediately obvious dependency.
> 
> Doesnt seem dependent to me

Sashiko grouped this report under the SoundWire subsystem because the
caller (intel_ace2x_bpt_close_stream()) lives in
drivers/soundwire/intel_ace2x.c, even though hda_sdw_bpt_close() itself
is under sound/soc/sof/intel/.

You're both right, there is no dependency on the rest of the series.

Happy for you to take it directly through ASoC if the patch looks good
to you or I can drop it from v2 of the SoundWire set and send it
standalone or when I handle ASoC.

-- 
Lee Jones
