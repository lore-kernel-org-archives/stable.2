Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475C3CF688
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579844; cv=none; b=ti0a8drjPuj+HliRvwKN1guvx4I0C9w9lZZ5m1UateLz0wY4cj+hpTc3EG5MSGBLZdthQwC0P3my/xHNgmGDN0MSowbT3nrzhtzLRFZSBpe7MBNOMLlniyeLOL8q6NwUlEIvzIccj2ubevHDzlthvMctylaARbBmtx6F+eQlx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579844; c=relaxed/simple;
	bh=7v+Y1N9t459dYGQSDB/mBMqLCDbbHLs2H6QN7wtNLBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2qEqjVJfWix+NZTB7IstiXnNa+7Qy/lpGjZdPurN3RIXiLI9UPtwzJTPmWV7DvTAeKCjy/KIvH3aVWEbdUVsAj5ogywpmZw4CJxxPLTK/RGzbJTYvmsy83Epc5WsXv5wSYO8Fa0BpoE4WRCej7tLeZDmJ3af2QiZ+YAUXAf8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=W8z3cBvm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFZUoj1s; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="W8z3cBvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFZUoj1s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2ADD614000F4;
	Wed, 16 Sep 2026 13:30:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 16 Sep 2026 13:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1789579841; x=1789666241; bh=sEzC4k5CJmAV6EJO1XhWjipY2iPMC41J
	5KqRauPMcFs=; b=W8z3cBvmX93Pzsm5bNCRiY139GXpeJe1v3Xkn22MstaPsHgy
	qP3GyTYl3P4a67pLjO1PGEb1dFV1DfPLDykR4z/854lyE6SMAtsArI+Gg3QGFr1n
	22KxTFVF9xgnaXFSKcdskfp+stDb1Pu+bcwUl6yYWwE7HdqikOZmXN7S2PksSAiz
	sgsf43bs4CbOHMqYYAtbePUcusunHBJd3lidU1ECQdq27jC6XHpJWeRCKR2HI0SI
	54cDKJ3qD8gY/Pp6ysmC2UYSxTKrj+SIgbfvcG/60mX9CYFf9Ad0K/j/m2WjSNhF
	kvv8ksUz7PGSeUJLLSMNF+khLrS/fwOUBVeUOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1789579841; x=1789666241; bh=sEzC4k5CJmAV6EJO1XhWjipY2iPM
	C41J5KqRauPMcFs=; b=TFZUoj1sd5wzq6V92J/uxsf3SSM2ifhX4DsjAgUNlWhU
	6eAsn61pwSeiVLgGV7jvmCKRWbXQ6CLYgzqEyQyv759H6AiJGx9yCW0EZQGvSqZA
	tdLRY4dnewtM5NFNa99MZxpUr+OwHRfifJ+FXNEbp/VePCF8odEsQ7SJjMpAePN6
	yl8MXZQOR9wortnzRLC5Cv8WCPbUmDe+qwK+357xalVj0aNXRwvbTbZPLtQprqPe
	8fnjP8Nhh2NWHHZ+WzFzG5iiuhGyDesYUDsQAReRN+nca32x16AxG+UqKvyJLZwb
	e07DMW/szM+5nAcoTmduXKQo+NQgCo0s6D5w4prHYA==
X-ME-Sender: <xms:QNKqar4EE9LI-Ci45nMVNqyof-kwidRJpl306loLxgGmy3IwfVmqSA>
    <xme:QNKqatkELrkNM8W2gVc3-2rio61NawOH3E1ezo3jDG4WzJ49qn8VIWzz2PCaNrSer
    cPQwbP557BE_fZbGQ3OAJ3MR-A2hCQ4qFF21tn4dWpHAU8Cgt0>
X-ME-Received: <xmr:QNKqamXp7FAlrkBIVB8SzSqRW9nEiS28hNCrLWexN4SBh6xYgoJGqbppGv9TzE1xFJc0rmwbSvQi>
X-ME-Proxy-Cause: dmFkZTFRR2SdzYysCnDldAnwcUjqwv+J1OcwrzewRKc+tpczioQYwLmLsiqEXhmQdC2nje
    56bGrrx9GV0swaDUdEK3vzaaVqY+M/XwqVdnxH+XYP25yLI5dgcMCMyHp1UAKHpzlMM6Pa
    NfKIQqGtUlBxkueH0hJjWk2FklFgBKXLz2xRvyNL8MinjeW04yJe6UQoDcfj7Fm7GkQqjv
    hWMDmiLq+BTLEM4gbkW/awJ3xlxmRvUzWx2Z1pfR7j7X/jzaQ8xRnBoS7gvzb3G9bG0ct3
    i24Lbjgm0XtyjqxFcsT4bz5ya9cZ4U8Y9gRKqIKKaOSFKm85ALGxH1ylfLgRm2aN/+3adN
    cUBVfKKQWHA2itOHpXXPGf2EhOirzoD+YJUN8W2J8btmtWKsDaOFNp10yxo1cjCNfqFLCA
    eetNRPqBIDmnhflwbewQqA80/IE9YIqIzcnlCVJFyqgi/DPFkMyhrMlFDOWWfHiQjIeh9G
    89n9QqLFXfGqXXqk99gbjnMCdgUUBVwfGw6Qv0Oj/Sv5b8KJP0y9gIov6j06UeHeBXiu58
    ngIpfuaFxt/OlglSkpwlIdfm8koIBhdly2sJuzoiRSESBrEf2tn7hwG3rFYegHCYuFa04F
    L7fp6z+VojadVcqdg1VI+iW4SHrDfKfNnDMGMAOf0fHuPfqzSNP33fuzmKRg
