Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081839B94F;
	Mon, 31 Aug 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160612; cv=none; b=AGSawvaIX6hDq8vWVvmsWeM1rDcSJn2U58XP1qIi90exjNyV2myI3XnHRGVoadXBAoES7fJcMcdmCEMHcPXPj8PjG/uc9CyayCX4hOqypP8uPSv8bS1aXAlUbQp1AiU+1J02PFiU2zTLbz0nxIqorKsw7hRzsIdAhmthy4YpBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160612; c=relaxed/simple;
	bh=IJBY7F+0jaX8e2RDQpvnKYy7wFrlT8kmrOFzMOh3UEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKuTa2cfbGZsHIFDv+uiKrg1XIvdi0b1tZvdCx8d4EV7M16OHkYoSeBODqEAIwsTu7x+SN0IU1VhssJH0HovjJ4/JXVeYV41koThtIMyV0vIXzoHPULrF5JNSlBKMOjT2aWt53ghwZJJMdflcoV2t4U2cwpZ/ayhTjAItHi5YGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pkWInfRR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pkWInfRR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52tsp1270840;
	Mon, 31 Aug 2026 07:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cj9+KI+E3RbfzXOrp
	IFzuxQkaC9UiINza73y+WdO+D4=; b=pkWInfRRFznOjcEF7RvTyGfP6iDY3DB6v
	SuAJzaG0OheV35+kNec7Qm/y6vZ/HmS0qJbv/v9578UwckZgoii5Bdwlh2ff+agh
	AClG8omHGxkE/ZvyMFOpZdtmciZwzFVXCzggSghCE+h1ByQhTTgT6qQLTJ+vkYTx
	lVLKVFRBNmUN92t41V27IDVnPeSUgoJb6utVzSIgJR8VTsBPF/65mUtVRGgTZmbQ
	P7LIy98GIfu4/pXvVC0NbtQ3vormnxqi5c+MwYRgNynY0N93TSeEfbfwfWtlIAoE
	lK24mCEL2FfyO4O2eFyVhnjfJESrMIFPUSF0wRY0qrtsPpJpqHJZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx57s1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V7BQ15012955;
	Mon, 31 Aug 2026 07:16:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjvj14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V7GPkY42926494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 07:16:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C1EA2004D;
	Mon, 31 Aug 2026 07:16:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515E020043;
	Mon, 31 Aug 2026 07:16:20 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.67.146.121])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 07:16:19 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v13 2/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Mon, 31 Aug 2026 12:45:59 +0530
Message-ID: <a827e3ef81cd43f2aee7e9bdfe8683f2c77065da.1788154635.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788154635.git.skb99@linux.ibm.com>
References: <cover.1788154635.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a952a4e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-GUID: bpNNleRyP2LDYGFdTA2L1-OOup9tgf5p
X-Proofpoint-ORIG-GUID: bpNNleRyP2LDYGFdTA2L1-OOup9tgf5p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX0Efr8Sz6T94c
 WygRIcyMDff6ZL4PnvgGjmrN5WjWrVJEjDXTKWjd9AwOo3QjGAX8VOUCvK1hbTNIFxYiCCO7Mmf
 Xo5OuHviXuONWmD60VBDy1hwvOBKkXE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX0s9n7wM0EAVk
 Cqxv9h/UuvS101nsnyuU6RiZqAhyHd/jlpAO3pQJpWXKF2rd5mf+CYRH0nQlYR4ZMiH+29j+MOg
 daReQit+xwLuk2bMuFxNB4XyjxynSFKgXq8lbhFzMOt2BgHnevNFgjMxte1n1DT0ZKtU4jHeI0G
 GX1Tiy+daxN4SR970J8VSfpHGhv2Jx9ruccspxlKQhMdrwSEqnyzRJbTVQ4WtiK9XiZ7yDEL4jR
 rd0yUlGLBgxX4T9Sj7P/BhLHTE7CKRYF6aDvYtbBKAQ4Ba5fyBkgTdvu8Sf8LSMxEbGKpqh5wGm
 PNP4g9yRCrXVBtoTRVcInBOwR8joJrznYZVJUFxdIFxhDbN9pHu7ylIEpDqU6X/posRAJ2K/ynG
 rw6oyw77Lw/0FrLmEVbj7Ia1K2Y5/GmU5WNHeCqGNL7BdQ0cGF7urSvIrX5fxEa/pryyMD/Mhjb
 FCAHHcuLPHzZvbTvZfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310059

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

