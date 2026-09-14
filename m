Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833F383983
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411588; cv=none; b=awhYsRH+6AlzpBxphQ90EqrjaND7YuRJUM2oVN9CRBWA54Pd3YC4vQgE0Ap9PRkO0ID5ufcIQpdylldpAqO2poY7qOjB/8jIzemvS5s3bqAB33PinWbJAYK7WpEUQ611f1bIoeId5jZre1yvyHhko3KCPBu97PXxSCz5+7/4N+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411588; c=relaxed/simple;
	bh=/8g8dechR+/Vj9t/nQ46EGGHn4SiPMwOZ/GvTtA80Yc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lr7jW04uAF/LXEJw2IBnGSom+QmZn7enQw4ueIC4c/DgjLUBy0e2WcBqC9tjuQ1E2tWRxxXz67zqfF+j7EYMV8RsIPUJqJxbXnpvVvqnScN9LcS0ZO2T1VcsQ7W57SQPw7eBDtciJ4kHcTfqeHohF3r+WfzeBbGEvM4RKvpidNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxQz1vLc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ujsbd5zU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxQz1vLc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ujsbd5zU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EHYqMV1297380
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nfvq+5Yyj0sd0gHJP35ZxMIsGdDSYDtwVPF1iXJOIRY=; b=nxQz1vLcXvGcV5q2
	O0SsczMHIbYthUogD8pwdoQYjF60BfbYFqhah3UkEiBrLpK3fm6x7FqC+uTQXRJb
	RfbWLX0u4dTpgkElA1dbRPv+Cq0TuTdCa+cPW+TpaqdKStomNWT4PiGiBOXZcLow
	6wYJJyj8qC8JJxV/0NKgOgF5gEfiNIX4u5yvgS3SD76B4fu0Joa9uY3JCV6aAcLG
	65H5qftG2kzo7lIGY0AbefV++lBPQkiSOI0cIapcu2Zs+VlIuVGBEBwB453aNVzh
	NBPRKAc2XYwINQeVzKXiWeAjdD5aDiWhkuOszyJawgM8zLc+bSNQcWFQ5t/WEG9O
	/mPoeg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet08jt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:46:26 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso2824573a12.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789411586; x=1790016386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nfvq+5Yyj0sd0gHJP35ZxMIsGdDSYDtwVPF1iXJOIRY=;
        b=Ujsbd5zUo4RWJqWMwc8dVjaR8mIinGcmBHDFqHTWtixbpreI0qaVeQ908LUsgYQ3U8
         LNFVgYPsIAWX15d7pJeCJ8TVTcrdgeg5xZnuL6BU7o/ikPYU7Fy7lfrU9BghgsOiwCAl
         43QB2TuUqO4A88EVBuGG8CnpLa00ksaR4iasYKKJXlHmWT6CNmTvycRodEXiwdFIaVVr
         Fmo7zZdQtlJuaPCpTeQlZVMCQIi0nNbBtj08sfKqd7d5OrmE/ToAGQSJcF64eUYby2rZ
         jTv+COV4SGT074PWil8k3dWFZ97Ila7CC64oRqMMCG96aRUk4p+e1BFokqK3x5pAjubf
         yq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789411586; x=1790016386;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nfvq+5Yyj0sd0gHJP35ZxMIsGdDSYDtwVPF1iXJOIRY=;
        b=IqVvFF8u0YgII/Fd3d/HW6DtjHraWsvQqL+spQWBMETbhXiCkoYElWRl42Zq0FcRdu
         4piDDTuQVPf6eZhkXTedKaOTvFfI+ucpsCYhnTgnYhlgQFy0IJLCPkas6XD3ojv5LdMe
         wWrEfNSiK3sTbMk0B01VPNaGKYJ5vnoX0jsjNO73lgd8dyjXcEOeE5iDkBAaUJzk5f3t
         t6cDzhiBwvFOsMeHN6CU686bztFHRCWV0Tgz9QI9Gi/ro6HCC5Wnl+Ji7ABFJz85r0bb
         NUcZXIvqXQwO+shf7tc0xSlQ2Tt+zcGTLidHFIBQAo5nDB2e2vHttNhSWiP/e7GbEH00
         n+iQ==
X-Forwarded-Encrypted: i=1; AKwUvByAehkO2pd3jI5tYL3tlNaCeSnjGB2Rj/mE8tyIPIb3hmhiWxXdF0ZJMMXITHWpseaGh1X1qvA=@vger.kernel.org
X-Gm-Message-State: AFuF++lgE5zC3i9PVmASLWIyi3vOKpUqhSlMsm7YPMiy6K/N4iQdczSe
	gwhRs+0O6Eeim3RktmiCaRixtvsqAJUafDIAyUJJpisI6xI9Q+771sr10NJpddOOCj3r8M6JfnE
	BLKzFhqq0c8Hs975YGooxN4FC6JDChAanb2elqUhI0ZVA04Cdn7Ni1FRy6yE=
