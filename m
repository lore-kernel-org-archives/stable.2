Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733E3451A7
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785987843; cv=none; b=VCAZyxf0njdLZtAm538Z4P80Qz77kB1mSOKB7em4ZF2VBJHLE9Fn6JBmAn+d9cdfBKHziuBWN0Ot9AD6AaFU5euOS1hlFG7o4x+kpEFZc6d3RczrLt3xRG9eg6yTaFfJeS57C9XCUYFi/uFhVrgw7iwk58Kklg9yHwb5Do8Lziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785987843; c=relaxed/simple;
	bh=cJZ3Vje4HEZlfXNGmqPQTktLjIS1LHADU62OzHj5EHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0w6f1gdcKIYa1PlGreWic1oCNIjqG5FEQSBvFckpW5i2QuDC+0T01FmIubOrL0ETbGK8bme6ORi2l9PNm4ulVMYqCBog+HIqO4qsmBvdnDkQ0RVHogk2+/JMlxPxfzP9tthVvyhzAD20gqn1sCUMOHyVzAMcKGLjuxBjN3nT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=IbzMC2b5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="IbzMC2b5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1441355a91.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785987842; x=1786592642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2jLtToL3PwaTAhWfeLF+tyVqbdrghdAzA8d8sJ1FHuA=;
        b=IbzMC2b5x7zpMtEEeqgKloJj0imYqdSMlgFYG29U9qB+L4FicVrCg8gzoRva+bvKbX
         36fnpso4rLGlHlsXbhcrdL6trP4DCnkPQEgJDPUWyMsrJ4EkNpHegVdn34xAldtlvSQC
         hE8u3oGzhZfB+DYqwK7m65xVQDOfBowYzzgWTq7seRB74vf7dqKmprRZ05Zg3bEkNRn4
         Vd6hUP3LB2/dmgmnaG6p8JP3A8r3l3pOPV1WZ+0jLU24rV/awu2tqvPh5ECz3F2HLbWo
         KdwnpP+ITuFdWCOMLaxA6A5wB60r2cyOgdhBX8CYv8QA6+GjVBTYH3BEkdALN8IUaJ/9
         8J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785987842; x=1786592642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jLtToL3PwaTAhWfeLF+tyVqbdrghdAzA8d8sJ1FHuA=;
        b=f1mc8X4Lpwep6S1eRszvdKEYaUd60It1cWCZxU2L8KNoOMHFfqmatjzbKTSH5AaWV6
         FjWX8qFkTGxGSVBNa/VGM6rJFYvFTVEm9NZiWRnR4Y3PQf2djZJGIIhQ4BvZ6nIlfOgi
         xUkSt9/7LFkFOv9dZRia9PuscoEa/1BVJlM+OE1YCxmK0oD8i3T9WI6isx1jEl1zne34
         +xr23vqbaYz7Lz/rL4giIPka3DW7M/i1S7n6m1XSsOQhgKiYR0ZWY9siWsQmn3k/s8d4
         wwHSKezb4I/Vdy/ssL0gJ0TO88HPyGEiLWHWEHtmiIqETz9gf5bRmZvsuTCLPL+sBhQS
         BwyA==
X-Forwarded-Encrypted: i=1; AHgh+RomYCTDgZQtXhrRoR4umtYQYqsuaPXU/SBxF190L6Vf90YepND543U6O96CE0NATlhBykcnSWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFc/W1cswdL/o5Ye3ublkBs6acHW6VCTMZqxAX/DGYjQdgZ6KW
	NztVpmODJOwDEFwpB9H/dftet3RgfHvKdHuPM7bAVPXvr6GmQHE06LAJC0E7rXCR9R8=