X-ME-Proxy: <xmx:QNKqamQRcqvlLVMy3OsQDxJ-Pj62_oGYUfuHRu2Y5BOtNr-7ukxvxg>
    <xmx:QNKqajCN2AJCPPGKq58J4g9L4vvSXTYb25eOUnyQ7d--iuJtUJD3Mg>
    <xmx:QNKqauuEzb0d10ZGzyknk3K36HIWDjgTpWiMYIC8Ck0U3NuKpU4EOw>
    <xmx:QNKqah9C--fGdirKD9LXW3LiBUUq7NtHJYplpvh9CAou0G6ozyA7Qw>
    <xmx:QdKqaoNidy3xp9Bfq4NoR1cy-a8FbyWcN-DtMO5vSOMoLGcheiud6Y02>
Feedback-ID: i792e4853:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 13:30:37 -0400 (EDT)
From: =?UTF-8?q?Szymon=20Aceda=C5=84ski?= <accek@invisiblethingslab.com>
To: intel-xe@lists.freedesktop.org
Cc: thomas.hellstrom@linux.intel.com,
	matthew.brost@intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	hch@lst.de,
	bob.beckett@collabora.com,
	dri-devel@lists.freedesktop.org,
	marmarek@invisiblethingslab.com,
	xen-devel@lists.xenproject.org,
	=?UTF-8?q?Szymon=20Aceda=C5=84ski?= <accek@invisiblethingslab.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV
Date: Wed, 16 Sep 2026 19:30:30 +0200
Message-ID: <20260916173030.3223833-1-accek@invisiblethingslab.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix display corruption on Xen PV dom0, where DMA buffers are not
guaranteed machine-contiguous, in which case bounce buffering kicks
in, breaking xe's memory coherency assumptions.

Apply the same workaround i915 carries in i915_sg_segment_size() since
commit 78a07fe777c4 ("drm/i915: stop abusing swiotlb_max_segment").

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8382
Link: https://lore.kernel.org/xen-devel/aYtznP_tT6xNPwf-@mail-itl/
Link: https://lore.kernel.org/all/20221020110308.1582518-1-hch@lst.de/ # i915 counterpart
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robert Beckett <bob.beckett@collabora.com>
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Szymon Acedański <accek@invisiblethingslab.com>
---
v2:
 - Imperative language in the commit message (Thomas Hellström)
 - CC the authors of the original i915 workaround (Thomas Hellström)

 drivers/gpu/drm/xe/xe_bo.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 290ca62..341fa93 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -9,6 +9,8 @@
 #include <drm/drm_prime.h>
 #include <drm/ttm/ttm_tt.h>
 
+#include <xen/xen.h>
+
 #include "xe_bo_types.h"
 #include "xe_ggtt.h"
 #include "xe_macros.h"
@@ -574,6 +576,23 @@ static inline unsigned int xe_sg_segment_size(struct device *dev)
 	struct scatterlist __maybe_unused sg;
 	size_t max = BIT_ULL(sizeof(sg.length) * 8) - 1;
 
+	/*
+	 * For Xen PV guests pages aren't contiguous in DMA (machine) address
+	 * space.  The DMA API takes care of that both in dma_alloc_* (by
+	 * calling into the hypervisor to make the pages contiguous) and in
+	 * dma_map_* (by bounce buffering).  But xe (like i915, see commit
+	 * 78a07fe777c4) ignores the coherency aspects of the DMA API and thus
+	 * can't cope with bounce buffering actually happening, so add a hack
+	 * here to force small allocations and mappings when running in PV
+	 * mode on Xen.
+	 *
+	 * Note this will still break if bounce buffering is required for other
+	 * reasons, like confidential computing hypervisors or PCIe root ports
+	 * with addressing limitations.
+	 */
+	if (xen_pv_domain())
+		return PAGE_SIZE;
+
 	max = min_t(size_t, max, dma_max_mapping_size(dev));
 
 	/*

base-commit: baafc300cd079a5210c1e70e5ea3d93518e40b38
-- 
2.53.0

