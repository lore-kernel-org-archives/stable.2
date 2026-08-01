Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F957384CCD
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545119; cv=none; b=X0PyXDhqpJXtFRjz3TBXtpye1mGieNMdkcfwjcYNbev/ahaYaaDTiPCZZgZhvCDG9Px1Yglpd/7urOcQ9nEmee5D8LMRjjprfmTUHsn0FC66OP4Z9Wu5MxuI5Vbx2mLdtoBP7jCp7xOcOwAg2T9SU1z2bWsblold1Kn/Meamt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545119; c=relaxed/simple;
	bh=xgoalQaSz5ySvrbgYy7pcxT8y3i3UVEN2uaqcXY8ALw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXJbg1Qa6ytxiRHh/wbrjPUHprZ0EK6Ak6ETr3olFFa1AjzUJlfoIFC6MqF7SO3HzyBndnnCRSp2RewqW/CBqsvthX6VxV39CY4O5IRGa1JMFBSFqHcM6C3Rbh17SmEAKgelGomKwV6zuEw6TbAA6Aa0IJfWif1odxQpmH5LJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRPNuqFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRPNuqFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7472D1F00AC4;
	Sat,  1 Aug 2026 00:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545110;
	bh=2gcH7x8V53XAnmyCUDDW8eUk/qdsmWvIOci3lDBHM1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRPNuqFEB9vmpFX1TwOoA6C4kNyE+dU4SP2+Hd3Zo/bBHhW5Dq49gWu+iOKru6uqU
	 oUQ8y+fdAjnxMGymUiWCXrSDNFk85M9b+nz3ZDaP8EZNUTgXTEnlQr1tsy36O8D8SD
	 zq5ixWMVmKBqemR9ZwommwIy8aAUOvdPdvNF/IpJsRDCtVxpwg3+9YhknPn4E45+Ri
	 ewAlNgk0RoH2xFWvFQf9AuAv1m71ITrQPUBHlFQyYMLQPn5wqU/jp6JGYiB4b99Jq3
	 CB9mEU1zQOPJjuP2wcxBigsashualmY0EI+P4nlP7D2N4f+xITJ0+ikQp0ixPktk5O
	 Z3hVP+jP6RH6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/xe/guc: Fix buffer overflow in steered register list allocation
Date: Fri, 31 Jul 2026 20:45:07 -0400
Message-ID: <20260801004507.3661318-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072944-swivel-tidy-c727@gregkh>
References: <2026072944-swivel-tidy-c727@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

[ Upstream commit 632ecc90e1ca5d3b6822bb4d08f84a175b6c42c0 ]

The size calculation for the steered register extarray uses only the
geometry DSS mask (g_dss_mask) to determine the number of entries to
allocate:

  total = bitmap_weight(gt->fuse_topo.g_dss_mask, ...) * steer_reg_num;

However, the filling loop uses for_each_dss_steering(), which iterates
over for_each_dss(), defined as the union of g_dss_mask and c_dss_mask
(geometry + compute DSS). On platforms with compute-only DSS bits, the
loop writes past the allocated buffer, corrupting adjacent slab objects.

This manifests as list_del corruption and SLUB redzone overwrites during
drm_managed_release on device unbind, since the overflow corrupts the
drmres list_head of neighboring allocations.

Fix by computing the allocation size using the union of both DSS masks,
matching the iteration pattern of for_each_dss_steering().

--
v2:
- use bitmap_weighted_or() (Zhanjun)

Fixes: b170d696c1e2 ("drm/xe/guc: Add XE_LP steered register lists")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8049
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Reviewed-by: Zhanjun Dong <zhanjun.dong@intel.com>
Link: https://patch.msgid.link/20260612070401.543305-2-tejas.upadhyay@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
(cherry picked from commit 0a78a44f4901aa6c9263e66be7fce02282f1109f)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_capture.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 243dad3e2418..3a1613886495 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -437,8 +437,15 @@ static void guc_capture_alloc_steered_lists(struct xe_guc *guc)
 	if (!list || guc->capture->extlists)
 		return;
 
-	total = bitmap_weight(gt->fuse_topo.g_dss_mask, sizeof(gt->fuse_topo.g_dss_mask) * 8) *
-		guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	{
+		xe_dss_mask_t all_dss;
+
+		bitmap_or(all_dss, gt->fuse_topo.g_dss_mask, gt->fuse_topo.c_dss_mask,
+			  XE_MAX_DSS_FUSE_BITS);
+
+		total = bitmap_weight(all_dss, XE_MAX_DSS_FUSE_BITS) *
+			guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	}
 
 	if (!total)
 		return;
-- 
2.53.0

