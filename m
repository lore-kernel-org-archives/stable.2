Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618149;
	b=LAEPXap1Eps3GKVrElQp8nyKv4CfePUFvs2DR2SqejlyHrza1d9LbZIj2DSrF1PV8TXH
	 D/XPEcuW/7MOm34T2iAFZUsbRC1ylrtkOd8/pZAR9NWKu2ZiBfvJ9Us+RI8Th/cu0gvom
	 WMOKci1zmJhAx2e4Oq1G+9K0eG65HLMNhcba/W2R+Ce3+FCm3CYkdjE9FbECK8jUi/SLe
	 XxpgAm0+HnKSjjFeqO+FyN/o5C6me9a763y6e8aACyjwBKg4Z0jWvNfL/GrXz/kj4GgCv
	 hgbsv10c/xOwAVFrEiK6fVnZqBwzgfz6Mox4T6U+Jhob8TwH4NiOVRMlzSu2RdsU73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618149;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4cTMTGrAlXbYE0wpw60PyKylklFI4cKnE7P1/RB0Lhw=;
	b=0ebVJUFSwfZyq7sOllY9nDvQg+co3AbCv1cYmkwH+FhnRnFMbzneg1mHVreQUwSC7MqL
	 RnA6smykK6UVuU2qqS8a9hhG9JwdEJXsbQmLNEy3NzCGHWOWjjS/N37NCC8SmW/W41fSP
	 wR10RM+cRZNhCwBNvQX9xG/8Fb9MG4I6upwhahEuUWjfB+z8lrPm6bz8woHDjgRd/qzsj
	 mpn1ETXDKCcG/8cEGc6BHzwYhCCdp3wDzszvpaiCWWruCFGLSQ+NbaI8GOmIjDaEhn+Kh
	 bCyknEEu/WcCRDMb7sivUKEWa8hPHMr7syHXvDiqOzPdMBSTJ3tbFU2Qybe+qAOYQQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXntOdJ5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FCR95iZL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17060A2602
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F17060A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXntOdJ5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FCR95iZL
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2B4SCb2616321
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 11:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4cTMTGrAlXbYE0wpw60PyKylklFI4cKnE7P1/RB0Lhw=; b=BXntOdJ5XkVp8UT9
	7xS/6NWU1BgmZ/iXf5O1G8HA5eohJdXJuJ0xVmgpthCTllBFQrsuHsvSPg9WeAX5
	1YHaYSMQQW8t874bYzsSahIVBCY/EWgjMf/NqQEynAh9pOL1V4Gj0IL69nAep0vC
	MceTOSH4zvlpDeTszzc4s+9Jk2xY+kGZLOPskI5ChUKkgmJd0JFKJeCvrqMeX6EJ
	47LKIf6OIdo5tmPs/uYHpM/nKyov2syPmUIJjGEhk7Yzg1jicxMJmjcY+DflsEwJ
	CDkZVfirs9WpVkQ8XcXIoXFpAnqcLXIwVmgq1NogfAychqD+cHcUGDwH5TFGXxRB
	AAgTdA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavg19n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:15:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-536540909e5so8443111cf.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793618147; x=1794222947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4cTMTGrAlXbYE0wpw60PyKylklFI4cKnE7P1/RB0Lhw=;
        b=FCR95iZLnyJIbl4bk87LIlRphqiVeYDcWDGZfPVkL8VqDLw6F7KP+Ls5vkfvLJyR70
         6fWpCrgd46bdB8Yg9i446kD9GgvDjLN38Xzes0caSe4Ram0SUhJ9EB4sZmA+0lUWd43M
         JY3zjccmh9yiIupW33ubutrQOXvMTCUWgwGV4wWE7FMNRqh6Q90NLH85Tmr/zj+xckYL
         l4BRYB6ARL1WubK6NljR1jKJRhOJYvrUiAJ0vEWuV7x8xB0DooWY2HsQuvGSqEQto1R8
         Xrl3tu4cGcOFoxsXXLrSTRioT2LpWN7wI4w+k3sjVSa5Gt3Z0wZvqCYchSaI+8TvyA4P
         ihow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618147; x=1794222947;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cTMTGrAlXbYE0wpw60PyKylklFI4cKnE7P1/RB0Lhw=;
        b=H5PWWR9oJYUZJ4DHgpIrKNHZ7kDWl9PcE13tywAnCQNP7dI+dIA4GWZBs9mN/Ks11F
         GGs7mitruo1ruo0RbM6eqHnPGRl3QBs34/WFPyuD9AdFmbEkLw/ixBXl5kw7htlQPg96
         D8tGcrmvchOPzXXaLBH20iicKq6KZ3fUV8PyamgHdB/eun5r7lp7d5ShTWm2JVFV+oJe
         5rwOq+AkO/mSgZa+VDVHflnkv6dvtuTUh+0T4e0ZCP0z+d87PtRVg285QIor4ar1A0hp
         Rbyncr6nIofQy0tv117zl4ZbDudSgvZmpC0DAjfW05+j8z/UibKOcGmwEqXoP9pI3S7M
         CaRw==
