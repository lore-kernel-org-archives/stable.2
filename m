Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902A42D770
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174827; cv=none; b=c3LmDL9VVhk/ES8JBrflD7J/XyjlzNV8wn4To9VITKqyVTeYstqUEP8lRkhxAHG1MJIgzUpo2xEZXOMKs65+AnXomvmYrInDYn4lgfrqEeN7YmsupkM3gKIL6dTmYrfGpLjJKKsthe1M6Vys4f33KOepQlc0qsO75LRQMfQnwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174827; c=relaxed/simple;
	bh=s3U6Yj5/mRiofbC9hwiUjTRcJgsFeXTmHeZz+u/SXkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5JRM2+i5WUNpDlxjDWIS2yB211Ihx58IeJisVULGlDo+NXtmDSeEWjST8HPmwMH6FLlFf256SHj4lJcIA7g1MzbOkd0ESXp3UJSS/VU2r1HdSwrvC1tp34jNqoEKodqpgA2ZDNL89OWoNA9D+gdaz3LHWaH5UPrh5bRHrDrqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIgSfIzJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIgSfIzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785174819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TowdlvuTVZS9NXVVVPf7eFBfnfCtrOAkvuPJAet0P8s=;
	b=JIgSfIzJ5/9ZRhcCjfJgdu6yMiCNPhXllmLe8TtTc8/1k6ykfNvcZbuh5fbHmuXpC4hTCR
	McfKgUkV0S/2Nvqfjec6IOvHTMIvZkBjrz/wPHFfxjpWiYT6uJ1t/abEXTUgY6WyQrYn01
	6AVFa3DEz/6irPuW7LgklCJx+0XvLN4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-AT2a_bd6PGianhP61_q71w-1; Mon,
 27 Jul 2026 13:53:36 -0400
X-MC-Unique: AT2a_bd6PGianhP61_q71w-1
X-Mimecast-MFC-AGG-ID: AT2a_bd6PGianhP61_q71w_1785174814
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D210F195DE15;
	Mon, 27 Jul 2026 17:53:33 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.65.215])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 953701956041;
	Mon, 27 Jul 2026 17:53:31 +0000 (UTC)
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
Subject: [PATCH v4 2/3] drm/nouveau/gsp/r570: Set GcOff = 1 in fbsr
Date: Mon, 27 Jul 2026 13:47:43 -0400
Message-ID: <20260727175246.642071-3-lyude@redhat.com>
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

Previously, it looked as if we were able to fix suspend/resume on some
desktops by setting Gcoff based on whether or not we were entering runtime
PM. This was a mistake though - the only time suspend/resume would end up
actually working was if Gcoff = 0.

It seems like it's likely the main reason for this is the FBSR GcOff
argument actually controls GSP's behavior with regards to which buffers it
decides to save across suspend/resume. When GcOff = 1, RM reserved regions
are saved unless they are marked as LOST_ON_SUSPEND, and RM channel-context
and kernel-client buffers are also saved -including- when they are
LOST_ON_SUSPEND. This means with GcOff = 1, we end up having GSP save and
restore buffers that actually need to be reinitialized on resume - causing
the failures we're setting.

In the long term, we do want to have GcOff = 1 as there are still a handful
of edge cases around broken runtime PM that I've seen on laptops - and I
have a strong guess that actually properly implementing the required bits
for enabling GcOff will probably address a number of those issues. For now
though, disabling GcOff results in runtime PM being dramatically more
stable then it was before.

Thanks to John Hubbard from Nvidia for providing some background on what
these options do in the GSP firmware do!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index 2945d5b4e5707..af5aa5065c3dd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size)
 	ctrl->hClient = gsp->internal.client.object.handle;
 	ctrl->hSysMem = memlist.handle;
 	ctrl->sysmemAddrOfSuspendResumeData = gsp->sr.meta.addr;
-	ctrl->bEnteringGcoffState = 1;
+	ctrl->bEnteringGcoffState = 0;
 
 	ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 	if (ret)
-- 
2.55.0

