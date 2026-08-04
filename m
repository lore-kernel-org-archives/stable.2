Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0813F8EDE
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853879; cv=pass; b=eoaXkhOclciIKuLmaP3Gjl4aYvxASv+IVPZ8kQp5/0HAi4F1XRLLGMKu5rsvqjUQdm7E+V/ENJnJSxgzpoQef5cpCItkJhG2EOsAvRKHUi6plSgCRi9qBOu4V++Jj1x6RGsg8v17yLaE5CEO6PoLJ4wKmuojn+38KmAX0qvJOQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853879; c=relaxed/simple;
	bh=5mCmR/6RUjKq6DEM2vGmt/KL+t14Bd5bccAfyxQBxCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRLXDjKDCxoZG6Cf2ZB85nCLIe+rtbya5UOL0tmu9dm0snwVx0XmcY1kxyUAlL9d7sNVe+SubbacJnLMVqgDUQVcLIyWQUNsloFHkkb6VDlgqBQ5NSIC7DgU6aWKwAuao5+XfEtzEULt3xY05zQBATGWWIMLFWOGXSKlcv/Qe24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQE+Atnl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Emm1Aj0F; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQE+Atnl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Emm1Aj0F"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXATA3572494
	for <stable@vger.kernel.org>; Tue, 4 Aug 2026 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=; b=nQE+AtnlVP1fUw77
	L1Amwx9hTTIRUxtU69jv2ipTe0oLZs76ubHtqVbhaABic/DOTFTjCZW2Pyf2wBON
	0N4iD0wfDbONJCGJ8mFP2aT+y6B6YIr8SuX5XMBNaL4N/fMlMW8cDSZPa4Fg0aU2
	HXT8ikgCCUqFtZIN7O0toIE2FXuJDApEvheHtUhW1BQyPKPXyjJ8irn86G5UJWx6
	ZqF+/qZVVfLU1Sl9jT7GDy+26BuMXGN16MZkweuYTEKGpfrxoAyaQ9QCUta2MdDW
	kOShYYbYXRjSokV3WoAi1SE3IccyPjrAIrG+Q2hbJepxm3qCUaB429RS/rHsVB9G
	gqqnKQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu2sykrhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:30:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fc6b670b4bso45841666d6.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785853858; cv=none;
        d=google.com; s=arc-20260327;
        b=a1IKarA2GkY2KrCFVC+Dp40zUF54zj0cwLKmDLgMjFtMVlo1RD8aezVmqCyT0AOdN8
         +I2LenZFLYx+NXnG3zb70TiuZToOGNKhx/l/2GIBWfjf06j+tYXSGWyWmUnesl4rlEPG
         1z4mjEqi2EzQvbNKRcg6PJr7eJwnQClwkJeHls8MXkwPCjlAamYqeP+fUlKkPqAcEeTc
         6pQDLfabctvpHMIm9w+uq0q+LVpN7Ko8kCMGn668weSkiZtpCHgt6kedkkRk6Bm6xweA
         I92vU9M7YzXSxlsfwwv0e0NexiBE730Fv8NIoIZm6mMtD7wVg+94UywV+NxfXHEFe3NA
         eHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=;
        fh=1qgZ8ak6YH8p31MudQQBdROQKLjifMrJuod5QeaSnEQ=;
        b=T4zZJMiXoS8BYGOrTKhjJ7p7E3QDM6nIeGa4b4PXOBz5qo1RXsBfW7ejECC3mn4N03
         PYYVpdxgKPExF6E+cnsBbi7axyMOduhcenua3gr1qrKq9DC0pZ0Fzb/YF1haVtyGqYtP
         xojNYeXpbRupx+cQwcHfoC0Qv/klKhqIu+yMeYJmGMJpC+7OrprXQVvCfS41Bfk4vGIh
         EadnRmu0llgC0jJUfWgl/l1oHW+QVBq4MWZ/UU1A8SYIx2REDiXvxCkEVDZLkPIBV7rj
         1GkyG4mKfIo2/eWluv4F57i0PK+mrs3eAX4jw7Qa8RKZbBDZuof8Wd5RX3SQZYzPlebH
         vkvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785853858; x=1786458658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=;
        b=Emm1Aj0Fgv6sNDYK5t0S38AU29p0v6h7i25XYm/kDi6+m6vm8WdJr0oqg3kZyrzioj
         0KHxlRPAmTdmsHa6ouJnN9krP0cTs9/CyNQ297wPPOEte1ID6GExYIEgJ7gagkbzjWR5
         RD6kztkzcKCmJJdlWejJ9GJSqSc646xQplMIDRrTRCflAU4p8wCGx2OI27DkOgoyp+Kf
         1TnbhK6BTpO6BSjigoLn02/lbs2H78He+vJHqW0+8f34BxWXJjM8pGpxCYrjVVacVix8
         bWza/8wjDwoVixaW+VGnJgsurQIAfQOUGPjoSwPcLS6dbLn1hvJBiZUWVgVSck6l2Abi
         C6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853858; x=1786458658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cg6rAo/MJYlbCvgNVBkuRq80ZlIkgToqz32zBTLhVSg=;
        b=jGUhzVW03OJUv9/l1z8evRKY7uiRJWy2xLXZi2MeGWbxKGHNMh8NCint/ABQUpKmmH
         rzp+wDvfNRSV1c1ENvE5b1M4wUiA1Sgbl+xtgxjdDF8rfwbadmbEe+N5Mt2uSNcDJOsg
         yw5yUSWo8+PFNpcTRKaCQSLJO+YC3k0bHnF4FPukq2X6FrxH90ISxxC/RcrtRsn8gb+x
         28p59gjUvdiehN4eNzZDMd6rFxUIfYq5DDZO6G8QrFZUTXW/Vc41JVGeHp7iypmJ/iLT
         McuFPpz3bVKhioC6IsZv6j0bhtOq4IXYLnWJjCWHYBmYwaoVoMRP1olHcMNiIAOuD1Gl
         utlA==
