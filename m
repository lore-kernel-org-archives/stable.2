Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9425012AD
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059147; cv=none; b=WNdHRF1/jqGE47FSftL9ZE/2Hn8iO+bGGbVRYJFjyxJgg+yuYy1uKH6nZHspPoe2jhlbyz9mF4bYHnmh13L7XB+torkmVPmVn4M2tqLzYbGl18QyQeh4MX/4ETWiEDZXvP+Q9cnonZYLztnScqKTzzXgMnYoabzoQUXvubBU2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059147; c=relaxed/simple;
	bh=q0Dm8N6179ZavdtMJN65nS5aknxXYjzZDwiWAsbOQwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJuMN4Q/pMGpoNpooEpO+a+b3Bv+m3rFpEvXvizTSCSXE7Ni0l9ePxnTZq1DEwdsOkOJieqwwsQ1Cbw61fMlVpPHXzAKXd65etX+RRxqUpb6jPHnvCzvGIdq5CJkXWM7WeoMsiLCEH70TWpIizA9CyteigebCb0GHh1y0sv8cTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S64fWGTZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcG0ibSJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S64fWGTZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcG0ibSJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jSr62662667
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q0Dm8N6179ZavdtMJN65nS5aknxXYjzZDwiWAsbOQwI=; b=S64fWGTZhKkuUcdF
	l55dEcT7II9eUe9EARbFSFHRFhqii+pPfEOQ1OLKXQ6zBEiZfdwAIHUxsUecpYIf
	ujgGbvusM34UgNNOztN5xoYpBC5SpDhqQ8weyaMmoZznPGafbn/EvFrdWRA4gH47
	lTz39aCbJ5j5Sljy1GJ+O3V23UR3i7JnK6SBFymVlDyuhbfHoqAIcgf3gYmFCPIM
	rMTxMrwv1G+oJDKQD/XmbVfXJWnmKmj2XyBgAqNJsEc4gYi06jvmJTv6lmhWImee
	H6FyRNbyz9USEpAIOlquAX9dTi0IDhwD2XCDmGXvVFrMHZuA912ohYN8SZz381F7
	II0wTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda1fxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:12:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ea8a9cfe6so89080285a.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792059144; x=1792663944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0Dm8N6179ZavdtMJN65nS5aknxXYjzZDwiWAsbOQwI=;
        b=UcG0ibSJCLc8w4Radz2Z8glSkrf+BSKWh/P6wCN0Xk0PuSAqAH5Vv+ocUzFqpPW9bF
         bzn2TmBZ3F/8Q2+o+AguEj4or9vk+Qg/mJ3V9SoBgBUWJuQsMOWbgJTex+cTxw+KKZtC
         FLX5zbm5asV8rz0q1rvLbOu8ChmLdxv65qtvYRKgmYJHaYV3i8r/ElmusJP/rB1sg0FG
         sl216ei2PKZCV+viGOePzmTRcj1FzTFp4RVyHdXiFZkKF9RdS+r7RP3KHPCxXGSglNxN
         rNBbVjM0CrPBwCxj0VXO7bWKStuq+jXoEO7UzmVmXr3+y3+ANergFkNvn1tbksoVdmyB
         FjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792059144; x=1792663944;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0Dm8N6179ZavdtMJN65nS5aknxXYjzZDwiWAsbOQwI=;
        b=Rv2pH8/c7GKVoOI1ZBWC+Bn6S+RHlOz9vzohJ2bPfUaIipt7YMtt0ZXLwRvpJJ1bYU
         IlbDIohyDYFsx4J5AVPQdACi/6N3pjC+goLbUy37nKZWYqQO7wFtR3wiXXOITqJmGqRb
         mFxmq38SByjZ2W+h+hCsAxBOOJAvZtt0gMuGFdN2ZVJvn6KFJvN4Z2R8WO4ArXJiVJ6O
         njlIbYzxvg3mfZOCZtcQBjiLkBhIh8AdzXly7QmTtufV1BCORt+uLyxPERVHW0NnxXoZ
         bfVpyox9gtcIoXQC+WQxSAZ504Uw/esxj1bIIyhYnMXkgLWFABn63IF3rS2JWLaJHBh3
         SU6g==
