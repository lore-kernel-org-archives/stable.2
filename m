Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC1448B84
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514912; cv=pass; b=fORSFNvwBh3Hfm2K9LPzo43u5TpWucLou0oZxSaIJIAAdjLWR3yTe8R61m0rQsKsTN4y8HpZ4bSUWGhYylDDZUu2FCCr8FJLdvZ/WfGpc1AF4xHONn3to2Hb8aBkRv06tjz9nlN7cIPmn7Xt4UXD3TH6OYpfReLUIv4lhZ6rUgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514912; c=relaxed/simple;
	bh=OwvhlOjXczwQM8RF6iBwIfWZpHB3GYOgRcW1D4QzHwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxoF981tsjswke7VPs9pEvnZIlD/SodJdR7TD2fUl8iTmhEMhnsVOqbz6ajOSiPUVSBlspfaRUrCEn/MdQeY5umiohYygIcuvgiM7lVmxnaavcCeVm7BHHw0gYkxH9XPYzwTFVkWMam7a0D3SBsp7KJ3IrPDFiy2mGowS+tvjBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cwgdt3ls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XdgKwmKJ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cwgdt3ls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XdgKwmKJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mgfv2945692
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 09:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=; b=Cwgdt3lsRogaaeNz
	iaJkGKKDHJiLBE+Wju7ec6VThgHosPQuqjtKuikylPsv237qJp+G5Bt97WKWJSsU
	XKPKtW0EfKpWdVM4Sr1Tbjw3HdS5CHP1VCia2B4jqN1tGmQDtZpNxrcf359vakDt
	H+E1tTbFJeMY/iSgp1QC2USZ3DfcO8I2snx4mIvcgDHVIxKpBjSWh+dFWg9raD6W
	+nm5fTCSRimnjzXCEIMV1pQSwNQVt8DAUmVl2YxgO7RE43JG625yF1Wl1pkm/KXm
	UhVUU/fHaGyuH0xd0nkSLZe3PmDeVHTYWbv4QLliXaC7EZsE98Ipvk/nCe1Hl0WK
	wWyG9Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd0uqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:41:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2611245b3a.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514908; cv=none;
        d=google.com; s=arc-20260327;
        b=Z0ldQ7slHXpkAOorwP27bW+RugeBXjpd3TBusCkRCDiv6Jdn8z9bsPbX/r7clo+JoN
         6iJUdWs6Qa93GiTh8mNGriyiJeuJ3lyS7thRB34X3aSCvvEbPVoAdXR2m+ZlXxsYfoWy
         DX6H1eZgF/QcCUsecbuWcHcb3sgeANiwjnsfpfHjBEOoGuMdpNXUOkkoL5pw1ILw8Csx
         FnJMykbPzsT9aBfrh+72XfMP2ZNiPVDtdgRGjngKMg3hycFOevTpYYoXpmojZBZOZCeo
         WHuEDFq44vYq2XG7FwBVvmqbaRTyYeoZem5z5eqHE4CPPRQLt9CdY21TqDVZxJgiHF0c
         0VRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=;
        fh=CWOCScwfr+L38xfoUyj8qTGQqR9E6vV/9D8UANXB/js=;
        b=bU1m6PJoeGKedpeg3X6Xdq48M1YwuQlmoiOT3M2dHvi+9mur0pynOYz77IyeaisXlK
         GfiCDrYTa6xQYd3eXR09XLuGV6w2RitY09dLLdKTxFGv0qdvLDMHTZL6ZYg3tUG9wigs
         31jdEXAON+OnSqv9qNV01mnXbI5justyOEmKpKvtxSBTGgSjJZ3AfQRt+ArevVV9gdp0
         i+6WH/FDRD/lcbRgrwGEgLdX9TnomkjYKs4R1hHaao2uYNXAhg6LsPIoDy0zB8Ic3ldC
         UI06XjbntLrG899ZEqRAnMGvjb7qeXOLftT7sPVw3H+/WIefY//VwC1gEb2mxiDBWsbA
         nXxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514908; x=1789119708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=;
        b=XdgKwmKJMB8b2KLKvJe5w61F45uLBGHQJW6IB6FhRWN8uVOLPl/4d982Cm3liUp5MU
         Wu5PPBJ25/OLkxvyhhqVgeBIcYq7BfK2C9Xd30RrForSHJv3v65sATkIcnLhLYY0jkrE
         B9ShQ/CsYdhdBEe6zZCwwmKbYTuKkB/zNcsblcg6UvutlzFdhYneRhfdcHFCUy7+yi6c
         PuTyyDTUI4tO0SW3KCHZ38b7j+7iXw6+244hFzUrGDJ1EebQsPAebcKIRkIkuupx5FQE
         bbnBXHIdKkOU1pmbdcVH4vK8JEbz6Q2zJPnTMk7LSuJGgIX47hyKM/f43Ds/8lOLTgVO
         PwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514908; x=1789119708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=;
        b=HX5+dyMOXE7XTpPnJP8rbHkoSHO6SLzqeh37bU6yz41u79D4baA+Z+WUsMGG57Inmt
         RoZ2m8xCDq9QxIOncwPz1izpKWnww/huaD/G6GIroOBzpPS0gEVNuWraakGH+rp0KDkJ
         hpkPmSJnh5VkPphWwjw8VAGducl4Aw7TVU4YbIjktge1xIxGtNIpdZFALCumjk8YIQT0
         ka8+CVa4fFpwZ+RW4DkYoYUJLXwpeYms7kibCvp/Zsw/gkdc2uS2LTFuxpR0m2ERmVxC
         fvKzSNMshn8VjL7VsNkctDzjRaYu3pnf73RAoCVuCV7PflV0a4EbgR5DB97Bgpf+qLQr
         G7fg==
