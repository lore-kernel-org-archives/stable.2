Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016972;
	b=uqkUuU/DZYFBmmaoAp0M1fyYiyg3LJtCWiJTm2UWk+rDFlSdj0cbxvtMh/J2t+GqbuhA
	 /EKJolGZG4nXWZ3Je2NxXTMkS83HIx5v5bFDsmg849lOyzhWuV9XcdzDPsqYIex1uAK2k
	 mPHsqXYhQTKalcgKF0m0uOZSh/i4qsZlLmIr7VHDrK6EzPUe6v4L32N8iM0mfW1Dwq25Y
	 +BFUTK1WoFZWAmClCF4XaYpkmT32XodNF/yJic4xRtHuZp0m2XtfIzzdO/kQ7XG0VIsVp
	 pZ/Xzjt2o9ip3tDk+dXdxPXhzpWiSLMNYS8cdHuvw26qIlc+PvIUvTnFkPrg2Ifpwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+LTz0oBJTc4CpLrS+/ZEJ4++07RrvK247eLZ+9FQt4w=;
	b=ccXIEa/PG4C/dsoFmGc41p5FOiL+Hz1krc8LHRbgNRRnx+XxfXFSn1BYu9RPVNzrrIkx
	 c8KNE79ZESz607YnPtiDoXsNed6EZD4s3kBeqEpoKnKD6j5OSZlmRC8cdjeQZonF6uGUZ
	 mBFw1zfhsKH3zWymOsQbB14GgCzMOzH6y53fgDSQBUA2pbb6ub/AqLqfMfN+ymlRwTWGW
	 tpA9JBMCA1dPpzS2JSrkXPYcyHR8l5BZ2XzJoJIAaRt7o870p2qgfvU9nriI33cB9lIfx
	 69m0tw2RFekGqxlSAhA+90pMHxJ42m3xkFkI7Jmgc3Ncmc1nLioaL9SBPY0U64mHqXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTLyfggU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RsntLCkc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359F606A332
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F359F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PTLyfggU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RsntLCkc
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAt0Hv2168793
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+LTz0oBJTc4CpLrS+/ZEJ4++07RrvK247eLZ+9FQt4w=; b=PTLyfggUoRL1+sjm
	/dcaXJcma7GaQiR9rDSTMAhb8C1uuduWHQ1g8oGnqheBndD0kclEKiPfTbucUCkI
	n6AqYRcXkAii+mT+Qr6pWfKFrkr8BF3iYjk7m/x7PCUAi3WKTgCQjlUwlpsdAxEt
	Bz/p6N029oxMmZV0QJ520ik9Jf3jdrhdUzQ+ItOwnVapESdlHRXSxb+SguRw6q6v
	AV3RoSnqS4pJrRPfJNI4O/hyC+uF+Zw4T7HZ2rWmsbupTHl1dcnXXNzEvMFdJUqD
	HLcguNwsRNBdjYMmeraNyIUUOsrrpPjeVoxvQywEM1IyKqKlM4lOdxfnJ4wTGTi5
	Ksrw7w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u60q8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:16:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc50fb0d2so47320285a.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793016970; x=1793621770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+LTz0oBJTc4CpLrS+/ZEJ4++07RrvK247eLZ+9FQt4w=;
        b=RsntLCkc5kvFQzOtihmgS2ACBqVKvrwCd0+IOCtikVBlXQ4pk6K/09+3B97wFi9VqW
         3LoaiGLmKVx1NNEXXPSQFwO3qqhmHBRYqB4x2hIZYWCGjUN9DNLvZm0oTF1gHUSAI1pz
         CLciN8Oq647K+gomHN1vR5gU5N42OmygIjl459W1ZHJ3mqXQakW5yeVJnIr+ceOucHGj
         5DXl64eLrtGyVJHCDMZIokktGMG0ZTRXpFU24rzwGvsFCPmUa/NF+iyLssliDzxz3B20
         a1Mb8NWL8sDeZqYUfyaczIClAgX/LLgR8j02EFYfO8xFgQl9L0N+cj2l9h+sWhu+zYXg
         9baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016970; x=1793621770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LTz0oBJTc4CpLrS+/ZEJ4++07RrvK247eLZ+9FQt4w=;
        b=DyaoLoMHzQr2Z+JqQEB7lh828Yu6vi+X4Udx2DaOHNjnpMbebZPzlctx6XAXMPdjBB
         Qrkjw4I0KuTLA7LM+sqBHyCs5Nz8luXGTxcfnP6093hTYtqtqo32JOcPtMlrJlrRg+62
         u2Kxw+AMqBP9kkCGZuINPUh8X4uAI1e3xOFzYvUk7wLfthEgWlF3yOfJZ7ayrM6sEsmL
         KnRXjghKZFOeYRPdemo1oTHbOS5Trdft5nEmzrttvqBP98YK6IwZDgsUA4POuMVag+NQ
         xiS7uR8FG2HCYnpAH067/7WCVLw3GIPsAS0YWLhiyc/hpxgM8Kn4/nWlnku+DiiNTZFV
         piTg==
