Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015953;
	b=2vhWFSqN2XxpINF1pcA6Z63E6fl59gVhS5fRoZTK7vvM7dYvd1QGTw7qgvzuem/k1vdK
	 oqGIgN9gDedyE3cyPEQ5uWsdt8EwELCN+YgVeo0yOu7KVhTNYLk4kbzSD2B0xA/SnjdRc
	 +nlkypTSko4TjJujWVdOyTUrrpF7tnG2l0c5oU/8ESzPKo3xE34W1pyuyUfW/KwXaCHEs
	 OSs6IPK16We8bLQVPe1+eAYgUCcKT0WmBh9nYTQjqMb3oZFh2B/yCFlOv6fgLqczw347Q
	 WQg259KRozir3FG/f2pPPlIoS19ZUctk6WQ/oe5jbwm82tmKCamS6EP3N5qUqteRg6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015953;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IsV99hi88PjkYSWI90A+gZYiPZ8DnKRkCVaWs6NIztY=;
	b=2qSqBChlO2g5Yj/+w7+ROnpbqgMvoDIpFWUc3w7u/ACNZaU8G9fx8agoVLQeEUqknQoD
	 vo2iCB09vL3nfcRxRzdIhvICX8rfBYK+2QhNov836TpFV7F9n1VNacVXnQX1b85RXszvL
	 FnMF/lgZZt5OxWwlT4w6wiLsh+XiOb8pgjKZ2VUwmb7QDuzPQb6ik2WSnZibM3k8ZVmD+
	 0QQteLAQABwZdWUgPC1ar3fuNJdXPy1nZfqPIPNEjmEsdR8VKyLAPR/Xm8UbtQFtj/MX8
	 W5JCxK7JFSnXMlMQIWxBACRWtQRxtc+ngieNbrrh4kYkj1TrYenm5SjscQI3XcvRFlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DLLvVPar;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f2UIo95c;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C2606A32C
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6C2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DLLvVPar;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f2UIo95c
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt2gQ2733255
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IsV99hi88PjkYSWI90A+gZYiPZ8DnKRkCVaWs6NIztY=; b=DLLvVParQf6/HTmo
	xMkJAaRYx/CNErg3qP5d373mfmkRMlG66TUm7dlT8HzFBnWBcTukab/whPunc1lA
	K0rVIjvllc85JiD1ZVo+TuCsCBUTtwtEdBM9GggqIJq0ujL2InfRQzN7LFO0qEa9
	8Ezy6s6QNxkgyn+hrW/ZH/jry7Qb/4fqMICpV8/EbF7XtpDMbbeEayFc6N3a6/PW
	e2A2nqFoTBOHdTW2cLXfE80Q8+SKh5pRhBkViLKswYyMKihZUhtwyqRirCnfIl7s
	voy8liL+X5m7hHXxY9k6lYNGdMGklZqe+9F+xpUL9B40C3+Ttwc1Vk3bebjBfuQe
	t5E1iw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp8gny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:59:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f3960dca5so41495585a.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793015946; x=1793620746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsV99hi88PjkYSWI90A+gZYiPZ8DnKRkCVaWs6NIztY=;
        b=f2UIo95cr8WCBxV4Nxt1/O7LnBls+f7NXgETkmWDCjDlwoKgHGpeJO8vg9++u0L/0S
         VWbcxJxr5SxdxW5TWcwvJ93tnUL+pSaAj4CTvVnxKwvqETc9u4mZLZLLmpzY1TqVkStk
         ylIVUswJLCqe3m5xWgA4CH1aWVm9xX/3EJ4r9iYI5i/AnF7HqxvCaXO1Z5trwSX63mGy
         0F5K4gzDSpExgqyoUUaxO9yKs7fqcQ0GSDEoSwBF7d0HwCIn9ySPk7ohgd9ScLpbH9/o
         XgBB0esC0Fv4T4xev8v1GLAhXMRHwL02UVAnZkCLlKCO31iS3zQbnBluBpsohfV8StnC
         2WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015946; x=1793620746;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IsV99hi88PjkYSWI90A+gZYiPZ8DnKRkCVaWs6NIztY=;
        b=ZoM8csuJWbavvRY7NXXFugYJfMUoD3BtzB8JvIChqyUnp2BYEzIwvpglkoUNXFXHUr
         YgKEnpSwZhAoaecnOQc+U0eYOdCB1yvjeilm0tdhOJdU31tCT4gT1qH3srrxOSZzN8Bz
         DmdVL7oz8YsE5gra41MwUs+7qkbrzZhP2qj1p0LMvvZbV+J8Yp4DNNNl6jqqm04HwlHV
         2iVW8XrRsvyqstUYp6A3uUggA0LSZEpyppVoVju5rOBsehrY934T6noBFCrxFZJ8iOTx
         oMvMOsNAVHlwLeHhynW9xhc5PzN23VIalMmgdL122hIU2UeWXGdsOzEYE/3CpJyr018K
         7WLw==
