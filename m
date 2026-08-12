Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7941CB5E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528114; cv=none; b=RqAnASMKs9OtfikV1Y7fz+YX8jlQ6x4mrJkxnEfVsoYEHhGM5MGyK79OiBhTO4NdKznNYViHc0NBxzPJgJFC4dx5TaEKAxHaRcw/ck0r3YLqW/pFZN7NPMHgQ9lFLKifqK1usK9rU+EzEIuoI8IujA+E+jbrs6ytE2Zz4CCdWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528114; c=relaxed/simple;
	bh=iaJUI/0XDvAWP+CA81WLf+ts9AvhQ1y2O/VPirV2m+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfDb8tEinkViChpRcuCEpiuTgsapXS3rIrBCYskTbNkslUGHXowXQoqdoBGPh3/bmKJl9+oebn36UE3fEgjdiLRa9zLLXResU4fkYXmr4E4xYBhbeRDnXGZE0ujJyCP5Q1iyzPjMEyjOiE3GJdeJPVeYt3TWFfvGSHsSlQGWyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PLN+1N8N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WBWwO98X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PLN+1N8N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WBWwO98X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9g1Ou3452296
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IM6yXMq39DX30NkVLM6SooXzKXIisePn7EGQ2VUuLjw=; b=PLN+1N8NUVDYJ3Ob
	AkzQiKCeVrtP8N+qV6WANuf/Y3cCi56hjsEQ3WyZHDyb7hmD9/h9SDQtsbTpNjk8
	PW8ZJTa4A0h4tNi82OoGZvW+x2b2vUAdX/XoaHHZ+giOnEu9M5/m0DNbrG2VCS8f
	BsOucgS3EczX/X2cRRmgHf9O2P6m4Gr014qAUEZklKbbNzVoyarlPGjVsRdQScq3
	Yg1We0jlcFepIiQCV+tFu3Zxe+U4lw9JrTSYt794klvz4veLZAGvRNO+utPsGdsm
	VKM3kGWKUYJM1hWYrIOVspsYnM7h2lPvVHfqAU/o8+YX/j8/h5ck/VfFkg7hZXZL
	4RKh5A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrh0sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:48:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedfa3898aso588292a12.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786528111; x=1787132911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IM6yXMq39DX30NkVLM6SooXzKXIisePn7EGQ2VUuLjw=;
        b=WBWwO98XuURbohQ++MrCRug9kaY7arY+cAAB5002ejqyARXOi3reCcImW9QYQW+p5F
         cA+JF9WSYg0QXVpl3p4l+SgvZQHnE+VtR+kcu2y6YXaD+G33GOlNvssEhPoa52nnxEXn
         5oYdAsqX618Q+mbHTYSp7oDgEa3IZlPLAuGRVXFSW3tqTEvGfyX/lUvcNr3kC1dCv76g
         Y691YJLNpCAWvIhbD66Gd6XgkxepSn7aMLAKpPd9Kn0Y7PClUVruzO+K8uoAizhim00i
         boMaCZ9xrdXJMdjBhR+IU7PB9Ihqx8moNnKr/rmF17JuRmJ2stdQ1vnGiquV4f9gnbc2
         gG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528111; x=1787132911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IM6yXMq39DX30NkVLM6SooXzKXIisePn7EGQ2VUuLjw=;
        b=oOBtyQ2p+qZENKT3SMyqlm+KfkfiomUaec8lLLz2RZTx6z8y4BA6o6Giqr7z02aBch
         Y6t5VQ0kWKMe6YmdaTlnJVgJFfMuZoziOUn5oCjsaB2euDbgvKw4QGF+uG6eJGoEMp1d
         xnkL9xKFW/6kBAg9wcazmjzzV08+7Gp5lYl3fbSBON8XTmjMHa40+0Ltr4XiqY/hVrhV
         OmmDakUCa8TXuDNrvnUrVWOaynxLdwac8DMPMo9EouAFtlr6Sx69hX2fukQUB8uMVw15
         v1J60UzBtF9X7rLCaOWquD5wQ4+zmNHmp7+7uMPMNzTO4BbhINVyhPJNkppg9MrBnQ76
         yVBg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4Q/0WvOjhAUPTG+OXuP4rpjrBkPYBoy8vAmcHypiVyy9ovJ0W31M7xKiN3lqHtNLdtPVBuvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIv7xcNl2zpDDXsxlHFvijrRICKRQ2hm64u3si3MidBKu3/If
	56F84IKrRx7Mk2lVUbHw11Mz9xqEIxskGebQkVlTMw9lV1v6geMvMR3C2rtZq+WFUOsY7VXwkc0
	J5ZHZ++iONSqs9GlmRfji3DS/pEb8YvRAylziOmdq6rfakuiw6VyLrXIG8PQ=
