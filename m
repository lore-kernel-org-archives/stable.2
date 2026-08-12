Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619002045AD
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549473; cv=none; b=OuKvQ0LeYURLL1zJk0koxamUcOBOrVaXBh7bFdlSdMWBrZw+Olb0MRWZW1zSZL2ykEDhRNhkiACYwiU5kR2BQdLHxIMd9DxsB3cUYJMnZs0BjaMkxYEGNOJsCeonLZfDa2Ck/OuTLbmP1F7PAtpNfomffJ04gPgMYJEJLUr83u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549473; c=relaxed/simple;
	bh=AaYkhdZN+JkJMfz0bcKXbcfwTdHrPakhVqQQvXyhfv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBLD7g7mR770qCoFcbd118klt81RwRtYGmiUP0pSOeqjD4iT/09vCB+0f+V4xXEwbrowNkM5PZTFxFOJLNtl12v9HkIKHdRhru/FjcjIBvNe40rhBSCkjD9GojlXdzYEYRc3Rsc5MfgOePl/SlyEXx4V9Rcf+VzCYRo1QpLbglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSwCJyhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSwCJyhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7921F000E9;
	Wed, 12 Aug 2026 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549472;
	bh=97oel6v0mrjstzJopDdga9TN+dyjDE+45EEi11HruQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lSwCJyhFfeX0m2Fl0RoOrh8iW1F6NrzyI3YT6J1UVg8UBS37QDDJ1oywiUSKPcyQA
	 P1Fc/9U0y19JXNVRiPyL5kaQApWKB1dlknPKe2jyTlq8sAv8DlD3sQunUqn3FKaBcC
	 6SP9uC/ieaV93pdfGN/9/X71RSNkbqJbijrzjQnQnpCMp3vxc6gWO5h33Rgd/N4aDc
	 dCZzEKbPq4oFD2tC3IrZdqXMcjYYIvMtFwmiiBW0FJb5XBHkQoBXSW1BGMHZQbsZha
	 v1nArEdhQGHQiQkQRItw+oDotljC4xk4weh2bfKhv+Z2c40Sg7LPuam/pP+kxg6sQ8
	 IGa1LTb0h72Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] drm/amd/pm: Use macro to initialize metrics table
Date: Wed, 12 Aug 2026 11:44:27 -0400
Message-ID: <20260812154428.2235665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812154428.2235665-1-sashal@kernel.org>
References: <2026080524-joystick-anagram-33dc@gregkh>
 <20260812154428.2235665-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 1327d8f4061c08c29ea8ce7bb89e209d3c1e8b29 ]

Helps to keep a build time check about usage of right datatype and
avoids maintenance as new versions get added.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 048f4541b71f ("drm/amd/pm: fix torn gpu metrics reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 58 --------------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 14 ++++++-
 2 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index d2f11d82312f0..c1a41610036dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1051,64 +1051,6 @@ int smu_cmn_get_combo_pptable(struct smu_context *smu)
 				    false);
 }
 
-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
-{
-	struct metrics_table_header *header = (struct metrics_table_header *)table;
-	uint16_t structure_size;
-
-#define METRICS_VERSION(a, b)	((a << 16) | b)
-
-	switch (METRICS_VERSION(frev, crev)) {
-	case METRICS_VERSION(1, 0):
-		structure_size = sizeof(struct gpu_metrics_v1_0);
-		break;
-	case METRICS_VERSION(1, 1):
-		structure_size = sizeof(struct gpu_metrics_v1_1);
-		break;
-	case METRICS_VERSION(1, 2):
-		structure_size = sizeof(struct gpu_metrics_v1_2);
-		break;
-	case METRICS_VERSION(1, 3):
-		structure_size = sizeof(struct gpu_metrics_v1_3);
-		break;
-	case METRICS_VERSION(1, 4):
-		structure_size = sizeof(struct gpu_metrics_v1_4);
-		break;
-	case METRICS_VERSION(1, 5):
-		structure_size = sizeof(struct gpu_metrics_v1_5);
-		break;
-	case METRICS_VERSION(2, 0):
-		structure_size = sizeof(struct gpu_metrics_v2_0);
-		break;
-	case METRICS_VERSION(2, 1):
-		structure_size = sizeof(struct gpu_metrics_v2_1);
-		break;
-	case METRICS_VERSION(2, 2):
-		structure_size = sizeof(struct gpu_metrics_v2_2);
-		break;
-	case METRICS_VERSION(2, 3):
-		structure_size = sizeof(struct gpu_metrics_v2_3);
-		break;
-	case METRICS_VERSION(2, 4):
-		structure_size = sizeof(struct gpu_metrics_v2_4);
-		break;
-	case METRICS_VERSION(3, 0):
-		structure_size = sizeof(struct gpu_metrics_v3_0);
-		break;
-	default:
-		return;
-	}
-
-#undef METRICS_VERSION
-
-	memset(header, 0xFF, structure_size);
-
-	header->format_revision = frev;
-	header->content_revision = crev;
-	header->structure_size = structure_size;
-
-}
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index a020277dec3e9..ade36a8ffa668 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,18 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
 
+#define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)         \
+	do {                                                   \
+		typecheck(struct gpu_metrics_v##frev##_##crev, \
+			  typeof(*(ptr)));                     \
+		struct metrics_table_header *header =          \
+			(struct metrics_table_header *)(ptr);  \
+		memset(header, 0xFF, sizeof(*(ptr)));          \
+		header->format_revision = frev;                \
+		header->content_revision = crev;               \
+		header->structure_size = sizeof(*(ptr));       \
+	} while (0)
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
@@ -125,8 +137,6 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 
 int smu_cmn_get_combo_pptable(struct smu_context *smu);
 
-void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
-
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
-- 
2.53.0

