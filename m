Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452914;
	b=2QUUMj+WcgCbqMjIdLsZ+CD6P8IRJOoNZqplp72++0bUN8Tsdo1QSxt3qr5OGWD22tG5
	 g7ZkRYQntncHsnHIR2+5m7hhzkNzSuEilCPEMXoYISDhTMfQGMC2aWLwjZLzQEGp4kkmq
	 uTNivzI0vMkwHvzXyJs/b/CQlBdbMgRDoy5WkdsjagxndV7xU+YTdiwRjviclHWlk8/Iy
	 861ifAIe03NxiqiCiQrZs8O9+tjTgWY68sCXnqy5X9S/qeQxTmz5AsEVhn3zTxjVwt7O4
	 sHdTlrIYmQD/aXy+fO6epbgYPS/ioZ+6tbEtVgUYrVfLFGjldmAjerIINUa7e5PsGlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452914;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=R0YaxkJAta/mVlVE1XP9/S1/mFJSUrN6mUoMtBEqewI=;
	b=n17EUAFvRkg2eFZqM8egeHjpUSEvRi+EAzQ6MdomOZiJkAm+jbGrb860SANma6y1pLSZ
	 Bc1AuCMjp8cup87c4QknhXtPxWeSlngNVTkgVcMD3M722/7zCxX35nCBkTD08R78iV+RQ
	 eNs9/zNf92azWIg525sbgmPQgvRZLs5lc4oFtP7W8YE7mcBwZhY//qIudb/CRWFPHUwoJ
	 6NmCStteZHDlNiOctiDJKQXU38q85M+Zl9UkCHX2qLpNMgVNvft56zxXrQdjnJmZOMCVb
	 yA4ndAW1ulV7FcavIxQu2X8mmbafFrtirKPvT/LrkSY7RDePLb1rjy/onzhsGXj6F8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qen1ezhm;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD61606A31A;
	Mon, 23 Nov 2026 16:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qen1ezhm
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id EECE320B7167; Mon, 23 Nov 2026 08:55:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EECE320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795452909;
	bh=R0YaxkJAta/mVlVE1XP9/S1/mFJSUrN6mUoMtBEqewI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qen1ezhmMTbNcdPmeI9v32zYARX+1yjzwcy7MgPKuwwCzwLdQrJ3zy1q95LBgseB7
	 tSXQlWXLmYWwYw5IZZd792vwUzgJ1JKgV5P/aA9QP4X65LGOKWY7PqlyUZUX2gzfhG
	 I+xO8ElKYevVL4deVSkOqSOB+sx+l5YfxzxTZgG0=
Date: Mon, 23 Nov 2026 11:55:09 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: dri-devel@lists.freedesktop.org, Dexuan Cui <decui@microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/hyperv: wait for flip_done instead of vblanks in
 commit tail
Message-ID: <awRv7c1yVG3QWxp+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261112184553.1595055-1-hamzamahfooz@linux.microsoft.com>
 <avyT6Zop6s5G5qwu@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
In-Reply-To: <avyT6Zop6s5G5qwu@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Nov 17, 2026 at 09:50:33AM -0800, Saurabh Singh Sengar wrote:
> Thanks for the patch. Below are my thoughts:
> 
> Since flip_done is normally signalled through the same vblank timer,
> this change does not remove the dependency on that timer. However,
> drm_atomic_helper_wait_for_vblanks() has a 1-second timeout, whereas
> drm_atomic_helper_wait_for_flip_done() waits up to 10 seconds.
> Could you clarify whether the change resolves the reported case because
> of the longer timeout, or because it avoids waiting for another vblank
> after the commit's event has already completed ?
> 

It does come down to the longer timeout, I've done some stress testing
and the timeout doesn't seem to exceed 2-3 seconds (on Azure and
even on the lowest end SKUs).

> This seems relevant to other timer-backed virtual DRM drivers as well.
> The older wait_for_vblanks helper also predates flip_done tracking and
> has previously been described as an interim solution [1].
> 
> We already have a vblank timeout increase [2], and Thomas's timer
> reliability series [3] also discusses delayed vblank handling triggering
> DRM checks, although it is not clear whether those changes address this
> particular case.
> 

From my testing they don't address the issue.

> Using flip_done is consistent with VKMS and seems reasonable. However,
> rather than duplicating the default commit tail in each affected driver,
> could we consider a common DRM solution for all ?
> 

Most drivers implicitally rely on drm_atomic_helper_wait_for_vblanks()
through drm_atomic_helper_commit_tail(), so I don't think we should
touch that unless we can prove it doesn't regress anyone. Though it
is worth nothing that fbdev has a similiar timeout that is fixed by [1].

> It would help to identify the precise condition causing the hyperv_drm
> warning and explain why the existing generic timeout increase is
> insufficient. If this is needed as a targeted stable fix, please document
> this in the commit message and as a comment in code.
> 

The vblank timer is an hrtimer, so it can't fire while its vCPU isn't
running, whereas the committing task can keep running on another vCPU
and time out. On Azure, a 10 ms timer sampling the vCPU run time that
Hyper-V reports caught the host not running a vCPU for up to 128 ms,
mostly inside storvsc's vmbus_set_event() hypercall. As the warnings
coincide with boot-time disk I/O, the host appears to hold a vCPU like
that for seconds at times. Also, it doesn't really need to go into
stable if we don't enable panic_on_warn() (and assuming no one is
complaining about the timeout in stable releases).

[1] https://lore.kernel.org/dri-devel/20261104024106.3109873-1-Prike.Liang@amd.com/

Hamza

> [1] https://patchwork.freedesktop.org/patch/318967/
> [2] https://git.kernel.org/linus/79ae8510b5b81b9500370f89c619b50ca9c0990f
> [3] https://lore.kernel.org/dri-devel/20260601141922.91498-1-tzimmermann@suse.de/
> 
> - Saurabh


