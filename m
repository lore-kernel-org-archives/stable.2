Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599106;
	b=QrofS5I2i3qRB79WZaOrT3Mx2foEVvutQN7R64/uRanmxiYsC38c+xtv3winPtHTpwTS
	 BfrCUVzo3T/q7RgsRMGzDLufP1xfrgZxkm+hBQC+Mue9VJFhXf/wDL+US77rKrKBYryCo
	 0+6sul9twfwf+EQmo5okuGivdd4Yn3fC68pB0a8R+Qz4FwNtbKhcqIZTZdh3lSdALizd4
	 MnhFBCIe8hvyjG9qddjFGjWkmSlOj+Ft/QUNG7JjiRHhD67m/uBgIPhvS5SlzjwwYHt7E
	 yN7kawGP4Ivq4ROS4C/P9SidMVXJ9unmg0zzb/sDJZEapDN3OVxpZ9DvPFbdstrmxtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599106;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID;
	bh=ZgPm3j48OhkmU0/nOyw0pk18bjZECBcGo+qJzz6e7t4=;
	b=JfiMxX6VJ34c3tw17AquhhyQpXYV9Iqc2kSm0Vu9o/Wi2BbjMqw0C2NlK9kox1ea43Pe
	 8T0HXGEwvdC7A7FdKPub1AWhBE8HmQJabrqr2CAj5u44wL3wdproFNPVu5pTkUEU2NY28
	 NZIeTYVC3EOhmRKSjKqmkKgdspt8IGLCaz5+4k8jSU0cK/gV5x31ZID3agI4q3MN6EmH6
	 MdmIr50QkSP/5XLabImPYByo8Q3XeYqw2EhBqNWRwXbrY3ocdmXWv0XuMdzW/7IdJW+LA
	 MsYxccyxAJ1GKgsSROiPPdubAtuTAEaKg40P+rGd+KWzXDF8VMafd9fgC50uZt1+gDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=BowZ2Sef;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F7C606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F7C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=BowZ2Sef
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LDN6a22885571
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ZgPm3j48OhkmU0/n
	Oyw0pk18bjZECBcGo+qJzz6e7t4=; b=BowZ2SefjVH3Ny5W4hcw9W0rPMNrWrVK
	Mbcw0KTenzCy7rnqd003Ywyat2Tq392Z3/NKLUo6LERnRSyn06Ij+gkUSxeMTNbr
	bNilEcWQvszuRlVnBH20Ch5Jsvad8eyOvfLGHA4fKui992zZcYcQWxorqDGSRBHu
	+A43g5aH/OVm3maeebtqVXQwHxkO5Glkw3Ow6j5+Ha0bbUqKZ6YwPqtrs6T1vzxV
	lYaQSQVly0RFCrDW/KaEdrkDUFCFdhyidHfR3Yq7X7epde0DvKRQAnOmI5gaqkUJ
	4TBM5JbQemD/NGL8GqNIgYRX8Lf7frnnN1xX9V96vpJkWaIua0iCxw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hdw4fjtqh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:11:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69LG8pTk2983821
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:11:42 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hf0nm82ya-1;
	Wed, 21 Oct 2026 16:11:42 +0000 (GMT)
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Keith Lucas <keith.lucas@oracle.com>
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH for-next] RDMA/ionic: Fix GSI QP ID release
Date: Wed, 21 Oct 2026 18:11:39 +0200
Message-ID: <20261021161139.4019822-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210064
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX1NEwewGQKJuI
 WfrHoP1Ojgfqwv4OWWNvzZZIHPE5HUmndRFLmyAn4ZTFe10NhfR8pZUF2t2+A2se1v45pOfOE+i
 fa1z9yHScR9fJP7HIF+kIBkHXvKsOSUK6r5yQhlCVymYpW3Chr9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXy388MJDk66ly
 cQ5/2v3zBAKlCKIUfquMhbnuGJVMcGKQrsiBxRTuywgvLlRQFhbsMHF8/r/0AqmJpttnsXLHIn8
 96FEbrb1eWoOyt9OSAQOWVeufXrdALK4NjVKc19moVBWgWu8HTDIw1fe7/XuVnOhDi+dTSiADd2
 6tQE1aKes+GHKKKRP2otj+Ls9+q5D5+25gS+M9D9Upm9v4mlF4tpgtXCyxyV1NYw4Vtiqbav3CZ
 WmEc1DcRTftgWb15JpqqNEBbp3UBnU1xJI8BfnDXFnrfp7Ib790/DVvzuA3nL2QcdzA9Kf7knfZ
 qjTiZitA85/IyyC1d1lzdr//WVfy1oHdMKIG5x9uhDvfzGTPfJ+41OEDEPBFnAFs4ncWfKcvWrS
 PiUhtRZUC7Sm8761xT+lBgr7UYf14nvGTfRT6OxTgh5JfQS9VSlE5Tt34XOCxKRd5UBL/7kbUro
 5x8S9fY4pNpHKRC0eRw==
