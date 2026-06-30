Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613443C06F
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831143; cv=none; b=dFjuyW0ZuNKsxRZVrHAcreJi6cS5aVAwipWTv5dSRmdZQsCW1OubIZMjtoo7B/0qa3CV9lmPyATbJbJ6+3zzmalPoJifMOECURMb+2bfqbVZnRjuziKjEFFFZCE14bMQoMlBtFOqYH4eGrpunbFUKyQaUm7qcgeKGIZ7Sicgjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831143; c=relaxed/simple;
	bh=G4mAqjeW0Dw8GshNscbJq+bhUDzpZFvHqndA/HuJECo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUFmE7f8dO7469i5/jIO2E2iFmfm7ehIDXi+qp3zQKBDqK2ij81VGPOKrYDZRQkVWMGQDBkRrDPauV8f6mCcN+X5KlC7LvJYWlJWM9DgeTR646KLJ0A6OcQNmgfCDjX3sl/VHPoDf19q53BN81sH8SAjgU3araaGKEx/1TNR7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SF0ifqqp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=baQ5unVy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SF0ifqqp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="baQ5unVy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDKQU2214590
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	voVL29loeKaAD2u6PAs1O9nFDwmcBaWGfJBn2Pq+Dx4=; b=SF0ifqqpwr6EsuGf
	XdHyTgrTPint3gmAHlIX69MM0pVKjBcBpV8UKVKJTaHLABVahL6rAlM/iSRXFBH0
	F/HNcWzjNZvzgQi660avYNU7JR+4ZJSZxzEvNDgMDS2jrmLw1OOlbq0qpzlj4/QF
	qA+Tl9Qyd8QvYgjM69kCeRsEcIX5uiXQfM0F5l2rkTAujmOXAIiXHsZL8iEu+fV8
	ZyQJxE8OKJHqMMReJRMnry1fHcAylHgq29hXgfdSag5UP4sU1vv6QQQdB36bGyRu
	1Q2y2ieUtuiBaaJum9Oeft0omwhLPQJzuOdONiLR07fKamAgy9jEY4zyfRIalsqE
	GhEFkg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5txpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:52:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92b4b575561so186890685a.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782831139; x=1783435939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voVL29loeKaAD2u6PAs1O9nFDwmcBaWGfJBn2Pq+Dx4=;
        b=baQ5unVydVpsUTTSFlQIrj1ptdsmJDIArJP4Vsax6KMJn73Q/wM27V7847ZmxearSj
         XUJNl6prmtvrikIhxPLIPKHghkfhdNYqJX6jIfhjXaAx0cAxuvj0SPQVEYESiAs/+MZ2
         lehqVfmcUH6w9mPnGktWNhZToY01pP3BKmkF8qSw2LySzUmQKIgwtGCT7RMF22h4SZzq
         pSoxSoLEXCeb7mIVGfNZcu+2vcZExJTcAAbdPXpjuCcuCTd0WeEaZE/MYhrPeeNvW4FV
         zLs5oTlGiPAqNeHubojJp8DZ7kATB8xAfynxlDZ/HvP0tELr13aW04Tk3BYdUGIRtbGi
         AKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831139; x=1783435939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voVL29loeKaAD2u6PAs1O9nFDwmcBaWGfJBn2Pq+Dx4=;
        b=O4ndklNx9ui3cKMBAvw5arByxyP8Feywz2v0B7oBLw2JlzquAR2fB5w+3vjdUYcYk+
         HmOfE88i+65PMowTxjueNOkLwPRbEAGiDZ2GERPN1xzx9AmVyWk+YJOBWWqsoOgaCwS4
         +exMUtgGIxtKGQJEugnXgovHZhI6DxmmAEUaEsiveixSba2HCMRXcOibIAJEYVTwKXAr
         gokukHE8uhpHL5520BU0gjcLh14xk1bvCfilz4pnE9bmmvS6T11O0rA3dBSGi0FNtJFn
         dvURSG9lm0+lQ1ABN9btZzz++QHxPUhxtirZlgT+kBuI+Yx+eE8R+7SYSfl7ZjKVSoKU
         zdpA==
X-Forwarded-Encrypted: i=1; AFNElJ8ClKDy/kn7ufqoexcn1SH5gCWZ+CGZIVPummdrwcp0UqtBdTHCyd5zrA/ZPl01UwyeS5QnUWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxehwDjkXba5t58FfKE/K0Vivu0YiWjAKs5aIXwSoVgGjnaxbxT
	eGoV4qLrF8GhALHsiwz/aGLJCL82fZOpfkLEq/2kVsbulwD6I6Debfbq8Ietye/ADtcC6NVpkvd
	1hHsuaxfqMLm5nb2kcp4BXgAeLjTBoFgDXBp+rgonpeeZw8OefupJgIJt2VE=
