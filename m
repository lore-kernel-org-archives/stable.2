Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F33C4562
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497744; cv=none; b=MM17K+yyhcH48Xgqu3XFYS5Ma77uDK+vWvKmzBLPMxDfezjqIWBsRRcHC/ljsCNV5PtOAQ70a3Uen4ihOU5dZMKTqypSgKolpPmIQ/4zxVrEkcDbcjBfS0VAViZquR7Bw2OEtIG3mMZD+PR0O/OmO8PwAHlrb1KSDOigE8MOiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497744; c=relaxed/simple;
	bh=plfZ4FsucgnFmYB+WLfqiTzRuqQ1f/GHyVysSGWQv6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7MK6joDYOISdwjBUmaJVAdzqZR5/oBYovYCsyvHEdp5nZSRe6O6lPyPA5SXu06h23n1+Cr7MDxQOUCk7/Z9fwMv8T/dLxn2wLlSAzpYQy24MdeGzn9grlhvWCH74lEGjajr4Y/JEScYon6ciQl8NMgfd7QrU/n9rjesXlJSqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kxrN1WAD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SjyigWmW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kxrN1WAD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SjyigWmW"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBSdfL3348632
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SntzIFPR+4FwE76k9egHNUQnO0nVT2pXTp/Kx+qC7ww=; b=kxrN1WADw9DCh02h
	SQ5T1fm+EggEMTO0j14VZTvKWSZnDbMroGMOUD7c7xWRPqbPFFyQ81tGnFoIQps2
	9Kx2MCNHisvGxAozCoWt8gcLsscBornjTPHFspVsU3oYOgJbS1rlrTL8aZNaznHQ
	Nky6SDLbN3YFUdT7DzyF4jMDBZoWRI9VgmrsFhL7Z8QsxnkLX5jI/yBK++NhDN/H
	0DyH0Iuw4a8UnAQDv71eSAEFWN6krXrotYlDRv66eDLXr6fd5Ss+CL959fks1Mah
	Rh0e1TaWWNpPaiwoU0vJnpoMiob2U0oHNNlHA7SwBzQLbQ1Mr+BVHanKQOpx1XD7
	NlSLLQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frtv980xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:35:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfa45b280so1365091cf.3
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785497741; x=1786102541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SntzIFPR+4FwE76k9egHNUQnO0nVT2pXTp/Kx+qC7ww=;
        b=SjyigWmWGA5cFtSY1uZaf2AysLmzLSaGEBGx5qZtx8oZBlv96/QXdS+AzzkP+hh+Lp
         4SELrDpm0JjfUbavF9pvGWixLuiu1+1anemdD1gC/4OdgVvG/lpxpuavmBqoy29IUsxH
         Gxmvkb2JxNvY+8vta8wgM7v55BdzJ0nNcgvAlkG3jJZ58aNawLC/PCKeaWNskGL9GcO5
         mPj7YVTwFpgB1pM5qWQpsk6OB6vEWaGjvcHAWPsKyaSNZPXgjY6h5GVlXse0fjsB1ysy
         985y4go7UyDGnLT/4X56R+e30qx4vBXLeIpuhjX/jHF2Ry7FuUi9gralOxP44jbV08KT
         Iz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497741; x=1786102541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SntzIFPR+4FwE76k9egHNUQnO0nVT2pXTp/Kx+qC7ww=;
        b=PAENs9oFQpNGHDhgza0+faS+7nOb2XM33DBuo2k4xqbe41R0R9rFczIyQsN55VmrTP
         xgclUpiJSj/zjFl8TzrcVHAjx5O5j/WyM/7hdcRfDBpaof9gTOfXxb8OYKijSVVG7G34
         yshsl6y8p2s43+QnUlfeRm8SAPdQpyUDNAt+Xo2coLumHhCZSpVjd7Tx8sKz/J6SEP3I
         X7HxpwfKXI3ym9VsUIKzFklV2jESBr5SJUFFnYUM7UJSap9sZGMUKtOGlz1klKaAUSWh
         CCbZoRRR5X2hcaLE9cE5zVqRJMJX6YeIxL9SiB4T7Yfq3/gjb7JrlJad4dFfMPMLRntF
         kFXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwYm9URKI8MoJd3DJk6WhawbKxGt+dwMxp16/3ghaFBNlg+aqzZVpv/konfQfYs98cjPoPkvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqi92CaObeL2Tas6USilDzM9A+sqB77AepZ8L2ELqxLiGvF3ED
	PCYINsH/dsFFxWPXWVatK6b6gpOKj4+qHBr2YBW/uIhwuEUkprjyUd6B87g9EarjL0y2by4cBg0
	Pq/R8Da71j/7KYdAYUiQZNpJ8RqA/npu9DvqFriks1titEpMNMbBViLjFHjs=
