Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25D2FFDEA
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210102; cv=none; b=MqthXtgc0cpdXmzFufib65axNFYPR+hl1x+6s9lQx961yGcT3azpWURwZhFO5e0MeKVV4OE+RrEfo30MbqSLlLiFnuZLpKxapsYx05t7UZjq7DakfO7y3sa4wXmNgPXKWBhM6DnTBvzUulgZGpGaq0JUkhZ59+RE4CcNPcbFzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210102; c=relaxed/simple;
	bh=FPrJmaVk4ArO2ZSSTjX7T4UsBhOE004iI3cCowCeRO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsWkeRz0LsoWwUrgyabE/4JP6vnLAcuZXgJ6/B7VlSk98bKAKrw8f5tX9b9lkqEYZYzPHwugy4xDkEQDzcGQWbd/Hn8TenClhthLeNbpCcIbyw85Fs8iK60DBn8vibMvQ34ikJn3hIcwfGiwrNCnc+Tp9b7bQld2jQKYFm+Fwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cl+JlB1t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y1hrs5Ot; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cl+JlB1t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y1hrs5Ot"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJjdL3988145
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	76hpgwGdW+31xLTgUxLwgEBfOk+woSeDm8vuSdihgRM=; b=Cl+JlB1tXCEX/+pO
	Hv3FdXEOaS3PBOK5riAJMxzEJB1GKjBlgoZuEI/2/lYxt/dBNprzU5XuHJKrFfEq
	tYez/jKV/G3Z0afV2fgCKkr9wF2X14swBON7EbyglAYU3vBBf3L119GdGczGanLJ
	wEc5q3/ApKvQgLW7PuLqIFyGxLM/evvvdXEhXpe/DkXT+tCUlohV4MmhK2l56waY
	9GWKUPWZlzayS8nL/D4QNNhZ2SLfxa+tSc9F5teYV3rPWE10MpkDORgw/uhQW15R
	6PmpgaeYpzjoblgCn2vgUqFjt35Mqfbr1ql+pQ1b+WXgmua8AeUEybY1SEugx5m6
	u7ZCUw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pjhkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:55:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c2af04aeeso8712861cf.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784210099; x=1784814899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76hpgwGdW+31xLTgUxLwgEBfOk+woSeDm8vuSdihgRM=;
        b=Y1hrs5OtL0M6FxUuduHlZktEcnaLJH/Cwesw0u/G6n4oHxJ2Vc+BKHihIEmBIVBjl2
         vytxwQ+ANVTsFEMBBnFcDLIPkxZIjZPOUIXyLidipAEiRE5wmxYPaFGjfHnhOVEuVYgH
         P/8bs6peZeoQrNVD8qa0xkRroZtf9IALJ3GJ7RwMcU7zbLY3/01Tra368uyPrvS5NYLJ
         uIj33FHZIw99JiR/eZVRHSMnrJaGP+Sy2G7rOc00OEvtyOqQnyiT9yeEDdeuVhh66FBN
         4OAAZCWstBg2/N9aWIHUPGZP5LN3lc5gRpGI2oYxdOuG7JsiCswKLaeEyGAzbLmqG1SU
         48IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784210099; x=1784814899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76hpgwGdW+31xLTgUxLwgEBfOk+woSeDm8vuSdihgRM=;
        b=G09t1jMXaVzk/V6PcINq6HcIIzczLgn7gkXIhL/yG+LvVmhD+qIhG0t7g1wpa1sH16
         PEWK4/17AZOyur/ZwDrhJTj1b/IA88s60bvbEvpTDEnks/7nErH1A3XFjsr5InKE6GLa
         GdGOL+HuvD9fqTkut/prUYrF+QMr+NeK1jL5lked3i2zbmhX0v/xF8RtyPKrOWgePe3w
         I9Wgfl13TILjPk/JtxWAW4TdwJKBibZsrCdS60JaGxqHGAPZIrAtKqtFysBpGHNgJEiy
         rbQwv5dR18FlvH2KY8bjB7ngnUC6MHo0RUL7ip8ZqjOQw+dwnhazDZEPluKJsziTkVsg
         rafA==
