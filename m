Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2D2FDC30
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227596; cv=none; b=LiAwBL6ngYHd7clYo3IGAm8Svw3XadJC3vWyGniDzCc2BSPI9Ce97waD/QcC6PauOhNev2RZiFYSL9YWOe5SXaIXo8X0XSaF45OF3i2A71MRo3FAdeWn7TJ2jvGwuukl7ujFHVHg2ks073G4eukb+1k6k0Ubw/XfJQIhGBlYx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227596; c=relaxed/simple;
	bh=c2u+Loqsb0Z8bYd20BzCpOOADV7yUAEx1S115q5f8fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izy3HDBBBMKccdXCcoaKZBtbuC6V2fVXP1W+9IiQQ+qQd+fA174FkoIbS3Zajv1/t8CJ8pY1u2gaeqfInT2Kj2GFgvqJM2MvUU5EQ4c8q4+yppYXPQQli5VrJk/SyJoQ0X8nuJJ/oa5mp1Md9aL/I3Lr2fB2LZ3yW16woP0DdUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SePqfZGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SePqfZGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85D81F000FF;
	Sat, 12 Sep 2026 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227595;
	bh=5uigI5C2u4bezsqF4b0vqLpI4yvD7SiU0fTFOulJVxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SePqfZGOer2n5+eI6MRSE+I0RPgn2ulTwjKGY1kI7KfhoWe/AIxgKTGSovivSuZTc
	 dmnRd9jEx2lqu19HEX5U3EqVHHkTyzVsjcFSV/ozo4KqNKJC8iv2KtM6PJ6F6oEQmt
	 oSBqN2o19k+iR68OFZmoBtsHa2243/6lAGebv/wvfMBxai90OPnH59UYrFjLOGTKTH
	 1toSuQ2hxUIT8ioBzOEyY0pUmWcxJ/BE7arI42B0ttXTI5h3J9gn0AuIXlFHjKXzdJ
	 YpuZtZOXksuwtSR4Chos5xqOrwobXBszRn9U+4TjFi1AKgW5aVp5qlrCQNUceutLz0
	 Hzp0JNZfv4GsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Sat, 12 Sep 2026 11:39:52 -0400
Message-ID: <20260912153952.3238327-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912153952.3238327-1-sashal@kernel.org>
References: <2026090919-cross-finalize-0ac3@gregkh>
 <20260912153952.3238327-1-sashal@kernel.org>
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
index 30676b1073034..fa40da758213c 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -52,7 +52,7 @@ static int
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

