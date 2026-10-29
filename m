Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284925;
	b=jR5tIeFiHolQZhbdbAdSXdFVV7NzVa4mkW3yBeA0eEpKoA22kVY8h2U0GlZ7Zg5RFdga
	 W1/zDxWqp/NSZwoUn9MmBt2qqb5FX9+SdMaiJ28BGNIzh+BAUn3POyJXHasVyfBe76ZfE
	 rXGjVcvBKxg7tLbj1V5GcfFtvQrtnJGgurrNmDTA5bYZXZz2zsnz2/4ewxZwecH+PYof6
	 Xk0rhG1PZf/JJg6NSuBYxEDdDaVGP5ARDj+6yGkgwIR34yrrhwrvG4tee7Nip8+0XPy/C
	 RDMvatxUQA+QkpDQhVQff35YQ0ZN7gkwxg8txK2ixRjpRb9GkWvjNz2JHbotm+/SSgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284925;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=e8t5Xq9tCKUo9Qzu4LPifkPJjmKDzJOtBLM/fPK1Urg=;
	b=p60NRdstKMk3HTw24K6EAqqZTdg3mPUcNsX5MRqRtk4KLuQWwWlHxGUqlSxmOTUNGLJc
	 IQ9v5/XCQ/nYPqbaeihONVkhP7Kq4DLpcHtq5lCGMV5NrWLK1EnuqHQ6aHzJYpS/djuLr
	 BQjAW9kf/eJkcP1rb2lR09/2FU0QuaOwYkK85f44bO5Wa9Qp36q5wwE1UkaqTjtxW9k8B
	 /PBcRj2vj04I0DlekjreIPkGREmJidJwUStB+twRqbpYob7SMPzv99f0PyM+qn+6/lybo
	 ejVVACQwnmnA2+0m7c2F7MeX/EIZHs9Ob1BAhPbcTmB9YbN8tJ5ae3rJH7ktu03hILw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ne6kKYZk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="CO+mK/Yh";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D660606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D660606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ne6kKYZk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CO+mK/Yh
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TDarxO791712
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e8t5Xq9tCKUo9Qzu4LPifk
	PJjmKDzJOtBLM/fPK1Urg=; b=ne6kKYZkf6lbtSRyfU2iZImCOOIK3M/HA7Nf6d
	fx/zGjGG5Dc04Ph+A52K9kIIrFi99nJH6MASEGwgoMsIu9PKL5L47NlakJS4wwM5
	Z2Je8KFDZ8elH9kDuZIHdO26BfIXuD6592EgffarG0/DXclnlgPYquy2FiiDW4Et
	+RsmWyi7FQu1PkZdtJlmU7SphT8ErjOzKrLeGS/0wWXgjIn6kgLuCAzYHcwSuE+e
	tBf6a/FmLHWKl3aSYaarEPOd8Pm/Ib1scvut8686yaQ6YnQWPTySgz8anmbM+RPu
	ZnO9tq0AVuABuqhTjyuwGf20u5dIs+WneAjJt3K5+3jx1Nxw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76cg960-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:42:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso2817094a91.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793284923; x=1793889723; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e8t5Xq9tCKUo9Qzu4LPifkPJjmKDzJOtBLM/fPK1Urg=;
        b=CO+mK/Yh8z/jRm3PeFsqk3VvQ/xwUlFt7oVYjySgohwiytFmOaXSL59pwY3nr4z+LM
         zn9vLoAGmlGB+Br4o+72/R33OHHUxFoyj/ay7OAs/1HMr+2usPq4UqvZQ89no2F3hDy0
         bJmc4w2HYd7WIMPdsCbBaTROjZq4yNptS+gbddbJVYzOSNc4hEY2tzGNmScHbocpprLl
         k7bGiFvyq2TSvfa0TE38JWvZdXvAFw/9W6aNTgQZCPgDoHHGKnTiWKeCbK0JggDetWbY
         +B0ysxV5u/lZw8WsSRusFt5/Ptk0gyumjUuLGMGqg9l06Q/bnf0ArSo/AEQtqB5BDXIH
         Msnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284923; x=1793889723;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e8t5Xq9tCKUo9Qzu4LPifkPJjmKDzJOtBLM/fPK1Urg=;
        b=w74hKfv5kgUkUIBA3gtQ9zVI8gjrcQsgRUUTmczOFnRB/cdEwFDAce6Yh/cv3ZK0pM
         qnm8beA2SYF3X7RkxuTc3LzDVzjTjzWXx6hMTS6rDXLwS0R8l39WYDDmxrrehA83eUIk
         8b8O/86c0bQzvLcYNG1Wqb70xyKtG6MfN6cuTaMqH9GgnRku04uhUwdubGZFM4oBYlcA
         /NvgWar33JOh3s6kpocqm3ODnGCiF6t1XjH39Ho1b3zkb6ayaY6bCwk1dtuyPoXzn2pw
         wUmz7rSUf8iH0s3bmS3JGw6PvFXuke4BAnxuwgTAmEey51KWJb+Fg9gIkmkI0EG5B1Ea
         /gJA==
