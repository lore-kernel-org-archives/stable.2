Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12C43F08C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406284; cv=none; b=Q7bLzhlTsR2796jo32TaE3cmhjEjzKjCP+g6sXPDYqheh3GoQcUWisyxXVE1EluENS8RIkj807qNEZ+/FP+JdRcKIedH2gslAtOaqkY9xpGxr0fpn+YfsBGm/YQyYGAVhPJS/5/em80zPe7TpBD0jP2t1tez3ZJI+13U4YRrqm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406284; c=relaxed/simple;
	bh=Q5pXdEF7OCon4a/uNW+NoddQahCqEMMp0u2sn7pjE/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTz0EDhZTu7VpgKFP3VlcvB1/expedEKsQoiKwQJLjSMg1DqZAwmCSr4hLOAWCrUoDfF2c3fod5XDit1VygYP1U6ZABBI+6PFwMFuyaxXSjqs0YvR7khrrca2LDM/eHzuh66Yq4MF6EzYCz0EWNFnnFZFW5qi787oGL//2FK+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl9NSII2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl9NSII2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022CB1F00A3A;
	Mon, 10 Aug 2026 23:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406283;
	bh=VuP/NcEklXdZRLxY2cKCgFw4P6GnpUU5/mg+KBr1EYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wl9NSII28uwDN+wVbqExImH903LbksWuCZ8Y+sGpFuF07z8yHznCXcZ2q/DotTPgU
	 0fEwlPj6kFa2ZnPN5b34o5yBcrgaMROKildY4uZyl4qZFJJM6cy0uo+MjkMTzZeG9x
	 XDDHhRURKPqra2QHygjXKYmvtD+pGq5XjJC7tGOqLHsitLFMbEg7XZe6stqM8rmcUK
	 VTseb8U1dLktElq27ki96G7yaQvb6MmI5B40KkoW3gT1NURuN/66CXQNHPM/G07URl
	 B2+SqRyjdUFM0tBCwuT628YA2vdKCmB43Hay+2LR/S0vZ/EUx5GWG1zN3pVPDhgY2V
	 fkQlulUBf3VGg==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Wayne Lin <wayne.lin@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Fangzhi Zuo <jerry.zuo@amd.com>,
	daniel.wheeler@amd.com,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Viktor=20J=C3=A4gersk=C3=BCpper?= <viktor_jaegerskuepper@freenet.de>
Subject: Re: Drop "drm/amd/display: Add AV mute wait frames to dce110_set_avmute" from stable queues
Date: Mon, 10 Aug 2026 19:57:45 -0400
Message-ID: <20260810234738.0007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <608ed117-5fa2-43df-b10e-738cf3b5c2d2@freenet.de>
References: <608ed117-5fa2-43df-b10e-738cf3b5c2d2@freenet.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The fix for the regression has landed in the mainline tree, so you can
> now backport
>
> 443290d70b01e9c35830c300e3247c06581b594c
> drm/amd/display: Add AV mute wait frames to dce110_set_avmute
>
> and
>
> 3141e3d61469bba2624a91c5e2407f110b33b29e
> drm/amd/display: Check for tg ops in dce110_set_avmute
>
> to the stable kernels (7.1, 6.18 and 6.12), both have 'Cc: stable'.

Queued both, in that order, for 7.1, 6.18 and 6.12, thanks.

> Note
> that the 'Fixes' tag in the second commit refers to a commit on the
> drm-next branch and not the corresponding commit from the drm-fixes
> branch, which might be confusing.

Right - that Fixes: SHA isn't in mainline at all, which is why the tooling
never paired the fix with its parent. The mainline commit is 443290d70b01
("drm/amd/display: Add AV mute wait frames to dce110_set_avmute").

-- 
Thanks,
Sasha
