Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084309;
	b=ljSaICz4nGmyIowJegx4qZyzQyRW6Z/onOXYl9tkIhNnl35UqYWASHn9iagaiDf1Mp2X
	 hWcZxPRPQPiavF5ZcHJ2GMD3HLeGWUJycLN5QNb4cicPRLeUkK4SecDGVvPDPKuRCteAF
	 w47A210r2Lbcq5/nRT93FAk0y8kzu1+l0Vd0D4a0W3kDU0Lej8PtJOmL/Cs4MVThxaD6o
	 +V9ZLJyd6UGumnmNy1ZbjEeZc1ZSaLzjUjsGCAlF5Lg1w/APRq87XNmwNJR5QzJl17myB
	 56qIBsi2bGuU9gIpBl9ciPd1Z94yVfhoswn62QWdnR/s8pBEJ5HUvlBnk5HKHglX4Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084309;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=D7SOOLu4G+MIx/n5d9fRiG+tkN2TgoMcpVaaDx9UbOQ=;
	b=UFS/adpoq5DfSWpKVDlyIC9CNT9GZ/pNs6qEQs5ppDqucds9L57si3YUsN/dWQw3B4lG
	 wjU2405RPQdv1+jV2JzUvcJylI4ZfqjvLDVCuvl7vWs0jemC3VGRRiMrsVomWoa214IM+
	 z0D/ACZHxMk4VH6wcIsAOuHht/BhTAud8TEw1bRafKen/YXTZpkwXyMsyLktzMARUWn3K
	 0iY90Bm15g6Qsr/n6Rbdhyh2nutlW/Sp2hsF9WQyoceQpElwAAENWBHBUg/ME1aetXisN
	 GLVHDumUdeIDrjEBQBRD5SzAvdVvUMjDBrcnn+jq1i8+tWr+8YvrzjqIoWkBP+LAYfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rt8QaKIr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BgQqxjwU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676D606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9676D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rt8QaKIr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BgQqxjwU
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9xpPN3351505
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D7SOOLu4G+MIx/n5d9fRiG+tkN2TgoMcpVaaDx9UbOQ=; b=Rt8QaKIreejd4vOo
	tSBSvpkwnB+f3c3Xf5lf9BqbTgQip9zblH6bavvWtEtSlQSsjXlvTt2j4RKSMWVu
	OsPJFbYX1ngJEuTAJVwuY/ZfNkLokyYV5yuJXTRCV0h63x8yFPeGnMDacqH3SJmy
	ZV+FVqpcYU5GlURs0OjYrYAC/JEfGq2IyA6ZHnFepCIvrukZAOS2Ezlz73pj6lum
	KEsgLU0/W9QfTNg74yP5TOoY0+hoXkaIKgHyMmCsKIhArpXKBbL7h1O9eTxAr0cL
	4TM35j8akQVEbbrP/GeH0QLIc8FuLnkyJlapE/VyiA5zZ5lvLJLHltZ3WTps7Rlp
	wwtvzA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymg3y4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:31:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-949b0d3232fso51552685a.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 02:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795084307; x=1795689107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D7SOOLu4G+MIx/n5d9fRiG+tkN2TgoMcpVaaDx9UbOQ=;
        b=BgQqxjwU7nXEsAaxHrXhATj9uNnONr1+q4ln9jpgINdJGS3qB3nozrOO00PX4W5XRr
         RV6m+jti4g+uTHJLaS+WAL+A+R0iUpDwAYUJ+PSWG1UFyuyEwglxHEv52TpwSFJnw9DH
         k1+wqxRgQ0S9kLH8pHUuXuDc0mMRmfuXGt7Qvfv1+fSZTzp9UUvhiEZ+ld5AvKu0ZiUW
         rnMWG5FrCmetpX7q0fKmcaJFirv8hTVcnuXrBKlnNuvqa8ZLtIo4fVyLXXDGTLatM/95
         GkrLJJKK+9SxQY7UC6tV/j3wP/hc7CjpAmNybFrzwNuso/wnC012ym2vcExjpqnAu9fV
         oolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084307; x=1795689107;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7SOOLu4G+MIx/n5d9fRiG+tkN2TgoMcpVaaDx9UbOQ=;
        b=R4e00jUcshj9uWV0BdhXcPbnx8iDQygjJ4gyII6OwsfGLnZTrbOI/8CQQoT93Ww1zF
         MGw1ACUw5NOj9amTxwdvCRQJOqud6/kcyuTNOdOMT27BOGT4nemEsbjzaNQSknOuTH1o
         TlBR5pgCzmGG+lDypfqSgVpf5pfPzy+GBVPByVFqYH2zwc8W7wWJTjiYNnRGbJzczy2N
         eWIq9ArAWNbTHMhLdX/eTDRs9QlFcgokfA+YHTpkbW5kkN19UymsgAZD1e4qkDBwh2QV
         w5cxQrBJJiHAMJEL69KYGzyJVD4rD3jr1Pvfay6Smah+hSCLPbbFD9Mx3V5p/9y/o/Fj
         rv/A==