X-Gm-Gg: AfdE7cncjlFhKni0wQOin6KGolDZJ3ch8Bk2u0O7/a0jDpHov7TzO26BAUczjN1HD/X
	Vtwi8pWZrN9y7Q9JLj0bJrzx2bJ7PETnLs/M7JeaszqPka12bUgiZpfwOZY4KgIA5GIMt4wA4wO
	pp9Q+He94Lz+fiUaG+83QtfBh4XBNiwPLj3HUjFbU/Eh5m/G95tVr/YqNstR1SRxWLRA67IeZ8N
	5fm7Pyax+Lt/nDG6XSTZO6+bFcV5vEEz5VViuhK3YMCYdfSq/nP3uyYPJ2PNLm81AzWwxY7m4lD
	eUxKhpJQ5rrKE89Ybgw5yUG3wQhjhsTXm64UmiZj9dv85TwTtnIW2Orwg5ek2u9zrSxwWg0mGir
	foe7G8jjM7c7DGnZ4f88GELcrLSXWbPq7S5NLRXM=
X-Received: by 2002:a05:620a:4149:b0:914:bfca:7d12 with SMTP id af79cd13be357-92e696afe48mr267965085a.5.1782831138792;
        Tue, 30 Jun 2026 07:52:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4149:b0:914:bfca:7d12 with SMTP id af79cd13be357-92e696afe48mr267946785a.5.1782831136817;
        Tue, 30 Jun 2026 07:52:16 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:a2d4:ac8b:bb21:2661])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bb1bcd1esm41326815e9.2.2026.06.30.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:52:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
Subject: Re: [PATCH v3] pinctrl: qcom: Unconditionally mark gpio as wakeup enable
Date: Tue, 30 Jun 2026 16:52:13 +0200
Message-ID: <178283113076.37349.4420730863475722984.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
References: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a43d823 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Kpg7wRNn3CZZSTE7MwYA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ZWFMFwRlyRXx7dsT7TUBWpe8BzuYvsbm
X-Proofpoint-ORIG-GUID: ZWFMFwRlyRXx7dsT7TUBWpe8BzuYvsbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX6cbaoGO5LI68
 xryOi9Z8f0NtmnB03GPgOdeeOTl9bJEA0/7QY2pahvaWZoaJ5179LrFEC/wbqCs0BzJTEGVRO29
 //B9iC1BFatQw1btUsQN3TRtXCtFDnFGv8XBTnBwspcS3jt5Tay1+gN01tlrGppMiUJloA8YF/r
 m2KAALA6IaF5VmKwApl+XzwMsdqhuw8RpG2z9RwyQBcpwEnCgJVEN2qhmHpse/jz503gah33eLu
 dU81hQDWcz8zAYsqjnO1V4AbFh+OSwj2MGCqHzBQe0M7Rl5M/oZ+dePvVuMLfteb4Kh3Y27WOgU
 0VdPT2D8k4+lbFbb67aGwzNP63gRQAzjubpD4ndq4YtJHM7h5pGmy8zTUvT/V5S+LOjB67as6GM
 97aR/7Ul702zxAmhZmmTtMmL86WYpf97kGD5jFgA86jSPpfp6LDefmBQOqWTwYnyN0wLYhqfzjQ
 U0MEKYh1yh/SSWTCSCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX0btyPO88YdOx
 hKT2LzrQJu5IqWHTZnSg49oCkFCFntdF2dk16FOfj80e949PPInrmYvvw07WMWliWMUNK2hmKmD
 JTOLZqYntexWUoQPGNS87Vk/V1TtL4I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139


On Tue, 16 Jun 2026 17:24:53 +0530, Sneh Mankad wrote:
> GPIO interrupts that are wakeup capable need to be forwarded to wakeup
> capable parent irqchip. This is done via writing to it's wakeup_enable bit.
> 
> Currently the bit is set only for PDC irqchip by checking skip_wake_irqs.
> skip_wake_irqs is set to differentiate between parent irqchips MPM and
> PDC. It is set when the parent irqchip is PDC to inform pinctrl about
> skipping the IRQ setting up at TLMM.
> 
> [...]

Applied, thanks!

[1/1] pinctrl: qcom: Unconditionally mark gpio as wakeup enable
      https://git.kernel.org/brgl/c/859e02a369ab328a77dfcabf59562100e55f9c5c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
