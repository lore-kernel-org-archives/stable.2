Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB641F349
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438645; cv=none; b=jGDzz41DoyWsURdEikhoGse4N8S4AaOl3sv7FAQy+JHBLy8blvrlWl2lBg4Wgch47uOG++JZKykD1WdVuS2whKiu1WM9wT8AE4WWhjlLubaEIzs3FT+CxfTK7MgnWLoWH8OcuVjE/0mtAJI78U7Gc4On0WU/n1Q9AzM7qFDR8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438645; c=relaxed/simple;
	bh=ctVwGNs67Fa6z+hLCuJ8VLAaBJHX9wbgA9F0FRIaAuw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OkrsK52ffdFGgNgmEWla7lGNCOd4HqdU6B6OWsgEp0N0aCOpczv/XWPoNJUhQp6k16bMkj0wp5Tlehh7GxIkEumaQLSPt4yn3KaFU/dKUtjCjD4JtDhJF4uw28bDd79983pkZ7iyrgyfaOQYqBWjmbvRUlcxniBim0N63HbhTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F0m5H1v3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e0LgnNBD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F0m5H1v3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0LgnNBD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6sxWq2995717
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	elooRN3b3UOMpv7wiJboOEuKd6vdGvMOOo10ZNjf5Bc=; b=F0m5H1v3uPL5OCJL
	lVKiVbn5NLq+9yv4FUiK30drplli0dk+njiMmv61n0OBBqiiWvSoWtRbhz0GRrnc
	yUxZFqT5mwngnm2RPsKeqrlls0wd6WZgCDgiRsNbmTjEJ3CvzDHF9Mqjfs4iEzVe
	TeLURWcKEk5tlFklXxvr2CfP/eZB7EPgOO671QZXktBj8nQqfK/kDZraVsgNQTAY
	XQbx1LouIpCVXWHTDFJ8GDh/o53yi7Irz+S4nfzUeF/dbjP9yf9wwg5qM2J3fOAg
	FEWSkedq1hw+NkvXzcCCDB64w5ptEFl7hdB0zdPiBJY4U+1XNhXIaieDe9ad1Rap
	vrsg4g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf36s1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:57:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a236220so5958531cf.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786438642; x=1787043442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=elooRN3b3UOMpv7wiJboOEuKd6vdGvMOOo10ZNjf5Bc=;
        b=e0LgnNBDm01jNRH6KikcAxRvvOYrQI9koZxSeakCyupolXYGEW5AhoHCrXgwXxtZA6
         KmskxOdjvJwwrvL6V7AoeT2nZ79MRZU8Qb9/wDpPZSzIDKckUiwi6eS/HxCiJQOnXOvD
         VJhlgz1vqy7aofhpofTuCQGmWbcMy5To5sC5ghbcXzLpF3eqiscPWoX3P0mOVmfmWTX4
         YT0NKdtzQjYpy7pw27Xb7y1CAzA4vqDXjkgJospCCei1nLZ0oUlRPbrVyN1P2r2Jh3I7
         FlKOBi2S1Hx0Tz60eIueasVt5xmWAeLAXV4JTm81kcEUwMWEsFF0MwTtYGYBqW0CYuRC
         Ds1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438642; x=1787043442;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elooRN3b3UOMpv7wiJboOEuKd6vdGvMOOo10ZNjf5Bc=;
        b=EMNlDUflqTu+nRe6LpDhmdMC4EdDG32TUQj2nKNaXfRlETQyjCWXJRArGQUK+fhzBe
         1FUuKlirmib2jGeWs+7sR98YyJR8Ukys2m2IgQugPKI1bRKku4gcfiLRItxDH8SctkoA
         PgUqgpu+1n2nG77eaWOBVXRqU3f060L+3LvaYJl1FtOOlXAxX59JEwOF6vJikyCO8RKb
         NCgTlZqrYbPj+PzFl2bGyPdku0GJkFAZlKgrtwkUSnOQEsMJBpEZmJ+4Ox7mW4zbD6uu
         K+jpo2BQ79VpPxkbAYitp+h8IHL7C4FSekFWtf93GyS9DgvuSu2yni4+AaDtD45QkSv+
         wJUg==
X-Forwarded-Encrypted: i=1; AHgh+Rpv891xtN5XI0RF49AJVbMtQbYoYYjA/hMHnq9Y0vvzVW3cJLLPAglmNpzRbCUEQhG+Tx0y69Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPd4PqsYgo6ZhA+72SygBVsP8UzXjYUcA3VeEfuQUUNS3lCpD
	pTIXQcxHk7H5nQkoiTmYt4EL8Vla6cDBqcw5cqd87omP+JYcC39n4Igu/BBe1e5FWQrARv2Aa8a
	66XaJTek0tdTbs2HBd3ErCASAgIRxZF/3r5BDcYQQNnHaOeSFIj/B7Pov/44=
