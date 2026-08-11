Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6ED43D51A
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446641; cv=none; b=OVvCjwLWt7pAWHd93+uXrPqX5Bumg4KMqUX0QrIFTZAdOu7O5iKsRD02JbYT/Q+FE1K8D0v4agWEAno88gYBpts70J4vLuETEpEKN5okrseqmeFqPJ/fHsncMNogPbxlTzI4v4rUwMId2MH1D1ZsFxH/4+T5uQa6s0wtw4QL9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446641; c=relaxed/simple;
	bh=UQYSpG/ghwrPrmS/sItNYj+UpZyw/JFbrCVrlgjfu0I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oXze8dOo6uW3CSvPB4cXk+NIn/Uo5p83VnppYr6f+kYJMQgufb8ZnVkLR8lxaYZD++gjTTSWgfG5fsMz45Filx5JrWrsUfYuYyWY2Zb8ZFiEgN2SU9jYQFUzoqIh9pEWOCaPJijWV/SQNGruiOvp6iF/OSLaIn/A0L42/Ujp288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PkNRkPW2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ICSOX2dE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PkNRkPW2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICSOX2dE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BALfj8338674
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BXeWoJq8DouvrtU54oGeb0YWU/iHBff0ptXq89RGPS8=; b=PkNRkPW2FJbHwyPh
	wl2jhujsgkLKOcQLjq1tC7oTW9GNrcbO/2rLLUeOCyoXfTN/Q/xs0LX5JKDmnHvy
	+Ms/KEeS/DbUfY94vjyEJYzfITXSxxk5ugMs78gE3vT1phYyFT7He73ahLObzZEP
	DsqeLCOfKmYyrrXMxWJfFv35EBcmxZ2/TNqGwrxRiUGpkp4PQqviUtY+AQo1IQ0z
	M8UFF1R/dXv1pjqp66tDpBIfxbA/jFnvAOf9YgKaScdrZr0byJMVlI2kvQcMIDt/
	vuUIZ75oXIotC26Lrf1sw+hY9EBRThULzIJ/STkTxnI3vekn5shEXaD2twS9I153
	UoVOsw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc0701-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:10:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52769fc3f2eso38106621cf.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786446634; x=1787051434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXeWoJq8DouvrtU54oGeb0YWU/iHBff0ptXq89RGPS8=;
        b=ICSOX2dELHUb7xqrqvZ8s3ihQRltK/CY0JJEWkA0dzmzhShs/zRGT0hD6h1WuR7ZMc
         zhQsSyAcyv8TUL6MYjdYBKikQy8RRQWlMvL7Is1/jScLp8Xvnx3wyMYKRbQpvEWfVbwC
         qrTzejaJukizToLpVIGHd5zJRpRhBkOvI7NPf3WaEP/q9crqjMXGiHDtEOvyGM0M8Umz
         KOEF+iA1MJ9lGd1+Uz0So5Hd6CPaOD7Q/olhIi9NKNCmzm2YCGTarOz+4zpnL5pIWS54
         gXR3s1dGJW770MFpdKn5EftO1I5aeGNKJd1/+f4IpvfVnbklC2n+Io+vcULJxUvxpV2m
         mYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786446634; x=1787051434;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BXeWoJq8DouvrtU54oGeb0YWU/iHBff0ptXq89RGPS8=;
        b=dQffo7NUEpIA3MPcghyX2O56BlvIYbc2dcSD25Jp72Grty2OLegzF+hc4RdzVN8nw+
         rKDpDxGP8oGhALW7bRfthBfl+k1jpt0aOCNqRnrqJSpjD28q4ArU4pFIrGca7Xiln8Rx
         4WO2e2TH8NmnxFGTXau9s4DJkYjBpefLt+J5ubp4t+gdRcZKo5iCyrY0exTXGHLDgkXc
         y2QeVTbC+Szw1888W9OesKkiGcFU1/b5jCnX5vfS45f5MYzW+anbknoXQC6enQEYTP9C
         l+QLWgWxMQpsVpl2G3zmMxQ5dewHTLEivZc1PFbLen2uepmorsQidpigGcTIiGn66Z8+
         ZsFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRIsVM9hTHl9h0DcF366Ns5piNBNE6HbzhzJxtI6D5tNXvbAA0060T+y2dYQPR45nKgSvLzgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CWWE7vfpDZP1uhbedN4M3u4zqanoAGsqo9nbcOWHTRYvz80F
	Stnl/FVhuU9LKHaZH++UJuQ/6RbMfhGIr7Z9c/jgwZWOrUqIl1dYfxN7SwLPZ0O1ow57OqrZcV6
	Kj8NzBcwXyFgY8op/8zEPiwauF36rp5foAwRx2dgO5rfAdm24qKyf701IwJQ=
