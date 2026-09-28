Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B405374A14;
	Mon, 28 Sep 2026 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572474; cv=none; b=fYRxmGcb0a1+I/QQl020l5upJxJVc2u84pF93Iu9iwDOo0nMvLJugTTZt0Ub+01wNILuHS8FXMH6E6l2MjBgFQDNA6z2aacBkMJblcnhQZK4mX9cVb7MET4zujSSggzzDe9PiVTNVgF4e2HwwWYdqzYo8J/pdAv69y+PCzsOKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572474; c=relaxed/simple;
	bh=kfMeZXTKBYTD9EcBpS0uASIIps5dP9fB28XnvXU1NF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbOSD51FnAEwBaq4kvhnRUBHBXM0UckjORaFtc94DUvUJgNl7gMSnMilJeqv4N8wf8gSPplU/E2P8KbiwwdLP9OlCOPfGPqHfuaVY7MdwCsPcDB+h5NMRKEjqJa9/n7CLI18Ha331IrM5CXbO/xvNe3ITq2CDRWZx2dHVRsf6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tuuPnXdj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tuuPnXdj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RHXNgE264923;
	Mon, 28 Sep 2026 05:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/sVVazsrJgZvbb2V3
	wieE7Hf1ogw8nJ5o7Yn+SUUkv4=; b=tuuPnXdjPwkKqGTqsn2H4bm6ILN4s/SWk
	SPAdoePev9hXk2JCMGOMNV7W+0F3gPjTER5olsbt4ldlk+st3oH3KpHMXMMoh0Ts
	VBIdKN3MPX0gJStsaLBXrqcN1nurS1b3F+opw5lgSaAyvi34PU1a0UaaJuvlKVeQ
	uZK2HeuokLiKsMpqdl3k2eMFZke9sopNNBqY01tOH4HfZ8Dd+kGYPQxqerTTINuK
	1BPK0XjfD+3S4WX8es1C0bl5cDEbqrTZ8uO6+IVN91MbIHj8JnGdxsp/gHFq4z+Q
	8I5mDODi4fL5tSRu7AhYwoHmcNcX4lGRfaL9KR0x95hnpYt75o7Eg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j4yg68-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:14:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2jCxW2024369;
	Mon, 28 Sep 2026 05:14:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw3uct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:14:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5E9xk48431534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:14:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F213A20049;
	Mon, 28 Sep 2026 05:14:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE45B20040;
	Mon, 28 Sep 2026 05:14:04 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.213.52])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:14:04 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v14 2/5] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Mon, 28 Sep 2026 10:43:51 +0530
Message-ID: <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1789982239.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789982239.git.skb99@linux.ibm.com>
References: <cover.1789982239.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX5gzeXAnOHrNg
 Vx1t/DMdHd7rpgbhiPkYJFFCauWtuXg4iCp6Xqval2jNVY6t+eynrg7WOF1g5csbfqU4Txc4CJO
 F65TU7glhN/7IxJj7RyyPY6mWFZrA/Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX+D0lx8H9i0RE
 E7JqhVje8pJZYF+8NkxPw6yUkp5LQcGCYnoFFhp0YwtuNL7NI/A88r42rdfxSDaYfYtXqv2Zg7r
 YAefe4DYB0MltfXBZtlW3Qz54CpvyqRy18LapzeZy7yIEUpsAIlmLrF4ZF01u7rMnj8TEmm1psY
 CgTgELB/i1yhwODlBS9Nay3V6VtZ2v9jrb7wHh0wCEgth7AvJr6iEV2fUfFSjJxACNN0SCgUmdy
 SL/Zdw4wfEcUpc0PbcVZPf+ZKip3LnE3oXEf0CI6AUOOr8X+ZzSULQydkvZYH7dEGwsrpL/BP/H
 3fc21Q9+GSmrx29Dil08rY++Cmrt4DRjGCijiyvAcRrmlP+zzytU7Fu2R4ht7Arm+0c1YZivriS
 5hGdzs63k4dD0PhH4YIIPKLVS78xjMCKr5tbWkfZnU5zWwqFFsbwbQApSCFf9q0Q7XoQwUZSKbV
 eS8Q6elcFKR1g1PioBw==
X-Proofpoint-GUID: A0fID2WT8BcQoyRaYS33Fp_5Kcabz96X
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6ab9f7a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-ORIG-GUID: A0fID2WT8BcQoyRaYS33Fp_5Kcabz96X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280020

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
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a875521ff904..8f7501954d9f 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -357,7 +357,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 				(void *)fimage + FUNCTION_DESCR_SIZE);
 
 out_addrs:
-		if (!image && priv_stack_ptr) {
+		if (!fp->jited && priv_stack_ptr) {
 			fp->aux->priv_stack_ptr = NULL;
 			free_percpu(priv_stack_ptr);
 		}
-- 
2.55.0

