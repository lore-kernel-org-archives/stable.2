Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637498;
	b=H1uE0w+SIMOYK8uyEFYQzUl7p7HHjVejI7q2UW4B/jQgFgmmZM2a7/vjQiFHWyTuYwPz
	 +pzOV0ZyaWSzcYWZlusXsq9YCQ7hWaEgfJ47WYE3YL1Aoh0jgrBlEVeDZNn2bt8HYPH2v
	 BPyb1nBtnGkLlN90RTdbddTOKqrwqrsdxDI3IUAXOCx7xfeWhKS0qC9Cav/B7Y95VSxo+
	 3RPKpS+KlG3u6yfPRK+XVVnxdYppZ1aNcWletxCjArP65s1w8xnW5wb1NxpUn/KlOA6rU
	 SZV6eCLBVqq5Xoq9M28bSQRawcyGSTywWGLUb1iZA3rd3tlmBcxMUDzsGdbaXsYdJ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nuw+0N/N3N3TgZSRfVF3OxMj+eHVfhZTZnHIUjTrdas=;
	b=pklfTRKkHGJt6oxaPoHsLqSM6mg3fgpO2MSKAEBSKeiD1cvpATnWqmc222j2YeWicCjJ
	 yZ9nNM/xg9wcaRFO6hlWAdbkkzXWKBhkbbJC8ndf2pfsGULQCCnUwMaBfI7wdcq1tv0JM
	 MvDcxhKHAUHa5zcM2enhijh0NMN1e88gkeSP45lWp4FssBnIXZeLKS4+h6RG8UcXa2/xQ
	 SXVZIFzuxBrmOe9tPvyT0Zqn+dpd9V0sqGFF9NrqYTccjoqbyE0BSPxWCgbdJD+Xrx6wa
	 A3BoNnyyS5JTDTVFF/y9Y7fTrquhIpbDulzPqLTTpFGwj1uy34lR+AAHQYyrhsI3cUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MRtKWbpF;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA780606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA780606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MRtKWbpF
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e2b1db9bfso197247eec.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794637497; x=1795242297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nuw+0N/N3N3TgZSRfVF3OxMj+eHVfhZTZnHIUjTrdas=;
        b=MRtKWbpFpiCoHMFHbjToXB1tMg9zrjZ6+Wu7wXTfDeqNTiu11McNrTmmEV7vAEwLfN
         vmG+IlsJ+rAQ94wPSyN2EmqTphjQce6tGu663BlNMVKAKIWUTVXfydWpJmWC53PS5lMV
         XgpUtN+UNbZgMDyUxgcoibm6l5SUYbRJ6i0oau23w/d1EbuNapoTGCdBnk48OrYv3R2F
         NefyaFkHxmDB47Wp19wKeP/7xjMfxWUE1ewNH7zQXSdrGTSP8xQT8Pvbz5345Xongn6c
         FDKn2u8xp7+HUhmtEp7jwMdk1QAHAdyZ1ZSBOTrbqGPNNS87gWDwFKAF5aBcvADHD8PV
         cXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794637497; x=1795242297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nuw+0N/N3N3TgZSRfVF3OxMj+eHVfhZTZnHIUjTrdas=;
        b=d812ZovQF9RYlr2eaG00xJk+P3oD8WEWva4wgN+OpST8T/6n8v3Y43KUbzetD8+Hrf
         kVNlYSvK6k0Sr+TVXLyMCFz99nWWqQYsk7byqIIXNkmjo+3Bjakub3zv1+NaFak8yNyC
         /5sBwdQNOKOODeneKdUwCmGPvoyPTeK9MRNeZHY45XaHsA/+gzhfhExbMH8vXC4yfd42
         KL5b1xJwXW+w8TMXz5cgo2TdAC0hkM0Y07fC0fxDhWeybLQ0ebSs8f4ZjsslrOHtwfct
         8dyEkOZ+JpHZIun2YV+gc+WL8/XI/kn9Jn+JwN/EZqV+Hlda4brZ2iI+bRCjzA7nlJuJ
         mwXw==
X-Forwarded-Encrypted: i=1; AL+hErEo0GhtjmO3le/hd8cRMzS1Kecv70aytOVJLsAOjMaoM1MK2uT4Ddpcf9zPSYwZpbkwXqgeB8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9znhQA1a/xlPkWjINibZUyRB0P5kK1oSVJ9xR0b35lCc1gNSAh
	49yv3/OcuviWvecSBaTdlY3zFbp6CbM5kq86+Y43riIXded9jMbT0lra
