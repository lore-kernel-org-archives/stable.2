Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794376809;
	b=CtAq8GmuPxs0kyPnkijFSLD44N3Sv09c9U+++jUQN4RKW3Avk9/H8bCWVrE+slZKYcZa
	 ajtWUydcPoE6e976K6IoH6yBYAcp98ygCVGuHe6nfqgfKiN+c0QGUwaqPjPYX28UIljKO
	 JwPSHtCGZ8N+3IL8o4xyhXQymbvc1xZNTNY/8qiOuQg5eRPxhhPHsglQFau3WUC01w/XH
	 EyiPeWpnBSaZ+82Te/RJb3RlUtGU4K+XcBgU4Y44rRI2/2Qd01JpL9UB9ZKgJ4iKMtf35
	 3P1iSTGcPTgB5fjDNnjX+yOIwDcd0F+a97eyEp9S3jKsafIgR+sJkY7HiDDBbwale8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376809;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mORo6hrIll4hKzDE40unnzHfctLSM43QrJ2IFMh45mA=;
	b=onC3L42nMoE3z91saYohRIyXF8CF9pi7amOnGjYvx+MAxOFt0xfohnSPGYuldoUkOGcQ
	 iy4Q0UDJ3hvtUy4ojc+53mFSvtUaoXeAvFC2nG3RYpx4oVze1B47NTECqXcAfsrYQ9sgG
	 R9zmVxg7f2njnUggvb3Srxm84rG5MLpsKAyN7Jt9YogwS9/RdZ2iqqeUa5rawpdb9Ef7T
	 OQA6viPDvuyRBaNbe02mPaaWnMYFGLvymQ5RDQ8/MZ6TCQ5N5N/mads47HeUWJnBnphoN
	 3XmgQaza8h8bCfGeUBz13OHnSS0F0ezVBoo8tjB+kM0Qji5W8ogNSoBAI1gXgBx4acA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBsv4lau;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB409606A336
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBsv4lau
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794376809;
	b=J1GUF5gUer2BBWv5fhaSROdesHirrTBD08V7rJe3bkM783SfzFG99liGIXmzl+P7ecTa
	 NhzsfeAASZBAiQNGMcRwx7y1EthMU5v2WndkbzoKXwtI+jxJsbA5oaO1mgYnG7KIT82Zf
	 QItp2DvbqT5vtbpX2FMyN87NdX4x/11LV+9qRbqGuuwkW0XSwCw5mBoU7Ge/kTDTlLq1U
	 FqoOo8sNY6T1gTb8IHVNZDtenqNb+EvXYRPGuiu0B3KV8l8nr/HVc1UsZA9qkjWDdSWAX
	 UY1AwlHd4snVdkxd7hgL9OkqTGT+ODO4S3T2s6lznfFLNjnjXIKpm7IfIqOFamUWIxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794376809;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mORo6hrIll4hKzDE40unnzHfctLSM43QrJ2IFMh45mA=;
	b=SjSUbXClzyG9e/29Ikct8vEjly03ra+YiYOZ9qBMmlQHSpLTePR3ZWWyFqqhOviMtY3p
	 9UEZIDMSQGOFoBFxVxflbEoXciqn3xFTl5pNR071z9r/cYhx2ooBxK/20lDCTvRg6vUbl
	 bBOLej6wFSGHRWNgQZRsgZUH6JCiPqYtJzJKJjyZ/T2hOAgKwip28oaFncd0NvH4vdCRt
	 NwsSJWzUl8FOT5KZ9SzHPMAgHRNtE/g3fwvnbDDxbez/UJFrLZGRyiuj0zRaecM9gWArp
	 KtPyW6seTeoY/hSoWgvfOQr96JzjqOUPk9qKeFkkJS0Q7jex0kFAn6cFKluF+9iJCeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 303351F00A07;
	Wed, 11 Nov 2026 06:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794376809;
	bh=mORo6hrIll4hKzDE40unnzHfctLSM43QrJ2IFMh45mA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=IBsv4lauWgIjA5q+wEBKkbz5JYbZF0nnkXdTIB4ABgOd+H5VYVICo5pW7ucKxQYRi
	 nJ3pHqHWDy66w+33YnDaOHdP9dE56D5mrar4pYMEAR7LH9qkD3UeLfBFVkzXJ3y1ps
	 +ftSgi9a6EomBFxqbt3hxCDe62D2HxCObwezpoYZX1jLw7ht9IlYJBfMog2QB2E207
	 i3ROk1FObrd24clHmah5Bc1Z/1GPit0QoX6wWvGnvOblyLEjGpKPN4QdO8QfIXIAFC
	 kcDn6UAYWlDQ3XKtn/h9fIOjfXWUQ6xU72y3OHSepou4DZXkjwm2tILjTEBLjlGIPQ
	 o7dCK1EtmFA/w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7AB3248DD6;
	Wed, 11 Nov 2026 06:00:07 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Wed, 11 Nov 2026 16:00:05 +1000
