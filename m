Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968940FDB9
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976983; cv=none; b=R/H3q64lmWmYsX6F/KiORCoIjin8/eZA5taPi0Swc4AAPLQCXjnvpG9wlOuaLIvNqbwUdvQH5Zr9nt6Dv8xMKLBwvAIJ1nhUNLaPNDEOJ1eXFJMBaYXds9u5U5gURZj6wiwLFRln1K8N4IWAG3R409jNwxuyoVWli9NZT+pCCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976983; c=relaxed/simple;
	bh=qHUVrYNXOCjreop3OQtmlFvJB4z/ZeTtVIsnKD4pC7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OR72/ccxL+PXg9AwJUT3T/pBHNwh0Potz5l/324D/qSn9Ulx1rF/vU2CSCDqSWenlUaK3sO6rARm8ujvrvVUypnhDWuA9N5oz6c4rQ9CljX0L0xdS+shuCRqPkzljF+WeL0xpNcZqBCLbYqQ3a2Yk888Ku/8ryD4UpQILQVFRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jWX4MAsI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ICbcDQ48; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jWX4MAsI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICbcDQ48"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD6KTJ2395178
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hXSh2qARHtU3Y2heqKTk7VlbeCt785lyS28ARpXeBMw=; b=jWX4MAsI2vUT9hBz
	dO5KUnKJN3M00jdD52X7WgmdhwD1AXJh/4Fc7GXbsb4TWD7F/xOKmMfTbMjzY3Jj
	sopUSadpfEGmDZE94xQi0J/nbHkfkkPB7uiXyNwXgIcy34Se5I8B6sgsmS1qD0rb
	aaBXTb9kHMx6dIdfpafUI+8WMURGAgiKlY6pJkn5ruWFcezVcQzTYw99wXC50DVZ
	TFe7rFugycGAuH63q15nT7iqkFUSaBAweVRs7w25YuUubEEaiKmSLssNa1eznCM2
	UkB4ehSbq/U757Jf0j0LBQ2c4L7iNfDRe1oFRku59SrAs2AcgbIHIIVlCATspwXG
	nuAfYw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txya951-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:29:39 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836d003c296so2226637b3.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786976979; x=1787581779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXSh2qARHtU3Y2heqKTk7VlbeCt785lyS28ARpXeBMw=;
        b=ICbcDQ48FAXh6rjZp6r/ef5jc2f375v0Uq+5CI+W4DXgLTWVUVyVzN80ewWqUVUDPM
         t5sRcusRH+DFIToBRR7SfU3Z9Si40N3rpMwm6NR8ygVVGIN7xzEk9GMX4nnEMgOCzR4G
         CSnzrmOVS36HsVZ8+NfOBQwjJZZ2B55xrgIyYiDlHYEtb7DGuv51Zm5GlqByl5EWKRXN
         KQOcxPkCanAB0Wd1H+99q598iHWCBQdbxjm5VGaEaTNMCsvj/t5nwBBZk1MKZIJMEmmS
         qeseNymjxslozqdK5yo0JrKC+VESHzTi7oVp1Bq+lY6ZKpndUNHwUFOGbsHLM43lLDyb
         EOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976979; x=1787581779;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXSh2qARHtU3Y2heqKTk7VlbeCt785lyS28ARpXeBMw=;
        b=c/LTUeFfMUp/FEyEizrcM/Vu/IPlW43Aeg0ahimFPwqWEF7fjOpj1/YhrZoPwdwE0h
         iRMnJ3baVKYcHK8RHI7pvOKw24HPYjKvBe2i9o/xWIjr5qJPXL2Xbqo7m9MGAE5Qyqui
         0yzg6M30axN+q+uTcZrM7s+1JdlKyRByaeI2YoRYlcES5MnCniKF3CQ9K6dCcNCRVBl/
         EW96o1W1zu0Px7NrLKxlO/+YOIlDt0UUE44SRjl5T3yoaO/b/nmCPzBPoKGM9gCrjETf
         xClozbHiZBYOr14dFAllrKFhPB7IXi3TL3T+ZuUmY25eBy67cKSIflfVtL8coBe5Rr3I
         SKMw==
X-Forwarded-Encrypted: i=1; AHgh+RoDknwmngBMrPtK8JeFB3OUAEawfUT7LPu9Dk/lVeIdJtdutOmEirifPFQ7PdpSmykCEkJ5Foo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySozxuWOmEwj6LEwbE5KVczN52Ovk2fW1ai/wozy1objXjXwBm
	u0lryQNht2Jj/RqwTe8XnuhSpjUZmL2ylEPhQ3XaNSJ8mQ45d+HLjR5jhoF3rViUNCJdgq9qUAl
	QbyqSWLcHoO/NMji94ooNa5VSql4HW46NVA10rIxFzQPxPuIYWI5+yI13vQo=
