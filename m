Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F431960B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857582; cv=none; b=UJ41SuQta1O/N+33lPBzh5me6lLUSIjDJBcmfcp1hIrdwcaUntBXPOTgre+jH1M6tbxpGYP4AHbPreNX6rGBX8Nw/33nwLHPqlshDW+iO8xufpCWBMm8QtLKjf7/UH38T734b94OshiEqLM4muwv9RW4IMYOr6Ya+a05X206XzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857582; c=relaxed/simple;
	bh=ISGoxkb0uMTtloHIIQl13lAb+eAHI6nVD1FKbzcjAZo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TbYHV4ZfCSC5HJLIardbdKSM4u6+Jc+e4cnJCoq2wgs1p19cgdMQHAug1F+oHkQvWeN1UeMkbS7vqabYWRtPLXsT2FOM6cup7EWmPCiTaGNQxyOItL45reMB7tQdbCf0TPElR77TXqckGvBBQ0KznBwdzqfwkgigdWVysDclJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JN96ldF/; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JN96ldF/"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so1339342a91.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784857578; x=1785462378; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+1WbU2W0Xow25CzRoAw91vdRYKBdi1C3Nbcp/adKJ8=;
        b=JN96ldF/mqGFVokc/tdJ/CU65UjMaTQtc46FhYxy2n15+9kltNcLKRlTbJw9S3mkC1
         FthayFp0jd1y1M+LzuDYU0WmCWBFUygRi28Vj/1ZQHYhFmmmUTxy4z2hAUGfBL6ZpYmO
         hd19ECZiGA7bl6bg+oB042u+d9un65KoBbjXbY5J0cX3c8ZCcgTyOhf0NUQqt9svb+vp
         9rc/8VvP2oSHCi80ZpvR3iSCsrsgloMpZGpmKycLBdZzrNGl4fV+RLVCdAe8zBYCfzzp
         625lGQ4dtaEZJJdA8ZF3I78Cz1I8Q0OvHjhbCYcp9Ci6fO9nST3cz9A1cN4BZijwTCRM
         zqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784857578; x=1785462378;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+1WbU2W0Xow25CzRoAw91vdRYKBdi1C3Nbcp/adKJ8=;
        b=i6pNtqNNjvaVCYjiyEQXkY+2OpahOrHpPOOOKHeBMJnFItXe430WrB5dRgHTJ9wPyl
         MR2SLV9duvW0LJ9oxv1dgdjHiUUz6QutWF0QmwWEcibAI0s8JlBrzSKGkKTC4jj1PqDU
         0UjXK75u5Awnfva3AarppyWU03q30Qv33ZeAiT3pV8L326zYQ15cRsOcarsyKd0B9gRv
         TMPm72AMz1Y60OlAJiiH9pFec6+OecWqHBCMEFXmRffa6LN9oODUoJv/YxtL2qjXvdvT
         nDJvx5ytopYVBf973/Kmex9r5d4YAnKxv1RXjkzUD81PYnetG6JGMvwv0RvcN/2Vzj4A
         BVJg==
X-Forwarded-Encrypted: i=1; AHgh+RrMgHQFiHvfC7vcQ2jZWE/4JVP/oBPPQEBYT8w2rUn608WRJN6dbvp+e1TATMXhc1TXpo8vyyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4/Mu6/Dg0k4poWV4ha4CdFKdJjNSMqBPT2WZWW7jAsd/NPMl
	6mf8rvNG4f0z6hHXf9SnJbLl/WPpxZf2TMTHHTiP9VV0KRlgdpdGstJc0/29yqHniOmcG/qumaz
	ORA==
X-Received: from pjbbo4.prod.google.com ([2002:a17:90b:904:b0:381:1d7f:b8db])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cb:b0:38e:69f8:cc49
 with SMTP id 98e67ed59e1d1-38ec65e374fmr5127138a91.40.1784857577957; Thu, 23
 Jul 2026 18:46:17 -0700 (PDT)
Date: Fri, 24 Jul 2026 01:46:05 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724014605.3377283-1-linkl@google.com>
Subject: [RFC PATCH] virtio_balloon: add VIRTIO_BALLOON_F_REPORTING_PM_SAFE
 feature bit
From: Link Lin <linkl@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Cory Maccarrone <maccarro@google.com>, 
	Taylor Scanlon <tayy@google.com>, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"

