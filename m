Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584205;
	b=vAgUcr9RTYvagnIc+7U0ZMvTd1bF7eiWWFJYnMVgDQArEKpy1qmuOlEMZ88LcWgYtQdL
	 AVv1eERX/nnhSThFWjEPboJ2LQOjeV40tAmYyCRW8GHL96a/+WvCc7xOk6VdRwQhbwaTx
	 D1zMoNt5IL9DStbmC91vGoB0mAniilrtbB7Kv3j3Yoz+UojWj2HgvZaySiDhfxQi54hJJ
	 7wY9fsWZJ0vPYcHtouULj38Yv7/JZ0hZK8LixUOPmex+vC0JR2Uz1RyK1SVPUKhvPjc/c
	 SqT62uCU/Tpp4jfVgRD7OVu7lhj6y0GRwjeBDCpzj/r3DTtv7jz9eRuq6hcsN7Ww0yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9S4ihvKUkO7Ltqn/sTOO4cUsUEmO6vGuAtxaAv/6WVo=;
	b=ynnWmRYrbZ0Xt4DDMQl22yIbQ7SgMo/vPwc3ee826M+bIR0cZgHAIlP7kUXJqmLw5t33
	 LYpPenfDiXeGi7pUaPh3mQVRRotVFdSAd4sVcl+Ml/AXebaMWO6RUKjzifHLrKBDnOheP
	 6M5nf03t4q5yWfZj28n0Sh2VEJ8OwlZMIVY7FpxpCQvpYL+YA8eupC/uVZ0Xom3GjGIwD
	 ePGo1CTZ5t21K9iRZXkMJ0KIjN279WKoFvor3Yi6/6VORgIHT6RZDod2q4E5kopUeSzAV
	 B8bwOXQKSBeIKNoDq42nYH2hc+UwaEOSGv5zmzQXKMrSXgBe7h6jyA9Vbp2PEiOBC2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUIA7kW0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC3606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUIA7kW0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55D31F000C7;
	Fri, 13 Nov 2026 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584204;
	bh=9S4ihvKUkO7Ltqn/sTOO4cUsUEmO6vGuAtxaAv/6WVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUIA7kW09KP1TpjBC1LT/L4MiUeK2reHA138I7xtrTDRaBlodaD8XoWLyumIogN7t
	 FuOhqnc7H/Ip8TD1My3YsBaudnGYy+hW5uFLBqd0HzJTk9XnoJj037S+keAEjjhYjV
	 cptJB+/JgHfFr7G2dwOcV4YdaSwhYzfor3p3EL3knqU+3aU2ovoFYVgmvnlPOodJLd
	 sUtBImyh9mNzJd6w34Wmc55XbA8yFGlZ2s3snDjqtQ7aSCjaSP23oRQrTH8rVRmViL
	 Pn4xSK8Mvn9K8I9wyTQAkJt4XlqOON49en+EcNI/hGE+L7D0cwMPvm8UCmFxfoVRcI
	 6sev/W39yXslQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Wang <kevin.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/pm: populate unique ID for smu 13.0.7
Date: Fri, 13 Nov 2026 10:36:42 -0500
Message-ID: <20261113153542.1860841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201930-failed-6.1-079f9103d9cd@kernel.org>
References: <20261109201930-failed-6.1-079f9103d9cd@kernel.org>
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
[ sashal: Adjusted context to insert smu_v13_0_7_get_unique_id() immediately before the pptable_funcs table. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f5e340c2c5984..50d4f7990dfb2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1695,6 +1695,25 @@ static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
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
@@ -1760,6 +1779,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
 	.gpo_control = smu_v13_0_gpo_control,
+	.get_unique_id = smu_v13_0_7_get_unique_id,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.53.0

