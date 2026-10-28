Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179859;
	b=CeiYAsSF5YObitxerMR0DZ6jGiqS4NPt7IG4oGi81Sztwfd6HdDWrUYOh8EYSKIpi19a
	 ZX0rsh+3/EMsjOFwf0Dyw7uG1Fp3X3ZKtWBl5j4K9yY1syHNBtU4KxEJPE81pVZFpj78L
	 Jr3cT1JbmAI5IssRxtjfXto8EFxVGUmo4NBZAZtHbhnoMkEocBDBAJeJZnDhwyGF31nLC
	 xItvQZcDQ+Oh8qq4A4z1MMd1Pxd3zNOTdwU3XAOPyN024Wjk0F5cpMqZsgtghGbhyHTpW
	 shkuYWxizUyx79aZbdr2kdiERlzbqh4tLuW5VjCrDbCYsxU8jW5+ChTAABrZMrShCvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179859;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=H9WSVSzQM3gxoBgbW5KOP7ComFae578ztsE1a3gy6yg=;
	b=4GitvfXSrDsIqC1UlZWld4vovO3jInOPiIwI2pddk2VoJIA1oY18rYI60gpvNJ5YRtUT
	 M7yA1+NbSelgAaUesnicgEu+COaailSQC2kwkZIt17S4OABXKsIKHhYxt1bJwlWnmkDoX
	 GzKZZ9ps3mmzupHBKEsT8FMrTAcm1Vh+vbBXOL92eih5FnZlBgsxrmmn3zmwiF8hvvvC5
	 jcobzEw7T8JoOUtBFPGIx9f/mSb42JNI7TPzzvOm7wSF9U1SYbSu7mzCGpeD6OFqsWEYK
	 7IA/2QpIHKguKPQDMYtVdUb4+zeo9KGFxqTjCIpW6IesJ4G8HY5nY00D9ErzQJO1MCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VJjoPXSN;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H6heotuH;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67460A2602
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF67460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VJjoPXSN;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H6heotuH
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K7Ou066114
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H9WSVSzQM3gxoBgbW5KOP7ComFae578ztsE1a3gy6yg=; b=VJjoPXSN9HaORW0B
	rdlqrIiuJJPmf+hFREacFInMjBSuffov0c+nPWdcB6GxYX9lzR0vMreJY31GbWm3
	TjgcDz9pCJKT9Wwcog9BhQL+9XV1fPyULxOYARs+hAbH01l7Nbb7yetYf186N3e6
	oSCWXrmjD5x0gl4Fhj286Rqpzu1t76Pl/Zsq+YGu83gpr0GqnYMxhY66OVJ5/wAL
	mQvb5c78yoyjhJA4B++5G8iP+wePlRuXFyGvh4MpGPNa2xE/ikt2YKIK1z/kfUlI
	YSVd3DFtOGN1BeQlbo1Ojz0cHEm9L8/JqqRxdxlIB5G88QeAGoAvJATC42dTyXJr
	4SvpbA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g3epf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:30:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f20addba1so113351885a.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793179852; x=1793784652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9WSVSzQM3gxoBgbW5KOP7ComFae578ztsE1a3gy6yg=;
        b=H6heotuHGmwDbcJzpMgWwPXA9IW4DrSCQQb51DfZM2nM9fP4xs00c5D25Rh9Cp0uyd
         6vET29ZkXhZEG3zt1GdDjNcKX75t9YuS/fw1YW509ir8N95qVZF2sEiXUGTEK6eYY/KN
         iasadasbBnjSHc+Yg86gQeu9RQqczVcBDFROr5JuTiBgj3sGSZl8U9VGeka/Dmxi4pUZ
         eH53U7aA64eMUp7wLe2pOZ6wS1gytu1kMdA/cPUQZ3oYGar5f5VDAiDpIUkg/1uiXFRI
         249zLJsX3AWDBws+IpCwQ7jDHZVQRxFK8sZLgsbKtDLQ1FUxHzpWS9UYtD8AqGRaH63H
         Fh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179852; x=1793784652;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9WSVSzQM3gxoBgbW5KOP7ComFae578ztsE1a3gy6yg=;
        b=E+1J1wLzcn0+vfAXejwnSlssLYxyDbQQnFZhbgW3h7fWNpCcgZPLfTBW7Kz6bbAQNg
         eAXU6bJba+1s6LWwwq188SV9zM2n8KqSmYtYQcem+H70zsWk92hTMKdKddkVnd0XpKHm
         Ltu0LQR/L+CHuzox0YA5/M4AgQVUTI+NTXlkPKZ3IEOVRyWkcqsinFjG55XSZZ91xhVy
         ZRFJEJ6SRC3oNbXYh2FaOiE4Yk3Cswk8LDYLkoOgPRHHv2OMqI1TX/6EzjltnAJRjFN8
         xIFlBRoWvhqLTXu08DuBb/rifTbSuj5vYJUVK20UudzMQf5/wtUgsz/P/mOniJSiJZI5
         Wf9A==
