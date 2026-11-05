Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866499;
	b=cE+OS/RK53AbyYPc/+NQ866iENu5Q4UQyWk3sYfk3JxfgTxm6jhxGF6PaEEHT4JfqRy9
	 +k6CGubypX5e1Kok2Fx86cd98NM/H02kpUjQVAClxyPY0K0mGx4WYZ+LYuj+QCvNlx5kC
	 7JDZDlVmEJ2vLn+qZao8aL7sSZlW/Xn5RrjUlmFfvljzktH2OagTltKmyNbP41vwSgbzo
	 wUquCg9gx5T++/bLFbjeLuAg5UGcNjUvwCShJZOzb8Q+wgNlxFi9DP+kHwkx9J2e9cpmS
	 HUbE6GGSDN0TsRmzuJObBgmiuzLhhF/sxM8fZsumUPBIjcIYq9es/e3KzLxmld2TKAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866499;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
	b=yi+n8uCt0vJQEu15CjUo6AzOhbOZnl1OGS4s5J/jefs5hoqZczMZzjO8Aj8rlwnb6+pE
	 /CwuQk+72ttGjCzkeQQOkgSS1i1Zym/Cdw2NNXF3u9VGCMaMHrlwBjrgo2vYyZz7Gv6gq
	 kbfF7neD+8M0hY/QfmZGywCCKLscd0PcLpUajXr89eAvwO5ncNMoCYXUOvdZH8Lfde1Ot
	 wwGT9w5Gm2D0BVAw84i19ynM47GTFoUWvCAvy6npgbx+Izc41R3KQB56C9eB8aggjCTGN
	 8ZqZZhQ2QZETnRS74qYVbKF2d3W/wDGmr1aX2mz4wLNseHuj8wfwIxDWmS8dIuzwk4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j77L8QPK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R1FBryIY;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983EB606A330
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 983EB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j77L8QPK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R1FBryIY
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56U4Xc3073642
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=; b=j77L8QPKWZBQ+jZ1
	K8Btva8ICOlPOodpHLv4RKpgwyePhZRn+zZizN9rDvlunq533kw5NK+baUNrpaTw
	XK2xXF/FJfDqIS/uHxgblKfJQyKenikPMofnghGau4ED6zfHd+w1vLAlbZPA+tpn
	KVQiLJAyrsnOZaqh5jfgjxAW8pRJ60UcAnuBnAaIeDiyynLO4/VT4aGSxQxZ2hRU
	8KGehbPJU8lnW6XuOKmsmknMr/eq2BdVUbsvCuEuFBCMy8pPw+J3TnnO5uEcIV8o
	pp+v5LicooMtD5U3luCR06m7sdbaur9psqVgs0Vdhd6OiTt45gaFSZbeqVPB3rcx
	PbkHvg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq8kka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:14:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c8f9f6b49so3880736d6.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866497; x=1794471297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
        b=R1FBryIYs0ICPItE8MiJatJT92Zw0SuQATdhTmE0LbBphFdwCBSue1twZIev6yKyLL
         AW+uQMleTJHTo2n0DdEk1UIftx07tR5Fm73ORe4Bdob9nD+fGUfjX9QZRSZlHoURa4D6
         ZzhoeyHlKnRq8KxbFgYCsrssI4hMQyt0Ie3hzdCehyAcSDexBTReEhZxUTECXnNz4okL
         1cYZXNxxH5F5b3CFx/AMQn3coaaS5YJHjLD0K2Zl+wP900M41vJ2C9CagforW927K2ZN
         d7JTcWazVyicV/nDGdXEeVcvxGfdnuPlE0mpi5LhhSKmeNfRkdsVitkHLbKAocBrQe/m
         oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866497; x=1794471297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNclkriunYbBMaVdIXTN6SL9vtukgwN4y6FMbEyV2KM=;
        b=JimRwfv7xe49siJa0vk4xBz1V/yekf0EYOKMBCmhE42hYd2j1NI4IBWQXikwnHxwxV
         dbpttIKR2p6AJa4vZSNdPIDLMjfYo5DEk40yR6qcSkTRO5o6+Z8VMTvxU28gMEcJmm0Z
         VK0SatGq+aDwRm5v48t4y15Bj84+N9CcdAMg+9u/FBzKoYTeEiHgkSkWugMTpkLgIYDe
         9ZKilhAOitIHTvyLngiUvPYAhdJjpk0VD1vOpEKKN9dmYDwG5cCgSg56JTfqLPttWrUJ
         N21zURz786sRAzC1ZnUU6aziY8pSCN+e+0kN0oBEnymxO8jcYpgN906Efm1L4bKf9F9f
         tX7A==
X-Gm-Message-State: APuU4Z9caER1l4QR4f4vLgNwdO+TpaAIJVyltOUTCUc63vY3Tlsc7Iy9
	6ohXUwwIR+YG82ApXpMHuG7Ed7UhfHGp0PA5h/dmeGifMX9uMagNxU6m8CL/Qfhu5NY5iWsKXID
	OoezP3rtGdgq7tdcgGcySPrSUdMuBSzMAhpaYOv05gS64Uv1kvwns2a3nGM4=
