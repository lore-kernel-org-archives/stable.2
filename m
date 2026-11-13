Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575428;
	b=VkVf3FOaqwIiipVX3vYMfg5AMKM72Mi9rLj75G8nTuBnucyJQCOhfm3Lf0uDhqZRVf2y
	 ZfVqcdaqDl8deFeVVVWd20lHPIPWpkusBwWRAqdHQ07IGREWjRbXpH7gvH7zM17upcLy1
	 8Gc1CHk8GUIn+lNLrqnxwoJBvasOZDrs4z07ckCmT51aBQ3f3PdflubNPa/rQTudB9f01
	 Xnx2xEeK6tDjujs+ZE3FM4Bo039M7DoaRAmvDTElscAACOmy5lUx+ryJblaj+Ot6jib7f
	 I8JBmh+5FrHurdQ/JGis3u19KAhiTSt6LwdlD8L1PwLpsAT4xdeqE5RtI06TkqOUWFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8U6mOVcAUAT1gUK/55V99U44e/o3sySgoEmlT/i1khM=;
	b=ed0tn3+EflkeZnNV5T2XBT1+NFo7HqS++s1u9agz1e3HMfEAcW8jWuDi5quvDS/JCz7x
	 G+tBKR46lud+abztM3Mw/d5EHf26lJ+4grqcmdtoDdxp02V4RkaMySf37zOIDcbtRPphQ
	 SdWw5S2I4mvyIUke3gVkiCYJjQGPPS3mjuZ9BLWEwLkWfiLdl7ooDpnWAjsT6KEXh59Ak
	 9oekEHgy8ktHi9CvWZKPBIeLycrvImy8Va4QLf8xgNvTD5I6CyC/fWZAkWmaug+6MND5B
	 F5Hlcx7Dodgoa70FBrQIlZg+YS63v4HztMjEKZAHa4gfqKMlWMNVGBv076Z22n7t5BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0q15Kfs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD84606A33B
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0q15Kfs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D11F000C4;
	Fri, 13 Nov 2026 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575428;
	bh=8U6mOVcAUAT1gUK/55V99U44e/o3sySgoEmlT/i1khM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0q15KfsoHemjoPFLS/p4uZPufnGo4bCkwkH2+OiBDzJ3mTD5l3hAnzUnZOoLoKzP
	 21rVFoHPD4F2GiiGSSMSNrGKFdi3ok9aOpZK0s4c/afuip+OVrELOiTbY9p1dNxrAx
	 +VK5RqRV2Myecrk4skp1jeXBYXxmqaKX6e4G/iuyes0zLTixPq29byPZZPqUKdCZNv
	 SNyoNan91lrrp3DCtGppDryuROTZh3oJtp6xAoeAwHx2J2CAPcDDuDwggWaToxM6H/
	 IR8fZ0oI1/1Xe9uQ60eatyuvmcxSRQsES8qHuqPwQhGx6fAnBj2ud04Qzlawsk0vAk
	 kvNBJBptVl2Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Wang <kevin.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/pm: populate unique ID for smu 13.0.7
Date: Fri, 13 Nov 2026 08:10:26 -0500
Message-ID: <20261113130524.979877-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200544-failed-6.18-079f9103d9cd@kernel.org>
References: <20261109200544-failed-6.18-079f9103d9cd@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Wang <kevin.wang@amd.com>

[ Upstream commit 079f9103d9cde68fb2ccc414e94520f43ee102de ]

The smu 13.0.7 backend does not register get_unique_id, leaving
adev->unique_id at zero and KFD topology without the stable GPU
identifier consumed by HIP.

The failure is observed at:
    auto ierr = hipDeviceGetUuid(&uuid, 0);

Fixes: 113cc31dde66 ("drm/amd/pm: add SMU_13_0_7 ppt_funcs for SMU_13_0_7")
Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5e2585daaf8336d9ce1bf52e55a9b7a8cdbf625b)
Cc: stable@vger.kernel.org
[ sashal: Moved the callback before smu_v13_0_7_ppt_funcs because the surrounding upstream functions are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 9947b3f6bb5fb..5df28b89cb696 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2836,6 +2836,25 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 	return ret;
 }
 
+static void smu_v13_0_7_get_unique_id(struct smu_context *smu)
+{
+	SmuMetricsExternal_t metrics_external;
+	SmuMetrics_t *metrics = &metrics_external.SmuMetrics;
+	struct amdgpu_device *adev = smu->adev;
+	u32 upper32 = 0, lower32 = 0;
+	int ret;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics_external, false);
+	if (ret)
+		goto out;
+
+	upper32 = metrics->PublicSerialNumberUpper;
+	lower32 = metrics->PublicSerialNumberLower;
+
+out:
+	adev->unique_id = ((u64)upper32 << 32) | lower32;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -2905,6 +2924,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 	.interrupt_work = smu_v13_0_interrupt_work,
+	.get_unique_id = smu_v13_0_7_get_unique_id,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.53.0

