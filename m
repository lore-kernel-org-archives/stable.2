Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921D27144B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139811; cv=none; b=GUTpf+FARaHOlPF8XzooZwTBoNvPR9nD1YCoM0Gp4k7gwoU2+CaqOImads8MDrlbxVkNK9bUBuC0Sccd1nA/bP36Wp+lXqxljuQJcKOmRb3FXtgy74zMV8I6DQ2fUmj/wa4NQwFYVkfZ+o45m7Cb0lpaMLgMlDkpyFxazK6hruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139811; c=relaxed/simple;
	bh=9HG4Myf/MzWs9emqrTUTe94JsB/+FQptg2zAqa+Luow=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S5BWYIQK5tNVEuyH/ZnP4UdwP7B2LbIY49S0oTB2a/MKxGTTxv3bAHnlJgNbmatQF0I1EhYHYS49fbec0NUiE2gXncPovUpq1HHAW1xssQ25JdWFf/QLESd/93BGErNRr8qJOyBESWlW/qCWBB5VserFlEUeBWnwou58dm9WSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V1youPMe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LnRYD9sq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V1youPMe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LnRYD9sq"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G89ux31675912
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c+kSbfg7kpwZHurr+6X37ZZoLppm6N1h+AqBcwmBJ/I=; b=V1youPMe/NMdLUHq
	GhFg0qBfvL8z8iW47Nxh+ypDCp+BuJNy1bvhlW3YNkNjd+2Zuz9TFXKBBomewrNA
	86Vq1OPH91NOLHsQ625Cigsj1gP4X3oOnEk7XS3GjQ5OWivQYbGAq+USkPwgS7jL
	8nRpaQxvkskmu94FWNyvE/5swp8AAJa0b/yOigaSrIutlY45YU6OwPvPKhGt1mKN
	0mx+XU49r6mJcfEpGH6BZk9GMlvvG1spMadclrwr/ydy6HdzQ9ySb12h/jDk0ltx
	DlUkz7wM1sW+/rZKwbImc9Fe87wWp1M7084E4R64ohV+gS4Rb61N8eJRd3/rKPxe
	PWIg3A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yr3dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:36:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510d0baf63so8771795eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792139805; x=1792744605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+kSbfg7kpwZHurr+6X37ZZoLppm6N1h+AqBcwmBJ/I=;
        b=LnRYD9sqW+ya5/09NbL6B4cF7TFTxhgtPOC2GtllohWRemImKpXh+QMsVsBboi4ox0
         8ZWsVk/esfdsONVZy6d/e3uythZHkoP+IiwHYw7Bye6pdXkiOAgelxthjLw86odtRf2S
         wdVkkTkIpMVOPIqb/as9l+QZVa1DvOdKuLVl6kXgrXFCkqJutvtyV2JTsvr7CoXXU0Gl
         otmCB5zvRPbg5HfOa4qhqDLLllNX92kBjUEySSXlzdMNuzkGl8JyydaOkUDtHjeFIIvA
         QCmLQl35Z/jkXQIJP7UaQvQLlx0Cv2TaEgBiuziLIseGFK5cFJey7jhCt4jZyOjevMHV
         BOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792139805; x=1792744605;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+kSbfg7kpwZHurr+6X37ZZoLppm6N1h+AqBcwmBJ/I=;
        b=oa1Q5v08lRIU5vVBsZur0YIXDKcSJb3tnhckNICMpqvD/EUY+mVE6fkOis98pVJlEX
         GBPK3cz5UtxqrMwOhwOezEvewN2Hsk/b3mo/d6P3Oh5zivDcSHUy+RTx6ZTFGRrLMJeP
         D92O5h5mp3WTf1aQEzh4UR9bZM+UT89DWuK05zWyD2IYjn5rtZwtG3reCZ81Tzshjzpr
         ouFcJv9g6a66u3ytZR2RpzGvUcR8eoiiPvMQmpD6Evt/Y/aCa4s591AJ0KINLi2U9nln
         obZl3OwnR1hmYzey0NIsmJpxSnG1d3iuUB/gEOb547X5wmiA6MuXs82ffEuT4RKtNL+b
         Ey9Q==
X-Forwarded-Encrypted: i=1; AKwUvBz5K7PcgMB4Fblzd5mRDt/eO7BoCaouAIYZGGzz0+HXb5n0TyVz/NREyLAu2KFPX+aZyUzzIjU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSm3U6SvzfFPlhmpUUiGBTlBTNbdU6wFu+51D2P2c5HidT/PvL
	KXC59UdppEVbjXm+/WJYo8FY4kW7sQM91kisEmAcr0yatJH8v64zh0ZVPjVEY7UqaPo0PFC+4va
	fLtBJz7fQHuIuECWMzlgCeljmPx4qBeolup5yQ5VKGMFtrQVQ3q696SAJBufqjOkkrGc=
