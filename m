Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A33370D5A
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783856122; cv=none; b=I7comI26jkGCG/gwjNJtlNYvDHN9JEYBbCVIE+Hx/FiXhjvurdU7MwPRz5wpNimYYS6FX2wV3GtlRU6pQXQZpeG2s8zYeWTU+GZwozcYi0S6DqkWJi/BPlp+aw6LP1IVq1bar84PHW7ed5fc7BzyEkhN832dCievqSQ2Ey8P+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783856122; c=relaxed/simple;
	bh=VEamrEOXXhdzQlCWpYBcMhoy5mxqJ/BZr3QvXAhRTXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtZYVvoIFiaAUcD1L1KiNQjpERaoe5Gp3MeQBePwjDiecyNZ8YVWI2PE1+oaF9VphCGbfj93zTgm743s5kePHq139BsMsFe4TjqKBeguptQlXpyj01dtwyVOnC2FV9PPsatck3IUlXpaMCYwsuRu+0vvhohOXrGv/gv0/yi9Noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RBT1c7RP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bCriuF5B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RBT1c7RP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCriuF5B"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CAcFX12370801
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 11:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C/wSXBBN4gDQlGAHKupNpiLX
	9M+PtyJNTEFTUsKADHs=; b=RBT1c7RPzYBAedGXHdXmBTnwN5FnPZpHPQNSL5G1
	hyEafsAKOXd+T/QugnDyvL8xPk2jEO/eOLfLu7nJXq4VxouQjy5+6MpVnXDO37Qg
	BqKwlulzJOCN65RxXSTeOzbQOmEyDRIdFvoDSYcXD153X41BvoNKeVh6TJ5apDkK
	/x9V4o7LjHyiihA1WyhZAazmRt/PIYvH8P89oe9QH8//OB8XNQu9TswnO9QwhRD8
	/8yhKklJcUEu/btJ/L7k1XGJg0d/ZbLPZXevRRSkxzgeGnkAEc2+0ijkVqKVhwqc
	kWJxoaI+RyTKV2QMsl85uQrt2151mjqmli1aH1/1Uhqmlg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr2km4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 11:35:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so32059081cf.1
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 04:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783856119; x=1784460919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/wSXBBN4gDQlGAHKupNpiLX9M+PtyJNTEFTUsKADHs=;
        b=bCriuF5BH9UYDQ14VEHf6IpLgfJYjH8I8/DEISPgagnDk6WDLV+56SgXMv/hSge3M8
         ittjeetExna9+BKIN/cxJrrSCH8AhNf+BoDe6ikR7xvPnZbIz/jyrpduuNtMvi49t5O+
         Ha/jrdG2MAF80TM4kW/SJxeVuaFS1d4c5kEpiXwblmkHSIIxIoEiDfdce66CAq72ic/Q
         qNtebarouoe+E+4LpHrgbXzR3XjIkXwRivOtjwMWk2u6Gq/baYC1qwPWZTRpilf4ITqV
         fu95xUzk39v8mvOmQhcHXjhRdnAsxWbMnoUVmd1PjOXdkHrXDeK/dEFSGxrv3sqTNTLp
         mGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783856119; x=1784460919;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/wSXBBN4gDQlGAHKupNpiLX9M+PtyJNTEFTUsKADHs=;
        b=L6oWf40EznwMCt267vcVjrQQ0U6s46iOMkCCNXQCc5z9UYqwgluz0BFZfq7JSu13Fa
         m0C6HagnU+HviXAxASyRyKd5Z6cqGF+ARUEO7n3ihmeWluTsMzwnf/gk4ao9retBZum6
         qYR3afWP1yTYb5vcYK+XyJuWwUmujoLMhdGVghO+UcKoBRJmMzXEdDARt41vzqXF/X2d
         R3bz85vXVeNHpuXKD3kcZ2a5PktfvQVH18du4+1KV/PuzRpyJI2hAmEuSNPvXaLNVPEH
         dMIsSmLUz1co/Lbu+AxjmeF+VD1/jxjCGK1MqkpoCaDbZ8V5EXsRt65/LB/Ed5Hi0sqQ
         Ih4g==
