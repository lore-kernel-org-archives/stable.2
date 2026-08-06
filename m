Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FF37E5F1;
	Thu,  6 Aug 2026 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989845; cv=none; b=Rw3T3ZzClbNSrI48qI0VfHeNPH+cYVDfARfGn27rwn0gqd5J3dA4ek92uHZ3xypwawgmKy+BoRP+J2CMa7NrO50PjFVWwYTkcnquJHlFfhkLWfaebvxpZWw/V+lpiMp71UjwmgLnBM1Y0CYbb2pZEwskpf/yZnRIZWvJ40M5SYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989845; c=relaxed/simple;
	bh=UJNN0zMBMODzscybLgnfShli4inyPSqWKMxUBWBw/tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwRIZ8l0SU8Mq5LvkpwWHWJjgAI+deYc0hZB4R/cMmsJojGCnlBBYGywGLgiGGKsnSyoGFHUazKpkqPpbGsMVFdBEXi+FMMoYksCo0IKtJ66L8jkT52TtYKwU3pOx6Fqp4iuZ/u91ZX2eGs78cKtc2cmJ03FBwVjGLhBaT+6vFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cNBowQI6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cNBowQI6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NlhQx3403131;
	Thu, 6 Aug 2026 04:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sszeY5
	T8kdjTI3h5ZiATF3+wdFCDT7FEX/8SRrV9FDc=; b=cNBowQI6WUqhJJQ9Fs84Fy
	7ZuLl51EBO4dQIpmer+gKU4m6y+pa5FhQ712PTzsvUpaJIF795OOmG08p23/FbqF
	TDbS+02gAzbQRTP0atgT0R0DnXFkPa7ExZZQZz+EN+sU54FKN34jdaofEdOJr/5m
	oyhlS+KmFm1ueD2HBzygD0M4kJxEosNUFCbwJ5keqEk+ldf0MtIJDNtHRy8ba9UF
	scFRFXg2YqKMujMc+qSUoR22dbHPgfvpnMHSJnzWr3wEznW995JSxCjKIyiv5Xgq
	r1h0YhIWoNRkUVi9RLNNgNvpauRhhqzOngqpexFpu4pdxcNn2cRB4tuP9tVnxALQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqx70k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6764BI1v014627;
	Thu, 6 Aug 2026 04:16:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtysc5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764Gl5d48562628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1D7F20049;
	Thu,  6 Aug 2026 04:16:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326A920040;
	Thu,  6 Aug 2026 04:16:44 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:43 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn,
        chenhuacai@kernel.org, npiggin@gmail.com,
        sashiko-reviews@lists.linux.dev, seanjc@google.com,
        pbonzini@redhat.com, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
        fangying.tommy@bytedance.com, isyanfei.xu@gmail.com
Subject: Re: (subset) [v2 0/2] KVM: Validate irqchip index in routing entries
Date: Thu,  6 Aug 2026 09:46:43 +0530
Message-ID: <178598971883.942627.14864231076983027112.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9XIrn19liHt_Gp35TI6FU0lszKKCE0M-
X-Proofpoint-ORIG-GUID: ZrcnJp2922SmvrODV1LGkczb6OrRWGnT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX87taHarZcbbK
 qrDRHczbdO398Rb71hhfyEUYsWWE+Wmg7lcOU2RQw7gFL6oj1Seyx9KWKQpzqlcFU3GsPKBUEf6
 GrldeJGEPQPB+HkOW9rLreC6KaImCwk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a740ab3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=4sZtcsWrhcTQ-q4STQgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfX8/SwQGbft3ST
 v5BFqbRjmEOCDVCQOhxrCwJK+YMEQHJdc1NYx53TngRpMsAed09kCqyI4eLvg2zgb+pqqkVthQ4
 JDOxb/NC2yXu0QZHFcCnnXYMKqZchcYDyLVtRyPucY1jFwEdpKg0O2tAe/9tfboFbZqyxY5V5T/
 2240Wl0//jvzYLnMAbzIcCQItMC4XXJCBHF8XTi7J3V0kJ00/lHusCd0C6kIf4gwOWV8j0Q5VRq
 tdux4zoXsn+HhYk0CsB/dBwnZn1KndyLaANnKFHqBcbL8Q+P1LQzcwyhzIslOFFuanySdnvD+1g
 E+R1QqLWhiG42mb13lhLSEBJOEH3StemHUhegCXSpkVAxsoPZ+okI6j3RJgNcoT/hIXdN6onnBe
 dNAmUxRVMsQNHsEtknE3pAbY4g6d9hLJzvYESuDbZjP7qiQbb8SXDdts19J5TSXutHqnFdB4X31
 jk+dzPHLWXr+Y2aEMuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Sun, 31 May 2026 21:53:24 +0800, Yanfei Xu wrote:
> Validate irqchip indexes for LoongArch and PowerPC irq routing entries
> to reject out-of-range values before indexing the irqchip array.
> 
> v1->v2:
> - Split the patch into two by architecture (Sean)
> - Pick up Reviewed-by
> 
> [...]

Applied to powerpc/next.

[2/2] KVM: PPC: Validate irqchip index in MPIC routing
      https://git.kernel.org/powerpc/c/5458b50b5291390ce0af2872a1baa51cc58e8f08

cheers
