Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114344FECFB
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059360; cv=none; b=Q9T3q/uW0ctwdDr+xX3wPEZ7PKMil/1DAawcwXX/fWs+alQ078nhRTkuQSdn8WeEFO1GuLxdQ59IJz6MlHAADA72YzHQcpUJXDg+OiJ5alc6BLU1l3l7wMiEIUJ9I7JfIRilDuwZ7pPeON/r07r48di1bCj1xDW2Yobb0rUm2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059360; c=relaxed/simple;
	bh=shdhjPkvDR57kNHeQ4WOOkF93PcSzZ6NOlgi8C/r/gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzrfhhpDTGC2kPs06FlWaPYowgFibisXRpQX8KBgTTSa6SOfFa5rAVIcsYvlk0QtjJRqb9KULjagDGeO5EWqaDtyZmQ90O/8vabXJYNVL3dC8tkxgPExUBZK0RLFaFnMz1jIcNH4CD5//53tF0d1pbzdkzjfeR4tYmU/OzyPRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iSJ3TO7c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J8c6ZUBd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iSJ3TO7c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J8c6ZUBd"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jGDG4077443
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	shdhjPkvDR57kNHeQ4WOOkF93PcSzZ6NOlgi8C/r/gQ=; b=iSJ3TO7ckDsZiDha
	vTyozSoJSqmBjxWVultHkFGd8ojNNXSzxnN+tY6pEBDnWMWwiJ1A0YP2CgA4hcpo
	xeT1kAQU4wwKk3dyOvNN8I2U/VqYyY0ooEdJJ0oGstvIcruijG3B+r/HuciccY9v
	OLKDFocGjHXAderIRhlalYRIRJkxWCZ+wxekt4FhoTc/6+8aCXw4w3hPE1Izps0B
	fVdWILymgBZTuH9Up9dHLobMN1L1ja4ak1WKAY/dLSDPWSwzmnabCU6gZIuzeh0u
	MB18l7+H7ZTABqnXAl71uO4FFZQe/mC/3cijRwlhTsSjsS/TQff8A8hH0MugTNM4
	AiKJSA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc0657-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:15:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-917a04d1cb2so13287416d6.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 03:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792059356; x=1792664156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shdhjPkvDR57kNHeQ4WOOkF93PcSzZ6NOlgi8C/r/gQ=;
        b=J8c6ZUBd/N2XEsv8lya2PICzxrNVoImFYNqerGKiIlYugQbVpq2KOZk8pvRCxjskjp
         lKpTJwZkz0ZMS3ge3Og0Tb0X+QULs3bxrAlvWOApvvwY2PBl6rK/Yhz/NVqes6rslY70
         PxMA29ZpGs5eFTq7Fa4nxKMTCEjxTBp2nrcsmMDh6GgixInQxYziz39R6Bag4UJqHLJ6
         qfh2nk2fu0jOvxjDR66Uuos6Hw4OFFJotQ30Y0sJabHlJ12ugQRpVDMpI+1O556al2R1
         PJrN/wjNlLdapHi8fDJcRKGhGD8HdNmBeVTiYqbBpIrq1QVe+UduJyi3T2Tj2IVF2AxN
         4rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792059356; x=1792664156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shdhjPkvDR57kNHeQ4WOOkF93PcSzZ6NOlgi8C/r/gQ=;
        b=v/ifS5Yp3ZCAlZTmJCaGHfWjxdxuyM8l3Qu83JbaM2bZ2dXs3J2etZ0i7yvR1JB/yz
         FWIooB2WYhICZ46VnP3EEc2q8QBVw8xkdtIBmDlFEn90QsC1GfVwf7mejX09s07fLENb
         c3SlL2iDBNSrnVHPEfnQVX0BWiQvNTEQwhi5LDUVUzMCiFRKeHzweSI3tL0jFCQa+hpc
         CG5B90HKpUV0PA3pH7IMAzyHAr1EqX2awpjqq+SH3ocNsecwqtxPOUmQBQoa42SQNxGa
         BbdqHUDVpJaG4GI9wPgSu93LmyG54AL0AHbL06ZM1IuqjdIzCDEnlRWttSx6NhhZvCzH
         KjKw==
X-Forwarded-Encrypted: i=1; AKwUvBwy8/lkR/hJpYutjbSnjZAvYbavHJPoMyS/eeEr5AXwx4mUVYkDQqGGdgCcSSp278ALsbE5rUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKG+LaNxHhHUy/bOl4VOP8ifrZGYP0liJn7Y/OHzPkJS2bVwDR
	NJBrOUxBpxRhcov+uxY2HtTs9pP5trMFS6qlv14FC0yiNA3yAeYK9PhbpQuHarOuFSwkMnj2Kir
	nGV3e2eQErykkzViOlA2oIlVI61waFDfItF9Tl65/EYaN41ASs4qQ0tIFWnU=
