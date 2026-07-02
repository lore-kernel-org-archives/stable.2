Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB747ECD3
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983278; cv=none; b=RA48SxFCW/vG1AKJoerdJnLPyf/KZ91ehzw6R3Xpo7xTYwgp13PREU48dp94uRWMEzrSGNiV/BdqsN+IbOp4Z94P9720iJNV4dlLXHYZ+4IIa00HO+FObeJYy6UL1z7y/J0wRo43UXVcz2kT1uRPr85ahPMJcL7ZmqRpl3vB+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983278; c=relaxed/simple;
	bh=x/r2A3PMWHzHNJPCT3CV4Nov9IjXaJ5sN+BfAkkrPrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unDRBSaiA6EsLqKH+eLCjkjSvOgqfGzP9yeOtA4Xvww8znKohVlvmSJNnyNumpICaEdzFe0yOYNGpzE2qQ7HF2Ye8yHv5YfckBoBTTLhp3ORP+g0KDCRlUEHpvjOy+8fd6BQOCnKA2yeP8DwTi/cgEEw/S6iOE0drou1Heao7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jAx+iWLW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jH6U4oCs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jAx+iWLW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jH6U4oCs"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627TsI23964219
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 09:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ylncxSLUxXESezNcxecxf4Cg6YfvZmwrGu0aRxiZoZM=; b=jAx+iWLWrnKeyR5+
	EQw5eZ5BqUwhxKkuKyAH8yF5wfTKRL6/RI/7gfEETY1LPBODdGD/2PyZ0J8XhCgq
	O1fHSmmpPgurgBi+iROv8cK1e0OsLuY27iCZAIV2X1AGouli99MV+4mKh2PCo2A4
	c3uuMoWdBEDt/6P4cqrFEHD56y63N1rdBHnrVFoBfrgork0XFfI3mmNaS8Q6xeaE
	iCqBHnl+/G//gae5JX2j2d604YD2IwcdRv8kF1/I3m+7fLn+uzow11pYjeJ1CsyO
	JygXsu5jBo8X6KcyrIeV6UkrNXbx9cInZpuKcoS+0vKbcTk2kcFLbOzyFaZzq5Pv
	vWfDAg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc0cws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 09:07:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37fccad2b01so3507493a91.2
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782983275; x=1783588075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylncxSLUxXESezNcxecxf4Cg6YfvZmwrGu0aRxiZoZM=;
        b=jH6U4oCsmaXs3bIS0Cljk5PhMxSqmoQnjg10uGkT4z7WOruO0jT2KkTeiFRJnTsoR0
         LFwb5r1RrKXTm8v2qc5jLtulmtE5d7aDX/VprwCN67i96wcNdqhI/t9Eo7k6cley46R5
         a7p7gqHsJ94vD0YDtQLISK8yalfQRP7OpQgGRPrlRM12SWyuR/tTesNxnRmxNSFPHqbw
         StlxKYwzwwtzY+d8glQlS8zs8HLRtgHVRpcY++GIVLU3jTsmoqCoDDQBlX7LBHjG5GbJ
         TzC3sW1rx/8FJyuCE0Egwv+LlNKi99B6HujP/16IsMCKc4ZCdUM9+YH/I2mMNuhBZt9N
         M7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782983275; x=1783588075;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylncxSLUxXESezNcxecxf4Cg6YfvZmwrGu0aRxiZoZM=;
        b=CjjYY1Nh0u3oWsMnapJMT+BhZYeUjGiEC7BWqFDf/KSuOdsFTw0fFxzcp0P+S2JPG1
         66Frw6+gMtmGl0CPJsOehz66AS4gtxHXxeqZAvOLwfL1K0oTK6RyOGmw93xcnQORo8dw
         So2tBXqEPUKQOUXWCKaGnGuGV1w4Z3e9mAmsz1dMZSEj0PwDYeDnskNQUMAfmdHTXksM
         jTOtitxHFHqg5w4lx9Hg7IHJv/SJe6qCUsJjSjv3lmn8TB1wCjT8vjrM6diwzGi0m2o5
         sMIVc9JWn0oLXGeDnj4tpMLwcKdpAgb861qnKDQqYwS96cwQwAorct4UFpg6ogmN4VJX
         Rn8A==
