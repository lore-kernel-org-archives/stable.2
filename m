Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016537;
	b=sMiGFS7bK9ag9QRSfIIgfEMgl0RDIWdHGiP80ym2hHGHF/KKARARrhSeiekMJ+UmeKHl
	 vxmgYSofQXDNv4LSGWxCJxldd9Lc0+P7pv2sS0yuLMUuSl6O3z5ZoGj3cD/Gq6YsWqXDi
	 cl8uhFPE43aPQ4h60ZRRZatvoGpVWyJhwBJNN1uLWMn+q2rk6wxVJkunH3NHsngajP3gX
	 vn0UzbYaSpkNsxCbI6P7frbab2WxOpTEo0/GxDegzTEAMNLwSSnbwIC/+OlwDT5FeOlbQ
	 52EL1wgNOqzlhYdFSu+gmUP4L6gpsvJ7jxNDrbcO1aBks4es1Jt8YVc/8NnOe+LYTdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016537;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XtJQf2VZGFLMhiJ3YFKF5xOzKvNswmAE4W5BOc9iUE0=;
	b=vkwgcJg2u84NLwpnt0G7Mjl6eWlj58l1JR2BzIczkQdnBTx1Q/BpynwJdoh03CeEIwNq
	 ofuK6TK58GxrO5TgBOSc/SthR+mvs/ty5RUzAEVzO70Mo7S0jefD1X8OFBvsZUw8kFTyt
	 hRO/RVgLPYMtrkHNCqApEhzMqpDICAyZysjLUA6GOdl9OGoWxL0pPJVfMxwbU7hr650ct
	 L1whmZ5h6GsgINiyoYZvFnJLHK2tZvPDVxlvO3zGrRS5OHr9S6iU0Vt2f6qB8AXT6+/bB
	 RjJnfCpWg1+7C+GPH2IfAXfTeW+iFzg1EFwRJyrdx9fJAqryqPDzPlY+m9qC+mb9H9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQjh6u7s;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MCrUNl4v;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595D1606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 595D1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQjh6u7s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MCrUNl4v
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAssGl4131453
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XtJQf2VZGFLMhiJ3YFKF5xOzKvNswmAE4W5BOc9iUE0=; b=DQjh6u7ses5PHOUh
	/jynA5DQqOX/wdpP8HGWs+EuFDkOoXc2RRD7bivH5oj2kThoKCzGBjeaf4IaKUiC
	iWSuIJ//5bhq3MlqjoGYXIOLUQ15qobPfqECuD8FQYWh1y8hLzRdg3lLBWyJ6F3D
	Cuh9Fi2O1Y7sYNkRI3T/VgkU5lngwem8vGIp8xfpIr450Sgx24pID9u5UF8UrfBv
	0W3XIxkZHZo5LooqjQMqcVSxMdjjWZBXa3kRdoNNqsmGOBM9iXjO2s19rA/u7me5
	5a0C4rfw9O/zb4lL6Ptdd+FDXNY0bkF/4yiU+ZuaR/iTNUtoeLC/vhE5q0lw9wzv
	cAvuHA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q0bbs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:08:55 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-988bf286521so88389241.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793016530; x=1793621330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XtJQf2VZGFLMhiJ3YFKF5xOzKvNswmAE4W5BOc9iUE0=;
        b=MCrUNl4vwp5R5DFyVd76+ZQ0pr9OV12aKYrJT7rGlXDzl4r0VKOcjaGETHWH40yo4X
         PjysM/Fa/dc0gmaiDpUPg4bJj7/6O6BZQwoyyDWOF5SpuMhIkuPZwVXL1ptfdbyspLSR
         hEGCQHei1YT3MAdo5wQjnQpicMNeeja3tNPfL80+3WkFnOONNK8t7ws6R/yYwmBDwOGX
         xRY8F6Vf4I3S7fUzLkcP4waJBB48zsIp0gEUYI8fue1H5NZGizclhnVq0yXTpeyrKSA3
         WTrSwFJPLapx8KgQB83O3azEuJDFRLIYCiLEGzSER1gdeAtzzkXM3FuMpswkitxXo97Q
         B/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016530; x=1793621330;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtJQf2VZGFLMhiJ3YFKF5xOzKvNswmAE4W5BOc9iUE0=;
        b=JONVVWoX/2zMi9P/cp0vTy1sOsN8UAYhMC0kVx8DdzzBnaUOx2Cz+nNDaZNyk3UZvI
         Rodv340AYuyEGC+R7RHs4YLcXOywv5wKGui/qHScQ8lM2olypbxhtKWWCMVM3AN+SImC
         mO3GBrvTq4Go+9TcayimyHFI6+dXqIIi6kqowiZjv0wyxTu1/WJY+v2FsPm4uNjyX12c
         gevjymquGtqAmUh3wsXPG1HgTPkd3m2Bdjl9skezYxjDBoO2s9/0if0Fs0ECtYuOVnFa
         xBOJyKnJ2AKtXeZCFRcDkEn1HLZqn1BJbD8BNnksf0AMXHsA2oQ1fr3zx+wnjPKhxkEX
         QYRA==
