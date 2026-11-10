Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273273;
	b=c04cp7nfrINFfrp39dhy8QsQZ1vHJY5L/yUKd7OEoEG0eWYdzpvsOkERWD+orm1zWz+L
	 0sEpX4MVpszc4kyW4+/INLK9X2TxXM8Dh7ewOBuWnFeUXMUaoX1scnO/zO+6OWIvQ12yq
	 LsYZ0iXonhQGInqQfZmbCeueY3PHAhhdedjL9pamaThgkIv+WJNGqPyC0f2SdqExAzxjm
	 qtvtwjuNKrmx74zIGKS7EW6pIu+vBfpP4Sny88RNBzAr8F5eVpVSsY9UDCmiCpGQo8rMc
	 Lz4C7Dk5XbvpsvHlpDTCd2gmMe1VDeGhu4TafMbVs4ASn0iib3JbOO6m8B+oDRU1wFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0TMx0HKfYnyaj1NNFo+BXIYCUmNRgPRQ0bGWGLy6Lgw=;
	b=KMeugPEfHfvP2Pe/998VYfgdNly4J7y3Y2XEHzxdwXADkPmOfovFsLkN/SL8ZYktDrM4
	 tJa0shpXZ2rDjnzh9ogPFbr+tOx7xvQS75fLmZGtcDYW78yObTxtcd/TqoDHV6rBoUw+a
	 E+D6yF8VmS+n1XDRcJ0nmG9E8pDQ1+B2A8RzEOUOOOP4BWQhnPi/qYWyahiu10sR+HRNA
	 HAnAypL4Ss8Y5MCOpvQO9L4ZhjHimX0jqpL8+bzO9/uPMeymN7VDXkFUSkuAdxAihRN0B
	 2Q2ugjvMOu4iFPnY7gjW96GUmeZ7uBdVXaWktvXeQYfY8er3pLrZ5g9901R4FHND5Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6xkkGvg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D266606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6xkkGvg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A411F0089F;
	Tue, 10 Nov 2026 01:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273273;
	bh=0TMx0HKfYnyaj1NNFo+BXIYCUmNRgPRQ0bGWGLy6Lgw=;
	h=From:To:Cc:Subject:Date;
	b=T6xkkGvg1ZkSTCqNJ5otvjfGnwQo64ehT1EM8nLtaKOYEGIsspy1OuKM93H8cL6lx
	 LWNwuN1XZMgDVQjwVcx9KFoBUa02TjIt6mTbHFOA/wogCsPcnMnjuLVJUTLJinbFsP
	 4Ra/o/2kGtYSOBvHfaYxlUEkAC5SERd/4rFzjFPzsUcXDMpx+YzUMR9fcW6tesb/VE
	 NbuBkgHbcPR/DA44yr7Dv1lNMAQsJAx9NfcDm5XqYMuNjPVRl/+pOfBDc21dqmuz/M
	 0mJHi1KTk7gRxHl9VB0v1lGqS/TZMbqnxjzt7GdWW47VxO9wTnS8UC+fvD7VesbLsM
	 /OV7MvF2fhFXw==
From: Sasha Levin <sashal@kernel.org>
To: kevin.wang@amd.com,
	kenneth.feng@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/pm: populate unique ID for smu 13.0.7" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:31 -0500
Message-ID: <20261109201431-failed-6.6-079f9103d9cd@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 079f9103d9cde68fb2ccc414e94520f43ee102de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201431-failed-6.6-079f9103d9cd@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




