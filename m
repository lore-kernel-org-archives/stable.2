Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783115;
	b=LiubJ2wPBe8YIsXBgMnuogCGV2mgbyhngzR+IpQtDcE/S661ysbjnQcek0/zFuhMKBfn
	 9UUTOcKgw9cR+ewDq3traaqHo5z3tyKidFtDssJ5hCdiu0zFsS2YLGkmw8JjiI6kc/sCG
	 j1WkisRnq4vCZVhIMa6KfgByjz0BwtAzMGCO8S+7AZQchiQJPsGxKVV9KK7Ak+UV1xv4I
	 bfuKqqZbjw2wbZ/8ykRn8Kyasdcn2Y0WSfJOF/LDqh+Y+VYg+20bgY4ktS0AtG0TYr5/a
	 dZ1SqCauL6UC5jD3bbNXn39KQVHrOk91hoWjcbPxLea+WhI8ysynxSrZFV+Qwu3rS/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783115;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XMa2kCzEW/leD9xf1rjAeGaC0mopa8BovnBv42DRtl0=;
	b=LYwalOsNip/psH91LkmOpC5hy0dRV5+QBArddJ3N3J+9kfl41hwa0HbuHTU36JRqUkXk
	 LwOzLjodkHyPsksDd/vtisNRhr2rU3Cr9lw56JYzEVUZyBMrvgChaeItvXm3VF1xWGz1d
	 1Ufy0+guqHiIIQXbqOrK9f/vkaZHKvSfwVEW9FHM5UwoSgd7V3K/IZnXSReUkRPMRcqQa
	 U413DYKSJ2BQpWlwLuZGjQ3S7EVP7j+3LapCdeGrA3ucbZDvrbZvKem8hJkqhBqicQ/m0
	 fPooFHkE/a7tX8zNY3vX6NE5i5xjVem2mFgcj2Z2LWOZVodP1e6DT9FYbxNMMZmgtjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OsVD7nYe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K7oTcFTg;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B45606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93B45606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OsVD7nYe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K7oTcFTg
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAp8ou1376852
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XMa2kCzEW/leD9xf1rjAeGaC0mopa8BovnBv42DRtl0=; b=OsVD7nYemQhekW+f
	MgqDMfW6xtVAqohPNaln/mjk0f598jSdZ3jjOLaW912eROmGX8PQz5nJXPGZey9w
	l5B3qubGjlPmYQrNzOwF1gbwa0casEQjd+DYCODHkpz7FLDqX+DDcrDdtOnUzFxF
	inYM9cv391V7CHSyJxl1nJrmwADZiR6SPcgVXAybDl0MAy5xmObe5I2eOeplFNsd
	m9WM8zkFpJoG8GzwTPd4w5gs84DQPJraEqYP0QiGWnCtIbyhP25NykOV1KlinxsI
	gVGCqMquxW4xtaH8eB7Ky8HP+4w2zOSXjuPlLavcdkkqhM+xv7X8SgzV9GLGnzIn
	+ym14w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru3ahrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:38:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3846d5f54c1so8863192eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795783113; x=1796387913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMa2kCzEW/leD9xf1rjAeGaC0mopa8BovnBv42DRtl0=;
        b=K7oTcFTgsrOKKNvyzFPX6UYCSKWWB7QEPTfnuYn7drrq9d5q6TNIwZ905xZrumFLD3
         yhANAtknJcKw5/SPwfIoAXJVtUoyasynNDMNXa2bOiO9vFHFcLZYZj6Oh6lZxOVjprpl
         R/DyvJDAn2D2KntHlj/dSjwZ1LYGZjTxcxI6XQQ0KH34Xu0L/LJzBYhqFDmtalqWOd7o
         wFIMYlQqXFiJ/8tZxVUZPeB/Bi6ZBtW1hwK3bTAsIvj8K1CI5GbEVZ4n0FzUsWjURBZK
         lc8VNtOA89TDj9YVWM4Ga0EnB58z9C2xn/ZLb6g1gJU4kfNjnf8jje67siyPoU1MsgfK
         zfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783113; x=1796387913;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMa2kCzEW/leD9xf1rjAeGaC0mopa8BovnBv42DRtl0=;
        b=lHkNlmI6WPsHGRx4pUhsZzvvOPXNJgQ5BlbfdFZoKMiZF9UjeDOUqCqGuMHV46kurP
         5aSRwBIAAnqmO+rx7eyhhFvv5gQ1jKnQIM2ENbzO9NEXDbGFTTPNavwKCFbJBKmJO7lK
         hZPv7p+ccYXCcdxuXGXCFwQ0Gt2pLOQ/Tn0hjjBVJTjPJQM5wS1xtxFJpvv5EVLM+tY5
         4dtSmo07fLpFuaadLGFmiGXJTPu3QRy2mjmTWhaoR1B9JD30c7GiB5ylTuF31xHZWXCp
         DaNEi1zWIPs9475+TX+fTQ6t1QwexCgpmZqx5E6YR91W8mnKP/4CQAQOMLlWeqYCClNb
         hWYg==
