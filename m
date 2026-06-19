Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5D324B2D
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844611; cv=none; b=CDVPykmtDIxM68LphcLG9nWomMvcJ2eQd31JVHYEO16hKacjl2i4211h9+KlVg0L7j3tpMhXptyoYBejoxc2WKI2glqUEFFd6UCY14vaMDGVGBojZHeZxRXhUAHNg1QWORbSitIxFzD9NchMiMgaaVff1w0aAlw0nhdJkoqcTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844611; c=relaxed/simple;
	bh=YugYfAkvOMN7Lu3THxpICZ57NxTRL0Hv3NO1YWbWb28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYNJoLxVmXLZF/Hhxf9Zxn4jfcYqJCD1WYWCTQ8BiVmrmFa2Hjc7eVszuik/0CdnWjrBT2TTGMgjUxZjCGv9CQF/NtVL0k8Zk3hu3fQz3fP68JEbQP1y33qpkk5R6aYiwm2WSADv5K9V5QEHnE+fXot01dEL1w9rTOOa0DX/UMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mHaACCYD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hw+UcH5d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mHaACCYD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hw+UcH5d"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J2sdj03130212
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mRq4CDm5HHOyBzLGqHqksbLK1NWzm5I/iyJtd/2glTg=; b=mHaACCYD5ykn3FeL
	7szb1xWAhO1lDBfEK8JCyP4kY+aKDslkUvWniUWW1l+xNkmBfHu4m+j3K0wYZM/w
	uXZtWrONAEhqHJiI4gxirhUerDSSaBSRoFBkyPOX+eMIT1w8rSrpT3skdW3OdwbL
	Syr88hlMK9lBBOkxd4cY/MYfpfGFUNBJkWeV8rRtXLe1n+Dx36OySHGrVDjuU9Gg
	ZJTZ2rUUl6Ied7YNTS3/j5bwaRJRYKxHzuvFTF19/6/4v2rKophkxsTEKPHGewb8
	ugdZRSVj07CjZ2eeThNM7ulVgfwF1gy9iCtVCLXM9lu4wX3itoof7iIpPmF9My2y
	dQUv8w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp671uxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:50:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8422ca754d8so1267996b3a.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781844609; x=1782449409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRq4CDm5HHOyBzLGqHqksbLK1NWzm5I/iyJtd/2glTg=;
        b=hw+UcH5dI5hinUNM0IA02FjGLQGz7W94U7hjxZnt9e8/ag5PNIOGJiS2R232EREkIA
         Xy+CYCvkd623uzK2SoHYqC+9m2aPOtlXvRVSvrbRTDrjRH+Lofm1qTIQ+BlFf3uPvmac
         LoinnJrqhC+DKq7oUAR7GEw05FLbgRVaWsQ77mAKZbqmP+0BMGGKeyq1an9BbZy8pMSt
         EhnGKNJ9Dq8Yc7RLjUCvyUAB5KBjOwAKEUvoAip/2sENuJxIFmrk9s2TWsfojlPYrpIU
         b/AWeW/N790qhY7WA2v2f7BDJn/izZViGj53+kZ5VLnmLtPfpH1/8LqvPE3lc32qzT9d
         Uj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844609; x=1782449409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRq4CDm5HHOyBzLGqHqksbLK1NWzm5I/iyJtd/2glTg=;
        b=l38+veIyQR7cRXbpH1s+F1OugSWm1z3l2xrHUET3eD/vH8c6mdMxI9H2lOaUC8j/n/
         zwe2G5r1kFsbIy6j7u5BzPJzIkTLt3A1Fl6s9uL9zrZXq8wuJW4Q0OIVUDWJ7TJ6t5y8
         wUUhXphjdRGhy8PlhzqeRP33iLOlIX9GnWxvLgVx16+Uy2GDfhg/TwdZ9G7tCPM2DmuN
         W7zVLnz30zIqlpd21FuuI7haj53VoIh+FnL/GzxaWnuW3BjBvsiPn3QqmTLplbD5J2r6
         53awJEy8ugTKg8sZ9MiDViY0SIq6PsAkoytH7IqFa8M7+QCzbrXXqSMyCaEcBYvvpbJi
         /bhA==
X-Forwarded-Encrypted: i=1; AFNElJ8NDOULxL2qDpNjHgnkUjeqBG3DBbTKJMV57dOBqwPBWVdxQx4wtvvVLzqBhsNWBhyCAegUZ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtrs0MbeBkg+Vv0FVUYDILIIMqw65L9KaV8NQa5HhxZTWHLVb
	TLTmJhNeqFS+6+NdqNzLMJd60ctYYujAf/xFYRiOUZv1xTSOiHsBp9lQ/kwZBy86Sj1KVu1WqLu
	WSG5Z235HpXAOcC+F4NdxgzL5kOA9clY9aLmlEV+NMb5AG7QUStDY4iVVHWMFNIb9rPs=
