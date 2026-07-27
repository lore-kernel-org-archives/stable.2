Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E740B397
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157697; cv=none; b=EYG4s4Is/6jqaIzEBqTV0fyPJaWnqwVYf2Bt+326+pdTVe6SahaTz44f9Dz5YbUcE/T2cerIuTa8Jck03f77TzeguW1Cdk3JR8a3dqy1l7ksugda8fkXDFQKSvw4T/tpzvMrEOStpMuHSwnHL5Uzvpme1/GBkKeG2hhVVLYFpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157697; c=relaxed/simple;
	bh=HYLFS+OFcWFTtSFm1PiU4CCDIq1dnlVTeFE2rXyTcVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlxLCv+6g8MrgZm0i59eIlq4m+D+aD0rGiD/spArU29hRohcfBxm0WRHc9fDmtAXiJH11qLOCFmqri8dMp699G7AJhoXG413j93inB97ugGOHFOe7IAh2ycjwFq8iNVMcKQEEIlfO5S5g1hAZNUsK3huadN63RarymfnEmMYQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZW+gRPaN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eDfOj6Ik; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZW+gRPaN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eDfOj6Ik"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RALucm3355435
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LZHWggkPMw97tiUjUmvN6ppmZKNPFHubbsI0aW0BRH0=; b=ZW+gRPaNKY/yucJS
	oJd/kSuFbPVjfpEj8uMQSMeAxIlBsxYYC8FJKKcmKeJ/AXu60CBCOoHcxbX45Rzj
	LwUXf+AjR5YS61fmWC4o4H0Cvd5GhNpZ4UE3wihFmNFAvZkN/j14yam9Eu27t2cY
	6F+AbrB+iXOxNRAjlkurLNyz6PCGkSisttOwPznaxyCfc9uL2NB4pofg3xfyjKmj
	VR3QXFQ626o5cBR08gb5BpnXd27j4qhMcPJOB5cdVWpaTpAYTA+GrmYMBDlMDVdg
	EeLkZuaiVOXgDucY12jlfbiRp86QZMywuMNZNXunX/4fyOnzQd/IOShdHr1X+TxI
	lCWewg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbrtpc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:08:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-522de3c645dso56026541cf.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785157694; x=1785762494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZHWggkPMw97tiUjUmvN6ppmZKNPFHubbsI0aW0BRH0=;
        b=eDfOj6Ikz6QVCi/UrQWTug9VJl0dLoj3MQi0fxbhQmX/3J1y44pOFQoK8NE37RSMAy
         8q4vmIXxhHsJ9XnN/VPoaRJqTrR+vUx8sLoR1Tk7ZPI4L8cPXr7ssEXDysA1Quoi9G7B
         kxdvNkZd4vMxWDUckaHMFrOLGJgh9bghtQP+nZ4gKEjEO2k07HQczH4lcNAYDkXic6HA
         wIkvU0cQ0N/tlEbx3Bviy/0LOJvqyAMhvsAIQEbrBl13Hv+vVSkgu+8YJ5mrvBsHymDs
         fj//z2PL3R4Te01DVN51n/hEj2t9WgbSwoMaGpKZ4NRcY+t0QawD40qV5sr/EvkRDmn/
         1Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157694; x=1785762494;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZHWggkPMw97tiUjUmvN6ppmZKNPFHubbsI0aW0BRH0=;
        b=Kuzwf8DbjxNxG2qmzPP883AkTxgqNOvDbQXQt5FbGcYbChYoBDYVCZ0qT+AEyEXedX
         pqjLwWDgnwEB7FDvjlgrll8agFJwvHDnSBKIc0wOV38/UGE/E3GKFwlgnsW0YyuFV1VU
         MmiZkXIosXGQAdNMmGkBmal8zDRLUr5J8nf6RA6PFlDh3vyTlTLbwVpLYT01sAn9M60l
         QBaorJjBp5ZuQl/fgiJeBXSTsCJPZy03ZeAOUhx4ktDXcPzMC0dReXPdOwje+qjVdvYb
         7lsNDPm6ziXyH2OiwhYIxVNSbqgxiFZ2xErz6gD0sDKOBgNQxE3OeJUgKgpR1+Sv5rgS
         fWbA==
