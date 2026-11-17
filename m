Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929795;
	b=Dt+g5cBDt3ulRU3BpT/NINdcVLN1+Eh22mCzmRkfwPil5nux74xy9Tk8+qPzoV1f/DAR
	 rh6tuMpnZO30Gy62ammRWNyL9yMxXIDgtQfIqykqU72ojcAVLHy3/ha0JX7eOydzhshbR
	 Pyrj741QNPJv9sWV7v49FT5vLpblmdbBINZkpwJIbyhvQ1CgZmmLfgAi1p4v0ufbujZz5
	 ssRQNV0ORdnoyON9XhDm6FrZDkRlueDB6hmF30ieIwc+FW8lye1dTeQhN2Mg7QqGlDKv4
	 1OdorBU5ing1OhtZmOjNSbmIeVgtjuXGldhbes+eG3qKxXHKeY7fb4nNlbeAnJEiHXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Iu0dxZTO8PcDzOB+6qCjf2Tg6FKjgEK34SzfNcCThyQ=;
	b=Rh3iTJ0syOr9vqNepHZ4EO+UoHTeIZDBmbys57oyK67JhSJkc+ClWenyuDBeWVRw5RkU
	 52hRdCu3NO/vDo9YSM/kyjb8sbGcVmmY5SXljKtCEiDr5XlVp1p74lKTpKkWW7cB8bDW6
	 byroTyIQbYlxPfdMIXr6cFaPzSZkYlbjSKv0Bh+kqUtu7xQSOyGRCVjdluSh4+GF7nvYl
	 kq6dCSqu2gdHDXF3x9Xb3eEHKbcY0PVtKWKUFyv2ytcdKudqbjM41iYhQp5fWDiISdPBu
	 4teiBJr9lVh099+o9ttS9qf6u6zjhtDuwSkxwi4HjjUuCZhNxqYQyrkZRjiC5kOgOBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=anHTQfGT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="eWbrFrw/";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FA60A3824
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E11FA60A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=anHTQfGT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eWbrFrw/
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQmNY3208054
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iu0dxZTO8PcDzOB+6qCjf2Tg6FKjgEK34SzfNcCThyQ=; b=anHTQfGTNUfJhltw
	JdjFJIw1vlt50liTTE6kzzm3wE6ww8FHTIic2iGqzuK2CJF+04/IfTPElzGT8eFl
	VRYt3GnTMHEp76+IUMgYCm4WYQzpVg98IBG47F+YX6rU7oegkq3PtMcfjEPaq+NP
	9+D/cpze7el9fxHT2uvvJW63o4Qk7oNw++enZEBVhIAXrNWjLPcXLNW0cI9PvBYJ
	n54o+5JrwwuwCgtGFQNLPf66HgIcGHDmqpdtuvFecu3V+rO9r8bSz4SMRxj/QWpS
	XjusrJWKWjcukmSJ2wcp3TAK8zYwTeBEZw0sVECBXdspfF73GPFWqrGtG3+29olq
	xUi1bQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0fjujnnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 15:36:33 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc3a482af7so3862212137.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 07:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794929793; x=1795534593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iu0dxZTO8PcDzOB+6qCjf2Tg6FKjgEK34SzfNcCThyQ=;
        b=eWbrFrw/UCkHtywquS+wnebU/CS265/ydsXk/BYIHDL1Qhlj4tS2l8dCror1TltJUX
         BBC36q+p69urs6rGkdp7mw6XxfoJsNt3agrQJG2u9+lmG+LlOtlA3jcyp/24Du/KZ+RD
         cIKfh0i4sUH8hiK0u5UMa9KqCzyK7ahuc1O5I7PyP6eCRAC8jIa2AzXriFXgBq9SFSmd
         0CePOkKV8smYrXe0TeXjKklcV1TL8sdDdJDbp+xBhVoisJ0HxsVhDlmI6QFeS8NQIIvi
         gHV4t4wv02/qTsdCM55nwx6oo8RFGK3ZPLf8y7bcXBxbWTYeDVwlY/CyY0FOgF70JFjL
         K3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794929793; x=1795534593;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iu0dxZTO8PcDzOB+6qCjf2Tg6FKjgEK34SzfNcCThyQ=;
        b=hon7Ppy1E7I/QDOjF4KCaL0uzBPh51eqeQ4vSYXX3w+FeztP3TjUj+2SvDT8TQl3rg
         +vdPcg5dDLW4KRBJONn4f12BoCS2tDQM9ENmeZ5QvRAwTYfXJfWYJUsGPD0lzJ+2XQbz
         y3qyixhe2d6P5zX60FQqQms2SxEhjOQUJWCwAS9767304rV+/bbgCSdBjAx4qWezkVNJ
         bClT+aOgFOhnKZqqWlNzg/UomY0PWART2gi8yFWxCaqiXV3U6CoEeRffy5i4n5VjtsVP
         qCo+gbdzUg+G1ktgN78YlcBi+kOGZCczZfXy96q4vDZA2FgyBXgbCZcldA5fQ1SqO18t
         2feg==
