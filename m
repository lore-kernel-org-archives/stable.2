Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384C13AF2;
	Sat,  3 Oct 2026 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067130; cv=none; b=pEkdSvBd2d1F4lFXhTyJVoWuk/fEjcQcHdLTJeRj8t58MwD5AcuGAQnzogBg7jJys4E9h/mC6V8HZMhqUb6G0gbr5q5PBUpX2p62CyPYZB3hmQJyDlrEFmKsPbOGNZ7U5NaL/NavEa4Pg0VQqWxN3zOaEfkbGagQWI8OxNFWMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067130; c=relaxed/simple;
	bh=MNZLe7lb7SL0qxi6TBFXRExtHot9BB/ihNfeI8+w9uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOkUybAiBASbhUEX56FiV3CII0mNHyXcTJ8RfAje69llsq6jXFv/CShJEjZW54uBROKus8gwHEnnB82Wc9m8VPwgmfB9JzA1SnoAoqN1p3PAME4f8GK/X6r3Fwr0y3LH2vmEu2lwwNFbg4TM7++gOuAM2nkzu8d5jq/AnVJtWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8gsQoBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8gsQoBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898EF1F0089C;
	Sat,  3 Oct 2026 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067129;
	bh=xO5R81dRFmvXP+oBvrJJLiArFPxToNNZBXws0YgONPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8gsQoBhJC5EYlxZ27z608xFzxwPohUilz2EuP2ADNGIfR8h3+S2DcTuy5XPEmdOT
	 7RHHGx+t9S4U6X6No7yx2d/jgaeVJ36MhyypFTYXDgK0D+lHqLzwyvPGPa6hg8uFmd
	 YwCWjdIZY0Ip+gSgouzHbEMQ4SMeRpCyZuZ9s4ofNBUYPeGodVKFvmHWDSDbHC2xm1
	 VFBwuM8JECPeh324dFaO9qLdx+2hjEJLonsWjTrGQR/EI3QrhLKhcCM6SMkLme+N/d
	 uFbZ/W99f+oU/Z9ixdyc0LHchzEeZomG5lQ2Jqd6JSbrmj2s9nbeXMxE2xP6Q3H8Dm
	 +BhzzRg5YecvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	jason-jh.lin@mediatek.com
Subject: Re: [PATCH 6.1.y] drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
Date: Sat,  3 Oct 2026 18:33:03 -0400
Message-ID: <2026-10-03-1-daily-reply-0022-re-mediatek-crtc-destroy-null-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194413.20810-1-artem@trailofbits.com>
References: <20261002194413.20810-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 4018651ba5c409034149f297d3dd3328b91561fd ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
