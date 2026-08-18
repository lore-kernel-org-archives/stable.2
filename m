Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0493A59A7;
	Tue, 18 Aug 2026 04:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028307; cv=none; b=Vnrrqlk2oUv+6s22YBN9p1KY2nFKQzF1F6PBbfq3kenhDpAj6xho/NGgLot2kL3njkDV4bfeGTgVCaco0GbWSaFPj5DoFZrawNSvGeQV1Gd6ws0PrDK88V6xFU/SLltZxu9mir1DK/fYJlFT0U1OHhmOV2twWTv+1Suhs9yZqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028307; c=relaxed/simple;
	bh=+UQcegOQsMkkQ7eXLjCr9DqT+/YmLtFsmfOfblkdhYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9mNzOmSVVGbCoqiKtU/PKMZqZxBc30hDCXmiGvtgJXmeqa8FdCms/PcpridTiv2zAZthOCZf814xL0fC/CfOVUTcwNfOA2XLuu7lpItdft+nCx677N5Edwt8X17LPldr1whgi3VOgDArwmcx57WzDHQ9J6QjM5wuQrlqB1FlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eGb+lGpi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eGb+lGpi"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1gs32575103;
	Tue, 18 Aug 2026 04:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6wEsgL8K9KN+G5AWn
	Q96mL1pVrLWlkU/qw9KAPMbtqU=; b=eGb+lGpidhu9mAWf85HEtOnZHf2jvT29V
	9gTu504EBD6QeJvPF3L+6Vwt1zrwVTBvYN+8eJPZEB2j8aEgzYLzkXclhAohuxcr
	05YhTTQX5nU9bx9Qdu35RHnRggU+uZ3NqPul4y/dD/f9yE3lHXRa4wWiTwzllDTr
	rXIyKcyr2Pgk8MnwxF5g/JmH3CJ2oLXagWdhqlL3s6CN55S/50pdTFFMkzB4DPhZ
	rUI0sM4gpc2q+P1Ws6ljtlR/X6kUdeJIkMsvuXOMFL544r/lglCIJUwY2XW3Ftwe
	lz+8mBdHjL1LPPibBVoJlamSrYBuk/uE4zYgRX7ecwXvrvpxP82rg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3p1kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4fTIM023690;
	Tue, 18 Aug 2026 04:44:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y940p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4igGq43319744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:44:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42D202004B;
	Tue, 18 Aug 2026 04:44:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F7E20049;
	Tue, 18 Aug 2026 04:44:36 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:44:36 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 5/8] powerpc64/bpf: fix percpu private stack leak on JIT failure
Date: Tue, 18 Aug 2026 10:13:38 +0530
Message-ID: <97a39fe69332e2db95f2e653445c5b8c9adc205b.1787027080.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787027080.git.skb99@linux.ibm.com>
References: <cover.1787027080.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: plkH1UaF8RCXxZMrpvXChUlEQqeXPHgP
X-Proofpoint-ORIG-GUID: plkH1UaF8RCXxZMrpvXChUlEQqeXPHgP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX9p+YbsyDb5RF
 06WXvieIQ47bc1T9XXvI71cXVR6JifQVySJbAlq10ip2wgmTrWkvIyChHQ8mgrJWYzAg8SGdj6f
 WQ0inBzJTdqN42u5iNmtePnSd3X1zXU=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a83e33f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SJ-jtujo7bo76xSWeacA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXwdwtC2Pkf1qt
 lYRaDi1xAW4PmrL1DJoE6tc0Y7bIb0oPiHdYcBx2V/IWt/wxGbcRcXWxoFoZMYW3vP+IBWA7Rj+
 LsBoJWY7wc26KHmL3z/G8U14NQoKvBEuUOVsaiOq5sJEgJHfeCCZmZaoFpSr9++KADbOQukp37I
 RzRui6GEm4tvvPILVK3P6hqwV1QnpHTdpn5UF3hdn4dgKh0t/BdlJ+Zo1kg5dVHLDpkiLSL8E9y
 CSHKy5d58ne05Nj38sv4Ch9kne0sPfoXm4Vnc3EGZnqoUCkd118TcELTElVkBtmqXcy1XgYXOkD
 h/RwaTyi7rfAysotRGRAHt5mUYfHzILAzSoAejnn49+b6sT0BnRiVJp1+Uxe8ju3zGXrIqqEAOn
 kCNkr6HOFXF1T6q0hA98vPWzq12p3moGtIsXyJ1k7mijf9qodSiWEAYmUYnc2ojyAj9sXPEy2Up
 U1AWT4htKglyzFZx7gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180031

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
index 38acef44c097..b45fa8027106 100644
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
2.55.0

