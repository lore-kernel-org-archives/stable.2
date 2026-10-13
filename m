Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A935DA68
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881330; cv=none; b=L/XxohP0+LQ+1LCjyVhcT4ca6O9Uia5CLyLkPnKux/jPyg9gjUyXxT56+joJSIG7G9voRaGGqkmh6X02Wiv3xKMHIHn7vjRYg7/b+CgSZ2V6AUEG3USer6ImBjaRGncfnOjIRSpwc5htD+7BGquQJJAdktjozQ+IfSxLWbO0Xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881330; c=relaxed/simple;
	bh=YtQ34cQ9XmFi6zcNdYGMdmbtWTCoLVnZxtAsP94R6sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqcSDiozj8jDA4V4jwq49fZIWm+8n52c1dgzxGCwY1iif+0BbnJ5h3CG8wUTv3j9E2HjS/Sx4UGl706jU/DxKM2VKydoBTyJaZozUR9XG9RjduJ0LCLmEBar5ApHfA9ybtj/NpLvLgG1Ze30C7iH0WX52m6qSsPbLvoK6eaif8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2VWao6A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LvpKYrS6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2VWao6A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LvpKYrS6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8dqXS302843
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JjxJi1akmR350BjqJjUpsg/JBkPEFxqTxpfhmQt0rP0=; b=K2VWao6AEPk4LMGn
	35Waa8iTcpOgbuYSmwTYe0FtW4M05O9CZjHTZDPpEvsNL+bMOWWfzPJf0pANq9Yg
	/SAzOHHOVcaQN7m3yIXKvms+ZydoW4SCvGfsblVH8cNoatZHKQaQFitxH4H2/O/k
	3duo9w7IfJu9Ad7Seh+0cgCLOSKXblbsQAHauG+ZcHTb2STCDzZ1CsDXoVMxUue4
	V02ncNdLbvWJW2iWtN0zayH6BvIrB9MsRXd4Sn7vwodCszH2V0VdeA/Zn6FhFZlw
	Kn86a9PB6mL2HKCtwYMLjyaF0avKCyYfOszNTJvw613zbP+nlycrEhyvCvk0hp3Y
	9U2eKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sq9xnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:48:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ae8e7e546so570759385a.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791881328; x=1792486128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjxJi1akmR350BjqJjUpsg/JBkPEFxqTxpfhmQt0rP0=;
        b=LvpKYrS6TBZWPt/wDNvEE6brivkqi0rTcljdTba60yGtlbHmv0mrLxwAzgKFdHNBFK
         69D4IOiGij/i/URa2558flsR3WdO+A2q+QHSUaqVqaUa9im80emTUThOU3YsUD+71C75
         /nqYQn0KQWt8RYYrH29IZPcNNSjw2d2f2ltpKy+l5FA8FKa0M4WggMMBgwnuAeY2CCLS
         kvyduHTnpvPzjz23xh4KnfO7KLu+uyCb1PBe5jnbgtqQbgt5MHtANzRnFcHJNyRcbV9r
         nis8BhBKisfDlsauM/yymZHgiUifFIeEp3nNgdAek2Wre5fbT6/DWtVCsv1KFDKw1MiE
         F/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881328; x=1792486128;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjxJi1akmR350BjqJjUpsg/JBkPEFxqTxpfhmQt0rP0=;
        b=IQdNsvkbJebx3Rj9EbSzZXmMoTE7F1hPnyO7cXTK74bwVMgTBO4/H+AYzcIGUl+qhc
         tyMzZ80zqLiyiBWnXmraX49F7mO4swsnXw6QKoBOLz6EkleGXiZlYe8mi0LIosZcv/4a
         NRbvCqDZZtXMywAh5XgQRKJ6n7sX9uwOmovTleBofRnqtlsiptiOgBMxuZe+3CIOtJaa
         U7itzGLllJE76pYANVvQljHpYWu25NOIEX41xmIgzPgybVdYmJd6G5JvkKDCn9bJNYeu
         8W7Vq77s5cp/DvkN1B+WtJw9IhOYM400UAIa9XgTw1y+9zgFajnj2JZjRHF70CsU5r5f
         AXmQ==