X-Forwarded-Encrypted: i=1; AKwUvBz23R3jbaB4NxYBPJiQ4g/DhZV0TuGiVBP4q/05SWtQjNKK18VJqcRqzjL8Va+dJ1B+By0BEZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4MBsYixWV2JyWu94JdTnRgqzBqKneAmgQLjdqSoBdOvZGg5zE
	PkhQiPpbG+fDEvYu8rS9ZkKkeVtfcMPdVMH2VGtk6H8uzZMxoVa6Ru4uc85S3EeXT6y+NNQus0R
	g+IfROPgm9DPKy9CKEbaOkNWFYMBgdy9ebxBeYTF8UD/3cXiMRM1w0B1SvSg=
X-Gm-Gg: AYBFou2oIHP55g+oGSGFEMbsPAmg9D3S+IvNsRrDKPOkJsKtWXNdNttgmbo+TJWaOpz
	C+wkjcz4bzuWnp/fYuwUrCIFPLZS9J9/CDTiGbqwfymj2M/82Vc6AP+F6oJ3z7Bo2P4V/HAekRD
	9aKXeArGJSC3S2uaWgoJWUq7eKjjEht1aeQ1Vhy2mq/JXeg9tsapAUkEKq4izzPQacqcsuHPiiu
	Bj3SFCmN/jhrNZaeLAPmbp8Fz/t3FiednLWmSjBZHQ3IlmtV9B1LmzdX8LZDY5GyW567GAzCsI5
	lqtb1OUa8Mhp7e4HfP2IGRFFu8aT6rHfg6oG35BR3P0Z8vp2t/4UdHDbdJ+1S8mvDdsVtHAclfQ
	kZGFJ/xAS4EATrkfgNBs0+w==
X-Received: by 2002:a05:620a:5797:b0:93f:740f:5a62 with SMTP id af79cd13be357-940ef995b07mr1112355785a.6.1793016970112;
        Mon, 26 Oct 2026 05:16:10 -0700 (PDT)
X-Received: by 2002:a05:620a:5797:b0:93f:740f:5a62 with SMTP id af79cd13be357-940ef995b07mr1112351385a.6.1793016969543;
        Mon, 26 Oct 2026 05:16:09 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a9c0bbsm1587764e87.77.2026.10.26.05.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 05:16:07 -0700 (PDT)
Message-ID: <673273c0-efd3-4ee7-a008-7e70fdada1b9@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:16:03 +0100
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
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sdm630: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NttE5l2FirPoz4bWK7-Xucb_P81nD4dm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfXwYztdVeAAfN5
 uE1BCHBzHYc/7kASaStswczADEGYBRaQO1eDoueCwOCa04l+5SOypadvJeftR/H0ZVI9kUu5tRR
 LxIw0aRyRqcrhwxvhAtCpALWUkqbQA4U6ZSCn6bij6YCd6btYkeUb/QVQ1PsaGLT0oP5jLo+gVk
 GX1IekefRcU7NZDxRudZBn2cQTTO4Sn/HvhE3zojC7S8pIJvTKJW9JJ8xrspt04oRdDBWYtBtag
 qXyuLD/H/iCWaJtJLqxV/lU3hRIyANI8GFechdAlp48Jaz9TcSv2wQ0TL+5Z8Z1TJrL3xKFBxmq
 dEx5Dt2gMnmwZfaa4SB0KK/beOKjDCzNFBIzQnHx8sstpMZ1Otqr2KNCX/Zuxg62uim30d3zUBu
 BsFi7DJHVogUZ66wPiBi6nk60jxxV9F7pqRvMx4ttqOzmIQEU5FtEThxyNQamV6a3dZODtlfzH4
 xed5dvIoMEu7ieGYbEw==
X-Proofpoint-ORIG-GUID: NttE5l2FirPoz4bWK7-Xucb_P81nD4dm
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf448b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HmQ7WK16ZiDfZ1s1pZYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX4le4HtvWYygx
 83u3Qq+V3UqLeHyszBRyI1M3y5rHmsSuoXiZiIAItE5vcCUWHsPeorLso7Ek1cL0Ryp7qfcn6YN
 +907Qz7ldsS40lVRQCM+7JRy7bBmRh4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260048

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sdm630 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: e8e1fb5c703f ("arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index a41ba0da380b..721885455639 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -2483,11 +2483,6 @@ compute-cb@8 {
>  						iommus = <&lpass_smmu 8>;
>  					};
>  
> -					compute-cb@9 {
> -						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <9>;
> -						iommus = <&lpass_smmu 9>;
> -					};

I think 4/5 are secure on LPASS on 630.

Konrad
