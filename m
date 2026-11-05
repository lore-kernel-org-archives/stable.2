Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866960;
	b=iWHxFNePYeXLmbambnyaFDcvhxULBbAhT2FCCl/PSexC9wlGIO8DeXLqyQK6YzuP8vuk
	 WKT1jAJ1ECW9BdpNHUalNxlizDMH7eVexaiFfixfTRad2oQTW9Z2TlAY1hgpgPWZFBqbQ
	 dPd1ZwR5NrC9z5LYFepblvQp2CHHvUefMzxHX46X50bowrV90uiPn4xp3X/1pPydd8CQa
	 1viabacvQzGB4ovXaAekv2RPhJwugrDM/nZX4b8w2ZOn/c6AfTwRxlsG/ZUvyZkf55wdC
	 9oy8c5ElG+LB1wjcoVrBcEQ7knL0kW6Ie1kqkbEyCEOUXs8z7ia+Bc8PoqaN/B1zbaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866960;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
	b=KIhV14ye2OPASdLgk9kzm7g7xRBirg0wekm7Zi4m9nd2/bfg93anpZGJ2fnGGGPNupA5
	 dio9qoCu4eP9rajG7GF1ZiZCfoTSqQfKXt55aOw/vdBkTq9QmYw4CnPyDKw7VhaACYYZ7
	 2jRwuvp4PTym1iifjuDx1GJ64yS+6L7y25Eq53sHxMeTv57bLy+MAD1Wf43nNyO0si9UC
	 hLstp3agK+UQmLaNySicVu3CbIhqHo2lTX0B2ijpJpa48fF112gjdTIs48oDYCsnTlWpN
	 tvQ+IAo28xl9CPrQ2GHmGe83YG39v2L2BTkTEg3mAQwKInKQcH3py2FvOULoZLmo0eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=memcz5aT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YOJ7WMtd;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE592606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE592606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=memcz5aT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YOJ7WMtd
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UHfp4179364
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=; b=memcz5aTefo4KGOZ
	rgWnJ/uabi3neKbmngooBNvd7gHrIpsZOx1v8gPp01TSx/0fhIHBJqOv+lwgFfCG
	47mYl3Tw62xnSS9XD1oqDXhK5a/cCwCK/aVh3WfzN4HGy183y1iKNnw34xGH7CNM
	4w8Z96I4V1sjRr/VMEsm3PlWdHTFJ0E+2oc1RrYHWy+IF57bJtBK8XPAutXx1Gnr
	5SnOA9FmmYdNboeTIRW1b2MUIOABLurLebyBAgssvIq6xdd4XnkDpyqgfFtQCrlj
	MgZaKBrrCyBTdr6m9HNGLaIGAfiZOPg0BL/B22YQa/XLqzoZV5RttPlEF0V78/Wo
	+SaTBA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn4ms3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:22:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c83481504so3125676d6.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866958; x=1794471758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
        b=YOJ7WMtdQz0aIapT4F9RwpJ2i+ZE3XgX5li2D8OAA3ZdxMkOyrB23muMp/CaD6usN7
         fJP5JAMRjY0aFPc1hNf8n+yLXnPuEbHWd9meh9NQjFtJFw1wS+bK5ljm2OBd4xKND3zR
         uheh6pWUqEny6VHsU+U1Ye5NgpqgpGKRKgIvy1e0JMzA4cRH83XKidvXwWT4igX6QiRS
         BSwYIozmcmtbIVoaUNi0JIHwfr4NGdoYFYnPsdsNbGEhd8wqecVz5ORdfVCd0es0D0lO
         8HaLGcYOIgZIpuO6X3bxxs8QywZU5YItmgNUEUc7iaLP/JusFA1bdqLTE5/AGO9wfcEn
         /aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866958; x=1794471758;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ix1+20DyoRCGmBOgAiA9EOhmvPdqx6nMCYqJ+YFb1H4=;
        b=2ye5eqjOVmX+DucWW87vua1Dqg6XxNg3URQ7dRCnf/PzSuKaEdeclmFeitduo+BnYU
         6HPu8/6X9rioBIq84/xXD89o+009Celq3qq39DLHftcTyUcCoQrg8qk51zgyvnVjqXGy
         CrHxOGLlkHU8AoWrPPp2E5wbJVL5UTW02oh1isu9hjlQdU+xwaq1pm+/7Uydt/qrkUs8
         Op13dc3q0r0TWChXy2L5ovgrQTjdjcwGnTAnMqvW5UcCQlaOfEazVaIdXHGl4HCJB6uX
         ICumOyy8gkbDH8fsyPBdwvw5uL/yje0EVmdGff72NqzXp0hKSduOOSFaphHzn8Zdj2iF
         2aqA==
X-Gm-Message-State: APuU4Z8Ei86kOIt43urWy1/8YQnv9OikyuGcX/y3thBOUHZTmL3Ocyf2
	JxBZFI+KC8ErqK9GUf/xT/z6A56gKirAXkvFF7KQiONmZ+VOPhhECh85WQv/SAC3yRPB2Ga5BOO
	6B8z1hmwb3a78r94I+Mg4SB8qh4DTa1SJJkGmztWLfncIcQSSq5nCa7fnkC8=