X-Gm-Gg: AR+sD13KsJhcWCcybj27f4kwVxz9GqYEQ/ZOR8YylrE6CoXYKtDrfABuE0xCoTeRPR+
	a4sOU2hKbHKAEyxiFzf2NnJKbmaW4AgFqv4ehc/qmI467CEcnt0mwcYr4oK7RAd9nRYRJb+e7rl
	VH3HJiLdREx14fN49Si7LgY9RTQNZaUU46TP5Uz/ndmWbUYL1Fd6Rl0fkwxD600cHqZIlRUtG0r
	YJFFzXwbc6ekdAvT2vQjH2qxRR5EH3aqPMmDxreKifCnsWr3ovQlHRu0Z3cUhWld56px4rlxXVH
	Zy6luONinFMrQPB5fINZUl4XyjUtFTFcg7ks1F64aP0gsz3IfDOhbt7BA9DO3wbqp6ybN+NFiM2
	CUQiSyCWNfi0rlHLjAvY3JNIBR2e9tgGJF3OZm2t+B2AE35P8DC0BO/XF1qBYZFbEDC2fmoJcv5
	2QtpdKocwc66cbnvOuqUszH0311QguXqo7Ua4Qg14XtiE9LPu4W7DxXYnvFaDdFdsfV4U=
X-Received: by 2002:a05:622a:1820:b0:51c:ba4:d837 with SMTP id d75a77b69052e-52d5856d370mr12243591cf.18.1786438641976;
        Tue, 11 Aug 2026 01:57:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1820:b0:51c:ba4:d837 with SMTP id d75a77b69052e-52d5856d370mr12243301cf.18.1786438641426;
        Tue, 11 Aug 2026 01:57:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362e17756sm399788a12.1.2026.08.11.01.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 01:57:20 -0700 (PDT)
Message-ID: <cff4de4b-3a94-4a5d-acb9-726939a75791@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:57:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH v3] media: ov5640: select the MIPI lane mode from the
 endpoint lane count
To: jason98166@gmail.com, Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260811-ov5640-1lane-v1-v3-1-ae476eaf5024@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260811-ov5640-1lane-v1-v3-1-ae476eaf5024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f1j8XS1dBB8azLMQbbceYzPWRuC-A0nq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfX92Dob7G/lEdW
 aggFUEpn9/M/hELvwoelPP4ue2RoVluGzW2+3PF0kzbDOKTlkvD7DW1kQGHRUjs5Dw5WHlB9Gy/
 HafawCarGFdcfJD+1FG7nsEVLAD72CE=
X-Proofpoint-GUID: f1j8XS1dBB8azLMQbbceYzPWRuC-A0nq
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7ae3f2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=s5WTe2n68omTjJFxeYUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfXxhb0br10YJFW
 Gog95io/qys7j04RsJVBx58eBfZZLqxLN79gwXQ0m2TCHizR/5IcwwpJ4SZSpRrFABBAWXSuI5F
 b/bab10BAo5mHIUh/mmtAc7AD6+zt6OF219GyPK2CqT1pZAfcFe0psavRswnBsIJoFqZngIdTR1
 SKhR+JRSeEnMHP7bv93mbWjH7Dgi6xY7rQ3qiOCT+p3x9ssPhGNzfXui8yNMRVbLYfApCXIPzec
 7lU2F7nwMLrmLBd/BISDqzWvPM1furaEdo0Wn+Wq4qXc4RK+TDETEJoBcJezB0WzUvpHaiY75Yr
 sZpiTFfZFkR7AJ59NxVpCNLajhk6X5elpQOubrmVKEF3v03o+vuD6Lk8jSjFiFfDtBkrSAdq63N
 hUvtkyYTSY+WSmn0Ab4Kr3yULRJJknKPx2UJEepmDI+Lwy+9VmmPTsx9njdABbj9uBsE1P/XfC7
 LBipULMRpOOXCvJqsnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110073

Hi,

On 11-Aug-26 09:30, Jason Yang via B4 Relay wrote:
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
> index 8deb5f5501fa..18c3bb5498f8 100644
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
> +			       on ? 0x5 | sensor->ep.bus.mipi_csi2.num_data_lanes << 5 :
> +			       0x40);

You're writing 0x40 aka 2 lines now when turning the sensor off in 1 line mode.

I believe this should be:

  	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
			       sensor->ep.bus.mipi_csi2.num_data_lanes << 5 |
			       (on ? 0x05 : 0x0));

Only changing the low nibble for on / off and always setting the correct
lane count.

Regards,

Hans



