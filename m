Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622177;
	b=i3oVD5rZ1XoCXq/jfrbFki9cCplHbTVJefq/mM3RnJ0yGKDFJfHz6FuykWshaWQFwxVJ
	 wlDxzSwq1eVOYjs2rGljs1Mnb6LHkdaagyQp1G2MGiRNhP6UxdNq2KKtB8nMNqvyovRLk
	 qk101k3gTqr7YP9+UttuTnaayUES0oeIzD6Vl63aVMYqMYO898CdvDSODeTA0VtHpTKIR
	 Xld85s67rLm0zgx5IgFDcp4aFOsd0VMMnf7U86CcMPymTkHoOmQ67KGMOHvjdblVnTA2U
	 0lLh4RFpClFzFcHlrfrQrsI+KMzlkJXrd1ewVgbmt3oxU7RHtbe1nUbLnjyueoF3tWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=abibISRiUwSvMFecqGaDadoCAJ+Fmjo80Pp9RI6LfO8=;
	b=ATXnVhQ7hTv+pxGHPwyfcnjQ6aOWt8vQiPazZt2G6xLw9obgXD0+GusYPY3uekCv76np
	 V+EJE5QlsXpVyssHJbJ005dIf+82NUuD1tfAYN6puaAW6A1//xqA+krg+BXsvMfllmXak
	 C33UV9NBCh55cOK9ZGWaHR6E5gw2s4HdrupWPtROG/QUgDc3asUk2QF+dU8PPL77Sessa
	 m3NhAheg313EqTfOuG1RxXr9UhCKpu7KszbagYzzC3VIzTXe4exuCJQE9eMiyo4WUC4il
	 xPA+zoHyJNOUw3JCQUPzb07l2FiVp6p34YQW5zrClFfG+OylcgNBczYZXvnXAV2OfSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ewVK5FsW;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECDD60A3809
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EECDD60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ewVK5FsW
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so25728295e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622175; x=1794226975; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=abibISRiUwSvMFecqGaDadoCAJ+Fmjo80Pp9RI6LfO8=;
        b=ewVK5FsWNqs67XMFEWCR81dLwkdrViWaR1Mpa9sViu6UqFO7qZb8ZIKdPkTqiyR1ll
         AmsdzeWBsRHeyVELcdHZ4+FLGKGrb3JbHEj/Zw+oygRFTpSjz5c+a29ARFitt2XTtMVU
         l0bzH3XiH0K1MaeKOuvjPlO6SRzzr/f9Slsvg/yYo1uvqaaNK6wnNdJMGsViwgk7hnGS
         FAKFE0zKQom/9NcpMpWgYX8xy4vW2BfKkLa65iZhIqotW/ArrhwfMadqBG5IwFXHAXQY
         s3fEUFM8+sGRlAu+tfJfI20Cs8CLCjLCJJArM/cd3tAmC3IitCnbc8fj3vqlUFf9+XCr
         HSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622175; x=1794226975;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=abibISRiUwSvMFecqGaDadoCAJ+Fmjo80Pp9RI6LfO8=;
        b=ZPyjijE3YZKSgTStNVDYArMS1ziOvHbti6CT2mRLG3XeEy0OFSKpG5hasCq/kuXusS
         gMYEs5LfJNEtgX9J1Db7BIN9naYerfmQA4ttzvtpujC8N0QV1fn3FmRLpLq+8IpzjzlD
         369musfB/L3JavQZJSOCN0X5jM5kSO22cP2u7UE/YyUyEy4BykBi4ArytWPLy8d67y/x
         TgkdkwUp3ii/T/UJlJcux+8By355M9A7sbmJBFZaZgEUk1drCSwIBtqEPCH6blujVVAC
         WOO1hvl3zf3jV9k6MuHCKhy/3OEAxEYwKByI/sjcpDaGzDHNDR5fJLl4slmIPgSDC6+a
         2HqQ==
X-Forwarded-Encrypted: i=1; AKwUvByx09hJy9o2PLxB4lM/XrXHuPxK2R634Zuqm9mq/Ogi/KerN0Mn7G8a2Z/7nzbSSsww1t/RNSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLF/rYsePHqNoETqCFocM6STAHUY2/5dfk5KfhRY68zkUGqzImt
	NA4dJPk/qg0Qu/a62bl8H3DbbKXUNeMT2NT3f0JmTYryob106FmTMgEn
