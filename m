Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004436;
	b=ShpANWNwMIj8rHv+AwD1ifDHQsbbx7s0TTZ22GRhx6cvW+grLujTElu2uGwwIcBblHV1
	 r9za+NZq2j2myoFoUJJPXvJxU6oJY6wfHevkfqfaj420lazRLsS3o7IERMktIFF6mn6Uj
	 B+kzIuhu2NLiT75e9tByxhYMtAip7Wfd3KaXOE14I7YjRWfNwfzjkDWmtmKOUQ1ABteqj
	 dRzGeyjDAD/AGV1/ds72soyN1xDT6/2Oc5RwK3F0TLno6gir71+hBvRdy0maq8hBpVRXi
	 Zo+o0mJWNs2mW43YIxPW3QR8c3v6cU71tHJ0VbtEet1CM4s6TKyU004TTInJuZu85Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004436;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TG4+TX/hNNdKeOSE6aIh3XoWRwHEosKSuvOtrUxuk70=;
	b=tJLuNOb7pnBjfEG+7+W+LyA3Qq84L8Ji5/xPMlWwutcyDYt6FbZ1EAND7xTIXCvVladj
	 lGUEvzv7x/lT943gesrPlbyO+B5YrXorbTysbTe39GUGu4IJv/8Hjeoh6Oz+wcLHa2GMz
	 KPtE/CXIb2k4cceZFpzVQMmutT8Ci6qaHXp+8CajARb4uzjdEe3Jhn8zFs6M1JA1C6e2P
	 QJnwRDd0DhKdb+YFG2KcYD/WNcFqRaSJtpmjZ+Fb/WjB9+enggVsbsR8KnfeHpKtrvGP2
	 iJ+XcgquvpFShx7d8m52B46FMcAE+WsHmhOsfEgMVmA1jjzIeK8ZpmM9N3zveEooqag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PaKakomL;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA355606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA355606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PaKakomL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795004436; x=1826540436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3T2zLZG6Fsatelqk3J5s9jKnF8ytcJizYsHOMATTVgc=;
  b=PaKakomLGI3FMy+NrH3THKkoi1DD6Zrw/MNNwXteWG2TAVXzMbEsUREM
   U3q9ziCOIrAvtoI0eVdLSj8TKlzJPKOj98y5P/LaJOaD9NkvzeN/vMQ5P
   f6VDVt08Fa+m+ALjBJbYJXML5IGsf4OY1FKjYDPRejhVsL8OcxggIomKq
   dOR48hqu0aQLW3NO9FuWQWrIVLrAhuW1491hsYdH2JZtAhJuM9hk3pkHh
   zzBNMuppr/XZIFm8RGJ45I5BweqLUA/sNJzy7l/bLwauL0QS8kARHYbLD
   m6W/NuRVG+BQFsFjcMeTejaJwY3PUXhY9J4DC6ZUDnsNG+MSu4P/2fcnA
   A==;
X-CSE-ConnectionGUID: 21dvc1nrSrOKPFaWusnJGg==
X-CSE-MsgGUID: 3HkwW4u7S9qdWUtri3l9ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3802172"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3802172"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 04:20:35 -0800
X-CSE-ConnectionGUID: 4VRWGNyGSq6Fu3GcFEBLmg==
X-CSE-MsgGUID: p99UIoFsQ6ORGfCyZmo6uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10040417"
Received: from abityuts-desk1.ger.corp.intel.com (HELO fedora) ([10.245.244.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 04:20:33 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Don't zap imported bo page-tables on L2 flush optimized hw
Date: Wed, 18 Nov 2026 13:20:11 +0100
Message-ID: <20261118122011.487537-1-thomas.hellstrom@linux.intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Invalidations of imported buffer objects originating from the dma-buf
invalidate_mappings() callback may run without a runtime pm reference,
and obtaining one from that context may not be possible. However, on
L2 flush optimized hardware, xe_bo_trigger_rebind() would, also for
non-fault-mode VMs, wait for idle and zap the page-tables and flush
the TLB using xe_vm_invalidate_vma() in order to ensure the L2 cache
is flushed.

For imported buffer objects this is not needed, since the vm_bind
ioctl already restricts them to PAT indices that either ensure no
data for their pages is kept cached in L2, or that are 2-way
coherent, making a flush unnecessary. So, for non-fault-mode VMs,
skip the invalidation for imported bos and rely on rebind on next
exec, as is done on hardware that isn't L2 flush optimized.

The patch and changelog were prepared with the help of an LLM.

Fixes: 4e7ebff69aed ("drm/xe/xe3p_lpg: flush shrinker bo cachelines manually")
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v7.1+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..fd7833e598b3 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -805,9 +805,12 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
 			drm_gpuvm_bo_evict(vm_bo, true);
 			/*
 			 * L2 cache may not be flushed, so ensure that is done in
-			 * xe_vm_invalidate_vma() below
+			 * xe_vm_invalidate_vma() below. For imported bos, the
+			 * PAT setting ensures either no cached L2 data or
+			 * 2-way coherency, making a flush unnecessary.
 			 */
-			if (!xe_device_is_l2_flush_optimized(xe))
+			if (!xe_device_is_l2_flush_optimized(xe) ||
+			    bo->ttm.base.import_attach)
 				continue;
 		}
 
-- 
2.56.0

