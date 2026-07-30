Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A837A841
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379242; cv=none; b=cUeTQBXmZeShX/V6B0/S3X0G6KeHejTbflYImn45SS8XtOxiYAsX3x3sKDRtkrfv9h1GRK71eCWpRxAiv7mwBjPDo/uqE7F/yiLaBAR/zhSoW03yQH3LMPz3LZUuyGxchEMVr58rMaImEly4Urpd0nN9oLNqq6kbsK9/jY2fHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379242; c=relaxed/simple;
	bh=ehlwOSYldoDAP5D+ik/8s8CNfkRdymCrYqsX1j2verQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5yyBO8NaN9CF2YQJlG13xy0amnhueWeRRBEKgN5BH0723BO4u4zx+y8wVlU2gRXFFQ7yKiU35/gPl0kEqbYSPpr/mgNM1yPgD0fpkQibr1fpLqpqdYwyFapkba2hIpW3+0yOw2k14v8tJ02xDwtbGM3gCQDCsWe1MTq5pWaA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyTd5g5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyTd5g5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98011F00A3E;
	Thu, 30 Jul 2026 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379241;
	bh=kzshhQShEALfUgm8OY0PEu/4IHG++/qw5QpmzIBc4ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyTd5g5Oa+bQXq/o2jQ0KJXZZDrFWK/jtpuqbHIM0K/4+tTX4bvxfuE9vMOoZ2f/H
	 i72xGjDCbtcblzNY0PZb3kE+e1S/KNtuP1SanM1KDI0OMFbH0qouWvSsv3FoOFfzlg
	 Gz6YpaxtK/oJcsZm85oUKbriuAuPeJNNZwq3oSSxCryVZnHP9yBOhmNCs2jZWT3+Ys
	 p1RT9EAA3KjIUoOHUvMKHUlNHuNCPOjKXp/vld0bFHFL6hHvun9Vw1ZY9Z2O6BKgtg
	 mahvc2KdQXR2hbNdMnZJSq6xW4Dt53jyoeewQqoqdr7P+O36/fJmwVu7Fo4VKDCbUw
	 DDO0l5Sr6Wgvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Leo Li <sunpeng.li@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before sending event
Date: Wed, 29 Jul 2026 22:40:06 -0400
Message-ID: <20260729223316.stable-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729173742.950965-2-sunpeng.li@amd.com>
References: <20260729173742.950965-2-sunpeng.li@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before sending event

Thanks for the backports, but I'm going to hold both of these for now.

There are two unmerged Fixes: patches against 48ab86360af1 ("drm/amd/display:
check GRPH_FLIP status before sending event") on the list, and I can
reproduce a flip_done/login freeze on DCN 3.1.5 with 7.2-rc4, plus there is
your own Cc: stable follow-up on top.

Could you confirm which set you want stable to carry before I queue any of
it?  Once the follow-ups land in mainline I'm happy to take the whole thing
together for 7.1 and 6.18.

-- 
Thanks,
Sasha
