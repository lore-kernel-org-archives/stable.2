Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94634388F
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785987830; cv=none; b=pVtRwG20o0jyQs+SZK/OSh+BxQfHvb3U6O9lHSQFP6bch0Apr6oYt+jX2epQczGCbgQTTIaxmh5O5/KJzjHmNUPNSQ4AAbnymls3BxVZcU+KxAh2mWr1wCWd6f+heI9JFe/Th3VykMB6GkYGAT5Id88zFiANgU925Bbn/6e8ZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785987830; c=relaxed/simple;
	bh=fchfvWlsIct0g9r2ClTetOkTbO2pVjS6YDYc7Pca2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oY357NklCcR6YdoAb4yYlzKcOQPhWc2EdwgZ5C+muTd91i6yUTH/H/GFFiJhgx65mok5nkG2x0FhCiwohBnmjwpieJ0rGRcAy0ohBIgJF1d/AntgMV7PoX7Kvxy2+D1AGbACMskyYQJilie+sSp/h7mNnG8Z5KATRtzPvZB+3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=i6E7RNMD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="i6E7RNMD"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf50c6f235so21555195ad.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 20:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785987829; x=1786592629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lB3t5AM9S8rNfa8MkksIa6QuMH30IsZNuofW0zacyos=;
        b=i6E7RNMDkh+XfN0jEtx0WjXjx7y+1Hu5h6gPr03mjOWbuhJr0XNQdtvy6/OLUGAHHK
         vEjzqOonq+HD4tmetzMfR3rlITp5QMhxFHfNR7zhsbBUbgu6Z1O2j69PNJzs0EbxWM04
         U+3YaIy2ngdKsI+hZBnHF3JUZr/fgc0B/DuDNoXwBTW0cUI4ZzhBzSBqaOyIZaC0czRz
         NiFzHRLvgWTB8O73PdtkoAIewPfBb9C7IcxLlu1c7u2GlDk5B2p7Binf5IQzRfzaBPKH
         rrIB+QrH59H4LhMbFdWcr34Tiwe5V+9q64lBvhhbEXQ80xrjCoeY4T4I83nZddiIr8x1
         u7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785987829; x=1786592629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lB3t5AM9S8rNfa8MkksIa6QuMH30IsZNuofW0zacyos=;
        b=jCuGoXSNN97oLjJT4wsgQHCMFKFB4itqMyLC68EzjqDK8Vh3Msy5w+H9kep73qRBzo
         PAsXQz60e/lARt4Yze1W5GFFtvGi1tpWslBopEZp+6hU/IPEBUS4vUWVc4KY4A0MA32U
         NcfQuxM0U2GTUDL8EPIOWAB5vE+Ew9nO9BPSKQvCaJAY6CQuaMYpYRmqNqAd5deYPq1h
         ohiifu+cqvmrDiXqJJsB8DDm9hP7Jj4rJAQanrcC+Pg/fICYmwLKJJSRLhDafXuyw59O
         dM49qlF5j+XIhk89OETAN4EDNiDJ9eJOdT+tkXyBoIigT+ssv2uDeqlWL/86vY/uiqD2
         lEpA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1bk6bnrNugqBVzgW2qJ0wPlN6N+ckxRAYCSPADIdQR7eeVTvakpIQ4dc8W6rXt5dYvMQDFXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0OMo2mVOjBqmbO9uVl3pL0A7Wtwd2jWvrcG+L6HFRSgH1lZS
	xwcLN/jONYq3gg9/SoLrvF5ZnkbVOo45OUcrRNB48i34n5Zu0fQ5GcycDxcBD9OGDa4=
X-Gm-Gg: AR+sD10ldgxu+YTGp2R8n1hQzSAjaOz4lx8o07+B9B40u1FMbeMLkkwJmXlqIFbm1oL
	qBU/s9Mw2Bxi115xO3z4HXEVlN9SESBA9kR2ypsp5w/EQ9ZMYSaqaLDhmY7In39kz/hJUlMpXpm
	kchMdT+R8ZnwDI/3/hwY4NjDqvzLoU371Gx6lpozbouZqGPxPD4p6nnX7TZcrAB4InlbpFdsiWy
	A60P2VoJk6zsJVIHeZnnW+fh3FGStSSCe2RYM+TlWcD2he5rjEDGU6qla5i1X0XsaTPZym2/YZc
	RVFLIeBMjhbkvSL5itMcJlorFJGFiUoaxjlPK3kQnTUC7viZRnc14veMe6Nsh7gZqIUEzdIUv3r
	LgCEi7p5fg4n/9dyT2QA10mMxRbqWAUb2EoKpbytE9/RD3MtO8kR5lZA5RAacTO188G/vNPCLwy
	CgGRLDeVG/NTvvRxvQNyLHjGBj5JrUcvA1DU0ZK2H4RnfRBAyxc6bVPI862o4fUMW/ZCb8HeeIL
	U5GuWjnEJcRjwkPWOTuEgGrRO5k
X-Received: by 2002:a17:902:e94c:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2d0ca7b5520mr151674245ad.8.1785987828619;
        Wed, 05 Aug 2026 20:43:48 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c911esm23899715ad.66.2026.08.05.20.43.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 20:43:48 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/gma500: bound the fbdev fault loop to the framebuffer
Date: Thu,  6 Aug 2026 12:43:43 +0900
Message-ID: <20260806034343.43629-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psb_fbdev_vm_fault() maps as many frames as the caller asked for:

	unsigned long pfn = info->fix.smem_start >> PAGE_SHIFT;
	unsigned long page_num = vma_pages(vma);

	for (i = 0; i < page_num; ++i) {
		err = vmf_insert_mixed(vma, address, pfn);
		...
		address += PAGE_SIZE;
		++pfn;
	}

The trip count is the VMA length and the pfn walks up from the
framebuffer base.  info->fix.smem_len, the extent of the framebuffer, is
not read anywhere in the handler, so a mapping longer than the
framebuffer installs present PTEs for the physical frames above it.

Nothing else on the path bounds the length.  psb_fbdev_fb_mmap() only
requires vm_pgoff to be zero, and fb_mmap() passes the length through.

On x86_64 an unprivileged process in group video mapped 4800 pages of a
600-page framebuffer; every page was present and writable, and the 4200
past the object were the frames above it in physical memory.  Nothing is
logged: the kernel installs valid PTEs and every access through them
comes from userspace.

Reject a fault whose page offset is already past the framebuffer and
clamp the loop to the frames the framebuffer owns.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 0867b42113ec ("staging: gma500: Intel GMA500 staging driver")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/gma500/fbdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index d1e93588234f..393a939a0c37 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -26,9 +26,15 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	unsigned long address = vmf->address - (vmf->pgoff << PAGE_SHIFT);
 	unsigned long pfn = info->fix.smem_start >> PAGE_SHIFT;
 	vm_fault_t err = VM_FAULT_SIGBUS;
+	unsigned long obj_pages = info->fix.smem_len >> PAGE_SHIFT;
 	unsigned long page_num = vma_pages(vma);
 	unsigned long i;
 
+	if (vmf->pgoff >= obj_pages)
+		return VM_FAULT_SIGBUS;
+	if (page_num > obj_pages)
+		page_num = obj_pages;
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-- 
2.50.1 (Apple Git-155)
