Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF725CC57
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334607; cv=none; b=Cb1frcR2zOSDv7TDOfBA7jWAwrsJQDj68S9CJwGkYI1mGwPuaiSp/okfTNKbDoWO5tqEv3i5MZiEEKoCAqGrZOLqW0arDCBhliBlX6P7cvohxckF/1na680R65uZ3HQwvKTYaBQa7bJtbi8U7i7+weEasbIqt0owX3dnBY1Q2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334607; c=relaxed/simple;
	bh=swYgNpL3HQnqggnpIgozmzxmOvpgXxag8qPtxc1RaF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCQsuOIbJjBcOyvKGaM8LKgXCnvByUkZLzgkPy5hlRqP+EYpd5F3vAMnlh7oZsiXX1zwPGtl+olQnEyY5RgKPBCiX2fLw/lLRC0ehLo2IEpZdRjkySvzJVq/nZgFlF1ZGtFxTIseZ0VYFPyFvu4hOcE41WZlLG8l2Ne30i4nrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cpGPFQr3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cpGPFQr3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LG1Ydt145506
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hYFs6a7Z63UM3ZUkm
	Ki3bojxIvFrcxKM8CWHlCdicDU=; b=cpGPFQr3EP2HO9ObNd7n9by7fw9e+YxV/
	k+I8UtyRf1N8WntL3DWITU5gpX72NPOP8dlcxUnQuFESLygdguCP3qJMjE1v6chY
	RKEsI4i8xnFDoiSpDba7oXZr5xeOu5UWPe+CurFxIpYK0r+5j90PSUoNRbZOTpZA
	JIkVYbLNPEp+Bl8VKXkwRjTGCL6csNNQSzh09+2AQKdO8ojbhKILv5y2AnRqnERQ
	eq/ZEjafzqyRV8l2pkqawXNxILkKz4D3m/n/Yn1Xz4MGmjDkGo9ldTApMgS/BmQr
	gMoATdVFg1kOXNf0ug4dfUMPU4o8L1NSzqDvQIKuvPRXVTuABrJvQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0k656-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LHfJnW008946
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ywsr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LHo3HE26411642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 17:50:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B8615805D;
	Fri, 21 Aug 2026 17:50:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A503158043;
	Fri, 21 Aug 2026 17:50:02 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown [9.61.78.161])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 17:50:02 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.6.y v2 1/4] s390/vfio_ccw: Free all memory if cp_init() fails
Date: Fri, 21 Aug 2026 13:49:48 -0400
Message-ID: <20260821174951.3467637-2-farman@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: q4SBuZo6scOe94a6_TF91qxO9n1qQeIx
X-Proofpoint-GUID: q4SBuZo6scOe94a6_TF91qxO9n1qQeIx
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a888fcd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=WEmllObKAWPfCt-5-jUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX5V2ROXL8e/ZD
 BHdol+rK3kqibSSB9L7p4Ztft414IQJUWYpguGpI+OEEkcEDDWIRIHaoUFUQE1JdKUo4FH3J9EP
 csh9t18Alry4RTYKNwbacU8aHt3FjJM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX/7CLoLBvA5La
 Q6w76CKn3XQ/qzOh+a3WLHqeY45UxBn6z7kEj5RneXAfTDC5z5IWbruwNgkReoSdo+890Mo7xas
 ChQFj1a3tv0O/gbESw/gR7/tXPad+0Rc1s8VEHbRpXRUAei3CuTR0sgeHTjpIECAmKjsNInIz3t
 ti6k/Fe8pr5jVTaVdVEj7PVawP5PxE3KSuKGIAbxRs0Gz7NvOKyYGg9AhAoIRIrnylVBR1SsRoG
 08+ZdeG8wL8jnEcZ8jrNokZA52kb+UQa0+N0HFh40LM7+NPN1h8sCSsOGxt9ENdFfARqaEiqhPk
 9gGnLjV/djxcQzeRP7tK8axbot/3xcYu1H1iWaE92Ks64ZzTiGsv75v7Zs7KaKenu93ksbr4SEY
 zg2lNSszlztR0nujiXH7VCZ9p31RnR4T5iGIv4pIZMQAqKPDN2kS1UC/JgQNoGsIZYV1sa3pd+Y
 JpfnS+uR3YBVzMZI3Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210138

The routine cp_free() is called to unpin/free any memory once an I/O
is completed successfully, or if cp_prefetch() fails. But if cp_init()
fails, and cp->initialized is not enabled, the same routine cannot be
used to free all the memory.

An attempt to address this exists in ccwchain_handle_ccw(), where a
single call to ccwchain_free() is made for the currently-processed
CCW segment. But this will leak other segments (created as a result
of a Transfer in Channel) that had been allocated as part of the same
channel program.

Address this by performing the cleanup outside of the recursive
ccwchain_handle_ccw()/ccwchain_loop_tic() logic.

Fixes: 8b515be512a2 ("vfio-ccw: Fix memory leak and don't call cp_free in cp_init")
Cc: stable@vger.kernel.org
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 74186c2968f8f756ac3226b545b598457c910c75)
[farman@linux.ibm.com: resolve build error]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 933eb4a6cbdb..741225b4cfe8 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -450,9 +450,6 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	/* Loop for tics on this new chain. */
 	ret = ccwchain_loop_tic(chain, cp);
 
-	if (ret)
-		ccwchain_free(chain);
-
 	return ret;
 }
 
@@ -481,6 +478,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 	return 0;
 }
 
+static int ccwchain_build_ccws(u32 cda, struct channel_program *cp)
+{
+	struct ccwchain *chain, *temp;
+	int ret;
+
+	ret = ccwchain_handle_ccw(cda, cp);
+
+	if (ret) {
+		/* Cleanup if an error occurred */
+		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+			ccwchain_free(chain);
+		}
+	}
+
+	return ret;
+}
+
 static int ccwchain_fetch_tic(struct ccw1 *ccw,
 			      struct channel_program *cp)
 {
@@ -728,7 +742,7 @@ int cp_init(struct channel_program *cp, union orb *orb)
 	memcpy(&cp->orb, orb, sizeof(*orb));
 
 	/* Build a ccwchain for the first CCW segment */
-	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
 
 	if (!ret)
 		cp->initialized = true;
-- 
2.55.0