X-Gm-Gg: AYBFou1NzJJ0M6KDTs69+uGve+q8q01er0r3Yoxij8iqfLMhVdWZeXuhv0H3oU8rwHx
	YLgfEt/1Sm9PNhH9nM8T38oHu3TOOZ5wcImRGq2dRGZye31d70qg1I1pI8jLnNVsWaqrUrY7ay5
	BvlktG38DnyxBKaFgbIq7iSMWnvzW9DOBS+Z/pFmmCrVFxgwQYfR0TUz7S+fvotnWs6de9M2Z5N
	JMtVUUBVUlG0aFP6jZ3PbNS0TeDjMS/VdbVoKxxJo+Tp4Qez0he8sCB2gA+6D/XU/sCcKVEwLtt
	WYY5/YxUjnNRe3svWGm5Mz/KA86fSoUfSi5voXjT+cHXjU10rWDTx33Wuj2YagHuSYqe44C/tnd
	kxgzycjPDUwpI+feHE9al8TdySicSctgeIy/PhVMg6QnfmRUB3yaEl7vcqkNN1u3s0Zia4y9frZ
	r1RS3ST3nXtNkijhF0EjLD+IqtdZAlraD/BBdqTHkfbA8memE1LKwOjI2HLz1CKofI555YfxS3x
	sC8JWpFc0ZTzOJCBh575HmQ5LTsx++wAzIL+JcRMVKohDF5FDYQcgXc8U06T+pfZw0Qdf0cr7t6
	XA2JRTeyhIJhUYlbv4ocyiW5rHa51WIKewG9dBm5zmVX1Uyh+WfClz2HVODLlRpSBptitRnazzL
	+u049UDjdevY0/PvP3lXNnWj+JyUwSoKR6FVi0LyemgeJP8e2eVQ5
X-Received: by 2002:a05:600c:46c8:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4ac16acfde1mr240738005e9.6.1793622175008;
        Mon, 02 Nov 2026 04:22:55 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at. [80.108.121.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm20361252f8f.30.2026.11.02.04.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:22:54 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 02 Nov 2026 13:22:51 +0100
Subject: [PATCH] drm/etnaviv: Cycle through the MMUv1 address space again
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-etna-mmuv1-iova-cycle-v1-1-1148f02da254@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNphg5eRRxKTTWgVVotinh3i
 +Mb/n8gS1LJ0DUPJCmadYsVpm3Azy5OgjpWAxNbY4hRjuhwXc9iULfi0N9+EeTgSSwTBWehtnu
 SoNf/7Yf3/QBCPcBNZwAAAA==
X-Change-ID: 20261102-etna-mmuv1-iova-cycle-2fc0e6200fa6
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

From: Christian Gmeiner <cgmeiner@igalia.com>

On MMUv1, all clients share one address space and the allocator
always picks the lowest free IOVA. When a process frees a range,
it can immediately be reused by another process.

The GL.FLUSH_MMU write before the next submit does not reliably
invalidate stale TLB entries for that range. The GPU may therefore
continue translating accesses to the old pages. Writes through
these stale entries are lost for the new owner and may corrupt
memory that has already been freed.

The vendor driver works around this in a similar way. It does not
return freed MMUv1 ranges to its free list until the address space
is exhausted.

Restore the address space cycling for MMUv1 that was previously
removed as no longer needed. Start searching after the last
allocation and only wrap around to the beginning before trying
to evict existing mappings. This keeps freed ranges in the
allocator but delays their reuse until the search wraps around.

MMUv2 has a proper TLB flush and keeps the current behavior.

Fixes: ccae45928fc4 ("drm/etnaviv: remove cycling through MMU address space")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index e3572461b599..c4e4dd3d4235 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -141,10 +141,20 @@ static int etnaviv_iommu_find_iova(struct etnaviv_iommu_context *context,
 {
 	struct etnaviv_vram_mapping *free = NULL;
 	enum drm_mm_insert_mode mode = DRM_MM_INSERT_LOW;
+	u64 start = 0;
 	int ret;
 
 	lockdep_assert_held(&context->lock);
 
+	/*
+	 * MMUv1 does not reliably drop stale TLB entries on a flush, so a
+	 * freed IOVA that is handed out again right away can still be
+	 * translated to the old pages. Cycle through the address space so
+	 * recently freed IOVAs are only reused once the search wraps around.
+	 */
+	if (context->global->version == ETNAVIV_IOMMU_V1)
+		start = context->last_iova;
+
 	while (1) {
 		struct etnaviv_vram_mapping *m, *n;
 		struct drm_mm_scan scan;
@@ -152,10 +162,16 @@ static int etnaviv_iommu_find_iova(struct etnaviv_iommu_context *context,
 		bool found;
 
 		ret = drm_mm_insert_node_in_range(&context->mm, node,
-						  size, 0, 0, 0, U64_MAX, mode);
+						  size, 0, 0, start, U64_MAX, mode);
 		if (ret != -ENOSPC)
 			break;
 
+		/* Retry from the start of the address space before evicting. */
+		if (start) {
+			start = 0;
+			continue;
+		}
+
 		/* Try to retire some entries */
 		drm_mm_scan_init(&scan, &context->mm, size, 0, 0, mode);
 
@@ -215,6 +231,9 @@ static int etnaviv_iommu_find_iova(struct etnaviv_iommu_context *context,
 		 */
 	}
 
+	if (!ret && context->global->version == ETNAVIV_IOMMU_V1)
+		context->last_iova = node->start + node->size;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
index 7f8ac0178547..7fa6e3ab427a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
@@ -75,6 +75,7 @@ struct etnaviv_iommu_context {
 	struct list_head mappings;
 	struct drm_mm mm;
 	unsigned int flush_seq;
+	u64 last_iova;
 
 	/* Not part of the context, but needs to have the same lifetime */
 	struct etnaviv_vram_mapping cmdbuf_mapping;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-etna-mmuv1-iova-cycle-2fc0e6200fa6

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

