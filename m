Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49C2750E6
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334611; cv=none; b=OiqQEUqj5PnEgpvwewJ0yrEBq+fL1cQVYo1l8uXC4KUa7MkIqWZbEpsvje49xocUXWbw4cc+YcuFR5bqIzt/r3DzyfRezK1gKpkUpc9as8mcNarTT9IevlJDXp4STdW2549OaYZDWRN9AIQuTxHLE7pxU+MLvvJlv9fRbj0gF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334611; c=relaxed/simple;
	bh=yKP7RJcXiWLK5xxZLsUYlSUArq00oLLycrUxhi2+Cjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du+cletxEvpvgWShSpaIYA22G4Ek7FiHG1F2wvPpQh0c7+wp5vo+YvRnu7V33syHcZNMkB8kjUDAR/bAb1SqoJee+ulK5Pz5hlxnU16t1S828uBCp40l0079shpBRU+3sYlbVj6SfRqSx2KAwdl30YEWbfsTMoYazqe3Q3q1fqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fw9WS9I/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fw9WS9I/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LG1o7g2040382
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wfZyfJ9Jz0n2QMxxJ
	BQJGHYWrOznatYgOwisn8mxJ20=; b=fw9WS9I/cDeWbjBF4ReG8sECQh/oBnS3d
	Ez8UF7LoilDn+dITDWvScWCj+EEn1zsqzIYU+x/hIUuNNuOnrAlr0oo23DWQ2haz
	34CwZpaEIili+GBSRmkec1VSyo6ARrER5MPaANSvl+D4Du9yN45ZT0Q6HGMbQbFZ
	dab0Y+udZlIm6kCMw1a6n18O5UAyJ1RJrCAALpnXEN2PUDgbP8ZvAWZbuwFpcD5H
	SnipTH5Vwq4uF1z0/GqyDx2c8FrWswUMCqq7xf9KaMLCkrbnul+zGdf7gTjo2HYu
	KoUBPQsfKWLU5FKvlr2rFXOp0q1SfPSCUs4HsefarQbpguDX03jXQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4jyf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LHfHVi020596
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqp7g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:50:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LHo5TZ24183476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 17:50:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F9A558059;
	Fri, 21 Aug 2026 17:50:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A7FB58043;
	Fri, 21 Aug 2026 17:50:05 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown [9.61.78.161])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 17:50:04 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.6.y v2 2/4] s390/vfio_ccw: Ensure first IDAW remains constant
Date: Fri, 21 Aug 2026 13:49:49 -0400
Message-ID: <20260821174951.3467637-3-farman@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a888fcf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TyQ-expsAN5g-WtpmiwA:9
X-Proofpoint-ORIG-GUID: FhnZHuFG_Imh-Ybi9QMhL8Ez3TTbK1aP
X-Proofpoint-GUID: FhnZHuFG_Imh-Ybi9QMhL8Ez3TTbK1aP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX9EHfv578ad3R
 fagHQ5Ypl6TY1EiRaOQwaP8cDoNevPXoEptIfQXob99K5aCBN0TjDqNI3CG2JemHXtfbNPtuoqK
 r52HqQYFBQFdch5f/82Bncsblbk/Zg8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzOCBTYWx0ZWRfX8ta7JnX1XhVh
 MB9XgbItYALplTS76GH50pOa5EDAKTmFE5QQxsZ/c22zl8KyfLKMDwU1OhUZ9arUK2OBBYCdPJn
 88+WiTf5VhNwEOkLJa3WcqhFRlsPh365yAs5NNMebKiz1UXJjIeZnsO4QfWkmBe1JFmDqKGVhgf
 tKvFqvH8CPasy4zljHTAyBP5pAGafpz2f56M/bJZFJ//m6QFcw4XiXLxoIJoatp/MGcm9tSk+07
 RJkAVijRrX3da0hW1IPa6XymovRIcvsBA5EuhvZvv94n9gTXJIU4WaaDjSnI3XZ1xlRG8G8As39
 18yhFKgd5dpo0UstxeZ7IBiuesRHVR1siLpF/7e0hH12GnGsQgO+/OuqxBUXJ+ZlWoTG7QC5iaM
 ZK/spJOSFVRmhRkCR6AlSfGysLYdp++cKB674qS8qLwyOTX8C/SJXJMfC1HUjjH076Dv/SuiCwH
 dnRz8yRQ0kgZD2yEV1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210138

The first IDAW in a list does not need to be on a 2K/4K boundary
like all others, and so is read separately to accurately calculate
the size of the buffer needed to read the full IDAL.

Verify that the address found in the first IDAW is unchanged between
reads, to ensure a consistent set of IDAWs being worked with.

Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 565bef268d75bf7df665bce6923a88cd0eb74592)
[farman@linux.ibm.com: resolved merge conflict]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 16 ++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 741225b4cfe8..22bbdfa7076b 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -521,6 +521,7 @@ static unsigned long *get_guest_idal(struct ccw1 *ccw,
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	unsigned long *idaws;
 	unsigned int *idaws_f1;
+	u64 first_idaw;
 	int idal_len = idaw_nr * sizeof(*idaws);
 	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask = ~(idaw_size - 1);
@@ -537,6 +538,18 @@ static unsigned long *get_guest_idal(struct ccw1 *ccw,
 			kfree(idaws);
 			return ERR_PTR(ret);
 		}
+
+		idaws_f1 = (unsigned int *)idaws;
+		if (cp->orb.cmd.c64)
+			first_idaw = idaws[0];
+		else
+			first_idaw = (unsigned long)(idaws_f1[0]);
+
+		/* Unexpected mismatch from earlier read */
+		if (first_idaw != cp->guest_iova) {
+			kfree(idaws);
+			return ERR_PTR(-EINVAL);
+		}
 	} else {
 		/* Fabricate an IDAL based off CCW data address */
 		if (cp->orb.cmd.c64) {
@@ -598,6 +611,9 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 		iova = ccw->cda;
 	}
 
+	/* Save the read address for later */
+	cp->guest_iova = iova;
+
 	/* Format-1 IDAWs operate on 2K each */
 	if (!cp->orb.cmd.c64)
 		return idal_2k_nr_words((void *)iova, bytes);
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index a9b1d8dbc6f6..9af98ff12d67 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -35,6 +35,7 @@
  * @initialized: whether this instance is actually initialized
  * @guest_cp: copy of guest channel program
  * @ccwchain_count: number of channel program segments (linked by TIC)
+ * @guest_iova: first data address of a guest channel program
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -46,6 +47,7 @@ struct channel_program {
 	bool initialized;
 	struct ccw1 *guest_cp;
 	unsigned int ccwchain_count;
+	u64 guest_iova;
 };
 
 int cp_init(struct channel_program *cp, union orb *orb);
-- 
2.55.0

