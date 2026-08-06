Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150E40EB9C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050053; cv=fail; b=pU7DSNzP4gncbAZgnjbCH+dNfF0TwDJJiIUUcKHtbGC6R+msEr7XmNm0ZnArBw5yd9Dz6ejoXFOtXTGc2NyRXXB+LxDZ+q9+YzaRPIkr6zTXb5Li8i//ki1SPcgXP7bo1HqaX5iXzRrOOdooK+/6Ia7PtqEfoJmKW0zQkA0sofc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050053; c=relaxed/simple;
	bh=2m/MezBLD4L9Sm3qZKBo7QcHD2jdQUmxgA8N2cAddlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ycf9U20MP+t+MrKpV3krgyBm5FXXhLwo2fGs+NqFJ/i97yqRuA59pa6FC8U7UUjIbHQ+GZN8UUUtoZ7B3yvq8C6NCzB+S7qJ7xN9dIuj5uXSDMtg8NJknRnQETAV8ra4BLfAZhiZo/ElGK+4rGick+CiwZk25IxnQzcaO8/ngTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MxK7WhiR; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MxK7WhiR"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IDOPG2244243
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 14:00:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=lGo/gZLpo5Hr9mAvTJPcSXUi62nYZCQQZFmDq
	daORas=; b=MxK7WhiRX3PQSToO7bcU6y/HrAiDQ4GggX5OSGMGIpLAJDxgYypY1
	H0IL1GSSN65qK6FoF05Q8swRWZuHAjlUr9ZRdZmgkJt2IOTFrg/1ZdfrAyBLuq5Z
	dmD+BlhYyrA2lfq1b9LOomI3rnTR+8MXAewJasF/3ufqgJYZrgNcxnwPi77iNhEF
	VR0n0ZLwXW56djpAf7BMG0OnZi4vSl0YZ0rKw20vR5BIGY686sT53MBXcZmWNbIs
	OqjRpPlyt4FXcv052edU1Se+6Ustt5JPv4pRBFOpej/evv6aTtpJXnrrmqzCHEcr
	tNuvEv9Bw+Lw+2R94YYzyivuQslZI8raw==
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4func515r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 14:00:50 -0700 (PDT)
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c25c44d15so318495466b.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 14:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050049; cv=none;
        d=google.com; s=arc-20260327;
        b=hz4B0one/NRgiZeT6GCnnMDhJJTmOp2vR/uG9A+1UsoafeCZp0z6qDqLDrXGWSyTDj
         YVMgs8aewF7LfUdFhYgsXH5TbpG6kwdQSy+pjL2PmlkOEfw2cCypbZ+QbGLrnvb+FA7D
         0vW6a+UHlJYKcr8EKIOnAlMj3q8hhbz6sFKoeYUDAJ00eOKa+zs1ondwrR/7bavlY7T7
         HDrk9tdyZ3dqIDYLBReLa57cj0JGxw74ZL4pnO4R/VhF0JLSFDTsjGKb38nRSLE/K43i
         Zg569ClFx3rqERJYvDdXIzZnZQvdm09fCjjQXeGrY7XI7pn3HnqHThPu3e8XmdPUUE0I
         wmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nTp6hXk7VZVV5fQRPsG5rxZpnIFm2RbQ6Wg97lqHG98=;
        fh=mVgh6PtmqJ8p0Y8PQb/mF/RE9VsL6vz1VpkNF67dtxg=;
        b=YRk7FaE3IOOPy/cgZMrzjB/Q6A+WMRT3C8P6ZNIsYvVq7MXgpLm0BRNWwINaNaQH6g
         JPtLDyiVoMUNW0lxGuIsSBLShbGvmdCSdQp312fVfaxFLxLMahALTDAWGazUADO8VXXb
         kNZkgLTTZr+t06pYlKdaqU29OcFxtCmpi9kiLf0Rud5w1JqZtI7jzchmxE1YA+H/uGNg
         ebyvHVi/3wSUotn6Fv+rmANy1gJv9ZtxhnUnGvIqSumX6EFBhY7PWwpjiMjhdEzzXaLU
         5xyBrWwNbDX0ZE78jgN+xUiY45czooPszkGMDKsMZkTwt9m0ISyXhl68F1Lyp7N/58Bb
         dfAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050049; x=1786654849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nTp6hXk7VZVV5fQRPsG5rxZpnIFm2RbQ6Wg97lqHG98=;
        b=TVrsuYERWUdq6FzNaIwjMdEDt6xHwqopIzxexEDwMAzVST0+KLePRL0AMzSYJ1h5b2
         gBsxSyXHGS+2iwCyiSDrIEGhBPyIsFsCOp6C7VB9yiCtrPDJa2MUNpiSVkzSmd0yiKYR
         L00WwpUVvMGLVWKpZWqhBNRNIWGSoDLJ6IkKRpHAWOFTKvgNaIYyTCqLnNraq3+lVyUr
         /Pbr1d5HOGf/eeuQsIkbv1w4Zxv6kHD7R69O+xU0AVcCXRUeBCk334swAILXrciNY+SK
         0hR7Iji0McNkCIgzwAWuxEYtrprF/+lFlYfpPCsx41snV1pSHkMETjycU5zoSadbG9LF
         jAXg==
