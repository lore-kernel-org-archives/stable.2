Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F64D0CE4;
	Thu,  1 Oct 2026 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848960; cv=none; b=hfeHV0URS1uafaqjnoX3m1/GZM8cvxNGC2pQKqCj8wveNgQiScdnXQxZVe4l5TER0W9u8HbvVWHU6VXblJgq8h+SVQKa7+Fovr+pmlnvk7PwJwclL2BM7nP9V9iEQg+JArg1RjNqP/fsAZJJjAcGi9+7t6o1gq2d0HhO/BbyZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848960; c=relaxed/simple;
	bh=2JYHJhvAThnP3DHw/GqpJSAL1v5Peleia9xCSSbHW5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA06RlNlmvhLa9nGkipcPnttJeqS2wwOV1nvkFhTOUIpt16xkIZ5pZ5fibZhHdmVFSrMVeDKhbLU9B1nbYpDHn2HozL3t/aLDHKFj8loCPzxXvCzxgy7GWBPKZx0WuIixo/GWgPsMA7CSkMY7XHFQgaYnU7JJw82fsKb/CGuNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WCUHBVpt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WCUHBVpt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Rcb907219;
	Thu, 1 Oct 2026 10:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LIZGsJr5BmqlOfmS2
	T80z3mcRYeW92CV4VFwKHhdJKk=; b=WCUHBVpt/efTIcVoIvF68A0Q4OEco+e4j
	Ar1TI8ifRiylq3T5cxDHA/qCEZqgu9HNNW1l5qEEWrRWh6eWrM6o3lVJy/7n901I
	D/Fa/rtfFi4OW31G4C8DeB/SudfqdmaE4XR5/O8h5GEypdDIxGvYiwHHDpd/w6iF
	LZ5AUy9OAQKJKPYibWQJesEFH/+Skb+c+LyLFfKRdtp63FY8nKc+dhI5c5NnlZLq
	h7hlzsDOv4EZ/OHOPXmrdvt/LiKIVO95zt01A4w3YT1yjO/5uaI6UzEzbt9zjDdO
	VXuBo3elZqPIF1J7XibjYZRO7PUW1K8eAQ4TRPl1/jVR1TQpVB6qw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhn3n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172TNk557896;
	Thu, 1 Oct 2026 10:02:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23r0k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691A2JDr47776204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:02:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26B8F20065;
	Thu,  1 Oct 2026 10:02:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF16B2005A;
	Thu,  1 Oct 2026 10:02:16 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.bl1-in.ibm.com (unknown [9.123.6.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:02:16 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/3] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
Date: Thu,  1 Oct 2026 15:32:04 +0530
Message-ID: <20261001100208.1271628-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001100208.1271628-1-gautam@linux.ibm.com>
References: <20261001100208.1271628-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GliQW2aLIPp72OGWWIMIAvPkmGC8nqCJ
X-Proofpoint-GUID: LuojzUTQv-XOlOmm53gahgLiY_GBx_KU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX316ZXoq80y45
 7HlkrTAHvaTyEulqLxLuDM53AziCgm41ccUTUhDb/eiTHQJioMc/D/ZES4bF0jzGiR7J/gELcN/
 fsg/lI7qQ/uRsIq9w38Q/nWPludHVRk=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe2faf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=6c1f-Q0peJaRmYMZMr8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX4saDOvOmD/ME
 rndDVwXEVtV8/m+Dex5mzLvOUk8qPjfS3r20WxZvS3g8kRqIaSF9Gs7LmtQujILbXnBgYujxGVU
 wtJwMmkcJaPBqw44AlBejEi0vhVy63BcTyMNMG8hRJ1dhwql/xU8WM0j52YnbWaD6sHfGGBET8O
 mFk80IrqxJT59JhZwS0b6m/azK1FvcT+fx5wvjzl/qGl+I0DcBv5G2l4B+o4fpn2UKMpCChpF0s
 I3QUnPWKJDTj1QJm13YIJ87sjQqLneVpUD6nqd8FHhdLeTwtoXEgwW0dL8D6kXjlkzLMr9IX+Pd
 3T4s6RGsKPS43VXEQPnt3qTdBBfa29aa1uvFA8rsyoT4G4CjfLAx/NDyckuk86kHc6QTcB36qEh
 SlUfSgTDzemXqwQokNCM04VLxf+5lHBNnf6iHxusDg6FOy/MNB+/UHyk1TFhCmjX0KTz8cBboYM
 bTutt0+KZBlXZv3OExA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010038

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
2.52.0

