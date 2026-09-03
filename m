Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671B4B2CB5;
	Thu,  3 Sep 2026 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444764; cv=none; b=e2phhPctW5hOSQ53KCM6mX3GX7DgcmJ9LzcErBRrv9bSdZxwEIZqFjqK1EgzHxpyuictYW+1s0lyNojewbVEUoumKWGEF+ddxgV+A5B1nYDo2TNSJLqgIrmlLy9D/190K3weANybxl54aNjbDl7/QfI2DCdygFchzmTyN3Ul8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444764; c=relaxed/simple;
	bh=2QVB//AclfNeAbju+0IYoO6raZ3d7xQbfRbudoLgbH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmQ3d1yNqt/Q11d4GzH7U1kJut947Ecmqqcy0PvPk0VpPq3Bl/dlRSG/y2VB9avbQIIsYP8DSeHo7kfgWK9ruGvSjfsC18R8yys88Fo9xReO5lAJLEX18IzLm3vULSGk4S/rNBxAYBnwSgwsrZVrzCBXAmUwzdo/y/5stmAe9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GjRQ17cT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GjRQ17cT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=HDphPTZasBW/m6rqPKWNWdlcoSOfg9Wv3BLKy1YJmFk=; b=GjRQ17cTZGJyO9RseyyaQA+rJ2
	KFNRg9yVF0nvIwkEzkEfH5NFEWW8acQDmuKl1f6q6vQ7hOzImiIke6iL7hFX1C+f6tBGJf+Ol2V+d
	VuOnEMMB3JdoROXdxAxA/ilFfkTGkMt8LL6JoSRAgFSTaGoLP9VoY6dqRK2TiMGA4r07hJDy8Mvll
	cmXc0yGIA/VDpi2tfF4vsdgfV8buO5SyDx3nPWjAxOJ9Laa3Hc30GvLHcbbVE2PXOKlVadljZYaIr
	whRPifETlbniKBgzN9KMCSWvw6CT6YutHQB62x/U6kYBr/SDQuhUBOZ4Jgb59PjyzScnJ1Ql0JJlj
	77ooFAow==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yudi Yang <2000jedi@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: analogix_dp: bound endpoint name formatting
Date: Thu,  3 Sep 2026 16:12:03 +0200
Message-ID: <178844472024.2481528.12971315442057669333.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901195511.2761251-1-2000jedi@gmail.com>
References: <20260901195511.2761251-1-2000jedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 01 Sep 2026 14:55:11 -0500, Yudi Yang wrote:
> rockchip_dp_drm_encoder_enable() uses sprintf() to format a device tree
> path into a 32-byte stack buffer. Device tree paths are not limited to
> this size, so a sufficiently long path can overflow the buffer.
> 
> Use snprintf() with the destination size to truncate the generated name
> and keep the writes within bounds.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: analogix_dp: bound endpoint name formatting
      commit: bc69439d983cc491cc86e01fafc1deb94e1bb85e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