X-Gm-Gg: AYBFou2M6wpwPwe4j5X2Na43pvQ4A5WG0nq70BLhsTRIbc7JXjFPuoLinOz1Pxd5jh5
	AtWipwqsWIvkKi63ZyGTe0tL9PSGZoZIQmt6SU3o2AWhKwK6ed5GmBtXYDUlHEzn/TSawzjdGeQ
	6pk9kq1c5/wKUCZhPu+SKRqHLtg+3SF4vL3861mA3tSvj1b1vHQSuFgcoXMmdzp3ZVG0MfG34B+
	9002Uus6r3u4OzzOL7VXUjxm88vrH3B7P06bQdClkm4fJufYxY63x5f5LYOPJM6R80m8577gWxQ
	sFc2lf2ZHE30bfyhp2VmAwsu0r2eVzZcLcv+fY4yTJqA1H9MscodSwir2Ia02uaV0g4bsB6NxO7
	SXO6IYmUzso3pxq9H0sI5SnVBVkkZKcykbMeN1MgGd/mq49aiFa9oSiPsJY99ZpymZaSu
X-Received: by 2002:a05:6214:5913:b0:91e:94a2:f994 with SMTP id 6a1803df08f44-91e94a312bemr42645136d6.1.1793866496656;
        Thu, 05 Nov 2026 00:14:56 -0800 (PST)
X-Received: by 2002:a05:6214:5913:b0:91e:94a2:f994 with SMTP id 6a1803df08f44-91e94a312bemr42644466d6.1.1793866495886;
        Thu, 05 Nov 2026 00:14:55 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e44650bsm149681966b.43.2026.11.05.00.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:14:54 -0800 (PST)
Message-ID: <54b22ec7-f763-4f89-a711-c6c6796550cf@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:14:52 +0100
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
Subject: Re: [PATCH 5/6] backlight: qcom-wled: Check for auto-detection
 callback in wled_ovp_irq_handler()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Kiran Gunda <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-6-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-6-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX+bLdXtqYRHJR
 Xxy0Z7btNGAwPQIfQibk/TuP/UXvaRZ5/C5324pzcrXeZD5fK6Fh0l7XzORLeXd4yyu2DizojII
 V15NyN9+v09dt0aNbKcEKCtM3LjJ/XTTbIkretfu7iSzNa3KYAbiwzeXdwassmM9Wbfs7L+/ih5
 6574HIKKXQn34JpfSoGH2L0y3NpXEBVveFBO/keWBDstyyH/sxGNJrnLQSkG3UqqTC9COeopCzD
 sf7aamLurvzE2VR5DTeCTIDGGShqyR/FM4BCnPlQvNJJyl9zLSMvh+/B8q9qXS76Uzmh5TPf8C5
 D1CSs2+AFc9m+PZQ+V/MItslTPl5AfKu8Y75kSSoxDlg6EUIzT7fQF1OxeR549paYBlK+RduVxl
 fNn6gV/7O6fhdQsHn5Nf55sEw/6LWEG5Iqxiyll4uMc6rIP3r8MREQYXNWwgQL/zzJF2QhNiWeD
 yVBqQd9KNf5IqwIeW6w==
X-Proofpoint-ORIG-GUID: yuwybefU2NlwgIWrJfsNSq5rwgjrmAg4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfXyk2HDlLQG78g
 oPNzEYPAG/H/rE4lg0JzxJTW3hdmNYfZ7OV9P4u4YlZIoYjlVZdJ5eGwyaB6GkqJaEnnYRAztSk
 f/xJ7F6DsoTxp192+Q+nHTwp1g8wFQY=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec3b01 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EwSOXpY8fmkhG1aJMgAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: yuwybefU2NlwgIWrJfsNSq5rwgjrmAg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050032

On 11/4/26 7:39 PM, Lee Jones wrote:
> The wled_auto_detection_required callback is only populated for WLED4
> and WLED5 hardware, remaining NULL on WLED3 (where automatic string
> detection is not supported).
> 
> However, wled_configure_ovp_irq() still registers wled_ovp_irq_handler()
> on WLED3 when an "ovp" interrupt is present in the Device Tree.  If an
> OVP fault interrupt fires on WLED3, wled_ovp_irq_handler()
> unconditionally invokes wled->wled_auto_detection_required(), causing a
> NULL pointer dereference.
> 
> Verify that wled->wled_auto_detection_required is non-NULL before
> invoking it in wled_ovp_irq_handler().
> 
> Fixes: f16899a6a7d4 ("backlight: qcom-wled: Add callback functions")
> Closes: https://sashiko.dev/#/bug/linux-d3eba287-2af9-43fb-851f-78ab3df0f35b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
