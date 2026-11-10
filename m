Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290302;
	b=HZA0/qjevCtm3d5RHXmbblE1iw6ER5PGnk45N9Ni7IpDrNMBiivWc98aRKc8b0iUsB9K
	 t0rmVRKwR1Ojsr/oDMhC5dq+qg1o9WJkEpl8rqRRvl6ZKYdlvHMC1QCVFuirMp0h4WiTe
	 z9oqAIwkR48i9TMRVRw3IRgncalahu3B9ndbHalHPat4JZlIS8/ZDtqwRhR6sYlQnmcqU
	 /d0orwJ4BvLTHBu82SNlGxp2KMVXIYkRKb16aUdP+VJyVmW4ZX5zcjLr/XDCsBwiotOMj
	 PemFtscOSSBIaqaESsnQrxTTI8Gq/F2rWVCD6+FiiPgdIwMaMa2SXmGMktR5Xz1+amQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z7iAk94rtQT4en12Oo5gzA5SIJCnJY/wdVZuGhW9uGk=;
	b=0xS6Vj+5sk+UQ4kyvwUdK3dQtAKE3lPzPTQHhoLSFhFd+RjFK1cJPTxHXS/g1zjaTnas
	 CtxCM7Ren+K7RjjkSfbvNWY1tUuRMVW3Cbwod4jJreO+HKdz2+nPTBkFqCb556FGb8aPO
	 NeO/53Wm6KLqFgg3AJBCt/h3O4oQLM4tMWBNQuVfAzzzKYkqp1jfft05EjzywHC3ClaKb
	 l96H6FXNvT6FVZjbxaH8slylYcATDRd5SlJKRcdy1fZIYQpWVwoJjjTbpPVHi5zI0Yo4g
	 ioBfZaU4YHI1JoXJDO163ZN3pg/+XJTcGOawMYtLYHd7bSC8CknSgxh0tdtiK6AvWoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqEYcoVo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90965606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DqEYcoVo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32951F0089F;
	Tue, 10 Nov 2026 05:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290302;
	bh=Z7iAk94rtQT4en12Oo5gzA5SIJCnJY/wdVZuGhW9uGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DqEYcoVoJ4NVzkUI12zFP/8ltyHR34sOhLNoZ+6EbcrhvFpnUVs7LbEo1Nnt97tc2
	 JXmZOgO/GYesMTExVSk7Ej/JXo9wlaa4IKi2kAuHvBMNfCtyBPbw5DvFenTbm5fFvD
	 DbBBci/lpJv/5T7fX0Mo9s6mZegLhlU9363QdTmxwLg7izEF6ggDS1ewpuyK7TE5q7
	 LcdBuSgjv2TIWygxiGltY0aK3FhC67j2sZ9R5JLlfbXtin+G5n4GQtJTkXXiT+Wz1W
	 gf+Wy9T6ElZRqQEWe2yrivKtTk1dw67Dr9k/e3Phtk6wJEwuOYWCa0wAxXmVs4m4Hk
	 +7i9v23CCS8Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/panic: Do not use un-escaped URL as format string
Date: Tue, 10 Nov 2026 00:58:20 -0500
Message-ID: <20261110055810.483002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051705-failed-6.12-6596aae25585@kernel.org>
References: <20261107051705-failed-6.12-6596aae25585@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 6596aae25585b183ebd528206bde6f12efaf8db1 ]

Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
with a %s conversion specifier. Avoids a possible vulnerabilty from
a crafted URL string.

As the attacker needs to control the kernel at the Kconfig level, the
potential for an exploit is likely low.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.12+
Link: https://patch.msgid.link/20260911124540.279841-2-tzimmermann@suse.de
[ sashal: Retained the zl= URL parameter instead of z= to match the older QR encoding. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 06f0aa1cb4f74..f4662f88e2173 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -507,7 +507,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 	char *kmsg;
 	int max_qr_data_size, url_len;
 
-	url_len = snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL "?a=%s&v=%s&zl=",
+	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&zl=",
+			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
 			   utsname()->machine, utsname()->release);
 
 	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
-- 
2.53.0