X-Forwarded-Encrypted: i=1; AHgh+Rry/Rc/+LxfIkJ2XnVDBDtSj217mlyk0MdXdBvv7/am6pvZ03/HgbRxTlGpDxYU/yRgcwOnWOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0zFgpOKHJvpLxDYYO9Sj2nv0xQNb5tUvNuW74pWy+hf1OPgu
	ByiKoMH0tsqIel5gHWinj+JMokJOuOgEz+aSrjIss5pzXpbfKBSepBOvhAvEdWgQRB5lGYzLqLi
	sGCnHsQH39hLD3T52+jrClSWfpq9bVgqr/CJM2jDrI74wKAxiUFtNtDVXHt4=
X-Gm-Gg: AR+sD103LeKi/kSRT2xGgc8dik7x4pQIIvVxZMcFbLpiHsalZjJjv310PDRaQYzoo8s
	zBOFnvm1X/NubYVroFSIIJVM6EjC1EgVOjHOxgDMklQo7X3UkcahhrW6ClsXkwE9sQrv4YBR1ce
	LvNxLLvfKMLhK6pQiQiJUle9Thqab6hIvu2EPLMu12N/3fB8vggpknPmcdd7Zsy8fOri2QpCNWD
	C/l2AUZUqPCzrSRY+DO9YrMZ8vvLjnhCH6cD7ntIRzWvUxYmk1tcmfu93t07XbegWSmWe6G4iy9
	Ci+W2UAiofx1mr7fkbYZclQzQoVWWQFY5HoKam6qzuG4w4WiDl614oPIEaYOgb6UFk5qlUKjDBr
	eknJf1xeQpBXigOijOVppzHIQTAs=
X-Received: by 2002:ac8:570d:0:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-529a84bb82bmr84853451cf.22.1785157694232;
        Mon, 27 Jul 2026 06:08:14 -0700 (PDT)
X-Received: by 2002:ac8:570d:0:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-529a84bb82bmr84852721cf.22.1785157693717;
        Mon, 27 Jul 2026 06:08:13 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1449:2d40:6dd2:20d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm233635795e9.3.2026.07.27.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 06:08:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Junjie Cao <junjie.cao@intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: pch: use raw_spinlock_t for the register lock
Date: Mon, 27 Jul 2026 15:08:11 +0200
Message-ID: <178515768299.55050.11621180913720960066.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723014129.1129730-1-junjie.cao@intel.com>
References: <20260723014129.1129730-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XEvtsik3sm9HyNhAF2r7mpo72XkS0RCX
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a67583f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=K0IHqChC3_vQdOeRQfIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEyNyBTYWx0ZWRfXyUQ3Wvqi4i1N
 gsE7SGVVH02vPyBPhqbpRB4oHc1bhQWyXvPLFE7hDVRAReGn8irR9M9T+BLrmW45hxmPQfG88Hi
 SKDK0CCLmUVMuAHi8aYcn0JAGFqxhwM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEyNyBTYWx0ZWRfX7npbq4HNKOkt
 Br/olxFoHpXWV0ReK97kDJrUUKmoWvBR8WbpolAFIxTeQU/vyUFZDsUHAVG3H3KAGB0QA4smNc+
 eNTeUJXk05jVcBeTeGS0Q3WUvbdFhBFCQAfW7clYUydAi7Rn2lv55tTLpr5bsTuoqyj43UmoD/F
 yMMBr8DQ9h0YcOYGQPzJOaxTdE5L6MOlsxw3k2foYLYkLeCzPQkpP4iG9/W6D/mgVQ0Xi9BvyDs
 J1FvfXx7PULKmzZ1xP0v7rado5npk9NAoamBKXv3tYHBkgfvUczThyBt4N1GVnCaT/wnKiiIXbb
 uwloJKiEMU4Vh7Yu1YDxvPKv5zWhIpxhl3caiXlXdqt9u3YgXyE0HIBGow6MnKHobdKD6BeidDr
 0fA37yW62etchIQ9bBusHkuvWOJ25lL0PdZoeFxNLIEAeT9Gliny0B18Jis1apy4KTiUY0aRHbI
 AJu7DdzM4yYNOwbM5Ew==
X-Proofpoint-GUID: XEvtsik3sm9HyNhAF2r7mpo72XkS0RCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270127


On Thu, 23 Jul 2026 09:41:29 +0800, Junjie Cao wrote:
> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.
> That context is not sleepable, but on PREEMPT_RT a regular spinlock_t is
> an rtmutex-backed sleeping lock, so acquiring it there is invalid.
> 
> [...]

Applied, thanks!

[1/1] gpio: pch: use raw_spinlock_t for the register lock
      https://git.kernel.org/brgl/c/a02b8950d619123da64f69b70fe1dadef217dfe4

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
