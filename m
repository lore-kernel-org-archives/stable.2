Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC072430CE2
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174832; cv=none; b=Kekhw5QZnR13qYWZ4W6IOjV7t+euqnGxUU0u6VkUhENdwnyMwMslAVweo7Qk2V4ckXZ9YIYuwymOetYNY7OfAef0dN3aRXT2VvtfPUKiEzrs+5JO048Z+RRvuFRNL25sQ2LMT1Hf+DK2vhflxZPOBKzpugTyDDzY6r0ZWZS1ulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174832; c=relaxed/simple;
	bh=KMjiMwJxEcFoImBP2CGGJqvjXnv+idGDvqtvlRLb0GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJF8KW+1+TvNhp6OonB0a4B4qTKsFujyQHrH5qHoz7Dw1bQmJooYB1GdHnpt4S4+AQpZXJtYrCHgqbx2Ijkyy5eRdZvhBl6Ia3MB50UsqM1kzQeYoGuwXONWsr+rnv4m38H3BnFaPmqrHcIIhmI4VKhN5IbduSzrjKrwrdAWvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGCotbax; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGCotbax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785174824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXRw5HgFBqtMjibe0Tg/q0W0/UG6cgg62YzMlj2W/cQ=;
	b=CGCotbaxSi78VttjzHgZIR5vf1ril4cMNk+DKAaHLopRh9EUw9QPrlVyEKPM8dfB0EfC+P
	qdLBqZbysslHGVOdz+Ek1an9yegsR20Mbf0GPoqro34LrC9UGTEjJL8rVGokQrexbKzhr7
	v+0bihXDOzgZ2+cc5ZEvqcBhK9MimXs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-s2UMOuCWM-20vr2eNngwmQ-1; Mon,
 27 Jul 2026 13:53:42 -0400
X-MC-Unique: s2UMOuCWM-20vr2eNngwmQ-1
X-Mimecast-MFC-AGG-ID: s2UMOuCWM-20vr2eNngwmQ_1785174820
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B8A318001F9;
	Mon, 27 Jul 2026 17:53:40 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.65.215])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE6AA1956041;
	Mon, 27 Jul 2026 17:53:37 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	"Timur Tabi" <ttabi@nvidia.com>,
	"Dave Airlie" <airlied@redhat.com>,
	"Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Ben Skeggs" <bskeggs@nvidia.com>,
	"Kees Cook" <kees@kernel.org>,
	"Simona Vetter" <simona@ffwll.ch>,
	"David Airlie" <airlied@gmail.com>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Mel Henning" <mhenning@darkrefraction.com>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v4 3/3] drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP
Date: Mon, 27 Jul 2026 13:47:44 -0400
Message-ID: <20260727175246.642071-4-lyude@redhat.com>
In-Reply-To: <20260727175246.642071-1-lyude@redhat.com>
References: <20260727175246.642071-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There's two flags that we've never been setting when asking GSP to suspend
the GPU, which OpenRM does set:

  GPU_STATE_FLAGS_PRESERVING
  GPU_STATE_FLAGS_PM_TRANSITION

These flags aren't -supposed- to do much in GSP, they're mostly used by
OpenRM itself for state tracking. The only thing they do from GSP's side is
control whether or not a single display related workaround is applied
during suspend.

But as it turns out, that single workaround is actually quite crucial for
getting runtime PM working with nouveau - and without it set we end up
seeing a lot more failures with runtime PM resume. So, let's start setting
it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c     | 3 ++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h    | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 996941c668ba9..3e391646d8f7d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -198,7 +198,8 @@ r570_gsp_set_rmargs(struct nvkm_gsp *gsp, bool resume)
 		args->srInitArguments.bInPMTransition = 0;
 	} else {
 		args->srInitArguments.oldLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3;
-		args->srInitArguments.flags = 0;
+		args->srInitArguments.flags =
+			GPU_STATE_FLAGS_PRESERVING | GPU_STATE_FLAGS_PM_TRANSITION;
 		args->srInitArguments.bInPMTransition = 1;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
index b6075021e74f5..c458569af9d72 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
@@ -523,6 +523,14 @@ typedef struct
 
 #define NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3            (0x00000003U)
 
+#define GPU_STATE_FLAGS_PRESERVING         BIT(0)  // GPU state is preserved
+#define GPU_STATE_FLAGS_VGA_TRANSITION     BIT(1)   // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_PM_TRANSITION      BIT(2)   // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_PM_SUSPEND         BIT(3)
+#define GPU_STATE_FLAGS_PM_HIBERNATE       BIT(4)
+#define GPU_STATE_FLAGS_GC6_TRANSITION     BIT(5)  // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_FAST_UNLOAD        BIT(6)  // Used during windows restart, skips stateDestroy steps
+
 typedef struct
 {
     // Magic for verification by secure ucode
-- 
2.55.0