X-Forwarded-Encrypted: i=1; AKwUvBylb6gvyoW06jo372FMffQwoA5VZPxqT/+uEQ2CJRJLAWREm1Loahkgn9n++TbpOguSVoYajpc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUmcQqrTnbnAP9sbVTxG4k0Z+84j40QFtmQUsy/axaX//KmN5e
	15fjBRVMoREs7uJRXk9oABN7QFt2SJLKvHo8MRFnqsz1UiHJblRcNJPnPV0thAICDdF2ftJaLMX
	VP4bZ4me7sWvkl1qqYOPcuRWFTYTxOqd4r3x3xv+YW/7rf5CyKLYN2HSU9lw=
X-Gm-Gg: AYBFou3fWhnL6EyI47h3FLAsbCIjxCjeDK1gkEFyIzOx/hJzsanksvjIAuK7EwdqY5J
	v+qBaOq0LdsjDtQKzp3NP2z0lLfZcqy5tmHN1QvY9zAIiilQUJ3yjXRuUZLC2pygLllrDbilmF3
	BYzLl1zitWu4cMqltr6SBiPBnSakvcxSDk3Dho/xGFIo+RE21yjEbSWJckoE/2taRzSA3+lO1nz
	WcHlZfZVs3kHt9EuU7XS49HyInpyJ572lIfbnUJqXqz3Eme50QDCN9C3zYv8Mhiczh0Mrxx5CDW
	ovVBTcrom0PxhvNjrnAA48qas+tEqZKDb9Dc1Xf7q216A3ZgsrvY+4vi6qoxeidaEwKAXZS0qZ+
	HUFXz/BCqlrpHwZP7qGk36LjbMRGYJ5LY6bEszQaCKRG9P03f1JQgEZs2QqJvqg==
X-Received: by 2002:a05:620a:170d:b0:93c:7f48:8f46 with SMTP id af79cd13be357-93ebd0cbba3mr2018273885a.4.1791881327650;
        Tue, 13 Oct 2026 01:48:47 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:93c:7f48:8f46 with SMTP id af79cd13be357-93ebd0cbba3mr2018271885a.4.1791881327187;
        Tue, 13 Oct 2026 01:48:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac35dfsm3905304f8f.33.2026.10.13.01.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 01:48:46 -0700 (PDT)
Message-ID: <8e42db37-3aad-4825-8287-8578fb3eadd3@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:48:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] thermal/drivers/loongson2: Fix Loongson-2K2000
 trip point programming
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
 <93d78dbedc091117d8fc7ecb29a0fdf2a6d096b7.1791512067.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <93d78dbedc091117d8fc7ecb29a0fdf2a6d096b7.1791512067.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX2NjoIPQOzefC
 erQjw+BQ3MUIXL10MbT8r271D4rgobvB2ZVayL3aGFCaXy9iuXsj2YDdx7PqyTBO86ae9Vxkrok
 fLpEqxDzdNKcjdoq9t+CLV8Moa+BJx3SV1o1CCFd6k8023oqmE8EYKRLgWggj3TATcaWGo5NrY5
 RXIuC9tYRwMXO+NYh/LLjgnevzvZ+4mJzlvGb9FHxDPvW74ce2wNp3FvY+XHcFuHDBxvkw15Kk3
 XalgcFT6N0pQHrt/ljtn37qHI/p9l71OCv6bVlE/UC4/lLhhB2bk5CbBkGVfT4ioT+C5G90XTxw
 wHhIa31tXAxj4EhgrWMRnhyi9BLjYSeoEtO78iKh+UnDRjleW01jlZDJ8nSk0EPZswu8WBiwnSx
 4+1dznwUXg84IlpA4UUF3c9PdrwIXEDWTc6MYQP45Vm6K9DrBYX24xrHpHoI4EMVvZC9gaPCqUD
 vSnCSgJAmit5FmQ/SaQ==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acdf070 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=B0Tmh5SJC70KtaT1dDUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX+nEJyvKScQkA
 Mr5VEXzfi4I2kaSh0Lc5usFrnfsiP5DGl8h5wvtci6pUMo6YyKAP0t54epcb/8t8asTXvgJO8NR
 YzJKPGE0jg+yRLCvr+UlkR6Re9AATqQ=
