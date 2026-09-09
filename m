Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFE3D0907
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945965; cv=none; b=nAm11dy/O0J750ZMuwjEAWURptEkA4FuUZTZHHkuwi1Ak6v/M5QIsBEwfANbwZFJztwm91SU2fg1RIS7ym2kpDqR+A9akifABt0JwUZjY3D93DfJkvxpS4+91uoo4XDNQpgv+21/9RsLZlS9cUxJ0jNFvdjAc/hKe2UI/82Mi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945965; c=relaxed/simple;
	bh=j5zb56tNPES6HoGggM6gg9fHPtkyL7wluGxX+nvVUbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO48I7QziT1wyBCewdG9K41e/uyhe5EzjA6m0Cy6JjBuNAEL9VNkir8xrVoB07h8rL0/JVTVWaXpr7zzzt1vLJRiWweU6UG1kbZB32EUVEnNIm0unWVrP397LWLk3jImSA0FYjHHWQAdssqwxlELZxe5OFk/X4/A7R5iUSx8t9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr5tft0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr5tft0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B141F00A3A;
	Wed,  9 Sep 2026 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945963;
	bh=KOj7tjsBgiSEwkhnPKWfjXzZsR76iFxhZKLviiqPGPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dr5tft0nutbxnflVlVKL+ApjXjQ4YzZynueuTTcOf0muy7Ytxk3Vkjvw4KT7Xg6S2
	 3kQ7qrx+2BApCTXxLkdiqC9m50FDo7T7W+talP+2XgAh5W3yAJoaCgPx2AieJyE03V
	 tYgAfdlFk/j5WnE2yNdZZ0tI32a6dlyLoTpeCrXXgENEtrbxbWM0rL0A5ePJuYaywn
	 IW1XKu4gW49zxB21rdg8f7bdQ+EC56JYshonpPjdLoyJxOuY36z3pFXyGWzmLJbu2A
	 CWUjSyOGn6rKV7kbxhcgU5DiDH+C/NcpUUWWzIfTIh8mY2JUZRL6Y1kKkWOIXBi2+U
	 Mlv+6p2m3gDgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check
Date: Wed,  9 Sep 2026 05:26:01 -0400
Message-ID: <20260909092601.1293319-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090335-olympics-autopilot-18b7@gregkh>
References: <2026090335-olympics-autopilot-18b7@gregkh>
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
[ changed qcom_pas_metadata_release() to qcom_scm_pas_metadata_release() for the older branch API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 808e9609988d3..7ab8969528225 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -240,17 +240,14 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 		ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
 					pas->dtb_firmware_name, pas->dtb_mem_region,
 					&pas->dtb_mem_reloc);
-		if (ret)
-			goto release_dtb_metadata;
+		if (ret) {
+			qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
+			release_firmware(pas->dtb_firmware);
+			return ret;
+		}
 	}
 
 	return 0;
-
-release_dtb_metadata:
-	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
-	release_firmware(pas->dtb_firmware);
-
-	return ret;
 }
 
 static void qcom_pas_unmap_carveout(struct rproc *rproc, phys_addr_t mem_phys, size_t size)
-- 
2.53.0