X-Gm-Gg: AYBFou3tDXs8PZ9937A2iA+UNoKJmKEmwMjYsjBf9ABQD97jUZSUXg1onXaYBL1TdUf
	pKoZlFw5vvw5ZwhZgW/S0Jglwx1ITWFiMCcchyXMjrJaaJ9TSQBSfGICh57zEimx7Vw8gyCE2iM
	lRrA7avNSMMt4g77MJyRK2FMnI4OxMOpW/7KWe/JYVDURDhsesd5YcWFexufdHhp7YUZUJ7A4Gz
	iI6HJt14jALPRDlcO+zTjuDQ8xkVFyvawuMG/UbjYWYE0aL5lMVNTbFIIL/WtIZuxcgQAfulM+y
	TsPh29R4qF6hxfE4z+1F8zZ7IdzdZR9TRIxMKzoK+T2H+7HL7YnbQzKP0ersv4OkFHzKwVKWh/I
	7ID6vcirRGad5JertYcPPQQ==
X-Received: by 2002:a05:620a:27d6:b0:92e:6485:f640 with SMTP id af79cd13be357-93ebd224118mr3300567185a.4.1792059355970;
        Thu, 15 Oct 2026 03:15:55 -0700 (PDT)
X-Received: by 2002:a05:620a:27d6:b0:92e:6485:f640 with SMTP id af79cd13be357-93ebd224118mr3300565185a.4.1792059355485;
        Thu, 15 Oct 2026 03:15:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed6beaf65sm106831266b.3.2026.10.15.03.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 03:15:54 -0700 (PDT)
Message-ID: <e147f162-a52f-461e-9c70-4947019ca4ab@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:15:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] remoteproc: qcom: pas: Don't fail attach if the
 remote has crashed
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20261015013827.716465-1-shengchao.guo@oss.qualcomm.com>
 <20261015013827.716465-3-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015013827.716465-3-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad0a7dd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FBzCk_X8rep-KjbTXLsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX/MfSh9qLgGLE
 62p7tqaDPMfgmmjp/rmEsaPC8ONr14QduRTDSXjzW8YStGsv5+vVUh+DYgrXGJorT1H1917Ypof
 qH4WfnoA8yixJ3qutPlwFbnyI74+bJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX8QaVBa9lerO8
 xYJKjslO27QVkMklhJdx3wvdeUm0OSZyKtE+TEN+vmFAAzcLhVxf1vtnDZsYfWO8pvcSqMT88Tz
 g9f8EOVcB/ipenpaGWZiaiOvsszopl7xGWwEVgqPqVBI7X6bZIFHsiHjJzSAuRFahONelsk7iXm
 63J8k3QF3qybupETlrsMEgkFBuzKwjhPGR30xnJRR/JzlbWJgFfG8kJZwle4CPoEdZs1l3W5zMs
 Or0OZrMzIhrpTa2iz/mcUFTQrgGzCFXOsmoxa0UgLO7TiLIQDi+HlKWNpyk+gUc3feyuEXCVHOK
 zxge2YgHfrXljzjop6zvZlAQbVWjO/pcsOOLS+iRCpm0RgYYpBotz3Cyp1qZ70zTPa3qLsW+YU+
 Ooi7R9oXHAqO77JQBnkS09uGaL4c85iPmwWfCkTXz0FWckLYLBicdXyJcXb4Z2iZiT3F/gnNGL4
 YpVcJdNfTYnBFriiazQ==
X-Proofpoint-ORIG-GUID: Qu6dBLnhFIjCNyby9Agb4L-puhTmoxY9
X-Proofpoint-GUID: Qu6dBLnhFIjCNyby9Agb4L-puhTmoxY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150040

On 10/15/26 3:38 AM, Shawn Guo wrote:
> When qcom_pas_attach() finds the fatal SMP2P bit already set, it reports
> a crash and then fails the attach. The core unwinds the attach while the
> crash work is queued: rproc_boot() drops the power refcount back to 0,
> and __rproc_attach()/rproc_attach() unprepare the subdevices, clean up
> the resource table and disable the IOMMU. Once rproc_boot() releases
> rproc->lock, the crash handler finds the rproc still RPROC_DETACHED,
> marks it RPROC_CRASHED and runs rproc_boot_recovery() on top of that
> torn-down state:

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
