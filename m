Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361897;
	b=MRodZd5UywdsgtdVNLNxQTiVFMRk8tI8HWd5hH8jhgMFGSczTDuMIAZkYaVQqfTupnfk
	 akrBTSOg9yt8REYKtwnRsw8aCsw6P7ZmWxuGMbCwu62pxaeTNfAoYgeZNSA+UrXDnsfpz
	 jKkDxL0MIBiJhb8otWLQTq3NnfvQr96J8p8/aSUHAksH5lG5YydETNVySjEG4m54t50OT
	 FGASANN89IQp5rRMkOCk4xe+0d5mLemP2KL4qD1scQZLKFgv7JVwBPP6qvNsfGlHzKtMR
	 6RuncBgnTgcNyvCRum76usDxHdRCpTyp1KmYGoF8GVaQ+0ybUVIMyUMZRVW+sMfVRRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361897;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1BzPLi5ldrzbAy5AgNEu0GX66dBkc2cApy1ZIBvasOo=;
	b=3d5xKhfYZa2iNwhG3Jmd3xVdlQiQgHRJSSX4rzKYon9uStzC877niviasamJ2rrmUhOF
	 mqKKmgWy/L07jn0IydRfrcqOPf/riExL9cdrQF8q1+iz0U/3pCpNpL6NslyjLEtXrSVkc
	 oR2qVOWXGPZrX6LpsgjRuyuiy2rsQg/GJO5tuIuLH5+JWDC8tbqkCehJOphptOuDf4JFv
	 cvxvGZpxMFpp+l3/8GHnFnBfZHbMTKBSsUc7aXQYAFGUaEvN/ZNJFuMTW5xAa0opJ9kmW
	 UeHNxlpGhWELhxTG7MBQ/pbfHFZSESVwT3FsldFk/8bYwpziFNtgUPdFqvu1e/8tdRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zl/3FIs8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D9606A326;
	Fri, 30 Oct 2026 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl/3FIs8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1321F000C1;
	Fri, 30 Oct 2026 12:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793361897;
	bh=1BzPLi5ldrzbAy5AgNEu0GX66dBkc2cApy1ZIBvasOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zl/3FIs8VpthH5bR5QRxV6qaTWH2gnDIHAlDGgzlu1wFeboZbLim0FqEF+pwbOVjZ
	 Xa11KE3AgRzDoGie+T9xoFOmW+p1zyZoUK8WIuPmMnGMn1YUMKjtpLfXCqhaboY9NO
	 RFAxGjb4H1u1MRSd7iYTb0Lsf2tTGh02597aRYnYrta42b3m809JFpKpExXiY5XHey
	 ILaDfMRTA8fuJj1lOOJGy4+aJdGPjx1VLghugwxTOyB2mngnoVIr3g0sAeGPIJyQ1m
	 yumsWiAtKBydDdBU282+uyVtuQRPxziDArjPeJ63ff5BdO4x/mA4ZRK5ZeuJNojYXr
	 RpIcmIjD6r5jw==
Date: Fri, 30 Oct 2026 12:04:51 +0000
From: Lee Jones <lee@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	"Prasad, Prasad" <venkataprasad.potturu@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
	"N, Poojitha" <Poojitha.N@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 15/21] soundwire: amd: Avoid static port offset leak in
 amd_sdw_compute_params()
Message-ID: <20261030120451.GH3774906@google.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-16-lee@kernel.org>
 <bb7e2262-af12-4891-9070-74058812d5ba@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb7e2262-af12-4891-9070-74058812d5ba@amd.com>

On Fri, 30 Oct 2026, Mukunda,Vijendar wrote:

> On 10/30/26 16:16, Lee Jones wrote:
> > [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > amd_sdw_compute_params() tracks the next dynamic port block offset in a
> > static next_offset[] array initialised with {1} (which also leaves
> > instance 1 initialised to 0).  Because next_offset[] is static and
> > never reset when streams are freed or when the driver is unbound and
> > rebound, the offset grows monotonically across stream lifecycles until
> > it exceeds max_slots - 1 and permanently fails with -ENOMEM.
> > 
> > Compute next_offset locally in amd_sdw_compute_params() from the active
> > ports on the bus and clear port_offset_map[dai->id] in
> > amd_sdw_hw_free().
> 
> This is not a bug for ACP6.3/7.0/7.1/7.2 platforms. These variants
> do not have banked registers for data port programming. Instead, a
> fixed port mapping per DAI ID is used by design: each use case (e.g.
> headset playback, headphone capture) always maps to the same DAI ID
> and port number across stream lifecycles.
> 
> The guard at line 402:
> 
>     if (!amd_manager->port_offset_map[p_rt->num])
> 
> ensures that port_offset_map[] is populated exactly once per port
> at first use and never reassigned. Since the DAI-to-port mapping is
> fixed, next_offset[] advancing after initial assignment has no effect
> on subsequent stream open/close cycles.
> 
> Furthermore, the hw_free change introduced by this patch:
> 
>     amd_manager->port_offset_map[dai->id] = 0;
> 
> would be a regression. Clearing the map entry on stream teardown
> causes the port to be reassigned a new block offset on the next
> stream open, at which point next_offset[] has already advanced past
> the original value. This breaks the fixed mapping invariant that the
> driver relies on.
> 
> The number of concurrent streams per instance is known and bounded,
> so -ENOMEM from slot exhaustion cannot occur in practice.
> Please drop this patch.

Done.

-- 
Lee Jones