X-Gm-Gg: AR+sD12fE1pAi0ctXaDOuHqIM693U/FSrQa0RIc3D0TI2go7LDUE/w0zGZ99G7GfAsw
	LoIJ8CGtPtbLUBNqKIVHTtOz0LpQHwbtlR9LOTLZSzIacNTX6u877aXuSwjRNg+4YuJCSxbxKq3
	U1up2YZpYBB/hsi3yrZD38sFoTi5V5G+sXKBNsqGWrJsOryo085H3I7l6pLbssF95tXJ+4ErN2o
	BGE7Wa0BFdiakYAnRImrtvfPH9FkD4Hhv6TxTBuu2swNDaV/0BzKZrSYrZgrmy+1u5az/kemkxK
	h9tTQOpnhMMZTfTxDx/KfVoPD3p7k4pHaiXqeSic9jP3qwhm1/0dYRZ5AjzKwWPqk8fidGnqm6k
	w6ldY4ddvYwkM453Xyah5R8/8aRR0/Tmt66VIZikcgujCqz6Dnu1MBnZWz+LkIu12yyFSCMGqc2
	Z7gxMt4j4ShqAcTkzfXHVE8ktH2iP7bwYbqDVxcztP9FJR9f6Dzyh1a7sU4W/a9mnVARc=
X-Received: by 2002:a05:622a:2b48:b0:51c:b6d:740b with SMTP id d75a77b69052e-52d58639ad9mr19916211cf.34.1786446634416;
        Tue, 11 Aug 2026 04:10:34 -0700 (PDT)
X-Received: by 2002:a05:622a:2b48:b0:51c:b6d:740b with SMTP id d75a77b69052e-52d58639ad9mr19915721cf.34.1786446633970;
        Tue, 11 Aug 2026 04:10:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e432065asm38947466b.32.2026.08.11.04.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 04:10:32 -0700 (PDT)
Message-ID: <b70b5fac-a39c-443c-bb9c-6f45d9826ad5@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 13:10:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH v4] media: ov5640: select the MIPI lane mode from the
 endpoint lane count
To: jason98166@gmail.com, Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260811-ov5640-1lane-v1-v4-1-c4a05d4c1b32@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260811-ov5640-1lane-v1-v4-1-c4a05d4c1b32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MiBTYWx0ZWRfX/30Il4g+DSbM
 XZfLQMxb8ZvIoHSmhbV5oP8WKYl78glXgqr0xjwUYEtMFtbzopqH+1LuMt8Bi0LLkIrOtbZwAqj
 iUb8JX+KaHjOqFRKr4LzEheg1v6VjnU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MiBTYWx0ZWRfX1aELA87hoxBL
 D00wO9Wiv8ebV8Xi/vBCPjs3slTjutcSZG2WPd7DKuP34LPWe3lzwfo2dgPzF7pNN7kIXj+e4wZ
 tEK9Fxp1CYNwotxHSVDmbaOYzqqX7d9FJqcbV4OfpV22MjE7xcnjZHE8CdiQ/ZcS8Q3YmEmGf+Q
 5NkNI4JQh3ukMx17IolKmHFlkBjov3kw3wKX6EnM5Pun7YcM69hNWwxNEyZbikzUFT0Sn+EqDOK
 P/pqjY5Q25f6hJ1JxSOIa+AuXLf1cmldr/DmKdPQyG5iNtfclWl+GSvjpUtoTbi/WQB5LlduNHn
 qmzq+u467LqGVsw+QGsPGsF2nzroozYIEvnev/YXQlxehU2p1xVXB7Tfh7ig80ScJnY1SQMW/EG
 Z63fO1SbIl3lbBwtBFaEDSiYvwzQt1RYOQABsygA1geqFJ6SaKZAN8U/rqBlFDsqRgM+5Vs+POV
 I2j5va1bvZBrMBZlzDw==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b032b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=0TnFsdFECxFYUmcDFoEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: I8Ht0QxSMzjS1e3rEnSMzSmmSpOlVQfj
X-Proofpoint-GUID: I8Ht0QxSMzjS1e3rEnSMzSmmSpOlVQfj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110092

Hi,