X-Forwarded-Encrypted: i=1; AKwUvBx0HCipf1BEyrv2eVpc9xVmQ/dGk543yZeyQ2z8rnafLkAxjdI9v1tbQFhqK5FFFiW1SLcMHz4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs5xUlbOFBsq4RNyP7IgiZ87TXM/zb7T7Oh/S2KfarXSzjOxSr
	ZN3PXm/8gKslA/emdl9yIl1RKJcrhwZ2tGYtV1oQmeyVQvI72KJrojqdV5tZow4zgUik2wH/Etj
	5xdrpXnNH+Xq02yiysIST+O9X721dDEZBWn9Xzrn7R2s2ymcjixbVZOEjS+0=
X-Gm-Gg: AYBFou0wKBBMeFYiQSV5ssXGo93m0/lpHpgcKNFj8duVXCMWJT2ciM7eHi+CoWEiVpx
	RzQRJVACzL8ztP/fVXEzh3TYOMZnBvFSp5LUSLgKLAFOt/iPC0uvfvcees6e/tu+C9c9dZtryNL
	z+ksWAVNdnQn6MWjvnQ6O+2Bzz1vO6PzgrX5PjVkG5lUz8Fo6aWifE2MITjMePKypub/G6plzgl
	7d61Y3UAcFDwHdBOs/LLQSBp8WPlBO3DzwslpTs8znl9l4/WnmYGz2oxExrWBdUdJMpz+EA3Ksr
	hH3+9omLcPkXQxSV6fATCKZGkNWnSZHbmnfm695SJrkfJfb0FlH4pHSPTFoR/uYXtTDoTXo0XTT
	igKDl+2VDe3IkUtjLzjXoSALmsI7yUmwL3U41af9E5ju8h784C+2DEzXrIQNvSxr4HK+Ab1bKEu
	LI
X-Received: by 2002:a05:620a:1d03:b0:943:faab:aabe with SMTP id af79cd13be357-94408d43a71mr195778385a.62.1793179851965;
        Wed, 28 Oct 2026 02:30:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1d03:b0:943:faab:aabe with SMTP id af79cd13be357-94408d43a71mr195774285a.62.1793179851499;
        Wed, 28 Oct 2026 02:30:51 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94e4be4b2sm21772175e9.2.2026.10.28.02.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:30:50 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Jianqun Xu <jay.xu@rock-chips.com>,
        Cunhao Lu <1579567540@qq.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: rockchip: Fix debounce arithmetic for GPIO v2
Date: Wed, 28 Oct 2026 10:30:47 +0100
Message-ID: <179317955938.10111.11780019305484547923.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023-fix-rockchip-gpio-v2-debounce-v1-1-f1141bd5b58f@qq.com>
References: <20261023-fix-rockchip-gpio-v2-debounce-v1-1-f1141bd5b58f@qq.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfX7qwFC8qr7Eha
 R8IidjnCLpaJfzh5QGbTUZSZNRsgyZOxyrZeOsrAoAFkyvQSpKfKRinJPE1GkhAU83MxVFCDx3A
 CChYzFAY7QSd0nP8jzwy+mIy+raS4tnlXpWX1NcSx8/4lzB6hEYRP4Ys5aNdVXCnococA0RxF/t
 pjCKvuEqr4uGLEp15y8BlTglBIYO7dwgbJLNERYptwRKda5IJbxcvTsu7qINe5nJIlEckdf/+Q8
 Pn7djTqaIctzTYMLp8srpv9/Kn+AnGY0GQtBYH701U331LqgdeX5cOnJQwHZmNqLZ9sgKfL8vPQ
 f4Oa3OVtlQWImT1361+OknwknpQ/oGHqaQTFItgE/6nIkxliW62fNI5s7ai+69IobTGSEF7dpv5
 E3QCrLXikeCQWj1Fmn7qaFwXVP99/9myQ7uvYdbOS7qwdKdy2A45Q7q2I6BFYT59O+k2QBosV6i
 Qm98fXR6s46ejH08VgQ==
X-Proofpoint-GUID: GnWF2LOPBJoz-io45iJDCggDRcuc4X_z
X-Proofpoint-ORIG-GUID: GnWF2LOPBJoz-io45iJDCggDRcuc4X_z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfX7OMwjUDHkRtm
 rg7mKtX3N/ZMlG8HDvUobc8p4NH/kGePUroQTseoIMeSM13EVpgaxoGw1U/0ZnqImby1T6+y3s2
 bfY37NKzo4mU5pE3+7O8inzZHoMfdy8=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae1c0cc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=G63kk6RMYl0S_NIbZfoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280037


On Fri, 23 Oct 2026 16:21:05 +0800, Cunhao Lu wrote:
> The debounce interval calculations use unsigned long operands. On 32-bit
> systems, the numerator used to calculate the maximum interval overflows
> before division, while multiplying the requested interval by the clock
> rate overflows before it is assigned to a u64. A zero debounce clock rate
> also causes division by zero.
> 
> Use 64-bit arithmetic for both calculations and reject a zero clock rate
> before division.
> 
> [...]

Applied, thanks!

[1/1] gpio: rockchip: Fix debounce arithmetic for GPIO v2
      https://git.kernel.org/brgl/c/13467fd6998f5da4f5b4f172f1af3d9c48d5de8f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
