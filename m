Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955D3D1AA0;
	Fri,  7 Aug 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103034; cv=none; b=vC8x49Q8Ld4wf030YwA5+lpopTGSbK2dtOsLQqHCqbgWdQqDyDUWGJGvwn9ayb5/HWVUHbNGvWmVHCd8KbZss0onxt4lHsi+QTV6IO87aUW9Fge1g9ovVfateZYYMOAq/lZyMsCeLKlpb4Z9EIq+I2Ul0qpoXH5APnuQqQfcsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103034; c=relaxed/simple;
	bh=Q1z438hFJdPpAifJJphLRnxyIQ/3ToE8arTdF2glJo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsF2SoEGIgaMkipjVBVUpP4jWBMDon+vky0IGkPKRxPEilDY1B8T0C9GAapohCLeV4bIwRMo0wB52aerCiunEG+pXRTp8IlJArbgAr5EE3rBdSgYtzj2PVvV/UnoQDIJi5OhZ8o4e2pdnl0V6TSC69u1uFBHt0o41EGJVF27cHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rivIIHh/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rivIIHh/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HbNe4161185;
	Fri, 7 Aug 2026 11:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uKoaHjLhphLy+WQ12
	17Z6OSaogdoPojKH8VZzODaxGg=; b=rivIIHh/0CSx9Ua0vgXZLNpo3KuUdFsqy
	n8OGUaFA0Y13DWNbKtDyXfumix2Ch7b59vghq0X2ZNSaX3ML61aacElXIWv7yoFr
	8w6OlB3iR8umOXThfBrCwhYr1Uc+NrJQ170XACG9vvJJePqnv+2sR9UZfNpUmkjy
	fFzAAYC6+mR3cUVfZnGNO6uqtfht/GRvmXWpQ9xHTfKaSloCEjmSBOQ2yNfRkeM9
	LQCp0uo1tTdWiSZ/+C3/EwscEr+n5GlPh0udDlrtp8ufHbvS/K1Aj0yX92AJvVJD
	v3gLvCcGR9uzb5qti20LB9mqvJ3JHF+jkMawjqtkB+ILHKpEq8xXA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyunm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfGYv004614;
	Fri, 7 Aug 2026 11:43:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qym9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BhMe233030572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:43:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B052004D;
	Fri,  7 Aug 2026 11:43:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E44B20040;
	Fri,  7 Aug 2026 11:43:19 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:43:18 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH  v11 8/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Fri,  7 Aug 2026 17:12:43 +0530
Message-ID: <6bbf4249e47dc14ac65d72c304bf9335cf10b206.1786099877.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75c4df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfXyLqPFweh2V2I
 /NhO/2dD60al0nZZrCzO+wkrR8WhSfhrV33hxCDsC4CYJu/zPDvGeYQO7lbhVd9meqD95ptSS0a
 bFpcC3A9mTqXiSftwiK7gx/6J1Ga/rU=
X-Proofpoint-ORIG-GUID: DFefQo9uBAVa8kqhBFxRTVyHy6tmSu44
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX4EjVSVUoxZAP
 eZS0zXz81NkYfj+krmCeCBBV64S/FO3jvOS/9VxUuA7IgPwDup5iyOC4Yesrk6+cm+iKko94ZqH
 njzWM7z7VByLO62GsT8T1KLU6d2sb7x8EozEByIhg006M1z77Dv231MxQbfxDCkNTYGf8/hmB9d
 ZMHrg46HqxFOFFTvlTXAdjtcYMO3c/tzQu81Cg2TFQ833tpW5h3HnzsuDf95iZ7/0o2H+Qqor+F
 9b7O8JXfmauuXfVSdD9nh3lv5ANsQv0QyrnnUzCmBgroSUhkXzKfkdb4mqunrI3EXntmCE/XaXe
 nfnaoT6TIOQSm06vRM8rdWI5cuomvoPCHvBr4vl4dv3VaVHir/8z1QP7ZT8VBqFttDNRNNJzQPz
 aDfGXHzHE7dgQy5rMknmvu+ELhk3XePTZixRhepdUge1Dge7VhwZqYLvXYskkpUK32cNMoTjV6i
 2j7wH0Zs5Q0EiIZV66g==
X-Proofpoint-GUID: DFefQo9uBAVa8kqhBFxRTVyHy6tmSu44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070087

From: Abhishek Dubey <adubey@linux.ibm.com>

The existing conditional statement in bpf_int_jit_compile() frees the
percpu private stack at out_addrs only when the image buffer was never
allocated.

If bpf_jit_build_body() fails during a code-generation pass, the
image buffer has already been allocated, so !image is false and the
percpu stack is not freed.

Because JIT compilation failed, fp->jited remains at 0. The subsequent
bpf_jit_free() path only frees priv_stack_ptr when fp->jited is set, so
freeing is skipped here too, leaking the percpu allocation.

Fix implements freeing the private stack whenever fp->jited was not set,
i.e. compilation did not succeed, instead of keying off !image. !fp->jited
already covers the !image case, since image is only NULL on early-failure
paths where fp->jited is likewise 0.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel.org
Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private stack")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 2cc1124ed530..395f1458db2e 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -404,7 +404,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				(void *)fimage + FUNCTION_DESCR_SIZE);
 
 out_addrs:
-		if (!image && priv_stack_ptr) {
+		if (!fp->jited && priv_stack_ptr) {
 			fp->aux->priv_stack_ptr = NULL;
 			free_percpu(priv_stack_ptr);
 		}
-- 
2.54.0