X-Gm-Gg: AfdE7ckrMSQg0QoEk66RQ/2wsJ7Ipc8SCMt6KKWXQdQ9h9nYCw+Rgiskhm3jxXbBXSA
	0ZVw+bst8KS/99tMRHzhWV9g+dY5EgMLNxWthjcrfN9l/AeqXBA+A9UKNXYsV2xq1mezMI8Tf7+
	lepzeb1tPSXL7U9PK0S3+70bOd6MHAiw/wdR1YWHGPvl8+d1Ql4CmskhlQWh2J6sxgxHq/9I4qr
	UeVRbouwhfcdHioGTpoJonoFn/J4VbVCJ3dJKemU+QwH5KmepXmDZplAjZml/0k4wqHYOmyVljh
	ZqHCNWXam9d1nLoKFs6E62trGSkeR4LOHJ5oNH6HC4/GEFbBRXeRDVqNGR3PAStg7brSkY+svrp
	2+RF22BSM+ZAUGxdaaKcZ29/EiFkeFklC+duwEiuH
X-Received: by 2002:a05:6a00:14d3:b0:835:4291:6975 with SMTP id d2e1a72fcca58-845508cce6amr2238497b3a.39.1781844609259;
        Thu, 18 Jun 2026 21:50:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:14d3:b0:835:4291:6975 with SMTP id d2e1a72fcca58-845508cce6amr2238466b3a.39.1781844608791;
        Thu, 18 Jun 2026 21:50:08 -0700 (PDT)
Received: from [10.218.19.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455364cbbasm901324b3a.1.2026.06.18.21.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 21:50:08 -0700 (PDT)
Message-ID: <a7393eb9-4e5a-4795-b499-761eff129291@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 10:20:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] crypto: qce - Fix crypto self-test failures
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org
References: <20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R3H0OmNAYWs5GKWWZijiBuVxkfsSbwJQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA0MSBTYWx0ZWRfX+Crq/X0Z+nP2
 CLHvHuIF35w0hNiL+jYejh5PClm03rRWC/66UL73TkF3USvddwKEqrBpSQHaPSNXxdBDkVfm/qX
 2qa0PIqbsYTlplPXvSO9Jaf5riYvxNKsrGtR9DFvefCJ0Ur6lyin4yHsxBbCZnF7R2QVy1DcMS/
 NpXWsB68uvO5mY8HhIYYIs8+CtRl+aM0dKXCQ6mDEtvB7v7Oz6OOPVxmQ3sX9tggrSwpAjXOWzR
 0MyZWeK9SEPoIA1pvkiMNJivXtrhg58/eaiG3yMMqenNJ0iLVRmfcClbNnlct7Ld2+IFqADVPmH
 ZK6QqfO56RqiQdawJ3eKu6OUYLlbuA9T03LUyfp8jHS+LQ8B3mFELkNa1OkVyoD7dXdeYBjZyPw
 oYxsvXizhGdacNxL9S4sVFIBxYUqdMuoAJqVPFxb2dsTmT3ED8mM6lNww5ofTWJoomRSZn4Dgpu
 sbYHvbEIWx6bhP+1rPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA0MSBTYWx0ZWRfX7lOnRJhS2Oqt
 8WgK+AgDmiglzIoqvuI4pI/b0KTD++6abBDWKJZ3boBCe5nZxf+O/STHB7+T3u2CXTYoXe4eNHb
 LgCdgxtaKNO/derY5O3aEN9SIm11OVM=
X-Proofpoint-GUID: R3H0OmNAYWs5GKWWZijiBuVxkfsSbwJQ
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a34ca81 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=8rAcuamgrkKAINotf34A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190041

On 17-06-2026 21:19, Bartosz Golaszewski wrote:
> This extends the initial submission from Kuldeep.
> 
> The QCE hardware crypto engine has several limitations that cause it to
> produce incorrect results or stall on certain inputs. This series fixes
> several bugs and adds workaround allowing the deiver to pass crypto
> self-tests.
> 
> The failures addressed are:
> 
> - HMAC self-test failures for empty messages
> - AES-XTS returning success on zero-length input (should be -EINVAL)
> - AES-CTR: partial final block causes the engine to stall, output IV
>   derivation was incorrect
> - AES-XTS with key1 == key2 is not supported by the CE
> - AES-CCM: partial final block and fragmented payload both stall the
>   engine
> 
> All fixes were tested on an SM8650 QRD board with
> CONFIG_CRYPTO_SELFTESTS=y and CONFIG_CRYPTO_SELFTESTS_FULL=y.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Tested on sm8750-mtp and qcs6490-rb3gen2 with no issues or stack traces.

For entire series,
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

-- 
Regards
Kuldeep

