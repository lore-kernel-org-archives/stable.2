Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749C1D89EF
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785593047; cv=none; b=K7rqj6efIGDt0a+4onfzKuT16maQrezQV4WerlGPcUv0Ki0XCKTmjj6oht6rfSOB+GfQOt06FzhpR2jMrdPgF/OBdgKz8PDNISwPyXgt3p6PJcLsLiU4kPye6vkCH+JznjX/ZflgwNL/qBeY1lRAy97CVpm/1W3i/BJrGQ8T+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785593047; c=relaxed/simple;
	bh=U84e6D/j2yvwJzPdr6RUcHGaeLBiUmGwv/o5DHq5MlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E85cue6+aLkhWjRvne9AKFzu65QS809y7AEPudB1krLdmWYfERE73uP0WknuFzTwF8rSWaHKrkC+2muHNvPJST6sw3RqOPtLFdYuP/l5RgL1DChMxysOuHH1EM/xk3IFqUoZF2gDTv0HkBHYr2oT0TlAY5kFTYeW+YOUl8MRu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiHzYOkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiHzYOkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55971F00AC4;
	Sat,  1 Aug 2026 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785593045;
	bh=dVocF9GHIuljWzCi8XkifNpHz0lwD/n4X0L1ylCWnWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kiHzYOkfm+zNbSzpg9qBHuA+R9xsx8hr3fq31VG10lGVY49t5aaReETTIQy9cUS9L
	 VPzPyQUoIwce6b1USrRoT4U/roS8wOGXA9GQI/keQn/uOFXLyL4soO+KQGc2+xmdod
	 4a4s+Xp63cSf0Prf0hZTIwUbMU/8dox9SYvQKk3S8hG4WwPGEqMEMawhXUNmmtgwVR
	 ufto7IRbNcs9tUJ1ZFcIJgCi2tJ0PhZ5D0EtIWwLWRJKYTou9fRKCNW19wPoyMqe7H
	 nM+I0Di90XeSrW+utsdji8pEl44QoADwxLzWX+1Zl2WNgOpBShuT5MuYEj2lkIlmRU
	 45nqwUkFy7n8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Wang <x.wang@intel.com>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] drm/xe/pat: Add helper to query compression enable status
Date: Sat,  1 Aug 2026 10:03:55 -0400
Message-ID: <20260801140402.3645391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072936-hummus-emblem-55be@gregkh>
References: <2026072936-hummus-emblem-55be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Wang <x.wang@intel.com>

[ Upstream commit b2bce0e551e89af37cfcb1b1158d80f369eeea3f ]

Add xe_pat_index_get_comp_en() helper function to check whether
compression is enabled for a given PAT index by extracting the
XE2_COMP_EN bit from the PAT table entry.

There are no current users, however there are multiple in-flight series
which will all use this helper.

CC: Nitin Gote <nitin.r.gote@intel.com>
CC: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
CC: Matt Roper <matthew.d.roper@intel.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Xin Wang <x.wang@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Nitin Gote <nitin.r.gote@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20251110221458.1864507-2-x.wang@intel.com
Stable-dep-of: 7bc597ce74ba ("drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pat.c |  6 ++++++
 drivers/gpu/drm/xe/xe_pat.h | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pat.c b/drivers/gpu/drm/xe/xe_pat.c
index 2e7cb99ae87a..9a321384b73d 100644
--- a/drivers/gpu/drm/xe/xe_pat.c
+++ b/drivers/gpu/drm/xe/xe_pat.c
@@ -160,6 +160,12 @@ u16 xe_pat_index_get_coh_mode(struct xe_device *xe, u16 pat_index)
 	return xe->pat.table[pat_index].coh_mode;
 }
 
+bool xe_pat_index_get_comp_en(struct xe_device *xe, u16 pat_index)
+{
+	WARN_ON(pat_index >= xe->pat.n_entries);
+	return !!(xe->pat.table[pat_index].value & XE2_COMP_EN);
+}
+
 static void program_pat(struct xe_gt *gt, const struct xe_pat_table_entry table[],
 			int n_entries)
 {
diff --git a/drivers/gpu/drm/xe/xe_pat.h b/drivers/gpu/drm/xe/xe_pat.h
index fa0dfbe525cd..12cb6ec39d34 100644
--- a/drivers/gpu/drm/xe/xe_pat.h
+++ b/drivers/gpu/drm/xe/xe_pat.h
@@ -58,4 +58,14 @@ void xe_pat_dump(struct xe_gt *gt, struct drm_printer *p);
  */
 u16 xe_pat_index_get_coh_mode(struct xe_device *xe, u16 pat_index);
 
+/**
+ * xe_pat_index_get_comp_en - Extract the compression enable flag for
+ * the given pat_index.
+ * @xe: xe device
+ * @pat_index: The pat_index to query
+ *
+ * Return: true if compression is enabled for this pat_index, false otherwise.
+ */
+bool xe_pat_index_get_comp_en(struct xe_device *xe, u16 pat_index);
+
 #endif
-- 
2.53.0

