Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319925;
	b=gsJR9tgBXLdTa94hCYpQMoXG+h5pLqvKFv+RxCr+QKtZ6NkjRb6Nda2egWs1UiW6sXor
	 U9htul9OTHFM2KzbYxqo38xwsw3KCmP/6DxQuKY75OK1LS2llLfJocOmQpisJjcgsoX0L
	 0HnfG52hVC2WGN2Z93ZeoUDvf0JQqVBSosJpws06D1qWOPyFcHUkCUsyOT21WnteUHpnc
	 JGK4lRgkUUVZfEJk1mKClkdzUgDiBX1CLgtfzVtTKw9a8wRbedDI5kHrMAVFKtbqSwDXG
	 YfK+Lywfb3wrwqgyZf5PCDqlOgIaILIxC/KrV/g0jaUkiv/OHiYkTg9cdRhwiC/wQIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319925;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2mhps49jkazEfpgVWRSAiF/UKHaCp2mrSjBq5r/twrM=;
	b=3jvvixTRR38fN5c2enEgw+dfeEGyGqghOYKzyCIC5cwvtaLHX52njjYmDmXEtERdrXru
	 KoCD9HoHYvQfkxbRMgjtdfbGO82/Bat55NbLCkdaVIln+axm70YZQ/S+b5fTYTxUPSzyb
	 1eG+6rlQPoHJDlmyHxpc8Kxw3dYrZYzxJpVwPDK4EUKveIz8fG4nhZ5lr+iCgr5erHIAp
	 dRs/+Lp6pb/JvIMYF3hruQzmCAHxk8GimLVxEEbQxtAKU4sbHAr/6eyLon8KS2yoPWF+v
	 bSXFovzM9kOa1KWdl9B8LK7Tf8TLhQ+EtEh6qKkZbvTqimssmAu6Tlu41fN7bcwY5+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="mM/jPauF";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QMdFysQK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7A606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED7A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mM/jPauF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QMdFysQK
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9uG62253408
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mhps49jkazEfpgVWRSAiF/UKHaCp2mrSjBq5r/twrM=; b=mM/jPauFksBQ27Nl
	vJFbuBZBpaRX56t6K17dYrYBsf6PnHvo7BS7hnwhdoeOvnliy2hNNkTEcOhDvqwu
	zn9ugQSwBs94XR7EeZWmVjQ5tnY1ddU+dS2+g079Dzn/wbCYbYGem9lbInM0mpvW
	b6n8dwl9sX+5OjUuEDTmmXzlPezQ+s0D2ogzz0UuIP4JY5UksscN3meF6Z0q2o35
	KrWHTQie4rju/XEOJau+cMjt0cfxWHwhzU4a6SkFScOtK6CZP1vxFGCwX3S83hU2
	nGAQI3mf4E68iv+nJy0vcNk/3N0cE9UGuRGbj6jO7863DLWCHw/514zb3FWT/Y00
	hJSQfA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw494h9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:12:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36efb506f29so2082549eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319924; x=1794924724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2mhps49jkazEfpgVWRSAiF/UKHaCp2mrSjBq5r/twrM=;
        b=QMdFysQKeSuRHTDSWYxfErRMlVSGw//aKZDn1sFdUF1S7euKKW7u/53iTNzDs6xkG2
         JuZPulbn1yAOiq2+U2fDkYaaZJ207l30BIRvxKaRbEkRyRxaT5BpCO0/rT04B7nwFtDH
         Wg3+LRwjfwJqQjAJ2nIlUMkzu1r9hcMvMQvy2CX0liuUbFp6XMyoB0NkRrAbZ6pQbRqO
         6tIIW9OK12xqfT4RgmzWnhuq8KGe+zdu/51c1mjqbgc+FLjzrJ8xzisAqqEl6qkz0Ahu
         EkydGgcy7AWuqz3OolDOmRsWCHXtTDABgfQAt0WsYh3P0Wu5oDEFO6uJUiY4fJw6lG2B
         7mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319924; x=1794924724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2mhps49jkazEfpgVWRSAiF/UKHaCp2mrSjBq5r/twrM=;
        b=bFOO3Bduen55o/CCl4IPzIk+bY2iCYjMuWPuM5RMsjyb/22HEmuj5Q7p28ZXxK1/Ii
         OfYfnG43HDNYdWtQz+O4P79FCwZ3HPUFVSfULoGr14peNcmbNS2LsHZfVv13ZivIScJ+
         +HCCzFxwQ43N1uwF8+44TH15MlgUS2E6vj5geSea+Pjcvmoz97GDbR+xYhY2tBzPR/RK
         ojmoUCAwkaz8p35XLZiGVvTCPFSFEneWhXS+qJ+WEqDaCJARTXLs8/vNXLsaHEVMr/iN
         BRhYmJVhxITcQd4MTXAzNpQqZzzFXFM5Lu9dQhEkk//VP42MwNhXj5zRLPoffA1Ab/cn
         sZeQ==
X-Forwarded-Encrypted: i=1; AL+hErF0KiX/QSUfpAySIE30jnq51t/lBIwvPS53OFPVKWce3OSruAxWcOlq3QB/VaCGDs63fisvfVA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/Qyc8JCh7Z4RW5907qEGW3OY9wjilD83sV4TOi0f3+e53iW+S
	x9QiQKUKrsIYYcJVC6EhRI9YZUlJg7V2jsaWXA/W0SAmZfFS6VyrOWhp2Mw3qd+vBzqkoDD4EUH
	Uya1VtHdpQ3sIJnAEFD9ca5iT4L+6PIalv3GbD75pfqc/bzc1JMrooDaVhcU=
