Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6525616DC;
	Tue, 29 Sep 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707879; cv=none; b=AxSp5g3e2C7UaRzkiQ8PdRcLP0W3toabFljoS78FoKx09eY47oc3sfLtH/szJuL6TQsTR7/8CehResiwic5H3Exoz64YS//9FZtccxlNXLMGxel8XwbmIYY5c0JAKNEcBNm8A+/tdFTsKVpP34aJkQq6vWz1bCy21YC29nc9TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707879; c=relaxed/simple;
	bh=Apzs22em9kuJVQ/2eBmRmLYcGYetY5y2FmGpA9VVLNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9sqE2KZeH4XWn+SwU5YX8DNU/Lii8rNeJWoJ6XRCrdUNadpLJk5IRrr9MU0TTuvSp12yQg9GrROCZbBOJb6q7UU4nMLYsZe44gW55GIHlXnsaIdtaoODIU5YVhQYgOsDmvvpE7y+YECHVeEZ9aM2ivh8J31xyJ2RoBRH6h0asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFngQLgg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFngQLgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E82C1F0089B;
	Tue, 29 Sep 2026 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707876;
	bh=kaRa43CELU4o2hL/fYKd1KiJSlVv0GcSE3JqRJkpNgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fFngQLggkCT7MHNkNQbVe5irXs0KqAdjCdnawZ1d5UAYxmy0iEisVnTjDlCzn6Bnv
	 VK7EyIubW9JlAHNP4vMAaS477xBUn61WNTl6rtchbPUSzOx0OslaBXDFiEsP+gRK+W
	 HVmSzYgv/BKHugdSEhL3fOvk81GuDTDmg99h5gIS5pyXgKCd/gb1V8Umr8YQJt5xKw
	 HWZRVqZukixX8TxBcjSWiYzF5fZmrESJYIdrWVwB00b1nQIMiMTCQrfxwK7AI0ylC7
	 wPTGELqAf6OUP6sqoxpUHatRe3i5GhT/foINUJKxOsM1rmd3i4Ol5LSTwUaTK+k7Fb
	 eRnlOp0c4g9qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Ensure array index tg_inst won't be -1
Date: Tue, 29 Sep 2026 14:50:52 -0400
Message-ID: <2026-09-29-daily-reply-0009-re-amd-tg-inst-index-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031209.87164-1-artem@trailofbits.com>
References: <20260929031209.87164-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-46730. It adds upstream's zero-count guard
> before the fallback timing-generator index is computed.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
