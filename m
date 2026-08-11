Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87992449B10
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458985; cv=none; b=j+A4NU+WYiZhzqf5i8ff1MTQLbsiOBLxO+9q7pcGzsa7iDImDsP9TTh24N1FZnYIZD0wtmImcfyKe8d9q16mkoVJmWb01ayW8V+TZ8bDvQKL/Fw3RD/Osa4G9RmYUsYnNPd5pDBq2ZQLE5hlamxvyX48PuoP92rQK3ZzTMtHU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458985; c=relaxed/simple;
	bh=G3BdBR7697xUjjuCo7MFSXSomFi+FPGZV8uhCFjNX24=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jd78WfsWv84340hmKBUyFr4m/tAm5Yd0vniDFpImtmxHPdWT6Rzoq1lwjz9h6KKu29bOOgIKhGBA7WP7QsLMyOZbsCghOMFvsQ5Vfd+EHpgn1cowKPfVkLP7SQQOexebhFanDpGKzIbRZRMxH/q+mwq44LBdtNlEPZgiXyxoceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hrYksqob; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EDRJstX4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hrYksqob";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EDRJstX4"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXqQE767933
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z4npT91whHGlaKUkHbgyocvB+1xGRkT8HCeq2TRpFog=; b=hrYksqobfha8uye+
	Zk0gc0WLv+GeP7IXh3sc1JGMMZ4/JZ5AF4B9f2h2x8dOemPIG2nVI5rhKa/Bue6K
	aQJialweIRGAQuQepQ6ek3zEDtHeCQGSuNgHWun3iR0bKP+loR/mbJ5aRUVabGyJ
	fxMfKVLBHxuAgsGorh2jwgCqiLfyh7qxFP0nk6pij485UjFAUmYJBFP2ClY49pAu
	+rG9Wc6QOo0I8rFx+LnzE+RKtl7puHJcmRtVJwk8+g3eiGTufppFbyfz/gO+pfwd
	BNWgawO3W2v2ojkHD/G9lI8UtbhtPTxl+l20VVc8fx3/8bLd11HdBmS8uaSM0v5/
	8GuhoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc0yvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:36:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0e702df8so40862661cf.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786458981; x=1787063781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4npT91whHGlaKUkHbgyocvB+1xGRkT8HCeq2TRpFog=;
        b=EDRJstX4yoNyZ4FobRvVeThC54W3SfbmCm4VW2tkAJ/ZtxDdpZU9nm8ppj1XABVchQ
         L/9mBRWxR1wE4pLG4as7J33BthtfI7OfJqsM1khK5hNFHsx2mms1uw2GrnixvVOcVMmJ
         8qK7dgc0Kg1MQaJVlOgmYhJDZkzEzmHqTz1wfnVuMb+cABjs2jxAr7Ku/pLD7YFnfIRR
         8k9cAg609S42+c2gN4D/W1Tp4CtcK1ZK00RW7wQ8aD0kS7aGVlHx4ALDgHA+zHOhkM9X
         bzTu99dqk5U3XBjvXR6enFG7Or4drwsq8ar/keti1TU8jPQE40cS/4wgwSmIrOUJK3WN
         /wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458981; x=1787063781;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4npT91whHGlaKUkHbgyocvB+1xGRkT8HCeq2TRpFog=;
        b=Yl7+2zDG8RQOhiFMqvdTkoXvp2GM/i8YNEjIPNpfwlO9FI8PlXcJwYur0eFa1k4RIo
         JOtNKJj4gLz6e5YkVXG3U4kB9i6/Txe4g633XaCmhKlFDOpz2/5wu4oCwpvyToZMcCzq
         KLi5LWb4qz4fFU8lIZ546CyKOg+Jh4Z3TN3/0ixGBiw6s+0BCKElqSXPjNi+2DG7J0rt
         dc2rMdoYhhwPFrCLvKoflAAAADH35dIbnnABcnreJSl3VRTLQ5vh4QnpGv4PMWr+TDzg
         RPoT6pTC9G5etk1cuGQsy0NQAPQDlpmXWFMSO7aoVjKlALiz3TWdrEzJvAw0FRcWVerv
         trAg==