X-Forwarded-Encrypted: i=1; AHgh+Rr57B9V4idOTgdXTf2ESyHkH/VXpXgboWpTmt7kwYJg1YznU5tR15RGCxQ9sqgA8oy+14XUjAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJO3JAe+kkTXWKWkEwmjre+uLivvys06SJ3jINCbx21PWwzWE1
	AStGj9A9IY4IcX/rm8itKoXsJkrLe6LG+T/j44XHmep2UHBXsIUfMnjx1YbEdhldK7NEHFO64eS
	MFcPEbPRq5+DmPa3s17d4y0kbbEjydd4Jx4quqTKsdgLeHkhvZBLPcz3oO05lbXKXmsz6j79/T2
	x9MC5iz4mG4lViGEGyBKHTdCpl07YWp7q3FQ==
X-Gm-Gg: AR+sD11Bz8BA9RE3pu5ktr2HaJzKrA9dT+baPHFrG0rgkqBVdUJHgZF2YXTkSpSWpjr
	q+hLsWvt8m59fYIOuxNzM/fGn24SzJ3jKlihdhLMgXfEPSK8QQG5DKVqjNyTd9nBbI1Q+cbQ3WN
	RFR9usXSqd/Q8d43LkOkTJDcbeqCXCGCiNgiysdYw36WuZ6F+5jUd+qQjdtQ==
X-Received: by 2002:a05:6214:3286:b0:8ee:b05c:596d with SMTP id 6a1803df08f44-9084967def8mr342440246d6.22.1785853857794;
        Tue, 04 Aug 2026 07:30:57 -0700 (PDT)
X-Received: by 2002:a05:6214:3286:b0:8ee:b05c:596d with SMTP id
 6a1803df08f44-9084967def8mr342438776d6.22.1785853857275; Tue, 04 Aug 2026
 07:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731102147.127082-1-git@jaseg.de>
