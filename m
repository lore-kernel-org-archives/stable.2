Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045815;
	b=jGFcxiSGKpAM21VzfqIktYaJBU9pFFHApXRQqYxMpp2MAqmtpj75tIALBGD1gFbekhbz
	 EKKHj7NvY0elXOBTWDv0czBM5w47B8zdEhbJP5GuruzJiDLhi7HH6wG+HLS+wJm3x7d9Y
	 7YooIJFyWC/5A8uwCCP4xlz4oCyP+qcSwuEKPFpkSpBj1KpfEWCu6i0d5/s7ixNO7EqNN
	 EMnxh7yNYSU0udeovgO7FoHZ2udrQWHP7l7DAieN4s4I/arklZKrxgbN6ETj5xz7iYWdu
	 wiVp5+KhH++2cTuSoyOT94ZdGl3pZB4i+ri/Rdo9n1Tr+K+I7QeEF0gd5VjM7sRFjtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045815;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=83XTvVVuY3doQQwiMqpdC9ecoHyJlqwJUZBwSC1jVw8=;
	b=z/Ru5rqG1UzmN6vgHXcE8M5qSHvA5HLZfpsuehgUP/wMS95pqI9DfuS64SAABMsZ8MLA
	 bqjU82bPcEKYNv+grwsOtMP5sgyOWwXDxBR6rbRjPgMKO0qFQL/pVVxTbxfD/ppT/NlUq
	 TV98M8H/s1lZej3mWNfbE4L0hNGNCpNnX9F2ap91xo0bn6bsUYuo73/SiFO2f9vpSM2aF
	 R+RIoqT/uomUeo6XLbJ9G7pdbZrD4FAjx3b6h4BmaVXIVIIuDc3aL/+0M69cx7z5QyCx7
	 6x9/KIackpteyVIHY9bQ8ug072kWd30dRzzC1j0nsiIx6GPlsfCpce/Q79yCqg2lQrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgtQNg6C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8358606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgtQNg6C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA501F0089F;
	Sat,  7 Nov 2026 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045814;
	bh=83XTvVVuY3doQQwiMqpdC9ecoHyJlqwJUZBwSC1jVw8=;
	h=From:To:Cc:Subject:Date;
	b=jgtQNg6CwpngWLyo9dNP6otRdacbULvrnpgfIEPmKa5pJTWugU4fAhFWJEPI1OAlG
	 B68FJ9Y1z22I0zjDrCKq57hXG5bVzDaYbUsVt7oxxatOAnSEYIoTZ5w5HlbVvql9Ee
	 RyZQV+N+oZr18nGYlRfChRVx3pQ6DQjhJGPYOhOx1djiwy/xBWIX2Zm2EHFL57wuht
	 wiZjoIw9njGCe1J8FeXLftyw4x+wvoFtn81WX7n716i44EUfPiA2esb58fLb6Wp3b6
	 oKgNKqUYGI1n/A+RYiLXaB4J8WcMiNSuw/XkL9ujbOS1d1MHG9TMNt5GQC4u4kil6q
	 sJQwpmdItTIsg==
From: Sasha Levin <sashal@kernel.org>
To: accek@invisiblethingslab.com,
	marmarek@invisiblethingslab.com,
	hch@lst.de,
	bob.beckett@collabora.com,
	thomas.hellstrom@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:32 -0500
Message-ID: <20261107050332-failed-7.3-77f704158f09@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 77f704158f099b952681f207478a22d5b8218edb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050332-failed-7.3-77f704158f09@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 77f704158f099b952681f207478a22d5b8218edb Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Szymon=20Aceda=C5=84ski?= <accek@invisiblethingslab.com>
Date: Wed, 16 Sep 2026 19:30:30 +0200
Subject: [PATCH] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV
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
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260916173030.3223833-1-accek@invisiblethingslab.com
---
 drivers/gpu/drm/xe/xe_bo.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 290ca624e2a77..341fa93a71e45 100644
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
-- 
2.53.0




