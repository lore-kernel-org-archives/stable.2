Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999A448B84
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514909; cv=pass; b=Kdxe7lcjrtcKaBwXyK9eV3Zc3M5bRw4B3fRGCz63Cu6O4eiRIMjeyOLcFef44MRXwYnxEKUfxJ+Ecuhq8HEfc7QM5DVmYKese5mjktBnQ+Gl0v9YITPPb1WJzQvfI13J4pu+lb/0oiGR6KXbvTfF2Qc6YI3ckcdA9oIVTCisoOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514909; c=relaxed/simple;
	bh=50uP1eicgdZrDAdIF1X8QHzjHyrWCQ912G1iM8kMKvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCLEeK4QatIOq3yhyitPzBwYLWBz9vzdUWcDtWI8NIhxP5pU/xzGdLC5Gxb8xbGGUlscQ/MMH56Ce3HWRU4w6WZUknwEFvl7ZenLlcxjyhgHFIwrJwU8Ze7qf4AQ8wmqL6Lb/RCHeJzZhGzEd7M6+QP+mDWb72WEUw6GaTWFC1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOnHgtd+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjZkDA8m; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOnHgtd+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjZkDA8m"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mvDG2430383
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 09:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=; b=WOnHgtd+g4Sfp0Hk
	ELZWXPYcMvA34BuPdsdmCIjRKBfex8mAm3BOPnr80WCPsPc/fvz8c4OMkchMC0gs
	hhJnUU+y6TJoP/YyuDqiRrOlrc18tA9SVrDcJAPQsz+BjrzawZTmF9gozQU4ib/f
	EBB2dZarfnLeReRTa1IvG9wydG4O5jFD0xSCh+84YVA2E6wb2iFcZeivISwaqxnx
	qqR7+QXl2n5TVbj0lLvlXfnbiA/pQsZvTSFzU1630gxgIEyff1tsx3EWwx7jf0/a
	vdu5ixJfaKjsa29C3cnmlBqpZT6SdDt1fMdxmAexlOnmdk4ag2Dv2wqoGvpxJcV9
	kqdsQA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfk921m2a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:41:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so1327365a91.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514906; cv=none;
        d=google.com; s=arc-20260327;
        b=GMNZNpi1H4ZndBxc3K9rUBa40QZ9M7NhVPm4IHUyZGY5p7GYJgNkXxyhBiA5PswX31
         mSm8WKw0LZ/Op3azpv7nq260TFYTppYsL8AROxOrO2QYdMmAdx5U4t5xVworNFlKI66t
         s2vYGls59zltNs/PzLPv3imqI5tk6LTVHvyFbcl2RA55ZURY6tTYDNkO7/hkYL+cdPss
         U4M4ZUoeY/Bi8VPepPVoLVWJWnREWkF2Pi2+M9fpCBErpPpTIS1/vvshaMbYzXpzXIEs
         EqiyKbrLv1VlzMHxSqc+4694hUB+k4Y9dSuVgWisOcWni+i4zEuyWQjfDEBKc6DrKrTg
         bdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=;
        fh=hXh76yUmBIOkCFZHv5cM+aUNmgQvgJ5MAsiZkujPh1g=;
        b=fU9DG/ecmqZgsqGv0qXDH7Q1LydPf4FzG6f9in4SADAqxs2E9OgU/CRoCitzTuujYO
         L4u3f5wBs4AjHMcj5+qgJ2ZM0ogzaUaB4NNByVbzZ59Ui55gJmFoybSDVW9xk+VTG7wu
         SzOfeo33bbMyEiGb4xa6G4DvWxg0yMWK7hv131qU7Vd5yJ7F7GeOMF7QQiz1iJdofHV5
         WDcpc3831UEHr+ZE1Bz/Ww0cBlfWH4YsUBl8MYYd/eDmxXX/oISNId8RlxoJa7cGKzCR
         yjpvmorHthsqtvM3OBGhefK29PD19HOaLDGXgZBZLy3Ohso1gBmniCdIJMHtRhZTEhHR
         l7bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514906; x=1789119706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=;
        b=IjZkDA8mYmlNSEXVI2S76hlYMbYjzKPPqNYdaKq6+kwYdMtbAGnz1Ad4DTvjWr+Ysb
         55ZMjWYbGYR2olp4oFrO9LGn0zyGuc8mRwaWNCmUjcNRgbcIRtiv0UaT1ZDzDbDk3Mo0
         9KP2Q2VcFmdlwIfwUjQKldHTuyRa2Yh5/aKAmLuxcfJxuBR2gjK91NaLUvGQlswtK+Jf
         tJDf5aUM7rG9kbyLrs73Y6rsYfoCJEjak8WVfc54XMmr5j3dXosC/UmT+gZLOm4KfmVc
         FlCz5FUaNLCZbII3vAi2Qy7QSyqQA/ufuCLeamXhf9ZK7ACiB6SqdA7LsfSjUHY3ABFR
         FZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514906; x=1789119706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JldoHfs12k74dRK0ZkTsEc5gWGEjCULW7w5FKztiviQ=;
        b=jRje0r3WSKlRQ33PXYRX5VHewL1BK6tjSopC/2Bau09BL3nLufyRWOWTWOUKhQWoHV
         jSbherm/jLtgsHJtTqG/YnE6gwD2c+T7coaC+4jZn3Tpp41kylfy5BnPz7euhTVk9Kmm
         twldlCPiAwbB1mF8IB0p/j4CZbFwpM3SrRW2WarZzpIUqc2OeTgSkPRqvxWDmCs3VyEa
         69fGsF9A+N/5xr9yfHfusJGB0Od+hGVhQtN+IyS1GFcqQ7ynb/FWP1PODtYoS+BNxyBx
         wferYcmJOhS4Eqat3isT6tNFo7Y+/YKOo1hg9WoLsZM86VnjxUQ7pWVj+VumvWvqoHRN
         iPaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzE4zwxlnNHDv0ZIL/sPzEOZFE5sPhzJR9D8/aQZAwnVPX8sNEQ8+mERH4s4nj5xuybC8N1YCs=@vger.kernel.org
