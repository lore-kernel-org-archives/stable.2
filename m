Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5C39EF16
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638618; cv=none; b=sMY+51uVLDn2y3Cjhs1EP4Xmw8nl7I2Zr6PMfCFtqsxHhyR0fPS9woBl8dQIDINBEVsBqwsV/78g75vM2Ttf7MzHtIdOY8Wg5V4ZG0UzeNSjwm2gdhTou9mubvqjJwD7iF+W69rOI0k9PaozPIFJQs/gMhHWUYL8y9zBiid3go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638618; c=relaxed/simple;
	bh=VKtvCqmaFwakDh3dPdx59QHwtYLAF0CeW9u+HP99fIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSYcH3ge7fYfkrFqPmu/g4NA7kwh9tBrAiqnh9hWACIgHbivI4OzlRKl9rpvaY1+FVU7POHGHdmmI85TMIKWCGcMcQI1FrsGFfaMWJgn4zvQI8DdRrnZhvt98gNIl1RgpTcrSP0qB821AP4aYoSXrMHTu7OsPkts9xCf8pGaTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZWNFDDrL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Af2urDWa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWNFDDrL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Af2urDWa"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9Zf0W577171
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EXfjpYF/qRx5R7vw/ngOXgeAsq7XaRfsZ2rZhaAn2Fo=; b=ZWNFDDrLmTQxDCuQ
	HFDQlHMYRRCo+rH2wLP6KJcXoMJ8HI+z1pxwgOXSBrbhfMiC7OjhqJkMx4i5kIJP
	AwJaTN2D6t3ambX6BPl/8pR9v0pmvtwDa32vIbW1mrUzIMb5qrXaO6bbugZMRZsn
	+VXJ8X3YFMjpnizlN8t8hGnwKJ+yYpFGJgBL5AyJb27KW9XgaAuG6d53uPGvPzMm
	lqMNnSS1Ik1zfwape1U3jAVGp4Gn7ZESpuKhHd+6Jw0cQVesTbS5nyjtU8AXCryu
	XaWpXmwJh3S0yS5zirrCu8D30NDPMcpnQsqfnJv+EYJvZSdtlmB0I5n43w71rZwb
	eeIIvA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw19j9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:49:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9394ad7f64aso86554885a.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789638587; x=1790243387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EXfjpYF/qRx5R7vw/ngOXgeAsq7XaRfsZ2rZhaAn2Fo=;
        b=Af2urDWaIm9Qvt7MYKgxXX4jE/Fn2BjvAk4rarzLePn/2MiX5bDV2BO7pRIumxOQ1P
         WAz0D5RGNo77j10GQx6Ynyn7vyzvFFrBsk4QN4u2MKxmcMDv5wFZN2kvmeoRgZfQmV45
         8SjHlVDVRJzGFT+BsfwkWreP0rwZW9/IgPEhSQCuIgjWL5+vO9YVlk+fgpj+GQFuqiWw
         BAOh3Qkv3fLHDZ4HEQpGQ6cZhQ5cBHJz/wWviTNn3QRL21wGH6Zx95kIadYz1PiWmqaC
         Hs6tIbuo16wckmnZuMbgyW6RcEGu8fBCwBrFK6HtjsMdVN7+PNy9QYypxT+Csmgw8Dyi
         EmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789638587; x=1790243387;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXfjpYF/qRx5R7vw/ngOXgeAsq7XaRfsZ2rZhaAn2Fo=;
        b=ps5RJkG6TXh1ytlEzXN2vGjmF0iD/uL8gcaDZHwlE+b9b/T5V1mcqKlEFuwLi5K1dU
         9n653JMZZi4KhXVJA2MIolq8MgphgSZ3T1qBWsudWNlxa4+jdMt6S32+Wu6urdi+204g
         1XcAYNwICdVHECBJG94+nZ+TCo/l88HlW0k+Rf9S7McmDRGkeFMHC0r/ESNtyIfH1N8u
         +q+jShmOlPLQ4KH6vQksrnEAWL2KBlvOmSTaUJlOwvtcO9aajj9oR2nWW1hBHkNE27VE
         dJ8uVxXHJYkdxXfEN05n1znbJ5m8RwBJ4McPZxHyDulqB2pjNikonyoEydUvePert6bX
         wCtg==
X-Forwarded-Encrypted: i=1; AKwUvBwxCF0W/F82Mn8Epwna2MXmjLQmRVlhvroliXvLhNs73B5MAiqZFMPJb0s6mwRtn9C+yBlZKJM=@vger.kernel.org
X-Gm-Message-State: AFuF++ki/GeP/AVCcwtoeA+OlVtcK5pRQ88uoHGUinAObAc4t17oFWId
	PcOvmUGrB3tqgUdyDeG9BtC75BjN9Rfs2WjJ5DLfH2bJJJyOvvVwEsN87JfjTlOCQXOyJSBkmyn
	1C026vjfFa6R5L0LKeKOE0rtPhUJMkqLNJ7t98dPtHXvRzaSmZ5tEfLSmhjw=
