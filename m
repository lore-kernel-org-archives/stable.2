Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336547;
	b=jbVF7lxUEsLSWs3mF8O2jkMxIr47VB+2y3OCpRfuC0ls4b5+K1twn9g1k7Py0QzMoPYU
	 sHq/QXketv28mTv21pf17ghAwMiLrADg88zGHDEJFDUhG2+kgkKHX6VvMiHVnEivP56M8
	 7pCmLsIVxEbA2SJrW9rJBdyhFOAMG4syykd8sIjBP5wxsmX+USSmsjh+2258cxsFFaVk6
	 0ob2nhJP1siWaLm1jQNIgMRA8oSAZaKzrFfLDuQ+tl4DpSbwlvEgo6ZYRoOdhJd3RM66D
	 kVYfxINLwO2nussQuE0QQegyHDDJz0QUH//8jnfZ9ljyUtbyXQdqDrkWnN42GLipauw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=4NwN9E6vgSlo8rB96M5nv24KM+FlzXoI9Z76B8vhdMY=;
	b=yVXuBK/GQj5Pb5S5krTz+IoDgf5Pin+/9cPiD/DHteDDcSkxiGEPWlhZbQZYNzHEi7dc
	 O0rVjg4NLMrdS0U64IegYHKVO6I/CYPmDABOQ3lBuv1DozOeF6D3NY+zk00d9a6knW7GW
	 VKMIL1Una4/+ExO8EDgomOjrkjGP/im6jAxFp6/X2wVZJU/dgfC2SfQMDwX0CNxGtaEvm
	 Qkj+G11XrvWqeUlkLQW1KVlKoW4VA4TKkDGikpCV6jQZmBGnhcmwPDrou0iQ8PlMUXvA7
	 lWFDbg8HQKcAbzdNCKSrKaF6QhSrAjmsybnyT0VeTiFD39xBKtqmOU6OUA9YHsft4Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ZUitLn4h;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C4606A326;
	Tue, 10 Nov 2026 18:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E50C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ZUitLn4h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794336536;
	bh=jegcFOu8qaT2jcRlBX2akbwxJzGRCez4pO/j9if0ZOA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZUitLn4hDLwR4dPGt6gBgP94Jd1TCaTjqARbtL4+Kvz6yCt1UhXUV+JvnakT2MI0X
	 lQXjeApoMi8beKDSY8i+3FuBHIWGxPvpu1X0lNk3KXte5MfmqwahXb/wtibi4GWoqh
	 OJcLpj11rvmZKydMjYAAQFxlcLAgXNisyYKdCFLyvKZIlkYzqiJpvMVdAw/BqPdtZ7
	 uFcVuRs90O9vUg1wBJVik6NdBXnXCP6uag76yeW5qGcnJkAKgLBMFvhWQUkw1iMB4j
	 Rw+XnCWcsi2iWZQPh9DcoXLfePg7IZyNDwWPYm4clqNwgqjGqQn+VlMedzT9dMwp2N
	 RwSyM5Y6uaz2A==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 7957025A66;
	Tue, 10 Nov 2026 21:48:56 +0300 (MSK)
Received: from mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue, 10 Nov 2026 21:48:53 +0300 (MSK)
Received: from rbta-spb-lt-115149.astralinux.ru (rbta-spb-lt-115149.astralinux.ru [10.198.28.148])
	by mail.astralinux.ru (Postfix) with ESMTPA id 4jPFzm59Nqz6pr;
	Tue, 10 Nov 2026 21:48:52 +0300 (MSK)
From: Elizaveta Tereshkina <etereshkina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Chen-Yu Tsai <wens@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Samuel Holland <samuel@sholland.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	lvc-project@linuxtesting.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 5.10/5.15 v2] drm/sun4i: backend: fix error pointer dereference
Date: Tue, 10 Nov 2026 21:48:45 +0300
Message-ID: <20261110184847.439523-1-etereshkina@astralinux.ru>
X-Mailer: git-send-email 2.43.0
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/10 18:31:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: etereshkina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;127.0.0.199:7.1.2;mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;patch.msgid.link:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207384 [Nov 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/10 17:50:00 #28834512
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/10 18:31:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Ethan Tidmore <ethantidmore06@gmail.com>

commit 06277983eca4a31d3c2114fa33d99a6e82484b11 upstream.

The function drm_atomic_get_plane_state() can return an error pointer
and is not checked for it. Add error pointer check.

Detected by Smatch:
drivers/gpu/drm/sun4i/sun4i_backend.c:496 sun4i_backend_atomic_check() error:
'plane_state' dereferencing possible ERR_PTR()

Fixes: 96180dde23b79 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Link: https://patch.msgid.link/20260217014801.60760-1-ethantidmore06@gmail.com
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
---
Backport fix for CVE-2026-53066

v2: Separate variables declarations to avoid instance of warning due to
lack of b5ec6fd286df ("kbuild: Drop -Wdeclaration-after-statement")

 drivers/gpu/drm/sun4i/sun4i_backend.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 9c4581a3b65f..20740ff02a81 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -505,13 +505,19 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 		return 0;
 
 	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
-		struct drm_plane_state *plane_state =
-			drm_atomic_get_plane_state(state, plane);
-		struct sun4i_layer_state *layer_state =
-			state_to_sun4i_layer_state(plane_state);
-		struct drm_framebuffer *fb = plane_state->fb;
+		struct drm_plane_state *plane_state;
+		struct sun4i_layer_state *layer_state;
+		struct drm_framebuffer *fb;
 		struct drm_format_name_buf format_name;
 
+		plane_state = drm_atomic_get_plane_state(state, plane);
+
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
+		layer_state = state_to_sun4i_layer_state(plane_state);
+		fb = plane_state->fb;
+
 		if (!sun4i_backend_plane_is_supported(plane_state,
 						      &layer_state->uses_frontend))
 			return -EINVAL;
-- 
2.43.0