X-Gm-Gg: AR+sD10cposD6/frVu1H64LKC5ULcCvCo2rtKuy0WDarNmkob2Fvelsc2PGd0Onmlab
	8a2pA9y0Obtq7/+H/kmHNPGiheMXFqa9wf/Y9QHrejjmYZmbIqegrexDkCIGuHfqxylxBclS03m
	GMrgLbrRmAG4lu0BsWHVwlNKMyBOaY7ADXfDXQzFbsvONKam7JgVL7MIpCfbVjEQrxGFqjH4yyV
	pjp/xBCnZ9SuU7H4ixsQmLzamZ0LSsadEs7rpSXDxOVQMXGq/d+d5RmHtBqDihGDMtgYgHt7o2y
	AMcqzuYYUJoxNjd2zLX5twdZz9AfEBwpMPzgpkwxsNxLglUYE2GGutquM+VXPDk2Inm0nZQrWc2
	1pNfofY9zlDh+eJlrLDVenCgvXhmH8o4no3Z9Lbm0O82FUNwhibSR0bxM7ze/+fv0hKrs
X-Received: by 2002:a05:6a00:2386:b0:848:4ff5:5316 with SMTP id d2e1a72fcca58-84fb54dcf49mr3751742b3a.19.1786528110517;
        Wed, 12 Aug 2026 02:48:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:2386:b0:848:4ff5:5316 with SMTP id d2e1a72fcca58-84fb54dcf49mr3751698b3a.19.1786528110077;
        Wed, 12 Aug 2026 02:48:30 -0700 (PDT)