X-Gm-Gg: AYBFou3fslqvmLVRsCOLfCKLfBhfAsa6GWGbKAhIll26j0RxPHUiRi2Wm5uvqKE9Zd7
	C8dha6HweNdMWy3L2WIeLUIXXvGkcH7HF5UXO5RJqfj5c+t42ptaqBfPiXceCFVwWjukV+d2yj9
	jqhA98WS7I9JKjPWyy6JGcFdjU/04LIAOBhuEh2+nQ/V3vXqhGKNSki88OiBMxmXQ7Upse4M11v
	NtHn+QKOVtpi4fgDkQ1enO7JQDb52FDahGYKoYRKmzAvPvZZA1jFRlcff0A+0Fk9x9hrbELdaTY
	vksu+ebmE3HtC+oGwhftMIl++0Kjre5SkGQ1uQ1V5VoPvPQHC30Jylqj5tF30v6QZZtuOrAuQMT
	adKZ/P9UhmaOy4Es5Zob7PZio+cUvF9HlprUZk0i+QQ1K2skJOrM3g4LPviMKcIyGzdNtd5Pspn
	NOIpzlhzs=
X-Received: by 2002:a05:7300:cc83:b0:36a:18e2:64c with SMTP id 5a478bee46e88-3751eb8a9c7mr3451755eec.11.1794319923839;
        Tue, 10 Nov 2026 06:12:03 -0800 (PST)
X-Received: by 2002:a05:7300:cc83:b0:36a:18e2:64c with SMTP id 5a478bee46e88-3751eb8a9c7mr3451676eec.11.1794319922726;
        Tue, 10 Nov 2026 06:12:02 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm8059128eec.27.2026.11.10.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:12:02 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 19:39:53 +0530
Subject: [PATCH v2 5/5] media: iris: Free the interrupt in iris_remove()
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
Message-Id: <20261110-iris-handle-unbind-v2-5-86d5f6f1dea8@oss.qualcomm.com>
References: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
In-Reply-To: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794319890; l=1091;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=jIb2ycQ3moYpdaKxeD/lr+k+JtQ8YBIbnmK+M8ixipI=;
 b=TbDLgkOUwKMhe4NZ6wbIy3aRKhV6wvsT4DQz52wV913++1AVqsyHCTkZJ8guxxsBmE646qDPd
 qRNWEfzSd5GALHgQzZuwWrBPCzsFo1GP2Px1FeL0mpfUltKUfq5GHvM
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX7OmyMxssiAGg
 Bv/9cEL2Q5U4ARRSYMaICct8HDN2UFzqSNNqN8B/kLYIqaiBWAROCEEHu9FyQW1Ot+HSRoNHIWE
 X6OgqWiVCqOtacoRPKfXFMFtoVNGGUYLzvxzm8wEJxJbcGux66+/rsKOjhiJWQrwnzoEDTE8KDU
 /lywMQPstJkRCZmvKC0cLhctmzU+I5lCNDXM63/cfqLf7VZYadP5H6VerPHthkXQ7qTWlh0DQom
 uWQ3oQJYtimNi3l/8/cBOhlvLVxmiUTqec0mtFWc838iq4JDEX/iJlH3zouC4mihmC2WJ2Rj13D
 0BhpBy/2hTaPl1Ao7RfTDbmp/nFq2s+o4odztezPIheJCC5ssWG3t9b4sHhZHHuJFl5L7Vm0U7e
 RqLp1si/8rMAHpW9EKvLRqG6fPdYY1udEiyjZ7e6ykVrV/g0D3zc0+B98JC3OytYTnpWHBEQBZH
 B3+OB76neGorw28K+rw==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af32634 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NKppu6mipZSEaVxE2m0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NiBTYWx0ZWRfX+sLP6L1oMUiM
 oY1/nArPaAn2IddmCFMGN5ulQubdUcco5GVd2Xv/pNAJjEchiwLftyVkyJ2NX/c60ejhDKJbvuU
 FHiN+763T9s07xZt+C1y8yN3ZxQnI5g=
X-Proofpoint-GUID: nGFmkuEp6uZ_XhcNmcPt3YZF4gUy5vWz
X-Proofpoint-ORIG-GUID: nGFmkuEp6uZ_XhcNmcPt3YZF4gUy5vWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100056

The interrupt is requested with devm_request_threaded_irq(), so it is
only freed after iris_remove() returns. Until then the threaded handler
can still run while the rest of the removal is in progress.

Free the interrupt explicitly in iris_remove(), right after the core is
shut down.

Fixes: fb583a214337 ("media: iris: introduce host firmware interface with necessary hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 51054862bc64..925a450a8597 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -292,6 +292,8 @@ static void iris_remove(struct platform_device *pdev)
 
 	iris_core_deinit(core);
 
+	devm_free_irq(core->dev, core->irq, core);
+
 	iris_instances_vb2_queue_error(core);
 
 	pm_runtime_dont_use_autosuspend(core->dev);

-- 
2.34.1

