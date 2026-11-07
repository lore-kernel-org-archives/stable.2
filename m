Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048758;
	b=B/mdj+bJM6Gs1LBiy4GI9u7kfzykHPFQ56QK+t0JgzmxwTcuRKa3bR6MAom5oCpfcekg
	 kBzKGst2LEVNIZ1w2KdVQfdvRxyYHRHF/uLrDsjZLfQAS8Klv1QBpV/0lvI3Acdt2J3Q3
	 Okh1n9UezFU4Q8NkMffX3iBML6x/rm8WGUyIzbC/yAVBIZ8wy0/wO1g3KfvwvQnuZVbtv
	 YUfeu83kwwfbsIeN7HWunJ0fqy6lK4h6R4SIwJepOJHMPLhdxnPTaR/kkwHGQbCaBOXkR
	 riqFA2s90XlrOAPKtL8oNNas4MhCaQ/wnZm1HYZhRIRzIcK1oKDkdCPbToDKCBMmgVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LxLNA5zJ+0TKavq+OylZrDulXLV4MSdpD5EAX/qvNy8=;
	b=0Zqhx+iUsAOMXl9KrcJXWJq1ekGPztJtyHJNRQT75UEMMyJhhzE8NrNmRKrwTqJCYsPI
	 qL+UlSPgK+FSDJzquVwR5Oj07uuL+jKqheWSJCcLFSagR/IoI7kMY4dKvKjN0shqNa32v
	 TSDM9UDoUd1CqmweLmdbxuZPVRpjbzFFCTGGqVQPKcmJ+yXWnsJroBGPa35rr9y7CxcKQ
	 fpZ0sELbgJXbku8GSTR170JhnO+n3B/wXV+9qdb/HMGRxSM6SwX5/H3X0QUBsVdorLxiq
	 ois9uZ1sxvBvfj3ivPSOdiiRIKh+gfMD0o3Njsa9iZlvyWENLePmvRqpGfcjnlW1VBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLPR13+q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLPR13+q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BA21F0089F;
	Sat,  7 Nov 2026 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048757;
	bh=LxLNA5zJ+0TKavq+OylZrDulXLV4MSdpD5EAX/qvNy8=;
	h=From:To:Cc:Subject:Date;
	b=gLPR13+qOJ7laNbBzKTmVAVseuO/UYZ+1/QSrIjNQJZgzEsWTNK+VKL/OVM5kute6
	 SHosQBldH9MQ7GN5IzjZC9k9xdfn5xkkX81i/wuCL93o3HKCdbQynyvWH6UCIFsBpT
	 PtXQu1sAlNzYp24isOPTxkIF6ySg/NfdY+hMUWMgi+c4IYNKHy+L9GKAMvaH/CV2zK
	 1MDVPVNRAnTJG7xTQi2pNJXahA2FfZzW1koUF8qhldHfQ9VDdbiiC3ACiYvKc9f5Ki
	 qXgsZI0ZbhSqfUpSKp+k0BCvgc3dmA8+zEAymsZZavKqmLV/bp7w+N0AmtwjuTb6P2
	 UK1KSmGr3dNdg==
From: Sasha Levin <sashal@kernel.org>
To: kenneth.feng@amd.com,
	kevin.wang@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/pm:restate all customized OD features on every table upload for smu 13.0.0/smu 14.0.2" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:35 -0500
Message-ID: <20261107055235-failed-6.1-44d0d3031e47@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 44d0d3031e47973ed65fd327669d5e2eaaf6c565
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055235-failed-6.1-44d0d3031e47@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 44d0d3031e47973ed65fd327669d5e2eaaf6c565 Mon Sep 17 00:00:00 2001
From: Kenneth Feng <kenneth.feng@amd.com>
Date: Fri, 16 Oct 2026 15:17:43 +0800
Subject: [PATCH] drm/amd/pm:restate all customized OD features on every table
 upload for smu 13.0.0/smu 14.0.2

PMFW interprets OverDriveTable.FeatureCtrlMask as the complete set of
overdrive features that are currently overridden, not as a delta
describing the operation at hand. On import it resets every feature
whose bit is clear back to its default value - for the VF curve that
means zeroing VoltageOffsetPerZoneBoundary[] outright.

