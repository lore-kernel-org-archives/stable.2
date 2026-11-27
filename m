Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787930;
	b=zvgyi6dfMcC14t8mjf0WjT8e0qDpXLexZLxZ4i96sBxBPpfyJT8FE0ZRADBK4u23CuKI
	 KvoP9k4xsKAGwSjv0mJhvaofu0QBqmPu2DiWvdl5hEwtesdh96r2Jxn+OcilMnwAc4003
	 kdyeDQo4mT+miMGK7LD0vReVxli/A1qlvcIz+7InCBps9fjVIa/iJ+25mINwjba/u0lbU
	 5IWg3Hh4kPQXd3AOFcsZiYDCk0vvYn1yaUZ5MekSlDoZfphCxmjGmCYb4vzVZgmH679Pw
	 ni+xtKFZMX4D9ReTCxOpT+DplL8l9Hty25OP8ODlhs6AXd2nLjT1ZgngqLSkrDjHWhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787930;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cK0hfsO6LY84HqJrabEhSmxltsurGZr9GeMKtUMsBls=;
	b=kQ1wS6yXXVWVTe/gbBeSk2sZA3dykPeeIiJVRb2YjWuQuznRfdOKaqhse7fHOzuaribY
	 DABP2+kpAKk6TYqLYaKiPFKEKnIDmGL4yc+0vUyidmOq0szRfiLux0M2JJSlerGj+XLXm
	 tEiC0/IR5PLD8anpmHllApdZ1Ag0T6OkPkCAD7pcrsDlFbjHcoOEXIqZVX2CcGhejWVg3
	 ZeUNDCpSFUTcUoxvwk+2FQvKJl0Jgmv/MNGd5bagifomiMKzOV6DKoChbASs/nOuEg68x
	 IZGbvRK4oUuLuxxjuc2/LdZzOqAR96mPvSl01G52hj33PqQ+F98udy+49mVU1ozhq6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n8ppqP6k;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PLqO8wee;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE5606A690
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCFE5606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n8ppqP6k;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PLqO8wee
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARDuQjr2086987
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cK0hfsO6LY84HqJrabEhSmxltsurGZr9GeMKtUMsBls=; b=n8ppqP6kYFQ9GmjE
	EbsyxBbCL21dST0etq4DY4NcfHA4a8YCKJJwFEkaYOUHeb/lJEcoeaa0Ezq7K+Gv
	KPaSWVPrkNYsFJX626QQA2idA1UzBdFOI7UFW2YsxMSZZe9ZrYbUnl/RoUHvWFhe
	Wz/hbpbtji/F6oTLrcbYl2sza3wJhBpmeZaWpvE1sbblbO2VEh0MwAcBcJ1+C46y
	rpGRTDGQ2YJc6o0qlNfK8IjD4Eip72RK8HwrANfUryJQ6+7m5l2DDLcKwX98O5hZ
	oR38nCe3ed1UJu7HcOWSQe5u6N3zo7oudvF8ypehOqGj6xPmZdEEzoz1HVNMfWCQ
	LInydQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756k9hr1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:58:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so11705511eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795787928; x=1796392728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cK0hfsO6LY84HqJrabEhSmxltsurGZr9GeMKtUMsBls=;
        b=PLqO8weefJMSkYog+9sAX0nsymR1CSemcJNUvDeaF6C8G7SPJnh9qhe8v/NQke0+Yd
         abFLpCa/59rB++o/5Fn4riZ108JPKlvXVObtJjXniYC0NH4RGc6nhuntzUDbFf8E2smx
         4vtgO/VgweE1/G6UMDBgMeQDbpd7n8+WdKKsBY24yxUhRKU2TxZmY5B/vaCx4sQQQj77
         vUpvi2X7odwY3bjLLnaXX+YxXeEPERCeh+reaR7QdC27+MD3fa6ukVfCTjTgdFHpmmUC
         b0At6I64KYMz4q6YtTJapLPROpumSN3C67paKibSWBSly0j8wu1Hd6im+rXLzKjTwxc+
         JHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787928; x=1796392728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cK0hfsO6LY84HqJrabEhSmxltsurGZr9GeMKtUMsBls=;
        b=zKCn15Uvfp4SADvXh0gs15AgdmIZRuEVsDxeHrOjKyZHUPdI+N1SoeDJSUO8oXxd8n
         ut3wVNJjE+WEM04aB2ErO5rc0yd2nUuk+AWDksLtBKqA2ngaS2HA39gbHwvZkh/u/gLV
         6aWEcC658PlF5/CE5bObYkiKUMnvbiM/NeUIai8VfAFr7voKKTf7vjn2fsKdDHMj3w84
         jCEJnHWhXngL+yTXZqHTn/bwQyQJAXx1rkRRicjTguTgOsWLSNVrbsslGGpoPAzywd64
         4Cl2O5xJk89a/LszODF5MxdWzpLc09aSwP1l0MI/elyrDVRBrKj5lF4WafcveYA09G45
         BmEw==
X-Forwarded-Encrypted: i=1; AL+hErHqk9LDS9erQp6WsqrRzAmJAeLBm5WwyJtwQShZRoUa6evV0a6181rbCpn5qMj2EHvaqaUaHdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I1rQR0eT6w6LFjkfIjrm+E8cva4p9+3MMbsZDApMQa1RYwHrm
	rQKMj9zhRsQcznW4qxR2y6djwipGSvj8lWxqlSrd179RjdwhuiFAsm/MlFchT+2+TX7gJXlN4RW
	h1LDJ9rc9iSUe0rpIHS112GlX8mgCwz7MQRY+vtcG58a84nZoVL+qGfdwEG4=
