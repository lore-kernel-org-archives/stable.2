Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC53D75C4
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408827; cv=pass; b=Qlyry/LiEBijXwhqpIAaTs5dIhmW+2CponvRc2n1kTY07q8cKGzC7RIWmU6qm0O/7yzZ4fAMkHUEQBA9dqlsJ6g4dQmgGUKSgCPII2yTQyiWB25CxWMwTa6n2RGgTkLb2ZMAnIZfd4ituRsXaE8hixMoX8YICjPNT9EG7GNWb+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408827; c=relaxed/simple;
	bh=D5i59ny8Jjqz/d4TnC8e+9Pgsp/T/5exBPsqV2oj2ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqu/WHOrikqyTUOrG1lywle602FshcTBSnrebZ7wYzLKUzdRPMljvPStWmK0rbi5S8gU8XVEDDX4s1bKMfr2hcVOUSvtoLGloUwku2ZD/QmOEmiuXBH2gjhTwnjWOcMixvD8LEV2dhIoO2aixKa2WzMI8IySD+/HYL7Umelgkdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzHSTr9T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Th76OclR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzHSTr9T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Th76OclR"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2KSl288140
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D5i59ny8Jjqz/d4TnC8e+9Pg
	sp/T/5exBPsqV2oj2ZY=; b=BzHSTr9TB9qAI5/3R6EoiTO8Qlg0B0vpYUn5SKTW
	KjTmKQ50DPQgPO+njeJO5kK5JfVR6f8Ks4U8aqxGvoROWPH2biPRhhG7OJfln+R6
	HBq3dX7keS6xPRt3y0fGOlmbTlo1Wdk8SQTVINe4DDUphYntItddf85AwekC91na
	Mzuk5zZi0lWnT1rQAobomy3VpOtXvrby7WVST+8v77SMXauY3/mDB8BbsH+dscJT
	krpJ5NejWp44MpDhhpDPT2Y49FUa/Sd7fNrQCWkinRYsGJPMj7Uy+cSmvhJZnaG0
	aZdOzqc2unFFGyz1hLCU6YzvdLBgvTxVVcc1u7/6FqfiUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3v38d3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:53:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e7ee64b25so298407985a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785408825; cv=none;
        d=google.com; s=arc-20260327;
        b=IrWn9hiCU1RwWozc/KeiGaLXkycIIYGinC8xB3h1zz78yBsZj7JZypBiDQgoYsJNKa
         v8W7cxPfq11uGtfa1m88i50/fRZOnQ/x9IRqI/2/b1METzoqc0JzA9t3hGYKgvyR/fVH
         kkKYu7aTtLPrZ79B/jGW0K9M58OVJIJmMqQF8L+6OKjjlriUxSv2yIbC/fo3TrJVh5HD
         azjqiyI04gR9lrQeLYsbE15Cuc+3Vsso93XjSBEFkF85shn+TzGO8zreMjf5kFd0s5Qr
         AvRyNOaIiiZ6FVAdWpnFftCbInz5LGYbvgGY2+m1Z1GSiccTYGOoyAOfiH1/nLZuOwxc
         kjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D5i59ny8Jjqz/d4TnC8e+9Pgsp/T/5exBPsqV2oj2ZY=;
        fh=wQDkrENK9b6ETWRJCBJSRYi6FpNCUGekKI5T2+K8DSw=;
        b=WC3BNZnaTUveYZYfOh5ys45N43hAfbhIx1xs4oV2GdHJoDhR+DZS+AcuCIwjfsvTZs
         7vOV1dONhOpxHF8A+racCYDZC5Cl5WVaB8YIDQSPcr/8Q+iUmXRX0p9meRhN7WNrgfGe
         9XvDUQbdIVi8dlI1JCU5EFmfXhqoZ1MiZ+G0HWaeec25tpVMxhQ+EIbkLYvGZLqAfO7G
         9+9+WNT8CX6MHF9QoV4vtDHGoIPWd7i5l4KzuElU9WtrVMDgnw8kUQZgcIFhN8jfzzLp
         wRT5mXU8qYFi8aYJVZ99o3/OhyZZfTxEay7UNUtvnd3fXJaXvbSd4ikkMYL4yUD2vujO
         QCTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785408824; x=1786013624; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D5i59ny8Jjqz/d4TnC8e+9Pgsp/T/5exBPsqV2oj2ZY=;
        b=Th76OclRQjk63bvdg4p23WPeMXbNAr7YAUYo0HN7AU6iZswUKEM0OhDSANtax9mtjW
         sQhq+YsS4Ua+bXbb4zOrSI1opN6O9BnPS8L7Wg345eNwmit0k9cxcLky8ito4M3T/NUz
         JrZnaAaqLjkSxl+F4N3V0pr5ksCMnUXsi+kO/VivQSBVtOR3sR+Gw48WNpSjr2uyNgpc
         UvBAPIs6Rq8ViD/5NLAUbJl6T9NkWOS4R0/L9ndALWlKXGeUZ0l6TTGcF8d9AyaK76Yb
         ABH8iv0o4w7eTWggF216P2wTh9PtnKW/ciNY90Lg3/0/M0+7KNqpTA/uH2aaoTWVykHD
         89Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785408824; x=1786013624;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D5i59ny8Jjqz/d4TnC8e+9Pgsp/T/5exBPsqV2oj2ZY=;
        b=OHuQRr6vMuvSr9ZyAlwwKYitHNxrQgHmlG8hhJzLOFKJxaw7oBMvrsOW/USreWRu1E
         uTgGbUSOEOox+A64SQZZLpyO2VvzLrlqBJS1bZi6ixV4328RhKUa9IYyCpej7qgbN1Iu
         YAVFaAkdIhSIVpNxQr2+QIQhe3iMrNEyFiE7U8sxWyRZmHGZ5V+GHHs1dQ7Kklv8GebH
         LpaGjdpbGCGM2+/MQoTFEheX1fvHxgvMOl6gaxWYh9KqK/aBrpnLmTodKhtIkiem7xSF
         OEpjqXYWn/GvVkpP+hYXasPVlAq1oKnBgIhokZ1Yr/WWrhQnylvVoc5O5jx2904MxSYN
         x9dg==
