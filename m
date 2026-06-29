Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F803CB8E5
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773091; cv=none; b=RLCMa5APQzowsxRakNyqiRjAwOx3yt8uRwOtroDLzRIYjbw9YYmDgf8iYi0sTpzzeKiBF8S9I2J0ZbIhhdWVJvDo0L/tvH5t2iHDYkFq4qZSCxGEgrqGI2ZsF8mfv0GTqxox3VLmzbNIQGaAvUXzSb49ZvarrTsDxDBY3XG7KAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773091; c=relaxed/simple;
	bh=N5x0Nh75cu4+IqDps8Kdjw8TIB2SiJNdPgwgNbOpBMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKVdqlks4L2rPIPfC6c+d+iqYYjOfI3PO6smNP0ixfC/KN4AXRkWYlzNyLRFRqHLZdfkFmtM37Wi+D2/3msGhlKxwwdW8tCnZHAMG5wiWkPEm6kLz0IG8bPF64FO287voyGQvOERAJ5n3r3fbHx4mMXPOVRmgf9bFv6UlwFSn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFU2biuK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFU2biuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782773089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkXT6NSCsXj0i3X2uHiUABcB9Jzld6noTRsAXR1p7vA=;
	b=hFU2biuKohmaXzpsFv+yJ1GP+DDXmXPJIXw7RgXrj9hqyw3zrhK10aFuYUzAgFmwj9jBe9
	a3adqIqYSqlrOjJmYFN9pLedo4QfZJXPnai/A5JqxtWL3aknS02u0yD24Bw28mbUIFOG6K
	7GSg7aR7ri/ek5x2QtoQtSt/HuWBd34=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-oTPzkahzMjK9kh3AL_vaSQ-1; Mon,
 29 Jun 2026 18:44:43 -0400
X-MC-Unique: oTPzkahzMjK9kh3AL_vaSQ-1
X-Mimecast-MFC-AGG-ID: oTPzkahzMjK9kh3AL_vaSQ_1782773081
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FC39180AD57;
	Mon, 29 Jun 2026 22:44:41 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.59])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 297B53691D;
	Mon, 29 Jun 2026 22:44:39 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
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
Subject: [PATCH v2 3/4] drm/nouveau/gsp/r570: Set oldLevel correctly in GSP resume arguments
Date: Mon, 29 Jun 2026 18:42:35 -0400
Message-ID: <20260629224350.2870201-4-lyude@redhat.com>
In-Reply-To: <20260629224350.2870201-1-lyude@redhat.com>
References: <20260629224350.2870201-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The way that OpenRM handles this is a bit funky. By default, OpenRM passes
through NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3 as the supposed power
level that the GPU is entering. This is misleading though - because as far
as I can tell, that argument is never actually provided to GSP and appears
to be used mostly for internal state tracking by the driver.

What actually happens, is that on resume - OpenRM tells GSP that it's
resuming the GPU from LEVEL_4.

This is one part of getting runtime PM to be genuinely reliable with GSP
firmware.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c      | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 996941c668ba9..00158697bd77a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -197,7 +197,7 @@ r570_gsp_set_rmargs(struct nvkm_gsp *gsp, bool resume)
 		args->srInitArguments.flags = 0;
 		args->srInitArguments.bInPMTransition = 0;
 	} else {
-		args->srInitArguments.oldLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3;
+		args->srInitArguments.oldLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_4;
 		args->srInitArguments.flags = 0;
 		args->srInitArguments.bInPMTransition = 1;
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
index b6075021e74f5..1904305b69624 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
@@ -521,7 +521,7 @@ typedef struct
     } profilerArgs;
 } GSP_ARGUMENTS_CACHED;
 
-#define NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3            (0x00000003U)
+#define NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_4            (0x00000004U)
 
 typedef struct
 {
-- 
2.54.0

