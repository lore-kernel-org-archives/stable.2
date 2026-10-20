Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481958;
	b=2quqFDkNc84shBQa5e/gLgglUTNTDp+WRiWafeCHKS3BBydPqPnZJnVebm6LAC3iWkmf
	 YRGXVG5syNdlwXvwAavnGKQRMZ+a2ZoDcAv2UeSd97yAY1B/xc3Ba+F/3GoBAW+yBtwGV
	 Ac0ZMFcRhV6i5q5iTPFR5SL2Is9AsQ77k/5vq+Ue9GbB2KUvUrxTyPLvAhxDZQ5F/tVUg
	 VdFWUJaHaMIYF6I6qRaALtqyVOKaH4CiSbOrtvb0B7/snl/FEL77xUJ1wOi6INSci0Wvu
	 VPMJWsVChjGUE5gzUWV0Zg6pmxWfmxBA48hCYEvjSpmpBczyOcLbAjW/Sy//dUJUTMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481958;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EyaVBfoPjvnSMo2Diw9nR7qJvmDk1I5n9dnvXC2rzQM=;
	b=nh5xai7D7qDBoVpCBRv5ymBZiEQorTNDC2axAu1VqCsfUJeZl5VYgZOoGMBs844GECDp
	 mOjS0eKFflsIBqtc97sjbk2Qx4HeJBmhkmPKHHvYdIfPqJbfrVciW7TQDp9z3C2PcwOrC
	 ucI0h+XLmFpa/m+tCyNCywWF+yzFkZNnZ+3jJhgJrtJv4a1SGgLQU9tXFPCmYtON456Ey
	 /jg12EPHjYTiDoTPO1anPVxaTu21gThCzmFjgt9WiQPEbolFrS//ry/dYY7BP6HJlyoeW
	 ybirXx4YI93Z/LghpCv8mIsebktFmRFxGWeKHa8WYlUfJIz98hen6rcD+HHPk4T1tGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aHjw9wPk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIMw47uf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F0606A320
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44F0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aHjw9wPk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AIMw47uf
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0t3Be1253890
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EyaVBfoPjvn
	SMo2Diw9nR7qJvmDk1I5n9dnvXC2rzQM=; b=aHjw9wPkBTJ0aaaTt7OQG4XQbHy
	ihAM7SSwPiPp9jd/PR4jv8AGXcxfeMcJSXSaTf6C/HBgzZlGhb9DHif6AUYHft0g
	bIDvc0vlrlRlOhrVNAM3uh+2o6gDtzfI/w4fZhqDHMv5b+btJWw4LadULgCyr6E5
	PBCWZlvUsXq6zhGS4gDwqgssG57HTYHRjMGdYHEeNDKf/Jiu5f49N1yK7ljpP/2V
	IAKDClWfq6QiASUVdco43Dp0PoCmOOHem0PM5qW/x6yV6VdtWXgSFUFeMZBe50e9
	yyWu5G3u3iRzttQGpXKVvfylxaHzf2Bkn+PssUyK6e4gA659dAoCCbIAAYg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n9e0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:39:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93dd3c3badbso701806185a.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481956; x=1793086756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyaVBfoPjvnSMo2Diw9nR7qJvmDk1I5n9dnvXC2rzQM=;
        b=AIMw47uflho5o1de5oDlEHumsZUskcfePORtax9hYdLokxYk9Gl7zgfGyZkN0Myhek
         kAx4BA6KuEvKxwJ6xwdsLmlciyyRm7PuhStunXk32kJLe3uOQY+BX+CU37mke6GygkTk
         LtG+4pYuXkqS3JgYj78mfUSCTOi5ufQSFA18NpQ6oBHDzV6ZBZXd0jWYOx9V3nVympeP
         3dM9Jit2tburkkmrYym+qvga1zOFV17L5sEXczqVJEKx0hmoFj46NvRTLNT48CwsZ5Lm
         QTVVSeuC1EhfKbbfrYx89SZ9JaM8YGx0VnbV2/eqBCqdeSfdc91bV0IroPkMidhtyMyP
         pV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481956; x=1793086756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EyaVBfoPjvnSMo2Diw9nR7qJvmDk1I5n9dnvXC2rzQM=;
        b=tpKoxDpxx3nPDM3O4/tunWVUX/1il1t/G05PaFyzdo2VpjltORWA2xQselZF2EoUF4
         rqk8ODc3EiWKyElyRxwTR8tkh286IghvmZ6hmbneRIvZkSIB6XNzcn56ezfb+8TB+VdM
         JjcUHRbfSq6vYekV8FeNamieelKUdK6nqahWAHhtEovOW2UWQOQs4MnHQDJvyfUsQffl
         HRMaKfleKbQ0D+r3dVPyzLUdWHcATeTV+kprTXqAT0OeHq4sH4gFhghkDods0gzlI1yw
         0uv33mggj7abmQg/v1HoACS854ofFQbHQOIE41uXa6sIX1IECKQfzvQfWAsaD9sSbVCF
         hv2g==