X-Gm-Gg: AR+sD12l6dbn+UhiPfSJHeEib5VPMuy8eG26mFTlZMt9PCW4p5S7ahSLYFECDS+y12z
	S4+/x9zbHR4kev+zSFQXhypQggH3dO633VbdQ/BoR4POIFXuUp48He/GYZkIWh/R5xeu0EL55HE
	+YjgIXzyj0nrfF65he9erS4Abt/vG3TZEkR+pkY8DSyDpkLco2Q6PznLOYjSPrTqjSp6POvW53V
	eiebUE3JMLEKnWYWtiuXDXSL5/yXnrc6RI3l5cY524fpPdkzVV5DIBXIW7w8MNiQAgDzCNhMdtn
	9W/kZHby689YEidcnwkitOTbd88mciJ9Eq0aTA49FL4Lt691L+WQJiKbUJHecMP+zS+RasV3Xeo
	cn0nQmzBGSnda9E4nnKya0EAhh6PL9b8S44BNCk6jDLKQxR2FZH38uHfEtJlu0IuSSiEtn2Ih35
	ZfXN2/mQxUX91g+SFz2tyZRFwsQd7lywEUnAQckthyG41SDseX+S56dIp40bp9dYkxtouEYJMp6
	mI1tHeX+aC90qcUaYME6nj2hhEO
X-Received: by 2002:a17:90b:2d50:b0:38f:1f8:1fa with SMTP id 98e67ed59e1d1-3903c5ca8c2mr12349041a91.15.1785987841775;
        Wed, 05 Aug 2026 20:44:01 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2c714sm569978a91.10.2026.08.05.20.43.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 20:44:01 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: christian.koenig@amd.com,
	ray.huang@amd.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: matthew.auld@intel.com,
	matthew.brost@intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/ttm: clamp the prefault window to the buffer object
Date: Thu,  6 Aug 2026 12:43:56 +0900
Message-ID: <20260806034356.43681-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ttm_bo_vm_fault_reserved() derives two page indices from the caller's
mmap(2) arguments and bounds only one of them:

	page_offset = ((address - vma->vm_start) >> PAGE_SHIFT) +
		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
	page_last = vma_pages(vma) + vma->vm_pgoff -
		drm_vma_node_start(&bo->base.vma_node);

	if (unlikely(page_offset >= PFN_UP(bo->base.size)))
		return VM_FAULT_SIGBUS;

bo->base.size appears once in the function, bounding page_offset on
entry.  page_last comes straight from vma_pages(vma) and is the loop
terminator:

	if (unlikely(++page_offset >= page_last))
		break;

so the object size never bounds it.  For an object of N pages, a fault
on the last in-object page passes the entry test with page_offset
N - 1, and the prefault loop then walks N..N+14, reading
ttm->pages[page_offset] or
ttm_bo_io_mem_pfn(bo, page_offset) and installing each frame with
vmf_insert_pfn_prot().

page_last exceeds the object whenever the VMA is longer than it.
drm_gem_mmap_obj() rejects that on the DRM node, but the fbdev path
reaches the object function through drm_gem_prime_mmap(), which does
not.  It is also exceeded by a mapping no longer than the object taken
at a nonzero file offset, so the handler needs its own bound.

With a 128-page object mapped 192 pages long, one read fault at index
N - 1 leaves the fifteen frames after the object readable through the
mapping; on a fresh mapping, reading index N without first faulting
N - 1 is SIGBUS.  For a system-memory placement the page array is
over-read as well:

  BUG: KASAN: slab-out-of-bounds in ttm_bo_vm_fault_reserved+0x248/0x57c
  Read of size 8 at addr ffff0000078aac00 by task e1/219
   __asan_load8+0x84/0xb0
   ttm_bo_vm_fault_reserved+0x248/0x57c
   ttm_bo_vm_fault+0xe4/0x140
   __do_fault+0x6c/0x2f0

Clamp page_last to the object.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..14ebf6ee3c47 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -212,6 +212,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
 	page_last = vma_pages(vma) + vma->vm_pgoff -
 		drm_vma_node_start(&bo->base.vma_node);
+	page_last = min_t(unsigned long, page_last, PFN_UP(bo->base.size));
 
 	if (unlikely(page_offset >= PFN_UP(bo->base.size)))
 		return VM_FAULT_SIGBUS;
-- 
2.50.1 (Apple Git-155)