X-Forwarded-Encrypted: i=1; AHgh+RrJKFJvDqsRsLxo4PIuYq6Jabv+cvSM/9PwEj9oua605yH6ucoQ8H6wnDYiaJnJglvmBXEKKdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaha5cW/94y53Bmmyy4DiacFFu+BlAMEhqCjQCvzNFk+dFcnJC
	8wYoFKeK6+nwKaEzL98sryeHNFTi85XNeEjnGFALF7Nk02Rgm69rzq/77JkJCMbQeMRjWPVpj6f
	Y0y5bh6keONZOq+yVvYFecOjYeUZKuV9dO6TUkEbRoHRKnTolrsHLxTG8CwA=
X-Gm-Gg: AR+sD102yOxPuleKjye2m3JF8EboZ6mRGzOOWPzUiouDOo4eLUMRdGTxlnO/IV29yjG
	V+ME9o7v2Zd6VXv/adg4fBYbSHBTWI8QelFhIxlDqTLCvqb8bNCXCJP1XI6+RGF7wFSilwKiTIt
	3qXuLoPUcL8VhrE3hUvG9sRXXdI/jv05FnSUqpZvBfGI092lhLoHZScd/hdILXp6PbUAby5YQza
	Jjra3/hILp03QOV8EEPLpXXXafVEUJ6yYoNItD/goSh1bzAhq5/b3Ww2VIE3EPbb4VGzKt6aE41
	tpFAWN6YJf/2JmI1oxv1NFcoNAu44ZwQR5a/isDnET/MU2QGqsxijwGPEaBDrRHQP7FLyhfEVJr
	L4iDUwJYMRYMX1s3j0/xbu8yGxjWxVBwBYI96yN36rAwX2mDs+FNM9TG4L2LxqgNifgKR/u2y2m
	HIsT+g4imz0n23HtJU6hVEB++g8/aHMVbT4PdQnd51BsRD11DFGJY0o5v6S1dmRavq1wg=
X-Received: by 2002:ac8:7f41:0:b0:51c:19af:6341 with SMTP id d75a77b69052e-52d60251984mr6645911cf.36.1786458981496;
        Tue, 11 Aug 2026 07:36:21 -0700 (PDT)
X-Received: by 2002:ac8:7f41:0:b0:51c:19af:6341 with SMTP id d75a77b69052e-52d60251984mr6645201cf.36.1786458981070;
        Tue, 11 Aug 2026 07:36:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e4102739sm63344066b.21.2026.08.11.07.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:36:20 -0700 (PDT)
Message-ID: <47ba3fb7-baf1-4689-bac5-7f296e70f3b3@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 16:36:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH v5] media: ov5640: select the MIPI lane mode from the
 endpoint lane count
