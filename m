Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04ED2EEE83
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844521; cv=none; b=l3x0xCYs0xwWA2LmEEauda8/3f/EifojXSb7Rt/K/evVj50LlhW731luSTS+7iFBOFdhsfV/LEoAY0NUuMMVmO4nbtMQ6KFXum9/HpyZQxzkDOAvCNAiPHHejEGv2n4luGtXZYTsNzVxSyH2J6zoXh5nneKL+If1zqzBDq6CBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844521; c=relaxed/simple;
	bh=erypfUCUmPRkcMDgTcg6Z2l0KL1uXHOFt3n1IlQzUFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbdNuSqO1c+sBzITJsxRoeOnFEtN6d/23Vh2Ze0YhvNQdIrIa5l/XmN5UHm/zKB0zFftKaAe+sUF615E8uptPZbZ5JfWCb7WYh2eQVnHGNtzBQx6JDCLVJSHNsMjwQVt+iq8dDSElap6KDgpekaGMq7drQ333j5rBjVRPbrrKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Igalia.com; spf=pass smtp.mailfrom=Igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d7b0vxFx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d7b0vxFx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=nmwrLXq7/O7Hbu3rbvXMqYcBqfxPK2sVzyBnuhEyf1k=; b=d7b0vxFxH6CIzC+fn3pEpOxuIB
	+v/T43SE3mTY+TFmygMh2nuq33QxvD94qmljHx0ST925XUXCMympXEhV08pUSs8vxurhLF5MtZmIO
	Lp0NmGQguc8BtrHx8ctdiARkK+FeHJI8VtZM0Mk5eQszpY1LEzjFFud9K8NsGpCMBDbbMVHPB26vZ
	24zZTGQsI2JwvEUsX2oId7Jc1MidPtypDhcpDjQg5qyIHHMrmEtQCfHOuDbZBB5I6j0pTbHF5Cbc2
	URk+wG18yVx4Tq9jhkhF7gOQt5XqoSMcJdncX/mRgWPXK+D1QoUBd9r7YFqk5/vrtX+CNkbwZ0Mp3
	LqRx9jvg==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wn1aR-003ck8-V0; Fri, 24 Jul 2026 00:08:16 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Daniel Stone <daniel@fooishbar.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/connector/hdmi: Fix out of bounds memory read
Date: Thu, 23 Jul 2026 15:06:52 -0700
Message-ID: <20260723220652.533345-1-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A helper function was copying a given audio infoframe into the
connector's copy but using the size of the destination (a generic
target, sized to accept many different data blocks) not the source (a
very specific type of data block). Thus, it was copying 60 bytes of
data from a 28 byte allocation.

Fix that by using the source size instead, together with a build bug
on the source size actually being smaller than the destination.

I hit this running KUnit tests under KASAN (while debugging something
else entirely). In the real world, it seems unlikely to cause an
actual problem. It is a read not a write so it can't corrupt any
memory. However, it could potentially fall off the end of a page and
cause an accvio bug.

Fixes: f378b77227bc ("drm/connector: hdmi: Add Infoframes generation")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Daniel Stone <daniel@fooishbar.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: "José Expósito" <jose.exposito89@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce17eeefc2da..d6669e36ca1b 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1142,7 +1142,8 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 
 	mutex_lock(&connector->hdmi.infoframes.lock);
 
-	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
+	BUILD_BUG_ON(sizeof(*frame) > sizeof(infoframe->data));
+	memcpy(&infoframe->data, frame, sizeof(*frame));
 	infoframe->set = true;
 
 	ret = write_infoframe(connector, &funcs->audio, "Audio", infoframe);
-- 
2.43.0

