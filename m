Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E435542816
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953292; cv=none; b=RcvRAUunOemyaGU0sulUOqFAhGT+8y2Yjm0G+aR/IBKzmrzZ4LR96WEQnj3OxLltCO2N52PxSaQfCLzdGHCXvBnb7N3W8piUMaCaLA8gDYbFbMtJe0R/PgRuChF0sGJhBIRbZVoeqMC6Z9MSsTA99KeRIwmwjm7NB45SFhR6hbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953292; c=relaxed/simple;
	bh=0xbeuMTQdlaqzpmdIOio1CgCGqt6yKSOoDrGc7TCA3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSeztTS9bIwOivJv4KnwNb6trIGl1Ow6KB/8CH+9zTo69a+IQtY7+VMRbeDdrObl0FlCOZtbPZ40/R8wvHu3cpeJGR1PAbm3gK7f7PnSVJ6Wgnk++ss19vBL67hp4gYkfoQq/rMXa8Rdo8i1hpJ9Ln/mRGxUrEgyLjiMRDWQXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwi8m7nF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwi8m7nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA371F00A3E;
	Wed,  9 Sep 2026 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953290;
	bh=WUKeDu2ckv3SXRzySp5OP1s4P3tg/iwJgpNP9jiaDbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cwi8m7nFYdXvN9Rom4iDYsfjRP4lih0VLT/UDiBSHIiqqH2F/M10nlsGVaA7vQnes
	 mDftONEH3IJhQP1i0jy3/ndRCQ+doFg42ynlZAmuECadbeXNohTOdn8/kZ+4/l4Dgm
	 UQWLhujT7wi9+i/qXsjH1rmrHlcAnqTdfNMgZOfmPQJl+g/BzoKG91b0hRzBP+x2ZH
	 hPU50SBK72S2UYZeCjZWPTGf7BlsOYXd844pVy+g7lXCfeYqsVIJ1xDow1YqjK9TKa
	 oqaelKFQ2udUyQOxia/U2vjlddjg/GpGVM/iy+AMkzYSYwhBdrWBPSSZ5zLtLOJSIm
	 J9J61JmwLL2fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check
Date: Wed,  9 Sep 2026 07:28:07 -0400
Message-ID: <20260909112807.1846537-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112807.1846537-1-sashal@kernel.org>
References: <2026090336-dweller-sepia-b585@gregkh>
 <20260909112807.1846537-1-sashal@kernel.org>
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
index ceaf4e3f68247..cf0bb4115aafc 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -230,17 +230,14 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
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