X-Forwarded-Encrypted: i=1; AKwUvBxMyTQw5xN0MLlYkvTn552EdG9HNPdrj+brtV6qlEnK2K1CayEoFuiR64QeQtieBVC8zeeQc2Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8YyAyWN62wNVhly6ubkP6xoisj6ebQE9VoFlc5leAXUJps2gC
	mc6jUcQHA/rO3Gker56MgUWcLgQzOmqAHDYkXq98I607rVRWr5NMRFr71b89THoEVqKZTo1EcTS
	4D1hXkNo8CSJOA6lS4+MWCt+kxp+xRD1QcDdNNk/MZFR/2bCUEzJYFGGuN5dgGQIu5P4=
X-Gm-Gg: AYBFou2mqsz49r2kKZ3j46ztUpDzZvlIT31lJDJearmN1I56xv6j6SuppNEbU1IPaiM
	SHvGrIWIfx8UmESFk5qFXMiWfiKWPG9YX97hBYLeal+EG239rcDUvLlUwzGlY49ESedotjqVAIR
	iZnAqAh3ouuY4fuEyLgAJ0BVJrBwKBOz/RPEmBK9gbFzgOzrjOcQ9936nRLdeqbkzhFH14XSRCY
	obUp7lsMOfpPZWIIj2Jy/A9okJ6WwBcciidmqIxVTM6uVa+whFE0ccHBOn3l0L3NKiDI/8eOVxD
	UEAQnywYSyNz3ze6+6cIpFLJ1dJKtVyexHgYbYr44BXzS2KLM2OqWx3m5E9ymGI+RH1c1eKv9gU
	itw86WjUqH2QINR7O2nZsVVz/I7TaBhEB5fAY6ccRDdkCNDATVh4fjlT/C41+reUWSUIEOAznUF
	+4c19B2Ec=
X-Received: by 2002:a17:90b:5404:b0:3ad:6090:a183 with SMTP id 98e67ed59e1d1-3ae57f629eemr4725570a91.16.1793284923063;
        Thu, 29 Oct 2026 07:42:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5404:b0:3ad:6090:a183 with SMTP id 98e67ed59e1d1-3ae57f629eemr4725539a91.16.1793284922659;
        Thu, 29 Oct 2026 07:42:02 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccde306sm5444510a12.30.2026.10.29.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:42:01 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 20:11:45 +0530
Subject: [PATCH] arm64: dts: qcom: sm8750: Fix iommu stream ID masks for
 CDSP compute CBs
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-sm8750-fix-sid-masks-v1-1-5ed50a1a0342@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAChb42oC/x2MSQqAMAwAvyI5G6h1ifoV8VA1ahAXGhBB+neLx
 4GZeUHZCyu0yQueb1E5jwhZmsC4umNhlCkyWGOrzNgGda+pNDjLgyoT7k43xdkSFTRUuRsIYnp
 5jsK/7foQPiAYNIlmAAAA