X-Forwarded-Encrypted: i=1; AL+hErEsKylY7L/4do+BGDi+SF5TKUOwpFwpfA9seTqimbPC5f15hpn74CvvFQNFJgSicCk9vqfPHek=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p653y6zr8KK3o11Y6DpTCQrMUFjR5/v/F/gfwno6WD0kMpRpU
	6eJNUZ9H5oXbqoJQ1X/eeEyfIo3QAfyArsDiMsE1phxFGu8ZTX0OwcqEz6EGwGJL+ObX3Grrm3w
	dOaoGHj+2aWZ74je6DPMk+bGj73W7idW2ZNn508KOcQQq1qSHFRwO/MFV34cBanHJNTY=
X-Gm-Gg: AYBFou0QJ9oY0pLSAm1gopJjvUSfa7wjbfnxroR7m3hz0Ik2iTUmtxIC7ILzoTcFLst
	rDT1XdznBELyAG3yAr9HvU++EIaQlcfqcyCbWhlN7uAiahaFU6GSFYJ/ez9jkQN4YWxQwnHpRAE
	8YL33Tn+M4ID4Ymjk9g+n3ytq832jwj77PlgQPExj6atMjisYW+9jQLf74Q5FiHn+bxkFEnLiHd
	5Er5kdBpVnDD3fAn6XA5gxxAUtsezoWTp34m5psA+66/y6MtzyuOGONxN7ZmDZd2hJuQk9QQqaX
	aA85Mt/0NEvOn33MebcAcBlantA+Duy4Pfs/6B6k9/Sa1dkLwxrzL90mHnZXVqYy0vb1YgJ8Z5A
	dylqBISBQaNpl7/k3F5P8RCLz8UQoL/8GXGkQ6h4D8kde6krCjf6LOM4w03o+QXqNwTeCB0CtVn
	Y=
X-Received: by 2002:a05:620a:46a5:b0:93f:22f4:f0cb with SMTP id af79cd13be357-949995ab612mr1085617785a.43.1795084306634;
        Thu, 19 Nov 2026 02:31:46 -0800 (PST)
X-Received: by 2002:a05:620a:46a5:b0:93f:22f4:f0cb with SMTP id af79cd13be357-949995ab612mr1085615585a.43.1795084306168;
        Thu, 19 Nov 2026 02:31:46 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm26124995e9.5.2026.11.19.02.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:31:45 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Haipeng Lin <jimmie.lin@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Val Packett <val@packett.cool>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: sc8180x: Add missing dual edge GPIO IRQ errata flag
Date: Thu, 19 Nov 2026 11:31:43 +0100
Message-ID: <179508430131.48541.2060654933340230751.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114-up-sc8180x-pinctrl-dual-edge-v1-1-aaa31ad633f3@gmail.com>
References: <20261114-up-sc8180x-pinctrl-dual-edge-v1-1-aaa31ad633f3@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX6AUFZKLRFARS
 V7Lvpp1SKcYsLSjyakCGSOCMPLogIvGPffpNX5EqtduR9CWzTsviXZYl16i4CtwYxkkHCr+MQpx
 iD8cELZYpv5cY/Pnpf3798OMUqod9gg=
X-Proofpoint-GUID: 7jOQcZHZQBbzVfrCJDfmOtykFpbQAEAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX6fA4pjhTIdgG
 p+fAiYORzcKryREJdg/bBcP9mkkNmEsbD0rCAh+7ruXoaANwSOzDIGguHjtI0SV+NP1CM0dcrRS
 jL+mO3tCjEQVrSK5sdo4c/AJWyeauiOmf4d5bAhTryODUA1fm7Hebqh7gTCIV4bDZDTuGDIxhxA
 NgOwiU6aGLcKmeLpvKet8XV299eikQJDIFSyTr/hmhFPtgSbrOC+PwdYRCG4KrYK0WcKAV3JHyp
 2jRBZs0dgpFfX3PA9ZTmvRZzlPSjPGYiSmEdcMHXWHOy3W5XYBmcbNBlqrpl8EXCUYm2NnpPZnz
 fJePclMCu2QydHnAe0QREwHFdiIfPLB+xGDXLHPE29wDTHmmmAGTjiJrVUhWvHr0BTBJZdVwRpi
 DbODN7/oPxcEiPlHx12Naw5l8lLUlv6pMaQdGpVUUX2Xme3jFwWSnAtWIe7LgCFxTa3Yq/laSTq
 ONdfpsGe/ucCbSrTc3w==
X-Proofpoint-ORIG-GUID: 7jOQcZHZQBbzVfrCJDfmOtykFpbQAEAs
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6afed013 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_HFaMYOssqv2UMXnlhEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190041


On Sat, 14 Nov 2026 01:18:41 -0500, Haipeng Lin wrote:
> Wakeup-capable GPIOs on SC8180X use the PDC as their parent interrupt
> chip. Like the SM8150, the PDC on SC8180X does not support dual-edge
> interrupts, so dual-edge GPIO interrupts only fire on a single edge
> unless emulated by the TLMM driver via wakeirq_dual_edge_errata.
> 
> On SC8180X boards with a gpio-keys lid switch (e.g., Lenovo Flex 5G,
> Surface Pro X) this causes the falling edge (lid close) to stop trig-
> gering interrupts after the first suspend/resume cycle, preventing the
> system from suspending again when the lid is closed.
> 
> [...]

Applied, thanks!

[1/1] pinctrl: qcom: sc8180x: Add missing dual edge GPIO IRQ errata flag
      https://git.kernel.org/brgl/c/a67b4f18ae1c0c8597e2e4804c6f5460450418e0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
