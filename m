Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250339792A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252759; cv=none; b=p3pVcwiqCxv2RL3lPaFj2bFRmDLqnZgWLgUyTqbzYkHN7oA30rjD08eTpxsfwkVbuEtzg3WzXBoPnPG4kxWVer2kchjme2eGisIdDM7OUeRmwsNbNHQjx5BgAgUs/OxyZWX+AtUlJwgq8yRvPpk7z+oZgUKlmdQE/QiNcWan/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252759; c=relaxed/simple;
	bh=/HKKUrJ6P/h/EpgphaIjg2HxYVkcyXtQF7410C4eU90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqHhvDsw4LIva29CFcxOcRvIkV0kgqcCRaJPa9+kbGSeHbZoAjx9dF5puYOJdwdsYpFEmZbaTgQWf1KRw1Rx1OMyIrzV3yI5dg1OyDHCsmMcqDLWEWeLycWPGkfmxwlp8LcgAB7jIavO2dtqqSKJvbO4uhr1oixpDq5LXQcpBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MoAdQAXb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MoAdQAXb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KIVvMU3233065;
	Thu, 20 Aug 2026 19:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yZ2e/7NaoRc2vNuUi
	hkHEhJ0FtqCUVJ2E0Usp1IWfNM=; b=MoAdQAXb1SIKjaqC0sz6aqv28WaBa1QL+
	J5/nWOJl4wITuUuv/w5gHHSUk85X0rVShqi1ia2diqih8MdbwFv9ekbD3T6qOA+0
	o9QX5+JFVnoyLB5DaNljgBm0Yp2e7i4UNPb3QvUkpl/2Dyb4PMJ9S+lIFQkwaGKP
	hSobk1QFQMpnM4URy5qzuw7O/FkKUp6dyyE6agaFou3zoNCHKC9XMpNxazrOn3++
	XrB7usgu8AlpRna6y7WST6M6p6HC952vaJ9izcNVF67x6EkF86bZJMFesg/PUeVe
	RZSwcnjarvWaGd5yJGD5LGwAkTodtxEwnhRHZQZQEbSOakB3Xhblg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4ccm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 19:05:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KIuJoa032655;
	Thu, 20 Aug 2026 19:05:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekgbxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 19:05:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KJ5rk930802640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 19:05:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2828C58043;
	Thu, 20 Aug 2026 19:05:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BC8758059;
	Thu, 20 Aug 2026 19:05:52 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown [9.61.78.161])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 19:05:52 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>, sashiko-bot <sashiko-bot@kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.6.y] s390/vfio_ccw: Calculate idal length based on idaw type
Date: Thu, 20 Aug 2026 15:05:50 -0400
Message-ID: <20260820190550.2690100-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082058-slush-preface-49a0@gregkh>
References: <2026082058-slush-preface-49a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX52ReAoUAxAnn
 5m32rgBmDIX/ztTX+gIqxLx/Od8iIE3gqmDwv39usYn0Wh1uN1V/aLMLWs5sF9JXKeKHWdDecWM
 7d+u0/QAqthgTXz66zcWu8MBLI+bed8=
X-Proofpoint-GUID: bJUlwVYQW-xZaDgrjQAwULhPOgYxXvF2
X-Proofpoint-ORIG-GUID: bJUlwVYQW-xZaDgrjQAwULhPOgYxXvF2
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a875013 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EwhpepNkZwNmKqsVLwcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX2PDcR1KtgfBF
 tXJXdHLH4ZVimdGOf20vAR/aNcx40N9RntGTgrh2Px3bMFSSJBCeSyIvVpAFDkY/lJawmBo8+gd
 y7pjUoX24XuWL0Qk5mAmOVOD//w93bTjqBWytrLv1T4wnUiGV/UD4XZgLHSaI5ubj1NpxH4n2Pe
 weaNr1fTGKdBDHLnk5n/N7G/2x8x+RE4imSSlsD756dhqL0d2LxKPEbM64515zNITpKJmxvld9o
 0qfRXSqL4SvriUl94N0YBEXIOQqu1HMDA+O2HP9JYBbyXism1Qml1YTnQJvfXdeukr8v6jPfsVy
 Ho6GDJ9D3RyJZkR5MXGxMt8+7qmvAWCLUPmvaGTra6m5BIHIyHEo8FqVRdd4qE5rSIu+5G0xAYM
 7D01kgbBc+MMtOh6REJ0ODqMCDnCRciOOWRBI1AdrAklxdfMqqWVPx1LYEwakE8HjeR9WWEqwWp
 7ELjuTp4C/u93arMBnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200143

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