To: jason98166@gmail.com, Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260811-ov5640-1lane-v1-v5-1-14849a3d3a71@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260811-ov5640-1lane-v1-v5-1-14849a3d3a71@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMiBTYWx0ZWRfX91s0vMSaOEXj
 gnhxe+85d0R4k/TJDDDluPAcSt9NbuK0Re+TkUz7CAISOH56lb1R20caKwLwrFffZlLyc+QCc9n
 IaHsCoVdF2+KTWbeyg89FegwOiN82UQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMiBTYWx0ZWRfX+ksfo8jtZO9Z
 muyGBvAckXXiSMaC1+zQep/XuZCJUGoSX/yi+S1SRtsOqMvgR9OnPigDMiwnMRbKPaKED/xCqTU
 z0yt2gij9jBeiXO2uJ0wtQxL5mMVlLUmeZz0Ol4/gmGQ+OALkqYhUyWu01lKDTjfEmCeq0GRQg7
 wQ92IFmQB4fYgteAspYH7H194nqjUGnt+GjRNuO7YZ6fIbi6zyqO2asW6VbB7UuLwKac30ZAHe2
 oaP70GAgJ+5c6zmYnWTg72iqhknbak9UB01V4U9fSzpyZYzx9/wzfOz1jGJ4LNsopERUUmKdgbx
 k1Pc9moLQAT0k+IvGhVf6bI3dp6lMXW0fXkGJVm1oPbjhQ+IwcTj/zdxh0WlqTBqsVxzdmp3lkb
 79ujWyQgYwo7/mXMj81Fp/slblMxk9gvyehXF26orFZYC6ubwE73fJdrjK0ggXb4c5/DQFGZhPI
 tiLgigTam2qGFbJ7CRQ==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b3366 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PFQL8LixuE-k6l4gkC0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: BSaXEQEUev9Jessut55GSdMhda3_Zfww
X-Proofpoint-GUID: BSaXEQEUev9Jessut55GSdMhda3_Zfww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110122

Hi,

On 11-Aug-26 16:06, Jason Yang via B4 Relay wrote:
> From: Jason Yang <jason98166@gmail.com>
> 
> ov5640_set_stream_mipi() always programs IO_MIPI_CTRL00 with 0x45,
> which selects the two data lane mode: the number of data lanes
> described in the devicetree endpoint only feeds the sensor's clock
> tree computations, so a module wired with one data lane starts
> streaming in two lane mode and the receiver never assembles a
> frame.
> 
> Take the lane mode from the endpoint instead, both when streaming
> starts and in the power-up path. The field encodes the lane count
> directly - 001 for one lane, 010 for two - per the current sensor
> manual (version 2.33). The 2.03 manual documented 000/001 for
> one/two lanes; OmniVision corrected the table in version 2.1,
> which is why the long-standing comment here found 001 unusable for
> two lanes and validated 010 instead.
> 
> The power-down path still resets the register to 0x58, which is
> the chip's reset default.
> 
> Tested with a single data lane module on an i.MX8MP board
> (imx-mipi-csis receiver), where the unpatched value produces no
> frames at all, and on an RK3588 board.
> 
> Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Yang <jason98166@gmail.com>
> Assisted-by: Claude:claude-opus-5

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
> Changes in v5:
> - Program the endpoint lane count in the power-up path as well,
>   instead of leaving the hardcoded two-lane value there until
>   streaming starts (Hans de Goede); the power-down reset value
>   0x58 is the chip default and stays.
> - Credit the v4 changes to Hans de Goede - v4 wrongly named
>   Hans Verkuil.
> - Link to v4: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v4-1-c4a05d4c1b32@gmail.com
> 
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
>  drivers/media/i2c/ov5640.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 8deb5f5501fa..526939041ad0 100644
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
> @@ -2532,16 +2526,17 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
>  	}
>  
>  	/*
> -	 * Power up MIPI HS Tx and LS Rx; 2 data lanes mode
> +	 * Power up MIPI HS Tx and LS Rx
>  	 *
> -	 * 0x300e = 0x40
> -	 * [7:5] = 010	: 2 data lanes mode (see FIXME note in
> -	 *		  "ov5640_set_stream_mipi()")
> +	 * [7:5]	: data lane count (see the note in
> +	 *		  ov5640_set_stream_mipi())
>  	 * [4] = 0	: Power up MIPI HS Tx
>  	 * [3] = 0	: Power up MIPI LS Rx
>  	 * [2] = 1	: MIPI interface enabled
>  	 */
> -	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00, 0x44);
> +	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
> +			       sensor->ep.bus.mipi_csi2.num_data_lanes << 5 |
> +			       0x04);
>  	if (ret)
>  		return ret;
>  
> 
> ---
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> change-id: 20260811-ov5640-1lane-v1-b0fe37eab4d8
> 
> Best regards,

