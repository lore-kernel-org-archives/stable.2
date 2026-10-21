Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792587117;
	b=ms5oRv9RSZmSXIwmLA6SNM9mdH0vr25m00/TL403j/8FA0bSY43rJPA+olgDzk9cJ0UP
	 rIEkbkpd97jtA8jMs1Ug+f8T7ZHxN4eoZJVc343T2NTEhF6Cee1MexXZP+q7g5VgRSiqd
	 lfTugxzpGCIDsovHPjzTEf7RNk0VgO6c8vjat35j/3Q+I65bbWi/kkWd4TJVRmitTIhnk
	 +D+6saBvCz/G71Jdg03RkcVF7r6Zrttz+IX3ouekXNPYQzreZcdJc+bv1ze9E/C0w15cJ
	 Ze/h5wbes/3jNX1a5WbFBaHuFYEm6e4+f9e812JN1R1hoss73qzVzim583cjIk/R3rQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587117;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tKCN/Ntx/9lDpfB3hIQgsrXXGLrS6SF0i7Fxu+R/PMI=;
	b=kvLXgBByIYD8PbxR1Zc5Kj41DiIKnbKheR5/QV9BE3215JFp3AXqLIGR7KIt3vcQSCf2
	 XymdFiE9DeWnocfWFGXXuX1JELkvput3IMXUxdjoq3E+ziUqbOxYhKIw5LNb5fcIswmgz
	 PoSqRxs7RH8K9xTe4rt/prqHfOU5/thGlYlAOaOQSQzreFXJoJkX951Gke7iNNPbv62HU
	 2REE15JQo8WpKPqEFMzP5whJGADg58ptnolJNQKCxNZL/YYQ4jKymTBmP1KBwTW+O7qFt
	 xGwA+zmVI2aD41lPnjyCy+vU15pBJSsjWsaOm19ehOOqc+j4tFDLTKLhijhkqXQEFMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gketJED3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRcycZQK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468D606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2468D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gketJED3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRcycZQK
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LCPuET586592
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tKCN/Ntx/9lDpfB3hIQgsrXXGLrS6SF0i7Fxu+R/PMI=; b=gketJED3Gng6Tm+J
	KacvTNyCZfwMvS3Lp28mWyYLX9yosEkoYK3b9HIQfhAJMRNTgT7q9bE+QQQl9nWT
	NV12o9+UP9p18OSgcaYdd/VC7zrlj5hOsG/rq9rT0lDWPbb8xv4V+/tlNycOa5Z0
	UXriXCV0p/+MICmDwUES6u+qHrne7Jvx2kKmnHz7SXM+BfPxko1JE3y6Y5U3dJkg
	4gLNCFrZtcwHJkcaLNRAJP1ei2oXuo4+LjK46kkeRbM/6gVPliQ/McaqutAey1BO
	Wy0L1UAE5aQjoi7r0lLlA+I09JT7RUxnkQVdqFnptbepx3tXn0tv5v/KeVtr8uXH
	pumlVw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r31d0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:51:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f33438950so157595485a.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792587115; cv=none;
        d=google.com; s=arc-20260327;
        b=FoNXBSmTiXBbpG0UQ+NulR5e6a/r66+/qYvFwr4dUGOcguPndAf2USsyOwggU32V6d
         kWylCKKdZZLfhf9+BA/AZ4EHvGxkYAxX7UnGZkO6D0YTCgG9h8OlPd7TGXSEBRRmfPX3
         zLmsC/eBRUITgIzOGZtAh90KpHalSgY/wJm0oAcpXo7uaf4X9fI6aD68EdAR2UeFd3t7
         3QyfgpKoiibwcM665cFy+/UGSeGufk5sZKNqdk2AljTnv05aPi+8VqhTzOYgsE5dBOdk
         FBVQPA5yxL4bcgyEIy3/gxskwU3OIOL8h9/IdoD4VyiljMcarCrH/NDZTO25tBubuN6U
         c/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tKCN/Ntx/9lDpfB3hIQgsrXXGLrS6SF0i7Fxu+R/PMI=;
        fh=85Srlmr+NwiZhxMNnIyOwAdNE8oacWB14o2CYz7kRoI=;
        b=BQhKtzGPeilyIEce0o8vPn8VZZT3TKWsWIh161dokUJRkQt0PKwIKs0sjoE9vf74ww
         32SlGFHH4CWB4p2I59CMTsXGwFRo3AYgVVAE1High2KJ5++lzYUAHyeyEqgETkcaTbR7
         hBYegDj4ShjBCuGwD06IV21sTDfq7YaNRnn4YLVbsrOcf9+1R7KaYEuStO8cUmfI84Oi
         1GlDSPMlPdFkIV3HtCHHS1UVGVhgGiZOL2jJ4L4HJq3ofawtMF80b3LGlqY+sxQGr4jQ
         HmQ5NC/Uwk5NWK3OcLMSbbALcbzQ0E2/tluI1A2VMT7XDRWjNmZ5Oi3YUPTQVaiHWlem
         Zrnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792587115; x=1793191915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tKCN/Ntx/9lDpfB3hIQgsrXXGLrS6SF0i7Fxu+R/PMI=;
        b=dRcycZQK5Y5F/pJC4zlLVfeRxLQMwvYMncEuyHcsU80MC1Gg0+fDL9r1mFb0azva8N
         7w+ui5TuCWff+ypxgbNwF6pAc2KMLQZd7BSF7WVe2in5217+PMgijV4sOTWgW2iULyyP
         k0Qw5lxoRHFBwonHW3lTbky+/4PDMvsBFPFhLaUtMq6gusBR09ruQLzg68UoMudmlw1M
         xi9kpAIdbsFM86DKAQk4zkt6+GFTePJMGEtvh6IYgkJ0dqKUEoY1rGOvF9F84ha3zOmc
         7kcqJIQ3ta8ApvhVexILuIG1PrAs0PBGtpsZ6DDvzMZaKEVPakfcX/FeDePqa1czXb2a
         PD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587115; x=1793191915;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKCN/Ntx/9lDpfB3hIQgsrXXGLrS6SF0i7Fxu+R/PMI=;
        b=tF031E5kBWsyA6sTv4Py+qO7icq6B7hLC48Xli0KzwF24deQhx6Qal8Bu8bKPwVX66
         bCjipgeKhO+s2lKnTZSc0XsMp4ICcudraS9mKi4pzJWEZybOhNaY72YWPmIzjgTiexYJ
         88/cUfIX17YD3mU9kGjnN/ONejqd6MEn8FUI3CsUJu32+BsK4YzaJA/qViFYYIzWRxna
         PEU9p1oc3+lP3dFU6qGBowSqYILkPY3bXJgCW52GignO1kE8eBzvYRoyApVJwpkHmRGQ
         W7O6/QeI9O4eQenhPyBYzt84BkOIhdA4yc9lNfBObXt8xr9Oy9EUwxr8hdFaH+Yqu7Gh
         XWEg==
