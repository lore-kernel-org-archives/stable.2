Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008389;
	b=Vk8I8YTuYTlhiQl9/oSvTyhzzfLBfLwZN1y3sjoez4QgfLAh448c7X4EkM0QlW5rnLvZ
	 jCx634802yEYedBkEMZI6EEdj3DcjcPhTgIZciXe2Y9XHsFG3A81awO6Iy/yFS0ss2FZL
	 cD66IupRCO6eLILIJaJ3aOw56TuMgv+/Sla4T+QnM5lTsmRItUQWU2JstK8P+adAugL0z
	 Xp7PfFgTLhEBm4XXDn/AxgnUenJcg/gzqcuCiAOyOBq9XKemd/O1w1xyFfPQpPDtVqkbd
	 BtIIHJ4F8pcJ5kofUxPd/epfgwZbnqF6PvZ1+ju80gqeI11JlleNy6ZcQf9eIMnPwCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008389;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bYy/Jwyeow/fBLZ5IOY3qekzGxtgJZYPejsTaPKV4sQ=;
	b=rNsXeqqDeKrnJpdIcXY8RTdcw3n02WmLo81FzEj2eXDYS5OlR0rAnhZg1BiYrYwbz+C8
	 oxSNtiyfM6ySOUpEHDk8sN2BR1GCG+HtHAx+mDKyYd+X28ctozsuH6sOA/bBjuDS6qarD
	 RdGaD88T5xseygi2YowgisaOpBi2cj8+bmtXXDDpTff4KovVwX0D5PcX8ua959Gz8grcp
	 OF3D1F9jG9Yv87ukUioWZZW0avga/NGknXQpEK2nefRGPQTSJ9cRx4JcJcaiG0DKYSZrc
	 htSqqmcTV6VXx3RniY1vCEpMQ0u3YkJgiPp0PFtkP/+TSXgfDj7WUCxyMt4hjnBE3bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPV8hxT0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drL4hGM0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECF606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECECF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPV8hxT0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=drL4hGM0
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aQ7X3300584
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYy/Jwyeow/fBLZ5IOY3qekzGxtgJZYPejsTaPKV4sQ=; b=JPV8hxT075qsg3T6
	mEcxbfzWO/F+1sHvbdS1G5qtSnMINA9fKtU8iq0N4eX3VManpvgZnx28/OYHsPKj
	0nWtMhPFg9FZDl56IzqTpIhLJI+suaIMFsJTfgyKMoSNkceArzFrt4rkp6DQ7nzR
	hWngJCzomXAwMUOZ1sf09waCCAMS/TnD5lw7+DYp+8X53Sw9s1xyXKIW+WZhRfs+
	xveOSkrSw5FhyipIoD5ksk9iNWegn8G2JnPAH9onQ6PsR5z9XZnmvKaGt5hkt90o
	YXfdculLyMcNh1bPkAGA7A/EMpNfbC88TYpbujRGi/F7XqoXiOIT1Z7MJ0vumpBG
	zxxciA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpstf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:53:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc50fb0d2so44459785a.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793008387; x=1793613187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYy/Jwyeow/fBLZ5IOY3qekzGxtgJZYPejsTaPKV4sQ=;
        b=drL4hGM0+AATbwNTS6Yy4e2F0ActdezJgOYWnit9LaNjxp7DaUBKcHo1k5RRLI0I2P
         xVAO7SwPCoJ5//uVMD3OraXrKsvmliQN1ocQi0bFHMiMc9nK1ZPsQBjeIhQRJiZuZtd6
         zCAcIO9Y+7P8dizmTr4xmuHQ7zBFNE5YZiSdOs2DkBoLIz2jIOpCptzbIJyvNN4oB2mN
         TUN1zEb9j5JLGHQMWbvzt9d2Di2yOoA7CZI+qnoLaH2BL1uSUZcsivm2j3JOh0nQrGiy
         g8lEZVBCsqWqshpG+G8NVQRZcNs2kfrrzmiNrMPZcgYUzR4ZCgv8hgg9d5ucnrp89Sq/
         zmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008387; x=1793613187;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYy/Jwyeow/fBLZ5IOY3qekzGxtgJZYPejsTaPKV4sQ=;
        b=GM2k4VfXgrOVH57JcdtdyuBF85R7BsFWFo5xBYsSQBUvHMZKQb/ZqzFr3V2+CMErtj
         aTh+HXgZ/YIV+evkz18ikVj6fD42gA0DqJpf/fkX0UJZsnASuuL6+JitHWtZydPZaF+7
         DQ1DbBjUgOjrBxX2ITbP8dmneI85WgO1p9DbArfYSQmBdjWh7cN/fLLx4jCnnNWV3paF
         omkMwv6wqIuIfoBvZ9w/9ePr/B7BMqiDUGUD9mpfntgosmF7HqgVXg/Ae0GUr/wfqwX5
         VeskrltIl7kg25wh1ghFAFXpuRSlJWrbXLtBpTfgqeVmhAYP+I/Ed6X3W1T+UPVud7pM
         aTRw==