Received: from [10.217.219.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1f2645bsm731052b3a.50.2026.08.12.02.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:48:28 -0700 (PDT)
Message-ID: <0802e0ee-499d-4f47-a8d9-1a6eae635ff3@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:18:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
To: Jiazi Liu <jiazi.liu1984@gmail.com>, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Jiazi Liu <liujiazi@amazon.com>
References: <20260727092258.1121-1-liujiazi@amazon.com>
 <20260812082127.79610-1-liujiazi@amazon.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20260812082127.79610-1-liujiazi@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NyBTYWx0ZWRfX7lqFrSvjNv+V
 pbBQbKkOXSk46yqRMMjNgAOWsE3TUFyqMJr05CT7GUYTiqDxV/C8GY1W2s1C+29g8F9o2IBM30v
 XYSW81LIMbSlt4HUjHgYfXfqkTpHAF8vfopQVnUJ8CEIbJJECwidYWXANZ8ZsrSfeZJIm34R7oE
 O0Ic+dYKaz+axDN+qPthEjPK22jaD7T+zK6iT+tPf25khFeM6KmL6QC9ZKoITfuwJXDYR4GDLpv
 scdNeXovCjVAwZ1BpedsWqTyK8RbnDK/IMRGb6GLLS3jASJcJrZBAKug2dzt86sVy5uRX1ncLVV
 e8Xo5iD3nUT5nNWr0lUTHvx6+fnBdahXh+vmHMjwoBUxIwtl0ELZi7wbiYFz4kzUojVWshfowoi
 HQekwjjaw3Rb5BL+MlxvOMOdKfVRETSTtC92ekk8pfFRqOuXj8n6RGkVvlG1gkFJRFn1Vb+edat
 xVBl4Zjp+zDO4RY9tsQ==
X-Proofpoint-ORIG-GUID: Pjbcmy4Mq_2d0UZoetdIRdFd0hUg0zU8
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c416f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=fsXfUb1GuYEfvJEzrroA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Pjbcmy4Mq_2d0UZoetdIRdFd0hUg0zU8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NyBTYWx0ZWRfX1IRDahVpXw2w
 9QRCeQdeUtNAtEbGafxvBN4kbBxLPNKXEDC5l9ZLrN6DW684W++9TQwowVkLHWPZolgphXshc3X
 IGeVGRIqg0YJXig7SG7Xp6rmk7Ox5iw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120077



On 8/12/2026 1:51 PM, Jiazi Liu wrote:
> From: Jiazi Liu <jiazi.liu1984@gmail.com>
> 

[...]

> ---
>   drivers/usb/dwc3/core.h   |  7 +++++++
>   drivers/usb/dwc3/gadget.c | 41 +++++++++++++++++++++++++++++++++++++--
>   2 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 608daeb7ef10..b1cd888eca77 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -49,6 +49,7 @@
>   #define DWC3_ENDPOINTS_NUM	32
>   #define DWC3_XHCI_RESOURCES_NUM	2
>   #define DWC3_ISOC_MAX_RETRIES	5
> +#define DWC3_ERR_RECOVERY_MAX	3
>   
>   #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
>   #define DWC3_EVENT_BUFFERS_SIZE	4096
> @@ -1004,6 +1005,7 @@ struct dwc3_glue_ops {
>   /**
>    * struct dwc3 - representation of our controller
>    * @drd_work: workqueue used for role swapping
> + * @err_recovery_work: workqueue used for controller error recovery
>    * @ep0_trb: trb which is used for the ctrl_req
>    * @bounce: address of bounce buffer
>    * @setup_buf: used while precessing STD USB requests
> @@ -1171,6 +1173,7 @@ struct dwc3_glue_ops {
>    * @wakeup_configured: set if the device is configured for remote wakeup.
>    * @suspended: set to track suspend event due to U3/L2.
>    * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
> + * @err_dying: true when controller is in error recovery, reject all requests
>    *		  before PM suspend.

How about gadget_dying or gadget_died (similar to hc_died in xhci). The 
variable "err_dyring"is misleading.

>    * @imod_interval: set the interrupt moderation interval in 250ns
>    *			increments or 0 to disable.
> @@ -1186,9 +1189,11 @@ struct dwc3_glue_ops {
>    * @wakeup_pending_funcs: Indicates whether any interface has requested for
>    *			 function wakeup in bitmap format where bit position
>    *			 represents interface_id.
> + * @err_recovery_count: number of consecutive error recovery attempts
>    */
>   struct dwc3 {
>   	struct work_struct	drd_work;
> +	struct work_struct	err_recovery_work;
>   	struct dwc3_trb		*ep0_trb;
>   	void			*bounce;
>   	u8			*setup_buf;
> @@ -1420,6 +1425,7 @@ struct dwc3 {
>   	unsigned		wakeup_configured:1;
>   	unsigned		suspended:1;
>   	unsigned		susphy_state:1;
> +	unsigned		err_dying:1;
>   
>   	u16			imod_interval;
>   
> @@ -1429,6 +1435,7 @@ struct dwc3 {
>   	struct dentry		*debug_root;
>   	u32			gsbuscfg0_reqinfo;
>   	u32			wakeup_pending_funcs;
> +	u32			err_recovery_count;
>   };
>   
>   #define INCRX_BURST_MODE 0
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index fa0f16ffafef..05f3ffab6e47 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2054,6 +2054,9 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
>   
>   	int				ret;
>   
> +	if (dwc->err_dying)
> +		return -ESHUTDOWN;
> +

Not sure but should this check be added for all gadget_ops ?

Regards,
Krishna,
