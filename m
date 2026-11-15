Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794736846;
	b=bZX1ZVWhDN8HHh74TU6SuwsG2Ir3qdYag6UBzF+blMFtn8ypvyPkv05R3PP+KCKqCkvW
	 QFylVxNXrktOgTjwHVaJNmhLirJMzCXHNax4+3IWcEa6h6XHkYrgk/g9t8Lz9VCgwjB9d
	 lNgFP4bPuTOQJzDUDKaa6IYG7uST4pu2VVief3e+IwSQBm9DbJtFyDr7uwKygJFIhhM9T
	 bdvDog7y4KsSc/M1g6cNNipe+PBUHq8xr7r3/bvn16YbPrq341TwH7OOaUUpP5+62XuFJ
	 4TZgq3/LW8s5r1LDliE79gTh0mEwLEXMVlsXK24hnw3VoT+Q1Zca5wVuzvskpcBsqDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736846;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cx9pCkxTEi+9RmZrKlW2vNSTCfm+MruumfTTeAoZOe0=;
	b=lPYG4Xs1KGYpUIwtnKALaDsX0zI8f+tyNWrFNcWz8JIcJfba6URd9DznWkrUtB7uyVLM
	 0kpC5GR5bUHjmA4LczA27Kin/zUPNJz4KMEGYMumwfDg+hkU0RET9y3qjFWXemf3JokRF
	 w1KuSKdXI0EkrmKPRc70USQ2xR0gglLlfUiChP2pKwsNQRS7c4ILk9jWXmZ7crxUmURTw
	 dy1fu2uPy7+nSCdNT+056RCnv8JaT6dOOoObje1xEfrQ9fFnyz9u54jo85KkoUHAjRbGi
	 Rifoq0lSCypBqPmy42HpjoGSeeiR7R6yiJjJuElKs7dtQmgRI/uVg3NYEE96LF9+okQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3BVvFhq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GjAoYOBc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C61606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96C61606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3BVvFhq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GjAoYOBc
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF7wFeZ1195813
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cx9pCkxTEi+9RmZrKlW2vNSTCfm+MruumfTTeAoZOe0=; b=P3BVvFhqucobJ06o
	Ij2JVoufRZ6Ra1Y+aSoyUCnFZzTR8u8jTAYcMAK23l+KtpYjiIktn7R7WBOS/x+A
	EeBxUxViCUyuYiP3FUr7TLb4AbiJv6jAn8ugZZhWFPGhr78/Q0gtapk7yPQrnwnZ
	vDQgfuf+1dT89qYrYW8j2crR58Ix3X0XRw01dI3sogDX8XE8iiejf4xJ/8W8u0Sf
	0wGCbbaJcRpQrVdW6gLi1Kq9guYLNtbz/Y8P5eR2Bg7BJ36dWWCeWoDr1WvX1gZH
	31xNn6L1njsic74BdJ5SyaQoH+L1Ml9UZmxXTv6B/9m83SPSgwKnkAZdOk8f0ne9
	GSNhmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhjq59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:00:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f6f4fe531so449026185a.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794736844; x=1795341644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cx9pCkxTEi+9RmZrKlW2vNSTCfm+MruumfTTeAoZOe0=;
        b=GjAoYOBccrU56snOKF330nAF3cSJGpF+u73lOp7u6JYohv+O+yToAV1nQX/je6b1O2
         1/J+CPwpJgKkA7dMk55XZl6IVQ4kqp8f4etllQi39wK2tFbRG9pDtKcPse6VezIfkQJA
         2O+wx0RCsOmltkrVlObu7mHYwEMBwekAiciRXmIOVtOQTPIVBBPUdeDHNQQ2sTB7qLo6
         yracrJlCiEy9NjfBQxgcXWnCTMXsgdfR2An/8dnWOJ0GJgtxZ9nXNr6qYIQDflBGX+86
         9bLURiWO+eLDtC+xMY0VYDiEQzd6kEqoAv1v9aadV2NhdUUqN0ToVoQOP5KxKmgkZEtM
         jbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794736844; x=1795341644;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cx9pCkxTEi+9RmZrKlW2vNSTCfm+MruumfTTeAoZOe0=;
        b=gGz8HyuJ4cIakfe+FAKxGz22LzYENwb5ZFY5urrYTbv0GUHVV5VVUnXD+3Cj+V12X8
         eDg8uipMisJyERIaqRIo3eVERFUpAvJD8goqxtohMI+ztQEmrbK7qPVsPszHHS+8fSE5
         dlMtBAz8GgI0B3cG+sOMPQLGTSoS8MKeAcfAZ3OHaf9Vyy9T0s+z5nGAjbAf+Y/wvtq8
         F7nhYlZHwYiDwHJPW8mXrWkDR02JPLymipoaBahvgdVwV4SW++DWqhP2ERkCU3KXR8GO
         jJXYqvEHibFOLi2lX9/RYtwXUFUGBCZhMeT/TQ1AUzBAOYwc+mxoFiX7Llr+WjkEnkmO
         cFww==
