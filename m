Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783285;
	b=TjW9Wk1SUhgLBMqOHfN3+B7ooZw7/hWer3Uph3OQVbh4/rbgPCNlIT1W0W3vkqpJUTmF
	 rTXqIBseg5ksRJb66UXjNkmSrcj9PzYAisdP4O2TNkss0mOwoozMiXKGGy+hqUnYixwI4
	 w0pA+1zTJ5I/R7OqeQsUQ78gB/0Qy6vmjKow0+909F04ZhNTQYmVDYgADFIzqbghxr/1G
	 eWwAgEe2owrzbjUAP00sViiRNovWh/Kzdr+Xs+LT3XEohVAqUCqRwiYwbE4ufRT6geOpb
	 N8fKvv4UF3/DquyUCYKsSlyBsU0W/OOrU5bP/HsAEMfaW02v5W0det4LMaZnKJV7nWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783285;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
	b=h+S1WCtpZlWfaef0LUq0uxluxMQW/ECuG1OnD0fQjxAqHfL47ak5FiVAae5P1aveJZ0j
	 CDpk53lnHGiIEW8HiVb9XPyksD6r31g9AEhLyZYHE2lP68/G6V55V7bkDHUUvQoM4FBZ+
	 icVhkmpXKVV0C2ytpS3GXpm1wSOD5pIVg4VWAPRw31rk59qfGomAvy0WzgatJdhDo2YUs
	 1R0cniI/tM5FJHDCQkv6yCb1O76BU2LASXX4sbJJwbeWBeYc/Pmgj/JBfreoI4yQmzU2N
	 ZDdtoL6ASLsn5IE27cPuOULPgFcuLVtg75ruF7Q/cCZ6ONm8VCDcUcdyx8WpdjnBE6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwtlwXbU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ViQDMJoh;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A260A262F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D31A260A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwtlwXbU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ViQDMJoh
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAsIEc3609921
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=; b=UwtlwXbUzcwW4iI6
	hSK5ad+HFd/+LYW/fiw1EDNV8nDTBBJmMejo3/qPeWqAnAfb/gBvTp020QIvbkWJ
	2VATnaKNOoa8+APXE/rXKdilHmVdEmCCERYpBFi2Btvw5U/G27VHDc3Xcgj9VUP7
	fbI1uj5gyWF0hF2tzOBXTJPCjXyjIcs1PUaNE0R3YJ+hEf1Hg1gzEiFP2prZ/cNx
	xbdDguTT0krxp26OPzDuEeNf4NkOFhjXDf4iGLtrDhv0+jB8j+VoT72k1JLWeSJD
	A+afRBX8eRb0k5++huxb/J9hnFPnrzshqHJnQWVXUdV9u8/OD7Wu3hB3WIkpQKan
	migdWQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73dh9nep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:41:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso12583758eec.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795783279; x=1796388079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
        b=ViQDMJohWOkii98SgMb8tVx4fQ0FB0evAogm5qHkrPol8mKaK/GnYE+eEwxXqLpj/1
         c4PFdBjaVIqHPLxD/6xSTY5ZfLhaPkAhP90B2mlvZXH8liz2m3eMs98nKqRpJpmibv5n
         IZfZaRuDkD+a6rZ0hR0rBCKNR9JYlOdRiVMq+DCfEsryAvQSMBqS9kmbFxNtperSMufq
         S6JTT/V16JQ3FZWS7wZnHN0Ew+2ifCNcLWQ5ZIwg/+CPsl8NgwLZVpVMno0RWSd19meJ
         AEzaXY4cjsE3y5AvdCNqtdtO6E6Gb9azAijwkAmwAPgmhYV20LCxN5kymjmOfcOgeW5X
         wm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783279; x=1796388079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21wwXPUWNXnpO7MEvgC88mCJTsCmkOMu2Rh/aIjZfeA=;
        b=oW7wxXnSKdeOXAmJ9JdRXnAAgJJJCkTt2VoobhhlamRDp7C1jpmCtLB1lYZ+qZAX4N
         Frq58jt95BMYqbKHcsD7iyxyFEqOOKg3JR+ZkiJRLFLTOwFWgC/Wm38HWc1JfcjljpDq
         5ACD+HNMEfmlg7coyB87JsXQwlrDNs8Qhx5QQQZOQLCpZj0ZmYsLzBWMDuxkCHWb0ZrG
         s0L4DchqY4L3aV1K6axkYEuMRCUqIhJIk7X9JMG2iiJoVEZI6dhdtFHfMCNxGqlr2X8Z
         GRmm6uNdvj/ibtyUegH9QO7bxrCSMfMBuahWFMXdSNskdDyX/ZTdtwB94vJmp4myML0F
         DuAA==
