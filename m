Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE52BEC5F
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290838; cv=none; b=ApMOjn4Ts7Bn/vz3yIELmRlsfAWWiM/fCe9HG4q/vLGwGA4HAtv+0JIMNBl9JVLDkYbK4aupQHFwgQljmE1M9RFezyE3O1+WDRBGZh8Cik2vlu+KnNFJyS8zxX8wOiJ0vhFhy0nQyrxJPFh4JjSTHhbiAA7xpqb1Vj0y2EdW/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290838; c=relaxed/simple;
	bh=ZfxlxtmL3f3PRGLmnA/UFU+0uUoCd85J9y/mFCt9dxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tF+7hhdS11u+UHk6B7R7dW29Fp9qzl4gue11ht6r/nHlGI7HrsCF//zqkdWsvW7R08RLcR1mqWs/AZzde7VcHYvaKzC5BfHfAE46s2GXDl6uIKfjCpDCyKDOeeitNvUqsacv4nIb9jalw3hBGpYn4W89u2T1P/pZdEVX6eOdUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CMtqfJvy; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CMtqfJvy"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-918f75a68f0so16910896d6.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792290836; x=1792895636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeSnSeSZP+b+6MzP6ewtTRyYSL3RxjlUFlHftt5R+jo=;
        b=CMtqfJvy46Fu1j6MExudMxmUp2GT2OE0bSguoLYv0MphSj/eGgo4ZYP0maOHYiCUkS
         AZVbUzj3tcQV750AeRXlEW0QcZrJ338gskkoSkSGRyy0gMjUjpIQS4VWHNtubpooxxNF
         YZiUT0ArxEvSiF829KEyXk68lukAz074kX/pk0Rsbfd4QsCmTTmD9ePZj7XU4nxaGd6M
         E23oEB2HiI6SEgO9LMGHRRGgMBCwkZXfvQESz3s/lopaT20RG1EHev2MIpz5OJ6hpY3O
         M0Bbnp30gTq8OP7d+m/viHwNICNIJk5t77IJLCueY08jgYiB889sfDEtodLMGBXJNg78
         hHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792290836; x=1792895636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeSnSeSZP+b+6MzP6ewtTRyYSL3RxjlUFlHftt5R+jo=;
        b=x/wmCOkOBjyjgVA/iXXJRMSTOVn0JWqm7tUjZSgUeg1FJ3jhZn7dP7PiJTEmHtswz1
         nf+6xE/XW69wYJroX4C163jqYhgmgq0uRQY7REPadfanIPTjs2trCPSbCHLAG7SuMGvV
         uEHBg3Q7r7nr2Px07cZSBSG/UGe3jTF16Xe8/hpE5r1hIhoJo5kJizmvvW5ofpnTnFFe
         9PD/3bSDdXxPn0zz9CxsjekAgskXi1tQlpziLczwJtdYxgYjbuAjT+2uRi/yil+EB99Z
         fXrmvJhPO4sVdZQlKWFVyhdEkNcCk/47Y2652+uJHrWti7g2Q7fS8Ds9l7e0P5KBTldI
         wlTg==
X-Forwarded-Encrypted: i=1; AKwUvBx0AjSFKGveZQV82cxSzfREVGkQ17KiWkWz8ZLT63unwiFAUIXNsBRHfnsgUXhx0Iw2GLwPSKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8bhMztqvI5xwehDIpAGKQdj7klImD8mT3MLAuizVR9aOOkCmD
	JT2yjmIL+ad8OHzUnP/ofYZmiY63mVXJzv7+jbYxK7dIL886rQtI+F9CyuSJoMfsz9g=
