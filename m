Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26737B014;
	Wed,  5 Aug 2026 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910089; cv=none; b=cmNphjG4/qf8NBrEwAOpq8AOv46JyRDzPonsMUJJqMGzem0P+SQzuMwFYVbx4CNzWvgGSyoaeElgsnuFVClX6N1NGctZbWAamTQjlVzGonm76K6kyMAvyJzbhaH+EpQlEaszWRgagcSFZakuxGoqlmMiIk7mi3zLdNi2m6fB+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910089; c=relaxed/simple;
	bh=jpoMjcNw/89ZNPXSZbs1mBTNGTOjMQwKk9aH/Yc+QeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAEx2PPoVxk5nYKFL7v+GrwMZqPonZwsKRIgsJR3xf1dQ9x7LJsgjXh2FvjMt7nQWWdzdW/WuDqdQ/h5L8SwKHZFfq5h8cdDvbBP8MVVrTMoZUORE2xFrOP+W7uyL67E023YSiLxi41PvssMheWWjVBVIs/UD1IkQpo9v0tnsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oco2K8fJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oco2K8fJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755mPba2910524;
	Wed, 5 Aug 2026 06:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uDTPb6dzY9jtW1k/H
	1n8YTGW2zvvVpmc+b0m99r+uvo=; b=oco2K8fJysB/C0jQvAzfMBu4x8D2hR/pA
	+GxSlQNSNKGEFy/IFIPSDWpGFrZJPVEwhVOiD8Dt0Rs8enXz6uUB+LW0yvpDVMgy
	cpOp5nL58Ir26D1LrNbAg9htDqfPDtlNcuoZCryuAfNLLwPxRxcVTPldXZeKZGq4
	ZnnzlIknN5ngrawsnvIAGAyCEnlXrPYOq3xeKzP6kZB88ndMrvnr7nWqueDCkEiX
	O041Wo3/8tRoMe4kHyApmtYfE6UmbRtDKhyPBOfk1dq6c6E9kqx9sJz29kwTQw8Q
	AgnA28vixNyYkHxEeFV33vCsNsUJAiHr5GbI5W8pyjzic8WKAZ6+w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g96qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6755uiHP030288;
	Wed, 5 Aug 2026 06:07:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyn0re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67567itA31916536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 06:07:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A154620043;
	Wed,  5 Aug 2026 06:07:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12C3020040;
	Wed,  5 Aug 2026 06:07:41 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.213.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 06:07:40 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v10 8/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Wed,  5 Aug 2026 11:37:04 +0530
Message-ID: <cf132f76a7af898af9f9690952067e213430c43f.1785906979.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785906979.git.skb99@linux.ibm.com>
References: <cover.1785906979.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX6nKtj2oKgSdR
 pYWlWXvuAEEjUtDZXKZy/q42KogMk1hRjQ2FEEVdKqkFsZ01zOHeBI8pteiCgAK1l8HF3POzHDz
 FfORLlOGSDYumJ3DXWGheX9kbt9RwWtF2cc2Z2wPTP0c3Jp9czEDpMqQaIyG1y9b5iu72KUCv5E
 fEfUX8O3HYg7iEdf8mHEZOKc8e+hZjl89EzN0/cqmjHEBVNE5NXjMA7qQ5//hpWELyUaC/nSNWj
 daVQIAGEaTUoxsqknAihWiapUYO5Sc9I2BGHE1TXh9SztXWjMqyOuehs4Wgdd5JCD8zJ9g6c/tg
 kLJEZeC5pDDnqpBWoobWveaoiiTRP6pBbU7f+hUSA2RU/kwZTPCDwGMlxS2NGpGMPAriq4ckLdL
 Lil6NOgSMzRQME8uTPCaQ1M5fjLN2lX079kny1tVTNyxfJAZUqZQQo736IIyMxDe0ekYTI0EEVM
 Xr0inrDvwuYIvuejNxA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a72d335 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-GUID: 0mGG3xd-nK8OsZBkB_0MKgKDqqrY6o-3
X-Proofpoint-ORIG-GUID: 0mGG3xd-nK8OsZBkB_0MKgKDqqrY6o-3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfXwUR7Kt01Sf6s
 64I2kGrFBBiFCVh8JmUMSmlkxGkeAp00Os9TEM064Wz4oDLQsHFt3oZqGen9oReZvHTJRibw2du
 AhBuMxtqzMqRqfp1e4HUZEvKwNVIYko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050042

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
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 3c20bb13cfd7..825999f8717b 100644
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

