Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6394582F3
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718490; cv=none; b=rV2K/3CHUT60uQuXhGj+j1fmSLBMLVD/4A+HuQf6x8TQFdNEnJ4coyK/II2OS53yi4tn+JR3qBqO9EGiz5hYAA7/Chr4s01qx4fy5YGpM3KtLbXOFOdWXokFmpqEI9nNx0D9EkFtNNa86pIQEoHdYwH7Ax8CTuCCvQQdXf41Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718490; c=relaxed/simple;
	bh=QTe92VTed7P60FmFpX0Q5Dd4oLw6vNGPMsslVbNyB60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRTJ5xH/x4tED5RKk0zPVfAx6DhJGMzVbf0g09EUyK2gZ/rOFPXUjn6mvKCC6CfFxrn6Rkdo9vcq05WedfKj6GiTbmfav0yRa9eIjxGoULxejpQSTWIPxDBjNQc3zSiSJccgijMcbM4vggSY+TkNNGPo9iQghq07Swr8E2eAE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f4eEd/ba; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D6vKEC8M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f4eEd/ba";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D6vKEC8M"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EDxEYQ2993680
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/dVGa0Epfwju3+kziPy6JjeCQYvIjk2mCPesl9qfjeA=; b=f4eEd/baj7CPamLi
	uO7qrsSde2i5yZ1haRIgvmVMsVqkxKYzl03CDAOJU4B+ynEtXBhVeM5KwijYjKBF
	4W2YQrZ2KDa7F6Oqvx2Dmb9ZsXsmdttHeyiIWH9CYwLJBogl9120gQalm7fzAgd6
	1Uv+1nL8Sgyz51Z4oD0icIy2Yyw2htmy2UO9w8PblLUopfxX5+J4k1yaNkChwjGV
	dapjMof0K4NCgm/n6mV+jDIzk5l6Yg7ySDL9VEmE4MPRmAM0N7AVb6iMZBfx5lVM
	yFnGxOb/PGqEt8yKT1QjuLToUTyUzsjamrBDQc8Tn2P7uR3w5H1YcroT2o65Bxaz
	cUpOZg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g20sj16ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:41:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso22647835ad.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786718487; x=1787323287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/dVGa0Epfwju3+kziPy6JjeCQYvIjk2mCPesl9qfjeA=;
        b=D6vKEC8MrRpfLwKfVLnVs7B68NkvWLoKOaD52RjV4w1gn0hYwy7YNY8yy8lEfZdK+G
         eK0316Ph4AsS7ZosovH/aJ5Q6mXf+Gf67RkLi5/gJqFTefVrultmNlhwsnVi1HPI98X3
         aMETKv6G1eOuIu7wgiUZEu0WkZHDo7Kmqymp6IkI15FyguTTWagjiFEBigJDtSAe7o+D
         tG5t7/RhVVvo0lSBN4ph3DZSnNuRRqDwcNKYt4l+2Zn08qd/016reAzrNIHXKT9US0xr
         FjMVGVj1vrG818OJdWI2EW/TqEhG5f77NvbQmtzxopopAenDp8zLX+fNu7mqOSghMxZe
         Zt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718487; x=1787323287;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dVGa0Epfwju3+kziPy6JjeCQYvIjk2mCPesl9qfjeA=;
        b=GgFW1D6lI3PAjPe79GKVmiRyYY2HLaxfZ9GADTW21mgxGeH59duQ+6W4vgCb33wjx4
         kTxIZ+Fz1e1hKPSe9hUq0qZHVz2WcCpnt7VCbEMPcr8S0hlKUvFGAevokRJwdOiMAA21
         DY/pNyYrWh7s8kgvS8SGdrYB1fOVl0qdZEb4nMGL2ELoJrj/NVuY1D2lTFZVf1Q+5QHr
         TW8ozdw82iSrjEU4S09HDC3JKyl2667qjz4YZs23lQ9CsZwKhjtNpxZz5NlsQQQzrRel
         9zFUZH9U5Aj+yIV1QJ6LFxZcM79wWB2edKVelwDSAXiCM0hfdrtP4vyABDrOm2mwGkTr
         FcxQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfXNHJzGS0qopejXwDV2v+fAfDcmIyoB0Qc75zpo0IH74Ap2ncLWl10C4KwPxCNGn4iy5ms9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XgKDUb7mJ6zXNLMaeD3YUqCGJm7BWPpzY9J9/v42mppcXqr/
	IDLUeEFgoXxuaskEXoIjdjFK3KspxcyGziQlVarHlnLrcJI2f+gX1Pi6E3zKWjjRvBnryacmDtL
	J1VMxCJ5YYtW8qlwht+pWZU7DxCa5oN4fGpFqmjfhB7ODCkCPbNMs3KHmGIU=