X-Forwarded-Encrypted: i=1; AL+hErE5PCGCsOpp86AVK/UNVUh0u/NCB1r1n0WsuDKpiJM49YLzmsFSuMt2TEFc9zp2T/HrajC3YzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TNDnG42s97zzfSguLo735/sCJIzJWP7PzlmpXl1vP5plj4gF2
	CHPpR5OzQnpjQ15Qs+mpAnk1ULVnJEp3S+gHVzgUYGpWFYw3aRJQ2pm3Ziuxlinc07Pvx4Os6zp
	THsT7prBsyPS9XRjSpyCLQykdRyLOHn69ctjaTxQ/1YBZTIoiSEaIy552e2U=
X-Gm-Gg: AZFdTZeURhpLlyskIakPmoD4O0E8Z10PHLoGyV4j1+ISNlslpLARhovFI41fUU4xMh9
	f2D0sn90hExs82HdjU59bp3OjcKyk1t3le+bWxVeOwWL/v6gjVTNzKFR1MTKSWSwCUQXA2DeL/o
	36MnuYsqN/+dmIxK4HIhYFDnKx3n+sR8QQA4uu/zHMchM4RxHW7JmzZSZVjlGGcbFFmpnhIcwm+
	Tq83YjC06TMhsWQvURwBtFcgxikXWUB1CtXXXjfuoloClcuB5UXBZfEm4v6+QEIrDCiac41NaBI
	xjDoves3ei0OC6dRE6wbQQ598PWn1pYq8H11KIidLZr14/ULcOxiUPzuhCIyzzOXpaTkOL5DSFM
	V2pvxgxuXCZeK5zhHQsT4UqxyQpSMHcv7wyjpuu/427dx46G59jRwVcyq7eidyECxm5YzT69piE
	iHxSFM
X-Received: by 2002:a05:7300:89:b0:386:c880:19b1 with SMTP id 5a478bee46e88-386c880248emr9901029eec.10.1795783112946;
        Fri, 27 Nov 2026 04:38:32 -0800 (PST)
X-Received: by 2002:a05:7300:89:b0:386:c880:19b1 with SMTP id 5a478bee46e88-386c880248emr9901006eec.10.1795783112393;
        Fri, 27 Nov 2026 04:38:32 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm88060568eec.10.2026.11.27.04.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:38:31 -0800 (PST)
Message-ID: <ffdfe000-fff5-4498-a4d9-1de2e0f23707@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:08:25 +0530
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
Subject: Re: [PATCH] Revert "media: iris: reject open() when the session limit
 is reached"
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261031-fix_v4l2_compliance_unlimited_opens-v1-1-f20cc9231ee3@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261031-fix_v4l2_compliance_unlimited_opens-v1-1-f20cc9231ee3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b0979c9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7GKYziPKAAAA:20 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GeMy74hU6CVubCBKRZ8A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: WVkgeuQAxlvLB2RQ7BLEc__C1UosmXuy
X-Proofpoint-ORIG-GUID: WVkgeuQAxlvLB2RQ7BLEc__C1UosmXuy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX1SoFWBfIUbRW
 1pQKc/yrt3JoGxyo6nG/7Wgju0oz2WMSE4+5ekxIMoHBMDTGaA2LPS+IhneXDi/qUpjCBwg3aJf
 trcQJyHJOBex62jOQkuRcyuEYtNrNC/4JRloHsZqpBCQ9aY3jGtJ9Y/hUUAy7ZrYezcyYwwCPyx
 ZbvrqggFyYcByypNttvqfkz1JgHAq1bOvq+yWAW7aL4W4PKokOpULz8wIyfxbbg10aV8xDUIhqM
 Y35tWvb+V0Zl0MId2+3O85M0LAK2RYq2B6egrer1+59aOcqLG9ar0WN178Ttaqd+7RFoBUdHWbw
 LOFA6aFADnrxiopdlSqPSpAuE65T+spBMPck675X6syN3QWGIVXgls1hNTR+0S3G+BpwC35KCdi
 c51YrAdkqEOsAO0djWK9cIY/ibeXMCkqklniHjqxSNVXEP4xjf/5dJe1AQIDBZfhWhYD+/L54dm
 JNeX8iMJhf/Ob9cFyaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfXwLCc+uNmqUuj
 EBCstuOwtlpnIpjHUdZEfg/wH+hhOjobZ6AYuSEufTqjdu3zjcEpjhD9yse+LwXF/rOtfb9smSJ
 DVtXLuqFmpeBWXHoBGS0stbei5dWLWU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270050



On 10/31/2026 1:45 AM, Vishnu Reddy wrote:
> This reverts commit 397ebadcbc21 ("media: iris: reject open() when the
> session limit is reached").
> 
> V4L2 does not allow drivers to impose artificial limits on open().
> Resource limits must be enforced where the resource is actually
> consumed. v4l2-compliance verifies this through testUnlimitedOpens()
> and now fails with:
> 
>    fail: v4l2-compliance.cpp(773): !ok
>          test for unlimited opens: FAIL
> 
> Link:https://github.com/gjasny/v4l-utils/blob/master/utils/v4l2-compliance/ 
> v4l2-compliance.cpp#L747
> 
> The session limit is already enforced at the right place. An instance
> that did not fit within max_session_count is not added to
> core->instances, and iris_check_session_supported() rejects it with an
> error from iris_vb2_queue_setup() and from iris_vb2_start_streaming(),
> which is when a firmware session is really needed. Failing open() adds
> nothing over that and breaks the compliance requirement.
> 
> Fixes: 397ebadcbc21 ("media: iris: reject open() when the session limit is reached")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vidc.c | 19 ++++++-------------
>   1 file changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