Following up on the fix for the PM suspend Use-After-Free race condition in
mm/page_reporting (merged in mm-hotfixes-unstable: 
https://lore.kernel.org/all/20260723003650.CAAF01F000E9@smtp.kernel.org/), 
we face a hypervisor-side deployment dilemma.

Cloud hypervisors want to safely enable the Free Page Reporting (FPR) 
virtqueue across their fleets, but enabling it indiscriminately on guests 
without the recent suspend fix exposes them to UAF crashes. Relying on 
out-of-band metadata (e.g., OS image tags) to selectively enable the 
feature is fragile for custom user images or live-patched kernels.

To address this at the protocol level, we propose adding a new feature bit 
to the Virtio Specification: 
VIRTIO_BALLOON_F_REPORTING_PM_SAFE (Bit 6)

This establishes a formal device lifecycle contract for power management:
If negotiated, the driver MUST guarantee that all page reporting operations
are halted and pending requests are flushed before the device/system
transitions into a suspended state (e.g., ACPI S3/S4).

Deployment semantics:
- Hypervisors operating in a strict "safe mode" can offer Bit 6 exclusively 
  (suppressing Bit 5 / VIRTIO_BALLOON_F_REPORTING).
- Older, unpatched Linux guests will see Bit 5 is absent, ignore Bit 6, and 
  safely skip FPR initialization, preventing the suspend crash. Standard
  ballooning remains 100% functional.
- Patched Linux guests will recognize Bit 6 and safely initialize FPR.
- Note for fleet deployments: Non-Linux guests (e.g., Windows, FreeBSD) 
  that rely on Bit 5 will temporarily lose FPR if the hypervisor exclusively 
  offers Bit 6. This is considered an acceptable trade-off to globally 
  protect unpatched guests without relying on OS image tags, until those 
  respective virtio drivers adopt Bit 6.

Implementation Note on Upstream/Downstream Dependencies:
--------------------------------------------------------
Because it is critical that downstream Linux distros do not accidentally 
backport Bit 6 without the core MM UAF fix, the final upstream 
implementation of this patch will enforce a strict compile-time dependency. 
We plan to export a macro (e.g., PAGE_REPORTING_HAS_FREEZABLE_WQ) from the 
core MM fix, and wrap Bit 6 behind an #ifdef of that macro in 
virtio_balloon.c. This guarantees that compiler backports must consume the 
entire dependency chain to advertise the feature.

Below is the proposed Linux proof-of-concept based on upstream master. We 
introduce a helper virtio_balloon_has_reporting() to ensure virtqueues are 
properly allocated, torn down, and validated if either bit is negotiated.

If this architectural approach is acceptable for cloud deployments, we will 
formally submit this patch and open a corresponding issue for the OASIS 
Virtio specification.

Depends-on: <Message-ID: 20260723003650.CAAF01F000E9@smtp.kernel.org>
Signed-off-by: Link Lin <linkl@google.com>
---
 drivers/virtio/virtio_balloon.c     | 15 +++++++++++----
 include/uapi/linux/virtio_balloon.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 581ac799d9..00e8273dc3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -39,6 +39,12 @@
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
 #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
 
+static inline bool virtio_balloon_has_reporting(struct virtio_device *vdev)
+{
+	return virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING) ||
+	       virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING_PM_SAFE);
+}
+
 enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_INFLATE,
 	VIRTIO_BALLOON_VQ_DEFLATE,
@@ -598,7 +604,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "free_page_vq";
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
+	if (virtio_balloon_has_reporting(vb->vdev)) {
 		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].name = "reporting_vq";
 		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
 	}
@@ -635,7 +641,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_balloon_has_reporting(vb->vdev))
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
 
 	return 0;
@@ -1013,7 +1019,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	}
 
 	vb->pr_dev_info.report = virtballoon_free_page_report;
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
+	if (virtio_balloon_has_reporting(vb->vdev)) {
 		unsigned int capacity;
 
 		capacity = virtqueue_get_vring_size(vb->reporting_vq);
@@ -1099,7 +1105,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_balloon_has_reporting(vb->vdev))
 		page_reporting_unregister(&vb->pr_dev_info);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
@@ -1162,8 +1168,10 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	 */
 	if (!want_init_on_free() && !page_poisoning_enabled_static())
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
-	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
+	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING_PM_SAFE);
+	}
 
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
@@ -1176,6 +1184,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_REPORTING_PM_SAFE,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ee35a37280..d206f156d6 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_REPORTING_PM_SAFE	6 /* PM-safe page reporting */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
--