X-Forwarded-Encrypted: i=1; AL+hErGGeAAQ/5ZdNdLjFcnUToqDNCuUC9Zedo8Y2IFrx450NxMtkfKUuQayW6jubrZ/LusMFXUBt7c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qs7Lw6YXA3RnosmrcxjmaanYLmP6t6ltup8ldEahibWsHPpql
	zN9/a7cKj68HB4foEGGR3mxO8Ji1O/Vb7Bnb9KRu3CIWF6UKC5s4hH+oxrCbbg7ZjdOxAcDJmHE
	3UdIextHBkfHAEbnE/5zdjnmbNheVs9/67Qfba7LQVioRlUWj0pGnvcIjbWw=
X-Gm-Gg: AZFdTZdeO5thPWLghibuzrooYGYw/8P8wZlXUdaE5eejGWnn+Cz6d1pVCihf50pU3l9
	iAe7CeqoRzmGOcPdBQDLCSppNIBLGSI+PltaQdZiiLIruFcmhjaQ9FVlKwE/XTxc2Yt9s+Dlea0
	x4bVpOvWV7cs85fVWMQMR5Zb7EYIjaJOBNi/rYeenB9rTWzUhkl00NVGGilv55KGERW25ZXPv/d
	xvjUaunlGAB+7FQlfJd1z8qXzdL6yAy0ZrQPhk31Dvxr3o10F0RaNFqvWizxIp4jZp/y8wSsPui
	oARVUy2XwVV7hZ5cOaQvIqs7r1z3Xnd/TExrr77x2Ihz1DXpOgzcRz4yAvWNIGHBgpAg86qsbdj
	25f+ShyMvpNTGC78Sv31XGNa6GkAVlUoj9u4PpzfGtwrwdzg3bdFH1mqi3ooGwqNuipsb+B/jE2
	oQzHb4IA==
X-Received: by 2002:a05:7301:160c:b0:382:c1cf:163b with SMTP id 5a478bee46e88-38571419d38mr22800252eec.32.1795783278658;
        Fri, 27 Nov 2026 04:41:18 -0800 (PST)
X-Received: by 2002:a05:7301:160c:b0:382:c1cf:163b with SMTP id 5a478bee46e88-38571419d38mr22800239eec.32.1795783278184;
        Fri, 27 Nov 2026 04:41:18 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm82044382eec.26.2026.11.27.04.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:41:17 -0800 (PST)
Message-ID: <fdc9fdd9-1b76-440f-94d6-c6c982884878@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:11:09 +0530
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
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sibi Sankar
 <sibi.sankar@oss.qualcomm.com>,
        Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
        Alex Williamson <alex@shazbot.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261127115849.2780625-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX76HFmI4c8QaB
 ekJ7XkmPS4LlNWZr1fMnq6vXA66rgl5sXULk9NZDjl2nfpGThERUowI2N+w8PwXRr4sV2GS8osv
 Q+nuW9YLlqR/ftcywDf6Kg3xYVyiYAIbRMW77Mo7QU4nAFAJvf+vBNLZpmU6/0+DN0M++htA6RM
 nYY7hIEne5zL41ohKN82CyPTChJEtAQ3mtp3exi4EQIkKR9DGbknfYStJdaWYhz0LpMfjCeoU7H
 scoQwclzQz2Y6zXJ07fZ/yeTvzr5k/Iis5K2f4mha+esh/hcNWHUqPX7MEGIScpIoGSRAedwEpW
 x49XH3mEqdeQnz9MWB1Skg2IwnRkDsm7rMVLkcNn5Cw3/SY60sGYGA2pS52McJuwNysUXP8nc+9
 bwV9D0+mgYd7fQoIONKzdNdYMlKct0fUOCVtSBz3G+x/G0d5hC6QeoxxstgjzOaOepnxzT362h4
 UMZtDLafpx/ytjn6YKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX6qXBIT2bNO78
 QgwHkSn2vpeuGbU8GZ89lr5pyotzWj26shocZx6wCjVy+vYPtFVieikgbECRWjPSrxWuxMOSthM
 ovogciLN3S+BDsHvaQaZekJD+V1r0VA=
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6b097a6f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=umoC_DmSGuEwgYlhGCYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 8uF_1A9s3X7Mr3NZyrdrqdez0lK2tlrV
X-Proofpoint-ORIG-GUID: 8uF_1A9s3X7Mr3NZyrdrqdez0lK2tlrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270050


On 11/27/2026 5:28 PM, Marek Szyprowski wrote:
> The IOVA reservation code compares dma_iova_state::__size directly with
> the requested chunk size. __size is internal to the DMA IOVA API and may
> carry flags in its upper bits, so use the dma_iova_size() accessor
> instead.
> 
> Fixes: 953439251b59 ("media: venus: Fix iova allocation from restrict region")
> Cc:stable@vger.kernel.org # v7.4+
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> ---
>   drivers/media/platform/qcom/venus/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

