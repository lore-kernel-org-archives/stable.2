Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F93409613;
	Fri,  2 Oct 2026 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924609; cv=none; b=pKwbuCJNFdU6WDfPmLOjqb4fpbxXH/6S5FgU9PmGen3P0T/z55xZw4GcI29Vdal9ghMn3yBBkZipO1x07Tw+rGKWXtqYe2oug3GLrjZZbYg9wL5i88IqWN4Z+hfRlwK2eRGwPnUmAjvW4DCzqOocp1I9/9lb5hE5Gz4Fj5Zr+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924609; c=relaxed/simple;
	bh=tE6/i+yYB09r+i8ASE4DQo+syorkgg9eaoAvSb6Ib1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnS0EQOdil/zWk+1kzw30Tgm28yiJHfMtVr9W0hG3s194mPSUK7l2ACnFooYiwiujdgevM+8/Rszc51vSH5cKQ4aZUbZjQvHRFBRStUm18HlcIuuNBv0BYpfPEol7V15uA6cKD080d0Qigka61nXTJk7+6Ji7h+CzTlhlpSUE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=og5U/TWX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="og5U/TWX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265SHT3755607;
	Fri, 2 Oct 2026 07:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pga9cvOkr+G05GCHwiw/yNVZVi4HrlhY5RevFn+JH
	1Y=; b=og5U/TWX+EGDvcyMn2QaiF4VY47uPte/+kXhDBEWllsNMLK0piJcxgra5
	Bc4HTS11YYds4NbpbPjKdFLRxZsE322Tva3xTsYady+wqB6TDuGtNuynjXdq3+oF
	LGc1MaexQS4BgzxXR1E+2jenBaKcf89pO7wPDEAV7sHuOKrl7FvTnUP+oJc/PBvT
	+3CORipiPCjAoRayzPZ5SYaoY574+TCLPmwknyrKkQ8KA+k40sSgsCcRRislG0er
	Ha4lJ6pw5izVTHbmZbXsTndsZdoITJSJ1aRuOihvRJJcWpxVOQdQB0pVFiqc9idS
	wlPxout+26hUoL2uw4UJCYGW1j6Qw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkpxv7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 07:03:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69262PnW2076517;
	Fri, 2 Oct 2026 07:03:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcshsdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 07:03:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692734ZN42336730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 07:03:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3825520043;
	Fri,  2 Oct 2026 07:03:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1AA720040;
	Fri,  2 Oct 2026 07:02:59 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.28.159])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 07:02:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com,
        Nilay Shroff <nilay@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] nvmet: send namespace changed event after namespace is fully initialized
Date: Fri,  2 Oct 2026 12:31:43 +0530
Message-ID: <20261002070249.338225-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JsyIAEKbwacjh1RIYlX5AskX_DliDhIF
X-Proofpoint-GUID: JsyIAEKbwacjh1RIYlX5AskX_DliDhIF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyNiBTYWx0ZWRfX9JkM0N7MzKGm
 hy4MW4xj+aIPEwrzd0wFVx2LBJO9xrbzDm9lAFUikka0w9k2RdBL7P55pA81CFSXXCJV9lsk6MN
 CIpOUJ9MEvQ1Y9JLeJN8wB5ZNEoWuZc=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abf572c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8
 a=ygIurIEAvY1zSo9kXhYA:9 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyNiBTYWx0ZWRfX+EiCb8/daIDe
 yBEZ/7AbIx/F6MuG8faa5GQkBG4zIDOYbv2r9ZziHfoBjYEf55stAw29ZAqjYqItEs/G9mZphKz
 CVCmAILIZkIQ1Oz+LWMyMsQb4ODQa79GK5kIUczYZdxwT19MuY3G2C8cmus5N5sRIEiqjAyLs5l
 LLaHcMqOcrtx6TbUZ+wQJQXqu4/p7CXhlrwtOTdX0u04aWOqybdrL5Y8jxBGsZ5bx98DaiCIvjg
 /jCuz3kN2EmnMJpYLrDY+dsm/HgDFHZSUaTchUgnLJUVzAfV74bs3Y9wd8K7CnuZrPoluKXYoNH
 vuOtBLYZ+HWA42G6irLwJdpH/xDc1fXKpc8V1SLhaIywIEhPOtUxaf20oF76QW56U7i9klAKJaB
 rrixnT+jBvdRWSnPHuNNLCwidUEXAX4NQPOSdfWmLjfDojcApfFndQd+k70n+jiWD3D+zg2LW/Z
 aN5GGSmU4J0r1kSo3JA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020026

nvmet_ns_enable() queues the asynchronous namespace change event before
the namespace is enabled and the corresponding xarray entry is marked
with NVMET_NS_ENABLED. This may create a narrow race if the host
receives the namespace change event before the namespace is fully
initialized on the target. In that case, scanning the active namespace
list on the host may fail to find the namespace that is being enabled
on the target.

The blktests nvme/052 failure was reported[1] due to this race.

Fix the race by moving nvmet_ns_changed() in nvmet_ns_enable() after
the namespace is enabled, the xarray entry is marked with
NVMET_NS_ENABLED, and the NVMET_NS_IO_LIVE flag is set.

Cc: stable@vger.kernel.org
Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/ar30Q5H1fuyFtDwM@shinmob/ [1]
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8eea0a504308..da98e5cae7f6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -626,11 +626,11 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ret)
 		goto out_pr_exit;
 
-	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
 	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
 	nvmet_debugfs_ns_setup(ns);
 	set_bit(NVMET_NS_IO_LIVE, &ns->flags);
+	nvmet_ns_changed(subsys, ns->nsid);
 	ret = 0;
 out_unlock:
 	mutex_unlock(&subsys->lock);
-- 
2.53.0

