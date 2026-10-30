Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360328;
	b=4gnx4JRmAkXavZ9WRfLEqNg+jhsuyZhgVlWN6qyxUIomHNL1q1KNiIyjJPBzm3LC28NM
	 MSI20qJ5iSsb18oDSbTby2Ck9xhrY1DiEAr0WiItZf8dqsgwv4AoFClnQYKU4mF9swNh4
	 rfwnjEQ6Y9zpLuMrEjpSJJXgRE5bMOXUw3BhjU/fuwE/UbX3y3UNiAybPIYuioAwplJj9
	 C1MAzkF2KWuy7LXdu4EzJailRaLbLtIqR2ke84bmJcMZzTBBxoGF04LFAtPLAX/QKvpPo
	 5s6ZbJo8f+t1WFwvj3sBc/e3cJYzBUjRPn/8wlOtBQ/V9hQZFdCX8GCju97vTDODcCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360328;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3Mwlq5sMliAwELr+fuLBkmzrUFIsNRXm4j3eRddU/o0=;
	b=LmbwSVMKiavX3UvrLNFEV4ZFJaRneq8OOl1e8YBZ4dK8m9GGXwXUQyTGi/BXCMhRixAO
	 rx9Pn6cMMHE+E2V6vViBbbRdjg2jm6QZq1YxE2eoq8eE9uMmDVk0zfLBFg8+U7cUzFGKm
	 fSS/aJiX7q/rIv+VK5wRvCQQZ9Xt/FGxszqEML56YwmmuI9UXT5zIMaFi/wPI3aClukIs
	 pr8SpphQ9sFnQkpmoUmJIGui0LMy4oHwbVScx1H2oauIH0dsv/9GFIKPdMHNQ8YfTowEY
	 PSsU9BGbaxxseV1bjG7kAXqSicycZxynpjNw3puyhztYE9Z0poHJKh2OhW+y7uKFc/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2idrk4r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041D606A31F;
	Fri, 30 Oct 2026 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2idrk4r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EEF1F000C1;
	Fri, 30 Oct 2026 11:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360327;
	bh=3Mwlq5sMliAwELr+fuLBkmzrUFIsNRXm4j3eRddU/o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2idrk4rhrVjaBEC+DNuKPJWdiI9RYe5rLMqQxNQr84+ZtwYEVnrjLiDkF0YTjWGo
	 HP779znfkAtLwij3WJQVXkeLmI+rhEbI08J6w7DhtejERuW2DTy9KXEGFvA9DUOB/+
	 fP/JfDcM1MHnJmfJLT46zfEHRxF6c0n2KYCF/h+RCUAOyyYd4MNYtq5Gh9MfCEa6JT
	 WZgn/nNqpbm7W2kLxht0ak5TOMTFczdVxCpumxeEoF4HGDrFORW8zYSigOSOxePnrd
	 RKpwUSaLZez3lcF4d2hM3Egla+hbA/eNI/5kh1Te6Rwwq43rS3fSSAPD9qHVRcBt1u
	 NsxXT9UCLNvEA==
Date: Fri, 30 Oct 2026 17:08:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
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
Message-ID: <auSBwzvJaWyFmVio@parshuram>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-6-lee@kernel.org>
 <c56e07ba-3038-466c-9eb6-1cc5e23afe2d@sirena.org.uk>
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
In-Reply-To: <c56e07ba-3038-466c-9eb6-1cc5e23afe2d@sirena.org.uk>

On 30-10-26, 11:14, Mark Brown wrote:
> On Fri, Oct 30, 2026 at 10:46:44AM +0000, Lee Jones wrote:
> > When sdw_enable_stream() fails in intel_ace2x_bpt_send_async() after
> > hda_sdw_bpt_send_async() has already started the TX and RX DMA streams,
> > intel_ace2x_bpt_close_stream() invokes hda_sdw_bpt_close() directly
> > without calling hda_sdw_bpt_wait().  As a result,
> > hda_sdw_bpt_dma_deprepare() tears down the DMA buffers and BDL while
> > the DMA hardware is still running.
> 
> Does this actually need to be in with all the Soundwire stuff?  There's
> no immediately obvious dependency.

Doesnt seem dependent to me

-- 
~Vinod