X-Forwarded-Encrypted: i=1; AHgh+RqlLrQCWY+XkYy0u+jtSd5lXu71aH9s0KtkyGO67Kt4F0XUFycwbxMrv0YsYeXX4t6r+pMwN0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UPVSOjpTqBt1YicnHg0A1ohLHdnL0er7yDClYytirFgf628t
	MoG9ig792Y6s6dsBiBlqB+p9tlfVO1TjEkhhafbvCWaJKxyrsEG3piy8R0kOyJ1iei4vj6Jzlg7
	vbOdYqTl/kVESP4AvgIqFFV3z1wv+Rav1dz4bvmDd+RwKq+92tBmq8FmlmtQWnFQnVLteEDLYfR
	I35iZgXT8uIGEdcLvHqkLfKJHh8KCmGJg=
X-Gm-Gg: AR+sD103x9Npo15QU3IA/Cy4YwVSQ1joV19thgZ53QQNUwYUYlrKqglO//VvA/Evl/A
	jaLb95a8MSk8PThAGuInEcXqIf2RaDyFpYjExjO1lXKQJ+YW0MCWpQNw0u9uoyzaI0nnJccEHMv
	TsBApM6MZcBOMs1Ts5bohKFcBFh2lIN6aHL6ShJ4utkAYOp0YaCoCT5H1jpXOzrxAU5UsNPT3W
X-Received: by 2002:a17:906:99d4:b0:c1c:66d2:7718 with SMTP id a640c23a62f3a-c2039d5209dmr854596566b.14.1786050048708;
        Thu, 06 Aug 2026 14:00:48 -0700 (PDT)
X-Received: by 2002:a17:906:99d4:b0:c1c:66d2:7718 with SMTP id
 a640c23a62f3a-c2039d5209dmr854594766b.14.1786050048279; Thu, 06 Aug 2026
 14:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731102147.127082-1-git@jaseg.de> <CAPx+jO_dACmFfdy6v32=V31HYiBFeU0NpnvhVuFWvLQ0Ls845g@mail.gmail.com>
In-Reply-To: <CAPx+jO_dACmFfdy6v32=V31HYiBFeU0NpnvhVuFWvLQ0Ls845g@mail.gmail.com>
From: Saravana Kannan <saravanak@meta.com>
Date: Thu, 6 Aug 2026 14:00:35 -0700
X-Gm-Features: AUfX_mzSDNGyLEl-UUPi4Oxyi9XZAz5DTONgHQRD9ibtZ8HcFoU911_qnyQ_le0
Message-ID: <CAKJaZcON7n66Sk0RFAEiccw2G1aKF5jCR47Ph8+0RRY-Zz88aQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: jaseg <git@jaseg.de>, Saravana Kannan <saravanak@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: DDhMQYAV-xa9l5w3LIf8WmqewUXnvxOM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX3/f/mX6VOHf1
 1x2m8kEUiDrzHe1TBOZSi1Ivf5a3TOlA4vSs7mAF6dpmqvuXS3WHPTsDksdxS1qfyAI8drYgXfB
 Y/yI8yGj25r8BC97xRzT7ykAv3zEjos=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a74f602 cx=c_pps
 a=Ak8bExYEjeps3Jj0Zi+cTQ==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=K7AIXQN9CNApSj4PEboA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=IIT_bRn7abC_HnDGr_W6:22