X-Forwarded-Encrypted: i=1; AL+hErGt8a0OKYQ9oHZIUhzp0iYPrdbcfeJ/RtydRz10R4L8FVG40w7B+GZHS7+zi+ur3UKF95DVjzE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B/Hh2/VEkKnPBI0JYLXw+tWzCxaFSnKj1Q6x/jUSEniKJEY+n
	EAgZh1etI4nbuLhfXx3cyryQuJP5sax6vlRbVfDn/v9KpAp9VM4BuyVTI2JVJ7SIFBR7Dm3zsLC
	x2f4fZv6NhB11rNNYfWVY2dCprkluFGY8k0x4jwrR1eZKqn9glyFSeCD8kZI=
X-Gm-Gg: AYBFou3qvtun8sELe0R6RzfmQ3hpeDgI/yT41HcctYxYvXehwsJWWp+UMrU5Zh5SLPm
	EOJfERgbvw9whd7gXEfAHMTpefGHrbA7awcBl4NrOMuP024E8kkUIIP4Z2dmv1LCARXpoXJLRfz
	oqK/qXCYKSpQP/kWEVv95CGqT9YLJSZfVU3QMPi4Pj3uBK1Stsx15mk03nqTwgGPL4wZjjJvQY+
	64JaUl21W2YP3SsfUfVoB+UdkjVEYJvTSPdPxQ4bmNuGaDROvB89tGl/upn/hYZZ1Ke0QGvwrUR
	UZ59SPGneuCFUWMYAxt0X4Ue+tyXSTjtVfFZnW3QjW2ckWSp4V6mdgkgflnaDOjj2PEpTikouly
	uki9O7Q8B2e15fVVqD2BwGBHks0wKO6ItVSFyFEEpObV4KeTKZXomPuxSFOzgZNvHNOZpIYXBeO
	laQnWYx4J3C0ZCyzdA9Q==
X-Received: by 2002:a05:620a:4399:b0:949:7759:7faa with SMTP id af79cd13be357-9497759914dmr99788285a.60.1794736843551;
        Sun, 15 Nov 2026 02:00:43 -0800 (PST)
X-Received: by 2002:a05:620a:4399:b0:949:7759:7faa with SMTP id af79cd13be357-9497759914dmr99782385a.60.1794736843069;
        Sun, 15 Nov 2026 02:00:43 -0800 (PST)
Received: from [172.20.10.5] (82-132-234-47.dab.02.net. [82.132.234.47])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c5095b5b078sm292229666b.56.2026.11.15.02.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 02:00:42 -0800 (PST)
Message-ID: <bfd794ab-7c62-4627-9c96-44a8a3bf5d3e@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:00:40 +0000
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
Subject: Re: [PATCH 2/2] soc: qcom: apr: Publish GPR callback before client
 probe
