Received: from mail.scd31.com (mail.scd31.com [205.209.125.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528A34678E;
	Thu, 10 Sep 2026 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.209.125.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004987; cv=none; b=owhjjmbaIQwySf1sZbsltm4FGaApo/HXmDNkoIsFEJAY4inASonnLDc+sgjsoNtzKeEP+IbBbtEjMxAVRYRJnY6q6K6qwLtSG62XdelsJDhzFyDah5m564byYSO1maUH+5HjLK5EuFdIXUeYHsk9nz9rG5s5TZUPhPp67R8vy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004987; c=relaxed/simple;
	bh=7MOgUdEQpk9tZYWcTESHq4VCQW60JrFAbdUGeLGPojI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty1h0lrRQN/scDAlbnWJs2CObc9dcRdy4Gg+s0AiAYWZuAsamqLrPV9p9Ac+KktjX7CmXQVbSqED5u106kFTf2rnb4v6N2Xdxyi4sx/MpwxwZPDX+6q/vODCEkEKlTXuwWxsU7H6h16tmGqHunliVF2VTa97m5ZyZLUIZTvPGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scd31.com; spf=pass smtp.mailfrom=scd31.com; dkim=pass (2048-bit key) header.d=scd31.com header.i=@scd31.com header.b=Wq+YZ+XN; arc=none smtp.client-ip=205.209.125.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scd31.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scd31.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scd31.com header.i=@scd31.com header.b="Wq+YZ+XN"
From: Sophie D <patches@scd31.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scd31.com; s=mail;
	t=1789004974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gqOCUAt0BB0MGG5A7Mb4irXVTS/KZBPzdwYbKbMHAw=;
	b=Wq+YZ+XNLVIYKZW3f3wmn2c02wi81jOjUoO5g8WJFVp4cBGKLhNQ8G63X8QsJeMsxob2Jv
	SFj8Uv6QaPFvCi9mF0Gc2SO28rh2POa8L/Urw5WTqn6ESgd5jTlnpZt6vk/wkFeLWSiE9A
	vV41FD2tQYm+nEIudFcf4+BNr3wUbZo924DQt5Iz5V/WPsA+mS8wc0KyiNrfqskCCDxEud
	tx3JyIxfruDyGXJ3Psq0JH4PhgUqoF3VDXXS5HvDTq3WmbLOg59QTO2gVCqooWTvC6J41n
	pAmlEnXowWQNLmYpAto5pMGyvMVgO3twS64UBMMKK44jBQNgmy0gbiNuTt2vew==
To: Ruben Wauters <rubenru09@aol.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sophie D <patches@scd31.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/gud: Ignore damage clips in full update mode
Date: Wed,  9 Sep 2026 21:49:10 -0400
Message-ID: <20260910014910.8564-1-patches@scd31.com>
In-Reply-To: <20260907230849.31032-1-patches@scd31.com>
References: <20260907230849.31032-1-patches@scd31.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running in full update mode, previously small updates (such as
moving the mouse across the screen) would cause many full frames to be
generated. This would bog down the bus and lower the effective framerate
significantly - I was seeing a drop from 60 FPS to 2 FPS.

Set ignore_damage_clips in full update mode so the damage iterator
yields a single full-plane rectangle instead of one per clip.

Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM atomic helpers")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Sophie D <patches@scd31.com>
---
v2: set ignore_damage_clips in atomic_check instead of merging clips in
    atomic_update (Thomas Zimmermann)

 drivers/gpu/drm/gud/gud_pipe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 5ef887d84..3388fdc8e 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -482,6 +482,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->visible)
 		return 0;
 
+	if (gdrm->flags & GUD_DISPLAY_FLAG_FULL_UPDATE)
+		new_plane_state->ignore_damage_clips = true;
+
 	if (old_plane_state->rotation != new_plane_state->rotation)
 		crtc_state->mode_changed = true;
 
-- 
2.55.0