X-Gm-Message-State: AFuF++lHX4tDQXQrzsTWlH0qBJCNK8lfzmechzVs00RsvzWqUbdOgwxF
	mmO+iBIaBjl/V0sDwoVWBiafOu9tD0moHUN9nmvlRzNh3t6R1DLYUrlq7R0JTrI8vxGEfq41bYI
	jBnUej5uy49neBean1Mt2YWWIjuqAJKbrx00knrelqscxL6EiWmdNfQB1RZqSK6krl42dI6ydLq
	XWLjxhY6ZMQSGlNzkYaXtmOCUH6IRG0HxSrA==
X-Gm-Gg: AYBFou0Y5oxAVWBDJ5/cHsAsnXLN3rUZQB42H96idX/ASDFALExKhj9qufzTHpwYla4
	yJQYa6ybmpjPELcQ+vUmQ3A6THzq7c+C0GAk9rRHEBFoOw6W7e36K1lRieJkJGnaEsRD/ckYjT7
	Mc2/1uJK90AhyI0ZjQBdc3we4IcHv+G8xEmD/62pXISD/6/0aviSMWYEK3zw==
X-Received: by 2002:a17:90b:2644:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-39b26204e50mr6922767a91.14.1788514905828;
        Fri, 04 Sep 2026 02:41:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2644:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-39b26204e50mr6922718a91.14.1788514905397; Fri, 04 Sep 2026
 02:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814082550.211496-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260814082550.211496-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:33 +0200
X-Gm-Features: AcwNN1X7jtNoULHEL26canlwRNl7gaaalnTd8u1iDOV2xMeca3w1nhpVHiz7hJQ
Message-ID: <CAPx+jO_NZOWDKDkQ_CkMPRdcG=mR7fUScPFS+urYu4qdCD0veQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Fix use-after-free in busy-timeout work
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux@armlinux.org.uk, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfXxUlOk6XELXsG
 dyokkWAUMZ/WvKkmMSgFCgd4CDbTQfyeLqUkopKRjSD6HArfhnlC6LjZQdYg22YwHFbcb7B04Ur
 fk+uu+A6cmoEcNETP3/kk7jv/J6WrdM1npx2eqeGyhHJqZNN3DNILApMF/daTV8EJRXyKGMaufD
 Rxzm/5Z1w9Vo85veEGQKfjTzgWVIa1xV91eKgfcQi+bS/YM+tiLdv9OcMg9hmFTKv4ZlZ/fkYTd
 wMlWFx+1xZ7npA7pjKxcStq9DKuHJgNv7qwWS2Tr23wroaALwAbFMW6y3vg4e/iq0iBxw2UmQdD
 7/1zkn2f1gh70/C3rQnBgPeLZjQY9hfr8nHI0rEZtjjz3R9eCoQ5AZh3FEyfaGhIxCeC+V006MG
 2RYcxIBPQFPx3hpyKGvDVZoZeSt1St+XiYvm+aP4D96HxMcWBekgmNRZs40JhWS0nv0JVsvb279
 znPYVA5Y3mijwegR0bg==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=6a9a925a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=GXuGsSDVByYryeoQmGwA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: AJXo_3oAbaD0CJ9YPv_807drQXJBM2Ie
X-Proofpoint-GUID: AJXo_3oAbaD0CJ9YPv_807drQXJBM2Ie
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX1xfEXtwSb6KW
 TQUZCyuj6k+9KOJmfObmkEb00ODVsr4YKl/5ZmUdhrMT/xj1etx8VxuURCErkahmKbzTv+9QHrI
 fKdhXE6+QUw5/futKDO8bIXrfxs9J8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Fri, Aug 14, 2026 at 10:25=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> ux500_busy_complete() can queue ux500_busy_timeout_work for an R1b
> command, but mmci_remove() never cancels it. The work can subsequently
> dereference the devm-allocated mmci_host after it has been released.
>
> Mask the controller interrupts and disable the delayed work during
> removal. This drains any queued instance and stops an IRQ handler that
> is still in progress from queueing the work again once it has been
> disabled.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: b1a665932dc2 ("mmc: mmci: Add support for SW busy-end timeouts")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index e500051bd..416bdb184 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2511,6 +2511,9 @@ static void mmci_remove(struct amba_device *dev)
>                 writel(0, host->base + MMCICOMMAND);
>                 writel(0, host->base + MMCIDATACTRL);
>
> +               if (variant->busy_detect)
> +                       disable_delayed_work_sync(&host->ux500_busy_timeo=
ut_work);
> +
>                 mmci_dma_release(host);
>                 clk_disable_unprepare(host->clk);
>         }
