Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568036;
	b=Z9mzXb/z0nal33f3ia7MnDUIjq7sTOjNAyhWaD5cBrU19cIBgPzeODcw7bYndwG1lbyF
	 plg4aUISF4mH/U8rkdCerQ3t9EgoTxG2tuvmZ5BHPdPYKtrdo3m1oxi4hBIylUsQ6gM3z
	 VrUYMT/nuIu/5QZ7Pp1gMhTnZ6SXvhy4TVpdYVfw2KPNG6UTvZ/0ILnrFh2k1UPsO6nmY
	 +a/4U5NUIewz/c+UVZYfolcr/EUMRenPsuE44+wH2HvMW2yvCE1lFyU2peMZAfo6x+WeN
	 cEWbgw09ULR9zSqJGLDMDBci+NY2jlPN6C2OFHEMxyqO7g+y06qqmjvqZOyEMFW1aIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568036;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0u4I5WkyGxxjmS7tCo9l1n8+vnW6qTUBkG9tKJuJIv0=;
	b=2eE+lHJvlZAJLbCYoQaDnvTUT+OSelEXnhMOZ0Sq2SXo+xE9tgoQh0Pge+ZTjVKBZayM
	 /66X8yWFoxgkMuTduweHvJYe+tKkKV5XGdQnu+Py+cU0MFZzFPOp7xb2CzZaQ6qDcSA5/
	 dKYBf014q2TTCVQjvMxnGnZml8sOQaynE6EEOrD3ChOCipNL/qqqFLZg2ArP1uBxzkr9d
	 z+xAyKaDU0gCu+4MhuoE2ZL83QfZFmErSe7KBdplQXLDD0uoUI33MSY9x5c4vWe+DUGEG
	 RuLbB0NJCWmsNxMCIEvIxWUAwTeSGcApBjc9GtXp55QEktBEUJTAh67WMdO50KApbuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=C8zGvDYD;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE2606A323;
	Fri, 13 Nov 2026 11:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BACE2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=C8zGvDYD
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id 4845C26BC5;
	Fri, 13 Nov 2026 16:07:13 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id BC9A326BC3;
	Fri, 13 Nov 2026 16:07:08 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru BC9A326BC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1794568032; bh=0u4I5WkyGxxjmS7tCo9l1n8+vnW6qTUBkG9tKJuJIv0=;
	h=From:To:Cc:Subject:Date;
	b=C8zGvDYDGBmVj+gaJSFjQmmG3YDxG0/mhlULOXAGGi0w6lBvfA9RmSOJAYDc3jwkx
	 QzB8T8kzciyduOcqE1r3E+nOcdNv0tiBg59K43eMwXvoPHAoQ6IHu9GuiGs9oRGarA
	 IAulTjfECLBW/01dDRuQ5N0U4P3BAzZ9mG2RsYMwxCLCHOseblX/4j7LuX5NL7Hf/B
	 7/ZgBV4wHml/6kM9fZ3TMvahyEPEwLvvT0TS6Jm3l/OE6cMha9fQpDHW8YODOvWkJI
	 LyggwSP6NCZvtepBvEGUy3KS29eDw0xyH5HHLdquBdxf4EqDrKNhinATiznqp6TP8D
	 PLD0eypz+JMDw==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Dave Airlie <airlied@redhat.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/qxl: Handle failure to reference the surface release buffer
Date: Fri, 13 Nov 2026 15:06:56 +0400
Message-ID: <20261113110658.4188477-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
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

When allocating a surface destroy release, qxl_release_list_add()
takes a reference to the buffer shared with the create release.
If allocation of the list entry fails, the error is ignored and
the destroy command is submitted without holding that reference.

Once the current release buffer has changed and the create release
has been freed, the buffer may be freed while the destroy release
still points to it. Garbage collection can then access the freed
buffer through qxl_release_map().

Check the return value, free the new release and propagate the error
before submitting the command. Increment release_count after successful
release allocation to balance the decrement in qxl_release_free() on
both the error and normal completion paths.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: 8002db6336dd ("qxl: convert qxl driver to proper use for reservations")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/gpu/drm/qxl/qxl_release.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..342c3600d425 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -262,6 +262,7 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 {
 	if (surface_cmd_type == QXL_SURFACE_CMD_DESTROY && create_rel) {
 		int idr_ret;
+		int ret;
 		struct qxl_bo *bo;
 		union qxl_release_info *info;
 
@@ -269,12 +270,17 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 		idr_ret = qxl_release_alloc(qdev, QXL_RELEASE_SURFACE_CMD, release);
 		if (idr_ret < 0)
 			return idr_ret;
+		atomic_inc(&qdev->release_count);
 		bo = create_rel->release_bo;
 
 		(*release)->release_bo = bo;
 		(*release)->release_offset = create_rel->release_offset + 64;
 
-		qxl_release_list_add(*release, bo);
+		ret = qxl_release_list_add(*release, bo);
+		if (ret) {
+			qxl_release_free(qdev, *release);
+			return ret;
+		}
 
 		info = qxl_release_map(qdev, *release);
 		info->id = idr_ret;
-- 
2.56.0