X-Proofpoint-ORIG-GUID: GvHFFYD9P0F5l_W84PJj6RLTqz5PIh3P
X-Proofpoint-GUID: GvHFFYD9P0F5l_W84PJj6RLTqz5PIh3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034

On 10/9/26 04:58, Binbin Zhou wrote:
> The Loongson-2K2000 splits its 16-bit gate value across the control
> register (low byte) and a dedicated HI_GATE register (high byte), and
> derives the gate value from the target temperature with a different
> formula than the Loongson-2K1000.
> 
> Add a per-SoC set_trips_regs callback and implement the Loongson-2K2000
> variant alongside the existing Loongson-2K1000 one.
> 
> Cc: stable@vger.kernel.org
> Fixes: 734b5def91b5 ("thermal/drivers/loongson2: Add Loongson-2K2000 support")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---

[ ... ]

> +static void loongson2_thermal_set_trip_temp(struct loongson2_thermal_data *data,
> +					    int low, int high, bool enable)
>   {
> -	int reg_ctrl = 0;
> -	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
> -	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
> +	low = clamp(low, -40000, 125000);
> +	high = clamp(high, -40000, 125000);
>   
> -	reg_ctrl = ctrl_data + HECTO;
> -	reg_ctrl |= enable ? 0x100 : 0;
> -	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
> +	/* Set low temperature threshold */
> +	data->chip_data->set_trips_regs(data, low / (int)MILLI, true, enable);
> +
> +	/* Set high temperature threshold */
> +	data->chip_data->set_trips_regs(data, high / (int)MILLI, false, enable);

MILLIDEGREE_PER_DEGREE

>   }
>   
> -static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> -				 int low, int high, bool enable)
> +static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
>   {
> -	/* Set low temperature threshold */
> -	loongson2_set_ctrl_regs(data, clamp(low, -40, 125), true, enable);
> +	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
>   
> -	/* Set high temperature threshold */
> -	loongson2_set_ctrl_regs(data, clamp(high, -40, 125), false, enable);
> +	loongson2_thermal_set_trip_temp(data, low, high, true);
>   
>   	return 0;
>   }
>   
> +static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
> +					    int temp, bool low, bool enable)
> +{
> +	int reg_ctrl = 0;
> +	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
> +	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
> +
> +	reg_ctrl = temp + HECTO;
> +	reg_ctrl |= enable ? 0x100 : 0;

bitfield.h helpers

> +	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
> +}
> +
>   static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	int val;
> @@ -81,6 +99,27 @@ static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
>   	return 0;
>   }
>   
> +static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
> +					    int temp, bool low, bool enable)
> +{
> +	unsigned int sel = data->chip_data->thermal_sensor_sel;
> +	int hi_reg, ctrl_reg, val, gate;
> +
> +	gate = (temp + 311) * 0x4000 / 820;

litterals -> macro

> +	/* Low byte of the gate value goes to the control register */
> +	ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
> +	val = gate & 0xff;
> +	val |= enable ? 0x100 : 0;
> +	val |= sel << 10;
> +	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);

bitfield.h helpers

> +	/* High byte of the gate value goes to the low byte of the HI_GATE register */
> +	hi_reg = low ? LS2K2000_THSENS_HI_GATE_LOW_REG : LS2K2000_THSENS_HI_GATE_HI_REG;
> +	val = (gate >> 8) & 0xff;
> +	writeb(val, data->ctrl_reg + hi_reg + sel);
> +}
> +

[ ... ]