X-Forwarded-Encrypted: i=1; AKwUvBwfvGH8OltSypSm1DUqGxeuzu6vazxze7FQofUkrYMS3S78BiGWAVhQ2j3ECntJcm7BwXlgxig=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq0YMdgNIhK7iG2XUXSGlbNYVeKFF0XRZQ0gDtxzalkYJJcvNy
	8XbupDicKCV26V0elPqQlW+GLxAA5vUXrk6RrGxwZ/BcxbpH2zsapcLFVGUTVGChL4nRM8rFklw
	5OvydJoFMmtqeW6DRdll9sU4ODBUlw63rnsVsVsEZtEvnra+wFD7/Xh61U6/jeAzQHcRHlabA0d
	RaUwC4S/QYWaciPXq+F068UwFUrvy29z1SLQ==
X-Gm-Gg: AYBFou0Dd05o61NubYkmFDrpBPANFmJOXjEZHRY6+vSu5ILiOUFaD/1qvmrvcdhAP4d
	NcaWcb238lCmo6m0j07wJxaogqCri7atV1mGutAJS2E50N9mnFc8ihLLkFakm5pyQd+fQG4JkqY
	KW5UXUvpBN74XItKzJkoc+KpDv8E1boeunJ30x9/QB3zR2vOCV7LObtR5oJthezzZV8wRwLhKdg
	bR8KESBtOg3NPsP+uwkarmSHiRaLTV92WGCW3B7OC409P8j+IYl/DtTtCMuKJnveF0RbFh0WGo=
X-Received: by 2002:a05:620a:28c8:b0:93f:2aa8:c550 with SMTP id af79cd13be357-93f57fa151emr385796385a.26.1792587115055;
        Wed, 21 Oct 2026 05:51:55 -0700 (PDT)
