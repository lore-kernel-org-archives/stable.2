Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B8443AA7;
	Fri,  9 Oct 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549069; cv=none; b=aDKI6/5kE2/S/FEGO9Ab5apHFPWjUjvoSdcA6MTEtvzvxrHMkH4pI4xJQjwgwbW4/sEbWnWxn6K0StCIj7YFCJy2c0dMe37elkmB0mTHyTp8W4YaMnaLNwilyUIRkhcaIHVJzgpRfGePdd+8w5HKX6xC3ITA/pCmweBKqTFC6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549069; c=relaxed/simple;
	bh=YRpD/YvnNzt4W2F3ZRGFP4X1Za+i71uQKuroGq+JQ/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRO5kSWs/cPPnsyfmpBy6nXqlrF0x3NwuNMx1L501ejeVqYY3YAgMvPnmVHZQyrpVgFjzWxH8zvDqCLvAcPrZZg8zQFDXSvxH6ZerS6YzjMX3Bhp/hXEaodfuGVpc8q4cCvGy7A+LuhQqVKIDfFBlgjQPh+7JYU6lH8Vhid+UQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kx3xdYSu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kx3xdYSu"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZbGh2007633;
	Fri, 9 Oct 2026 12:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0Obzzuyf6UDc4Rtgj
	MD1oVFqbMVj+dMH5esCGJtY0AY=; b=Kx3xdYSuvbxgKGubGeWqVeF415V2IWfwJ
	rVSy3KKx6Zvb2ajQMWtD7xGaC1aeg6HHL1wYxgddbUt/32zkjMhnCwN3tgWvXVV2
	otVWFoLKOSjFq2r0fLF+igbYiyFPAkAg4YcFzM1qXZZd2ytrNpE9N7Z14T+NNxZH
	F7s+SwaKzWq1+cLUwtl8NP4o+jnO48WZFEcbhPr+/hv8vO9VZiZ+NJtEzbKI9WQQ
	g//m9dQuTtHtiSRdsydsMRCF8AomEBtbZo/w/K3E2TmulS4KtoJa9G6yjt69TEPc
	OmsPhxH2el2l71/Fs2/pyskp1YkECfLId3yJFDOEeH7g/jW7yJ+SA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwanm2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I36b621423;
	Fri, 9 Oct 2026 12:30:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnjyk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699CUnvn50987432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 12:30:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 464A42004D;
	Fri,  9 Oct 2026 12:30:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A45AC20043;
	Fri,  9 Oct 2026 12:30:46 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.27.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 12:30:46 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/4] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
Date: Fri,  9 Oct 2026 18:00:30 +0530
Message-ID: <20261009123035.157770-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009123035.157770-1-gautam@linux.ibm.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Fll5bl914Ol96e5QJkZrz3jAdKURsARL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfXxeWO/B1QN46r
 WaeSlD27AQcEbg6wQtgVcVzEPUVg0feSW8DWVr99BSC+azN/9UuAPQjRPDCNfLZ7EhkZpviBjUr
 VjR5cbHeZCRfhHuVL01a4H+Xv+YlMHYY6z63f1XAkceQQydSnghf193CiHaE3xvuHbc5te4i2VJ
 sydLlbe6mKd4DT9H/qAvnDyrFywjaaS0Cg67x3SKa4JOi6R09+xnR31qAetfA2UJ4D7eZmgkHAR
 +ks0Cp+XaoRrb7t2+b4EP1YMhIVyqdzureJHfxP2X8f0vssigTjMidlZZw6TxP7ap8FatFkNj58
 3D7mATDb4Jcx0YgzlZQOhPmueohk8al+3mv2ntyUlRrkrRgPKdt0XoC7Kexmq5mqvqmZadMztI+
 /m16pi6H+bVVKqL7mtTiOpiiw3OEdFRXXSAJwrYvWXBR7Bb+t3WmjDcZc0RKMWlO0Gn0kFEeDAZ
 xVul1pq5vrti38yoQFg==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac8de7e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=6c1f-Q0peJaRmYMZMr8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX7PLLc37vgm7Q
 vWrft5LCfopf062SMX+ARqV1NR1Byw1inResWkwj7lJzEzTjOiJCDqYE0v8INGkdXpTh6/HSrl+
 /7+iDdMwkxNORjgKkAMZlPrENoJbkC0=
X-Proofpoint-ORIG-GUID: YOh1fUSu13F-JrnsYlurt2PPFQS2QwoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090048

Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
According to the documentation [1], the caller should provide their own
locking to prevent concurrent modifications to the idr to prevent bugs.

Wrap the call to __prealloc_nested() in	a spinlock to prevent concurrent
modifications to idr.

[1]: lib/idr.c

Fixes: c0f00a18e2a8 ("KVM: PPC: Book3S HV Nested: Change nested guest lookup to use idr")
Cc: stable@vger.kernel.org # 5.19+
Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 34 +++++++++--------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index a6ff42d7666c..e893fdd24f0a 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -702,20 +702,6 @@ static struct kvm_nested_guest *__find_nested(struct kvm *kvm, int lpid)
 	return idr_find(&kvm->arch.kvm_nested_guest_idr, lpid);
 }
 
-static bool __prealloc_nested(struct kvm *kvm, int lpid)
-{
-	if (idr_alloc(&kvm->arch.kvm_nested_guest_idr,
-				NULL, lpid, lpid + 1, GFP_KERNEL) != lpid)
-		return false;
-	return true;
-}
-
-static void __add_nested(struct kvm *kvm, int lpid, struct kvm_nested_guest *gp)
-{
-	if (idr_replace(&kvm->arch.kvm_nested_guest_idr, gp, lpid))
-		WARN_ON(1);
-}
-
 static void __remove_nested(struct kvm *kvm, int lpid)
 {
 	idr_remove(&kvm->arch.kvm_nested_guest_idr, lpid);
@@ -862,21 +848,21 @@ struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
 	if (!newgp)
 		return NULL;
 
-	if (!__prealloc_nested(kvm, l1_lpid)) {
-		kvmhv_release_nested(newgp);
-		return NULL;
-	}
-
+	idr_preload(GFP_KERNEL);
 	spin_lock(&kvm->mmu_lock);
 	gp = __find_nested(kvm, l1_lpid);
 	if (!gp) {
-		__add_nested(kvm, l1_lpid, newgp);
-		++newgp->refcnt;
-		gp = newgp;
-		newgp = NULL;
+		if (idr_alloc(&kvm->arch.kvm_nested_guest_idr, newgp,
+			      l1_lpid, l1_lpid + 1, GFP_NOWAIT) >= 0) {
+			++newgp->refcnt;
+			gp = newgp;
+			newgp = NULL;
+		}
 	}
-	++gp->refcnt;
+	if (gp)
+		++gp->refcnt;
 	spin_unlock(&kvm->mmu_lock);
+	idr_preload_end();
 
 	if (newgp)
 		kvmhv_release_nested(newgp);
-- 
2.55.0