X-Forwarded-Encrypted: i=1; AHgh+RqQlT8FrdWrxhpx5mBwW1OT+PSgZDk2/T1PYSQ34R6srL6qVzxi3y99bAWK4Qu4CyVIkOUxRJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1aXY/gRe+jfc/JTWVVluUNxzIBP+nQK/JeN2x2FDSa9u+zoM
	AnBYlonU138J51Y18k3V4MbcuSlEWLZiJ6bt6gZa+hU+/7JoAxJLOPHg0oCO319dOXFDnQvtDWX
	aU1u3Z3IcJZSxCSZDqaMCSBlkBwT8hy8rgQDsj7wc7DBKhqlvWDtqqmVAA5Y=
X-Gm-Gg: AfdE7clcg3n+kb6Vu2XxnQ9A3R8/LoKPOxyNSq3OGGmvGzemd5GrkxK53LS8HVpCPZl
	fLPkvF9QGYPrEpFYksNN/0IaVUJagFnZYeeQojwADdmWYF+7B+sZgc2ieyPQl2lw7WSomtZS+Xj
	lvHe02VO6VcZwfdUd5xcsOaKp0aCnmuf3szOWwxvhOWcwI8+P9nt9c2Q1KvBvjiVZMrMBUnG+Ii
	coXRvHG+KSejbXPtQXrfHXUJNnq6aqbqzRfclD2TaMKlTgZ0oq2L8l05KXiwMkK6wQKKVjzJWMe
	wT0FUsugWxLTD901ua1XrThvJ9QT/XiePZ3J1+EDy2TDPkiDnJ3vx/lsXTWuUxqf0RYG5BE36iN
	Izq7fnDO6z31mO3SzjFxaCqUBu0fkUKkPqcRAqFh28qxtienkCtZLK4vn6DMilgEcz+5waxQCyJ
	lqj3oajXsIQ7zYreYoKn4IfRW2
X-Received: by 2002:a05:622a:54b:b0:51c:1f97:e852 with SMTP id d75a77b69052e-51cbf0e00d1mr55823811cf.6.1783856118749;
        Sun, 12 Jul 2026 04:35:18 -0700 (PDT)
X-Received: by 2002:a05:622a:54b:b0:51c:1f97:e852 with SMTP id d75a77b69052e-51cbf0e00d1mr55823491cf.6.1783856118185;
        Sun, 12 Jul 2026 04:35:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca5002fsm2010096e87.27.2026.07.12.04.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 04:35:16 -0700 (PDT)
Date: Sun, 12 Jul 2026 14:35:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kavan Smith <kavansmith82@gmail.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] drm/msm/dsi: round 6G byte clock rate to the
 PLL-achievable value
Message-ID: <5zcohpmyufznjrqvs5iqpcbsziq7fg47e7rsbj4hndrcp4c4po@lgc2kunzwwd3>
References: <20260706180753.408753-1-kavansmith82@gmail.com>
 <20260707013240.681012-1-kavansmith82@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707013240.681012-1-kavansmith82@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDEyMSBTYWx0ZWRfXyYeWBfLPLBmO
 gdfpktNdTFlCsyMIYPIXuXW7appInJYeG83STeuV/o/BSqOddfUussJ3AIEPkkneiMh6cu9/zQ0
 1nMFwJFresB9xMQxC3q4LmwBpncGD6g=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a537bf7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=S4yUXPuXAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=chEMFHXW5F1Shr2T6d0A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=uB3M1fsSz_FXjR1IXk1m:22
X-Proofpoint-GUID: iGwXTR9RvjSovJL5yHuwA0NbhqdJePiJ
X-Proofpoint-ORIG-GUID: iGwXTR9RvjSovJL5yHuwA0NbhqdJePiJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDEyMSBTYWx0ZWRfX/Xmbb4o08MKQ
 9sDsT+E+9BkHDj7BBtvOESR2gtiY/uyV09A1U7WwEVlui+KtN1hl/An3NNOtdqnccU+r/B1FxcC
 C8XyGWUztY3l/JV8KuxMnOgsNs8iL2YV99KgLZ0Dz2JFN4OWc3TgTjY9HB0gBBcEFx/DSgufxgH
 E3zSmjFGGjWlG+XtRp+lUkiqRbPXZRncSIHHprfBWnVAEt/eIsVC6Hc1tRBSxgv5wdwJxCmrAeX
 HNIy/VoppwCIBOjh6sFY0vPUHyfHboLJ/j9OSBqfcYQhIaue5He8rYPOs57gT6FVPpYo1I5mqdw
 MwFcHO8loTULLptXHXGV4eR25AaNsvbtKw6rxUy7eHzg0BZXXmPx/FnCNZGhAFB06zwfhGXI1D2
 EHyGMFFcxMrr6t3QbqG79+2LnQ4XhsEP5/K26/ylZGJTAs2hXtOlDLrH43JQQpDL85tW+XzUoAl
 2e/03YZ/NDgUX61XnWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120121

