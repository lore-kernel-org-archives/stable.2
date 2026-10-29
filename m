Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311029;
	b=fENuCBwhu8AKSxfN18z3dhqPPEJWuYtlu3X6IgbV9EaHYFVLwueUINJBLc60ZV1gy/49
	 AP20Ea/dydnsDLqM5ZM7pDWBedsj/SCVQjY3HsR2oNAshezk3g3r1g9jEa7nv9h1Okar+
	 9D9pqpzamssRbR6MmmGejCexdtGobPSQ0dSP/ksCRJtzFxxNS5tNePtgO8UufbWEe0VzC
	 JgWDebOF7O9W5kM64zPJzA1WyHmSNoOfuguabF7N0WWZ8ZHnqJsVE+78FQLFw7klHJtMo
	 4I4X+wSLIUJz1VW/SBvfek+QWEvZjYYEdgElvzM98PItoLUU6fazywsc0gfJyKHB6UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311029;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=BtE8gEpGXXyQgany7PV79KzxRGZPRiw2gHz+ihjMaWE=;
	b=NR4LIVeUAgkDLWucA2akGqiaAUp9NKyjU1AKxWrC/7jDXW3bGfvFhm93KzQPkxBZ4/E8
	 xGKk8CYvSu2dw86im6OxxlbIKdYCFJb+6l/WRGrvU0EyrMb1ncyUY0Rkuw6jYr2MW8QuS
	 f2t7pVN6hUba1YrhaOS7oSLWZtte7+bnMRyzb9aXB0fgCGtG06Cp8z9lOU8L9b3BjCpxg
	 FdbuP6yodAFsMDxZgxHKdyluV9xnURQWPGDhcCV6ct3h4LuqoWja2EebmHhkoPeB3YJud
	 FjikkRtJIp8AZviKsZulBpm0c9Gii9W8InLkQgFtxALMLz2Q6W2rof6IXJccd0dE7yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="am6/PCDx";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E4606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F3E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=am6/PCDx
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so45441a91.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311028; x=1793915828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BtE8gEpGXXyQgany7PV79KzxRGZPRiw2gHz+ihjMaWE=;
        b=kjz395wwRur0gJBN9CdvLkP/KMgwVEq0y/EK/b86aNDbhfckKNkNxSzzTx9O9iN3gX
         WO3Dmbl7izGSVMz0svG1yZ4cHCbwCiRJf85VLyOLmOmp15226UF7mn2yUb6gGINQAAMt
         aeSOv9xgG0XzxB9FV6m1B0KJdQKPvwYGfy8ZolTN+vzxBW0G5/Lf6rqy8bedcyXNMKMP
         FQaMs2QpSkQDQFIMEuNfrkpt/iI6fuuy8iDZPXZR8YS7ZdHqWxEdIs/QiOxKpFtOaBIQ
         abclNlJx7xP2Gf7v9I3tDP3k7j3EwUBrQ/yZ1yAbFRK4aDEdyiA8Z8kEX97uEDcNEOsn
         GDoA==
X-Forwarded-Encrypted: i=1; AKwUvBxumnGhKYhEsOKvQTkiKf5CSpqYbyyDt9AHhaxIznfHFONp9QbPpfbMLFCCT1Jq/9Fj/5Ak1b8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4Ha4gG/B2Bv4AXeWGCK9wQeWk8Q6OerxXfFGya1aV8e2x0Eer
	6M+OV9/JJucIRJvWRWyWPjKaBoLEoyNGAJwkJ52KRnkSS8dJgYEIk96gozCAfTtVNDsbPC0Sr7j
	s/gPAJiquzUXybLg2RzRrC09jBqtLnaOy+O6GHn6E5fQG64MVJ/i1MvDCQhSwzfeBjMXiCA0kEx
	RrMFo45UZHQEYQc1CdA43oErO60bFsm5sDTSdoDOjcAZBKVbClJZn4aADl6YhnpkSW9Z4C5vdsC
	psLkE3r
X-Gm-Gg: AYBFou3HYkLvUtDdnoondd4wQ/THeVWLdfyLLXTkQVRKyNxY1cgr7dKCM+wPDM4f/ax
	PMSPRQeuoo2E0W/Xdan6RJ4SZQly3oBBirOpzg5+j4RlgOmsTcmvBa59Bn2VkiYj8GNsOcbjr/Q
	4U+HqPSlKjEDE1XlhvOGqh3F4ESFebilljLBLpbBzvnDuRAN1eKkNd30IAqaD7fcJYwkee26FmN
	e4MW/OGHfbDgs2wUu6J6vvrcYvPkB7df2c2nSqKa8BRBy5zWo+QpMvgriPYDMVM1Unz7bFxKTrp
	1Atpjyn759bTgLLsRWvgN6Um3RwQ5ne7sW8yoCvmcUreg4sMFoSW8GogWXRpMlWscOu5+ruq4Ts
	OcBbExczjVPO+7yw0rMzdOrqITEc0ReU79MTrluAKb7e6h+ouDRMiV067ayLkh5WO6c4FcFdN6B
	ooZ0jP12KgOX/OpjGHam+8+BY6UwHfnL2j
X-Received: by 2002:a17:90b:4f87:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3ae897e5685mr223300a91.57.1793311028349;
        Thu, 29 Oct 2026 14:57:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae845878b5sm693420a91.4.2026.10.29.14.57.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:57:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so268002eec.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793311027; x=1793915827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtE8gEpGXXyQgany7PV79KzxRGZPRiw2gHz+ihjMaWE=;
        b=am6/PCDxHx8LuVxkdJ4BSCFv0L3iGMdRd2JN0ni0woCVtdSGELnZL9FnBWu4BEt/Zm
         rSv4jQ/PgF+eKWXS71IomqR1MbYA5g6ElRJnPM59zjO5HnLZGZJeA8yIW3gx0Nce+0SR
         xQIlhRk7yYcltn2CLe6LrBKmR1+TzCKg/Z8M4=