X-Forwarded-Encrypted: i=1; AKwUvBzwwS31c8Mbyrb5rlcYp6AzCJHwnNHP1lV5pH6IluQwdKHeJz1iSxz9AH7Zv/Kyqnv8pwgvHaA=@vger.kernel.org
X-Gm-Message-State: AFuF++kizMffNiFXOLGtmdlwolefzmMe8hh/TT0zkgDv7UQagCIHnvpM
	J00/pS/J1eH48mq7dS1aPhmf5pbynrzcS5M6r+uHymzzN8Um+i/s8SG2YvmPIb99kphLmtwhbUG
	sljnpIYBzc3+D9qO6CHa0PK3f+DeVHDj6rYlCV3yMCiqGTEM8eYYPLgkCzlrgJJdUrwuYZQy8FD
	fKak9PwleUXuCL31rE4kjkwQpQFuB2Mme3YO8H7p2mUw==
X-Gm-Gg: AYBFou1Qy+Jtqa75H8VEO1xyZxu+Ea++4FqGJptS2OMLFg6Q2A3+5rZ7r1imsv2TNjq
	KnBF4cUAvro1DEK1cd/SP4A+WryvTN8zD9oxFPR24JxvGlFTE7rdMNUVUGt/S4+p8QGY90Cq/Fh
	okOmuj78MRvy/YfPK/gwLW0MXL8ohS52mXvk6jsbqpA2u5qe8PsEYrKB/F2g==
X-Received: by 2002:a05:6a21:3292:b0:3d3:aed2:6f20 with SMTP id adf61e73a8af0-3da216016b2mr11449360637.20.1788514907996;
        Fri, 04 Sep 2026 02:41:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:3292:b0:3d3:aed2:6f20 with SMTP id
 adf61e73a8af0-3da216016b2mr11449326637.20.1788514907606; Fri, 04 Sep 2026
 02:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807032654.4744-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260807032654.4744-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:36 +0200
X-Gm-Features: AcwNN1XHSJTzWjsBXzcbHP-mMf0ZbkIiNc8q1-QyzFYKHrlJIK9-0ga-DRScoJs
Message-ID: <CAPx+jO-y_QmwAefsqKe9rTebyxcXPV=KidDKiFOXgsykksja-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxcmmc: cancel data work and watchdog on remove
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Ec9f5djSn5H_pAUvg8ql4TRcHJs2b9ri
X-Proofpoint-ORIG-GUID: Ec9f5djSn5H_pAUvg8ql4TRcHJs2b9ri
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX2jPYmMzbxKOM
 0BkQxHo76UFQd7MIz850V23L/UURbTLX4CepancIeqSLYvwBt9vPipTQmOXrvVvwUwKXGC19ymP
 2a/rvDH81j+gROvqFSGtUAzrWu/PJ0k=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9a925c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=_goTqDE6Cbb-XUK3vmYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX1X8atjt2TsSr
 taSZ8Q1FYAEl3R7jFAFf50yAxZv+QGtsTEHaTAwvbVvU0FEF9U/Y5Te9I6vXvWN9Tr61KRWdGL8
 RYugz6TyosHUyc2TZucWojvTDOSQ86zqDHzsWJ5qR6LffcJ5Yas855gyb5C29SWsM4lu9/b9NMg
 JVivubJM0WWwVgC8A06AQG1qjcyqpM2EHcw0rv6dMm3nLuFkfXfIAQtM7+LsHf7UtooaqxFXinT
 bH0l6ispmq7xVHC8GDniHBGhHYIKtCJdqaIOyIR1S5OcSDak6pGSJJy5KKQ8YB4ApiziPnlvkjH
 BR4f68QNoPpm6u5ynrN7DBh7IKPoeDB8oTaqaBRZkQ87YWuPPVng2k3it+RBD1VzubuojA00xtd
 w/9TdrYGscgSFzHaGVznhLGCGAXbKH2fcRC3zFd/Jj11PirHkdibOTvFB+82p+sPiMdZzgs7xJW
 t+RDzyOscBiYMNAyKNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040088

On Fri, Aug 7, 2026 at 5:26=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> mxcmci_remove() frees the host through the devm tail, but neither it nor
> mmc_remove_host() drains the driver's own asynchronous state.
> host->watchdog, a 10 s timer armed on the DMA path in mxcmci_setup_data()=
,
> is deleted only by the DMA- and IRQ-complete paths, which the remove path
> does not explicitly drain; it can therefore fire after the host is freed
> and dereference it in mxcmci_watchdog().  host->datawork, armed from the
> IRQ handler on the PIO path, is not cancelled by the remove path either.
>
> Free the devm-registered IRQ, then cancel datawork and delete the watchdo=
g
> in mxcmci_remove(), before dma_release_channel().  Freeing the IRQ first
> keeps a trailing handler from re-arming datawork between the cancel and
> the host free.  Both callbacks are non-self-rearming.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: f6ad0a481342 ("mmc: mxcmmc: fix bug that may block a data transfer=
 forever")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxcmmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index c405cfb8b269..097498a3f8ff 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1173,6 +1173,10 @@ static void mxcmci_remove(struct platform_device *=
pdev)
>
>         mmc_remove_host(mmc);
>
> +       devm_free_irq(&pdev->dev, platform_get_irq(pdev, 0), host);
> +       cancel_work_sync(&host->datawork);
> +       timer_delete_sync(&host->watchdog);
> +
>         if (host->pdata && host->pdata->exit)
>                 host->pdata->exit(&pdev->dev, mmc);
>
> --
> 2.34.1