X-Gm-Gg: AYBFou0LenGmKhuUAqo1VwNC4fIyZHDMaur3733Fofk4edSeD62G2KCB7U0YoZRUL8a
	Skri4A0DQh8LOv+BRXYt7HFRTjGOwBcUExp42ImRNUznNTJpyta9j7cFqKkBMBU80hbUM/2CpQa
	xRysL7sDpWtKpylIW9UPHhB9KokZq2MLZGsP7eeCftojdNkxLeCKlDlD6DxQ7x+75WQxY6fBJAb
	Q5XnRBcHKnHwXgF6fZpiP/PNqduIRvK6pkJhwcfCI7QXo/hWK4UoCkZPYOqDHttP3L9deKUD6Fs
	mZ8gPzjS5qcqMbjTS0Rqtrr05FXWUS1NXxrAMvOdzHpeWDd9tLwyg/vXraSQvbbX9Oiurndt0bD
	+1BqcUhHg7Pd7OXiWx2JuuIqfrcnc/DgZ66mLaUM+H3NfWwtZ3GHW9ErAFSj5aRNaaHk+e/I1aF
	JyRa8YvVKZAYIC2tpoUl+IJlIqxllNJycwm2YMuJh4tWoI7kBvAbpYr2nosq7xWmH+zhiU93T8f
	A50aUsNNPOeNwaw2f3DFd24QsTleClJ+BAoCAuhTZ7zjeIIQfUD1ImJlbGg
X-Received: by 2002:a05:6214:2a4d:b0:91b:5d39:e13f with SMTP id 6a1803df08f44-91bdf517971mr74943116d6.52.1792290835889;
        Sat, 17 Oct 2026 19:33:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba473easm61705926d6.17.2026.10.17.19.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:33:55 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	pasha.tatashin@soleen.com,
	mhocko@suse.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/mempolicy: apply bind policies against the scoped allocation zone
Date: Sat, 17 Oct 2026 22:33:49 -0400
Message-ID: <20261018023349.1697434-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QEMU fails to start a guest with a VFIO device when guest RAM comes
from a memory backend bound to a movable-only node:

  vfio_container_dma_map(0x55b1b1317800, 0x0, 0x10000000,
                         0x7f39a2200000)
    = -12 (Cannot allocate memory)

VFIO pins guest RAM when the device is realized, and the pin faults
the pages in. io_uring fixed buffers fail the same way. Faulting the
range in before pinning lets the same pin succeed, since resident
pages are migrated off the node instead.

A long-term pin faults under memalloc_pin_save(). PF_MEMALLOC_PIN makes
current_gfp_context() clear __GFP_MOVABLE, but policy_nodemask() tests
apply_policy_zone() against the caller's gfp.

The bind keeps its movable-only nodemask, and the allocation finds no
usable zone:

  page allocation failure:
      order:0,
      mode:0x140dc2(GFP_HIGHUSER|__GFP_ZERO|__GFP_COMP),
      nodemask=1,cpuset=/,mems_allowed=0-1

  Call Trace:
   warn_alloc+0x136/0x150
   __alloc_frozen_pages_noprof+0xed8/0x1720
   alloc_pages_mpol+0xaa/0x170
   vma_alloc_folio_noprof+0x65/0xd0
   __handle_mm_fault+0x137b/0x1ac0
   handle_mm_fault+0xa0/0x270
   __get_user_pages+0x250/0xfd0
   __gup_longterm_locked+0x116/0x870
   gup_fast_fallback+0xcfc/0xdf0
   pin_user_pages_fast+0x47/0x60
   io_pin_pages+0x9a/0x110

Base page faults fail with -ENOMEM.
hugetlb faults fail with -EFAULT.

Check the policy zone against current_gfp_context(gfp), so a pin-scoped
fault falls back off the movable-only nodemask, like any other
non-movable allocation under the same bind.

Tested in qemu with a dax/kmem movable-only node 1. io_uring and VFIO
pins of unfaulted base pages and 2MB hugetlb pages now succeed and land
on node 0 (correct). QEMU now starts with the same backend binding.

Fixes: 8e3560d963d2 ("mm: honor PF_MEMALLOC_PIN for all movable pages")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 70298fded1b4a..0884c629670dd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2302,7 +2302,7 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 		break;
 	case MPOL_BIND:
 		/* Restrict to nodemask (but not on lower zones) */
-		if (apply_policy_zone(pol, gfp_zone(gfp)) &&
+		if (apply_policy_zone(pol, gfp_zone(current_gfp_context(gfp))) &&
 		    cpuset_nodemask_valid_mems_allowed(&pol->nodes))
 			nodemask = &pol->nodes;
 		if (pol->home_node != NUMA_NO_NODE)
-- 
2.53.0-Meta

