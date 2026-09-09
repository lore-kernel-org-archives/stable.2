Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2618D5328A5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951270; cv=none; b=c7ePoJz6Zv52xL0AclIg3phI3Ne9n1ReDTDWJxdKV+hHn9MF4WLHcIAHMNdKckfnpipJwEORg4dm6BK4Vj83C+F5Rk5mGS4kmEfdj97zMDhNFfeDa+W4Ga39SjvbIB+uCMkTk29DBvHLlWuLKqK8jVtvDmhKc0nZXbrs0e3jRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951270; c=relaxed/simple;
	bh=egiwpFbmlrGFvARopo1kl2m4pMideL0l0NjQeSmKvtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXAlS09H29iBTJc6iM8WvtENp2hUm6DJzcWgFKCQEPRIwmjwvBnVRfUxtJVk9c+6JapkveDHcYHfLt/r+VeYxcNGZoojDfZUCyiEKqKAOii0uHXVrmtS8lhzK0DulyTjIoXpl7BLt+FHTzJLkfKeqCq3BHPkaZtipkaRLdHdkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awtU0MBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awtU0MBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D5E1F00ACA;
	Wed,  9 Sep 2026 10:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951266;
	bh=QLOqDJ01uC8/innBvE+CF5D1QjzhvDYnPtSyuO+qs8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=awtU0MBctigYWhYObaKUbpEQwg59snL6cU5/K8dRTyIFyo3rM7s+2fER4j6Oj7g3E
	 Jtk6HKA1WHXTJRfnbD5ArqN0B675dfO07zWb2y8uhw3ufTY/bO0pslQepZo/iMRvV8
	 HWTLm+tMwiQFYrqUmuGY7PHs+eqt9CsgZTopAWcQkhWqeMnRwiSytAcEBZ5Wshkj8M
	 eHBTmskxGz7HsgCB2valDZueFl3/PjoQS5don33wEDJUwKQVzs9E2DCZTUsXtJGjIo
	 jbndfq5BJOMYEH/uKjIj/EZGT608dK1qg5PsG4vk8I1ELKvsSr28hkaz7S63jPHK1j
	 4sKMaeyeulsoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check
Date: Wed,  9 Sep 2026 06:54:22 -0400
Message-ID: <20260909105422.1620618-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105422.1620618-1-sashal@kernel.org>
References: <2026090336-snowiness-uncle-0a18@gregkh>
 <20260909105422.1620618-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

[ Upstream commit c06c5ab4945392d2c2aded6d832ab6b58cabe351 ]

All other call sites of qcom_scm_pas_metadata_release() for the DTB
context are guarded by a check on pas->dtb_pas_id, but the call inside
qcom_pas_load() was not. Fix this by moving the call to the guarded
block.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 29814986b82e ("remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260724182858.1868271-3-mukesh.ojha@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index d7f84eb5b7f9a..23f928323bcfd 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -247,17 +247,14 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 					pas->dtb_pas_id, pas->dtb_mem_region,
 					pas->dtb_mem_phys, pas->dtb_mem_size,
 					&pas->dtb_mem_reloc);
-		if (ret)
-			goto release_dtb_metadata;
+		if (ret) {
+			qcom_pas_metadata_release(pas->dtb_pas_ctx);
+			release_firmware(pas->dtb_firmware);
+			return ret;
+		}
 	}
 
 	return 0;
-
-release_dtb_metadata:
-	qcom_pas_metadata_release(pas->dtb_pas_ctx);
-	release_firmware(pas->dtb_firmware);
-
-	return ret;
 }
 
 static int adsp_start(struct rproc *rproc)
-- 
2.53.0