X-Forwarded-Encrypted: i=1; AKwUvBySE7NTH/XOQndPmswpv6cGPMJSOBrKIrJHOs8PU+KtnhJ3SMnHIslauknzLd0Bs/i6jzdMfhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+CurNhMGrI8iFHpZLfII4i0IqZp6jIkCumFtjouEN9bn9nha6
	hp3Y0N7h4Fv4juvwlgAJOcKW0k5A07YjHWG554RU6pcZErswciiuDtD0Kp5BuVRg/A0dlI6fico
	Ai3HLiyF9Y8Ug4rS8X5lbkZYCIB+9dM80fepm3M+/vMdK/WFpATcTM76/VK0=
X-Gm-Gg: AYBFou2jRiBn/FOfUZU6fdIYWLYmk735z8g5ijhi79XuJ37i7RDKa9xieGLZ8JDSNJX
	4n/n7jDoxMLkxrDGrfnBUucGFoVowday8/E1wV3rTEhL//YHfsotaegkJm/PerWqrt4GuYI9zCd
	GLoxPDI/A255FtA66L2Fx/h33QWxfXNJFy7WVpa5kNAXsVun8a81BGn+qPex6iyRq5pkJHgGb7y
	ProMKksR6xxNY1UjSBC3b8OFXuTD0HvLL5mPO16r0Ducub+S3giF1PIeMki2zyh8JD0lQ9CDRiF
	XN9i8JhGIqg0nY14I72dcCW6fpDkvPQgRza3umtP7+QvcJu4MaiBZeyMSEktCVkfhJ3e2iZg1cc
	B18dbLdm4FBnmLL42vWtJ2w==
X-Received: by 2002:a05:620a:390c:b0:93f:a34:d9fa with SMTP id af79cd13be357-93f0a34dd2bmr693426885a.1.1792059143974;
        Thu, 15 Oct 2026 03:12:23 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:93f:a34:d9fa with SMTP id af79cd13be357-93f0a34dd2bmr693423485a.1.1792059143491;
        Thu, 15 Oct 2026 03:12:23 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963e0dbsm105680366b.23.2026.10.15.03.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 03:12:21 -0700 (PDT)
Message-ID: <8a31549e-63f5-45ab-9dfb-59ef49cefe5b@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:12:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] remoteproc: qcom: pas: Decide early_boot attach at
 probe time
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20261015013827.716465-1-shengchao.guo@oss.qualcomm.com>
 <20261015013827.716465-2-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015013827.716465-2-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfXx65bQOF136nm
 3R3IN1WW5PmcSr1hA1vPUsGSKI8d+8vzjXOJNWi/hY1jC5efQwS8GdI/fctBUk4yN9V1mz05XMv
 zi65e0oSAq9NYxxo4szQ1h2VYTGAtMY=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad0a708 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KhYryj7Us4LvWG6v_dsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: o-DFWnT9WbbBGLe6zRrOgj7hsfsdZ_DQ
X-Proofpoint-ORIG-GUID: o-DFWnT9WbbBGLe6zRrOgj7hsfsdZ_DQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MCBTYWx0ZWRfX+T25KGecDFLn
 XqwXpEgq2iI1J60sYFJE6h3fZvDbtEZ7zYubG6svsDMumM+x592Yvzx3KJLS/8LU4wTHauJbpkU
 XOJYWO+UJI3M/T4h6Qpd3Jnwthzvhs4GL4wNxKym1qeuj+etJAkrorMFGIfzMuE+oeIW7EmJRVl
 uD6hKq+tTEH4bHt/28WyNFaLSIkYYubyxMnCoyTyiMsleqBWWdWMUw3VtiLSoDLQZVRUk0MYF7C
 TPYNJG+42mJWJdMvnYXCtyQcq7+du6UHNa+cSG6Td8S9MRDGVsXF4IoYaE7dDXDPmVzaYPbjlCj
 UKxLS4MWj3kTwXSopHNQEHvehEPZTsLZL4/3aDl9e1SiDkB5PY9Z/DxTl5HlykAKVJRPTLH4DdS
 /KePEvkw6mXGa86dLgtGvf9GfV0ysZskx+cPbTPCYZ3Ehk2MNOSq1Wr1YAVBQi39J2wYjV6SEqx
 Q7Jg6vnfVbXcVnHMj1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150040

On 10/15/26 3:38 AM, Shawn Guo wrote:
> For early_boot subsystems, probe unconditionally marks the rproc
> RPROC_DETACHED and qcom_pas_attach() discovers from SMP2P whether the
> bootloader actually started the remote. If it did not, attach sets the
> state back to RPROC_OFFLINE and fails, expecting the core to boot the
> firmware instead. The core does not do that: rproc_boot() treats the
> attach failure as fatal and the remote is never started.

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
