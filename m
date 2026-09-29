Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38503560ABF;
	Tue, 29 Sep 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707886; cv=none; b=dBML6C43L0txa8+W13kTaK1VIY+sme90aHj/9+r5F23m6QxpJb5/GW7SPEzY9/DBfvfxrMSIbWTt5tM8c5B/8JdVW4521dP5ewMNgk5hn7swZvTNc+mmqpwShkYNyl1HGyeiFVaSz73U2a4bA0fskZVCVEfPn+NIE8ohK5w0jYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707886; c=relaxed/simple;
	bh=KfOONODzubOp30pOy4G53qHOs4mmHK4Sq86eVxoTouA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7zpgy8o/K0PmguUCL2a+dFnv2AO8Uz6cts+4YnhGGiWcoIGwZoVQBtcRRWDRderjzQilqVICgXK0Kw70EMf0i9BbV2653/cg9KX2ETJO//VSz4LkAv9T1ivrKU3izOp1Lp/f7u53XFhobPyV6LOrvwLHGfYLO47Q0bakw6dlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuHvziog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuHvziog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F361F00893;
	Tue, 29 Sep 2026 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707884;
	bh=msHud40OIqSpq3f9V3YZxbeDa6wD/0SM5+Ku3Otx2Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UuHvziogyqqoB6sgRjWKmHRCY1ChY4ksOWiyPrINoQti0aErTuaUxVVS3UTwG1F2P
	 RVzDVUSyxibpT07QGGrXXtss4Silcc1mp9BMPDYiDXaEcp2K92/wrFl0TE5eF9jiln
	 Zz+7iFjzrlQtM4OAP9fP5StTCM+vGYju23G8UmKv3Cs7cNjX96iORCi7ssIvsJe6NZ
	 x54zK6+65yz3zz5rbtn5w7iBcAXeAsJgG0VEE2F0MrvgOe8IXDZHdE6XJx0fWr9ryz
	 cxKz6QPitnCK4eghbtB+3bzQAPxnnSvFbsBfqh8pUJZhHB3KsI5d3JN14sef3lgzPd
	 r0B/JSwpcBshg==
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
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Simona Vetter <simona@ffwll.ch>,
	jason-jh.lin@mediatek.com
Subject: Re: [PATCH 6.6.y] drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
Date: Tue, 29 Sep 2026 14:50:56 -0400
Message-ID: <2026-09-29-daily-reply-0013-re-mediatek-crtc-destroy-null-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031902.88182-1-artem@trailofbits.com>
References: <20260929031902.88182-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-53056. It skips command-packet destruction when
> channel setup failed before packet creation.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
