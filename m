Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478237CD20
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163168; cv=none; b=UP5dvaZn69du3X6jJUadsNG+v2D7Vh4VqsXu9zbeef9zIeR3jNjwBO9J70YZBNWL2y0ki5sXfK+vmZ4xFU8S/L3z+ovh6GDmw0MGOEowgegilOZ0gZ5YfzjX3SI6IqLc6UyD05/uiaXIXJHSyDoalaLjzRxlq5M9A/gFlxrwwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163168; c=relaxed/simple;
	bh=Zxy16+x799ihBBr6MJe6NLfjS8UfI3VxhcWSkMvxeyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu6qB9BNCizEJxDZDDRSogZyEbD38Fi5N4bsK6RLNSLyr/lOXM2jrlcLkVk50Q6ql/KZ3tlsgo0vlR7c/ugqR4JG5taDxGAbkv7w92iBUkhYY3DXfFP8WyTok3cy/QSV3H49tBwk9TmnMzLDJxI2E/quCV94zIIbkpsNtE3NZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cnxgraeP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbmXqwfQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnxgraeP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbmXqwfQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlaPg3905434
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aNiNwU2QrjjQdW9slXjUnT/0JOvoYgEc5+oULzxO43Q=; b=cnxgraePk3sg5GSX
	Fy/C6BKFOQKwhwxJC4foprG58vTDKyc9wfn2Y9MCjt27ia7i6Ks1UCMmb9xdZAfS
	TUFMilyElQQ4nI7UygXGsk8EMO/0nQSiooHhKMJww1JnmQC8QIvVr7F8v2YtCFnC
	V3SaMlMnE4FC0VlsPbKsz92eEHnJX9Gv9Vgx8z+AYAL9FZUExb4vOGhQplJMTNKp
	Mdno9Tu63Vd9XvffFKdtqGCW1p3hZWBexODpxKYIY3/rxmekEyfVMh3bxmXGG25Y
	KZCOfEetABf2Wk5aNHCzoFRvtx+kC9Tvup0A1d5yWA8jgFDCOhche4OJuj+YSZoY
	436Omw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4uks4u8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 14:39:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c20762d21so30213931cf.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785163165; x=1785767965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNiNwU2QrjjQdW9slXjUnT/0JOvoYgEc5+oULzxO43Q=;
        b=IbmXqwfQYs8fbu+s7NaIwns76EqxbIYIOrizOCQS2i58/tvE9S6YUWjb3Db4r8spV3
         YW5togUKNIgBB2zuT1Q1OyIFIvsTUSsjWFTbvugQz+gBVq/8BmD/VNS+Bflv1knCiuOb
         eLCt9c73+S00lS/G4J0nZdyPig58Y77g4jd1GCWJZkcZcHl60T0jMOdecz/qOVPPLSyd
         eIxPpOKUNpck9/vEwxpyxrs3pQQW6YesmsjvHZGlXaTKDYPKRo+LAPAA0Yq51k4QTf5z
         46R2qsu6gX8My24LR4QzjYdZTqZU+CawpWzV56EHl8fF5CC3HUALi6cyZfz5anJLWVaA
         eqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785163165; x=1785767965;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aNiNwU2QrjjQdW9slXjUnT/0JOvoYgEc5+oULzxO43Q=;
        b=QA5/qoqZCcWMPcw/qwztST5Tb3NFPk7wtcaBoT3ScdDHZ0sgzuWojysYzv0UGiFHrS
         hIgbC54rDDkzhfgh74jp5pU1TJQ1fug5NSk97n674QnJcAN5bRqj1uT2bNZMWE77qoaL
         SIYm0u2nHjTAtNuelZosqsR4Ilyy3GNwjHcRqOrQVcOn7Q3z4tkQ3L9liRZJE1ScLCHU
         g4qQPCA58YtW130QLiUIRkyQxtZjHTZKNhM/6Euu6jG+AXoQMMuN8vBxI/YyHnQeYhF5
         ioLywnV72mdNmw4vglWo0QXFcw/VGTEScxUH3OuTJ0L87s7dwXBl+keG5KBREF5lEXkN
         NhNA==
X-Forwarded-Encrypted: i=1; AHgh+RrY1Sgqmy1GtiTXc7s5xKWmvWa3RPGFlCaFeEuHliYtSJ7o7XIvmwyS2cUvynTNuaWviFaWeYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0P8V2V7Yq0DMFvNU3oK1cxlIrxO5jzVMw5O/UN2wMassU9QiX
	3TdmpvJxaBWQsLPG/7ZnRdcPQvwhHQ8rMnJxuWqcLkfvlDmN3VLNuOhDtFD2w71d+O8+e+sOGLC
	gbOC3OWLtG15xRmikL3ZcIZ58NPoqOsUGYFtJvrt+W4NhLLgmWcSpJYyYW74=
