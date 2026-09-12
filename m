Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17F33D505
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227224; cv=none; b=TkZGym/nLIWc8dyXSEVTnCjiEZPfn7we3vQETGkyQ0DDTkTsRtCxEdZG7IbGs6a5HUDQZOeNjr5qt9dBXIb7ErWxiB5qb0sST1jfgkuM6pvcJTV5IASC9AO4KogQrmdvjcsrsJSY2V49IlZDdTY6ORWYPSfOnjWyrdmvtYhsC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227224; c=relaxed/simple;
	bh=1xsN4pELrtjyl1qeOwoiLcMy9rhg7HOkHL24s0OlEBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4sMUKiSuKiWjDcEGTS4I75h8BqdPdnwEAymMhfS1rU4PPsHccL5f0rp7qJoZpyPXYBUlQB5YojcIwcLWYitGUopkHycTkFJCAo4HF2wWerFz01CsfNBa+d7jsC76Bhh7VEsIYIsKgYvUyjrDSPbi27pAiKgefoKh8Vt628qUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUKCxekj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUKCxekj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E4E1F00898;
	Sat, 12 Sep 2026 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227222;
	bh=d1hYkJEWy/Y5PWwvwR+Ge9vDOcgx7nsi39bNSuAzm6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NUKCxekjXS/sar9H86EUOVe8SnofmlzgUvIjQyXF46LJBpEL9RThVo3f5XSlv49J5
	 sEFJwSrQQ1AW1zKhbes44NSL+T9tzuzjC1JffaU9JG+z5OwBmjX7rNk7EPQxMVT64l
	 TdlTKXJp1Z/3GuufVn85uzSEJWZ1rhWgsnPtjwU3uoJUcCOanUpP1Zb+vgkJfYBdER
	 0R0j61QaBkrNHrN1cV+tP5jsWvU1SMV+l90nojpxxKWD1njIzilYGIx437suUX/o08
	 O3MxBZRX8+SlF+/W7BCp+RXG6Zh/ZDLMxW8nksN2r4/ATTA17wpFubiioZlRdKv9Hq
	 Q2rGbjHedqp5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Sat, 12 Sep 2026 11:33:39 -0400
Message-ID: <20260912153339.3234260-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912153339.3234260-1-sashal@kernel.org>
References: <2026090919-operation-hull-a6ea@gregkh>
 <20260912153339.3234260-1-sashal@kernel.org>
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
[ adapted shared-validator changes to the existing simplefb_get_validated_int0() helper in drm/tiny/simpledrm.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 07abaf27315f7..b5df36aea6575 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -54,7 +54,7 @@ static int
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