X-Forwarded-Encrypted: i=1; AKwUvBxi/F3FrJ56ccM/zR7t1DTig0DDUuPoQwcaUbBNCT3I2mI6B16beY6pxopmQLmJwB/pvDXr+z0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzaNvsGQy7BfwYs7bJi1UKQRYzPHeUHAmBsiAvUCshEnjXy/qI
	LNTP6MJ6g/33HX3a6y57NE4tVxdmXGz5LwkJPYGtr9EjTO8H+0sMpT3qw+FNpK7UYbH4NiIHB12
	QYPNzEJ0U6oclsR0m3wsIOqyHtgXq56bbONd7XkCLV7jrzBzQFAvV3YCXVys=
X-Gm-Gg: AYBFou0D5Hcx7lm+Dz+o4G+VR/vWYuRLDPwE8xU1rIcfjNaYv84uhpbZ78jP3QIBSZP
	f/DRn1SXE+MO5H9zB1A+Y74IUgDfJOIwV5ibAorGWmFunMlSK6SzbNbzOCfAlgiQLl5GyMqFD7Y
	nnrsZgFKfoD+DCa2QutWsvNj5Ku6AfbxtBy+RFBkzaa27GPtXMMtDMH3vmhs88l2nMqTxqEXeI3
	/ojJLmV3wK4DiEWkDKoKWtzyZ6ikhuIL0pT6E/xdfwwHt8WrkEsXtFdt9n2q5ul4d30bs3N26jO
	zWcs46AyUCKnXMARQQwD4kOhSi7Iik7fLsNNeu7HdYzVqCi/CWLCKV6sqxigQyTudB5IOumg//b
	BnCAFmMrVuVDuvOyhKs51vg==
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id af79cd13be357-940ef8ec03dmr1010422285a.3.1793008387149;
        Mon, 26 Oct 2026 02:53:07 -0700 (PDT)
X-Received: by 2002:a05:620a:26e4:b0:93e:6d87:4f69 with SMTP id af79cd13be357-940ef8ec03dmr1010419485a.3.1793008386690;
        Mon, 26 Oct 2026 02:53:06 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e89e6sm304007766b.20.2026.10.26.02.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 02:53:05 -0700 (PDT)
Message-ID: <13053ef9-0301-4db1-a9d5-1cdd845866bb@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:53:02 +0100
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
Subject: Re: [PATCH 5/8] drm/msm: Fix sched_prio inversion within a ring
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
 <20261024-assorted-fixes-oct-v1-5-2977f974ddb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-5-2977f974ddb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXxAgjAtvswYKl
 s+dnbAyuIwo4DbQV45ZYdbaEXa0tAIDumoQapfz3skac7/nJR5KnVcj2XRLpzaH5Ns35rW5MH9R
 BHvT3aPQc84/UnYqfJrZLQ5cc3y26c0=
X-Proofpoint-GUID: Kh6luZLRs9vO38fRXuE86bhpHQ-jOs27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXyf+xgzpP7wL4
 L5miCMyMJumesAb80tgWu3qIddLIwRMLhqeND1UzhjipuNcIC8gFs+w0BuMkWbR8BvqAGDHxFmt
 sr9qyyjfwMyi9M6RACNV9yYO03H5ckne4Adl0Dth4x0qoGIIGPl6oeNW6r5/3x9MfYH1oW1ED9B
 Yo4zvshf3W7sML2uCqlKYfJ8h8ioS2PCGHBvUOOawLjBADJcNhHyDXQeK51/JxRdKujXaCYJNZO
 8/DStpKc3sDsmLs+3klEXr9lF2eMesC2sORUO2y+sGaQa5Jhn/UECACMqLvbuQfA/o0kTjzkxdO
 zdcuOQFosA0FaAbhibnxlzLM5gSm3wOk0nSAhmMUvRgZKS35znqm8imZCe2lEX2yZOHZMBBOlJz
 XOD7XHGrDzuq46dC/ZdwKBuJg3D8A9gQ3Drl5TNM5/0vnRaJkMr+O45tAUQPQh3sNr+GbjO6x62
 3X+OUGfPlKgcKNfPl8w==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf2304 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=TPaDMEC0OJE0i2k_fPcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Kh6luZLRs9vO38fRXuE86bhpHQ-jOs27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039

On 10/24/26 12:30 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Commit 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
> reversed the values of each sched priority. But it didn't update
> msm_gpu_convert_priority() to match the new order. This results in
> incorrect sched priorities within a ring.
> 
> To fix this, remove the inversion logic and add an offset of
> DRM_SCHED_PRIORITY_HIGH to keep the range within [HIGH..LOW], reserving
> KERNEL for internal submissions.
> 
> Fixes: 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