X-Gm-Gg: AR+sD10VODRMN11+UiE9lSLSTXhOmurOwx7EqTMXoVeNqb1OOmPRQe7zO2PqPw6DE6o
	r2U38jARD3mmEvwCcCseMQad18HSlRQRJEdC27KYpCVOgsI/4WXcOHylS027l4ns5+kzGxk+yh8
	X1iH5KNAOYpNQg52jKC3OIZ4TcxcMyuLzcRCQ7WD6pFdGRR5SxVw6FjAObwFM0qpnnOtDfW1462
	qE42ya12vOnNwpD6K7OAKv0LvothJ4of6xlCVycQgTvpDYviaOPjw3eVINUCA0tkqMgpHCYCYM7
	PQM1/6/TM3jJyiAlVW4oX2yVAbBCjPbaw8DdPpLahg3oI3q8+s9ZuaNS5DDKVndogUx9IxOtiZ1
	piatY1QbQlWaeqs42YH1uMQ8G
X-Received: by 2002:a05:690c:6d89:b0:820:100e:1abb with SMTP id 00721157ae682-83713764b12mr100668847b3.4.1786976978856;
        Mon, 17 Aug 2026 07:29:38 -0700 (PDT)
X-Received: by 2002:a05:690c:6d89:b0:820:100e:1abb with SMTP id 00721157ae682-83713764b12mr100668427b3.4.1786976978440;
        Mon, 17 Aug 2026 07:29:38 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45936c3csm10331366d6.32.2026.08.17.07.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 07:29:38 -0700 (PDT)
Message-ID: <6e88de1b-3f51-4c72-8bb9-c198b4f032b8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:29:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: supply: qcom_smbx: test battery health status
 bits
To: robin@snyders.xyz, Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        stable@vger.kernel.org
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
 <20260812-qcom-smbx-fixes-v1-2-eb48246be599@snyders.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-2-eb48246be599@snyders.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfX669HJvN9z0/N
 w7kFUURxRvnKaO8qx9QOapM+ca59vTUZQ1dUJKr64klpcV7ziGfBVX3kz2XzluUTbR4ybIjNCKa
 p4f3zcOGHsKdHhjRH0awMzrDilG9Uok=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a831ad3 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OsHF4jKAAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4rSUyN2hDD0KhXNsd_QA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22 a=aAwnOj5LE8VeXseigifb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfXxohr9HRVt2iN
 bpM627z9oX3QzAUel6XS3wE5ExqDj9wDdpq1oYeMbvD2UtrszhfXvxVVaW2o6hNMLsNFHLHMqKc
 uRr/qrkWwvpLb8nxPLN8SpGgHbFqHxrj4RLgaRT/XF6l27LalAfZhL8+/FlY/mMKufrvdGslbKn
 VhAfwIfGv9sn6A7tBclqFrL37lCCBsSpynXYg/RHdoD+n3/otzWBXRF3YFz8/9zO30FKCBBCSGj
 O0mQT9YWVRMvOERVKv1YyAnGv5sGEPi+1p7oHS6NaDHdeQN7qoVyfxGzNdishr+hXkYOZVhmY6F
 hArXF+h5ka23iMXM9LLv6yAydzDILpxJKEwMtd0zaECcDcFg02Tto6L2IUIJbc/glpzQZjJh+za
 wEhXJ/SdZd1Y9DytDv62Qka0PEmALFkCyxFm9HKWFXIMDUITSV0WHOlOMpfleCIJOWi5myZ1xTl
 7+RzH7PSQ1SUkphWKTQ==
X-Proofpoint-GUID: TFcJgDbLpqoudyPHgIWiwGDIm0XxPK1j
X-Proofpoint-ORIG-GUID: TFcJgDbLpqoudyPHgIWiwGDIm0XxPK1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170111

On 8/12/26 1:29 AM, Robin Snyders via B4 Relay wrote:
> From: Robin Snyders <robin@snyders.xyz>
> 
> BATTERY_CHARGER_STATUS_2 contains independent status and fault bits.
> Switching on the complete register only recognizes a fault when it is the
> sole asserted bit, and can report a healthy battery when another status
> bit is set at the same time.
> 
> Test the relevant fault bits in priority order, matching the Qualcomm
> downstream driver handling.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