X-Gm-Gg: AYBFou1OvhrgsGdl3xDm+dEfCyFpZY0rOeg5v54Ee33SjkHN2FdXuPQ0C65VMx/ly8X
	DfP2uEehr6ekpV4S62yHM+FQYcTuzBJaHRcAUcKxW00KnCyhOrvJT8JOIyvHq3oIbWagV1UH2ke
	R5RaGSk68qz6Q6pIy/FmpKmx80qUfwdGg5flD/kWyXfjt2Cmr6KGVJeq1PwZH0OaVgv1B/Arv+J
	y9FLGe+KSWwDaa1XyI9VYxkgAr5GGu1DhylRJ1pyAYls1ufJukgWw6T8k7VwlYYcKrCJABvwUtB
	OIUJ/fgvX5L60o2NP7ICGkbMCBGmnTv8aDz04yKIJSq5uxRkXKMXWG4WxYrl+Qa2wxTYGzjd2iw
	8U87UTILxfCQ/y/Taun+CrHkJhSqaAL9pAwW1qvjume7ATY8canHouNhvv0joqCyIjPMo
X-Received: by 2002:a05:6214:5284:b0:914:521e:7da5 with SMTP id 6a1803df08f44-91ca49e1e07mr371652936d6.1.1793866957748;
        Thu, 05 Nov 2026 00:22:37 -0800 (PST)
X-Received: by 2002:a05:6214:5284:b0:914:521e:7da5 with SMTP id 6a1803df08f44-91ca49e1e07mr371652436d6.1.1793866957143;
        Thu, 05 Nov 2026 00:22:37 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b57e26b0ffsm438510a12.32.2026.11.05.00.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:22:35 -0800 (PST)
Message-ID: <2711cffc-81b0-4078-b3a4-decad4969e33@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:22:32 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] backlight: qcom-wled: Avoid AB-BA deadlock in
 wled_module_enable()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-7-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-7-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX97F+f2AKp4Ux
 B5ibSYBbhgVaUTmuM4O8Mb5048lHFas9QBq7IHEUGBJcqGlXiy6g1Wna2CvFarBpzMlaEDk26kc
 shIbkz1N/rZdLyE2Fp858lbmzhO+vYlmuNXaAAO1wgWq5rM9cgl/3/ewVtqHM26ZgSlYNm09k9y
 kwfSBgYqyWGQv+5J/2S4FiRwTizWYBxnpFxf+N/ds13gbLwJl/VdPw1CSkRi1OR1d86OhJe3ht0
 dozDWQ7QDImYnFzUPAdk0MJyhu6TwBgXcu9MVJxm+Tge+VY7zvdunj3sxcuFI/8uLZH8SjR+Myp
 bJbWL7iWYb6y31BBkHtf9QK9FeTCbR5z0qzSdaVqjtnAUPiZlCIVDM8AYV0N9xfqWoQHG2Qb3th
 gwuSjMWydODZhqUoHDxBPLO414sdjXf6grblT0zGfwzqb/aweDG2tzyLsCtFf/wWNAAtT0IDwA3
 F92z4XhLXuyB2i/UcFg==
X-Proofpoint-GUID: ipkNc41SBIU4iDeC7wSUujrYrbXmU4GK
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aec3cce cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cyDCuRFuYf_2H7WJZrMA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfXzaeJ/s5WF7Ye
 kWJ34VXyVPR2djjCwdOmyX27K+ZhhQL4tTlot9ILIgb2wmKm1Q9pJ29fcE8Zu1X+jn2x0NIls6n
 emQVa7bST/hq/jJJ2dZNFlFRI45YN/0=
X-Proofpoint-ORIG-GUID: ipkNc41SBIU4iDeC7wSUujrYrbXmU4GK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050033

On 11/4/26 7:39 PM, Lee Jones wrote:
> When disabling the WLED module (for example from wled_update_status() or
> wled_short_irq_handler()), the caller holds wled->lock and invokes
> wled_module_enable(wled, false), which calls disable_irq(wled->ovp_irq)
> and blocks waiting for any executing OVP threaded interrupt handler to
> complete.
> 
> If wled_ovp_irq_handler() is concurrently executing, it attempts to
> acquire wled->lock before running wled_auto_string_detection(),
> resulting in an AB-BA deadlock between wled->lock and IRQ completion.
> 
> Use disable_irq_nosync() instead of disable_irq() in
> wled_module_enable() so that the OVP interrupt is masked without
> synchronously waiting for the threaded handler while holding wled->lock.
> Because wled_ovp_irq_handler() may already be waiting on wled->lock when
> the module is disabled, verify under wled->lock that the module is still
> enabled and not disabled by a short before running
> wled_auto_string_detection().
> 
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-3afa151c-7b8f-432c-8f85-8c43a83b964a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
