Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697694;
	b=Cl1wQnl1sa+rtP0VT2gq1hQKtdZU0rQyvvts0KQN2MLUPlN2aI/9/orHdehN8v5MNaIx
	 VrOcI6+sapRWkJQAsGGDHuFBGih0goJyP+pbyoNBNKRhDtxlh0o86Pa9LJlr4Gx1wG9Wo
	 PKeKpjwg7+gE1ROIKThz6PA4EAxhTVReMOtnt+r8IzXpaYo678S9zsHwJEyh4i+OCnACQ
	 WMpkIXiyO+E+oEahby2RdkyciorW58naipwJ8AChTJvm/puRtaugg8/FREVuEG8xleTxS
	 O+yZr0Q3BPalHvp+BG87R0JNWukVdPBHDwo1uccdzaHkuwuw8Ztm0uiZw9PcNYWVzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697694;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r/BYfi44pWt5omLrxYHtr+zgS/ql3OzU/W5sAwqn8fY=;
	b=1NWGayySrdA3FuDfMiLKqVYGFAL6eocJy0Df1fLmOI1GQyPqb5kC3daROgFiUByOLgJZ
	 1nqwZt0B9RLWJoBE/3SwasT10Knnkesjb3qaVE9bugj0GkhWhogz3a17CL8S5opls1OCm
	 quxNRGuoZrIvHKv2rxcxqoQnm9NWXTQZUN36KoiJDZqvFWCX1Uu2B7bnQjUfyR1yaS5NS
	 TCmFxRvpVCu0588o8qF2stbNovLBnh7RY3l1ncBH2w0UoajIqOHE0QCxiR3Vt8Wgnrap8
	 UeVD8ZrUUxPC7vtOpZSRHR8kXBGENarUgZCoH8tzOvgmcCNwgmBBkZejoKzIqZCWYBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFwHWBRn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB5606D837;
	Tue,  3 Nov 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFwHWBRn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AE31F00A15;
	Tue,  3 Nov 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697694;
	bh=r/BYfi44pWt5omLrxYHtr+zgS/ql3OzU/W5sAwqn8fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OFwHWBRnr5xy89CQpN+MpgeqDnw74EZd4qe77AQfSfa7m9+z/Mo5xVEELrXgTwA7S
	 TOJtcsxsEuomj/GbPGaIAj0mv6AVUsWsq/0tHCwYqvk9cvAVEL2wpaUiuYhQZJdDAr
	 h4dIyBRX19u9g6UYDtfiqp43zc64QlgaQAHUxV0Bkg5ORfNPF2A3dxaeqwPnZHdizk
	 d8e1SChQ/RWF6U0MH2VOJqg6BTzDXC4XYLLJQ94prI1rpZdsM3U8TdaFm81KcCfxoz
	 7BRGt8cwu5hTAhPAX2J1AGHV/0kCg3j4YsOGc32zzLmMU5MF+0+3fEml1H2FNNpPMp
	 MjRSCPXmaX/kg==
Date: Tue, 3 Nov 2026 10:21:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-media@vger.kernel.org, nas.chung@chipsnmedia.com, jackson.lee@chipsnmedia.com, 
	mchehab@kernel.org
Subject: Re: [PATCH] media: chips-media: wave5: Release m2m devices if video
 registration fails
Message-ID: <20261103-important-platypus-of-wholeness-5fdac7@quoll>
References: <20261103083250.1174880-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103083250.1174880-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 08:32:50 +0000, Wentao Liang wrote:
> The encoder and decoder registration helpers allocate a v4l2_m2m_dev
> before registering their video device. When video_register_device()
> fails, both helpers return without releasing the m2m device. The probe
> error path only unregisters codecs that were successfully registered,
> so it does not call the failing codec's unregister helper either.
> 
> Release the m2m device before returning the registration error and clear
> its pointer. This balances v4l2_m2m_init() for both codecs without
> unregistering a video device whose registration failed.
> 
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 5 ++++-
>  drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