X-Proofpoint-GUID: DDhMQYAV-xa9l5w3LIf8WmqewUXnvxOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2MyBTYWx0ZWRfX0LLhUOmVIkgV
 1FIWFK12nGuRYH2lvfmd7EFclVd0ePqcJkp6c0R77kdgpmUR8diEsxSz9c4BExX5EbVxcVkEf4n
 XH55VKs+H4l0Nw7cR/UIK699vvBjfIDh9Y+wJSTIE9sXNJD9sYg4HTcZPE0mXfqSfgG1fpo/ygR
 swmGYfLzc7R/l+wTEYvgDCbhzxPask9xSn8VGw5APPAMbRTdQANbxd43F+8QGR3kwPej8ahalMr
 d5iaoDtBqf4GQPl0IHhN1RHn6/Lzsa2p5IMfNdTN7QG+cm2fVm2G1UtxYoeJ6c/kgLiT7YET/JN
 GO6kKENzw+kLGWS5nc91Z0h+wkpo1yl9Sy7bVhmDJStKvhhFrIUu03mPP6jwSjm6Q38uEcFm1J7
 8Vq9vLLSRgj7ebJbtN0dt1ONISpUirkSFt1tytkVo/k9Jf72XFoT2qPKQpeRf/ZxvPRFKaOBRm9
 laoNEnaz7hJFtzqV6KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01

On Tue, Aug 4, 2026 at 7:31=E2=80=AFAM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:
>
> >
> + Saravana, Rafael, Danilo
>
> On Fri, Jul 31, 2026 at 12:21=E2=80=AFPM jaseg <git@jaseg.de> wrote:
> >
> > From: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> >
> > genpd->dev is embedded in struct generic_pm_domain and its release
> > function is empty, so providers free the containing genpd with a plain
> > kfree() once of_genpd_remove_last() returns, ignoring its refcount.
>
> Yes, there is certainly room for improvements in regards to reference
> counting and freeing data in genpd. It's moving slowly in the right
> direction though.
>
> Anyway, the release function is actually set to
> genpd_provider_release(), which ideally should free the data in the
> long run, but we haven't fully reached that point yet.
>
> That said, I guess you actually are referring to the ->remove()
> callback for the genpd_provider_drv, right?
>
> >
> > Since genpd->dev is registered on the genpd provider bus, fw_devlink
> > creates device links to it, and those are torn down asynchronously.
> > Nothing made genpd_remove() wait for those teardowns, so the provider
> > could free the memory backing genpd->dev while the queued workers still
> > used it.
> >
> > This is reachable at boot on qrb2210, where the firmware rejects PC mode
> > and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> > returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
> > up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> > causes the kernel to crash a few hundred ms into the boot.
> >
> > Call device_link_wait_removal() before dropping the final reference. All
> > link removal work is queued from device_del(), via
> > device_links_driver_cleanup() and device_links_purge(), which precedes
> > genpd_free_data(), and flush_workqueue() waits for it to complete.
> >
> > Note: This patch was LLM-assisted. I reproduced the issue and tested
> > this patch on hardware, and I did my best to verify it by hand. However,
> > I'm far from an expert in pmdomain, so YMMV.
> >
> > Assisted-by: Claude:claude-5-opus
> > Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd p=
rovider bus")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> > ---
> >  drivers/pmdomain/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 842c4169e290..4eeb980e5a40 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_dom=
ain *genpd)
> >
> >  static void genpd_free_data(struct generic_pm_domain *genpd)
> >  {
> > +       /* Pending device link removals still reference genpd->dev. */
> > +       device_link_wait_removal();
> > +
>
> Even if this fixes the issue, it looks wrong to me that drivers should
> have to deal with this themselves at device removal.
>
> In other words, I was expecting the driver core to deal with this for
> everyone, but that seems not to be the case. Hmm.

I agree.

 I'm not even sure if device_link_wait_removal() should have been
added. The point of refcounting is that we don't have to worry about
who releases in what order and the last one to release will have a
resource freed. Needing both ref counting and a say to sync feels
wrong. Let me take a closer look.

-Saravana

>
> Note that, the device removal should typically happen when the genpd
> provider calls of_genpd_del_provider() and it calls device_del().
>
> >         put_device(&genpd->dev);
> >         if (genpd->device_id !=3D -ENXIO)
> >                 ida_free(&genpd_ida, genpd->device_id);
> > --
> > 2.53.0
> >
>
> I will have a closer look at the driver core for this. In the
> meantime, maybe Saravana, Rafael or Danilo have some ideas already?
>
> Kind regards
> Uffe
