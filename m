Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629647;
	b=XT8TOh8YqN07aE8QPwVP0HHmSBHGgwjFHMWPUrTJsFLPwmeT+dtEjl91z8nlVpq9I+Dy
	 z4ppuJbF9wzU9mg8oedqWrFHAuhuapWhjFLlw3MjSsOGitXTrh4xINPRuSrlNZ12A+lCs
	 zfBJhgSrkrodlD661nWVBExfL88fMk49IA9IdMSiIF4uPDlgU0URejj+7Zj04XVTEwe7g
	 y2zmsLUAshYVAB+1BQtWC570yfsc/ibKvuXZ2dGp7OgSiLrrChsLYhOVrh2AP2nwV3iwj
	 ZLTI+PlC4DMAKl0C+4Ez9VfxPlxfks+Ou46h3iPVsPPYsWe0lhDSJLSgPWmeDm3HMbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629647;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sJIKUA27TouNgOY6Bz1h90nZcilG5A1+OjspnFYoXZs=;
	b=dB4FFOiFADVH2Si1BJV+yn7+oClfmESkwD5SxIQBqKXkeoGT7TZUw4xFuWjtzGqQBGV0
	 ia4mD57hguEwMCFYsCnQ5/ejZ0CwbUA8smnZ2NKGtTFfW7QqC57WYvwD+9yVvr2/+y4vc
	 qpegxvuCUc4AtPbTOQT6dvjGL58D44LnbvyVHV37VPN7AOX8qh8YOBVA3pxMrDSVTA4Jp
	 r+UBcPNZmQZ4mlG8vIQEjj4Lz9itxti++DHR1X+M3c8imiOyQLXDNEGd8L8Iy0Xq7FS9M
	 5EZU6rFQI5jTClz1Yh/V+ycBCP6SFV76Aa1LoAoRulp4s102seksk6zd2qVdq0hUqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wq5Hqjbc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hDAGpBWX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4C607BDE6
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F4C607BDE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wq5Hqjbc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hDAGpBWX
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpLxm2448586
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 14:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJIKUA27TouNgOY6Bz1h90nZcilG5A1+OjspnFYoXZs=; b=Wq5HqjbcSdreyUoI
	mPDDIwtGu1jpKnptdHHNPnkCOzRR1uZ+INo9GAn/VDOLTMrvQCZVZ/0jOcOUlwOc
	QdWwulBxyHm91jO7VyjaG355CmpdDTBWHq1Y0vm/yZITo4ldmaAyATAFov9oAnuy
	Bs0+X8Lx25IzyAZbLNDJk9yF1dTRV3paNg9jC+rXmU4KUYHf7Snzn3raFeGOeUUx
	qKQpenn+181puX2m0/Bh3WAoJ7HsRpJjhjR5Ue5ksI9ENfTv7fJgFyezW9SjP7M+
	+8kR4QyVzWUzF3PuYYlh4sv5XauLgpZlLFroyM03DOlhmKPtBfcSol3Ce6NkexMI
	Ne0HTg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4j37p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:27:25 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eaab6f56c7so93576e0c.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793629645; x=1794234445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJIKUA27TouNgOY6Bz1h90nZcilG5A1+OjspnFYoXZs=;
        b=hDAGpBWX+0BGLdwjvVYYONNWlFcHl9Nnb8MBoyyWqrjBg336MTpLL6klXHzgNc5kMN
         A+757y0KKpgl4G4rE8fgVlEMSid/YKkzrJyayUFJvyJ5cKrLgpV6kND4pacopf4N+Xzk
         S9Ad0QmLqWVWk83gtUaWeG+cg9l6kiAUEy44FQbEYLbmHhJL1deKgRN/zcKGwTQ2Xj1j
         pkCgGlgFTeQQVQrdFm92UPH1JZhITbAVQQVOSxw143eqwfsOTEHswupAmGG9vD/VZIvy
         2IiVCd4gz9XIXbpa38Z7xSwu3l7gKtxppsOYhS8TbQuBufK3AXRLJWX1jWUzRTrs2zzb
         dWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629645; x=1794234445;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJIKUA27TouNgOY6Bz1h90nZcilG5A1+OjspnFYoXZs=;
        b=K93qRmFAUgyGh/wxaZlL1WQPERqklArjxWRN2IZZNm+QtCNtUWwScxC1t4muLxDJIC
         K6KopQizo2Ni0CnXoKU/6E2BIdKkfbFDXGigXkQRj+LPw3YHPcSzMtfhb1TedFXJWWAD
         7bSqKVXE+mHZhN5jFO7rWn+QBvR85lJBomnAmwiLXO8F2phbPlpQS42e2lDw8Dns5SYs
         Duu1Ce7tqf5NOED7yLGjiCnoyNoBo+byyRD9nUztY/eJAamasVzKxOC4/s9jBXT4sonG
         FgLiSJH+f6mCn52ho1JfV6Xp73KcLeyWNLbRJHsCKnaeNtBhpVmdfx4I1d5uKsrQAW+A
         6keA==