In-Reply-To: <20260731102147.127082-1-git@jaseg.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 16:30:45 +0200
X-Gm-Features: AUfX_mzgivo-E3HGpQ3QfM9X418W4Z9nE91hXAlBr_4P1WkYtGn-e3ZUQvB34SE
Message-ID: <CAPx+jO_dACmFfdy6v32=V31HYiBFeU0NpnvhVuFWvLQ0Ls845g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: jaseg <git@jaseg.de>, Saravana Kannan <saravanak@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=TIh1jVla c=1 sm=1 tr=0 ts=6a71f7a2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=18yQujymN4OLJxJT4uUA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExNyBTYWx0ZWRfX2pCdAJ0P5+OK
 w/Zg3L3Y2Z59+6rPGotpGDjuohuqG3ikzfc8ZRBHGot8JwysX8Xjkn3Md54YnBVnbwqdFGhUGYt
 Jk23VCRPpfJjG7H6Q6PS+AReTUWnhSs=
X-Proofpoint-ORIG-GUID: Jb8Ssme00WY0TRlGtCkbuAhtjeaZTDwE
X-Proofpoint-GUID: Jb8Ssme00WY0TRlGtCkbuAhtjeaZTDwE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExNyBTYWx0ZWRfX7XqL3Q5EqHsB
 0xyPa944C6EcyTn5zEhSF5tvfX7TFJR9U+YCJvUNSWcyZt65zjumlGZN8OmTw1PZaJqN4//hdt6
 cx84H0LbJk/U/GEIhDT7Hwn7iRnd8oAK1SMsUn3t/52YbNBVjPcJ/me+GzroQYDXL9JJx5VZW9Q
 KE0OhhDLk4VPduk3CT/Kc6d/rvSmo4pdAMHet03Ww7mUldCqOZEukb4J3C1GP0hbMdmhBnNe0TV
 c6KhYIvGc3I4yNczIilh/YvCNsuMBR36ba1/mNNFfcs5IeBfVmpJu2w5xOJSGT+hR/HF2q0+Ntp
 j/Qqr8h99vrfUHAosqnTsZimRHoLGnHHKDTLM60UBXzvd2yk4mImdfiMTDX9Me4rcXJCNlQ6Ww1
 2d1rybZA98dHwhIhHvVrgsm+h3S2YyKgulXYjd8sChg1w5KG/3RVwXuFQeiPN5bwnQi6kspTrSb
 JIpEAmoBi7rvLPh7Utg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040117

+ Saravana, Rafael, Danilo

On Fri, Jul 31, 2026 at 12:21=E2=80=AFPM jaseg <git@jaseg.de> wrote:
>
> From: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
>
> genpd->dev is embedded in struct generic_pm_domain and its release
> function is empty, so providers free the containing genpd with a plain
> kfree() once of_genpd_remove_last() returns, ignoring its refcount.

Yes, there is certainly room for improvements in regards to reference
counting and freeing data in genpd. It's moving slowly in the right
direction though.

Anyway, the release function is actually set to
genpd_provider_release(), which ideally should free the data in the
long run, but we haven't fully reached that point yet.

That said, I guess you actually are referring to the ->remove()
callback for the genpd_provider_drv, right?

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
> Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd pro=
vider bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>
> ---
>  drivers/pmdomain/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..4eeb980e5a40 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_domai=
n *genpd)
>
>  static void genpd_free_data(struct generic_pm_domain *genpd)
>  {
> +       /* Pending device link removals still reference genpd->dev. */
> +       device_link_wait_removal();
> +

Even if this fixes the issue, it looks wrong to me that drivers should
have to deal with this themselves at device removal.

In other words, I was expecting the driver core to deal with this for
everyone, but that seems not to be the case. Hmm.

Note that, the device removal should typically happen when the genpd
provider calls of_genpd_del_provider() and it calls device_del().

>         put_device(&genpd->dev);
>         if (genpd->device_id !=3D -ENXIO)
>                 ida_free(&genpd_ida, genpd->device_id);
> --
> 2.53.0
>

I will have a closer look at the driver core for this. In the
meantime, maybe Saravana, Rafael or Danilo have some ideas already?

Kind regards
Uffe
