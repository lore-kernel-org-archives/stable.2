Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC64FB9B5
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842252; cv=none; b=uzchQdNOxOb+FRouD0qL6SEwxVYh7woUHEkdjzb2qLeqteN2QGizoMDJwt9pNZ+IvRdl19i9o8Cdr3fRWYPXwUiQIOd4wxakqT9gvSz8/eb+sUr/opeYD5odauQeO+D227RlCvC9VzS4P/aMByGtzO9ofh+A4ady2f+9gfTF1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842252; c=relaxed/simple;
	bh=P6jfC0A0EmG/xyfQcbws1efUz2wOkhVgwoKrGtJHlrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0eYEsCdAtlc20wh68+dlOaSq/KaNeIHxikYoKOcyjCjVF6ljh2R5KKOzKBzxz+fWCdJaiJQv5LW/4EJ+0kzO5+wJZW5ERlXYr5DI6ztmKEGdUNcpahZE25B/kas3Ce+ore0Ht9C8hCPTwnJCsCvc3fwDP8AZTRtlAbMlkRV2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obR9ibNy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JWUYo6XT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="obR9ibNy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JWUYo6XT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJN5KD3258506
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6GrCqiMFgsWuCjxp/MP+SWZYLaDIyfVl/iFjpkLpo+U=; b=obR9ibNyB7rgLaoF
	z62XLJbC4hYkUvwqdYBGhigKWvYaC3RH7SfggKa/mhO1WR8ruWHX9p/UrdNE6gmb
	k+xC6Yf8Lx2KCMQAZQFggHsx7fE+0SWtZLGg3MBO0K6g5Yt5PBdoh8u4Mb6RzMxX
	jxggXFZkmdpcJZ37AEIFhOJwPR0hW1xQE3X7ovKkfnp7jIaRO7VlPpYLx0pCwaXe
	c9Wr3R3S1Vrgup8sUxj2irHlKBxUXAnb8lZLnInekWjn6H9DcFLmJWKNiStb+MIN
	b1DPzWFBLtYMpwyRZP83VD7U+TP5lyqcfMc+k/e24JDQIhm2xrpBn1y6d68EIu7i
	K8lulA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq3kvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:57:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so461118285a.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791842247; x=1792447047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GrCqiMFgsWuCjxp/MP+SWZYLaDIyfVl/iFjpkLpo+U=;
        b=JWUYo6XTP5qUSpsPyZ33sBkeH7ETgktuCJ5RdqHkvgG/siqD9Xe5et28drIOuKcMtB
         cIFBwbSPkOlgGmFI4nR03WLFTr9sEk9qDjAXGvtCHnRnVpF2qyNhWdqR3n1xg0I/WXmO
         pyCRZqK6Wtoz/3ibiO22NdNDipH5+jghncooUotwKjta5v/f5xcMGG8Re0LuzOqHAcWp
         Ra1ZrzzjNen5nkL8fcCMcLyXVaXvvbfouq6yUJw6tBo7C4ey8upFUSee0Ap/zYQh/87z
         DthBzF+wjsfVCfevUynl2hHqrfOmz3e4bEQt/I2q2vyz143vtJsnCLiWpf7FLqDLSKs/
         nT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842247; x=1792447047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6GrCqiMFgsWuCjxp/MP+SWZYLaDIyfVl/iFjpkLpo+U=;
        b=HHpUQW1+zcyBs6ENu+6mhbHSdf4sNfXCaCjflQeJWUCtMZFTSlwaLXl3jzKBfkskZC
         EFBJaGgU9+3fGyIFELe+y+i9NFTkQTEN+XYAlK1bxulEabhVOcqpWBgLZYNbroXQdTjN
         Ou5rc90mfa02wpcF/JQ7p57B/l7tl+JdcPASbWsmXz8sr4i0Cl0viqn7Z6qVNIqDukZL
         SxPzZ1bACPQ2wl+k5rCeZtZHWJcl5DIeMFL8OtObUjyeh9m/9l1SzDEV9xveyquPX3mk
         OZ0/GFCO7WcK+tM+3Z3hN4Us7nbuKOW4hUvjDIcSBXYv3KypIG06uDH6n2lo98dkYe03
         HqLw==
X-Forwarded-Encrypted: i=1; AKwUvBx0eAXX7HWwd6VOdprZ/XUNGb38RmjLrpYEK0r2OvV0YW/Gts16/L1YGSUG6j7kR8L1j0Y4OCk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI657Ovm3HscyCU/kiPmtt3Z8S8YIQDau7o2pKp0nZihezX0pfA
	xjEyGr8m5egDYVBCw+R6EnNuAK1cW5OrSG3NYdl3SYXbFcXkZ+lQkSQdWO8Dl/GPsHkgCwRpE/9
	TXoMffPZep8omnh8y6GcjPRU7hjx8EdnRKRj4OPYWzn/0L7bY5QMC7F5AkAg=
