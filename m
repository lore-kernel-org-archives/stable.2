Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C203D9DD1
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785499820; cv=none; b=lGCisQTMAaSV/rvNQg8FHbE0KR3TstMMC6yBpuqleCg85BKYE/vHBRJgcn5n/3UiSyrDh52HQeVjoVrqxa12LfMRDD531ET4rkLZpnw2oPeFdl7FhIscG3A9n2FM2hv46bWgZu+i6EKtge4GL5+wDgp0SiAbhS5XmXg9su55c94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785499820; c=relaxed/simple;
	bh=7IWuEAa4jVDxyVRKrGSgG380LLSvUEDOpJ6jQFElz7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlDRhJA2rfqgb+WAB9V1/fuNRtWo51YEOkN08akSn8iz+4eoun0BIUb61WgF/zZK0wLIVmvNUlPx0o2uAPmcWQa5GxCWz9wZ3hO/0ja92xcS01XlVfs+bIEKeZmaGdK0lk/7Leba85hwRJEURGk0D3CXXwpfdWSgdRJRqVCdBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9uS/lmB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cezhneEC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9uS/lmB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cezhneEC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBdIoZ3371163
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KUM9tyOn7WaoLPUkUexhSBTqWwN8KFe+SDzVjpGtgug=; b=g9uS/lmBIGK12A2Y
	5ilVEZvFAAdBHqubtd3cq3HkGWzDaJi763PXQXrAMB62FCHBFUYepAQpHETTvbV0
	aVJGRyMHvGYdHfT9+gRMNfuGvnAyDDjbfYZvSbr0DkESTzV9fQyN7ZW+6Xa5iXTe
	vGQLP3L+cU1+zPmXg6xDGFkwimDgLbrHuA0ilOlUJJ5n0d/xBBu7XrM0q4ed/uC2
	3SfTxY0m4oxK9EqN88jZuGVaJOM69QJ6tZndQRyPHCQp2Gs2JtHpBEUu/WjsXcpi
	Yl0t5CjLSF/Xx2fNskvfN/NfJZRVEW+t4+FDNjzTtNWeTVDN1v5bwl5Kgj5qkllb
	i96emg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru0y03d2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:10:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21c01cf3so15697761cf.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785499816; x=1786104616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KUM9tyOn7WaoLPUkUexhSBTqWwN8KFe+SDzVjpGtgug=;
        b=cezhneECbQx3kZV0jWivYzujplQs0KLADMAGhDvjjNc/Wd9QclGRCqtEew/S7Iw1hy
         y/IDWzvSUyheGKHyEjnpD5biM3BHykgD29KRncVvvZlYaeEUM7JZxHyocKoC9qiZXMWf
         5dR3QQy0qluQFeMSUXrwrmS+wbPvnwaEb9sejCD2I8pNyezfD5dJRAK7/XAYGVIxo6t+
         +X+RNZx/ybtDuBTWTy74PzGLtqLhTKaNO6WSyZdTXc0HJatW5PUPlKQQhO5mduakNIxz
         DUKw2BIOj+gG/wcEW930OHbxLoc5TkcXl0dPzz6ik4RWR31q51sl4DxCJqA2mG+dQTeU
         dTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785499816; x=1786104616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KUM9tyOn7WaoLPUkUexhSBTqWwN8KFe+SDzVjpGtgug=;
        b=kcooUxTQXg3WZXowqVlezFtmkGNGQKfnNx0EFi+vCNJpHxEbzW9RwwF6ryI1QZkX0g
         PdqTb8Csa6DSfrIT8m5gvC5XnOST1zaEQsJgI4lrI7GGnYBavqw4mdGM8PNvbsqcXlQe
         kGGoDDuvpyKhXVEERN+t5fGpL1Zg8qPu9HAS5kUX0mViQ6J8HIf4FyCEUdyAwVPrdveF
         hnrFjW9wkju8UsVpaz2H9QpiEANgWURR/iFP6CUOi+FnMw2yFPx2BhoaOXOM9HXfByNu
         /J130thErJ9FHGGhoK/tgnoq1/STv/g5bH9/WrbJqo5fDUSU77dfUOpCEdyuJ8tup5s2
         ESjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKTIv/SmP8TTtzKCMaJvtwmbuyH7o+21QkJj3eoLtlOdbUKfD0ycCPAkW0j75txOL7+8greYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcUATxs6vIVVb3EFj998i8Seg5k4ToixXsUxfh0bzRX032YVs
	l7ptRLG78b8R7MmXz1gdz9l3n9yLGjIq3iKG8u0Hyy6rAGkZu+qzhQkp1yaYwFDkmCC7UENX3L6
	89j1VzAm40MfFYKKedArLUFIosTwO6FtE9FT6WJV2OTOgV24UrIjMfTbv2Js=
