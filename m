Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481960;
	b=4hR4NJV8TESrBTXzE8mdfUBHhWj58GyvMMFQab1RF3AsS9eCf8UHe75f6aPCVDCgEzmA
	 zlgt15EbzaJvXKFOdaxXTxQw6PXgpZwsz3dst1IZeqOuazQdRIrSHS+mlzYYxVmUiKl1W
	 RW8fDTmPgIiH29EC5tDRluoKjdrn+xHzL3heT4sJe1rjlCi+OuajqvQGkmlNTXy5gBSYu
	 J8RcyAcVlqkcmP6onlF5zcW48rvgeaWMhguJA2dZTl2glWX+yLfh849eHO9CwTx7sVMLJ
	 DB53q88dJXRXa7pFrBRre4qkd8LSH2QAilJ+cayAyhwMVs8S3nT1l4glyaAL1EGwUtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481960;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qoA6ADeVtXSq9JMrH4L+llb/0nFEv/ASnOYsfH0syRY=;
	b=HcRjL+M1BmqrqVLd0adbzv2pP12FQiV6+pV/lYJz9SG17F0/IQZ906/CVmBCDF4KcdVX
	 zkc3RQ1V0sse5YhY0ZnCCcpXRIGbF92UpcLaXnVi5W0ZELJM3fxzt3+gdxGKNyC4ftnOT
	 O6t0TYVGhrhJw1/Y72MvbUApOdRHNBpMwtA3CihmeFYLqh6q4pbcAxFhoQMBe7QpF/UEm
	 pPYxpJcL5uYBKrnjartEc5OlBfsFH08DBG0bjEmc6PVp0lW9YojlUlUK/ZS7t/NedwH8C
	 p8TaCBMvHF1kDs9PU0WdZKtvBlpouvKyHb3Pt3QpT/5VBHXdKzv94aowa5npKvOsq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4Kuknhs;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J8d5nr2D;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D713606A330
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D713606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4Kuknhs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J8d5nr2D
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tG022877942
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qoA6ADeVtXS
	q9JMrH4L+llb/0nFEv/ASnOYsfH0syRY=; b=f4KuknhsLH070xKg974nmwJrNAc
	lBI3yzn4D6mV/ibCdntGHPF/AgmRzylNGT/On/T61J1Gt4s05eAbQ+K3nGnMve0R
	p9oLw52f0zZXvwnE5C3AR05Ug+9d48+RvLLWr+Q/cSXxsfml6LmuTq4fkt0s7060
	/B2s0xOrTotlWT1iPd8f5+o69Dfh/tuwTFya9fmbmwrK2rmLCCWHCFoFKrNXETQU
	A2BYXS7VnQN7aW8H+Vc/mIRDuOwgAiYcSlztqSDQ9mzqKw3o1S25S50IfiXJh+Wv
	sqowOVmkKPFzKyUm/cq62SjJ8MnekRP4hmWgM6ZHzlWGzaGOmfdHNde1xUA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5psdw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ce7a85f04so593894085a.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481958; x=1793086758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qoA6ADeVtXSq9JMrH4L+llb/0nFEv/ASnOYsfH0syRY=;
        b=J8d5nr2D0q1bqqO5u0t8C08ywBeYneEP4JOgEt41dFbafQ7uf8dJTgc6VtGQMJCZW0
         rcWhpZ9Wc3f1F/bLLuDtAlq9DYIiDM97tHq4wPRn9BIpPzcrn59FEoX4he6A9808rdUn
         B3BpVeMHMeG1RlwMOjNr1L7ZoCsO/Iheq7ZtzbizmIJe+Q7MuiFeoSFZ7FrH6cnLEo7c
         MStIrfZ91uGCW4ofsBIOnJp4sAkfzGF5Mo96TbVj4UnXmkR+Kg077rGTQWDW5TsKguVd
         1bbIGUPLQAx9YX10dz7xuRyWroa6XZTZsIEM64MiTFVl7D/IgrXygRi3PL1iQtIjrC0k
         Si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481958; x=1793086758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qoA6ADeVtXSq9JMrH4L+llb/0nFEv/ASnOYsfH0syRY=;
        b=cXwxNUxy3MM/9v6aoghCIk3BjVsfzco/kBjF2Wg9Tc+inpN1J6+8E5ivZrWbDdA2DY
         ixip7Ci0WklF2Z4HPq8BEKRGZVB6Rsd7ZpAG7kr+Q6EV6kiFGQcfT0eZIXbBKBQX2cHK
         7ZDdIJVwYPHPYI+Id1TFoj6q/Ur3bfgTeer0Gjk1KvVsgkjkROZcS6pBOuUGFroxP21p
         3pc/5RCq+9d6SqDWxYCDT8FTvKPZOhvwnm+p21QDncvU/hLzSHomA23vGH33IGP/VHh+
         qUQvsmm/XzLnMfiLCSClhua9uOtARIsGXUC7PCYFIYVasMdYKj/GNviQzO29X09hWAbG
         GLFA==