X-Gm-Gg: AYBFou1khpxY9uLnRKdVu160H630nkWT/ELONr06EhWolmX3F6p0aB0nkTQaKFR3jIh
	lubsuGOqdZm1WUSjvI7HTXLU0ZNYDCQ3CXI/I3GrJsIhfedCRV3nV3STWIsLlqrKiTicmrM6i6x
	MqstOzKTvqDE7G7ysNjE7tviNNfNXIHCjNf+SJE+zypKa6rnBYwClcSZXZqxSZxUImjxR05P+ih
	tQePRA05O+mGN+KDmoTL3vNjWtyrNKeNmALgNX4lWaMt6CnurW2hHzRVUuQqTw+ujtZRsyJsRzX
	AWt4AOWbnpxpeKOtahXRsvPC79xYrxSrey6movUkMj+KN0GxXDqVwLwWriis5V3LxuMDSsFLF1G
	jLSr9Ta7KVG6Pq4+JxwPqu7KiYjD8TAGz1Gbv3UG/WiU3oHOclMqAsfup+VYX1Q==
X-Received: by 2002:a05:620a:4149:b0:93e:d051:8f19 with SMTP id af79cd13be357-93ed051b7e3mr1187563585a.40.1791842246910;
        Mon, 12 Oct 2026 14:57:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4149:b0:93e:d051:8f19 with SMTP id af79cd13be357-93ed051b7e3mr1187559685a.40.1791842246244;
        Mon, 12 Oct 2026 14:57:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm490389045e9.8.2026.10.12.14.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:57:25 -0700 (PDT)
Message-ID: <66a8df16-01c5-4653-9fb5-7d746f03f782@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:57:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] thermal/drivers/loongson2: Fix negative
 temperature conversion in set_trips
To: Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou
 <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <cover.1791512067.git.zhoubinbin@loongson.cn>
 <38f8e7cde8e454e7c6b72cb1b9a1c54e67c8a7fa.1791512067.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <38f8e7cde8e454e7c6b72cb1b9a1c54e67c8a7fa.1791512067.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acd57c8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=i-ReG1_fGx0deHkufOwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4NyBTYWx0ZWRfXxCI6+7VczP8n
 Uf7mPeIbgbAQp2D/SN46ndTMEmD79OARXgbxeLAF65E9bX6IRUVZ6L8eMRUj7AsfXCb4/aaUhAu
 n1NCm2DZAUWt/WdvbL3VtspQO/R+5H8=
X-Proofpoint-GUID: N5nIugemVZyQkRJvWn2HBOlCkuoIQ9rj
X-Proofpoint-ORIG-GUID: N5nIugemVZyQkRJvWn2HBOlCkuoIQ9rj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4NyBTYWx0ZWRfXxFlekJ/rFzSi
 O+cXJ1x8i9Yxd3wRNXwI/Ao6VKYElyunNBVgvIfShaVJEdGjVBdQp7v7jbLQmszJ+9hpnDTFFBG
 2gXVfxwPoHwyo7FAB7N/OTBvRDVEirMXTsExngDiw7zrEFt5FICY1F6Gu5sd4N4EizF17NjXuoz
 6IYgrwGcRfKKtbLZV898dmcUbE4LrVVtvAUxS5qNmpc3oaxXtTFQIy/rlDVRfyQYw5zNDlMixao
 Q+P4fTk1u6okRobfn84wqTbZk/afwAhqnYTf48BH+P0H/PErsUJCLIv/F0hsIG0vLTDXlv31CaE
 svD6O3u1cWO2Ct9KT476Gw456+B08ifZU5CMExau94nEPUwthtBFqwY+TC972aLi7L47zaF/yNs
 5nvmDT7nvTMdaxcS8ed/IQLYLZ5k73cpyG29ji/dXrlvsATwaqcEx8sNe5mkeOS/VV7+uA9xY4B
 AZ9fQ4YymAfW2Wa4O8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120087

On 10/9/26 04:57, Binbin Zhou wrote:
> The `MILLI` is defined as an unsigned long constant. When the
> temperatures passed to loongson2_thermal_set_trips() are negative, the
> expression `low / MILLI` triggers implicit conversion of the signed
> operand to unsigned long, and the division is then carried out in
> unsigned arithmetic.
> 
> For example, with a low trip of -40000 (milli-degree Celsius):
> 
>      -40000 / 1000UL = 18446744073709511   /* unsigned long */
> 
> After truncation to the 32-bit register field this becomes
> 1271310379, instead of the expected 60 (i.e. -40 + HECTO). Writing such
> bogus value into the trip register leaves most of the upper bits set,
> which may hit status/trigger bits and cause spurious thermal interrupts.
> 
> Fix this by explicitly casting MILLI to int so that the division is
> performed in signed arithmetic.
> 
> Cc: stable@vger.kernel.org
> Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/thermal/loongson2_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> index 4d40fc706a53..f5ff0cac1442 100644
> --- a/drivers/thermal/loongson2_thermal.c
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -108,7 +108,7 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
>   {
>   	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
>   
> -	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
> +	return loongson2_thermal_set(data, low / (int)MILLI, high / (int)MILLI, true);

What about using MILLIDEGREE_PER_DEGREE ?

>   }
>   
>   static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {

