Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486246;
	b=INCw8F6V9HGkzOAuwHYTlxOAHafjzMmxFy1UzODkMHzoz7728R/v/srBVWmqmh7+hoKF
	 ZOZ++1a6XJHH/igYaSE+TI2MnYEjOV7gEgr7AJ1mYIDF1ErY/AzuB374ksEZ7uL0DE6tf
	 G6ET4lvNp5kJdOKJLKCu1QuRbsH8Vihxfh9E5qPY3ubVXqSUpS/a2BEavcjlNheYFMdJJ
	 0olBGpfZ23wO0rO85lPRjEkZkRGkkdMGtobgd2RUh6ANPwahh4w9XJetyEPMI0iHC86rJ
	 hwDDb64xfllGhPrwB3zzlypW+0ecPsewU332VBqLz9LPv9jrwv+Udzg9Oytg9HGzKPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0k3/SQcwL9hW/Zl7iQWhHjXEYHWrKstA04jHEI5oZUs=;
	b=ljQT8XPSwbug8YhwGvhpXjzgvLELj4Y2r1UtPOlA5gBKy40zZLSniiIhv3ZZ/pnmvKOO
	 p0poH+zIMrkgjSpm19jRyPaN7/nEVCT4yrImU62JTWp6kWvBefLo4hsB8IV2LuTKZRbYX
	 X42rAJnpNlX+7R0HKDxTcZr7L9Sg8zX4sE4QpePTz+3jTnNetgi3OrbhKdaxOgOqYOcCv
	 Wdt0mGxBq3YGyyHV04T+IjrCKivmR+OTy2HoZvgSVxQ+/PJtDABPRZjy3zkzmLsg/bTQG
	 6d46m5XxjFXdTZ8Q915nr8cMgsnu3WIRQg6VTxz4mX+kHjTaZUFZaUskuEY0RlXe8xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KkmcOBHf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P1gMtb9K;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A6606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KkmcOBHf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P1gMtb9K
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8s1bM4149474
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0k3/SQcwL9hW/Zl7iQWhHjXEYHWrKstA04jHEI5oZUs=; b=KkmcOBHf79jShrul
	H2EqW/ZrJ50XOHWwwifpXQ0TCJLYKzlC/vFsfnf3C4lLtqxGzT9oC158GqlDpUWx
	KFGDOCnGwgnAsXIXsI6+P2uHFBdJVuIGwk8fnjTmGOy4p9TxBDiCM7u1kAcqIcfA
	5gg27XA2hxK0KC5Gska/BLxLkvhnLECkeYpmAmjUi2eY1yGZOOKCpvOxVI+uinL/
	T/SQBHjQDO30bYig+i6EnCMxIZNoNxsNIOAWcTyoOxe3PCwgMjVab9jHU8wR+U0u
	8lCw1g0X2Er9ZwsB5ErDEl0fdKAlcwhV5YByiBSJ8X57ME2hol5wW1pIbS9Q6Khi
	tFxLxQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvxc63cag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:24:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f1440e081so45841785a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794486244; x=1795091044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0k3/SQcwL9hW/Zl7iQWhHjXEYHWrKstA04jHEI5oZUs=;
        b=P1gMtb9KO18CnCb8ilEz0YapGTCLTUyWFFYiCUB0/OGJB4Ly9VD8kHX1PofwLp4z8H
         DvGgJzl6CMJ/tCyCq2aI2sZcFUXsOhYcZpWVaRl8NfkQb5dqYpRATFeuSPXpuw8aod5Q
         9IPEAZVsRWBOiOKHGaQyfMivOYK8sn24jSHo/knfSwk56aCVQMIAVcffOZWU0Y8QFf+/
         Z+kWtWWJkFk8nMRcnSWIB+wcBBTayyc1siG91Z/7ee3ZHgtSFsqO2cc0JxofDepUNj8s
         h8CcYSIGQRKs2F5Hjn7ljaEU0W7owcWuDG/AfYJUlmpHk52uPNRNNi+C3pYEpGuqbk34
         MUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794486244; x=1795091044;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0k3/SQcwL9hW/Zl7iQWhHjXEYHWrKstA04jHEI5oZUs=;
        b=CizI3HkbAsRVRJHxbEDGkGIf8fkmb55vP3n7aKmeH6GAbpv17mgT0E4hS/1ySQLkNw
         yF/8xBH4bXQf5fdEnnLuNOPqISvvotL2qX8jwyQ2sqchmGX5oFP506mvQrH4c4yTCxJc
         f8ZVOMT7tOFdO3mXccdyXqrP4hZtOwIR6hygBpM49NAC78hSByydfN947cxkR/nFsEkZ
         nNPgymjS8ykOu3fidFdewmA9uwYy84/nRlpaC5JA6Zbw9IgjvgLmcokrQhNg797peTb5
         BjBvIWaBv/dF7SKqI/2I3Rmhr1rzOMXQv/Xk5hs5f4D6lXsdBmFqpdwRo9WzKl/3Mhzp
         qvTQ==
