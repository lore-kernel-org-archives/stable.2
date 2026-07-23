Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869D395ACD
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830042; cv=none; b=rPuENYUXpvTbv/BAhCfaOzAjcMlEAQHtzJ1ophvCDmwKvHSu8vuLXydP40r9Bz23RiT8gIO0QN8sRrUiAVdrZ1eHHEtvP8vwJvb40G4Ul3A6EbBO11Q8apDcoaz4skHiWVsmV/omtJyMBxrhnsb51wp+QOYoa6fS3Fy1zSc+MDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830042; c=relaxed/simple;
	bh=snfJFKgok1e/zn5vd2nBZ99lU/T6Js+1Rok3VeWWOUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx+pevF0nQrDtBXPPRH+oPdotlIJzN675DRZwwJoQoo6EVtfuDX9WCygkciEo2Zq0XW6o4paNUa77EuLPrTGeiDAyYt4xm3uhFj6KZj4uQabrx4jjwdIPLXNAbdrvnwuAo2WaBVtDD2ONak3/VERhkGnHcVewq+iDz9J9mhXpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34B01F00AC4;
	Thu, 23 Jul 2026 18:07:20 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] remoteproc: qcom: Fix leak when custom dump_segments addition fails
Date: Thu, 23 Jul 2026 14:07:17 -0400
Message-ID: <20260723180717.3431408-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723180717.3431408-1-sashal@kernel.org>
References: <2026072052-revenge-discount-456e@gregkh>
 <20260723180717.3431408-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>

[ Upstream commit ecf9fc18e62c58eae1ceb65dab2bccb8a724de2d ]

Free allocated minidump_region 'name' in qcom_add_minidump_segments()
when failing before adding the region to 'dump_segments'. Otherwise,
the 'name' is not tracked and is never freed by qcom_minidump_cleanup().

Return error when adding to 'dump_segments' fails.

Cc: stable@vger.kernel.org # v5.11
Fixes: 8ed8485c4f05 ("remoteproc: qcom: Add capability to collect minidumps")
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260318-rproc-memleak-v2-1-ade70ab858f2@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_common.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index a0d4238492e90c..9726b0bcf63347 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -108,6 +108,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 	struct minidump_region __iomem *ptr;
 	struct minidump_region region;
 	int seg_cnt, i;
+	int ret = 0;
 	dma_addr_t da;
 	size_t size;
 	char *name;
@@ -128,17 +129,22 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 		if (le32_to_cpu(region.valid) == MD_REGION_VALID) {
 			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
 			if (!name) {
-				iounmap(ptr);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				break;
 			}
 			da = le64_to_cpu(region.address);
 			size = le64_to_cpu(region.size);
-			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
+			ret = rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t,
+								name);
+			if (ret) {
+				kfree(name);
+				break;
+			}
 		}
 	}
 
 	iounmap(ptr);
-	return 0;
+	return ret;
 }
 
 void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
-- 
2.53.0