X-Gm-Message-State: AOJu0YyzDEkla0+O1ZL+wYklv5zZMfIwXHx0+MqDW6B7DfXxQ6GVW2/4
	scaDEyo5ZysRI3Rh/hCt0ifHydmJ0nzMlGhNpgpRUjXJWwAp7ByuUkCbylDjS/9S7UgwPKmRrUF
	Ld1MXgH8XChM4WZC82IwL/3nu6927nJQBehC9lIMc2r8P3kBZRaHes8JI/QSa8k//eVoufsw6qx
	vXbrxMFAOGu7XauhGPWCcB+TjG+TbtCfiiw2OwhwbBsryn
X-Gm-Gg: AR+sD11L2K7wREmAotU/gwWMvOJk6ce/yEML7mlAiETPyCiVXriNmEBEXkIy9/j2a24
	j7/bF2Rq0i/k09Ma1VjgqP0djjiJHIuDyK7cBOH/6sHC/9YYMjFKvtB84QrX3tYwnrdI/Opl9QB
	e77FisGECGIaHGHJOa5vD57WRBn8DKoVg8YqpW3vadTSppUCq411jtfPbnhQ==
X-Received: by 2002:a05:620a:a18f:10b0:933:a21:5f07 with SMTP id af79cd13be357-9348614e80dmr130942085a.49.1785408824631;
        Thu, 30 Jul 2026 03:53:44 -0700 (PDT)
X-Received: by 2002:a05:620a:a18f:10b0:933:a21:5f07 with SMTP id
 af79cd13be357-9348614e80dmr130940485a.49.1785408824086; Thu, 30 Jul 2026
 03:53:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729150958.3889964-1-youssef.abdulrahman@oss.qualcomm.com> <20260729223316.stable-0014@kernel.org>
In-Reply-To: <20260729223316.stable-0014@kernel.org>
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 11:53:32 +0100
X-Gm-Features: AUfX_mzSGfAUDNdhpHfcTRjl8y_dIy1NDKpDZ5F5Qi2dbl0_PjQ-5aGojBq-yDw
Message-ID: <CANyhwx0BOQ1CEj2BpCN9MtUM-kbg-c2zDNzkvY1gntBBMHdwhg@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] net: qrtr: ns: Raise node count limit to 512
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: K3ovrNVUZAK_1h_JpLQ1CWsBs-dO6_1_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MSBTYWx0ZWRfX+Kd+PEKIxIgu
 F0ONMRuNmYFK+b4DFk2H9xCbLylnSYA/cqVDhF1wGFDAxm8fb2IXh0u8EmK14rw7pj5T2YbSNWv
 nwe/Kqx1ISmBZFIbQjlUF3b4RB6nn/I=
X-Authority-Analysis: v=2.4 cv=bZlbluPB c=1 sm=1 tr=0 ts=6a6b2d39 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=RsryKrR201jtlDbRoOkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MSBTYWx0ZWRfX8TMSuLKiqB/C
 hUOvPDS6pngGOhHWeYjC+wNkp2YzTWDrT79aUOqLS6HBnqngIt5wIPxFkDy/i8RXdPFF+15pAlP
 9iha2kkMzqEISjcvb9WcAskJLfjsNyADZIaffNX70OmLmx5U5l3NxmzDH52Qp2vjUdE2jLSbAtZ
 nyGl/Y5bTSKfk7lMocqxZ+uwywBwgklsJWC1TI95/4YKDw7KXXjVU40P5g422JRbWGc/ZoYLMEj
 FhK6aQMHTbg/VHVwNKfPx+SOGYLCtdRThmJv73TtKr3l+AURMBebgu46z570FPj8TCGTeZpn700
 AhazsHnKtR19rYnU22MtY4G3agPp8NDpw0aVvAMUl2oZAY0oQQkZSgPbMBBKU8IplNXk2lbTqCt
 klMgYVpspPNBpPeI9TRzcmsT4Q3PNsVT71vPbpUJUfuw7x46U0ZWEsR4MqyJc7n4A+4i3IyaC6I
 MvHZC2V/MineRJKVWGA==
X-Proofpoint-GUID: K3ovrNVUZAK_1h_JpLQ1CWsBs-dO6_1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300081

Hi Sasha,

> Could you send a single v2 for 6.1, 5.15 and 5.10 that matches upstream
> exactly and adds the missing node_count-- in ctrl_cmd_bye()?

Will do. Thanks :)

- Youssef