X-Forwarded-Encrypted: i=1; AHgh+RrWGV7tEIa8ld+xPF5qnc8IL0yhUFc4MI8i3Pl+BgMv45Sfd1TpXUHTHouQGieCxFlRZ6HH9kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHjIutoVQtFDtf5EMLavDvazwLJuMuiblXSUcUyxYj+ZuAU7C
	GP20zCiFUtGA0b2F0Uzo5wPQqdX39eUFX20/KJb+qTx2fEmTKUhhR2YxnBwZ/noy6//nihk7Kn8
	SJU+TLZnoE7meBlQ2M37A0z2BDe3ZIi3P1TtEY6BGuGiUMh2ee2LCMKyRYlw=
X-Gm-Gg: AfdE7ckpEA5vYVWvz+t51a1Neyx8O2IytMbGz5mD4gM3Cg9bbrd2LuBYgJxw4N2s2V6
	FcGXNCljtI6MoWx2BJxqozAkxyL/IGr+LNFBKk2gVo8qBlDiwYNMlyV45trrn7VmChwjhpIqcR9
	v7gwKO7S7GnoCojtklj2uJpHHTJg7wxLgk+InhRxdd1b0WYb+/04kr8YqTPiJN1ZfUKyIlAfaEA
	Sifo/K02TDqkh9exNdGztO1y63pXDtR5iADIFAHgbrEauYl2Xw6kTvEClcvaVlP1ZsFGLcKMOH4
	D0/v+nnortyMyQYQSasho4Kl7CWw2gwycz2/5rnZmfGAvcM6741c9rTo+/vUKVygnzHptFWqKe8
	U9WXe9PlrzpPL7FlhyFSBgZlIpg==
X-Received: by 2002:ac8:578d:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51fc1293148mr26127561cf.27.1784210099164;
        Thu, 16 Jul 2026 06:54:59 -0700 (PDT)
X-Received: by 2002:ac8:578d:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51fc1293148mr26127271cf.27.1784210098741;
        Thu, 16 Jul 2026 06:54:58 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:76f:d108:485:5b34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm52817615e9.6.2026.07.16.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:54:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: brgl@kernel.org, ian.ray@gehealthcare.com,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
Date: Thu, 16 Jul 2026 15:54:54 +0200
Message-ID: <178421009045.21701.2719688493306554868.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709045116.2304246-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20260709045116.2304246-1-mark.tomlinson@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mNHD87xhO03F6vv8lJosvdRHvjrD0UmU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MyBTYWx0ZWRfXxvUd9w1lnhmx
 KAzZ+bcM98ZylinZ59v0vXj5pwi0VTw392l3te4S7K8A0mf1xd7nwXDAxiW3TnetnUSTQ/+WDVc
 ulW9CPS69XrKEznOJ3mQNO2HrSsT2C0=
X-Proofpoint-GUID: mNHD87xhO03F6vv8lJosvdRHvjrD0UmU
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58e2b4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VvGnlNf22ANbwrc5_V4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MyBTYWx0ZWRfX9bVry0736L4h
 Vusp7jOXPzqB3bqcFu1FJVAH+GlozEk57FORu7aZKx9t+4EGut+1k1VRjznDI8PSjetw0PD8/7o
 MFadYh2LS/y10riisTnwWh0z9qeMcUh/xKQGbmdg4lWOKCC1nnVR7JqHlzOTzwHBZc6Us+ilxje
 9dCcJkejueV6IC7P0v9ei5CIHvaD3INh+Eci/2wve187JdeoF8fzo8Bz5xxnHAiLis1hoXqq1cu
 J26XW9rFBMYjkpqTgCXgs06ayr56sYkoxgNMlVHmLzWwoRb17MuHsFQpVFB8uJQ78iKMF5OwNwl
 9SuQri44ggCvzsDJBDBnw1sZN/TUDkaX5X6t9+QS1RtygR0FmyHFKoCzwxV73doCPV45ogu0BPT
 h5ppYoXuuCUH5y5PdWwknBeI9uXrc0p+Np9mwoA47CZKkh36Ps+fzlIRG/XtsTosfNMTatI/YVk
 l3avmwb9kN5pYCG8L+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160143


On Thu, 09 Jul 2026 16:51:16 +1200, Mark Tomlinson wrote:
> Locking is disabled in the regmap config as this driver uses its own
> lock. This means that all calls to regmap functions (read or write) must
> hold the i2c_lock. The function pca953x_irq_bus_sync_unlock() did not do
> this, and it was therefore possible that multiple threads could cause an
> incorrect register to be read/written.
> 
> A previous patch partly fixed this, but only protected the write to the
> interrupt mask register, and not the read from the direction register.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
      https://git.kernel.org/brgl/c/9dc325327babe7f159e84cbe9380a45342da0585

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
