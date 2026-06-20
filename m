Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253532F757;
	Sat, 20 Jun 2026 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781987997; cv=none; b=Vh0kducMIDVpp/eMQtkK6AtRCcIJIrrInRyDR9pVrFnPzP/ZopuS7Fyqa7gCcuVvvr1GycTh7RErWBnueIPE75n7aEzBmIVx0diea2Hhsq8mpcWq5cOTb0F2caIhSJnKcKs9xxg/PLsMkzIvxDOCIRCpCdRFp5DSN1ERuGKvQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781987997; c=relaxed/simple;
	bh=3Mu8wIpxk2ALCw3XaQN88/cuJnvvprfh9Crx1UpdKnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW5zvu4/H+lRzdl44U2E4WKLDJ8a5/Tb0doX3t2ewBRkTn3xhO/WYFLDcK97AnES4O0rTABVvhHfKNYMB0pGfwZjdZH6NDWKvh2joQAVXCMNwTRv2V8qA/8TPljWU2qkAucYQZK/Y1x7Th6rUomjs+eyEFvjvMqSkKwMhssVO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=k1I+BHs9; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="k1I+BHs9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7bD9mS5Zz5cqo1Y1ilNCwVtC8Kdtavh0qtaQ1yBkjo8=; b=k1I+BHs9IktNNHbqp/ZmOIeilf
	3tZcWG9aQPoIk4nkgS9Suxc5RqewRdUhS6oV5wHSuWytUCtCfCp79yR9N/3tq7Pvj2KWv/8jbJI6O
	uQgNFEYbqa9U+zW6CK5pVNdU4/9dtGfySKQaXTZdEIM/5T05wTYDX2ZbZmsehtq+p9OcQToSdgFDM
	uXnVKEzGszW1smE2Q1XkWx3wR8eoKrazOt20MwzWSKkEdtmaiF8PcOQhavsZC60LWGhMi84HfYi4/
	3I6j2iZmFaw66Xnnc8OB/3c5H1oGQwCVH76LcZmjVncCvvWoFBT/wXuAwGIaeEPZBHAMdeOjWRyZh
	rXdZ3Dyg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1wb22I-00HB6i-0f;
	Sat, 20 Jun 2026 20:11:26 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 4BA10BE2EE7; Sat, 20 Jun 2026 22:11:25 +0200 (CEST)
Date: Sat, 20 Jun 2026 22:11:25 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jaak Ristioja <jaak@ristioja.ee>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dianne Skoll <dianne@skoll.ca>, Chris Park <chris.park@amd.com>,
	Matthew Stewart <matthew.stewart2@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: 1139950@bugs.debian.org, egressions@lists.linux.dev,
	stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [regression] amdgpu carrizo: no display signal after modeset
Message-ID: <178198613176.3658222.16247101620976737948@eldamar.lan>
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
X-Debian-User: carnil

Control: forwarded -1 https://lore.kernel.org/regressions/178198613176.3658222.16247101620976737948@eldamar.lan

Hi

Jaak Ristioja reported the following issue in Debian at
https://bugs.debian.org/1139950 . Part of the original report contains
Debian specific version information, but Jaak did as well a bisecion
for the regression see below:

On Sun, Jun 14, 2026 at 02:27:01AM +0300, Jaak Ristioja wrote:
> Package: linux-modules-7.0.10+deb13-amd64
> Version: 7.0.10-1~bpo13+1
> 
> Hi,
> 
> Upgrading (after a long while) Debian Trixie installations on two different
> HP EliteDesk 705 G4 DM 35W computers with AMD PRO A10-9700E R7 (carrizo)
> resulted in both machines blanking the screen right after kernel modesetting
> activates via amdgpu, with the monitor reporting "no signal". There are no
> other symptoms besides losing the display as the system continues to run and
> is accessible using keyboard and network.
> 
> Bug first discovered with stable kernel linux-image-6.12.90+deb13.1-amd64
> (6.12.90-2) and the one from trixie-backports. The device is connected to a
> monitor using a DisplayPort to HDMI adapter. The bug occurs regardless of
> which if the two available physical DisplayPort ports to use.
> 
> I don't remember this being an issue some months ago, so I tried to
> reproduce this booting the Debian 13.1.0 and 13.4.0 install DVD images and
> using the kernel modules/firmware therein:
> 
>   13.1.0 installer:
>     firmware-amd-graphics_20250410-2
>     linux-image-6.12.43+deb13-amd64_6.12.43-1
>   13.4.0 installer:
>     firmware-amd-graphics 20250410-2
>     linux-image-6.12.73+deb13-amd64_6.12.73-1
> 
> I essentially unpacked the two *.deb files manually, depmod -a; modprobe drm
> debug=0x1ff; modprobe amdgpu.
> 
> I observed the bug reproduce using the 13.4.0 installer, but not on the
> 13.1.0 installer, meaning this is a regression somewhere between kernel
> versions 6.12.43-1 and 6.12.73-1.

The reporter did a bisection and found as offending commit:

    drm/amd/display: Bump the HDMI clock to 340MHz

    commit fee50077656d8a58011f13bca48f743d1b6d6015 upstream.

    [Why]
    DP-HDMI dongles can execeed bandwidth requirements on high resolution
    monitors. This can lead to pruning the high resolution modes.

    HDMI 1.3 bumped the clock to 340MHz, but display code never matched it.

    [How]
    Set default to (DVI) 165MHz.  Once HDMI display is identified update
    to 340MHz.

    Reported-by: Dianne Skoll <dianne@skoll.ca>
    Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4780
    Reviewed-by: Chris Park <chris.park@amd.com>
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
    Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    (cherry picked from commit ac1e65d8ade46c09fb184579b81acadf36dcb91e)
    Cc: stable@vger.kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Does this ring any bell?

#regzbot introduced: ae5b1d291c814a2884c3d54a56e83bc99052b1eb
#regzbot link: https://bugs.debian.org/1139950

Regards,
Salvatore
