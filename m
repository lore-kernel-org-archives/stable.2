Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30134678E;
	Wed,  3 Jun 2026 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477238; cv=none; b=mdyyw5NrlMkuwrg3lIGQianK0FG6jr0rDoC389Oc4dUIfOYT16KhEXJbdxQVBYxnc6DYsvZyfQ2NAftZnupofX/jk1ic938jBn5FOzUi57YZESBQUUPdwI9O2xAsiJZSX6SFvwjDhwO84ZJIaE7RC5V+JuhXUlNhPv7270P04O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477238; c=relaxed/simple;
	bh=vXVCuN6NAVWtC4G/8GUc3Hfrre7cwpZFQ2oHAGj7kRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHD8TT9WOdwFqY0ht7fkFBlrEsF3DK3p2xXwLD69YXz2hItOo8AQdc22ltFkjBDuyBZrH0GPoQ/GI6I41Xp5HCfRhfSlUhMzNHiqiHqT0v+GgWtzY03PJVmFRHNFvBevkH41QWvMp69IAuIWhsWn0I5uV6FY6ovoLkXQdNmVx84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dLJJnzFK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dLJJnzFK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 27A701A37D1;
	Wed,  3 Jun 2026 09:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE76D5FD24;
	Wed,  3 Jun 2026 09:00:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80C8510888CC5;
	Wed,  3 Jun 2026 11:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780477233; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SWJLbwcw1LfuoUnP65FT41JauKFUhB7nEOh+Gt4WQSE=;
	b=dLJJnzFK0xuKU5smX78GcLw72hCR9Rf7iBilOH4NL8BPKQekXcEy/YH8lpyX1vFD548KSm
	NB4YXxMFI/0tFNp9Mo6kP3KtrnJszt9IolCxhPwtf1p5nLwHz6QM/A9CwNc090o/m8X/Nt
	HhpVHtNIJORCX1y/qs5NwU5Cf2rgdzz6yFGokKruyJ9WWmf5cC9o1jnoQL1kyuzpv2tiPh
	YOa2q3HlFxmIby9mxm4iyRjTi5AlouOat7vyfEtJuo6g9cj8xVG6dwAMzf5pfA2BQbP1Ir
	LkzRTp0XTgrgZAJIXs/tRPXQnmmZCqgMQqNHLuWhn6Fx/hPTkQVp/UpltjPk0w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 03 Jun 2026 10:59:52 +0200
Subject: [PATCH 1/3] drm/i915/display/intel_sdvo: Fix double connector
 destroy in error paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-fix_i915-v1-1-7479ff64e705@bootlin.com>
References: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
In-Reply-To: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3

intel_sdvo_connector_funcs registers intel_connector_destroy() as the
.destroy callback. Once drm_connector_init_with_ddc() succeeds inside
intel_sdvo_connector_init(), the DRM core takes ownership of the
connector object and will call .destroy on teardown.

The error labels in intel_sdvo_tv_init() and intel_sdvo_lvds_init()
call intel_connector_destroy() explicitly before returning false,
causing it to be invoked twice: once in the error path and again by
the DRM core through the registered .destroy callback.

Remove the manual intel_connector_destroy() calls from the error labels
and return false directly instead.

Cc: stable@vger.kernel.org
Fixes: 32aad86fe88e7 ("drm/i915/sdvo: Propagate errors from reading/writing control bus.")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Not tested as I don't have such hardware.
---
 drivers/gpu/drm/i915/display/intel_sdvo.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index d83d350959d88..0f3aa879e39e1 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -2878,16 +2878,12 @@ intel_sdvo_tv_init(struct intel_sdvo *intel_sdvo, u16 type)
 	}
 
 	if (!intel_sdvo_tv_create_property(intel_sdvo, intel_sdvo_connector, type))
-		goto err;
+		return false;
 
 	if (!intel_sdvo_create_enhance_property(intel_sdvo, intel_sdvo_connector))
-		goto err;
+		return false;
 
 	return true;
-
-err:
-	intel_connector_destroy(connector);
-	return false;
 }
 
 static bool
@@ -2950,7 +2946,7 @@ intel_sdvo_lvds_init(struct intel_sdvo *intel_sdvo, u16 type)
 	}
 
 	if (!intel_sdvo_create_enhance_property(intel_sdvo, intel_sdvo_connector))
-		goto err;
+		return false;
 
 	intel_bios_init_panel_late(display, &intel_connector->panel, NULL, NULL);
 
@@ -2972,13 +2968,9 @@ intel_sdvo_lvds_init(struct intel_sdvo *intel_sdvo, u16 type)
 	intel_panel_init(intel_connector, NULL);
 
 	if (!intel_panel_preferred_fixed_mode(intel_connector))
-		goto err;
+		return false;
 
 	return true;
-
-err:
-	intel_connector_destroy(connector);
-	return false;
 }
 
 static u16 intel_sdvo_filter_output_flags(u16 flags)

-- 
2.43.0

