Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273006;
	b=z0n8RI3T3A0z39gQVQXIksLRo4hmoerEu/qWCAFlyyBZaedn3ACkfGCqoSx/6GXlPVu6
	 2XImwefzazVcfG8p74pl1GuXzfmfjMDPK7XtdYcm2kDMamGWiXDhF/6hxP5Mzc081wrhS
	 943cNrp7O3hXgtHZEKlV6uwNaghDPW8xTaHeIIq3BL4iYU73dI7SndGhRi5uq1genqvVf
	 w6jjcbyBTrDE9dXErcMbaE8U4MMiRIhigjUUeRdgB99MilRJ/OgYspqK4nEnZkU00+DFE
	 z/tuKFcj0CPrsE4lPB0F5AYEgC/UtTDLPSxXkSJeLML+e/U6hJjPUn00kHVvBQfOAZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8lEzrTTPabwhmUWy7eUFVcnBz9PcNR53xTJW4AiIOxQ=;
	b=ua4MtMgsYfKmrEADmr+IUJMVcvVbwZiBPCnuOHo+qZttvzl1F1hXM4KaMl9XuNx27aSq
	 rmFAYtefzuQWMQdCziXCLXQEVQnROD/4j4hkhnGyTPw85SYPLlhsnKWezjzFNCRT4vD9o
	 BpkPk8hz71750d8GYakN+641b583GhpnmrYlnTQg3TIhHlGV6ZIawdyv2koxVMfKA80Td
	 aWQ0e61rOWj2bH4xF8cPT7ZUXl7lIXh8ak4fScYg85pmK0izNTsWKK7Zfr9ugi1icnbp7
	 ArzY57sOINPKfLfYPVqvaDMXaa3+Q/atsF+fQ9Hcj2QCxiXFaX5JDmASeG00HavbaOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKiXRH+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC56606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKiXRH+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB581F0089F;
	Tue, 10 Nov 2026 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273005;
	bh=8lEzrTTPabwhmUWy7eUFVcnBz9PcNR53xTJW4AiIOxQ=;
	h=From:To:Cc:Subject:Date;
	b=gKiXRH+C0gNFc0FX1MtWOpaBzSsYIjwUnsHjD5I7XJ507eLksEg0lBPXTkkvTXYTY
	 ul3TNLVj//twARIEtyoo9Q9ExzQnkUfVdrMMH2nJA9YafzsUG4PLynXtz7fgpKMibv
	 mFvEb+2BRL9XLOYW5pz6sbU38nyIHkgMddiju9YX+etHXqnpWl0+WmxZAlwn1X0DTN
	 8bo98HzxyIPjV8wlWqI9lgs/sm84o24eM3SR9niuaqDAcxcMF7bCyLfd7mwQJYWwAf
	 9aYpqeHSlIkA/R7kXDM3LgWuLiz7zbGBLnvWSDTRUUhVBoze4qxS+Sd97N8J4P/h8r
	 DeSxfnktIBu8Q==
From: Sasha Levin <sashal@kernel.org>
To: kevin.wang@amd.com,
	kenneth.feng@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/pm: populate unique ID for smu 13.0.7" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:10:04 -0500
Message-ID: <20261109201004-failed-6.12-079f9103d9cd@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 079f9103d9cde68fb2ccc414e94520f43ee102de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201004-failed-6.12-079f9103d9cd@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 079f9103d9cde68fb2ccc414e94520f43ee102de Mon Sep 17 00:00:00 2001
From: Kevin Wang <kevin.wang@amd.com>
Date: Thu, 29 Oct 2026 11:50:31 +0800
Subject: [PATCH] drm/amd/pm: populate unique ID for smu 13.0.7

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
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 8285d4a91589a..13e7e33fa0eb2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2912,6 +2912,25 @@ static int smu_v13_0_7_mode1_reset(struct smu_context *smu)
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
 static void smu_v13_0_7_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -2995,6 +3014,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
 	.set_wbrf_exclusion_ranges = smu_v13_0_set_wbrf_exclusion_ranges,
 	.interrupt_work = smu_v13_0_interrupt_work,
+	.get_unique_id = smu_v13_0_7_get_unique_id,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.53.0




