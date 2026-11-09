Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220194;
	b=3FkbghNrnFpAXsssCj2Wm6k0TnvCMyMckDGlTiKkOKt/Dc2TyeDML1RYcyaOFQ41+b3L
	 a4p4Iuh9UqaoNIjuLJSnPmxXzm4hO8wYDD3aOst25d6GzdcgGY0gPPHdhX9iow2jOWRjZ
	 SBPa8beZElov52nkjatu7JUk20K/6AR3gpyc/JqzQqJFX+zbI4SOvPxMX3x+uvbSBzcDz
	 bJukuZwBQngcFlCmTLfu76tsP9Wh+qlOA+TDL/E5c+m5I9i0ii2qhKp4X5ZE6UQ1YFxcW
	 UB3YcSKen4sZ8NxEHjxqS7pWACOiOuFfO6yNCBp5rbohUh1pE87cTKlQRvAWsZRxESg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Sgmf+WU+GQP3XTy3922ixmErFZ7ksKRON+YrLfcDYXY=;
	b=VodB3gH7hhzqxi+67XcCQOeUXS+V8nJ18eeRbm+gOmQTj4HFlrQ4GxJSg/cQ3pIBxO+9
	 1U9StPrG/FQkVqxAZT63je5DaaMw6hZ6p5MNEZqvs786J9ABId4ArsvHZk0YZo+2n6DKT
	 NktmVy5C9Vh9Htv/dAL2G56TSwGeaqAAe3ZNGOboh9YrRvF7Ye+057suEj562BWmpyL9O
	 0m9cyrGOR0tXFEdxPySfo5wbcNH6LP5w/tM8kSsBodZgiQYwuvU950a9tGRQmmvbS76V/
	 p9dwOu5FDpOwDR86L2C+LSeNXKnGC3Wph5DF6qlCtxZUPXCiMvdFwgsp65K/LngMEog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ol+kNNx7;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4C606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B4C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ol+kNNx7
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9AEWaJ3323039
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sgmf+WU+GQP3XTy39
	22ixmErFZ7ksKRON+YrLfcDYXY=; b=Ol+kNNx7eF8YuBVGCHN8iegCw7RWn3MM9
	hnCM+DKA+vGWvQi5p0GGluJSrAEqvdXkQG5Ym1w3fZ+jCxUkwX6m0rQHewIebdJt
	2q1fOrV8nd+NYwGUu0JqPmxBMYQZ7yuSnyJXtkSwa4D1lFKwTcJRGWfZjVwqBJmC
	HZWVaAJgOMWwpBPYYCmIB0SB72WrCw4/Oc9cpFqwQ5LpEOuyK3zecb69R3IAwk3u
	ndZzcL9l0NJ9uYhfUtlUGXgmMR2Tdqx8xKzuhlwkvR2t7PDGX1qnXXSJ5uBOKicY
	LsEtdpPNuJysImLxas7/dJoJTeIuSwYdrKCseY1ED8ShsSA1hKFFQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ve2p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:29:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9A4xld4047419
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 10:29:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteapyc5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 10:29:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9ATo1v30343728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 10:29:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48CCE5805E;
	Mon,  9 Nov 2026 10:29:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 892955805A;
	Mon,  9 Nov 2026 10:29:49 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 10:29:49 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 5.10.y-6.18.y] s390/vmcp: Initialize full session info to zero
Date: Mon,  9 Nov 2026 11:29:46 +0100
Message-ID: <20261109102946.664117-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061856-failed-5.10-f63eb4ee4a30@kernel.org>
References: <20261107061856-failed-5.10-f63eb4ee4a30@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sejOxGGGJl0K7Nnchws9qEDB6WXG1Zul
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1a0a0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=v87GCxiidlf_rkRV-U0A:9
X-Proofpoint-GUID: sejOxGGGJl0K7Nnchws9qEDB6WXG1Zul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX9/8rWlhR/9Iu
 j6o/IzigeEAL/hnOtMzIcZ6er8k4VejlEnO2oWDkN9fVkaNWsgHF2HYYqyV39h9Vdpf1aCy5Hlw
 7pNBBa6aFjjcVE7qMkgi/UoJqzVEWAs3d5TQ4o2woz8ADTMmfHsw0vSzfmTIZTIZfHD1TS2/h4z
 8H3FetbXALkLDhYYNJR5SggcZ9/RR/xOEKaGZuWBkEl3Ol/XcGr3wj4FVOVrXZhaiPWXXLqmHD/
 I5ctS6VwhMg553LHtAeGgqBRpf3uqX8NPf1TdVVdemb3YRtbrQGzwbjIc02X1ZrtsFgxP5+Qq67
 hQRMVAzt06VPeIKCoAy/+mhKXeXC4sr534/HoUFdt6vuHg3obU2ripanSBLVKTSElxFhVRS3HLq
 NaXMso0E+Qpoi+lhedzQdenQOBiKLGpI77RqJSAYScUzSlng/sxDbceBOj+NszZOFae2JJD5Wr4
 Wn0mLlrSZ7pDpNNnvRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MCBTYWx0ZWRfX+ZdkujwjKBcj
 g6w5+5rDB8Qppw1kUEHVpNiCiCtc+iabK0Ie4AYJiyqw/1PJwFx1PBLZCg8u3x6fBm/BKPZjV1w
 zJRBjTH4bHyGM6jaxBixU4AT9rhd+BE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090040

The cma_alloc bit as well as the response can contain old data.
cma_release will not free the kmalloced memory in that case and
the response code might leak kernel stack data to CAP_SYS_ADMIN
users.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
[borntraeger@linux.ibm.com: use kzalloc instead of kzalloc_obj for older versions]
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/char/vmcp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 69899bb86b3ef..1d07d7b6acb82 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -105,13 +105,11 @@ static int vmcp_open(struct inode *inode, struct file *file)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	session = kmalloc(sizeof(*session), GFP_KERNEL);
+	session = kzalloc(sizeof(*session), GFP_KERNEL);
 	if (!session)
 		return -ENOMEM;
 
 	session->bufsize = PAGE_SIZE;
-	session->response = NULL;
-	session->resp_size = 0;
 	mutex_init(&session->mutex);
 	file->private_data = session;
 	return nonseekable_open(inode, file);
-- 
2.53.0

