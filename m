Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791D5221E0;
	Tue, 29 Sep 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684712; cv=none; b=ZhSjlbeYsi9n33db7L3USPP94CjmTTofVWmk+MJ2HvifvNtfTRGn6HDubPs7nROqVcozRCHuQlUbsujJRc548RR0b9s8bbRDBzjjL5gIu0Gz1DJBLbY1WqfZ2qhD9C0/aV7F4E9MyZEJIBMPcZASRbMQBImVO6hZti/el4U/jVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684712; c=relaxed/simple;
	bh=95+J11Z1DOc+XACtc20K9QsddW/UgdODPyGGv0UDEas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7n1wJi7y5sWbe6S6NixunmXi6wTaCeSqOZVDsSfG4dGy80dIzhqRK8Ikw4PkkzudADPIPBcykjuEHh30LmlQ5jvU/pyc4+qAQZV91O4KwVrIR49JnXHqnjHFoGVY6jfs+eKLVwTt9i4vhb7MeTf5acW+uEHROLTgMa63aLWUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaKRjqTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaKRjqTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814801F000FF;
	Tue, 29 Sep 2026 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684705;
	bh=pFzLhkHFFB73b2wvbO900QMj34HswOaXL4pqgH8gQtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QaKRjqTPFu7B3gp/zMWuiiPSzIciO6Cbe0lW/sxHDAAWh8+z4bVL2ubG0GUNN5aFL
	 nmY4WbqY3tNf3mDI0LabX5FgKeWB1oZa3VP4QSCJdaj+jh9AgV3IRvKbHNIRU4ejng
	 +Ik8BYF+V5AhgDa185xKI2awIE8OmrM/95kzzZOX/oqN9HRTrx3Ot83GFPi05gtqA5
	 yfNQN+xU1CGoF/Qv0cpaGfyrvTI1n4wIhS8JZuHnYLqfRgAJ80afTmuQovGEEVubX7
	 l81RVh9GSWVf2x7t2bs4zgPrMrm/BqVsm8QHJXBUsRoeyb6VG/1wDQY6S0m+h58BGR
	 ws2PZ1GLu7Mnw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xBWtL-00000006yNc-0MCV;
	Tue, 29 Sep 2026 14:25:03 +0200
Date: Tue, 29 Sep 2026 14:25:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Liviu Nicoara <lnicoara@thinkoid.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jonathan Marek <jonathan@marek.ca>, linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: codecs: lpass-wsa-macro: rewrite the
 interpolator volume after enabling clocks
Message-ID: <aruuH-uNfWYxBp7b@hovoldconsulting.com>
References: <20260929115755.6096-1-lnicoara@thinkoid.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929115755.6096-1-lnicoara@thinkoid.org>

On Tue, Sep 29, 2026 at 07:57:55AM -0400, Liviu Nicoara wrote:
> Commit 902f497a1ff5 ("ASoC: codecs: lpass-wsa-macro: remove useless
> gain read/write sequence") removed the read and write of the digital
> volume register in wsa_macro_enable_interpolator(), on the grounds that
> writing back the value just read does nothing. The comment above it,
> "apply gain after int clk is enabled", was left in place.
> 
> On the Dell XPS 13 9345 (X1E80100, four WSA8845 amplifiers on two WSA
> macros) the write does something: a volume change made while the path
> is idle does not take effect when playback starts. Lowering the digital
> volume from 81 to 63 with nothing playing, then playing a test tone,
> gave about the same level as before the change. With the rewrite
> restored, lowering it from 81 to 69 while idle played audibly quieter,
> and restoring 81 while idle brought the level back. Changes made during
> playback take effect with or without the rewrite.
> 
> The register already holds the new value when this happens. Without the
> rewrite, after an idle change from 69 to 81, playback stayed at the old
> level while the register, read from the hardware through /dev/mem, held
> the new one (0xfd). Writing that same value back through /dev/mem
> brought the level up at once.
> 
> This is the behaviour described in commit 46188db080bd ("ASoC: codecs:
> lpass-wsa-macro: fix compander volume hack"): "the volume registers
> still need to be written after enabling clocks in order for any prior
> updates to take effect." The value read comes from the register cache,
> so the write pushes the last requested volume to the hardware once its
> clock runs.
> 
> Restore the rewrite in the interpolator's POST_PMU event only. The mix
> path event removed later in the same series is not brought back.
> 
> Fixes: 902f497a1ff5 ("ASoC: codecs: lpass-wsa-macro: remove useless gain read/write sequence")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Liviu Nicoara <lnicoara@thinkoid.org>
> ---
> 
> Notes:
>     Changes in v2:
>     - Cc stable (Johan Hovold).
>     - Add the /dev/mem read and rewrite from the v1 review.
>     - Link to v1: https://lore.kernel.org/all/20260924125940.22665-1-lnicoara@thinkoid.org/
>     
>     Tested on v7.2.6 on the machine above, by listening. This function is
>     unchanged between v7.2 and for-next; the driver's clocks moved to the
>     PM clock framework in cd054a6e272c after v7.2, which was not tested
>     here. Build-tested on broonie/for-next (arm64 defconfig).

Thanks for the v2.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
