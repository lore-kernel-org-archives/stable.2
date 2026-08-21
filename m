Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFFF1F30A9
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334620; cv=none; b=go5zz5TXCAhiMmGoOnWw0Xq7Nb8/S0hh5VLVm4eZnf8mjrHTRS9M21WfbuYKeHSx3IppddTy5ycuX3fujO1NHPhS3t+arwzwvLznRwz2TzaP+PqKd1m9s0XPRofQ5kxxPMOMgTs/j2C3McfXRzM8sL4gt2sQu6rlVJDJmz9m1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334620; c=relaxed/simple;
	bh=/HKKUrJ6P/h/EpgphaIjg2HxYVkcyXtQF7410C4eU90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9LekAdGdrTV6Q0/VoO33R0AzPWWcFlzInYUsciPp3rkBhnJijrInAOkABkfA9xRVVZNhrmYL+m1PLysRSTmOu9v9q0CoQzeSPSzLDsJJHWVWtmOX5/WSsLLNBrYsNmPy0KzpDBZHCFetBygDtmmQDqdaKh6fZrFNn3Mtx606wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Go+tL0z7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Go+tL0z7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LG1cCE889254;
	Fri, 21 Aug 2026 17:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yZ2e/7NaoRc2vNuUi
	hkHEhJ0FtqCUVJ2E0Usp1IWfNM=; b=Go+tL0z7tP9nBy6u8exMtdJyWG39XW4Gc
	cSGlhHXNSOv4WffqrcAKALdsWp3af2c03Xw0eMDWXSliAPokbiYaUm0ycYBrpP6a
	G/HMiWi0cNSdcchJEtlSKCW4X6VBsihLpRTAL1IwJwf9D9tdA9LAqy9fxsqOVdog
	+Mhqiu7iL2PxCacZjMHVsio0HPl+KwvxWqe7c8SZqyuxqu6MuJq5aFyPKumESI8y
	T1BGS/U3jbtvGcGxfiUJPIMF9O30BB4O+WXYwve61NxJXqqR4tUAb3EmYJ1orqyF
	wrTmH11zYkYOnDiqnm26LDYn1YDsDx/1jz/QrHg+rS76+L30H7gtg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2k1da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 17:50:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LHfJIl005617;
	Fri, 21 Aug 2026 17:50:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngwu41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 17:50:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LHoEVP31916626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 17:50:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 773BA58059;
	Fri, 21 Aug 2026 17:50:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACBE958043;
	Fri, 21 Aug 2026 17:50:13 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown [9.61.78.161])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 17:50:13 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>, sashiko-bot <sashiko-bot@kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.6.y v2 3/4] s390/vfio_ccw: Calculate idal length based on idaw type
Date: Fri, 21 Aug 2026 13:49:51 -0400
Message-ID: <20260821174951.3467637-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821174951.3467637-1-farman@linux.ibm.com>
References: <20260821174951.3467637-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a888fd8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EwhpepNkZwNmKqsVLwcA:9
X-Proofpoint-GUID: ILc0crmZhRrsCQXZC12qVlck-8JxLdGs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX1P2kFdq/5jr7
 PzFNDhlHLzXCWbLSYe1ZtV8kNLE8KcslCq2zgeX7yD+MPdLem/+vFrmYIJIsxBTQPeI/djcrzoG
 MNrg/oEK5q5qoHUlZlN5nJuza7y4VVK1wQEkLrSuIcZMFyi5/Tdc8V8y9+iWQ+gGZ2ygjKecGJI
 5+wpg/8iBOb5EvtJ7jRfX80g6Rtxtbc4fciqrCsLuk67GHNsGFn+6YYPzMPJJIxI1/29/3QWHYE
 KrJOfaQV2qKGO8AZ65I2lvf6/jGPXpGz416Edy78h+hXriGv9Rsss1wci7g3F3+UhszyMTFXFB9
 dcYeDFfQJbhORTSA8n39gF67oXGSWc0+9x9osyb3UY3q6TzdKKOGqjN6MJ+HAdMT64mMYcckhej
 CojNca+FiUt75Ry3Fi8Un4IM1XQPDr8WQSRjZcqAJ4UrtN67MrDg1AScUYg320I5AKKyWKoFWuE
 kmiQKB6qOh2PvzTUGNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX00UDTpUBVaDW
 AbU+v3hZfAS/vIlZt9SJcHAjou8t0z9xZNx+lFbG/6ZA/YkIWyKNatVUalWdprRVThxFphlJuJj
 4XgYBOALLc76leHOiGgcapcMI0wsQy8=
X-Proofpoint-ORIG-GUID: ILc0crmZhRrsCQXZC12qVlck-8JxLdGs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210138

Sashiko pointed out that get_guest_idal() unconditionally calculates
the length of the IDAL presuming everything is a Format-2 IDAW.

The output of vfio-ccw is always Format-2, but the input can be either
Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
the size of the guest IDAL may be incorrect and should be trimmed down.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/
Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 4f6fdc6e1a7fbfa36b945af33c65a417948feac0)
[farman@linux.ibm.com: resolved merge conflict]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 22bbdfa7076b..bbc57a60e27c 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
 }
 
 #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
+#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u32))
 
 /*
  * Helpers to operate ccwchain.
@@ -522,7 +523,7 @@ static unsigned long *get_guest_idal(struct ccw1 *ccw,
 	unsigned long *idaws;
 	unsigned int *idaws_f1;
 	u64 first_idaw;
-	int idal_len = idaw_nr * sizeof(*idaws);
+	int idal_len = idaw_nr * get_idaw_size(cp);
 	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask = ~(idaw_size - 1);
 	int i, ret;
@@ -587,7 +588,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 	struct vfio_device *vdev =
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	u64 iova;
-	int size = cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
+	int size = get_idaw_size(cp);
 	int ret;
 	int bytes = 1;
 
-- 
2.55.0

