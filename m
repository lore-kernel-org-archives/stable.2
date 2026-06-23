Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941973451C8;
	Tue, 23 Jun 2026 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242120; cv=none; b=rlDQXYQO37B60D+XlnYOAiII/UaZ8ifx1v/kq5WDc7Um0MR5ovfcixTY9ICd20MZiyxrSda3cOsAIVkEdUfpQwg5+VjeBU+oYLToaRxQkmnz93RqEE1yRc4r5a/0kSGjnyhnuP2QMvyfFR8fM/i8iLubGCbluz9fPsUuD4WGVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242120; c=relaxed/simple;
	bh=+4w1cwmGCOBfNgnh9CjNJLL2xzFGrpbytR5Ln7c/FWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7PC3ILcHKw9mVjrDHazzXricUXXhQlQBEW810ZsvXcXChHGJBw/FPcnE1Kl6+h2zntQA+tDDpo9IM2J0EfpO4oFA86Sxy2EKttSBbKWmc3416CoLMpD1KSoMAFnjMfxLU0JCZ0syahml6Tx57bIn3itdDSW/pDnWBSQOrpPsdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vod6nmLW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vod6nmLW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmRZL1914627;
	Tue, 23 Jun 2026 19:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QFGzWOrOeMaGW9Uc4
	5BDxkQB2n97WnL5QNSYwhNDk4E=; b=Vod6nmLWfGJFIWWivCsfIIg0vd9L5LJrt
	IK2pjHqFkyP3RzKI+jARXPMZMLoc4EhOy6t70pchSzT7SsnlEtLrrjgjlHWRMGSe
	W0fD/SEI+0ps94ZYLvvtlzKPy+oCqF746JdWKqJTO5loYS8MW2vZc8opb6H5jiPz
	amDcFHELYWVKp3AxwOGWiRfz47F6I0IdXBEOc3ol6eWG9mVnnyng8Y83P+0Nu9TH
	bvqz1bbM1OC1UiCqm9a0f67B2w5KUL9uHNvO8G7yYkZ3P4ZFmGEjB3b+INT7mDK3
	O07hPhqw+zasS2NLmbIPAly4QXh9SaLwdovqV0sLDL8wxL/5ByhxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4geja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:15:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJ4em7015733;
	Tue, 23 Jun 2026 19:15:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg4rd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:15:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NJF0GP38601018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 19:15:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F26F52004D;
	Tue, 23 Jun 2026 19:14:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A65302004B;
	Tue, 23 Jun 2026 19:14:57 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 19:14:57 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [PATCH bpf v9 8/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Tue, 23 Jun 2026 19:14:11 -0400
Message-ID: <20260623231411.6216-9-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623231411.6216-1-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3adb38 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX2H5XoMx5nWWJ
 m62y6PksTNZin6rBCXi4c4pjygPixUARVgoOqwR3VF7zW3wI5yBplclQj4b0EwkRY2eZGweylvn
 dtAWAUAfAqsiRhov16M/8Bbw6oC9V3DGtAuyHOWE268Lr6ubQJssDKkduo4ftMIrNUV2QkJmz8K
 ybL2qODKGrMCS3rLeyCjtvxdbjeewG+EL6Kgs2RhI2tEco/0uZ1EZmDqpqiYs5NldkwL7n2AOQM
 L8NuJvDTjER13EFCi0f8qLmZ4CG/b6MyxGJKswqh3O5FEPoDMEsqC9yzndbWg0xVZff4pzaAlwm
 icr0ymb7L7trZ4R5KWzMCIu0AvqQ5TP+kAxIGAbD+um9AybOLCZazhwz0YiH4Km6oOtJaPEP9SL
 E+hwHvAeeGyLlQjJwvzieeek+VKvpw==
X-Proofpoint-GUID: xAJjT9n7SPaDfVV7uNdzhCqfg5IRru91
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX3BkofGrn1xk0
 y2+igvHcNP931PcZu3rd5wgnN1/vOcVXxACR5vzKNepuPl30q19sNDDH+s8hhfq7gAOJ5mRJroJ
 wmBW+AvQOcrJxV2fBIJOoEjhzdNGSek=
X-Proofpoint-ORIG-GUID: xAJjT9n7SPaDfVV7uNdzhCqfg5IRru91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230155

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
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 171cb6017259..46bbfb6be613 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -403,7 +403,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				(void *)fimage + FUNCTION_DESCR_SIZE);
 
 out_addrs:
-		if (!image && priv_stack_ptr) {
+		if (!fp->jited && priv_stack_ptr) {
 			fp->aux->priv_stack_ptr = NULL;
 			free_percpu(priv_stack_ptr);
 		}
-- 
2.52.0