X-Forwarded-Encrypted: i=1; AKwUvBz5LxJd4mXkXLBZk5whJyjFj7IdwXk7VCTdS5KuGVP1+khe7bxQFSGO/kjlfrAE1c3D7JNzKlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S3DBG/2flVqbyG/+FTaSQ3ZFHbj/lF1GYVTuRaFH1qWWw96Ls
	AZoJoXFMh6IqLSLQrJNJtKoQnHxTsC0xUcGFa8x0GncsceQagchJtETeNsH0XBchzUHY2Oa6mGI
	oel20V8LexCjakMHOoZ6fJCYj+wzoPXoXJD2SrsQJAj9CUrLaidHEtIUo9Xc=
X-Gm-Gg: AYBFou1kTk1pEJE3AKJ8XT7sbgAVwEhqNHR+u0Pr1UrcJ9qviH66ghFiB3BEw3Y+jH6
	hjYH91mJ7qnoQBzP8ZxDX8T7lcraSk5pDPV2SLL3DMj5GOS0XOCYGD/5Jd5JAAqbJFfDTFDYuvI
	AxomBr4Q9HNZeevR4bMJ1bcVh9OR39kYJrIrc/BOhAjnXJO1Ifnfabn5Ltley2VB/W78yC7gBc9
	zblnyUoGcLfr3LOlTx4kQVChxg9Z9/89D++QHM3vIRvNohhFMQkrnMrS2jDOsj0dXdbiQnqVBte
	jPJ5d36+3vsrErOLAUhp/kX3PzteC9EEJ2BIMtG6j/DvkOhF9dcH67DrsKCG8dzsxXRmRA+g0wp
	KaMQoQpAq2gzj8TgWZKg7NitbeU2sGseLrdJSQcNkplBWpiclLgAK3WU5FyxSbXPprxeCKCi0/T
	B7lNmlKvL0aj9JlZ5sxryL3+aOa/tYqA==
X-Received: by 2002:a05:6122:6310:b0:5ea:c984:5ad5 with SMTP id 71dfb90a1353d-5ec6883359amr4193639e0c.3.1793629644771;
        Mon, 02 Nov 2026 06:27:24 -0800 (PST)
X-Received: by 2002:a05:6122:6310:b0:5ea:c984:5ad5 with SMTP id 71dfb90a1353d-5ec6883359amr4193582e0c.3.1793629644026;
        Mon, 02 Nov 2026 06:27:24 -0800 (PST)
Received: from ?IPV6:2a00:f44:e0:8d11:8079:3a24:c57d:745c? ([2a00:f44:e0:8d11:8079:3a24:c57d:745c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabcfd260sm394744766b.22.2026.11.02.06.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:27:23 -0800 (PST)
Message-ID: <5fc68a91-720e-4c65-be31-8909bdfe6135@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 15:27:21 +0100
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
Subject: Re: [PATCH v2 1/3] soc: qcom: smp2p: Fix use-after-free of irq domain
 on removal
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Chris Lew <chris.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7zcTz5ldjliKE735gu5jrcjJt5CUbKpQ
X-Proofpoint-GUID: 7zcTz5ldjliKE735gu5jrcjJt5CUbKpQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX0bcuj4g7s1kP
 uNihHaQjqoi+fhpSh8GeNjNy0b+qgMQLR67Lsjrof3+rLSPG/itxMb5Ue8UsqUxS3DAk9OoPlUa
 EpbZpbQR5Jcu71tsZwPSXsOSl62mAmM=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae89dcd cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JYKc2Lh7GAscUsD6JlwA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX2+N3ZM4xpGr8
 Q1ctSXv1gCDeoAG4haKvj6vaNJ3wsJI2Le2sdiQgSzI+cGnhjfRch5/38PO6aFX7Y0pAO32xYtL
 dsBHGMe0RsAfU/306YIUc27PYpL1EvGmDq4U+9xhldoIwApzUrWeWSl/0yzIratgVgJZcBbF/Um
 BG8WRGdvkRteS95U9SIaSIpYdZvA/BK4oZiWN0eAVe5gNdLtHkEmGTin8MK3JkwgygGR3MdbUcY
 ESBukMFC7OX7lioHG4vKysj5eCNGxgQjJoAMNTR8FUolFcac3otuYHgfFkmOkHUN/qarQ+UpcEf
 tI6T4CAaTHO59PyLlNiK1wHfFeG5mK2WT+qpgclvfu+Gdalp+pweuD3uXTpWRHr/ZICI+Z+Vjom
 NtpnBpa48rz2y8oUofxAsZXgg6J1sxaEMXuYeGugE/ZWx97YevMiGWABW1rLm87sxvBipLMxsfq
 338if2y70QuQjjG4NJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020057

On 11/2/26 2:35 PM, Krzysztof Kozlowski wrote:
> The SMP2P interrupt is requested with devm_request_threaded_irq(), so it
> is freed only after qcom_smp2p_remove() returns or, in the probe error
> path, after probe returns.   Both paths, however, explicitly remove the
> inbound irq domains, unregister outbound SMEM states and free the
> mailbox channel before that.
> 
> If the interrupt is triggered in this window, the interrupt handler
> would use previously freed data.  Mixing manual probe() cleanup
> and resource-managed devm leads to such races, thus just convert
> as much as possible to devm to fix the issue and make code simpler.
> 
> Note that for_each_available_child_of_node_scoped() loop, before
> registering qcom_smp2p_unwind_interfaces_action() cleanup action, still
> uses manual unwind, because it allocates the "entry" memory which is
> used by the action itself.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-02cea59a-8c4a-460c-aeed-69002ab3e72d
> Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
