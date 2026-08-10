Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9A4334D7
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386099; cv=none; b=F30DTrraPerqADVL+2yQVHmnIQVGcPSP3JLSa7BW8HDBDiEh3tahOGNiBZPRWx7uQyrBwc/i7MFuDPs/T4Et5FuwH/6zEbD3aB9m6XJ1g+Fhjop359D1kH4sIPvangJa2PqsvxbwoRGtkN/0vnmaiOqDdHvDzEMw1nsgrkfgeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386099; c=relaxed/simple;
	bh=8+SJuRBzrDrStNm3+rxug9cuhdQPZyVbow+mJEmAyjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyN6NKdpxVjvythXaqlaS/mgGZ9hRDPv9xsl+usEC0OSVjWtO3lXLV7PuTVCq1ISzunlULCk1WwSjoQpXWq9EaOLoyYbH1RMHkR1AfyGw+14kNDpEMHdSUUfG+CA4nX85kMHe4ZsPGoKyIRLtSWUEZcK0DXHjxwOg35olXH+Wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kYNoMxe0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kYNoMxe0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGVYM8292040;
	Mon, 10 Aug 2026 18:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JJgCRGJhmYHsiMEtn
	it8r6J+pR0L8ayOjbObgh/+RW4=; b=kYNoMxe0RPUTTIw1xw175qao6BJrb4cae
	wpGZkQ6LxvluuhN2FHzb25mTev458ZP99LvjVYpI1+AT94PyI542ra7k3OuQRQ93
	RPLv23mFgobgfcWHS5ooJ/k7pbhIjR8PtxnyceUnPRUgSBbrKIrY9awq8Yg968s6
	AiecNMbUrsPLjT0Joff5lPGwHvqhEPSJr2XGadE28DzKNPETGnMibS2ZNMJOQqKN
	tqxiuqMrTUNu/U4LVZwu1hG2Y9IK+qlJ3jdwv56R0rruEfjFQtfLLjkLKCiZ7E3V
	4jeQRpVE0n9cYgfqY1q4vhuItGcwN0Uh2bU2O+uApmFjAMidzWYRQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjysg5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:21:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIBH8I032362;
	Mon, 10 Aug 2026 18:21:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gwvpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 18:21:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AILVjm28115530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 18:21:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3C458059;
	Mon, 10 Aug 2026 18:21:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4860858058;
	Mon, 10 Aug 2026 18:21:31 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 18:21:31 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 3/3] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Mon, 10 Aug 2026 11:21:28 -0700
Message-ID: <20260810182128.5458-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810182128.5458-1-alifm@linux.ibm.com>
References: <20260810182128.5458-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX7bxNHJQqk1xv
 /gthxA2vSQQ0PyGZQgfrbfCVotYxgMsjcpWiaRqaTg8KqtPc/pk58mR3DFw7pTzRzl4cWU3p4RB
 pNkpLScehKmitAQXVSvzPNTdbYkR4LyO1oYo+vh3CXRZjU6yviLUPBk7/aYL2i/Kx4q7kb9EuBI
 Ep4nAJG8epVdP6c1zZENOdfEPNvY0leG4v9AocCVCa/57qWANGHzI6hB3Xah7DAnQhuOjZ2UQlf
 5wvTxZ/w9yPM9/RKixM2dqi7aYZSwipOM9zu69K5IaknUt4Zz0ap43I+SEJcSjj6Evprtaq8TSG
 WcIyfM2Olm44rw3Gv4lNINWUOEcfUVl8MQMZ/siqOQi9z0YpE3+R0oe/dsctnoXWjnkl8cKqr9J
 VNyzkmuSFtIOYlsx01zzjSfGkGwMsQlWmqynwv45d+0mQEym6IS8jYz0M4M7KT1+9///JKj1LKl
 t607KQPXJZQE3Pb/0zQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX1FoSyH7oIBSv
 PsDuqMRUk0UsX47oUVqiN9h6DJuCOp/FYwRnNNn7D9EApTE6ogbEEXeTBdbPJvcOTD5pjh2XNcg
 yYKthptJ976nYeyPid5lu2quWpSPx3Q=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a16af cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=BhKMqK0UDOEe-qkoVwYA:9
X-Proofpoint-GUID: mE1mRfGqBj-zVEss_r1hVJhJfSsaVgic
X-Proofpoint-ORIG-GUID: mE1mRfGqBj-zVEss_r1hVJhJfSsaVgic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100154

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages. While at it, remove dead code that stored FIB
values that were never referenced.

As part of the cleanup, we are also holding the aift_lock a bit longer, as
we hold the lock while executing the MPCIFC instruction. Though this is not
strictly necessary, it means we don't have to drop and re-acquire in the
error case.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 5580c9858f1e00f60191eb09c3add359836d60b6)
[alifm@linux.ibm.com: Resolved merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 56a19c00d3b7..930c5141f2f8 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -360,19 +360,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	aift->kzdev[zdev->aisb] = zdev->kzdev;
 	spin_unlock_irq(&aift->gait_lock);
 
-	/* Update guest FIB for re-issue */
-	fib->fmt0.aisbo = zdev->aisb & 63;
-	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
-	fib->fmt0.isc = gisc;
-
 	/* Save some guest fib values in the host for later use */
-	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
+	zdev->kzdev->fib.fmt0.isc = gisc;
 	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
-	mutex_unlock(&aift->aift_lock);
 
 	/* Issue the clp to setup the irq now */
 	rc = kvm_zpci_set_airq(zdev);
-	return rc;
+	if (!rc) {
+		mutex_unlock(&aift->aift_lock);
+		return rc;
+	}
+
+	/* Start cleanup */
+	zdev->kzdev->fib.fmt0.isc = 0;
+	zdev->kzdev->fib.fmt0.aibv = 0;
+
+	spin_lock_irq(&aift->gait_lock);
+	gaite->count--;
+	gaite->aisb = 0;
+	gaite->gisc = 0;
+	gaite->aisbo = 0;
+	gaite->gisa = 0;
+	aift->kzdev[zdev->aisb] = NULL;
+	spin_unlock_irq(&aift->gait_lock);
+
+	airq_iv_release(zdev->aibv);
+	zdev->aibv = NULL;
 
 free_aisb:
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
-- 
2.43.0

