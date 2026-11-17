Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904396;
	b=kLV+9OTYwF6QRcD5C0FblAPqQ9u7uoLr0L4XNKDa4IXyQdRbDht5sUCBVUQ08Rlz0HIt
	 Cjm9Cqlacw8of2J+YWq0Ji50RABSWTDt4jAH+HlGLk0Jfdwcd5MAank4e7HRzUvSmzfvI
	 6p2zibHjpoCbT59M8m6TB6TsrbD0oEwB4EREZxZlbEcAmzbtT/VDSLftdlvbWdTnG47dq
	 N8xavmnGVY7ySkaBSb957S/c72Vh+4FOGAi7vf+vIwmrwMZ5M0283ui7W47e94uZwsWfJ
	 JWxlYJkF8oBjAT+Fcvv2ZPCMo81oqq1rCeWVbFH2JzoY0IW++4z3QVzE7+xgr/oK8Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904396;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qTaPbmNErXBwiuOezragKKQVbgX59r+D/qqn57oH2Ak=;
	b=WqhoVF8rOuf4K/Qku3JMxuBVZbhRjCVSeo4gSi1+g1s8L6u1eym8o/QAunL/3rbyR9qs
	 VseRDchFhMp51j69Y1VSogTcFYLOEkICdDlihcPMzdccl2mCdiyZuTU5poPMoehQ2tGiO
	 DjdTG23ayscCo66IsMVS/MYvCtvdLJLGIu3Dw3USGKUwXJ6uEEXbHzlmhF/sxZ0wfM6Ux
	 r6qkd3aGXYu33BecM2sBIeMxteKJXP0GwoHNDitswwXhRJgAsRk2TDskfh4hwl2pex6rs
	 ZY7Y3Lk3JC7XR+SRdNM7DhARzT32y047EMxh2RmuNBiW8MHjuDaBWlZmfNBcYEsYQ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JlcKKq8s;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OMHntUea;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B18606A8A6
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1B18606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JlcKKq8s;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OMHntUea
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH8WDwQ3407575
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qTaPbmNErXBwiuOezragKKQVbgX59r+D/qqn57oH2Ak=; b=JlcKKq8sGs60RAQo
	yoWKJ/Mh7qfqqXU0Hw3Mersbr/hZLvG8eTW+duvHiA0cPb9qpcaPIt7dkPwLVqsN
	/lAMNtPd1RAIwDQalhBTEk3BefKtWfequ+oihB4lBXpK/MYFp3euoYQhNki1sulM
	JXb1OR/l86Jo/yozADRutrfStKrkdBy5ZZKfPFoTEJ8JT7UHsjjzIOIjs/+4MOmE
	psDApJkJMtjZE1SYWM1Ji96M/SPI9eGUMfOg9fS12auqD7U/AlbxfsDwakatC8w6
	Jg7Jtm0NUbhcvCs5HcQ8vTt8jh+ssuY7H77JLcLJRV35NDtQ/uIc42ldqHaER7PY
	Y6Vv7g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htj5k0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:33:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9495dd0f07eso758956685a.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794904392; x=1795509192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qTaPbmNErXBwiuOezragKKQVbgX59r+D/qqn57oH2Ak=;
        b=OMHntUeaNhpVYlWuzU5G2GuPCSHURdW/7DR8u2UUXC9VbUvu01Vd70ZVIvhizGWp+p
         Pd3Uikfvl6ITMkmxbCKHR/e63MMGjD43PjMqkC/BwgnmFeQApFxKoR9Bg4f4Jgo76r4s
         gRB/8JcCwbPwet4g/TcusqmnIivtRjLQk6/MQrxe0Ul+f/LyG9nIOQmp+O4z4It1CP2z
         yzbs6W/TguPZ0rNb3OQ009ViehRDylIpDj3NdKkTod+mPx8b8xllxe70FGFWttjAa3M/
         OGTXfB5qUj53UVOYWnp6w9J3mFMi+UfH5hPTKsGc35PJpspBiVuG0+4ExM97FAb2fLfv
         BEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904392; x=1795509192;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qTaPbmNErXBwiuOezragKKQVbgX59r+D/qqn57oH2Ak=;
        b=0TFalqzWuYLHY6sUVKFbDhYKeWB4aQNnb8im3VhQ9mt46jC6hL2nqC9WkNpZkUbOX9
         wegWqfCA9fBmM30NrB5xidHL6lu/e4UcR3KkdwaDiDnZjVz4N7TIZtOpouFxkG5dAA2U
         TWNsNd4+tQROGlUh2eQ6jJ/bwmIAncEcZbCH4EJ/l+bSKzTqyW0hEHakFBAMARKgMWUx
         DBApXLFdZ+9W6iKlCJbypgynKTrY97SI74eYe7TTDMx40BimP1pRHXxyn7FvTd0tpBTz
         aao2s8Y/ojWloQ22DEqa4BHRHeuGp0fA67sEnByhdAL6OymuDIqjNFlcbLxh0OwhMwy0
         8zzA==