X-Change-ID: 20261029-sm8750-fix-sid-masks-f27747b63ab7
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        stable@vger.kernel.org,
        Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793284916; l=1494;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=h07EQK/xjhAXyzeFzx54Qn5dbimvAn0bx8lbX7X9MlU=;
 b=9m1at5bw4yfQfYCvWAgQQvecRPHuKtU/OdE1RDwj4J1gR+uHAd5f7du/+bEmobNS36WKi1bfK
 AdvIlK5154fD4aGI16+zrs57MbjXIy+Ysa8PhGTuDIhKUAlGl5MKPQj
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: 3XHR3LbPnQYM6bxr-D4HTCC_WZpqcy-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1NyBTYWx0ZWRfXz0GjKGAhrFXp
 Gn36ZZ5neALXAxgVuUAk7D+cNEfqKs0gYKZyoVe22u1T84DUZZJ0CJLlPz/QLbKMAhrErb9OnuG
 EiywniTRoBB+VO5uNPZdCuCIxpohpGZwZmftu9SRMaZKKGBBOUiS/z1OGdYgQPUUWbJElE0oox+
 Y/PmtQRcIoQr0fbEz7q+DpAmZM8kN7nS0c0z5efYORld9UB5m1JKBgkK9egU/sBrpPeUcKCRLl2
 X1I85nRqbATpZwshu6/0UCIFaXYvHNAOH3950RpxlTLhW5ExfdNI4fGHhEb0P+N+djqsPUg/QkS
 dh4+5wvrsSrpDqNTDEJoEaLOryPAwlNxoK3ynrV23w1OsV9NwifLiw+/pjrdy/ArXV4h/4eYUtp
 zuf8jC9vF7ER8r69DfQvJQvTg/WcY0Mk0A3uqIvmLH0fGMXTvaQpzIxyc767l7Liw7DI5RTDA3k
 eCWmrHUfyssUCcXK1aw==
X-Proofpoint-GUID: 3XHR3LbPnQYM6bxr-D4HTCC_WZpqcy-i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1NyBTYWx0ZWRfXzHpjKKwQgOzw
 350lqrraicqTl2DHRB/00y0x/qlB3clDJIrbhbUH2hod/w3gb26UMvV7A5TyJ3/iA9mBQ35qhxS
 TPL7/qlySlnks9q5guStt+Opi/DHE9g=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae35b3c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t4KJ5oeoZsrh8uawLdoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290057

The stream ID masks of compute-cb@12 and compute-cb@14 are wrong, so
these two context banks fail to probe.

Fix the masks:
 - compute-cb@12: SID 0x0c2c, mask 0x20 -> 0x0
 - compute-cb@14: SID 0x0c0e, mask 0x20 -> 0x40

Fixes: 58471055ae76 ("arm64: dts: qcom: sm8750: Add CDSP")
Cc: stable@vger.kernel.org
Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index cf947acc5760..de9d9bf3ca4b 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -6497,7 +6497,7 @@ compute-cb@12 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <12>;
 						iommus = <&apps_smmu 0x196c 0x0>,
-							 <&apps_smmu 0x0c2c 0x20>,
+							 <&apps_smmu 0x0c2c 0x0>,
 							 <&apps_smmu 0x0c0c 0x40>,
 							 <&apps_smmu 0x19cc 0x0>;
 						dma-coherent;
@@ -6518,7 +6518,7 @@ compute-cb@14 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <14>;
 						iommus = <&apps_smmu 0x196e 0x0>,
-							 <&apps_smmu 0x0c0e 0x20>,
+							 <&apps_smmu 0x0c0e 0x40>,
 							 <&apps_smmu 0x19ce 0x0>;
 						dma-coherent;
 					};

---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261029-sm8750-fix-sid-masks-f27747b63ab7

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

