Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272747;
	b=175QhQfm4OLjGslqfpN1zxwdJXLT635twahsDAFmcXSbfM+cXbP0D6QHRdMq7q2fS8Ju
	 xcZ/j7Tod2IVccIUoHTmfsf7Al/oL2FmZwNf065RQ57oHmSw1TM5hgmmfqQVOoxdf2hOE
	 QJnvOg/CacYdL72Izfh6hpHWQjFZgvOEGRCbiTe1ZuFi/rNMfOVhkp7E0F+lHKTVcTEuI
	 toYnJI8mNx51580pJlleihmowB1yVwu91TNEbK29xdkPCPzI6bbeqDUsnNJ//CI5zTeeN
	 9oLbyIOgpX4R9+yeGSAYZI9zoFC0YoLD+7U50bQy/TF6I5tR9A08SyDw9X8Sv4qpfHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EmfswcKSwkVvx064EoYflna8DbwVDkJ96wkJtT4nZt4=;
	b=360VAcXjwxxrPuObRj2BAjKnh5s0W4pSrZ2esKqkGk2F3HIuKI5ZF+CWVXyjgfzogQ1K
	 GODCZ2LuUMYYdJ1T7nr+Rh57HPhCQsVEZ6RTOpJ3AH7N37wQcOexMDH7CCp5wnNiWw6OC
	 /5mJ7sl2cnOtbx14vPgcL1qyDr/Ao+kPtfbdi85s4VSdh+64NbiUUkH9rBKy1fgGIMHxR
	 L3y4PbB5JxxZi2SNf+0S5n6pXONlJxL+7oTLUwPzcBUMUvMaWVqNsCi93Tmi5RSXn8iYR
	 mJneXmx0YqXCOvck4LLAXqBI4CIKO0sD0dECub3rxZ1c+4y7W4lm9obp5Y7/fBSEjrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PCZc/ArL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3212606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCZc/ArL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3711F0089F;
	Tue, 10 Nov 2026 01:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272746;
	bh=EmfswcKSwkVvx064EoYflna8DbwVDkJ96wkJtT4nZt4=;
	h=From:To:Cc:Subject:Date;
	b=PCZc/ArLsZxU/qsnSLcx2Papk/ak8J39omK3BUZnv3w+eVJdg8gz7XMCZuplPHHc9
	 cyY35wRUzshYVY5/muPohfZ1oxuA54MWqGkURmr/Xais0P5wk+j7b/lGJQoUU0n2wi
	 dqpSKwIckgM1EGs3uYqz33zx2O1G8+AjIb+SP/xQcg6Ri7Rs/7xf3utAPeZWNW0HIE
	 YOfBHf2JWbkeBApE2GtVRLXK3oK8CPc6Mwt+LQAH9SJFaePzushqsgkLYCSFMSpAWO
	 fBIZsGgrMzEcTyxRIvt5u1L75mYObFdXVni0dkYkeS1g7ddjX8WWtlEfCER7s07ooA
	 PLgafOmoCsgdQ==
From: Sasha Levin <sashal@kernel.org>
To: kevin.wang@amd.com,
	kenneth.feng@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/pm: populate unique ID for smu 13.0.7" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:44 -0500
Message-ID: <20261109200544-failed-6.18-079f9103d9cd@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 079f9103d9cde68fb2ccc414e94520f43ee102de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200544-failed-6.18-079f9103d9cd@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