The driver assumed the opposite. smu_v14_0_2_od_edit_dpm_table() clears
the mask after a successful commit, so a subsequent above-default
power1_cap write goes through smu_v14_0_2_set_ppt_limit() and uploads a
table carrying only PP_OD_FEATURE_PPT_BIT. PMFW then drops the user's
voltage offset and reverts to the stock V/F curve, while the driver's
cached user table still reports the offset through pp_od_clk_voltage.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5935
Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Kevin Wang <kevin.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1b63bb397db208a8f84778a9d9cafc93da9373eb)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 35 +++++++----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 32 +++++++---------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 38 +++++++++++--------
 4 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f516d0d3bb92a..9d47d2ab1b49b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -433,6 +433,8 @@ struct smu_table_context {
 	void                            *boot_overdrive_table;
 	void				*user_overdrive_table;
 
+	uint32_t			user_od_feature_mask;
+
 	struct smu_driver_table driver_tables[SMU_DRIVER_TABLE_COUNT];
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 6beafabf13065..468aaeb79ffba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1569,7 +1569,6 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
-	uint32_t feature_ctrlmask;
 	int i, ret = 0;
 
 	switch (type) {
@@ -1891,21 +1890,16 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 		} else {
-			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 			memcpy(od_table,
 		       table_context->boot_overdrive_table,
 		       sizeof(OverDriveTableExternal_t));
-			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			table_context->user_od_feature_mask = 0;
 		}
 		fallthrough;
 	case PP_OD_COMMIT_DPM_TABLE:
-		/*
-		 * The member below instructs PMFW the settings focused in
-		 * this single operation.
-		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
-		 * settings. Thus we do not cache it.
-		 */
+		table_context->user_od_feature_mask =
+			od_table->OverDriveTable.FeatureCtrlMask;
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
 		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
 			   table_context->user_overdrive_table + offset_of_voltageoffset,
@@ -1918,7 +1912,6 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 				return ret;
 			}
 
-			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2201,6 +2194,7 @@ static int smu_v13_0_0_set_default_od_settings(struct smu_context *smu)
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
 		smu->user_dpm_profile.user_od = false;