X-Gm-Gg: AYBFou0jC6+TnbI+zxA2A8U8v77YV77ePbOxeiWHwZ5A+XvYXqoqw6pyK4UddbFmHq1
	xVT9xE96ngv2GwNXHm6evmdOd6220JpFi9sfuLwpJ3TUffjuKhUj7E+k807fClRiX82r9zdqonM
	d8HJ2t+XILnZgqR0TIsB5kKlmNiSzT2OUEM/PWbCXn3DcVuiC4npgUx7obJx9jfIbyxccMAZmXS
	lTK1UE3HnTPJWXVULlBWDnehpeQJHnE4EAXWZpa+R24ig3+RGaBUqCqXcWsh6BL0EBUbyCob00R
	63RgfeA0NYeRNbwQJErsLcZVXhGvWBOJWJsDK/Vot2f5x+99aFjbl7vh3WfhWouOAaOUI++wvhC
	5Jl8DoQaVWZpaQlnvUdZFJuEKLqX4BbIXHRx+6S3/Jkx4FCDssYCTiihOoBtXn2Yrv/rjrwD3je
	xZA9lx+9Bzk2gtlUgVc4Wp4ukqBsL1M1Wtc5seKGHVmIIM+Qjy0L5DFR28OzCZNEKGdjMgLXuWX
	WF7La7DDyoXAmFuApdit/xNKW6dXVQp7Q214pEQKjtMvBryR5A1gc64jhttlr87VptoqlIPl6Bs
	V65v6b58ulQgYkaEwjIFAO8JnIMCRWPcX5jzK9B9rTPOZ0ItycZIN1gmsSyreo4/hXTNfS327dA
	cqQhFf3eoWQA8H39c2mhhMSge
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id 5a478bee46e88-3796038259fmr6483300eec.0.1794637496941;
        Fri, 13 Nov 2026 22:24:56 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795533170csm13564777eec.7.2026.11.13.22.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:24:56 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Donald Robson <donald.robson@imgtec.com>
Cc: Matt Coster <opensource@mtcoster.net>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	imagination@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/imagination: Flush the MMU caches after unmaps done by a map
Date: Sat, 14 Nov 2026 15:24:48 +0900
Message-ID: <20261114062448.1513-1-arpe1618@gmail.com>
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

pvr_mmu_op_context_destroy() flushes the MMU caches right away for
unmap operations, but defers the flush for map operations, which it
tells apart by op_ctx->map.sgt being set.

A DRM_IOCTL_PVR_VM_MAP over a range that overlaps existing mappings
unmaps those through the gpuva unmap and remap callbacks, with the op
context of the map operation. The flush for these unmaps is then
deferred like for a plain map, although the page tables that the
unmaps emptied are freed in pvr_mmu_op_context_destroy(), and a mapping
that is replaced entirely no longer holds a reference to its BO. Until
the next call to pvr_mmu_flush_exec(), the MMU caches can still refer
to the freed page tables and to the pages that were mapped there.

Record in the op context that pvr_mmu_unmap() was called with it, and
flush the caches right away in that case as well, before the emptied
page tables are freed, as is already done for unmap operations and as
the comment of pvr_mmu_flush_exec() requires for unmaps.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
This is about the existing DRM_IOCTL_PVR_VM_MAP path. Gyeyoung Baek's
VM_BIND series reworks how map and unmap use the op context, and this
patch does not depend on it. The sashiko review of 5/6 there raises a
related question for the new asynchronous path (BO pages freed before
the MMU flush):
https://lore.kernel.org/r/20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com

 drivers/gpu/drm/imagination/pvr_mmu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 67e73d7d5d0e..84a58ab2ab75 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -1444,6 +1444,13 @@ struct pvr_mmu_op_context {
 		 * ops. Linked list empty at creation.
 		 */
 		struct pvr_page_table_l0 *l0_free_tables;
+
+		/**
+		 * @unmap.unmapped: Set once pvr_mmu_unmap() has been called
+		 * with this op context, which also happens in a map operation
+		 * that replaces existing mappings.
+		 */
+		bool unmapped;
 	} unmap;
 
 	/**
@@ -2293,8 +2300,12 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
 
 	pvr_mmu_op_context_sync(op_ctx);
 
-	/* Unmaps should be flushed immediately. Map flushes can be deferred. */
-	if (flush_caches && !op_ctx->map.sgt)
+	/*
+	 * Unmaps should be flushed immediately, and that includes the ones done
+	 * by a map operation that replaces existing mappings: the page tables
+	 * they emptied are freed below. Map flushes can be deferred.
+	 */
+	if ((flush_caches && !op_ctx->map.sgt) || op_ctx->unmap.unmapped)
 		pvr_mmu_flush_exec(op_ctx->mmu_ctx->pvr_dev, true);
 
 	while (op_ctx->map.l0_prealloc_tables) {
@@ -2486,6 +2497,8 @@ int pvr_mmu_unmap(struct pvr_mmu_op_context *op_ctx, u64 device_addr, u64 size)
 	if (err)
 		return err;
 
+	op_ctx->unmap.unmapped = true;
+
 	return pvr_mmu_op_context_unmap_curr_page(op_ctx,
 						  size >> PVR_DEVICE_PAGE_SHIFT);
 }

base-commit: d48ea86919434695da12d280dccab72b094397e1
-- 
2.43.0