On 11-Aug-26 11:17, Jason Yang via B4 Relay wrote:
> From: Jason Yang <jason98166@gmail.com>
> 
> ov5640_set_stream_mipi() always programs IO_MIPI_CTRL00 with 0x45,
> which selects the two data lane mode: the number of data lanes
> described in the devicetree endpoint only feeds the sensor's clock
> tree computations, so a module wired with one data lane starts
> streaming in two lane mode and the receiver never assembles a
> frame.
> 
> Take the lane mode from the endpoint instead. The field encodes
> the lane count directly - 001 for one lane, 010 for two - per the
> current sensor manual (version 2.33). The 2.03 manual documented
> 000/001 for one/two lanes; OmniVision corrected the table in
> version 2.1, which is why the long-standing comment here found 001
> unusable for two lanes and validated 010 instead.
> 
> The power-up path also programs a two data lane mode, but that
> value is overwritten when streaming starts, so it is left alone.
> 
> Tested with a single data lane module on an i.MX8MP board
> (imx-mipi-csis receiver), where the unpatched value produces no
> frames at all, and on an RK3588 board.
> 
> Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Yang <jason98166@gmail.com>
> Assisted-by: Claude:claude-opus-5
> ---
> Changes in v4:
> - Keep the lane count programmed also while the interface is
>   disabled, toggling only the enable bits (Hans Verkuil); with one
>   data lane the disable value becomes 0x20 instead of 0x40.
> - Link to v3: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v3-1-ae476eaf5024@gmail.com
> 
> Changes in v3:
> - Inline the lane count in the write instead of going through a
>   local variable (Sakari Ailus).
> - Link to v2: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v2-1-65205ae86feb@gmail.com
> 
> Changes in v2:
> - Compute the register value from the lane count in the single
>   write instead of branching on it (Sakari Ailus), with the count
>   in a local variable to stay within 80 columns; the programmed
>   values are unchanged, 0x25 for one lane and 0x45 for two.
> - Request a normal stable backport rather than opting out of
>   AUTOSEL (Sakari Ailus).
> - Drop the quotes around the function name in the reference from
>   ov5640_set_power_mipi() (Sakari Ailus).
> - Link to v1: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v1-1-79699457ce13@gmail.com
> ---
>  drivers/media/i2c/ov5640.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 8deb5f5501fa..a99e4edb6a75 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -1831,22 +1831,16 @@ static int ov5640_set_stream_mipi(struct ov5640_dev *sensor, bool on)
>  	/*
>  	 * Enable/disable the MIPI interface
>  	 *
> -	 * 0x300e = on ? 0x45 : 0x40
> -	 *
> -	 * FIXME: the sensor manual (version 2.03) reports
> -	 * [7:5] = 000  : 1 data lane mode
> -	 * [7:5] = 001  : 2 data lanes mode
> -	 * But this settings do not work, while the following ones
> -	 * have been validated for 2 data lanes mode.
> -	 *
> -	 * [7:5] = 010	: 2 data lanes mode
> +	 * [7:5]	: data lane count, 001 for one lane and 010 for two,
> +	 *		  per version 2.33 of the sensor manual
>  	 * [4] = 0	: Power up MIPI HS Tx
>  	 * [3] = 0	: Power up MIPI LS Rx
>  	 * [2] = 1/0	: MIPI interface enable/disable
>  	 * [1:0] = 01/00: FIXME: 'debug'
>  	 */
>  	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
> -			       on ? 0x45 : 0x40);
> +			       sensor->ep.bus.mipi_csi2.num_data_lanes << 5 |
> +			       (on ? 0x05 : 0x0));
>  	if (ret)
>  		return ret;
>  
> @@ -2535,8 +2529,8 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
>  	 * Power up MIPI HS Tx and LS Rx; 2 data lanes mode
>  	 *
>  	 * 0x300e = 0x40
> -	 * [7:5] = 010	: 2 data lanes mode (see FIXME note in
> -	 *		  "ov5640_set_stream_mipi()")
> +	 * [7:5] = 010	: 2 data lanes mode (see the note in
> +	 *		  ov5640_set_stream_mipi())
>  	 * [4] = 0	: Power up MIPI HS Tx
>  	 * [3] = 0	: Power up MIPI LS Rx
>  	 * [2] = 1	: MIPI interface enabled

Sorry that I missed this previously, but should this not also
write the correct lane-count right away, rather then waiting
with fixing the line-count for 1 lane configs till we hit
ov5640_set_stream_mipi() ?

Regards,

Hans