X-Forwarded-Encrypted: i=1; AKwUvBzTfk7dyVfOhfp8nlu1DMt1aC+Ox9AVPYyKlzJ9E4Mno5tHxRfejbd0ig6Y1pWVJAWKEiA6Bcw=@vger.kernel.org
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a424199bemr813209eec.37.1793311026653;
        Thu, 29 Oct 2026 14:57:06 -0700 (PDT)
X-Received: by 2002:a05:7301:618a:b0:351:68e8:4646 with SMTP id 5a478bee46e88-36a424199bemr813166eec.37.1793311025708;
        Thu, 29 Oct 2026 14:57:05 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm1845188eec.16.2026.10.29.14.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:57:04 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: log MOB limits outside the manager spinlock
Date: Thu, 29 Oct 2026 17:57:00 -0400
Message-ID: <20261029215700.3009996-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmw_gmrid_man_get_node reports MOB limit expansion and allocation
failures through vmw_host_printf while holding gman->lock. The helper
formats its messages with GFP_KERNEL allocations, which may sleep.

KDE startup and desktop mode changes can reach this path, producing
"BUG: sleeping function called from invalid context" from kvasprintf()
while the manager spinlock is held. That's likely a separate bug
because KDE shouldn't be using that much memory but to debug
that properly stop filling kernel logs with warnings.

Defer both host messages until after dropping the spinlock. Capture the
failed allocation's page limit and roll back its accounting while locked,
then report the error and free the resource after unlocking. Use
drm_warn for the guest messages so they identify the device.

Fixes: cfdc3458db8a ("drm/vmwgfx: Be a lot more flexible with MOB limits")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c | 55 ++++++++++++-------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
index d607452dff6a..cc580ce57797 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c
@@ -54,8 +54,11 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 				  const struct ttm_place *place,
 				  struct ttm_resource **res)
 {
+	struct vmw_private *vmw = vmw_priv_from_ttm(bo->bdev);
 	struct vmwgfx_gmrid_man *gman = to_gmrid_manager(man);
-	int id;
+	u32 max_gmr_pages = 0;
+	bool mob_overflow = false;
+	int id, ret = 0;
 
 	*res = kmalloc_obj(**res);
 	if (!*res)
@@ -85,43 +88,53 @@ static int vmw_gmrid_man_get_node(struct ttm_resource_manager *man,
 			const unsigned long max_graphics_pages = totalram_pages() / 2;
 			uint32_t new_max_pages = 0;
 
-			DRM_WARN("vmwgfx: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
-			vmw_host_printf("vmwgfx, warning: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
+			mob_overflow = true;
+			drm_warn(&vmw->drm,
+				 "vmwgfx: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
 
 			if (gman->max_gmr_pages > (max_graphics_pages / 2)) {
-				DRM_WARN("vmwgfx: guest requires more than half of RAM for graphics.\n");
+				drm_warn(&vmw->drm,
+					 "vmwgfx: guest requires more than half of RAM for graphics.\n");
 				new_max_pages = max_graphics_pages;
 			} else
 				new_max_pages = gman->max_gmr_pages * 2;
 			if (new_max_pages > gman->max_gmr_pages && new_max_pages >= gman->used_gmr_pages) {
-				DRM_WARN("vmwgfx: increasing guest mob limits to %u KiB.\n",
-					 ((new_max_pages) << (PAGE_SHIFT - 10)));
+				drm_warn(&vmw->drm,
+					 "vmwgfx: increasing guest mob limits to %u KiB.\n",
+					 new_max_pages << (PAGE_SHIFT - 10));
 
 				gman->max_gmr_pages = new_max_pages;
 			} else {
-				char buf[256];
-				snprintf(buf, sizeof(buf),
-					 "vmwgfx, error: guest graphics is out of memory (mob limit at: %u KiB).\n",
-					 ((gman->max_gmr_pages) << (PAGE_SHIFT - 10)));
-				vmw_host_printf(buf);
-				DRM_WARN("%s", buf);
-				goto nospace;
+				max_gmr_pages = gman->max_gmr_pages;
+				gman->used_gmr_pages -= PFN_UP((*res)->size);
+				ret = -ENOSPC;
+				goto out_unlock;
 			}
 		}
 	}
 
 	(*res)->start = id;
 
+out_unlock:
 	spin_unlock(&gman->lock);
-	return 0;
 
-nospace:
-	gman->used_gmr_pages -= PFN_UP((*res)->size);
-	spin_unlock(&gman->lock);
-	ida_free(&gman->gmr_ida, id);
-	ttm_resource_fini(man, *res);
-	kfree(*res);
-	return -ENOSPC;
+	/* Host logging allocates with GFP_KERNEL and must run unlocked. */
+	if (mob_overflow)
+		vmw_host_printf("%s",
+				"vmwgfx, warning: mob memory overflow. Consider increasing guest RAM and graphicsMemory.\n");
+	if (ret) {
+		char buf[256];
+
+		snprintf(buf, sizeof(buf),
+			 "vmwgfx, error: guest graphics is out of memory (mob limit at: %u KiB).\n",
+			 max_gmr_pages << (PAGE_SHIFT - 10));
+		vmw_host_printf("%s", buf);
+		drm_warn(&vmw->drm, "%s", buf);
+		ida_free(&gman->gmr_ida, id);
+		ttm_resource_fini(man, *res);
+		kfree(*res);
+	}
+	return ret;
 }
 
 static void vmw_gmrid_man_put_node(struct ttm_resource_manager *man,
-- 
2.53.0