X-Gm-Gg: AYBFou0IDJVm049vLNlvjHPZQbBxi99xUIULbqjWsneVLI320mBpZTX+BzUNF5Mlj5R
	K6ZefnoFVO7ooqDvXEmMomWwj31+6hPC/olPX+Ggzk/MXRizRXUwx5XcO+IEVFvac32IFqu0f1c
	owQvyclnDbw5RIiTVO+fgmwSFjycN3TmF7gpIIEm45Rjnw8dsplCY5j9hyTUTO2F9gkMfzZbACT
	m65qTPEmav6pG7nS+ZCeEKTLyOzG7pYeQjRLUQrDjkPs09RweJXcjqxhS/ViZiHuWeAsN1NzWZ/
	1FJgqJ4NMXIvLPjBsMrxem2/wG6n60jw8N8L1sypGXZgooACVcPlttwdc6ATYSpHX0Nkj0ysHrs
	gylK6TAzGk7PE5sb+8z9EwFxsgfjWwRYjRnWVMpkwE+3gtfOagdOiP8ULpBK3iVAiE6d4
X-Received: by 2002:a05:701b:230c:b0:143:2967:c0b1 with SMTP id a92af1059eb24-16a5fc91121mr29418798c88.25.1792139805054;
        Fri, 16 Oct 2026 01:36:45 -0700 (PDT)
X-Received: by 2002:a05:701b:230c:b0:143:2967:c0b1 with SMTP id a92af1059eb24-16a5fc91121mr29418745c88.25.1792139804035;
        Fri, 16 Oct 2026 01:36:44 -0700 (PDT)
Received: from [10.217.219.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm5065302eec.7.2026.10.16.01.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 01:36:43 -0700 (PDT)
Message-ID: <9119509c-5c04-4b9e-ad50-b5b967c92ff2@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 14:06:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: Re: [PATCH] usb: typec: nb7vpq904m: Set client data in probe to avoid
 crash on remove
To: Chaz Bailey <charles.s.bailey@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
References: <20261016080517.156248-1-charles.s.bailey@gmail.com>
Content-Language: en-US
In-Reply-To: <20261016080517.156248-1-charles.s.bailey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y1rREBuG-icPEI2vMwu7Qid2DxLTqz9s
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad1e21e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=TLsWTiBSdCI7Qt6q:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=vfoRuJi7s0O6CHqACCkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfXxBW6EHXL4LgP
 d6v2DiZTzvTjZ+NVdBx9rc/IZ4cNVEcVwPYA41VybOTmqTPE1N3tYcJwfvz587a5fxJ/WuaQEnw
 XxyScOEnVLqnRVIbQWRaJtGhDnx0oew=
X-Proofpoint-GUID: Y1rREBuG-icPEI2vMwu7Qid2DxLTqz9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfXxelkdMiZvvJZ
 X2Qo8UuGnv50wIWxDa3CKrytJj6r8m43HzgsDZlS95nD3gzOwtEZ5U2XGW2oenKlWOG+XquYqDN
 da3ymabSMq/Et8GFfFAIsYFkEoT7YeNK+BBmdzygpY/BPJL0ewq5PYFAZZuw6n4n86Zg5XkS0I9
 fYZuYKiIkB56X7/BRR5fH+Bc/6a2fF1wavb63NknbQxK074ewqSCUv4M8ESFoW0moZWWSjK1z7J
 q4GMId751WghL6sU0aO5KUUTMMFj/kkCD4Jb+XTD92Ck6f+RTcTDHQJSL8lJluRRX8Ux+sYZDvl
 QURMz7NVpDIkUnYzf8+P6YE5SK+ny4IH7CVK1etStcIEafiixnEmfCm3IB2abY15PlwbPX1tYxi
 HET7l+sBCwedzIsscDcQOEroBhH+es1jEdbJdunQlNUmEMwgUjOsygZ8r+4Bh2KOrJugg0bJxq9
 YEu5RE0aDs0jpe1ZAsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034



On 10/16/2026 1:35 PM, Chaz Bailey wrote:
> nb7vpq904m_probe() allocates struct nb7vpq904m but neglects to call
> i2c_set_clientdata(client, nb7).
> 
> In nb7vpq904m_remove(), i2c_get_clientdata(client) returns NULL, leading
> to a NULL pointer dereference when accessing nb7->retimer or nb7->sw.
> 
> Set client data upon successful allocation in probe.
> 
> Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaz Bailey <charles.s.bailey@gmail.com>

Minor nit:

Instead of "neglects to call i2c_set_clientdata", mention that "client 
data is not set during probe".

With that,

Reviewed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

> ---
>   drivers/usb/typec/mux/nb7vpq904m.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index d1fa26ff44..52e3c9db35 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -396,6 +396,7 @@ static int nb7vpq904m_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	nb7->client = client;
> +	i2c_set_clientdata(client, nb7);
>   
>   	nb7->regmap = devm_regmap_init_i2c(client, &nb7_regmap);
>   	if (IS_ERR(nb7->regmap)) {