X-Gm-Gg: AR+sD10uYJuNXMlJCnslOMduN825hO+y53ehkaRKZoE6Rf1ZRAnGmW43HbzKCfIhh4j
	oENU5Fz+kl0k06XJLbb+Qx/lK4X6XtOjginD+N9GZ4BaTyTBq46b8A2t0OaHBj1+e+V3JccllJf
	NinTPc2mkJyDfLQLFe0Da7GuvYKEhZEDYvOe+Ci87qZhSLYBWwctL7K5ASldHPEbuI3DqFMcyVl
	E0o47Vb6RSrYT7/aiQ2GMjR3Cq5bD9y30OpS+TZ9gNmsX89LrPx4n76dJT5jWhLMCwnwlRwgEal
	lpvKpDn5pcI5Qk2DOlfJ36Rrr1vqliI4m5md6BHM8MXWbosjqAziT8GcCZdD1Xsb48tbtVaiTCw
	AlvsIrL1g6lE678c=
X-Received: by 2002:ac8:5845:0:b0:51a:329:e802 with SMTP id d75a77b69052e-52b4b0fc268mr22998951cf.41.1785499815980;
        Fri, 31 Jul 2026 05:10:15 -0700 (PDT)
X-Received: by 2002:ac8:5845:0:b0:51a:329:e802 with SMTP id d75a77b69052e-52b4b0fc268mr22998181cf.41.1785499815368;
        Fri, 31 Jul 2026 05:10:15 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b73asm3599966f8f.29.2026.07.31.05.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:10:13 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:10:11 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: jaseg <git@jaseg.de>
Cc: Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jan Sebastian =?utf-8?B?R8O2dHRl?= <linux@jaseg.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
Message-ID: <ivkwuomer5vsajf2lq6otpgxwqljkwooh3p7e5ne23j37pv22t@iluamo6gxmq3>
References: <20260731102147.127082-1-git@jaseg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731102147.127082-1-git@jaseg.de>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5MiBTYWx0ZWRfX8jxgjLeCS0yJ
 yKB5Z2DJmrPbJIeXp2l7DuGQQOKgwOTDaxFgGZj49/w2h6BgE2Ey5XmW4uyzPnxMCmQNxxubNkN
 Q2l722mvkEvCEyG7GrVVF9CQcCx2hVA=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a6c90a9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LNI6Y7vA10jdH1asw2gA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5MiBTYWx0ZWRfX6KMuZaife32K
 ZWIeQ65wDMcelrlRSk4K4Yqob2FKzbMIt+GNXPwNSessdmW3d3Sd5XdsJTTJDsG9CC2GC2zDlAl
 QII9uILbw1oiY7WbiJqDDnoymL0ZsZQqzlQ8KKehK9SE54vcNvzaeGNOff8U6Wx2JCHDadjKsoI
 Z/P2WvCvCBR0re+Lxw2M+SqsHx1C0ivybkjqa0+DrSr3SszAPW6+eaFvmCv5VToLWNnP7RRUs/C
 7gcF50ryLR0r/8z2c/mezVC/6cOmUfoD7z+TWMQ/brz+EUJ5gfn38cnZy/z34dK4NixrETrtCvq
 KgOQtomTP4tk7fnxYVz0nm6dddAP5VMhtdbyb75tlXac0DUo7AfOYa56l4SXw4gIDM39+StCHcB
 9XAyZFaInpLIXW5cA3oVxGvreKVRT89ruREdn5+5Q65SZ7X7g5IW6ZxtdY/HbPlNHIvecf4yUVc
 LLsOu91SIut4w3S6fDQ==
X-Proofpoint-ORIG-GUID: FZwPdse1axP-Lh6HiSpnRmcShWJP_HHp
X-Proofpoint-GUID: FZwPdse1axP-Lh6HiSpnRmcShWJP_HHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310092

On 26-07-31 12:21:47, jaseg wrote:
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
> 
> Assisted-by: Claude:claude-5-opus
> Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd provider bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>

Konrad beat me to it. But if you drop the last paragraph from commit
message, I think the rest looks OK, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