+		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
 		memcpy(&user_od_table_bak,
 		       user_od_table,
@@ -2250,12 +2244,8 @@ static int smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *od_table = table_context->overdrive_table;
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
-
-	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
-							BIT(PP_OD_FEATURE_UCLK_BIT) |
-							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+	user_od_table->OverDriveTable.FeatureCtrlMask =
+		table_context->user_od_feature_mask;
 	res = smu_v13_0_0_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
@@ -3069,8 +3059,10 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 
 		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
-			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
-
+			table_context->user_od_feature_mask &=
+				~(1U << PP_OD_FEATURE_PPT_BIT);
+			od_table->OverDriveTable.FeatureCtrlMask =
+				table_context->user_od_feature_mask;
 			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
 			if (ret) {
 				dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
@@ -3084,8 +3076,9 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
-
+		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		od_table->OverDriveTable.FeatureCtrlMask =
+			table_context->user_od_feature_mask;
 		ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
 		if (ret) {
 		  dev_err(smu->adev->dev, "Failed to upload overdrive table!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5fe409a237726..51e419e6380c1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1578,7 +1578,6 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
-	uint32_t feature_ctrlmask;
 	int i, ret = 0;
 
 	switch (type) {
@@ -1900,22 +1899,17 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 		} else {
-			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 			memcpy(od_table,
 					table_context->boot_overdrive_table,
 					sizeof(OverDriveTableExternal_t));
-			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			table_context->user_od_feature_mask = 0;
 		}
 		fallthrough;
 
 	case PP_OD_COMMIT_DPM_TABLE:
-		/*
-		 * The member below instructs PMFW the settings focused in
-		 * this single operation.
-		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
-		 * settings. Thus we do not cache it.
-		 */
+		table_context->user_od_feature_mask =
+			od_table->OverDriveTable.FeatureCtrlMask;
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
 		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
 			   table_context->user_overdrive_table + offset_of_voltageoffset,
@@ -1928,7 +1922,6 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 				return ret;
 			}
 
-			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2203,6 +2196,7 @@ static int smu_v13_0_7_set_default_od_settings(struct smu_context *smu)
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
 		smu->user_dpm_profile.user_od = false;
+		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
 		memcpy(&user_od_table_bak,
 		       user_od_table,
@@ -2253,11 +2247,8 @@ static int smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
-							BIT(PP_OD_FEATURE_UCLK_BIT) |
-							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+	user_od_table->OverDriveTable.FeatureCtrlMask =
+		table_context->user_od_feature_mask;
 	res = smu_v13_0_7_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
@@ -2689,7 +2680,10 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 
 		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
-			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+			table_context->user_od_feature_mask &=
+				~(1U << PP_OD_FEATURE_PPT_BIT);
+			od_table->OverDriveTable.FeatureCtrlMask =
+				table_context->user_od_feature_mask;
 
 			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
 			if (ret) {
@@ -2704,7 +2698,9 @@ static int smu_v13_0_7_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		od_table->OverDriveTable.FeatureCtrlMask =
+			table_context->user_od_feature_mask;
 
 		ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ed99e61f18e11..549716349117d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2360,6 +2360,7 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 		       boot_od_table,
 		       sizeof(OverDriveTableExternal_t));
 		smu->user_dpm_profile.user_od = false;
+		smu->smu_table.user_od_feature_mask = 0;
 	} else if (smu->user_dpm_profile.user_od) {
 		memcpy(&user_od_table_bak,
 		       user_od_table,
@@ -2406,11 +2407,8 @@ static int smu_v14_0_2_restore_user_od_settings(struct smu_context *smu)
 	OverDriveTableExternal_t *user_od_table = table_context->user_overdrive_table;
 	int res;
 
-	user_od_table->OverDriveTable.FeatureCtrlMask = BIT(PP_OD_FEATURE_GFXCLK_BIT) |
-							BIT(PP_OD_FEATURE_UCLK_BIT) |
-							BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_FAN_CURVE_BIT) |
-							BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+	user_od_table->OverDriveTable.FeatureCtrlMask =
+		table_context->user_od_feature_mask;
 	res = smu_v14_0_2_upload_overdrive_table(smu, user_od_table);
 	user_od_table->OverDriveTable.FeatureCtrlMask = 0;
 	if (res == 0)
@@ -2490,7 +2488,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t offset_of_voltageoffset;
 	int32_t minimum, maximum;
-	uint32_t feature_ctrlmask;
 	int i, ret = 0;
 
 	switch (type) {
@@ -2758,21 +2755,26 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 			if (ret)
 				return ret;
 		} else {
-			feature_ctrlmask = od_table->OverDriveTable.FeatureCtrlMask;
 			memcpy(od_table,
 		       table_context->boot_overdrive_table,
 		       sizeof(OverDriveTableExternal_t));
-			od_table->OverDriveTable.FeatureCtrlMask = feature_ctrlmask;
+			od_table->OverDriveTable.FeatureCtrlMask = 0;
+			table_context->user_od_feature_mask = 0;
 		}
 		fallthrough;
 	case PP_OD_COMMIT_DPM_TABLE:
 		/*
-		 * The member below instructs PMFW the settings focused in
-		 * this single operation.
-		 * `uint32_t FeatureCtrlMask;`
-		 * It does not contain actual informations about user's custom
-		 * settings. Thus we do not cache it.
+		 * PMFW interprets FeatureCtrlMask as the complete set of OD
+		 * features that are currently overridden, not as a delta
+		 * describing this single operation. Any feature whose bit is
+		 * clear gets reset to its default on import. od_table's mask
+		 * has accumulated every feature the user touched since the
+		 * last full restore, so record it and keep restating it on
+		 * subsequent uploads.
 		 */
+		table_context->user_od_feature_mask =
+			od_table->OverDriveTable.FeatureCtrlMask;
+
 		offset_of_voltageoffset = offsetof(OverDriveTable_t, VoltageOffsetPerZoneBoundary);
 		if (memcmp((u8 *)od_table + offset_of_voltageoffset,
 			   table_context->user_overdrive_table + offset_of_voltageoffset,
@@ -2785,7 +2787,6 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 				return ret;
 			}
 
-			od_table->OverDriveTable.FeatureCtrlMask = 0;
 			memcpy(table_context->user_overdrive_table + offset_of_voltageoffset,
 			       (u8 *)od_table + offset_of_voltageoffset,
 			       sizeof(OverDriveTableExternal_t) - offset_of_voltageoffset);
@@ -2829,7 +2830,10 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 
 		if (current_od_table.OverDriveTable.Ppt) {
 			od_table->OverDriveTable.Ppt = 0;
-			od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+			table_context->user_od_feature_mask &=
+				~(1U << PP_OD_FEATURE_PPT_BIT);
+			od_table->OverDriveTable.FeatureCtrlMask =
+				table_context->user_od_feature_mask;
 
 			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
 			if (ret) {
@@ -2844,7 +2848,9 @@ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
 			return ret;
 
 		od_table->OverDriveTable.Ppt = (limit * 100) / msg_limit - 100;
-		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		table_context->user_od_feature_mask |= 1U << PP_OD_FEATURE_PPT_BIT;
+		od_table->OverDriveTable.FeatureCtrlMask =
+			table_context->user_od_feature_mask;
 
 		ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
 		if (ret) {
-- 
2.53.0