X-Forwarded-Encrypted: i=1; AL+hErEw5jzTIr5rnFJh2qyiciTUurBMzjh4X/tRlB5EymROcdJXAM3EVkgHhkiAT+G1sgwD25aEwI4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vUXwVV5viexQOfTB8gFvV6TiwdQqMRB00dhPJ9Xej+c9JtIXP
	HQPwtH8xqn59rFBdh8+24WijvuIvhfj05CmLwrqUScQEOpNru3+DmaWkTRb3H75m2dxlUOav3V2
	GjphEiygr3/7K55Hnwbv+rxPrRrgA7hl8fS6m41es6BM0EKxV9NaKHFYVpR4=
X-Gm-Gg: AYBFou21jIfeqFM6mFhLI0oBlWxoFIZeA6BwtoAFVy5DdrFBnLkvm2zVcPMZTXXYrhk
	jcCUSjyrRetTnEM7zRpiyxwe2tV1DrAN/vf6B84Gpek0pmnGBEcjuArFMtuNmP1w1AHH+DaDzIn
	CAqqSUYhyfh1zDndcCDUx2zq4KY9tZzy6tHyJrezvp50pXVnBqf4VL5N6F+eJ2g4n2rLA57Y1LI
	5fsu1DDmYcYW9SZUL0eisOg3K1UUsx4xooTmiH/aOoZWKjfmPvoCnelZN8vxtMe8jq8cbV/SYU4
	ubw23fmrhp610x5UvRcCpYkQgBMNiH7Q3H0PCOC0TvRdUXLfao587az6vazMJ6QQkvOjvp8UuWX
	dtsHRvGLTgspRDFykbZwfM3RzH2tuyhoaU7LKPlg4hMgI/cN6qGAosKYq3AbjaLQi/D5T+Va0wT
	8=
X-Received: by 2002:a05:620a:4693:b0:949:6e15:e1db with SMTP id af79cd13be357-9498b875f48mr363268485a.73.1794904392266;
        Tue, 17 Nov 2026 00:33:12 -0800 (PST)
X-Received: by 2002:a05:620a:4693:b0:949:6e15:e1db with SMTP id af79cd13be357-9498b875f48mr363266385a.73.1794904391831;
        Tue, 17 Nov 2026 00:33:11 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571d7e87sm246783055e9.3.2026.11.17.00.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:33:10 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: keep the line state workqueue alive until device release
Date: Tue, 17 Nov 2026 09:33:08 +0100
Message-ID: <179490438637.15815.8754565205390800066.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110-gpio-line-state-wq-uaf-v2-1-ce6d8266656e@oss.qualcomm.com>
References: <20261110-gpio-line-state-wq-uaf-v2-1-ce6d8266656e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfX2j7aTS8LCHWq
 66UYd1thEUF3ucOns0+Q3KiBm69oCIGQ+3qOVS0PYn8AFRqrXsXOp75htA826O/m/GQqF96orGg
 F4bGWNHF2/zct0ibbnp3gRzqW4tCaEg=
X-Proofpoint-ORIG-GUID: 4tfnmt5Hg--0TLNz-KxhI9jECO5GYTul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMyBTYWx0ZWRfX0BrXSaaFJ5rv
 B0Fj1qpovraBMaO6UcWTRM1nogbAxp1SP+ons6KHkJcctUR3fciR4tSo6BVACTCDs9hCX945h1z
 /bF/twxv71w75vd9kFM+j/Dw++cHkWJyHr1695jNHzvqlXOgbJfOU/b8lnsbn7/x/i7ZGSrkDvO
 OyGkpaVce5KQnEFc+Wu6RKU8P02/KQ/TYMXYqlIIzHtKilRf16DKCbaTnh+xqcen4+t2wmxPBe8
 qm0X7DS/X/elEBqIYgnBYyb2RbgMclbHzLhy9ru7ktF0Yieacduo40kXuPExArB2wNs2c1OjSkp
 f6rWRYvKsYVpHyabbCRLsXQlNjf4htFb/2Q7b5XQVfikECFjEp/CyMa8PVE3HMMdJT/yVbKeK2T
 Vvu8wiJj+4X6+iPOYwVRnCd7nXa3aU+Skj7Ors0n/Z3tCcZ4vrX3UiCy3ss/L7U1s3OIssgNwYN
 eMx/VT5V47G2wlQhiiw==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afc1149 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IXciJTxnJKSDCwE9BYQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 4tfnmt5Hg--0TLNz-KxhI9jECO5GYTul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170033


On Tue, 10 Nov 2026 10:29:34 +0100, Bartosz Golaszewski wrote:
> gpiod_line_state_notify() races with a concurrent gpiochip_remove() which
> unconditionally destroys the line state workqueue causing
> a use-after-free situation where queue_work() can schedule a work on a
> freed workqueue.
> 
> Keep the line state workqueue alive until GPIO device release.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: keep the line state workqueue alive until device release
      https://git.kernel.org/brgl/c/2e002a1d05b1979006f3c46eb6cb5cc36e5630ac

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