X-Gm-Gg: AYBFou2UqCZJpt0NGBw++OUtrsVjV1b0kty1xpAcysvZIbSAdu9WTFQB8XiD5EDqEoT
	MAXgNpYy3MUX3qDNZFCbzGF1z2m8415DZg3dUsj5ZRORlrfj4mFEOxbZGC1Ll3jOUZvIeu7omdq
	raCiIg9y7FEU3ZSk4nSTebv/cq4voSFawwE1lUlyvHo33/O3Vb3MTt1J1SKwmvYgAlPp0i/zm+1
	ERt9knVrjc1ikjvpfX7/38HovO/HWMyDHyj1/3ee8b5e8GIvpdqYIeBKyDCT8eYQ9XuG8zozFtI
	rClF/EtToOuW7ZD/N2OO0Hk22A0OhIujW4AHaHpuLjpfZbZqhrg03/onZxxYGmj+1NkC9GsyE+M
	DmTOn3iCX2k2CEgIj4OGBjOms3+g=
X-Received: by 2002:a05:620a:bd3:b0:939:6de6:9516 with SMTP id af79cd13be357-93bb79367b2mr1090260985a.45.1789638587054;
        Thu, 17 Sep 2026 02:49:47 -0700 (PDT)
X-Received: by 2002:a05:620a:bd3:b0:939:6de6:9516 with SMTP id af79cd13be357-93bb79367b2mr1090251685a.45.1789638584950;
        Thu, 17 Sep 2026 02:49:44 -0700 (PDT)
Received: from brgl-qcom.local ([90.161.207.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm15736333f8f.1.2026.09.17.02.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:49:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linusw@kernel.org, andersson@kernel.org, brgl@kernel.org,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        pankaj.patil@oss.qualcomm.com, maulik.shah@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: nord: fix GPIO interrupt target width
Date: Thu, 17 Sep 2026 11:49:40 +0200
Message-ID: <178963857686.7532.12774109057722051769.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085720.771498-1-zhangfei.gao@oss.qualcomm.com>
References: <20260916085720.771498-1-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hyGYlAcoiuq9tG-ZyZIviZ_vlRL3dnCf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzNSBTYWx0ZWRfX4sUmZ5s0vGL7
 xzNzxkZkqkYjjiMqr6kCat2zUdxcXvy4qg3fzZSvt05yfkH43bclbJ4zKZ7mnuTClEXKYgZxMD3
 1FCN1XGgW+MIxSln+ZWvz/QRbuQ8DPC+byhusc3EK8EUpjELB222+NOEgOQRs9jLznNvmPx5mts
 TnSX0tX5Z2UC1rrejepKBCy1AM5mXGCt3BIopaOHzoArhM5zSCAgBl8naGqg9KR9AGpKTXBlR3W
 c3JDsKXBxJaTZNX63H3O9GOwNPSsf0EziYeFyvyhRsRGni53auxHWAWtfHHiQ8TE6wCc5gbqrYX
 QErxjyqdPo+H0fMTVBXWZB0SZPswjQfhUZ2aJSidYh09VfBZ2t84vPTXVfZYrYAC76MyeuPijJ6
 qx5zZCX0Atu/B0pUfGgC1/c8uX3f/2PdIeRc8J+Nzua4fZtOWTG8gOqZVG8FwgssetRGGKNIU1S
 Sealz08NwSOzijoY+Xg==
X-Proofpoint-GUID: hyGYlAcoiuq9tG-ZyZIviZ_vlRL3dnCf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzNSBTYWx0ZWRfX1u2S22vKCb0Z
 zPZtws9CSGOlmGCI5gwLiokCqlsS2dXMGhVPU9p475rwmRRF8XTOHouQSW4MsFMPFP267lI47/y
 IbbOm2l7y7XOtsxPIfYtaamssK/eBeI=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aabb7c1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=BQ2oiuy6hHN+kKmom1QVvA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UQ-mpCxKgesnfiZAKPwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170135


On Wed, 16 Sep 2026 16:57:20 +0800, Zhangfei Gao wrote:
> The TARGET_PROC field in the Nord GPIO_INTR_CFG registers occupies bits
> 11:8. Describe it as four bits wide so the common Qualcomm pinctrl code
> clears the complete field before routing an interrupt to the application
> processor.
> 
> Without intr_target_width, the common code uses its three-bit default
> mask. Since GPIO_INTR_CFG resets with TARGET_PROC set to 0xf (NONE), bit
> 11 remains set when the driver programs HMSS target 3. The resulting
> target is 0xb (HPASS_DSP_1), observed as an interrupt configuration value
> of 0xb1b instead of 0x31b.
> 
> [...]

Applied, thanks!

[1/1] pinctrl: qcom: nord: fix GPIO interrupt target width
      https://git.kernel.org/brgl/c/68ab4a6a84b92f52650508acb60317eb76454250

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
