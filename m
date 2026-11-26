Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703103;
	b=wF1O0b2qzg91OYK436gQhaGhVhs45k63wgrGH2n79srZgkbent0xfYlNWt+uEfMfwvpl
	 HcVoMe0gjR+hgLr0VN5lcscBPJD9yY0AWDEyeAa03lrdiIavNOIZUniJAOUta3tNVbYuz
	 Itp5DLafusDGanSl3Cq7p3eZDTXmIyPl01XCzByxIUCIKx7HPBBLT3GhPOwllZKkswTH9
	 Da6rNgtYB3ShJe83SiEK/JuCwWZrvHK5bTuXK6ASwSc6y/POagsPt6tuNv4IV+Bx31Z6k
	 9its/3Sxin7cgWGA8m+ccgN6i8NpaYLWo03UqoKWKSd/TNmgnOrB8jZ0//49qh9yRIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703103;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9vwVYUvGV2WUae1h/2niakTHh/F8JGHfUQz7QkRlWn0=;
	b=4OMWJabxRF6OrWgui35cwBJFhQLfoOq63ur6+8YF0e+CYOAEbnxMiJvbF8amaJdgijnZ
	 1UM6e+FpDAiI2avPnhQ7GcWdov0b4dx0EQvfv22S0hWUQ6ol4gveaqTZ4iKuDVsXvxUUM
	 5LW3E6DyZWXrCenwmMdl9CelD0gdd+diO6clV/jZLOzWHI64XsGAINkW45wEQuN8RzQ8P
	 AoFYPKD7dANAbDNGdqw/6bE4V2TdlxJckqsA6Bh67oxMTSvspGmcAasxs7kD6gaM/3ZrB
	 uQ9z5v5MolyUm4VvH0U31RdxqOcwjGkPPpSfyb5IBFVI55Vtw3CcmzE4KfF1tBX11JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=auuAUpTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06440606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=auuAUpTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61321F000CA;
	Thu, 26 Nov 2026 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795703102;
	bh=9vwVYUvGV2WUae1h/2niakTHh/F8JGHfUQz7QkRlWn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=auuAUpTZrw9ACX4MUFLLWWlllMmpzqPejQMG0Exml2+jwHBIjCmBYfkUdzEmvo1ky
	 S0YQ4MPBAZIwSCWQ8KNwpcReFr26e4peZ/AiZPcq8wrEIGwqM1wC+72/5PuHymlXPM
	 +6AKmrd5IYpmjafz5pn4obzB0o7Mg22QlqLBgQVw=
Date: Thu, 26 Nov 2026 15:25:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dickson Wu <dickson.wu@certik.com>
Cc: stable@vger.kernel.org
Subject: Re: Request: security fixes for 6.1.y, 6.6.y and 6.12.y
Message-ID: <2026112609-strep-tactless-e22d@gregkh>
References: <CAFaZ9eqzNSgQejze-paRJ720iMQpNA=0HCXB6YOgfK+c7YBfRw@mail.gmail.com>
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
In-Reply-To: <CAFaZ9eqzNSgQejze-paRJ720iMQpNA=0HCXB6YOgfK+c7YBfRw@mail.gmail.com>

On Wed, Nov 25, 2026 at 12:14:19PM -0800, Dickson Wu wrote:
> Hi Greg and Sasha,
> 
> Could you please queue these upstream commits for the trees below? They're
> security fixes, plus two prerequisites, that newer branches already have.
> Each applies cleanly to the current branch tip.
> 
> 6.1.y:
> - 7a6d793e9ca8 ("Bluetooth: hci_h5: Add ability to allocate memory for
> private data")
> - de4e88ec58c4 ("Bluetooth: btrtl: fix out of bounds memory access")
>   CVE-2024-26890. The first is the prerequisite: on 6.1 the H5 device is
>   registered with no private area, and btrtl_initialize() writes struct
>   btrealtek_data through that private pointer. 6.6.y took the same pair.
> - 0460253913e5 ("NFSv4: nfs4_do_open() is incorrectly triggering state
> recovery")
>   6.1.y already has 7813adb38c88 ("nfs: use nfsi->rwsem to protect
>   traversal of the file lock list"), and the upstream message of that fix
>   says it relies on this commit draining the session slots before reclaim.
> - 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
>   CVE-2026-98570.
> 
> 6.6.y:
> - c88c150a467f ("nfsd: fix possible badness in FREE_STATEID")
>   CVE-2024-50043.
> - e8d97c270cb4 ("media: verisilicon: Fix kernel panic due to
> __initconst misuse")
>   CVE-2026-31573.
> - 167e54c703cc ("rds: tcp: unregister sysctl before tearing down listen socket")
>   CVE-2026-68290.
> - 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
>   CVE-2026-98570.
> 
> 6.12.y:
> - 87cd6b717e40 ("net: ipv6: keep room for the mac header in dst_dev_overhead()")
>   CVE-2026-98570.
> 
> 87cd6b717e40 is already in queue-6.18. 5.15.y and 5.10.y also have the
> rpl_iptunnel commit it fixes and it applies there, but I only tested 6.1,
> 6.6 and 6.12.
> 
> Testing, on v6.1.193, v6.6.163 and v6.12.119: cherry-picked onto the
> branch tip, W=1 build of the touched objects before and after with no new
> warnings, and x86_64 defconfig with the relevant options enabled, built and
> booted under QEMU/KVM. I didn't run targeted runtime tests for these paths.
> 
> The list and the test runs were prepared with AI coding tools (OpenAI Codex
> agents, with review by Claude).
> 
> Best,
> Dickson
> 

Please provide tested and signed-off-by patches for these.

thanks,

greg k-h