X-Gm-Gg: AR+sD12J+ExKggCtth84wMrmxPjUqU0Br4XtKcC5BhGGakQ3Ow/1UZsuVV+TclJX9cN
	OH17iIGoGiTPvie00bP7wiqBUGTi9r6WdKnp/xCyxM8gaRO6v+W52KOV0S1mQ1iYfvTooj45W6h
	pOqzn8OMow+JdKDMhXuozR1kyuUNfZD1sl0rY/1AbzsYVW3syDkYXqht94NgVsumLlgXP38oOSk
	eGV1fLVAg6mpqntIELdtVkTOY+M3iNVSY3sBjc8Sx9TvXfjlQ2fl5lKg9FmRWJ8d7ATKCga98s4
	OzS4Z3ItdCgV1dML34+S3g4JFM9av96iSCqKDSbmR9rCQMdltJI6IobNuoh65tBgf0v6n/+Bfv2
	dadctre7cMAA/D15CcJihSY/q1NzEkQ/oYc8/8ZYZOCA0ag==
X-Received: by 2002:ac8:7d86:0:b0:51c:1811:6eaf with SMTP id d75a77b69052e-529a8732f6fmr90542281cf.65.1785163165413;
        Mon, 27 Jul 2026 07:39:25 -0700 (PDT)
X-Received: by 2002:ac8:7d86:0:b0:51c:1811:6eaf with SMTP id d75a77b69052e-529a8732f6fmr90541801cf.65.1785163164950;
        Mon, 27 Jul 2026 07:39:24 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm51480708f8f.35.2026.07.27.07.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:39:24 -0700 (PDT)
Message-ID: <3ce0266a-64b2-404c-a904-25b6991f380f@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 16:39:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/imx: Disable clock on runtime resume
 failure
To: Can Peng <pengcan@kylinos.cn>, rafael@kernel.org,
        daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, Frank.Li@nxp.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260722084909.463437-1-pengcan@kylinos.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260722084909.463437-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LwSeJcu31GWGFoX4IDF7CKEay8koBu20
X-Proofpoint-ORIG-GUID: LwSeJcu31GWGFoX4IDF7CKEay8koBu20
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfX+4b61fYbwN6C
 XXboNr6WJV3EECogM2EZHG1WZM8vk1omT/Yzpzq/Ywum4Kj00wPCydLJEicNt4gDaGmFjUJZ93G
 WysVuipqZ4dcYBmFWHjfOkMUyrhHHVQ=
X-Authority-Analysis: v=2.4 cv=PeHPQChd c=1 sm=1 tr=0 ts=6a676d9e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=mjVe68GCGcCyfEWORksA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfXyJSJApDmBn1d
 OcLBF6zW5y6F9GARsu1HoIa9fUOFPtX9gRkV1NyfTvSbAuBhiXfuekeRaAFMNghuCrwFhZFBbUO
 ONb2E11VMYVQv6V0JCzPkKwyMyrrS9vCQnyvfJY6gHVDsbXORJ0WlMXcR6W90w/80BKYLsP6kmc
 M3YeGAKe5+IYqgeRTJmYXb8Om5w7R635h9f7v+KBgeJziGBRDCs2iLpYjbK6R0lnptUflFSA1kh
 +UwubmSxa4j6vvTJ1g6CopmYpszrjdUYoGMxh+RvxUlez589UHWQHKCjphhIKVmWK5CGQhm1Rfl
 9pKMhEcVp3R8CvxNvoHahSV0tZPUMKv4M9kld2846RowkcBJ42DQM+sJ7EnZfX1GMPb8DMjQjqH
 TFj/JRnzpAUH8LB7Cbnf8UzvhnyktbJUu7mey169rCTqucg3+6j6t/NwDXqloMyEYzZIeD4ofQU
 vm6d/MQqsCBNPP1pTuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270138

On 7/22/26 10:49, Can Peng wrote:
> imx_thermal_runtime_resume() enables the thermal clock before
> powering up the sensor and enabling measurements.
> 
> If either regmap_write() fails, the function returns with the clock
> still enabled. This leaves the clock enable count unbalanced after a
> failed runtime resume.
> 
> Disable the clock on those failure paths before returning the error.
> 
> Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---

Applied, thanks
