Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D37560AAF;
	Tue, 29 Sep 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707881; cv=none; b=VbWABPfwa56rCLkypXDQIIWL9K6W+vDcUgBZmeUhDDmG3tdiOKzkxkDM0evbUlMrW1X+p3w3xW6bch/ZnUu+jd40oglUo43Z1YFVZpEqBpYvsTlmNI6AvbV89ubI5X82kic9iKpiz6BhT8oWheLpSz/meMAJZTVh9bQdQdZdSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707881; c=relaxed/simple;
	bh=FZ+lfPV783xmoIbcdbr/oDhfEPSm+mr3k4LrHIadZsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH/YBMksm8Y9uWGDtCRwRkL7KItJ92aAHgzRyCvToVuEU+4yTF85jm1APCzVJfARbLmz1O8CPyJXq6SPEgSNkfSFZ/FLxYfcvz0H9JdfswqhsAQe5wdpVxUOi+KThFou3BMDVSktGxWEe82Ri6LM0hHksn/U3lQDO+mGA80CnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwFqeb9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwFqeb9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3736C1F00893;
	Tue, 29 Sep 2026 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707878;
	bh=ZHSjjqpMm/URqtCDk0E7y52wfoKHRmMNE12oAP2zlD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OwFqeb9ha1kXhRCadNcpLhhWEmbOWfUEJab4R6DEcahzzX9butBH7M9Hf1XiNshNM
	 m2pzL3Hn6Re9j+u5z2PvCWo6wxUZLgR2Sh6Gnu8m0akINhWSV5ZG20bRCl0WcIhjtO
	 6i0EPcTYtwinotBrOqekw45bo2pxJT00zBdyRDVpMCEEnEhggKyMrMipRpQSm4pLsv
	 ZNd07ArA67xV937ar5nuVz3sb4U75sCj3Enbyawk25Euf13CuBI8zZ3IKO58+X6i3A
	 NP4GhhhQFhr/NcFTo3/dRd1A+BSrdSNrNwccKY/G2zBDrFSgqGEkJ15V4eIAA7RxB2
	 3f0GOQCf0d/0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Check null pointers before using them
Date: Tue, 29 Sep 2026 14:50:53 -0400
Message-ID: <2026-09-29-daily-reply-0010-re-amd-check-null-pointers-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031415.87382-1-artem@trailofbits.com>
References: <20260929031415.87382-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-49922. It prevents the applicable HDCP path
> from dereferencing a NULL dc_link.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