X-Forwarded-Encrypted: i=1; AKwUvBxsDX6rSTkBqCD+B9KYKZecDWqd2GhCEU3tVeke6tYVuInnsTWJ0wjb+30fc8RAwNtrssBHuxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1mmbVLPcz/cGo/7+PmhjWIqKLVf0+H0B8sZSonQb8j5bJva4T
	k2PNE51r+ZLD8YP75vBLhQQnJAbTZp8RTa2RhPnUoA2WhHuURCCUbvg2wc2/EjxllH0T3BDZP6M
	5Xt1bM2JC7ja3fcG6giwmO2RjSkb53VeOgH2tUjwgyk4emx59mKBLjQpP9k4=
X-Gm-Gg: AYBFou0SBz8hQ70pKrf2L6FMHmEBGR1HvY9AC5yLi6kDC0kZ26M0+O3pLVqMCP+3BZ0
	pedgcsdioG+zmqF9ECB+hQ/qbO61U09CMdLBxQHYojDy9GUGTwlkgnwE2x+SSkR5ENqsBgOM9XW
	t/K3sRNuSWC/LJ76UDXYThHXlhyubnSMGkTQ9N4M1SX6jWEnlsyq1yqWrzO6fY9gqbQIi3DC2UP
	Kj9fs8Tngw05TJR3RFLAotxNnHIxQaAxvdStxLZV3qxbfv3sW/sJ2hJBy7v1dIrK/YfVA28y35d
	jQF2N/5lF5Ee1Lak/gicf5GYjoVYrZbCSEpGYgknqnroY1Zlc9JdYjMmYc6KVe+E0Tfk3LmrdBI
	KIoVj2Ukm0/4OASCBHx4ALb2C56gygBXNj02IqydzxisGr2FWiRHzkpNI9vKy+Geo9kM9xcs=
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1532193685a.4.1793618147205;
        Mon, 02 Nov 2026 03:15:47 -0800 (PST)
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1532190185a.4.1793618146747;
        Mon, 02 Nov 2026 03:15:46 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe10081sm378131966b.42.2026.11.02.03.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 03:15:45 -0800 (PST)
Message-ID: <ea962f7f-b06a-46d2-b6d5-f3c1720551d7@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:15:44 +0100
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
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: Fix use-after-free of work
 items on unbind
To: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261102-pmic-glink-altmode-teardown-uaf-v1-1-377d92e3b5e2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-pmic-glink-altmode-teardown-uaf-v1-1-377d92e3b5e2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfX5DaPfUqFuOlE
 w1pDhk5JRi8qRe8t/1aKmxIJVJsQPiSizlyFH5qlYJTZniVFeTPBZvNQfs379EgEal5ztCwdSuL
 xVq0YE/jLtX73OskOvCLSgW6/nbadhsY+34BoTvcNnIZj6tSvc/AOpzl3IR4KZYMGa0BIYPcziq
 R0jj43nYdwLdwZs5sP75UlgZ4O8n6JEM5lYOgUQqR+IjwTEW+U9t1iQqfQK/Za1j5NrlUWxczyX
 D+Fo6VH0RDFpFzJIB0+jlrxN89XdvnKppb82SYmDQr3dJVfs+ioKNhglQ6D9+YjGoKYtCbugXl7
 DU6C3w/CpUzqxn1KFIYkCHHV9hLvJfMimQ0LOw2iLPXDbQhdINuCdgeyqi/uYpLcf0sx2tXg9nl
 e+uY9IPbfZm9vce+VgAknWXkRvj5uKhYT+pqtaPMtVucv2BRhERu1KqOJ1mmHB/AXR6xM2PrD2Q
 HgWQeWVCu/qMXJUnDGQ==
X-Proofpoint-GUID: 9n9bJkzaFh5-XNyKtc46NTtuL7sjpQyg
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae870e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=E2KS5iVw4tJVt3xiAdEA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfX7Swyzj3C4g87
 XnSXpIrGlZJR6wU6UWacPI/U8XxYaVgSUALRmC3eI1I4THgvFtTPJEP8+D/s3Kr2szZw4Q3C40N
 x02IEoWmDq+t7GPj2krHetxEv8m3VdM=
X-Proofpoint-ORIG-GUID: 9n9bJkzaFh5-XNyKtc46NTtuL7sjpQyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020043

On 11/2/26 12:07 PM, Abel Vesa wrote:
> The altmode context, including the enable_work and the per-port work
> items, is devm-allocated, but nothing cancels the work items on unbind.
> A PDR or GLINK notification can queue them on the system workqueues, so
> if the device gets unbound while one is pending or running, devres frees
> the context, the typec handles and the pmic_glink client under it, and
> the worker then dereferences freed memory.
> 
> Cancelling the work items is not enough on its own, since the client
> callbacks keep queueing them until the client devres is released. So
> register a devm action, right after the client is allocated, which
> disables the works using disable_work_sync(). Devres runs actions in
> reverse order, so on unbind this happens first, waiting for any running
> worker while the client, typec handles and bridges are still around,
> and making any later queueing from the client callbacks a no-op.
> 
> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> Cc: stable@vger.kernel.org # 6.10
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-762f89d1-07b0-45e1-9557-bf643a826aa1
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Prepared with help from an LLM-based assistant.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