X-Forwarded-Encrypted: i=1; AKwUvByru8snA5ihwcefvhQDaAfat9WZYa43XTJQ95HLdhiap5Ey+ICV2WeG630NY0n/7xv5ZiTH388=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVrKbMoRH+LBAqRvwZhhFCk5eUYrKxSn2X+kf7PsX2K9MnPmy2
	LIe4fwnTb9chNm3+7W0SHaHE+Ut7rzA1gei7SV3qjMZEBei8FGoFqLN8HhnVNJPC3Vy6ii6NfBi
	dyzeY7U3UiKAr7y8aKKh7AcGCixaCt+/23/Q62PbWvcTCovxlV8+wTQz7iXU=
X-Gm-Gg: AYBFou0omRIgtTeYHQRKPPx9OWXKemAN3E0NYYZ6NMNoucWAPvWHnz3fabd6+yg11BF
	Dlozdpej2q86Pr9oC7yJX3L0Jv4+c864T3f0/EKmh20iiEns1wqehMllw/7VTCyw/qS18jzS/0Y
	Ez5RG6geuRa5Oq5g/yGKlifhimh6ZcOONckzTSWsM0sg5LSkqy/9/FAkL7HOnKEhiUyOuqBv08I
	Vd/M28RPm5zA8GRCIGEUOhonqFaSMRGB1Lgs5gPYuCPNvo3pCGT7Lh9hTxMsHFCl4h9SOy18TA8
	yVFqAPJ68/5dBpN1ASCnSQm80upzmOMypPu5xUIBqY+cWMqxQxDvBTLdpshfOpbtXKctYVS8/8N
	T3ODIeUI82blMSCW1eIt0zw==
X-Received: by 2002:a05:6123:5ce:20b0:5ea:d67f:fd39 with SMTP id 71dfb90a1353d-5ec232b5a4amr1485267e0c.5.1793016530481;
        Mon, 26 Oct 2026 05:08:50 -0700 (PDT)
X-Received: by 2002:a05:6123:5ce:20b0:5ea:d67f:fd39 with SMTP id 71dfb90a1353d-5ec232b5a4amr1485236e0c.5.1793016530072;
        Mon, 26 Oct 2026 05:08:50 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd650118sm312729266b.49.2026.10.26.05.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 05:08:49 -0700 (PDT)
Message-ID: <b4b2c7fb-1c80-4101-b643-7a7f619f604d@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:08:47 +0100
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
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8996: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-7-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX+Mh9FbqNA46c
 uVV81F1sGpHiulsKKJPyq2xOG+BnIbb/6DSJLWUrFIvEGdZlBK/Cr7IMCmTcDmAHLMIgmyGxshA
 irL1mTcoi5bFFXoqlbxvyRB8B/Xiwyk=
X-Proofpoint-ORIG-GUID: T6t-42w54LWndt7X9Wxe2WK_UriThG3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX9ZChl/iHWpZS
 CsDCx1GfQP8l21clT5GJNOMlVcb/OWwOh24gl1gZuigmQkAum+TLyKgPVq9uvMmdRxbJYBFWP12
 ZAC59kMvqRad6pX1+/kLlxtEoW747VwG9cuOV9JoZcpwFZFa0PqsvHPr7M1cgKQOMPCDnCoiLxq
 HhrLnU/etLtOhonaW1RqUa2yrt/klaknxRkva/yTmuA89qkB7WFbAB/f5fpLzAryyNMMQO6MsdY
 NSTwXQxxVnWbDEa+RdCISZLKf3fnzXHXpztRCdwRbFa62tAD1iKNZr/rJHV1/368vU12f6GF/WJ
 WcU+z5b9nskBLSqxmV0V6qa41XcWaYaKIKgMGdGDmAJTUyyq5m5YK7X/stQQxBLUgp0f0pRoOs4
 5cqrz3iblne4pfr9EQFNQ8M7cncrryrvAE9GHV7RKo8SKBN4f9egNVGNxAqKrHYx1YjHVoXBi2k
 q8GE4tk5WUUsCcDdVew==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf42d7 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HmQ7WK16ZiDfZ1s1pZYA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: T6t-42w54LWndt7X9Wxe2WK_UriThG3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260048

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from msm8996 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 1b80b83f893d ("arm64: dts: qcom: msm8996: add fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 818e5660df91..51ef306c1ce0 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -3701,12 +3701,6 @@ cb@8 {
>  						iommus = <&lpass_q6_smmu 8>;
>  					};
>  
> -					cb@9 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <9>;
> -						iommus = <&lpass_q6_smmu 9>;
> -					};

The docs I managed to find suggest the protected SIDs are
2 and 3 on msm8996

Konrad
