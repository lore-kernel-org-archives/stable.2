Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481957;
	b=idAkXW20IPv5ZnNYYNdVDRd76LbPNGtx17DpkyaxjxUTpoXTX/2BvDIZgsnsk4sJs4C2
	 quaNEpH3Iym/f8Um0hWm947NSBtMg+HcdrvNLrrjbqzotiTMCCHcpwiUNoHaTrzp59RSb
	 NLJFuAfQ+CnT6ahLDPQ0CUsSbr9A1r3EVhCKh8xtTh0A5e24HadlvESWWHUdngTGcjYbn
	 HdV7GLUFXvKmQ3HfGnsU1rblJUYSbq/s9e58bWpYVtxpl3bwwWq5HRVXhuAioEKmXj0Gz
	 QZB713Zsv8vaADqxG/GKFKTsxzajgQVwh+QK1td+jW+8JK4HBVgaYa5O2Vrg7ZT9Q8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481957;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VgK2cMLsx+obslnqu5sYrnrzY/q9pv3tI9Vj5znR6zc=;
	b=FrJUQqr1BAuMeHGQJC/VbImnfHtZ6Iw+R/0q/NKgV8YSdu2siPeCB5orLMLTi02AiftX
	 MR0ZPaf2YEW/qgQ5+gy/bB/AT3QUXsLqSOFYNZP3+CVmrtjBHHQRplhU5sx3RbTCv8lwE
	 dEERbWW6UspUfXrBwqF23ul/DdR8hCcNhk41P5x98NBkPq70dXnqUpalfgok5YH/NyyhJ
	 mx8O7Z/Lw50acLw8/pdY+w7qIHJShDqKeOpMkEtdp7875cJM8ytIYwmNgmlh7ef2dRddR
	 w0tGGTracLyeTo333t3bV9xEJtwQRDrXrtsFSFgGB3oqQKiUPlRrncYTd1ooQFArA3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ahIuoD11;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MyG1mfr2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD260A2615
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49FD260A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ahIuoD11;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MyG1mfr2
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tFC4186368
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VgK2cMLsx+o
	bslnqu5sYrnrzY/q9pv3tI9Vj5znR6zc=; b=ahIuoD116fOXstk31lDWAqcUl2c
	d9HLvw7XoiG+xdPmPzCdZ7vTt6TFxsnb58rMI+tae31LlvxJk5d87DRHcXiwdefp
	V0EGRJejVm5imVGORfkfcEivb1HKZfjtxAMQ432rrL4uDcrJA4Xw0t40VaakucJb
	L8jeTUbWGCpaOIdRBVj7bmSDTdebKP+h+zCO4dDpSsX7VIcGaPH8chYYxZL0eQxT
	aiLnjBgaNjx/8NkfPNQoOB5RY9FEIm9tfDNfVfT3D80xPWsa/EFcDhF1QU5Ay/Bq
	s4/3fluD3kyD617vP7+l0C1Lyk/S7+czMIcvBK60rQnD3zrmcM0opv+UenQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nse6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f33438950so762842885a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481955; x=1793086755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VgK2cMLsx+obslnqu5sYrnrzY/q9pv3tI9Vj5znR6zc=;
        b=MyG1mfr2B3QiXx3WTaz3WIT0b04CT/EIC9JmbGgpxCo99ljXa0leLBBm7tie4353CS
         f6JOZpb86sZVX+g0HDV/iGjddhNLHYOYZ0lxireNka8kCBSWgs+AiGuMlNsPD+bv0j93
         ixQqifdi7LfEOV2tuTTCVPGJiXzcwDjilkUfZwss0P5J8HzstZjxJn1DY9ER306H09IX
         czOqApmMupJ8e7fCru5qvdqVm9yzMnLVuu38McXTQYZ8hfCK/aYOQQm0rcallUwx7YDC
         KzfwqSByfl3w20f8WAiberXlyAXu/s6LP/qwK6bWbh7SZ/cHq93eJ39t6wa2Og4fsaQ8
         PfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481955; x=1793086755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VgK2cMLsx+obslnqu5sYrnrzY/q9pv3tI9Vj5znR6zc=;
        b=gFuHwgx5U4Pxe6vnLOwbbJRGEyAHlvTf7ZAGbX5/CH4KQgf0ZbhaT4lH7XFGNLKYuT
         VwQqDN3g9cW5FwxbVHlXKpXmXPzOaAtT8J4CDl42VqFIJhCkLJzPk9izbL2WAF2HT53D
         qdFuPx+P9mU4urzSKaHmAQ+BDqtw5AVubrbl1xWcGPb8hx2iNkUgDRDTWLIHNUqT2Pgf
         gKyHoRe3f4mvlgbId2C5KsCfVsghLezv7bh5a7q0jtmTZRRcl2FopDGYbQQAsUmodyag
         3dFFGcRAbWzH0S4Y3lSZ7TFXVkPCTckBAMLwmexsEzeZeZzn+RbN2X97Svrf35ekqK3B
         qLdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWTiB8Zc3oVvO8eBLAocPckJ/0XczE2XZbxuqbGf46YIHi8guLVEWZIUmu2hdbNeecTC5ENZE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKbgDpFH/Z5rzVVrqZlnpA4J+lnysb2OFyt9iW24VI79qvNT29
	lSM92xkBY4OMAn2JS14a944xeri58S1MWEXdYUOyVMc7Q30C1t4phpadi2Nu2VZ+35Ff1wUEHaa
	TEu5J1QAZaOecpR5oP0et1VcCq9xyQyJhGlTNJ6B75hf0cuHCOaR/3qWJoEQ=
