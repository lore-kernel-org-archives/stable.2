Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12A3019C3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948660; cv=none; b=XfJSgdlOUGer2Wk0OXoN5cxamACOTm0TPWt3AZ88fX/KAM8q7E1uKRjGyhx6OSCNtwrNFBL//fo2NXVTTczEw9zeuakVoUUT/dwP9BwQh3CP1QywXVNNeiyLYIUFNt6u+iBWyZoONLABQko3KeeABDuCHRbZjfO2wvj3dt0z9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948660; c=relaxed/simple;
	bh=59sDS/TTBn6Hv4Txsi2y8gOhvRQa1m0yqEi+tzeaj7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fITM4dcXMch3oOHUU2hNc0oKwIH34qbQAnob9oSO3kNOZEZ5nf0ArP0++bQc+X1mPptwSgN/iHx+IBB8Fm5XQgEHm6BAQlcNV2tTorxmfEwdSk0KyRyH4JkUgSTLwbLTLk7axZErmAaW3ZFagvK4dXN5VLjDJtegROTysm6ldqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLWlQsXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLWlQsXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95A21F00A3F;
	Wed,  9 Sep 2026 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948659;
	bh=oCKCiU+iomayGNSwKC0GLfbaCEuF/Oglduba4n0vu0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nLWlQsXRhnNtEIj/QVBtDHCT7zOq37R09oeBs888Bu+PnsJiLqDSDyl+p5yd+dDT6
	 mRvgGleFIRqVxMjD/nuEnkIPUl0w4zXMaf515tj3+YnPV9yqkj1HMTAhX2o8QGKFm/
	 x8Up6/grsUDbGIK69j/h6Opn/aqA4H37O7nsg9ugjOiwueIi99diyRZ6GSmwgdlIVp
	 0eI1VjCbSG0ZlxND4Dp/JXuNZbWwlfC0f76bl5kWKK9V8apMwbrpn0n9FISDw7kQgt
	 P9JdaUtnjVnNEgsDpVvpt09uf35X84W2XS3zmZn6GO58jelS/ulD39jmNtlRGPSkvh
	 vv0GNJ1uP6+OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check
Date: Wed,  9 Sep 2026 06:10:56 -0400
Message-ID: <20260909101056.1457982-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909101056.1457982-1-sashal@kernel.org>
References: <2026090336-enticing-sandstone-d55c@gregkh>
 <20260909101056.1457982-1-sashal@kernel.org>
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
[ adapted DTB cleanup to the older separate initialization and loading APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 158bcd6cc85c5..8c59eac9bd973 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -248,15 +248,14 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 		ret = qcom_mdt_load_no_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
 					    pas->dtb_mem_region, pas->dtb_mem_phys,
 					    pas->dtb_mem_size, &pas->dtb_mem_reloc);
-		if (ret)
-			goto release_dtb_metadata;
+		if (ret) {
+			qcom_scm_pas_metadata_release(&pas->dtb_pas_metadata);
+			goto release_dtb_firmware;
+		}
 	}
 
 	return 0;
 
-release_dtb_metadata:
-	qcom_scm_pas_metadata_release(&pas->dtb_pas_metadata);
-
 release_dtb_firmware:
 	release_firmware(pas->dtb_firmware);
 
-- 
2.53.0