X-Authority-Analysis: v=2.4 cv=cfNHPXDM c=1 sm=1 tr=0 ts=6ad8e43f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=sG8J6-wLveFn0xi-oGcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PdImcDR6lBcCxy3CHAKes-AyTLtdTqy2
X-Proofpoint-ORIG-GUID: PdImcDR6lBcCxy3CHAKes-AyTLtdTqy2

QPID allocation differs between ordinary QPs and GSI QPs. If GSI QP
creation fails after allocating its QPID, or is destroyed, we see in
the log (trimmed for brevity):

kernel: ida_free called for id=32 which is not allocated.
kernel: WARNING: CPU: 47 PID: 6673 at lib/idr.c:527 ida_free+0xde/0x140
kernel: CPU: 47 UID: 0 PID: 6673 Comm: modprobe Not tainted 6.12.0+ #18
kernel: RIP: 0010:ida_free+0xde/0x140
kernel: Call Trace:
kernel: <TASK>
kernel: ionic_create_qp+0x4f5/0xbe0 [ionic_rdma]
kernel: create_qp+0x19a/0x290 [ib_core]
kernel: ib_create_qp_kernel+0x3a/0xe0 [ib_core]
kernel: create_mad_qp+0x8e/0xd6 [ib_core]
kernel: ib_mad_port_open+0x268/0x3f2 [ib_core]

GSI QPs reserve allocator ID IB_QPT_GSI directly, whereas ordinary QPs
encode the allocated ID in the QPID. Calling ionic_put_qpid() for a
GSI QP incorrectly applies the ordinary QPID conversion and releases
an unallocated ID.

Release IB_QPT_GSI directly in both the creation error path and the
destruction path.

Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
Cc: <stable@vger.kernel.org>
Reported-by: Keith Lucas <keith.lucas@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Tested-by: Keith Lucas <keith.lucas@oracle.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index a70ef59a8064e..cd623f1de38a3 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -2450,7 +2450,11 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 err_ahid:
 	kfree(qp->hdr);
 err_ah_alloc:
-	ionic_put_qpid(dev, qp->qpid);
+	if (attr->qp_type == IB_QPT_GSI)
+		ionic_resid_put(&dev->inuse_qpid, IB_QPT_GSI);
+	else
+		ionic_put_qpid(dev, qp->qpid);
+
 	return rc;
 }
 
@@ -2762,7 +2766,10 @@ int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		ionic_put_ahid(dev, qp->ahid);
 		kfree(qp->hdr);
 	}
-	ionic_put_qpid(dev, qp->qpid);
+	if (qp->qpid == IB_QPT_GSI)
+		ionic_resid_put(&dev->inuse_qpid, IB_QPT_GSI);
+	else
+		ionic_put_qpid(dev, qp->qpid);
 
 	return 0;
 }
-- 
2.43.5

