Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD563FAE1B
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327729; cv=none; b=CGmFvwc3Ptchq8btOUPMcvvo25Q8K48dY5w0Meb/m8vIuY72vgeN5IH1UpDrENjwmAJXGV4GHM0vAObj70YYRdL+Ll3g4uRAskca4Hykkk9dLm4sd95ouInKh5IFO+PPMaCT+dsg+Yogw04Pil5mjcE1QuTKzxpSG9TriiiIngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327729; c=relaxed/simple;
	bh=xM6/okhYflECMEneIeZKarjv5qK3xZGFBLjla8eF+bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjBaka5K/8nFRlZ5DWboIuW9ZsJ0yW4UxTXKs5tzs7XCjgfOW4QU+kZR3XTMI08iMDuDtFwaiAJzP28FSfWkldvDzyLYDlnvKkWMZSp/hpHmuXUIQz394+Aj7tbIAqnnrPiodj8SBBvrQ0XYxnVs6YAaxrO8FJ2H0CsqHBot29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JlFqREC4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JlFqREC4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MILNI2304038
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 08:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=lW8G+tDv6Wk1GGW/kMZTMSbppMn/cD4jk7qeV45xa
	So=; b=JlFqREC4IPcAbyosDS9gEDfEzhlKc7fnEOH+/VWYYMult+brqrh+dJiEW
	vNAXSOE7xIHkB+fnHLQzYa0rFwQpaxMGgu+kKB5Xc+4BvIlAdKlsCwGoNb+UMvRX
	f+fjw05ghwSnMqOnK6O3IsnYq6G0B6IF12kgCN4qI5RjJnDl6UxAmM6C/6qwOce2
	2tfqvC/MkV+rilJXBddjDjoztNAiS3S+q3DINFPSnQk7WO8t2c8kRGmKNjcb7IB8
	VbDJUecbv+BjW94p43GylbHT4i/WCHberaO/mxFa0UnsF3PwbRzyj/J+0od0SpPB
	e7whfAMFE0/9Oel4+eAoJy6W5qlLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gjn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:48:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668Yel0007899
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 08:48:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvvy3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:48:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668mTBd26411354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:48:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA0FE20040;
	Mon,  6 Jul 2026 08:48:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B46532004B;
	Mon,  6 Jul 2026 08:48:28 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:48:28 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: aswin@linux.ibm.com, wintera@linux.ibm.com, pasic@linux.ibm.com,
        nagamani@linux.ibm.com
Cc: wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com, mjambigi@linux.ibm.com,
        sidraya@linux.ibm.com, hidayath@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH net] net/af_iucv: fix use-after-free of listen sock in iucv_callback_connreq()
Date: Mon,  6 Jul 2026 10:48:25 +0200
Message-ID: <20260706084825.6231-1-hidayath@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6be3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UbVHRO3OadWMqvE3euwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX4bdrdkisOGdo
 1Gen7uibeheNiahPn6A4vSRnD7ldfvd5sPe3IcCRVXH+fk4cljZm0TPkABdPZ9iMlvX+CG+eH7G
 TqlgMKz3BjZ6xKZ34UFbEivPEUZeeXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX5HahXdZl3cXN
 X4ZIvS46ExNNDF15b+u3IAGCA6z+PlHxVvBH7U2lljV1wRO/ReX8P2QCw265wLfAQ3SO9I8JFRf
 7kTz+BiKWF43Jv7M8/pR7W2jMJWq8e1XW+HHRO8xg2FJEjx8ZdoFhfDwT0pl2/d5dXKs7ut4dIG
 j8heX6pShkWxYNVVbHM5Qk6y+02zRyo1LeI6tFYR9ybae51am7aHPT+IixxONwM/M60dXLvVZvp
 TVWtCUocTgmmSXNTScDGtYRhGLIGGQJzLcCgqxlEDIh/1bSArJLmIMldRCCbW8umo77a79Plqlb
 eN4OGGC7HwS12HNtyqnmEWrJjfB2b9Iwov0eVACGaQzVTfKtgpDoCBpS89Imn7w6VmDHVCcnIt7
 NJJ8wlOzX2qClxGtJykRke1qwYe0h0+lzLt6wQBUakNzEssRyue8m9VGpKyRuyy26hYA7WmT0ps
 13tIv3WkfzsUsfa3U1A==
X-Proofpoint-ORIG-GUID: e8-s_10ObFqK7p1Q_V9ywGrjnVbf_-iw
X-Proofpoint-GUID: e8-s_10ObFqK7p1Q_V9ywGrjnVbf_-iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

iucv_callback_connreq() looks up the listening socket in iucv_sk_list
under read_lock(&iucv_sk_list.lock), drops the lock, and only then
uses the socket (bh_lock_sock() and the following connection setup).
No reference is taken on the socket before the lock is released.

The callback runs from the iucv tasklet. A concurrent close of the
listening socket does not synchronize with it.
Between read_unlock() and bh_lock_sock() a concurrent close on another
CPU can free the socket.

Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")
Cc: stable@vger.kernel.org
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 net/iucv/af_iucv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index fed240b453bd..890d9df5ae36 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1616,6 +1616,8 @@ static int iucv_callback_connreq(struct iucv_path *path,
 			iucv = iucv_sk(sk);
 			break;
 		}
+	if (iucv)
+		sock_hold(sk);
 	read_unlock(&iucv_sk_list.lock);
 	if (!iucv)
 		/* No socket found, not one of our paths. */
@@ -1684,6 +1686,7 @@ static int iucv_callback_connreq(struct iucv_path *path,
 	err = 0;
 fail:
 	bh_unlock_sock(sk);
+	sock_put(sk);
 	return 0;
 }
 
-- 
2.52.0