X-Forwarded-Encrypted: i=1; AKwUvBwgCc6amHBRSeyFSxFQHuErxd0/eKil5z1F/EOAEQjYjwoSl/BBUAxEumo+4sZjiYnXyQTGNU8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSXqo3hXX+IQd8hD5kgWK3tkqCep9osaVFycVcZsEYQCoeRoWF
	SGXoL9IVybBKSIBeNe8VOpZFm1Sk6Mx16VJlvRuTvYSrLGU5HHPtGbNGtJW0vP5ITCY3uKx5Iam
	6ujJnHkFI8wcod5tCtqKtWY7VPyd9Qo+jNIHnepNu6EM0jJzwfSqPyZgyPh8=
X-Gm-Gg: AYBFou0mXRLijUbblwMx/9mPlkBtu93uTFJqYKI7lAwOHNgnZCH8ySeuVwXWI2/l7WR
	QowLs6tJY5wc6UUYnI5Ic09mqNMMHBvCwYSPmz3xtoEQ7QAlD3gF+63BFzn7Y0cmXqQTfNhIFIc
	C/Mhxw7JJdDpOWLso4Yfbq6Dveq+bgYcnqwUXq+6hMm6rg3s6g+oCJeteHfBxkcDRlSR/jxmpl1
	RC5IRwkxIn7tM2GUb1s/fCZORS3HnBRiR+Xn7DkxqwGgL7+yLjXpCAAoMr2sFcv5PGdo///QP29
	Tq4zBju6pM6BhStb1YE+vzF1Egf+CNwdlFrMScQicZVydDF76E3qT0kt2Rb5REtphYvIXKDVdaH
	5hTZZw+lsBaWk/urxFF5WnQ==
X-Received: by 2002:a05:620a:a29b:10b0:93f:1a1a:2974 with SMTP id af79cd13be357-940ef951f4dmr1003735785a.6.1793015946297;
        Mon, 26 Oct 2026 04:59:06 -0700 (PDT)
X-Received: by 2002:a05:620a:a29b:10b0:93f:1a1a:2974 with SMTP id af79cd13be357-940ef951f4dmr1003732885a.6.1793015945868;
        Mon, 26 Oct 2026 04:59:05 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd529b47sm310666466b.40.2026.10.26.04.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 04:59:04 -0700 (PDT)
Message-ID: <f0bd8179-f211-4d2e-bb0f-a419744de2ea@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:59:03 +0100
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
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfXyObTmRUstbj4
 kD9do9h0TLPZcCNxWAXcl7YSACOvt0xRmrhbX5UwVmWUUXQe/JIHql1ryqQYeOsnYrTL/nMWMmY
 UXABLzqm8LLZJ4D5Jy5MErEMsLzFYZZUDMLuYOrOwGGETBDVA972LDlaTpjgEHzKLakqN86rXx8
 HcIoJ0ktjtCqygoQzICUdZ02lYhvBhJ+sde1XaMNGuPa6+hmx894UK+K5RbTL/hdSRCCnrV3pgZ
 XscFTBOkWNyII1ToqbHztqrwKS5FfaoG9gAGnUdFe+1neTqxgLjvz+vpKM9GsLHWNNGiNGNsUJ/
 XKLcBcOSZdaM23Q2X/wTm2BoVgW9J1QhM6O+lpsM3ICpl2hyHog3xW/Wi/Hzt2cX3ktdvpgGhfn
 PkcaXgDMFYOhNIW5kCgC2QYHQK3B8aZFXelab+GwpRD8cEZXlukQzxueYgZFGF4eydAaTPTkCWc
 CUEGtHapQ9YQKjqaEdQ==
X-Proofpoint-GUID: 0aIYU9NevHPLGRa0XGcWHHbm9C5gI_o4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX4O45m+YvmHj2
 hp6t6129wHZ+n4uZPdVZKdcJ4uZwhi7bY2WMqaOkP0BS6Lug9Z5qHqkyQyEZj1A8s8+12aK/bJg
 Wjg9HzOx423QpB11nBL4MniAV3GaL5Q=
X-Proofpoint-ORIG-GUID: 0aIYU9NevHPLGRa0XGcWHHbm9C5gI_o4
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf408a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=khcIRSTurGpjo1Y0ADwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260047

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sc8280xp device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
