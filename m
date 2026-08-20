Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025313C2BA8
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220231; cv=none; b=pmwD9R7iLP4IOxUv9PtiiCu02yUvAjp7IORV+0EZqPdlKXH3NKgBDkFxC/964cjZ/eiJPFuI4SHWLzcXL8DDwyGj02RWB/k5bE1YiPEHBzp8IfZ6DX6xfc80qzVGe9LLmZsAM9XtV1n3QrsuqPnX02E46keD0mjH24nM3dtGgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220231; c=relaxed/simple;
	bh=eXffEAGKjk5hZBWJl6zMi/+attHYcgNZsIbemDFtAZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq34Ctpo1NpyP43oZoo35cg1i+DSIiA/Hbh/Q4A0I8tOXHVZNytbnWT8MlkrXrq8QhRSK8iB01XIJia7KihsvUZTs4Vs1qHsM+8G0MC4QckxanMbs3uO0B86S8bLZrlSKZJalQGDPYOVJSMo7YA8zcAhxQptWQbeyuPeUpdBnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GrUWv8E1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VMb62xFU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GrUWv8E1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VMb62xFU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8jd782529517
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPSkuOEchbemDS4U9crqf2tId0yJsRdyzuUVxXq7JPk=; b=GrUWv8E1JzQPRNt2
	g+UHy/wFYB6/Emh1fS4On/siAWE2XU8nd8XmNCtn4F3S3G7N+Vj7e8uaiqiQzumf
	Uw48HTxrOFwMdzq9UmulYBxsNgHga1Z1NvveN2GmDqO1Q2ySo9XlD9lPV1HNoKGW
	rricXfDqlvNeXCJr9qeYJKOrjN50RBiSN6NzRzMQOcSV59z/Q353HeJspIA82D9D
	kvtUZvk2YScboJZk20pXxMMu6LaswLpvxJtrWPvpbJu0rzhZ+hTTvezMqKdGYXjR
	nQTjUdVEj4K5SrFWEo+DtsN1G6hzuaCF+8Xe17pzLn2QZIN7HkelcmZtacFb1y1R
	wZj4xw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv89xn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:03:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so2821878a12.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787220228; x=1787825028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPSkuOEchbemDS4U9crqf2tId0yJsRdyzuUVxXq7JPk=;
        b=VMb62xFUcVrgewbRSXphIjDpyyau6Tk0j4gPcrx2EhobMoEa251AtqlY/y9wkrC978
         4e0PMN7GiDdo/1YV4SWBzpuCjJutZdfJJjNCLVdZs6WtJFA3PAYXcSj/GIHlbxzKNjkY
         Av19n6vLItXw6qxPUUMG0k8cdWW88Npdt/Nhu4gJ8QuWQfsLP8ArbzYnZPKkuCeYhQuz
         9NL289uOPbGtb/d8pePgot8eINsSkvi4aw3J0YqXAa/MD80f0Ch53HU2HJbPSRbT46Ji
         0e217MaJIIg1S25Ol7n21Fqup/axqC7FTMqFn6h+HfT0L+Fr32H/dtkwIr3d4D7brVPb
         KvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787220228; x=1787825028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPSkuOEchbemDS4U9crqf2tId0yJsRdyzuUVxXq7JPk=;
        b=hCrSra3omVQV+1kAzF+s5jNTyrB38fukmc398hkDYvFMf7Mlk8V7hF8Sy9eYeF50Xx
         Ng5E+aen3MSnJtyVB8oyF0NyGOM63eSSJaAf6Mx3w8saY8bNGLhpY3RAPYhyWCdQkl0u
         e2RQrgkBCrTIDlNQBvVGOM11Dd/fo10j/Csf9x8byUYiHxsCa+57cTtv+QY+gpGBls5I
         hhJL7VPgeQyFH5nnRgcz4WuNGU3z0X+qau6ZrpGZeeLL3pFXUkj9y6rtAjDxOhvuGVLr
         oaHTLIfskvKqTR6MJ8fSHrJxR7PSm13Mm2DWVrt53+MpG9/f82BQLwvYVjRq5KiaNXRB
         C3Ww==
X-Forwarded-Encrypted: i=1; AHgh+RpctHSF6YTv8KvmtwgjDtmhE7SpjCGgF6hjxXyyUG/tMAtObZlmeAjUKQVFTTtyqlU+aRyis1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGOnkRDGAFB49Q6c8j/Wi6jLC5m2YB8v8Sm3YNQW4+7QphKyk
	g4I8lh2LKmyr9gUQays5IKdbBYYQs51TEWNaBR+dqEnBqg8jNO0DLxyBm9AtmZ+CJyQEhRbJkby
	jU2J+zIvoWZjUsWRnGU7PShPuDSWmLr4CUHDDQhC6wewtTwgndahTwO/FPQM=
