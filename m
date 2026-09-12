Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50C3328FC
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228554; cv=none; b=St0i1GhIEJ15noGGRNl4hpwDU3D/iFnNdvVwipgsPISV0LuoRQjbz/jFCkwi/E1Zy8/xMmIjGrD2QvxaFqvEUFrU0jG2XjX7ifzivROU+ptcVdcSM8i2/z+MiWrkSMoaZfcWU/wMqfVJCLhc4VB6CGtZkyzb7QyxH48prTgXzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228554; c=relaxed/simple;
	bh=eO9zRV0hdudEPTVey3EQoS66SC9Hn2d5OchSIbQ4KHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOuu1tZiD6HQCFtS6hNXzHS9XLIi0FmKU0XSqoktldi/LqGLiikGwnl21nwDpEySfaI+e1ff4LFb4mPazlZArSBQBqWVGDrKfa6MV5zaUGsMxR0p7mosVZOA3WSdE1y+azMrIT8olUHGeCbIwtzvN0cD81zsklLtUFhijsTy1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3IilgE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3IilgE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB431F00893;
	Sat, 12 Sep 2026 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789228553;
	bh=fht7c6ZfmCugWyMqJQfeB6xwTrNalXdRtGWzbThUAWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F3IilgE4aOiA3G7zBw1IoqIE9Iy7U1VmCOh+4tb4NajUBg6dEK+J5PEoZo2T+/5Ym
	 9whMxiV4kU+YY5qZbFIRHNofaJpQzcSRWxgQN+3agecHK3BAtLpZDd2LVTjmZgVkg/
	 e3dvAge3E3aAVOGMZk2F51ZrS34EzlHXWne0zl9zyy5g/nzlzw0CPP+I6JPTtACBKt
	 rRKV3T8o81j3CYSKJ/8tUVzaNgoD4p6WWUUeKV+VkWFViGzCuuyS34SY83I5S0y82j
	 yDaF+6BNfDj4Gnc/gAXsRV/MMghwxmRXTzuK7ogIxrhmbc1juq36FZNoonvCavVtIj
	 bIPvgEGOWEUxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Sat, 12 Sep 2026 11:55:50 -0400
Message-ID: <20260912155550.3568526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090920-slot-cushy-44a8@gregkh>
References: <2026090920-slot-cushy-44a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 03f1a3545b721fa7fdadd00080e237519a286a97 ]

Validate the framebuffer size from the firmware against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail probing on errors.

v2:
- remove unused function simplefb_get_validated_int0() (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Link: https://patch.msgid.link/20260625094509.157581-2-tzimmermann@suse.de
[ adapted shared drm_sysfb validation changes to the existing local simplefb_get_validated_int0() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index f3c2c173ca4b5..7091af5a18109 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -58,7 +58,7 @@ static int
 simplefb_get_validated_int0(struct drm_device *dev, const char *name,
 			    uint32_t value)
 {
-	if (!value) {
+	if (!value || value > U16_MAX) {
 		drm_err(dev, "simplefb: invalid framebuffer %s of %u\n",
 			name, value);
 		return -EINVAL;
-- 
2.53.0