X-Gm-Gg: AR+sD12TQUYZfoOr9NmfMPSQ2QM5Kxm0jzIEX90V8QIFn3cJcZFWKSB2uQuiG6zTAD8
	fV5Og5oCSv/SyG2t4Vk2w+zd6qCnXfMktRiY3HqqtDSqkHGQuU8m6vpPOY64iXRAjOttr25uJan
	iFZiSNZKdRV13ph+ndUniP1PjpWRhBVdEkUhFeWR8eACcdF1oHe0lF4IbBySPMuS7qK8FT1UBVM
	NF5xeXCMYHBj3JQ72s+D2b52E5CdQO+lsbmrbjQeFMlPY1OKEM9dMweN09LFYoyGuWTvqJlFC2o
	4HVnw4bNUM2f1fIbsspxdeN2nTE32m4ZaeYMox5p4ppLpbUfnWBcoOhz3Yy2vqQYzKKJ1CZyI0L
	Jgo0yl+5rzYjLs9l79gXPm4Zd
X-Received: by 2002:a05:622a:6bd0:20b0:51c:2324:666 with SMTP id d75a77b69052e-52b4b164ab7mr15392181cf.3.1785497740984;
        Fri, 31 Jul 2026 04:35:40 -0700 (PDT)
X-Received: by 2002:a05:622a:6bd0:20b0:51c:2324:666 with SMTP id d75a77b69052e-52b4b164ab7mr15391851cf.3.1785497740570;
        Fri, 31 Jul 2026 04:35:40 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c664713sm1227143a12.30.2026.07.31.04.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 04:35:39 -0700 (PDT)
Message-ID: <c5a3a4e3-d78c-46ea-a638-2b6e37d7efbf@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 13:35:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: jaseg <git@jaseg.de>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?=
 <linux@jaseg.de>,
        stable@vger.kernel.org
References: <20260731102147.127082-1-git@jaseg.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260731102147.127082-1-git@jaseg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA4NyBTYWx0ZWRfX7YY1Kr3NFHNP
 OV/9lKJvhmgtDksGN7AA+nezb3nc7UE1EJSBfKcwD8//f5itUEof16U8EbBhO2/O3Sz4qCQY9dL
 vPi2Gsc9EkFWs1xEYCkmz+YQoMFuP6A=
X-Authority-Analysis: v=2.4 cv=W6IIkxWk c=1 sm=1 tr=0 ts=6a6c888d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=LNI6Y7vA10jdH1asw2gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: f11DUHhw_JHdZZuoYABFb0PR5CRehhSF
X-Proofpoint-ORIG-GUID: f11DUHhw_JHdZZuoYABFb0PR5CRehhSF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA4NyBTYWx0ZWRfX7SSq0mKuFKBP
 Ah18sM7U+9sD2pnTu01jBsS4r6ZfQ/JH4UCo4MHJGogG8G3FgaFfpq69n41044mzJ7ixOscwsgl
 FBQHcFtDEVfAleiR9f5OKFkrCw9C6Ezqz5NlowZzRhv/pHhp8LzITWYh4OlN7TxNcNE9kcZVJsM
 BxP9w0M/czgtWviCh2WB+rs7TcD5nVFCAJHPpE6UvqM8vBxveKXXDBYJkmpaSmWfPTXkkMepw8R
 LaeZjV251m0b1XLF2s7mYJWOKdLSKpiXVBb6ah4DXTOnNUvnioKaGyYt1Wgkyofi/Mqa509SvSv
 hYe11VeVn2xWmeTSf7FAbjMREMoCnQv1v8jl0AbrkAaXWxnXNmnYb33IFnZCvSZQRidNpsr99Z7
 zNNa7p7CD6xBmjYrA4KcYcqbQ7EWn15niYlCfugJKlY9nmlCI3tNEhHSSuLwTvqWk0TggZ+ipg2
 8iCnqMlkw0Onb4vdfKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310087

On 7/31/26 12:21 PM, jaseg wrote:
> From: Jan Sebastian Götte <linux@jaseg.de>
> 
> genpd->dev is embedded in struct generic_pm_domain and its release
> function is empty, so providers free the containing genpd with a plain
> kfree() once of_genpd_remove_last() returns, ignoring its refcount.
> 
> Since genpd->dev is registered on the genpd provider bus, fw_devlink
> creates device links to it, and those are torn down asynchronously.
> Nothing made genpd_remove() wait for those teardowns, so the provider
> could free the memory backing genpd->dev while the queued workers still
> used it.
> 
> This is reachable at boot on qrb2210, where the firmware rejects PC mode
> and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
> up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> causes the kernel to crash a few hundred ms into the boot.
> 
> Call device_link_wait_removal() before dropping the final reference. All
> link removal work is queued from device_del(), via
> device_links_driver_cleanup() and device_links_purge(), which precedes
> genpd_free_data(), and flush_workqueue() waits for it to complete.
> 
> Note: This patch was LLM-assisted. I reproduced the issue and tested
> this patch on hardware, and I did my best to verify it by hand. However,
> I'm far from an expert in pmdomain, so YMMV.

Thanks for the submission!

I'm not an expert in pmdomain either, but it seems to make sense


For future contributions, it's best to keep things that you wouldn't
necessarily want to preserve in the git log under the --- line (so that
it still shows up in the patch but it's removed during `git am`)

Also, your sender identity doesn't match the patch author (i.e. your
full name shows up in the From: header of the patch but not in the
email), but that's just cosmetic

Konrad
