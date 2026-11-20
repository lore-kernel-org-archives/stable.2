Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178455;
	b=Q0qC1YW6BCs+FsCs+nqNgT3QP5njNxsrASOznu0BRBAeZTJSIfDOa6NaI3XyPKlIdhD2
	 LTdAOdm5u512NjvpGO8BEmwKoH3eM4KV8dWOs5pRA4X4puMKlKCtJQsz7mCuYE5hIR5v6
	 42ai30GDiQhRn8GP7PeKNtvom9IYRtaKal7fljcXBulUzGP/8ZHQKLwnJqE6YDMFMYPq/
	 M49sUY0ZL2AJGcH5UbRveB6Gpp5UqjomW3WXGFXlhf9fbDzkB7IHH5/WU6hsrF0j9Dxjd
	 unJ9BhTjynar8Q4XW00Y+xeKUFnLngfzEGM/DjL+MAcV3SvkWaeUy4XTjVoaBaVo8cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178455;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yjnNm8i9GLqLKpkwn2Wyin8sUF/yJTYucbRHBOaf4lg=;
	b=P16qRoAqnbE74YMs015wQpfTwbdJotgdU8FEfpNDPTFQC2Ejpf4jHZ0FUus+n+s4A7pd
	 Wt1WOoeLz3NEb9RxIa+3alcksGrifH6yFEA1js3FY0gogXXWPjr29yGVc8VC9Psi0YVUP
	 ykjppwA4Fjepcsamxt3WnIpNj1PaGOE9Fn9xc/xPdPreuvZXw4O6aFg/8Ko7DJBUpR+SA
	 LFKxE7yYfuHUMk/ffyHIXLOt9TkkjMQNSDUlOJP8i2kneQ6WwMoqGFTEC2ibppY+ehI5u
	 /SQ9P9iEAG1pCrvInxA4NWWgMLOKm8udFdW9FN+AefxT/BjBTMhndSSJCbW5tsKPbOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3LWWR8c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cQOW1BeR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DAA606A338
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1DAA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3LWWR8c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cQOW1BeR
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKCKnDs1268981
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjnNm8i9GLqLKpkwn2Wyin8sUF/yJTYucbRHBOaf4lg=; b=F3LWWR8cu3PlTHc7
	BfuLKFWULnraZ+j+RnzaIxbEMXWguU6M5pZ7p6Gujwg2lMz4cQJ+iPRfILoBaZ14
	F8Ps89wxZC3877ad5we5IR1CqLG5u+ofVvh8JaJKCsyKrAPQo1VEdDO72eZODq7A
	IRqRtNI+d+w6M/tY8RjgBSgUTGFIrfFqpJg54XQmL9VVL1wekFgdY4rQgtBZp9x5
	akB53RPNEb+4uyMubB7e2H+SyveVewXkd2KeHG+YhCQlwt4o3F4rklG3QQ9+ylhk
	dZeM5u4EzgPfo0ua9ts95sF/KHN6vjFwMgI0mZj7ajzV0IUvDD+ytiyYWr8iC69V
	5QfGDw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fykq7x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:40:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-946038e22f5so200970085a.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178453; x=1795783253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yjnNm8i9GLqLKpkwn2Wyin8sUF/yJTYucbRHBOaf4lg=;
        b=cQOW1BeRVDBHZIZOq60fQfgl3aOx374Tb/gAZC4y7sOgA2q9R7RCGMJM6cE+UbHUPb
         5ylKMiP9g7JRcYlNqCGx8a5ev/+Ua0UMxRilI6nUJQAC8jtU2zB+3jIVvP3gd+VtPK7t
         y+bu47GYgy5Uarz/7sSDu7p0WM7StXj9CUQjHODDeBGqduBCIUqw897XoD3kyzOlsKqe
         s887tqfv/Oh4pB/INPSMOcMOg8Kc2DH+dp1vjgaADL7zK0INBsXPjhgRjTZnvkrMR7yY
         QkiXdi+wcU9k47jfS0DSlNTiMPv+7G7iLQaaKdegvR8lcntF4kmC7avsY0tH5oDeC6Kd
         QOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178453; x=1795783253;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjnNm8i9GLqLKpkwn2Wyin8sUF/yJTYucbRHBOaf4lg=;
        b=BG+hPDenUYdJuU1X4ZNDkbrrC6EPHoFzLaCqNmyDaAm8CAvk03CKgtQbBEF7Rc0B4o
         IsfrQt0moBwWuNB3GAk0IPtP6WE0OrY29YgaK5Z2m0ApL08zKQCV89pdFraX1d2Ez3/1
         2GamUMfRlvSYKJJqLRD9KNR4c0WHkWe1FUgkEgJh1ML9e9ZmHXpl6tTre9abAA8mBUYX
         LHXVsT8fyVl6NiB8jormvTIGaSVwRjWH6MGQroquNV1tPtUXzfxCQmoQ9SrqAyO7HIRc
         D/+RvpB1v1UwDbTeXIQHJ/F4H2whRnWqFvhGYQmw8lSDAAm6UWC9FsViHAMShLXpglGZ
         LojA==