To: Mohit Sharma <mohit.sharma@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022144130.2443667-1-mohit.sharma@oss.qualcomm.com>
 <20261022144130.2443667-3-mohit.sharma@oss.qualcomm.com>
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022144130.2443667-3-mohit.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: y-WSuCNPlEN43ZwJzltjuy60U8G28Q6u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAzOSBTYWx0ZWRfX4ydNJZ6nXEBr
 hcODRwHja6mr7l1JHIfYTGCnhGomsPanVA5C6YG2MkIYtf7JB3dj9xtnSyEZ6ydV4m00qYP/R3H
 ZMdUY8mIU2IqL0zlQG8kp66G+MgRmYA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAzOSBTYWx0ZWRfX0dRce84yJ7d7
 jUe9zww0c/lJZgZYaFugeHfTmy5nNWlSlHCkpJmu3yYvPH+pTXhzi9c1CrSbdcw23wlxgXYAJxC
 EHeQVSLtD3XFxBA8ls1zzYh/yza16qX+s0Lo1a/SQZPwMS3JNWfZngSsunZ8b4lsTg0UkIJiljk
 c2lWKI3oE2vqmFdIpzg+G5xmEsg499g1bHIAMKcjbNbIa8hh2l5vafWZVsnUlw/6jGYifXhPVB/
 3Tw5L0+fi8VpnXkGORHBzkNxQxtrB+IN0vfG3HXyJ7FfSpZPGsJJMh2OnxTU1T/4SKpmB87MY7f
 Iwd2Dpd4z2iq2PWBpeTVlJlbbinVYW0FtkhYWS0zVXwnabRNWUHnuvTNdYBGb3METrsCotNIYji
 c1tv4zs1SAYSumtUTTF9vxXdKUbE507fykO0O+1S5EgTQhB53y0hAmhaMDD3uuBj591dI2uArqs
 zET3EyWjIg7TSwe4XSw==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af982cc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=AI3hfGQ59aOwaD8qyfpUrw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yE1VRrYSBdsmvBnWJTkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: y-WSuCNPlEN43ZwJzltjuy60U8G28Q6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150039

On 10/22/26 3:41 PM, Mohit Sharma wrote:
> A GPR service driver can issue synchronous commands from its probe path,
> or populate child devices which issue commands before the parent probe
> returns. The APR/GPR bus currently installs the GPR service callback only
> after the service driver's probe has completed.
> 
> If a response arrives while the client probe is still running, GPR finds
> the destination service but cannot dispatch the response because the
> service callback is NULL. The client waiting for the response eventually
> times out.
> 
> This was observed intermittently on Qualcomm Lemans and Monaco platforms
> when q6apm child probing sent an APM shared-memory map command before the
> parent probe returned. The failure has the following signature:
> 
>   qcom-apm ... CMD timeout for [100100c] opcode
>   q6apm-dai ... Audio Start: Buffer Allocation failed rc = -110
>   snd-sc8280xp ... ASoC: can't create pcm MultiMedia1 Playback :-110
> 
> Install the GPR callback before invoking the client probe so responses to
> probe-time commands can be dispatched. Clear the callback again if probe
> fails, and preserve the existing callback ordering for APR clients.
> 
> Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
> Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
> Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/apr.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index ea7f83916d8d..829e5c8fdf98 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -365,13 +365,24 @@ static int apr_device_probe(struct device *dev)
>  {
>  	struct apr_device *adev = to_apr_device(dev);
>  	struct apr_driver *adrv = to_apr_driver(dev->driver);
> +	struct packet_router *apr = dev_get_drvdata(dev->parent);
>  	int ret;
>  
> +	if (apr->type == PR_TYPE_GPR)
> +		adev->svc.callback = adrv->gpr_callback;
Why do we need this check?
> +
>  	ret = adrv->probe(adev);
> -	if (!ret)
> +	if (ret) {
> +		if (apr->type == PR_TYPE_GPR)
> +			adev->svc.callback = NULL;
same
> +
> +		return ret;
> +	}
> +
> +	if (apr->type != PR_TYPE_GPR)
>  		adev->svc.callback = adrv->gpr_callback;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void apr_device_remove(struct device *dev)