X-Forwarded-Encrypted: i=1; AL+hErE7UGM5breQ3OgSIInNJbOYBxQ3uxJKm6z2NQTP3g20scKcarKd73y5smtd2DEA2+Wtdi+v8qc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OWpnhZoDQGBb0Aa/zXrmXR9DmgWyM16GFbgR23m3VjzLaUkTF
	5sbk30ACzYAKIwoeWAx4rQWI8Ak0ZvuiQg5qlbgsca+IU7rHdrP17GHEIiBErV1ZKCi2l4FiC25
	JOfTFzLpL5i0/zkYvk+5UxdOLlRMUldmpzbeLJQtElKYuLfPV7166Aig2voE=
X-Gm-Gg: AYBFou07sm1k1tFrB8dDkzPRpvPMJoK2bhahNrtO55pEKRKFOwgDWOlrY0vRvDRFcwC
	v+oUYBUd4K3OUTKfTINgakNxx4hwMSs+ZMpRk/tP8U9SE/fX6UIG5pXLd5HAHy+lQR2/OA1xDQP
	jQvGCUTz3Br4J8tM2SrRWLcJjur+eDOu+FqBIgHHAOoZvLWmG6iYPhmg0fb2/1XZmtkW51ZfRgO
	QoWBAhMpoPPsFuAlzj1a7RDd6c8Cpy3NDAJk8OK7TYUL2yIS2JH6kuQFVepKTDKg8L+cVtgVuuy
	YUHc5z0kVNVu5m4gqgfxvwyPQi2QWOi8Z4lIo1PuTVr+7qnpfK0bIdUkMgntuBwW5Br1A5xtuZ9
	9vcibOcLFMBiH434d36eRTpvB93Wzm/kpZdC02OMEzYsz/Tra5Gos8TV44q8wUJz5eYBtjlc=
X-Received: by 2002:a05:620a:a8db:10b0:939:8148:1e3d with SMTP id af79cd13be357-947afbb28ddmr880862485a.2.1794486243570;
        Thu, 12 Nov 2026 04:24:03 -0800 (PST)
X-Received: by 2002:a05:620a:a8db:10b0:939:8148:1e3d with SMTP id af79cd13be357-947afbb28ddmr880859485a.2.1794486243186;
        Thu, 12 Nov 2026 04:24:03 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6930sm334003466b.5.2026.11.12.04.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 04:24:02 -0800 (PST)
Message-ID: <444934fd-f094-4c46-b7bd-6bba62456dbd@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 13:24:00 +0100
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
Subject: Re: [PATCH v2] surface: aggregator: propagate -EPROBE_DEFER from
 ssam_irq_setup()