X-Gm-Gg: AYBFou1yB8wnrEZNzeHv1OM9rTXF6Ux0E6S4kEvYzCP24psh8aZKXc4BIlfSatoL1AD
	YJkEphrn7j/9hx/R9U5kQjQcjDpjEkQm2oxovhmD1q+9SlSryHFUhjYsq2nbNY5x4EUrbxrl/c7
	Tybh3Z+mIR8ym3QcnEpLxJbfuROAbdCxiRRrBniRanXwqUrdZ3MELJnFiuUrMl+cDuUJn47uOzT
	TmsfXETQ7290nAOtHqjvpPKBHAnTKotT+DtFSK3/VDUsUTMX8AywRRsd77c4i9hG8+B9ULUHpq/
	xEuEPeqTpeweMiMoWFh8fbEP2P3hqc+CsRwB3XWwy6vSVa5OOvZ+VpshYaE4xJYfpmXkaexXvYA
	WPG1KFVMGKUTJY6kwaCVteT7ODSPjIOuACAGh71Ity0pEsce6BAjq6qA=
X-Received: by 2002:a17:903:388d:b0:2dd:143:d5 with SMTP id d9443c01a7336-2dd6c75a396mr93751215ad.22.1789411585926;
        Mon, 14 Sep 2026 11:46:25 -0700 (PDT)
X-Received: by 2002:a17:903:388d:b0:2dd:143:d5 with SMTP id d9443c01a7336-2dd6c75a396mr93750535ad.22.1789411585532;
        Mon, 14 Sep 2026 11:46:25 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f06423sm32032524eec.20.2026.09.14.11.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:46:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, wcn36xx@lists.infradead.org,
        Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
In-Reply-To: <20260910020907.3353-1-fanwu01@zju.edu.cn>
References: <20260910020907.3353-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH] wifi: wcn36xx: Fix potential use-after-free in TX ack
 timer teardown
Message-Id: <178941158481.2896945.12592794463351144107.b4-ty@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 11:46:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI2NyBTYWx0ZWRfXy4RxVSMLyxBV
 fsMSe8nHXpRVoetB4xL5woiD8olatmWb2vthYFZOwwjV40SbYHzkvdGV7dsquvFmoDJ74IM+soo
 HF7kPTcrOp64jtNO6EaQC0rSuy53HcU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI2NyBTYWx0ZWRfXwSKX9fnofwET
 7l/6jD0ejmPYjctXi4Q4Oa5ZGMfnALlKAVyREnqE61fmiVzYsnW4CIsiKGsqOZYVXyanKHsxTzD
 DS6Xb6DMAkoQJQKHJJQfyHt4Lrc3a5J0/c07ZxhtkdOS1Ukj/FLkU49qLr5tDvSbT2XzErEbXWT
 8GIaNdMbns/vJ3nmEprAk8Sa9/LJG5La85xfMAXHRPlF58fxo6FkWqvpSOxYA2O0iQ9tqxGJieS
 7kKL9tioruKosfw3XLujEChGZy9pyISFRZguUDMK+VPXIzy9Rwe3L7TbhN1EEsBavoF6i4Zhj9p
 Kt5b0HrLVKrY+Ft/Ro9rXp7vbm/+yB4AbCD8cMPBTAq/WTR9Herzw4pEIkUug6pQUOSj5uhHlcW
 Wyb+rbVoVPjCzESfp89idm8ZFVRRiAhQK692RMIYE69ANF/rDqWVexGjpYNdNqbQ22Xj40JyLf6
 DgF6wDE12Gkxf71j2Ig==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa84102 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0lvdRgit-FxgUHpCPWcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: rJIkxllkaGkYCKkDSRzTh0Ph5wVu08oN
X-Proofpoint-ORIG-GUID: rJIkxllkaGkYCKkDSRzTh0Ph5wVu08oN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140267


On Thu, 10 Sep 2026 02:09:07 +0000, Fan Wu wrote:
> wcn36xx_dxe_deinit() tears down the TX ack timer with timer_delete(),
> which only dequeues the timer and does not wait for a callback that is
> already executing; the preceding free_irq() calls synchronize the
> interrupt handlers only. The callback, wcn36xx_dxe_tx_timer(), can
> therefore be running past the teardown and use the wcn freed along
> with the ieee80211_hw in wcn36xx_remove(): it takes wcn->dxe_lock,
> reads wcn->tx_ack_skb and passes wcn->hw to
> ieee80211_tx_status_irqsafe().
> 
> [...]

Applied, thanks!

[1/1] wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown
      commit: d9be5e75530772fc31637070d51e5717d6aeaa2a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