X-Gm-Gg: AR+sD134ZHuAKKSKQtuA04LeC+G+v7lPgWRUiYLixRljIZ9w4SS+2IVWVc/CUXAWCNo
	qdBHBoTa8NvXMl1tQT2zQNfFAH75Xj8gmJHjW6tQ5gvYeZWk9oEDcZeMdPvU7/0DWLMdY3nHCxM
	2sGDTRegKxZ0f8g2fC2Uy5qfhfnFicDnnYfyUfWJ5MygNuU7CfL5RRGnA0fUiGEM2VPz6RTV0bu
	IxgjTbMtSoi0IXVLQDKbkj8Gr6F03IQT5dD5yw+id5dc+2d8agpa14d9yWg4EQ/R0OpgchKQ/21
	zW7MdXm5pyfdTW3deDLaVVDE2QYyN9R0DJ9UdEQlc8nSTYtSw/d1EypVhyXuBoPLbtjFinQcubB
	ZhqNCgUibWS/u8qiefJ27AN0oRn5JEz1V4eqUswlNciT2uLw959/3JJkCS42K3a9UUY0ccdFD
X-Received: by 2002:aa7:88c8:0:b0:847:9015:e68c with SMTP id d2e1a72fcca58-851d3953ac9mr17929937b3a.17.1787220227633;
        Thu, 20 Aug 2026 03:03:47 -0700 (PDT)
X-Received: by 2002:aa7:88c8:0:b0:847:9015:e68c with SMTP id d2e1a72fcca58-851d3953ac9mr17929843b3a.17.1787220227125;
        Thu, 20 Aug 2026 03:03:47 -0700 (PDT)
Received: from [10.133.33.222] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d33627ddsm1488181b3a.10.2026.08.20.03.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:03:46 -0700 (PDT)
Message-ID: <e07d3a93-390f-405e-85ec-21e5ad9a6738@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:03:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cpufreq: loongson3: Adjust the width of id and val in
 smc_message
To: Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
        Hongliang Wang <wanghongliang@loongson.cn>,
        zhongqiu.han@oss.qualcomm.com
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-3-chenhuacai@loongson.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260818123921.3600606-3-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86d104 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=2sVyCrUYgtLBleu_eicA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NCBTYWx0ZWRfX3a1VIcDCziTA
 XlTGp9RV1niEuqkPVDJgDjPcO6roACDF/Vr/DqdsTioCvT4K4kYeNfWT2eY4sQimScH8L5O+ebO
 M4dxLDkzHerbf1Lv6QP7pr8j0w9KmiSdCLE6RPrrrfhfl5dlYeKkh0pddxmfURHDGJD0BJ1yN5r
 8dmIjCHukvG1eNBByE2eR3UYN/NEQlapwBb+qQpbjdjfon54Bw0c5Jy0nCFC5Yxht8IMkxIdo72
 lqXLPxSyMmv+l2dlbytQYwmKBw8vjXkRietLUkWYMENDNJzoiRtOzK+HEidyaektdVscmVQfjhT
 D1OwrSejEmLasX0Bs+P5km4MPoWz6FeUg+woYD7P439bHlajFba2W/UhkyXtj1LsqHBMKerF0kB
 ykICbNxLSwlgBjch7frNHYv1DRUy4+l4GOhBQGUZlfntMQ9pP6kDC0JijLhVgult3lIlpR39C6l
 KZWAW0ftxzMFazFDjXA==
X-Proofpoint-GUID: bnVSRNwKOXZibu14eiTc-Aewt326tCJy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NCBTYWx0ZWRfX6mqx3XcIOjwz
 D+t0x5cvbQG/ro9JKR8aHxMa8uh6oBB+hDuHSBIiBxwx2j/7LwgBKF6ErCtAn4htwVQMfIr9Z4p
 NJ0KsPJ1xBlPCxQsRJH+xWb+cYbjAkc=
X-Proofpoint-ORIG-GUID: bnVSRNwKOXZibu14eiTc-Aewt326tCJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200074

Hi Huacai,

Please feel free to comment on the question below, or simply ignore it
if you do not think it is worth addressing from an architectural
perspective.

On 8/18/2026 8:39 PM, Huacai Chen wrote:
> The id field of smc_message is usually stand for the CPU ID. In the past
> this driver was only tested for desktop and laptop productions so 4-bits
> are enough. But now we have servers that can have as many as 256 cores,
> so we need 8-bits CPU ID.
> 
> On the other hand, the val field is usually stand for CPU frequency so
> 12-bits are enough to represent 4GHz, and for higher frequencies there
> is an extra bit to extend (enough for 8GHz).

The extra bit appears to be unused in the current implementation.
Perhaps it would be better to enforce the limit explicitly for id and
val bits, for example by using FIELD_MAX().

> 
> In theory, this is a incompatible change, but fortunately the old SMC
> firmwares are not widely shipped and can be updated on the air, thus we
> can safely adjust the widths.

Not sure if using CMD_GET_VERSION check can avoid such incompatible
issue?

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index 1e8715ea1b77..630f679aa739 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -21,9 +21,9 @@
>   union smc_message {
>   	u32 value;
>   	struct {
> -		u32 id		: 4;
> +		u32 id		: 8;
>   		u32 info	: 4;
> -		u32 val		: 16;
> +		u32 val		: 12;
>   		u32 cmd		: 6;
>   		u32 extra	: 1;
>   		u32 complete	: 1;


-- 
Thx and BRs,
Zhongqiu Han