X-Forwarded-Encrypted: i=1; AKwUvBxJxMgjvtnHQsP39iJwsLECotOX/fc2OqZbqP0X+4uPMpPzANMgLaJzS2b9yRxMkfPA/5Bvxkk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI37SMYIVM9pu/LeCnVg2IQPJ5WDIq6lOHfQqQNb7M+WRnnBwy7
	VNNBNZXdHXawD8rTapYV/gN77l1+RqVq2+b2Aeu35mVxGZ4CCapmZp9t1UWKUqLItC3Ac91TB7n
	htY3SWz2mEZeSmVldDwqDWESWn2Gzy87WcUWvL0fOea0bSZMrXCVhstqIIIs=
X-Gm-Gg: AYBFou0bl5Mj/EtnLvWZDwx7mTVMqgnpkbyQmLGk9eV9wjsqh2ezrKEgl0k2N6YCX9v
	9LqMbcNHKKieaOXfP8su4nboA8VNnRfS+ByG92P7+wInCeLLBfdrbEiFoGc+XCR6c9bO8gYDnaz
	TooYdmOVJCDG0AzRBwDjtbHS2D+Xthqodw8/smqiA0ltgkNb+3+M8AhsyiQmItnrUYqpi1wwkzj
	mwi+vW5cnIctJSXTdu5Fk/dAJv9UwyPfR1tCac3jPz5X3xwxE/doXjVmojKwrD/FHXhcW5FVi3y
	BERib7goOLhLR1PR35KG6eQfonAHkOjCMbkC1dcH+Mkq4bpAT9eEj4DWVTSagnqLlIKHKfDExhn
	DUICnzDhSVkti
X-Received: by 2002:a05:620a:3190:b0:93e:f499:43b0 with SMTP id af79cd13be357-93f29cee012mr1765039885a.22.1792481953022;
        Tue, 20 Oct 2026 00:39:13 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:93e:f499:43b0 with SMTP id af79cd13be357-93f29cee012mr1765038885a.22.1792481952471;
        Tue, 20 Oct 2026 00:39:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:11 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Sanyog Kale <sanyog.r.kale@intel.com>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 3/6] ASoC: SDCA: re-enable IRQ on pm_runtime_force_suspend failure
Date: Tue, 20 Oct 2026 08:38:53 +0100
Message-ID: <20261020073856.1177749-4-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DrrDa2/+ c=1 sm=1 tr=0 ts=6ad71aa7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=w1d2syhTAAAA:8 a=EUspDBNiAAAA:8 a=AaUSbDpTSIYfnfK-pzQA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfXx4/+nDov9MOg
 vM8ShAhUvDnmfFdXK6zk2lDvYBZWQ24c7gKe0Nngtk/S10rYZ60uH+kE2CmpHbUUkW/wx4bd8/H
 TLVuWfzRRRBw7A8QaS8z5xcwSxUkOAS/n0daCdjyPZNnnagOjdJMCGDkhLMfB8P8bF/BPIHx2Fz
 4RbAfuQVt8fnIF2Tr2PWq7ZL7ZAVdAOUQAnt+WG+hSXjeHgf6RlB8bkhWHw8ERPuWLwNhtGYeV3
 cjYvTig2lkc50/M2SiN+OssEwLUTTAbMtCYXTMy8SKaRoP23s6p+9/k2+KbC9cxhr0zjCHtPKbc
 49k3AAKW1IxlRtVCLea/+Undvmmfuc6V3bkwDWh5V5QpWDKJRfYqm/7w+S9FnWpJcnDZAab/UBW
 B2PBwXzImO70XbOZoAclIgtX28Sc7cJ5VAG4K8ytsFFkwYl8Zbf6906BH733dGbixS76H/0nj45
 xYR/243v7slkpVy5A1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX9/nwmZq02BvO
 hDqgFvrQsXM3GCo+teVIoMldYat48XQ1sf2A+BmF/esI8whrKeh47+3xoCvca+E0EeKOOGXE+mf
 NlgrcQWcftTGkP9B8N0io8UPUNvAJiE=
X-Proofpoint-GUID: n9uRa9LeKDmOsD9R2oaz7YXvVgTNlxYC
X-Proofpoint-ORIG-GUID: n9uRa9LeKDmOsD9R2oaz7YXvVgTNlxYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030

The SoundWire IRQ was disabled before pm_runtime_force_suspend() but
never re-enabled when the force suspend failed, leaving the codec
unable to receive interrupts.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index ca311209c6d1..ee61c983dc57 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -265,6 +265,7 @@ int sdca_class_system_suspend(struct sdca_class_drv *drv)
 	ret = pm_runtime_force_suspend(drv->dev);
 	if (ret) {
 		dev_err(drv->dev, "failed to force suspend: %d\n", ret);
+		enable_irq(drv->sdw->irq);
 		return ret;
 	}
 
-- 
2.53.0