X-Received: by 2002:a05:620a:28c8:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-93f57fa151emr385791985a.26.1792587114427; Wed, 21 Oct 2026
 05:51:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021105434.29897-1-slark_xiao@163.com>
In-Reply-To: <20261021105434.29897-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:51:43 +0200
X-Gm-Features: AclHuK-yPVVb7PzvbUMTFtaNy5JD5TXtzFZ7YNTeyh98oaWvr44i4RUl_uqSzOU
Message-ID: <CAFEp6-3F=fZ+kTsyZJTDk1Qfw_kPY-2u0G-PDHs7XyBs8tyOWQ@mail.gmail.com>
Subject: Re: [PATCH v3] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
        krishna.chundru@oss.qualcomm.com, val@packett.cool,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8b56b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=cfVVBkdRkn7iCyj4mtkA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: C5eWDS3Wek2549OPCe628sV8GAPyVAqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX2Bd3p3r2+9wM
 qwAjJ5FD2fXsh/uUYhiG+jUp/Qhau96JL0rl2yRVgf29KHSaGMFugNwJkV+zlakzq6ebF81C54R
 qFPNg0gkmpVci73xMUQIxv3m/+Q26JCKXY+1qCagnqqqQL22qvmIvGTIBcLU3r2DoWvnGvsjbF/
 9+ZDOQ0ozjxPqt0vIU8/jmjo72kBwNJzsWazloI+OUv7LZfIDHo+63/+vUY+YgEO4DUoYLqUAIT
 uqaAPNnXTL8bsgHRjenoht9Dnw/nte/cqLe/QVFi6AsU6LYoj+3fJRGgZJ9fBR6Klfagf4Aq0r+
 5RVrATgbcl2+1oRKm2f/rSkpui7/mxl8hlw8RwFBVIC1e8PP/0l5+2O/8DM59H813RQu95i75Tg
 gnc425fjPgjraau2M9BT7g+We6Dbu8ALPd1qPLJOLOoic7tnorbCTNCgYFsXOqMV3ENU4kKJnAO
 6VLSfm3pkmOUtlrGfvA==
X-Proofpoint-GUID: C5eWDS3Wek2549OPCe628sV8GAPyVAqO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX3tFFXury2YPq
 JbrH4stw5KBD9quJqCh/ItiBNPmmS0qbfw0FkBzGhGDh32qexiU3phgS3xMOF8yxZzQ3FCb/k7F
 9idHPs6Q1F3i+o/lQY4l0rynj15/e3o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051

On Wed, Oct 21, 2026 at 12:55=E2=80=AFPM Slark Xiao <slark_xiao@163.com> wr=
ote:
>
> For some MHI devices in some specific scenarios, the default value
> of autosuspend_delay_ms may not be enough to handle the last wake
> event, potentially leading to device timeout or link drop issues.
> This can lead to a runtime resume failure and a subsequent system
> error:
>
>   [ 8749.089545] mhi mhi0: Resuming from non M3 state (SYS ERROR)
>   [ 8749.089573] mhi-pci-generic 0000:73:00.0: failed to resume device: -=
22
>   [ 8749.090218] mhi-pci-generic 0000:73:00.0: device recovery started
>   ...
>   [ 8752.940324] mhi-pci-generic 0000:73:00.0: reset failed
>
> Following Qualcomm's recommended settings from Windows and their
> suggestion during case discussions, update the default autosuspend
> delay to 5000ms for MHI devices.
>
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> v3: update the commit message and the comment of the define
> v2: define a autosuspend delay timeout and explain the reason
> ---
>  drivers/bus/mhi/host/pci_generic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index 7193a384cca4..17d51964b55f 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -21,6 +21,9 @@
>
>  #define MHI_POST_RESET_DELAY_MS 2000
>
> +/* Timeout to accommodate a potential 'late wake-event' issue */
> +#define MHI_AUTOSUSPEND_DELAY_MS 5000
> +
>  #define HEALTH_CHECK_PERIOD (HZ * 2)
>
>  /* PCI VID definitions */
> @@ -1483,7 +1486,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>
>         /* Allow runtime suspend only if both PME from D3Hot and M3 are s=
upported */
>         if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
> -               pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> +               pm_runtime_set_autosuspend_delay(&pdev->dev, MHI_AUTOSUSP=
END_DELAY_MS);
>                 pm_runtime_use_autosuspend(&pdev->dev);
>                 pm_runtime_mark_last_busy(&pdev->dev);
>                 pm_runtime_put_noidle(&pdev->dev);
> --
> 2.53.0
>
