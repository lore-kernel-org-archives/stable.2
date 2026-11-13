Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577571;
	b=c7wY0zdwgg7vWHQZde48mo4Rb6o2q0Vee322GqeQjev0oj0lraEc+SbkeJUBL7+/Qtpa
	 g/tE5ZIGvpGg3jFTI2uh1VehjTcQaiuBQpIcSTIsSOK79DVt31ES1lVo+IpqB2nK5W3X7
	 N4zTMm14niFuL+Q1f/AtiX1p63W/qOoWYjGIyqTx12TyfC9cP60vq48uAHXoV5iUugcYY
	 NEx98EFuqz3v03JYkE0oi7w5M2fJtQyqqnkUOIefUjKpk2jXL5WVPXosF7cQRqSQQRpCj
	 XkMounMpBUPFpdlKFVLn+arjiJKDoveIUx+p7J9NOS3LnTlmht89h9Tb4g/3XBqHrjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577571;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wke/lWZWJ5oe3v8HYY4hzKwu1F/KvP2xL6bsuJI2W+Q=;
	b=s6GO+a/bKiXLaw0vN2v0wQUihQrVfRYX/qFJZYXLPYxAhGb78J4VRnpNetUbH7EeU5YP
	 wXYeqRfJWU/m1PRsz+mD923GGYbXkROrHfnQbzJU0YC4GKMyhWHhy7IYGetRKqmuYdN19
	 DSKMn+9XsmU8OaBzj2/gXpWZOZ9W478Bh2VMKRZvOqLlT8MX5GzH1I4xlXJr8Y7NipS0/
	 hSFFjK51HO5j3AVFN+Kngz7VTV0OXPe07fMOdvBjrGRClet5+OdW0iwwnyeivqqByOM6a
	 bVM7Yt/IO5wdKyzXpicS7kRaHoGb2cHyKeNxvDMDxKHjiRXkFVogVmqWoqDQ+ULKn4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNFZeXja;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1468606A89F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNFZeXja
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92841F000C5;
	Fri, 13 Nov 2026 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577571;
	bh=wke/lWZWJ5oe3v8HYY4hzKwu1F/KvP2xL6bsuJI2W+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNFZeXja6mwBGLZfwNbG6p/jb4C5sfQZTUxAI6/M6CvSaRtmpYG+e0PrFQgQ8flzv
	 BO9IBJLFLjiTuUqNUzdi/MTEUPQ4nqpOBJRvGYmxB+kUq8aXb3sMLmEqRfoM+zLjcI
	 FyLv6GmNHDN3MZnS/aRnk4sRXy1qroRMIBZJXzLEkDxGBKVDf7/6IzdR1Nd3jHKy5A
	 AxvpId80yCG1SZNJDomgt7sdUIrIz/ElfwRJchmiAJubgz8lCT+A5NNX5J0gNWVXAJ
	 1NRUAxk+Oh/Xv/NMXP0lgnIFTslEyB2ppTbMoV7/0GSd99ZwV0kva+rQqTSY3CnXB4
	 luaLPNSVnr1fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Wang <kevin.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/pm: populate unique ID for smu 13.0.7
Date: Fri, 13 Nov 2026 08:46:09 -0500
Message-ID: <20261113133445.1312722-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201004-failed-6.12-079f9103d9cd@kernel.org>
References: <20261109201004-failed-6.12-079f9103d9cd@kernel.org>
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
[ sashal: Moved smu_v13_0_7_get_unique_id() immediately before smu_v13_0_7_ppt_funcs because the upstream neighboring functions are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 9467db88969c6..22420256750fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2669,6 +2669,25 @@ static int smu_v13_0_7_set_power_limit(struct smu_context *smu,
 	return 0;
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
@@ -2739,6 +2758,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 	.interrupt_work = smu_v13_0_interrupt_work,
+	.get_unique_id = smu_v13_0_7_get_unique_id,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.53.0