X-Forwarded-Encrypted: i=1; AL+hErFa2iei3hyH0yrxlBQ1d8MF7ZDIxycH5/hkg8culFLX0GuQhU85R/uzOEVfq5Wu2hXJ1oJVDZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AF/5RMlGAmmBRCzkAsvA4wLMiPgO7yCkIEiO6aXK+1SRZCd/Y
	9Me3CgLfD4v0mDYS79MyJOl6CdYn531upPpLTEzM3NfjkB+z36AYtlz829uGza0MNk9eHPXHrGg
	+3HL+E+NSlXmkYm2yAuL5HTPUr6ti1OoiuYfr+ykrkZqoAyPGCeL0CcgAGVJSiRsQ1LV9Jg==
X-Gm-Gg: AYBFou3cmX6kANKTmz6uzRWjbLW6R9YmjAqDlsTCnGbklEtT1e9+D7g6SDcDdrKgqt8
	+xHGOyJocF12iClCQajbK1FCllS2AS8nP0kRhE30mpbFtT70YIybHYXvUUHJkgi4SuPPoVja+NQ
	GT0j/qAOnGI+ILMO2+5ZIYYXT3L2tLrnYpc+OOxTKGB+2eG8jyEw2FEwT4aQudVtc+e+jtZ2S1f
	tXd2brc7YwlJaem4uYdexaCe9HZDewQnqKb797NIgGofqSZEWJVn4RVx5HWLOQWL0SS0prTwPVQ
	+OlVFxuiho8UE0eaADnYKW9pUPsbqnxX/lm8s9pG/Xlvp8x/jBIiypbn6kvn2qluhjo9OtVD27Y
	YoEBqYyFv6aCKS+WLTf53NBJhtM6z8w45/5nFc1wAyNNkkW/gxt5lujtBXroY6S3kvBjopqFaiu
	U=
X-Received: by 2002:a05:6102:5815:b0:7d2:7be1:271f with SMTP id ada2fe7eead31-7d64d8228camr6206095137.31.1794929792698;
        Tue, 17 Nov 2026 07:36:32 -0800 (PST)
X-Received: by 2002:a05:6102:5815:b0:7d2:7be1:271f with SMTP id ada2fe7eead31-7d64d8228camr6206081137.31.1794929792052;
        Tue, 17 Nov 2026 07:36:32 -0800 (PST)
Received: from [172.20.2.50] ([195.50.164.66])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb7839cad7sm80688825e9.10.2026.11.17.07.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 07:36:31 -0800 (PST)
Message-ID: <65e501e0-b6d5-4204-ba6a-2d35091e2ae6@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 15:36:29 +0000
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
Subject: Re: [PATCH] ASoC: qcom: q6dsp-lpass-clocks: Set driver data before
 registering clocks
To: yzddmr6@gmail.com, Srinivas Kandagatla <srini@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261115-upstream-q6dsp-clk-drvdata-v1-1-4d7dbea52e52@gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261115-upstream-q6dsp-clk-drvdata-v1-1-4d7dbea52e52@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX3+WXEeD4MpTB
 eBUSleHW0hSYSCEf+6vHmZFwsH3g1UPG2+VSjKrXQBCHCIae/bs+F5AWmHIHZ//nGSBUxuhLHdF
 Z/HXXJKgTbaRPQDwhMdMKURUp4B6jJ2i1G+OD+pQvDwABxhvYtuRpnMAH43aEUjCyej0qx1UQKD
 FRMTM7DmS6tMmUcTtcSNHYO9ns6DLj8cAyWysJHcq5pxcpgj01ibj+5JCsXrhzpOMb+EafyoJw3
 vaTk1YBGLsn/jPyRcDW4j02Lvo058PyyYXoOav3KU7ZmGoCnfyXtNi9vjARAm6k2Dmnl/Skcfmo
 AYxnjS70PlFwXP+RQPz+8KfiG6q2Bx86liegux3HQhSC7MNFmYCTuvEPq1IvGwih8nqq39kHkOM
 /7c53bDrgO/fomPkB/zPSZlkXEdIRpWEth5AkiVUH0F52VRZYGGYRtxzuBNzHOk0ZlAxh/GjK+V
 SKu4kfKjCNhi6no8Q+A==
X-Authority-Analysis: v=2.4 cv=JfIpPkKV c=1 sm=1 tr=0 ts=6afc7481 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mFCCqUHryluRUJtW3YUA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: olQiqHlpl_j4hOBQ2VtcRE9hawecqRjP
X-Proofpoint-GUID: olQiqHlpl_j4hOBQ2VtcRE9hawecqRjP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX89GodcN5cYLm
 TZDXfOwjyj9o4FtoMAIbWWMlFHHid6wlwCTg94tEvXnFbZl8JhHth401Rygf218pMBX43U4myrl
 nFDcvUtjDGtbZotEoAGFEJCrvvW2A5k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170062