X-Gm-Gg: AYBFou0lgXfx1G1x6Z0QnV4a56kJlMMZCAxC3OIylhdLVbEr6AvCfBnynivJQIB7Wip
	5kPGmMamicGcVB9hg0uKhacEsBswd3Ie71zBAz71863tc5IRMY822ZUUv04Pxq9KGiS/6Cta3Gm
	ZDoEhbgnC8I4lawgV8rl547INErZ499O+wRCC3Km5BqCqZLlTs4YTG3ruRYaOzCniNtl1WahYjP
	kcQLUSnQTZdpoCfrnUTXds+MnAXOca556clZc66llnZ6yvam3e1kAl4jAzNPnbzmTN/qiYRBGEQ
	b0b3wFi+Kiiwsw6668hHAYUC1oTIF0pPDr7adDkKT7Gyf14jgCKCfa+tpDvLb232wjh0LT5+0CL
	58/nQLz/6cGvr
X-Received: by 2002:a05:620a:394c:b0:93e:5861:34df with SMTP id af79cd13be357-93f29d7be8dmr1654892085a.47.1792481950538;
        Tue, 20 Oct 2026 00:39:10 -0700 (PDT)
X-Received: by 2002:a05:620a:394c:b0:93e:5861:34df with SMTP id af79cd13be357-93f29d7be8dmr1654884485a.47.1792481948317;
        Tue, 20 Oct 2026 00:39:08 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:07 -0700 (PDT)
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
Subject: [PATCH v2 1/6] ASoC: SDCA: propagate sdw_slave_read_prop() failure in class_read_prop
Date: Tue, 20 Oct 2026 08:38:51 +0100
Message-ID: <20261020073856.1177749-2-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: jARmWNo3D-axUGY6qqTgKAb2No1OcCy5
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad71aa4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=w1d2syhTAAAA:8 a=EUspDBNiAAAA:8 a=jwOcZKWdBhvvz7EOEfMA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: jARmWNo3D-axUGY6qqTgKAb2No1OcCy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX2ybvqWRLOW8K
 K95DIK78b8yOkhfmLY7Ti9m5uaK7pju1z5gQXsvdcPbnMnAmIPYkTgvTeBI6+XxpXS2Ftb4NLJL
 c1EQDi7YSsWcK3/uNqUquovXkDWF6LIAyTIgPz81S35iHjSA2Rm4ilw7kZQf0crh75FZLdcVf/M
 pastvGh9yDkHjrhbXTUA9Ryc9t8k8WgDDef+/gC5vNWoDcaoNTKt5eNPae0qsF/Yll6sTJ9390g
 bPCfYY2Ow6AdIB9v/urvirVksZ3MvRfj5LIP7aT64dKMJPzyaaXJ9qxSqxtY7k6GzpMbxHQOFGx
 r2sx7y7e8vRlniY+nNZQ/4Jk4pjXkN91DX8pm+VpbJXZ3FWX2E0l7aeeuTWqn1iVId72PN0QkaE
 sW0SMaSvegbUKPoMpGnJ/b/g9Kk3jIpaLXhbC0KAkGmwmlQgQ5LssvM9/J23BNNd/ofYRDZMzW5
 FNwQdhxSzYqcPujyZ9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX2tOw3+0yFeE3
 5YZlijD09YhGCIO3/IUvjshr8nQMsluDxLLeZa30YrvLjwTUzvnfO8K/onA8R7PI9NhOUB1OhwI
 G3z/ikB/AjRp6LLmOY4m6BQVGT92d0M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030

sdw_slave_read_prop() can fail with -ENOMEM; propagate the return
instead of leaving slave->prop partially initialised.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index 79fdb672be1d..bcc660aeb739 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -27,8 +27,11 @@
 static int class_read_prop(struct sdw_slave *sdw)
 {
 	struct sdw_slave_prop *prop = &sdw->prop;
+	int ret;
 
-	sdw_slave_read_prop(sdw);
+	ret = sdw_slave_read_prop(sdw);
+	if (ret)
+		return ret;
 
 	prop->use_domain_irq = true;
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY |
-- 
2.53.0

