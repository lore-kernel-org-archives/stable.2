Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361176;
	b=cESA/9Cgiv+zjbT1s7e9Ve7d5L6ADpTmZtecsSksNmAvdu52ILUwwmgZhxTyNzsdyLKh
	 rYxhVYc0Teq5hFj+V2VLCYPAQ+H4pmOHM/dHA26kOQ9QeUynHi6VHJkcCMV4pttX73zPw
	 bXMx1in25QgzHaSlnSg0IsEReQn6169uPv24CK3mKnJrZyyBEKBFr8J/88AN8QMMCxX3/
	 63C6KGaNmXPVeZKl2/btRrpRn+kdCvjuykIjrxURp1vR5LqN9Ye+TL5uMvwkrhdntmsEo
	 hTww1epEJHWc51NV2lQOati8Le31ktatJOjO6x+uPC53dYZ3ky1xYi+YWmrZG4ap8ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361176;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XYrzJWmEZKkFPZMaPW46QbvWAVXRKrj/gB8ZKuUz8FM=;
	b=JAyDdVIKybYG28OupRs2+Xmf5QZJQnsdvEwZhZmZTQqDp1zwEAZG7fnBHBTwwgcg/EnA
	 G9RFCDZXa4hOtn9oxbk+ZcIJVsy3OzhKEdntGZa/w8YhHGqVTgwmfW6QTj8zzOjGKkmSG
	 Xj235KI+wM6Q0dRHJyyYjCU8oG1idVJv0Fnq4EdjjvblGWbvfQpx73N0LIdlHvDWJGri1
	 nCK6PQMgaak51EzJJslFsobtbhMQuwZc+dSUq12VuqxEBLpkQL84+w6+wK9a0vu3wV5A1
	 Qz1AFDPOGV5mKf09LLMwAohm9D1bs84axBFf7ButoPUjPG0kR4oagOIeOf6UAqjw2gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiPnqMSj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A860A261F;
	Fri, 30 Oct 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiPnqMSj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257D91F000C1;
	Fri, 30 Oct 2026 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361176;
	bh=XYrzJWmEZKkFPZMaPW46QbvWAVXRKrj/gB8ZKuUz8FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DiPnqMSjvRoyi70DomIOw6CqbeVXC2AvvO7EOLIxXAWnSmUrXdb1kvsE/a2x2u8KE
	 m+CnNwo47S+kaktCHUK22U40orsxDbjphNwjSwqR5rzALNcvlvfE7xBjnpivfjD7L0
	 lV1aqdacXBL3YyZ23HCB9tXNcG6STB0xqUOJfFpiAqwjGFVrTtu3kmZbDIchUxcuFF
	 IIEg5a/e2Mak05s/NICgBjzfd7/1s3EoT1dB3fdcI4QNwfLNUwuJv15rnZru6DtJ/E
	 ewKyQwnBUOI1MPzSyUlpLqdbONqPHNdcfOH3mk7NHAIVCcWOnRBDXZuoZSGhVs3OA7
	 lJM3kgQvC1aYA==
Date: Fri, 30 Oct 2026 11:52:49 +0000
From: Lee Jones <lee@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Prasad, Prasad" <venkataprasad.potturu@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	"N, Poojitha" <Poojitha.N@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 14/21] soundwire: amd: Preserve lane control bits in
 amd_sdw_port_enable()
Message-ID: <20261030115249.GE3774906@google.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-15-lee@kernel.org>
 <354b6a81-b8d8-4394-83aa-2afa13108df7@amd.com>
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
In-Reply-To: <354b6a81-b8d8-4394-83aa-2afa13108df7@amd.com>

On Fri, 30 Oct 2026, Mukunda,Vijendar wrote:

> 
> 
> On 10/30/26 16:16, Lee Jones wrote:
> > [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > lane_ctrl_ch_en_reg holds both the channel enable mask
> > (AMD_DPN_CH_EN_CHMASK) and the lane control field
> > (AMD_DPN_CH_EN_LCTRL) programmed by amd_sdw_transport_params().  When
> > enable_ch->enable is false, amd_sdw_port_enable() writes 0 to the entire
> > register instead of clearing only AMD_DPN_CH_EN_CHMASK, wiping out the
> > configured lane control bits.
> > 
> > Clear only the AMD_DPN_CH_EN_CHMASK field when disabling port channels.
> 
> Multi-lane is not supported on any of the platforms handled by this
> function (ACP6.3, ACP7.0, ACP7.1, ACP7.2). AMD_DPN_CH_EN_LCTRL
> (bits [2:0]) is never programmed for these platforms, so it always
> reads back as 0. Writing 0 to the entire register is therefore
> functionally identical to clearing only AMD_DPN_CH_EN_CHMASK.
> 
> Upcoming AMD platforms use an entirely different implementation and
> will not use this code path either.
> 
> The described bug has no practical impact on any hardware this code
> runs on, so the Fixes: tag and Cc: stable@vger.kernel.org are not
> warranted. Please drop this patch.

Thanks for the review.

Wilco.  I'll go manually turn down the Sashiko bug to this effect as well.

-- 
Lee Jones