Subject: [PATCH] drm/nouveau/disp: Set
 drm_mode_config_funcs.atomic_(check|commit) (attempt 2)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-nouveau-atomic-fix-v1-1-118e65d3a2f5@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBBFrxKzbsAkNLpKtBCbahZpaEUg3r2ht
 3sP/i+QKTFlGJsCiR7OHINI1zbgdxc2Ql7EQSttOgFDvB9yN7orHuxx5RdtbwdtlCfjLMjwTCT
 5P53mWj9Sw/bMZAAAAA==
X-Change-ID: 20261111-nouveau-atomic-fix-7478260ce6a7
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 Ruben Wauters <rubenru09@aol.com>, stable@vger.kernel.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=3p4OPHHZOJWgpQuQJ5QnAg5qMkCUtFo/f/weNmlXOSk=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq9ARmdY8O0EEkMXRDfLn3actnKw4etDeyAV8x8
 HKJOrksjxmJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavQEZgAKCRAMdPNZecSG
 vpwKD/4l9INlZa9aSAR5SckcwizWiw5H6zLQzoeImLwaKy+8n2gedhzzkX+PUHnmYZhnHVhK58D
 4TXaCaaLKqNSbG49F2EzNHi8S6kFnodZZVt1KNgCj9kyJEALImwsPYlJDDfcim92L1NTpg9J27L
 y9aUreEWmlfxoEBaf69hYwZRzgkx2GQK9qRduFvbXfD2O/TmU9yo0XtvMfOchvkmFqvhmrsEXzm
 7YQf8ogM5+5JK8CH/zBkXG6sikkjA0loZdNeOiFbtLu3pPwtX5wSIyhqGxSjTF9G9sEtDxPq99z
 R9wOuRuKqLl7zqRwwOnBcrUIk+mQVoihUPW9lPG+pOnfDR7i695sm4Ms8VmsNTpPGrbhqLd4wuK
 t148TuirypH6FSuP6hIPClTZQSlyVxFhS9wckmj7Jz96Xv3Vi/GGAfdqG0CYm1/0pg8y0Falhs6
 Hu01FdcGxNt2KKyejLEiUodh2Y5Vyw0CV55VRNAKgmT+5prKfexroeF0uVD9pe4XR1JuysFJ26Y
 BdYsOHE1nhrITGiNDbR0tBDJWwji/OxLrgokm1Eg6+9bUHzI+391vxC3ulv9cnAGdPy4vpHGiH6
 9VNBlcHeO93HhNi5tl3fpwONq+WFAbx85wvM45KC4Ql7C4S3y1Hgw8EBZrOv6xbVrQLxDgn/Mrp
 U3v3tPwh6US6jAQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Reply-To: airlied@redhat.com
Content-Transfer-Encoding: 7bit

From: Dave Airlie <airlied@redhat.com>

commit 604826acb3f5 attempted to add these flags but
commit 6c65db809796 reverted it due to it
failing on hw from pre-atomic times.

So use a second set of functions.

original commit msg from Lyude:
"Apparently we never actually filled these in, despite the fact that we do
in fact technically support atomic modesetting.

Since not having these filled in causes us to potentially forget to disable
fbdev and friends during suspend/resume, let's fix it."

Reported-by: Ruben Wauters <rubenru09@aol.com>
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/517
Fixes: 6c65db809796 ("Revert "drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index d71dcfc6ee66..07882624a7f6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -354,6 +354,11 @@ static const struct drm_mode_config_funcs nouveau_mode_config_funcs = {
 	.fb_create = nouveau_user_framebuffer_create,
 };
 
+static const struct drm_mode_config_funcs nouveau_mode_config_funcs_atomic = {
+	.fb_create = nouveau_user_framebuffer_create,
+	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_check = drm_atomic_helper_check,
+};
 
 struct nouveau_drm_prop_enum_list {
 	u8 gen_mask;
@@ -654,7 +659,11 @@ nouveau_display_create(struct drm_device *dev)
 	drm_mode_create_scaling_mode_property(dev);
 	drm_mode_create_dvi_i_properties(dev);
 
-	dev->mode_config.funcs = &nouveau_mode_config_funcs;
+	/* this only gets set if the driver has the ATOMIC flag */
+	if (drm_drv_uses_atomic_modeset(dev))
+		dev->mode_config.funcs = &nouveau_mode_config_funcs_atomic;
+	else
+		dev->mode_config.funcs = &nouveau_mode_config_funcs;
 
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;

---
base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
change-id: 20261111-nouveau-atomic-fix-7478260ce6a7

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