X-Forwarded-Encrypted: i=1; AL+hErF7DyY1fTNGX+Dil2r9q3TAcPPqQhz1jEFjNwpzkiWR0y93mFKSlIkqWsxjH9BTgItpoH73dNo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xppMPurpNUX2M7qFOhhncXnv5DiJQhI80kWMGsjsewNl4Vlc6
	s4IcTFgKu1E6+FeoagBqh416Buco3YbTPz0Gcm+NRnT1MEsB7/BpJKqRahYTzpZbTbFkQ3ZCcAu
	NwLdCStAuBlyKK/fuNPSR9GsbmzFkgIzHVttro8oYet347Y9KQaNiJmHTZz8=
X-Gm-Gg: AYBFou00RU5m4aeA9zzwfdp1NHSTxGzX4KnKmzoOm68VPDuKyGeJvEz9qhW5PHCIXuh
	h/zN0xYzNvggrhQA9mTxJv+sCwEo3ldwu01/FTwqK5xIG8YbpFPivcPngaC/3aumoN6qmhimTWT
	68jWKmzJkt0UPjLQ3sy3zm6Z2JSgmnus6plhx7Am7eos3EM7dyPUoGLYMuwRMg+Pnz4RLy8bXfE
	y17RjyR0lbOwe3d+yUX/r5aIMQvM/bLZgiaH2zi1e4Q+8qwBXLsNKcVLn+qQB8CCfFzIFrBHz5q
	VY194ReeUM56225Xn3CwVXQwAPVaqZS56sykIMubqR7AwKSr4SM7Ydv57OPGpIw2QUeJJT0oIZ5
	yJ78qPh8w8Fw4GOr4Cm/TvSBu77htWcm0AXEbkAVs/H+d2BQm+HK25sHo8hqwardZ0/mpY6BLpP
	I=
X-Received: by 2002:a05:620a:444f:b0:947:8344:17a7 with SMTP id af79cd13be357-949ba827c5fmr440600885a.11.1795178453118;
        Fri, 20 Nov 2026 04:40:53 -0800 (PST)
X-Received: by 2002:a05:620a:444f:b0:947:8344:17a7 with SMTP id af79cd13be357-949ba827c5fmr440596985a.11.1795178452661;
        Fri, 20 Nov 2026 04:40:52 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm4234481f8f.35.2026.11.20.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:40:51 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: don't cache new config until we know it's applied
Date: Fri, 20 Nov 2026 13:40:47 +0100
Message-ID: <179517844380.14049.7516898628067992811.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110-qcom-spmi-gpio-cache-sync-v1-1-190440d0ef3e@oss.qualcomm.com>
References: <20261110-qcom-spmi-gpio-cache-sync-v1-1-190440d0ef3e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX0XjYb1TwAU4w
 pOCED3DgvoZB+xofGBpgjXChOHJ41SthI1fnbouu/abvpQJSDE9y4c6sciVCTYxk7qoTHplU4nc
 FTUCO66p7I4suXiXC/gvPk2w9UY4KOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX/V9LgmUkz+j9
 G5RwQ7i0iPZHZW1WNzoFLlIEw8t05U1ny566FAmcS37cVLxM+TjFFw3801a3zetixo8mb2wmkmT
 NBJikebhbTTjYYilXf5//aRFnk26qYYKMglJAxIMxzT+LoCKRglvvUJ+c6VZHeF5RHbFrgSUsty
 sIHcVqr6qododsBxKiRUXq5dqChBw5pX/1T5Vbz/vdUR4sgKwvR0Zd/eL7rYalDRsOr8D2I8Hu+
 cW3NCnDYp/uY7MsC6S5JDxGPjnut/QthGKZyLJARLZ9Xe7/tGHManYDyCeZgmZZup1wo1pm787Q
 eb1MBcPORvm1XaTh1XfQk3QvEFfjWA3iY4KUBWTGqzap5QZTZIXjywzOpw/+i9oXPu0w7NwEePV
 aZ5rtBFktRRUJSAECfYQnLgUDibrbl9+FBHa1nQUDYrUyUyuJQqhwDARjeN7ulwtz2xsoZ4ZQmu
 GbtFK/edqBU3OVXO9gQ==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6b003fd5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HdM17cJtqKwICtWzaswA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 4z-lDR1TO3l3_ARzQPv1IepEufHHkCwV
X-Proofpoint-GUID: 4z-lDR1TO3l3_ARzQPv1IepEufHHkCwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200050


On Tue, 10 Nov 2026 16:14:19 +0100, Bartosz Golaszewski wrote:
> pmic_gpio_config_set() modifies the in-memory settings cache before
> performing any register writes. If any of the calls to pmic_gpio_write()
> fails, the modifications are never reverted and the real state diverges
> from what linux stores in memory.
> 
> Work on a local copy of the relevant pad and only modify the cache after
> all writes succeeded.
> 
> [...]

Applied, thanks!

[1/1] pinctrl: qcom: spmi-gpio: don't cache new config until we know it's applied
      https://git.kernel.org/brgl/c/21d7ff7d6531b3420727539f04470ddae499592b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