X-Gm-Gg: AZFdTZdbyBPV0kBXETA6VHMFpMtcQwLKoHrdeUGHGE8nd97fxZwIysflTk9JtzxNbaX
	yGHzhT8jy3+Uw5PLzN8HSEeyJVSho51OHP3u05zlzaZxdwjO6TYS/VCLjiz9aSXpb81FehmRvcx
	91M9z1a6iYH/VDYl/EiIsaqeuTLN24IqfKCDj2SC4L8tBFUhOMo0yRfE+hetAS8aYm7Pj5OfydH
	wkAfPpRqXA3IXAh1qOcIVBu/L+R58YVAAiIi5UJrOurhxduT/v0Z2OlcoAcJQlhhge1Q3fghOTW
	OCqagDaotfYj7dhD1/hd6kIlYSBPii10jCpMMRBW0RzzbnKVQn/W7riupoCWTWYnV9iqTqcGdSK
	J8/U8sW7LS4Z5bAyQ0r9He62Untk6HX1ai3wIe/SXUcEpIQPNaWyBkDciCXnIPIFW3VuIPY2Odz
	Ab5H1Kzg==
X-Received: by 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id 5a478bee46e88-38570c36e7cmr21793718eec.37.1795787927669;
        Fri, 27 Nov 2026 05:58:47 -0800 (PST)
X-Received: by 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id 5a478bee46e88-38570c36e7cmr21793695eec.37.1795787927109;
        Fri, 27 Nov 2026 05:58:47 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm69037597eec.16.2026.11.27.05.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:58:46 -0800 (PST)
Message-ID: <127c1c1e-4637-4bfa-a65d-4b820a8cb7ee@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:28:39 +0530
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
Subject: Re: [PATCH v3 2/3] media: qcom: iris: Fix IRQ disable depth imbalance
 on watchdog interrupt
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
 <20261120-fix-disable-irq-safely-v3-2-82f9561394cb@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261120-fix-disable-irq-safely-v3-2-82f9561394cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX3+B9/7O3PIJO
 PVArNwMGl53S3n/IuM4Zgrf8KlgwqjsuB6Rhe1d44rTfgvkDEaQmWj2A0SiJgDBV907fLpn7pQ/
 hcnV/FW6pRGHbmHjA1oJBLI++/3ms+XkcG2fqXEoI6CpAul3LY7lS3iL/s2WdasPcdxit+llX0z
 IOpBMXiU28BxYHxvlma5DN2Jxfde94txvT2AxDS///cD9oD+L3PMxjukVcEj2epyay6NVa1gqAo
 R1mvvNnW9EHBYmdmLSnZI6YK1rO6tRnm4jEkm9fBGIa/MtZrKDeKHWNOavf9n9/pw0X5AQeJOXv
 xrx5XH1XU29lN78xXoenfdcxYauHhKKE67sbjPg348t4ajr/tmb/v7dm/s0gDUZarytwbLnQI8H
 sQTE1E6A6aK3AgYuAxGk/w9sejjSMYGjvjae7CojjL0+eWbthqG0UAqmSGLc11wRJ7d+pOsTcDc
 VRsEP32br5jFRa1qLyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX2ObbjMVEGk9d
 8OZ4u/YYkgALqmrz5GA7nCHGgpj4tJDOvbHKaYXaE2CpLP6v+piJU4zs8VrcSelvOYqVfOH6U+9
 jD9S7z4ySgN6SR9mT0I4YRchEFvQS4w=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b098c98 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Sp0_ih0bWsTyJVZjBMYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 5cbwmP3TybovbciELGOMpWztBJwhIZfv
X-Proofpoint-ORIG-GUID: 5cbwmP3TybovbciELGOMpWztBJwhIZfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270055


On 11/20/2026 1:12 PM, Vishnu Reddy wrote:
> The hard IRQ handler disables the IRQ for every interrupt, and the
> threaded handler re-enables it for non-watchdog interrupts. This
> duplicates the masking and unmasking provided by IRQF_ONESHOT.
> 
> If power-off runs after the hard handler disables the IRQ but before
> the threaded handler updates core->intr_status, and the stale status
> indicates a non-watchdog interrupt, power-off disables the IRQ again.
> The watchdog handler does not re-enable the IRQ, so the two disables
> are not balanced by the single enable in power-on.
> 
> Request the IRQ with IRQF_ONESHOT and remove the hard IRQ handler.
> Explicitly disable the IRQ in the threaded handler for watchdog
> interrupts to prevent repeated triggering. Power-off always disables
> the IRQ once, and power-on balances that disable and any additional
> watchdog disable.
> 
> Fixes: bb8a95aa038e ("media: iris: implement power management")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_core.h       |  2 ++
>   drivers/media/platform/qcom/iris/iris_hfi_common.c | 14 ++++----------
>   drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 -
>   drivers/media/platform/qcom/iris/iris_probe.c      |  5 +++--
>   drivers/media/platform/qcom/iris/iris_vpu_common.c |  7 +++++--
>   5 files changed, 14 insertions(+), 15 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