To: Wu Enqiang <janussss@163.com>, luzmaximilian@gmail.com
Cc: platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        chris@nilk.net, stable@vger.kernel.org
References: <20261003044844.63157-1-janussss@163.com>
 <20261024054921.48209-1-janussss@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024054921.48209-1-janussss@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2qLIiaHAo7f_znCs5kdw8dLaqb-JCqwC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0OSBTYWx0ZWRfXz3Y47LJun86o
 q2F4xJOqi7Z7WsnnhgQZyoh+Gy2RJr0F3N8NOOzPNlpqBwYi8X41WB5VxM8A4iv8HGwSb8ouhob
 /JZeeRkukJvwrIpRhjQSVtd6Oa8MzFxr6N9DOWRf3XCMt2jnCVKBZEDaPcXpKaAJmTM60HbLXK/
 IgDVw2A13VAuSm5PtO5N7536kjizC6Q8FSSTUR9TlBWB2smQ72O2E84BCygCGo4xrDqB8he5Ucv
 yWyBDctcHIZb+hHk2qUYmla8kfS/dqqTCzWxsUrSwVOYRcu/JFdmKVFLwdzpgU7xUJ5nmusrZdi
 IgSLEwdlwujGysPVRzK0UWUA+wwu0QL+OppiNHY3zipwOmO/E1lxd/rvdxOBC8ooaamKgFWWFcs
 yE6047ClNdOGdebEHUP+5Y/LWTxE4C5lEx5wdFA/Dr90vzaJCtyI8AQT4tQ4mcUKvXeWBPdXKIa
 VyU+lY7JUbEG3jyb1vQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0OSBTYWx0ZWRfXxHfwg60ffFUm
 YjTQvwEnlAKCN7mysJqBwRnExHy0qEqK9HdBgdp1EW/DD5kXrsT1aIfqd/cC5KSZqDQHGCfz65C
 006164eGV5j9vkSqeOLlxaqCOXkMsqY=
X-Proofpoint-GUID: 2qLIiaHAo7f_znCs5kdw8dLaqb-JCqwC
X-Authority-Analysis: v=2.4 cv=O/ysLx9W c=1 sm=1 tr=0 ts=6af5afe4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=LbjcC2kGAAAA:8 a=NEAV23lmAAAA:8 a=Byx-y9mGAAAA:8
 a=EUspDBNiAAAA:8 a=dV-cC-vd_xqL0F_XgbAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=wkD_FXWuM03SqqimxJpr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120049

On 10/24/26 7:49 AM, Wu Enqiang wrote:
> gpiod_get() can fail with -EPROBE_DEFER when the GPIO controller
> providing the "ssam_wakeup-int" GPIO has not been probed yet. The
> current error path falls back to fwnode_irq_get(), which returns
> -EINVAL because this device only declares GPIO resources. The probe
> then fails hard and is never retried.
> 
> This has been reported across various Surface devices since v6.12,
> including the Pro 6 and Pro 9 that were used to reproduce it. With
> the SSAM controller down, dependent ACPI devices, e.g. the battery
> with its _DEP on the SAN node, are never enumerated and battery
> status is missing.
> 
> Use gpiod_get_optional() and propagate errors to the caller so that
> probing is deferred until the GPIO controller becomes available. Only
> when no wakeup GPIO is described at all, fall back to fwnode_irq_get().
> 
> Fixes: b27622f13172 ("platform/surface: Add OF support")
> Reported-by: Chris Simpson <chris@nilk.net>
> Link: https://lore.kernel.org/platform-driver-x86/d0bb21cc-6d3c-4526-8204-2511da51a6ac@nilk.net
> Link: https://github.com/linux-surface/linux-surface/issues/2219
> Tested-by: Chris Simpson <chris@nilk.net>
> Tested-by: Wu Enqiang <janussss@163.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wu Enqiang <janussss@163.com>
> ---

Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # Surface Laptop 7 (Qualcomm)

Konrad