X-Forwarded-Encrypted: i=1; AHgh+RoXOdTXlnabc24cuBMpFW5R53udS55h2U3iL6ucPdO+p8wwQV+JLk0O16cqlCw9yjK/8R5VjXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOoltkrq7bdCXvK+m17YsLiEgHTCitKH/TzZbub3xCSaxec03
	iuo3edyv4aoUoZ3BkA6VjfdX3c0tiXZOes/CuEYLy//KfiWEzI/OMLpYb8xnWoHxWwKuCi3/NVX
	653+xjqJaf2GleOu3iK9ED3DL2bZaOd7UOMLAAFD5bHD9QmpYx9B6SKKHHfEQv1L2SJM9+Q==
X-Gm-Gg: AfdE7cmRbg5+wcZqDzPDS3Sm2DE1CfE7jxDvMlTmi11iNmEx52DaZqU7YxwWmBfrUmK
	jn3LSYkaEKfXkG0QwLZ1fKedB1lkVBMwH1uK1vKpbliDSpCfi6giMYVh292eBm/6IfDtPBV8twD
	8xlE71Q+3HEpc/Z5L09ZjnkBuXZ/JSFxPI5CZGomqx/B36FJC4NsuRWgQcT3FBUqP6/Xfugda9z
	Gcgf5tbBh0k03+Bs5mnqIJSy8LAPwYK4fJMmpRqX2hYAi9o1Wj3CzYy1TJw9ZmbJ1cdf1ofCTIh
	dPqKb9pKAJZpU6atWzRjFwV5aFQ4tRJzjrxVduYLFGSup4aW5mKT343GBa7Y4KpEsS/QRTdTUtD
	o/TRJuBnonuqkvFVWl3+pWuUv32OHjui4LtS/8bzesM6rU4Q5YU5aDMEVdCZ+Ej7vJuL7d6v4+f
	44rQZtHj5t
X-Received: by 2002:a17:90b:4a:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-380baa88b4amr4478365a91.30.1782983275003;
        Thu, 02 Jul 2026 02:07:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4a:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-380baa88b4amr4478305a91.30.1782983274349;
        Thu, 02 Jul 2026 02:07:54 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e165cf62sm738930a91.17.2026.07.02.02.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 02:07:53 -0700 (PDT)
Message-ID: <c4569099-14e2-4898-ba9d-092680150d72@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 17:07:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix refcount leak in
 ath11k_ahb_fw_resources_init()
To: Wentao Liang <vulab@iscas.ac.cn>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260609092528.220547-1-vulab@iscas.ac.cn>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609092528.220547-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qPzkVuTYT_4uKVIw_E0HqBKPHMPR5QIy
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a462a6b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q36DTRNDronnURX6cDEA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA5NCBTYWx0ZWRfX6PrXz+W1lQfU
 Q9hMKPdJ5TfLzszNK+UGJIOE5HR7h4htbJV/6156jrzaoVVtT8CTfbk0H9HxI6sKmxIxNy+VUdA
 8ZethkGiOjiejY7BUBwYh1aFS3sUFaKz0GZTlm+WVtF8dFVVSyWXYlsPxDa/TTrXaJIKHJKBVbq
 sH1fTxq5iTZyCYPbrqDQANNZBh0wTs5PEl6AX2mMnbmOVw53l4MKzWo2dm58IVdlPgW77TuLrof
 xvv57LKF7HhhGTivHfPzejuLBeS8Q/vD+/SBLH2+OE9MaTXbHLq/QFdrqsqNBt88GpgkT6Hl4nv
 OHTNFcfTkrnpJSEMtwHFYXwnLNM38wprzrFQvXPOxp+fSJO1cR/aI5sFLjGA5XJ9FydAMzawUn8
 nAt7b5jRJKxVCxrBI/NkF9vJwIxXuRIC8bmx+Z9lS00drobNScITJHhLD1FagC8J+LGy5jPy7Cg
 CNROvv0UqsAjq4MjDIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA5NCBTYWx0ZWRfX3vcDTCy5ebVq
 iBxWO8gTfX164EdGwEAoHkWMNU/wUkCNw4uoIwFeg5n/25XLDH/0T+JJf5ZB9fRTeqCMYOUAkLt
 uCJjD4cUvm2sInIWtyNCT3I21ReeUsA=
X-Proofpoint-GUID: qPzkVuTYT_4uKVIw_E0HqBKPHMPR5QIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020094



On 6/9/2026 5:25 PM, Wentao Liang wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, but the error path when ath11k_ahb_setup_msa_resources()
> fails does not release it.  Add the missing of_node_put() to avoid
> leaking the reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 095cb947490c ("wifi: ath11k: allow missing memory-regions")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
