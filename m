Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581380;
	b=hM13RyISbpQLL6ojdzLms5g90cPv0OMVfW84x9uc1Os0oPdxVKykHA8CkGA8unuvB/G9
	 RIRh7K30A2YjhXoSLN+rgsAq5SbjVujiYw1+zH8r/ESKZm2vu5op47UBZekGm2O22IYFI
	 JYQ7sSYH+rO2+5UAnWvBMV1ZkCGMp/ShosHRN+e4HYsq9svp0jc6Pi0a7Ct6ha8nIysvU
	 Gznj1KIHoAWQL5Ylmf5v7xh4jz8PlnSBHbdJDI5VeQ2r6FJUqa/4Zvk+E+BkkkhYaOBwm
	 OcrowHlav+YC/zWH7xB852u5iPLQ4TWA36c4+cw8JiO82Hp26WKlSfWwg5HHPtN8jjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/+CqgD5EqPpO/LXf+S4Z7/jR2aD0DOfSHaoLJytMuYk=;
	b=tyJPEGsOzjQQG5zMZnjPayHivmMV4YnicKg0ZRLVeYLXS3ezPTPTJeuTDD0jFnAKAbVZ
	 uMCAN4ZZQM3VXbYsLyx4K7Ari8bDfMOifIZQt2wNy7xza/BNMF8zw5CoF4pf+1BEq1GHK
	 tgUfdr7bV5M3B2HoYUShW1D6CW9pSKt172B5SFMVbu7wID/bex4oc0QtwUsW3EcEYh64u
	 66Fv0j1+EWdmG2QB/uHQvc4FNZwu4PW4waLP0z6QWnWH+hZkNdN79G5XZNEG5m1RwAFVH
	 dDXcBR/jOUKHS7C8bx+EPWcSO92sMd7JgoHwbx9CbxNgwAu/M5cFa+SzBv8b5zu39zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOXSwMhW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79E606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOXSwMhW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921F41F000C4;
	Fri, 13 Nov 2026 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581380;
	bh=/+CqgD5EqPpO/LXf+S4Z7/jR2aD0DOfSHaoLJytMuYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bOXSwMhW671/Yd5CJVIKWL6OOzVaQKhh4IJdSUd54wvFE3V+uPZ8ufgbKbnr+OVlv
	 aFwy2NAvrUoUd8GidQbr6uEAm3IlrjkW6aMiJYR07Jv9FaTgH9HTgtULuI4d2Zpt6X
	 4gkAed/mVjMGw4s/KwRMRiIYiHax7aJC8A1d86UQZo8DXz/FugFIZ6w9+XbN1AN2/s
	 r1H7IP0IyJrVbEMUodj8Iw4cq6tlF589UZXq0mJa4wR/Imc6Jh/uuUjyK2wiO6wbr3
	 dX33rekPl5xoXvctX463jn4wkcfvksnSL3/GSZW0u+O2XzKE1EP9zBJkBSpsY/9cEa
	 wXMXE1k5qxHzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Wang <kevin.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/pm: populate unique ID for smu 13.0.7
Date: Fri, 13 Nov 2026 09:49:38 -0500
Message-ID: <20261113144742.1494555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201431-failed-6.6-079f9103d9cd@kernel.org>
References: <20261109201431-failed-6.6-079f9103d9cd@kernel.org>
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
[ sashal: Adjusted placement of the get_unique_id callback and its registration because newer surrounding functions and table entries are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b97015fc3c8a4..5b56819f26ecd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2177,6 +2177,25 @@ static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
 					       NULL);
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
@@ -2245,6 +2264,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 	.gpo_control = smu_v13_0_gpo_control,
+	.get_unique_id = smu_v13_0_7_get_unique_id,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.53.0