On Mon, Jul 06, 2026 at 06:32:40PM -0700, Kavan Smith wrote:
> MSM8916 runtime DSI commands still go through
> msm_dsi_host_xfer_prepare(), which re-applies the link clock rate before
> enabling the link clocks. That is fine in principle, but on DSI 6G the
> requested byte clock rate often does not exactly match the DSI PHY PLL's
> realizable rate. For example, the driver can request 56250000 Hz while the
> PLL actually runs at 56246337 Hz.
> 
> Because the requested and actual rates differ slightly, every later
> link_clk_set_rate() call is treated as a real clock change and re-locks
> the PLL. On a video-mode panel without an internal timing generator, such
> as samsung,s6d7aa0 / lsl080al03 on MSM8916, that live-clock glitch makes
> the panel lose pixel lock and visibly corrupts scanout on each runtime DCS
> command, including backlight writes.
> 
> Fix this by rounding the computed 6G byte clock rate up front, before it is
> stored in msm_host->byte_clk_rate and reused by later transfers. Once the
> host carries the PLL-achievable rate instead of the idealized one,
> repeated link_clk_set_rate() calls become no-ops in the common clock
> framework and no longer re-lock the PLL.
> 
> This keeps the normal transfer callback sequencing intact, preserves the
> OPP vote path in link_clk_set_rate(), and matches the fix direction
> suggested in the original 2018 discussion.
> 
> Reported-by: Daniel Mack <daniel@zonque.org>
> Closes: https://lore.kernel.org/all/1a682c5b-7fc9-3aaa-120b-64b239a355a3@zonque.org/
> Fixes: 6b16f05aa39f ("drm/msm/dsi: Split clk rate setting and enable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kavan Smith <kavansmith82@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Don't send next iterations of patches as a reply to the previous thread.
Always start a new thread for the new iteration.

> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index eabdaa4..5119862 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -603,12 +603,24 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  
>  int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  {
> +	long rounded_byte_clk_rate;
> +
>  	if (!msm_host->mode) {
>  		pr_err("%s: mode not set\n", __func__);
>  		return -EINVAL;
>  	}
>  
>  	dsi_calc_pclk(msm_host, is_bonded_dsi);
> +
> +	rounded_byte_clk_rate = clk_round_rate(msm_host->byte_clk,
> +					       msm_host->byte_clk_rate);
> +	if (rounded_byte_clk_rate < 0) {
> +		pr_err("%s: failed to round byte clock rate, %ld\n",
> +		       __func__, rounded_byte_clk_rate);
> +		return rounded_byte_clk_rate;
> +	}
> +
> +	msm_host->byte_clk_rate = rounded_byte_clk_rate;
>  	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
>  	return 0;
>  }
> @@ -2056,18 +2068,7 @@ int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
>  	 * mdp clock need to be enabled to receive dsi interrupt
>  	 */
>  	pm_runtime_get_sync(&msm_host->pdev->dev);
> -	/*
> -	 * Do NOT re-set the link clock rate when the link is already up and
> -	 * streaming. On MSM8916 the requested byte-clock rate never exactly equals
> -	 * the DSI PHY PLL's achievable rate, so clk_set_rate() re-locks the PLL on
> -	 * every command. For a video-mode panel with no internal timing generator
> -	 * (e.g. s6d7aa0), that clock glitch makes the panel lose pixel lock mid-
> -	 * scanout -> ~1s of displaced/wrapped image on every DCS write (backlight).
> -	 * The rate is already correct from power-on; downstream MDSS only refcount-
> -	 * enables the clocks here (CMD_CLK_CTRL) and never re-sets the rate.
> -	 */
> -	if (!msm_host->power_on)
> -		cfg_hnd->ops->link_clk_set_rate(msm_host);

There is no such code upstream. You are reverting a code from v1, but it
wasn't applied. Please don't send iterative patches (fix for the fix).

I'll drop the chunk while applying, but in future please don't make
such mistakes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> +	cfg_hnd->ops->link_clk_set_rate(msm_host);
>  	cfg_hnd->ops->link_clk_enable(msm_host);
>  
>  	/* TODO: vote for bus bandwidth */
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