X-Forwarded-Encrypted: i=1; AKwUvBxJoVBGsCJper6vyEebR+PAliRl2biJtr1K6dcwULxEY9j6r19tnPGb4K9IAwWi9Ny1JnydpsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYmIH90U3UtcKcQdCmkYTFngkvVrC7HRvybkUmBSoL/Na8hsz1
	I50wYXe8EGq6/iU3JRXEt1Mnl6CfjWDB66rndjp3G053hKmmrcLLCobgfSDrDeoM4fG9CA1UK8K
	YR78URH/wYi2Uhj35sKA6REjIRZCYQGvEasTd0Z53tE4etRp+gP/OGflglD0=
X-Gm-Gg: AYBFou3dE4It1IwiibUsRbaCgyL8ZaQxs7k0SLOPCMy26nLj8x71dB0Qooyy1h3fUsg
	kEYwwtTPfS7ZY8Qd7tRmYFEe8hViWf6axj0sQ1eKO3+/hrDb6oXTNGIEmPWFIP/X9eFjdLmESxl
	WTNZ9rbMjseUjMfrn5f+/qriYn3UoqdnB6XFO07GIL11dUoSdqoU6NGhNv4hsl0CgH8ECfkA9g2
	XTJjHiIDtZidwA2UL91ky8YZc9zptvAMu85oeGDnC+MVacoQFXkm5nCLrqndYkUtA3uDxPMvTln
	w/EHFDENEok/wYiUJBAGRgvpxPzQX5V+QXUxdgPSSpJBMGBhWUsKGcbj8bd4dQDKA27qmHEExCN
	ylb5fSr7biD+n
X-Received: by 2002:a05:620a:2254:10b0:93f:2ba5:170e with SMTP id af79cd13be357-93f2ba51e72mr983924985a.18.1792481956166;
        Tue, 20 Oct 2026 00:39:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2254:10b0:93f:2ba5:170e with SMTP id af79cd13be357-93f2ba51e72mr983913985a.18.1792481950954;
        Tue, 20 Oct 2026 00:39:10 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208e0sm4566271f8f.36.2026.10.20.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:39:10 -0700 (PDT)
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
Subject: [PATCH v2 2/6] ASoC: SDCA: drop pm_runtime reference on probe failure path
Date: Tue, 20 Oct 2026 08:38:52 +0100
Message-ID: <20261020073856.1177749-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: iuJMi29A8jjQVGfOcCey0JWe6HxKL1lD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX9gD0c1EVoIXm
 cFz9M4KtkgwU2u8DbmnqMTLMyRCa86MVcZGmi3Z/x6dLLj912Cma67xQ489CDd+H2401/MddTZO
 frAGGTL5ijGfvY/PpiIpMEJfgICmkqvL6iWyafsnX71v1MGiFrz7A+/okvUcYrSoCOkpsKO0APh
 yz/GsHjLPL9tDpUMmTzgQkW0mIwWM6A1jXxOPG5ZsAdZl+6VPUIj1HU7fzriGaQsoJoRgSU1WHy
 vsGcowAIfuV4DdxQlGClMl69TjqVKYRcI+6RrKuSVEV2urSakpmJwyNDTC+/eembOuy2bQBZv0g
 zl/9SnXYEJoH+vJaVCyekRdwgvlvuOqKzxiInX5meGpuIaBX0ctXM/kiilg+UoObQjMGG2GX0/G
 4KdlEVA0pCUv+PhdsIb/xOgnLK8eWxMbGd6mSKzYWoz/iqE2zM7S8WDIVRu4emQCRIeDToi3Mjf
 DVzUgmQhpcTKZMjN+ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMCBTYWx0ZWRfX/TDl6keIXxfY
 p4t2M7SoUPyCZXqLDzwPYDzmixaAjMD5dJScecWUbkSHrh3wHj5ZgeEkQ63aKPlrC3NTW2/dGhW
 jY+xyZVPVrYAFjwQeRtZc895q8SlqH4=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad71aa5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7vtXEAv6VZJtN8Rt8ykA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: iuJMi29A8jjQVGfOcCey0JWe6HxKL1lD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200030

sdca_class_probe() takes an extra usage count with
pm_runtime_get_noresume() to keep the device powered on until the
deferred boot work has run. If devm_pm_runtime_enable() then fails,
that reference is never dropped.

Drop it on the error path.

Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/sdca/sdca_class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
index bcc660aeb739..ca311209c6d1 100644
--- a/sound/soc/sdca/sdca_class.c
+++ b/sound/soc/sdca/sdca_class.c
@@ -197,8 +197,10 @@ int sdca_class_probe(struct sdw_slave *sdw,
 	pm_runtime_get_noresume(dev);
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync(dev);
 		return ret;
+	}
 
 	queue_work(system_long_wq, &drv->boot_work);
 
-- 
2.53.0