On 11/15/26 1:12 PM, yzddMr6 via B4 Relay wrote:
> From: yzddMr6 <yzddmr6@gmail.com>
> 
> The clk ops of the q6dsp clock controller look up struct q6dsp_cc with
> dev_get_drvdata(), but q6dsp_clock_dev_probe() sets the driver data only
> after it has registered the clocks and added the OF clock provider. A
> consumer that gets and prepares one of the clocks in between
> dereferences a NULL pointer.
> 
> fw_devlink does not keep consumers out of that window. The q6prm and
> q6afe clock controllers are described below the ADSP remoteproc node,
> and their devices are only created once the ADSP has booted and its
> GPR/APR services have come up, long after the remoteproc device has
> bound. fw_devlink therefore makes the remoteproc device the supplier of
> their consumers. A consumer such as the LPASS LPI pinctrl then just
> defers until of_clk_get() succeeds, and its retry from the deferred
> probe worker can run while the clock controller is still in its probe.
> 
> That happened once on a Xiaomi Pad 8 Pro (SM8750). While the LPI pinctrl
> probe registered its GPIO chip, gpiolib read a GPIO direction, which
> runtime resumed the device and prepared its q6prm vote clocks through
> pm_clk. The prepare op then faulted with a NULL pointer dereference at
> virtual address 0x350 (trimmed):
> 
>   pc : clk_vote_q6dsp_block+0x24/0x58 [snd_q6dsp_common]
>   lr : clk_core_prepare+0x7c/0x298
>   Call trace:
>    clk_vote_q6dsp_block+0x24/0x58 [snd_q6dsp_common] (P)
>    clk_core_prepare+0x7c/0x298
>    clk_prepare+0x28/0x44
>    pm_clk_resume+0x10c/0x188
>    pm_generic_runtime_resume+0x2c/0x44
>    ...
>    __pm_runtime_resume+0x50/0x94
>    ...
>    lpi_gpio_get_direction+0x4c/0x8c [pinctrl_lpass_lpi]
>    gpiochip_add_data_with_key+0x7b0/0x10dc
>    devm_gpiochip_add_data_with_key+0x38/0x8c
>    lpi_pinctrl_probe+0x2b8/0x320 [pinctrl_lpass_lpi]
>    ...
>    deferred_probe_work_func+0x88/0xc0
> 
> 0x350 is the offset of desc in struct q6dsp_cc; the driver data pointer
> it was loaded from was NULL. The oops left the clk prepare_lock held,
> which blocks every later clk_prepare(), and the system did not finish
> booting.
> 
> On mainline the window is short, but it includes a wait for prepare_lock
> in clk_core_reparent_orphans(), which of_clk_add_hw_provider() calls
> right after listing the provider. The kernel that hit this had
> out-of-tree changes to drivers/clk/clk.c that do more work at that
> point, which makes the window wider.
> 
> Both q6afe-clocks and q6prm-clocks use q6dsp_clock_dev_probe(). Set the
> driver data before the first clock is registered.
> 
> The oops was analysed and the fix written with the help of an AI coding
> assistant.
> 
> Fixes: 9ab71ac37240 ("ASoC: qdsp6: q6afe-clocks: move audio-clocks to common file")
> Cc: stable@vger.kernel.org
> Signed-off-by: yzddMr6 <yzddmr6@gmail.com>

Reviewed-by: Srinivas Kandagatla<srinivas.kandagatla@oss.qualcomm.com>

--Srini
> ---
> The kernel that hit this was v7.4-rc2 with out-of-tree board support and
> other changes, including the clk.c changes mentioned above. The oops
> showed up once in the 23 boots of that kernel I have logs for, and I
> have not been able to reproduce it on demand. The patch is build-tested
> (arm64 defconfig, W=1) on the base commit below.
> 
> I used an AI coding assistant for this work. It analysed the oops,
> traced the probe ordering and drafted this patch and changelog. I have
> reviewed the change.
> ---
>  sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
> index 94d96130245e..c3628f90fdb2 100644
> --- a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
> +++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
> @@ -146,6 +146,12 @@ int q6dsp_clock_dev_probe(struct platform_device *pdev)
>  	cc->dev = dev;
>  	q6dsp_clks = desc->clks;
>  
> +	/*
> +	 * The clk ops look up cc through the driver data, so set it before
> +	 * any of the clocks can be prepared.
> +	 */
> +	dev_set_drvdata(dev, cc);
> +
>  	for (i = 0; i < desc->num_clks; i++) {
>  		unsigned int id = q6dsp_clks[i].clk_id;
>  		struct clk_init_data init = {
> @@ -174,12 +180,6 @@ int q6dsp_clock_dev_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	ret = devm_of_clk_add_hw_provider(dev, q6dsp_of_clk_hw_get, cc);
> -	if (ret)
> -		return ret;
> -
> -	dev_set_drvdata(dev, cc);
> -
> -	return 0;
> +	return devm_of_clk_add_hw_provider(dev, q6dsp_of_clk_hw_get, cc);
>  }
>  EXPORT_SYMBOL_GPL(q6dsp_clock_dev_probe);
> 
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261114-upstream-q6dsp-clk-drvdata-e09d27f289b3
> 
> Best regards,
> --  
> yzddMr6 <yzddmr6@gmail.com>
> 
> 