X-Gm-Gg: AR+sD11fJG2ptM7pN24fB2Ww16URtcP2yvLCMMai0Kez/tPam3wuPiMU5kUL5RkuQHp
	EI4wlBvELiOkUTCeHpHdymG59HGXs9av0XeAIZ0oS/nLTfZhTQY6IUKTejRJza52AoH4zZQ+xzS
	NcXsGBwD0e+0UlvAvMhk5eo4fTZfYW1bki4ozZtq2cRap0Qm3S70R5wgdU+SuWKbdICiavQgiRQ
	q28QXXRrR1/7pt0/GyiHxd/d12eauG9ueSPGwvFk9hDDQtqhAOXCYbATCjibupbrNt+dV5BiP2H
	GoaZAOfbNiCIRoQzQ5cHnMpwVAOv6rvmk4sAv3AvbQMXYdSwyX94fkfM+3SedXV65Ag0MNgs+SJ
	GtbpOmNAga53LKwXKN3AuzFTxSr2xOs8q
X-Received: by 2002:a17:903:2384:b0:2cf:c543:2c7e with SMTP id d9443c01a7336-2d3b088651dmr86267535ad.10.1786718486444;
        Fri, 14 Aug 2026 07:41:26 -0700 (PDT)
X-Received: by 2002:a17:903:2384:b0:2cf:c543:2c7e with SMTP id d9443c01a7336-2d3b088651dmr86266655ad.10.1786718485849;
        Fri, 14 Aug 2026 07:41:25 -0700 (PDT)
Received: from [10.206.103.83] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03f9sm5561208eec.19.2026.08.14.07.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 07:41:25 -0700 (PDT)
Message-ID: <67e2f178-125c-4fee-9e56-9c5e31e996ec@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 20:11:19 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: iris: Fix iova allocation from restrict region
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
 <20260812-reserve_iova_in_driver-v1-1-ed62f801275c@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260812-reserve_iova_in_driver-v1-1-ed62f801275c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX3+8mT0Pc1/fr
 X3rZxDdgiDsXqZn8OP+En4PD4Z/bAHk6gfb16s5J1kx8gImDxYaEUQQkqo3RKlx8Z973XyINtkV
 +5tQVsqkqfdXic4WEJ+KmkHr3vKLadYMvDFfvFFZ00/H1t2q1Rx49sIrQFebXtAqL3j4doRw/IM
 WgN0aB4W324T8jalaoetuiJGlu+nYyI8pu5AfhnWzsw7D3ShTwMkMeNTWwFjfiFo2DCTwmKusQ9
 npplOkbTpTBosNa5tmY6Lb0kGmySKAseWEC3kjJ+xd7C/nAm7WPiZ8AtwyDs7vp0HRoe9Fz2js0
 I/wQ9FlpchpLPalS1XsqSKQeEotBjCqKNMJHaMsonih6g4F/5Iit430UB1NBgt+G8kPfIKIrUGF
 gP9VyRT1tfvEOefmgPI4Hv3RCR+08J9yeIFDQ5Dqn1YYbFATChrlgJfvPXnEV2yV/6QUOcbk6Q6
 mfcfzcYblRkSQmY4SMQ==
X-Proofpoint-GUID: J395jaJrk6gMxvVDjDiuTiQNZV_zvXIX
X-Proofpoint-ORIG-GUID: J395jaJrk6gMxvVDjDiuTiQNZV_zvXIX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX3wPybccCTo08
 VkY/GIDOJPIi/7IFuLyznx9QExs/4SkDVXZ4d4JJdUyVUf3zx9nfhw0UzYzfIt3xlTWky67MsBU
 tVeLC2ken1bU8LDtZ8893OpX9Q5m33k=
X-Authority-Analysis: v=2.4 cv=cMTQdFeN c=1 sm=1 tr=0 ts=6a7f2917 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Hj55FqqFgxrcsKo4rRQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140111


On 8/12/2026 4:25 PM, Vishnu Reddy wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>      +-----------------------------------------------------------+
>      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>      | 0x25800000 - 0xe0000000                                   |
>      +-----------------------------------------------------------+
>      | pixel stream addressable range (0 - 3.5 GB)               |
>      | 0x00000000 - 0xe0000000                                   |
>      +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream
> in one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below that
> boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots.
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> A series to reserve the 0-600MB IOVA range via "iommu-addresses" was
> already posted here:
> https://lore.kernel.org/all/20260807-iris_iova_600mb_fix- 
> v1-0-3996f67e33f9@oss.qualcomm.com
> 
> Those changes involve DT binding and DT node changes, and discussion is
> still ongoing on how to handle those for stable and for the upcoming
> sub-node design, with no conclusion reached yet. Thereby a critical reset
> issue is still open.
> 
> This is an alternate solution to fix the unhandled SMMU page fault
> by restricting the IOVA range in the video driver, which also makes it
> easier and faster to land on mainline and stable kernels. At the same
> time the patch only reserves in the IOVA space without allocating
> any physical memory.
> 
> Currently sub-nodes are not yet present, and only a single device is
> available, so the restriction is applied to both non-pixel and pixel
> stream IDs. This makes the solution unoptimal while fixing the issue
> considering all scenarios.
> Once sub-nodes for non-pixel, pixel, and secure streams become available,
> the restriction can be made stream specific.
> 
> Fixes: d7378f84e94e ("media: iris: introduce iris core state management with shared queues")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_core.h  |  6 +++
>   drivers/media/platform/qcom/iris/iris_probe.c | 69 ++++++++++++++++++++++++++-
>   2 files changed, 74 insertions(+), 1 deletion(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
