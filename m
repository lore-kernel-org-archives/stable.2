Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098167;
	b=n6VS2Qe0tUrKKrB82bFVm6SPqNyzNs3GDZEZaXBK4LVHRIs8aJBLVcSeVuHpLYbkaYQA
	 mv58H1O7SjeeJ1F9U7YVavAdn5LUoO3KohWRSkRXHnNZxTp65qtvJWzeECVDeNlhNDfAK
	 /lFTYUd/6/h0lfdUW9mihJHBpAdi4L7/4DmMFi7q0IWtCBsK7SLpoSmcVA12M7lGb4Id/
	 4keVH5BF1+XfyNczC/yhL8SYA76TaOg7SBvwBzjDxI0FTAnbzD8erU5BWv+YBFCdL2Pp+
	 PZk8ZP11UuBGldC0J+j/Gm5kAhvP3OkQda+TQyge5+C8AKewqLFs48DmbGYmrog2Guw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098167;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m2P2bAoF3lPHG2HUJuO9IMliUhRE5zUZXi1VzqMeRmg=;
	b=CZnSQkqFe/4z5SZ51JM975LVR7DncvWnG8ivu11AO8sAyLYaPaXp7iuRgPHmdzxm1a8a
	 4zPFzULixPxCJjimeWtA9Ze6cwdWDhlU7P1lZII3t1lrbkWle11J9nTYzurriYhSGR98n
	 wPvyFFruQsI+NXM4Ey6YKVyasyRX2s+6VVIh3S55mZvP85lZtpOq86vlwZuYgrPbTMjkN
	 y+kiNSYqyc3NeBDiohWqQ+SNMWche6FZOXFswtJW3670oBGBrblmvlwmCY95MWal9dU/w
	 +4pfzx6TGKys+bO8zl3nG6uNPi/mLYCylLpAK3yOYkVXHSMWqU3YE5IVDKxUJSv6R5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nxRAi8yh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF5606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nxRAi8yh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00411F000C6;
	Thu, 19 Nov 2026 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795098166;
	bh=m2P2bAoF3lPHG2HUJuO9IMliUhRE5zUZXi1VzqMeRmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nxRAi8yhG1C9hVOxwjbPRWSZfg21RHfWaAJttPZTdag82hNKz6+sfSg1DZiAsb5dc
	 IqloxgWFW6Qqv1xfzq7692ZADq/cvA5EUuvH9btubXAM5bMbqgtB2e4MiIswO5IzB3
	 wUVxEvIEOU9+Wqi42TfNXaR8Zoef1+oLi1ITY5oI=
Date: Thu, 19 Nov 2026 15:22:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nathan Blomquist <nblomquist@gmail.com>
Subject: Re: [PATCH] drm/amd/pm: track BACO state in the SMU v11 ArmD3
 sequence
Message-ID: <2026111904-gloating-share-b28e@gregkh>
References: <20261119141944.2994497-1-alexander.deucher@amd.com>
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
In-Reply-To: <20261119141944.2994497-1-alexander.deucher@amd.com>

On Thu, Nov 19, 2026 at 09:19:44AM -0500, Alex Deucher wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On Navi1x/Sienna Cichlid with runtime PM, when the audio function is
> enabled, BACO entry and exit are delegated to PMFW by sending
> SMU_MSG_ArmD3 instead of going through smu_v11_0_baco_set_state().
> Unlike the v13/v14/v15 helpers, smu_v11_0_baco_set_armd3_sequence()
> does not update smu_baco->state, so the driver keeps reporting
> SMU_BACO_STATE_EXIT while the ASIC is armed for / sitting in BACO.
> 
> At runtime resume amdgpu_device_baco_exit() checks
> amdgpu_device_supports_baco(), which ends up in
> smu_v11_0_get_bamaco_support().  Since the state never reads ENTER, the
> "already in BACO" shortcut is skipped and the live BACO feature bit is
> consulted instead.  PMFW clears that bit once ArmD3(BACO) is armed, so
> the check reports "supported but not enabled", the exit fails with
> -ENOTSUPP and the ULPS ArmD3 message is never sent.  The runtime resume
> caller ignores the error, and a later secondary bus reset leaves the
> device unreachable.  This shows up on a Navi 23 being handed from amdgpu
> to vfio-pci:
> 
>   baco_enter: in_runpm=1 audio_enabled=1 armd3=1 baco_state=1 ret=0
>   bamaco: state=1 ... feat supported=1 enabled=0 in_runpm=1
>   baco_exit: supports=0 ...
>   runtime resume: baco_exit ret=-524
> 
> Update smu_baco->state in the helper, mirroring the v13 implementation,
> so the capability check short-circuits while in BACO.
> 
> Reported-by: Nathan Blomquist <nblomquist@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
> Tested-by: Nathan Blomquist <nblomquist@gmail.com>
> Fixes: 13d75eadfa1a ("drm/amd/pm: correct the runpm handling for BACO supported ASIC")
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Link: https://patch.msgid.link/20261103141457.2558235-1-mario.limonciello@amd.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit d515b2694eab5b35533c7fb7af5bddff53ff60d3)
> (cherry picked from commit a26ec190925733dd205507493e936e59dbcd2b19)

Really?

:)

What stable tree(s) is this for?

thanks,

greg "I hate the drm git tree" k-h
