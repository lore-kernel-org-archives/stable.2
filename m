Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEF44A3EA
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514916; cv=pass; b=SiNHAAW4L0qmTkeN8AwaLTpkfV+SgU30SBVqp/+qzzyXYdmlNJfbuQayJrqPowIl3vpjufxDv6eOgjkdob1svN1KVNR1HACaMtpavCDiKMRpk1mgmbOwlGGpqo3CTH8I7MKrzRyZ74tNXYA1wPy/kGz/qiK7r/SK1TBS0Qr2fnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514916; c=relaxed/simple;
	bh=fW/lJf2KOwA98xIgXZaecXl33Btgc1UgRDfZfpjaz5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaJOp5S9hMP7QU1YLUqoPdV0NNpyPAO7m5g7autBEv403drJfDQRQ/AxmTwP6wmagA/4+ZOLjgMCyELDOSeSHDtKglEQSZ4jU4EnONu5pKE4sbDkNztqYLGKxqqr9IefO7IuUTo74fEi5uSBZJDwayUMLzK8vzc0HgdBBJE9ysU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m/1p6bDJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q/lnRKqZ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m/1p6bDJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/lnRKqZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mg3L2945698
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 09:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=; b=m/1p6bDJhbcvyAvv
	FCIbW0xSwPgxhakn0b4i8Y+2HxqXcGy8P/61V702mMnKPuAiIYtbYPuJ6czD9Wfl
	PUuk84OWr+XKKSzwcP9UiwPBnDxD7N9DNZKYIgWt1i/889knJwk1B0EEM2BZ4Hvw
	twow6ujuctNrePq1ZSu+Rm+QYknyx5Abt4KneqInvIcUxqWX400zv8dIQiN4WTOK
	GnzOsOpI/nJhZ5AwY0X8BiLSvSSUmAW9TtdllRBdIFYxIwSBjZAdg1IzP5YhuoZI
	2KN5nnEqNeJzTLiHPAlfcouhH4irE5lWzDlLRej1dnoo0MUGOYXLMHfihoYcZh/x
	hf2Hiw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd0uqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:41:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc44d708055so1704869a12.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514912; cv=none;
        d=google.com; s=arc-20260327;
        b=ZxyI+HrEAAHxQAvEfFW9MCHOlNOR4z772yLfC1+ribkEWLKPpAezzmX6HeNqVmzgpF
         Wmywgm5R/954VSs2PPuA1LV9GFp0Z0Y58rmJ+Nizpapce/LzmNRAzxdBPCrVKRnoiW/Q
         atUNMQHglP9/nssXyYus6YRSlr+uzNmt+DSK+JRK55Cfh+X81INiEgysfQIsOdomNpV7
         a9MBkAIc2EMvQSXa6/6tJmDEPsS5H1op9Mxt3mca7jzZOPMrd7Idusvg1FITX2B1rah7
         egalewpfG6KPTDNYSpDisdj5N5lc4VI4CfUUwnu/DomrCL6yice9UT6fvikbB+VCklAa
         G86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=;
        fh=9CQO7cNpIlwU4cqWjavPs8G9O1IcZ0NLnZtwMW4S8sQ=;
        b=MkkP5QnwNY3uq8wSR70AEiKwsiJeWKsWYwK1DDD8yXL9++tTCjfiXxme87i6Nc1yv+
         t05dA4yyyk5bQZgh66KmrI5IL7zy2VwksPfYgDJJn4iKSU6kdY/I18DYNpvNhpw/bX5D
         IMEUmsm2lW7xyNfS7wHiysUjNPIsFIv71BAkAti4f72ICEvfEWhuMRylJ+jHdSb84YE8
         JBKxupd14Rqear7eATPrq4o404/A+stqUTv6p47yilqA2vqgLvENTaECkRxJgoh3t6Qq
         3kbc+rZfJHsrtQDHYnF75nEwaN5OC3mFWy0rC7Fw7szgf7FylCYtaxYytj7K8HvvmJPK
         nC4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514912; x=1789119712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=;
        b=Q/lnRKqZYZwhUZ3NPccWNqsfsJj+YynG0f2/ACXxOu8uKBASK9lxGkRUQNFnMzHrVW
         sDlsYiO2ZqRntKZDhnAeLFE1kpjm/foEMycy4pyEPunt/LVAb6suh4AedaJLib3Bm5Sx
         d591O+6GJ1Tej0nrotlor+l593+QwM1p8PVwqVjtzDMopwr7RJu1AGQRmiXoSzzdccTN
         /INfUrWLVqpay0OBSRbqJz3KKRqGwDzy6rSl6tqeCH7OdeJCMLzA9TtRn8m6NiPz4+kM
         eOPYs6zbRmrWyiWuUVXFFO81C2SEUaIANaOReyY3TWiH9SR3RhYKunuzjnbVuEOuXFyM
         nR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514912; x=1789119712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2E3NOcNS0Jrf1iDrahKhhnn2EkNDFS2oGiB4m/hawxs=;
        b=H1N3+KB2IlHvRCafp5+8QD00DyKp0xP5gBWWa5rVflMQJWtO+uoyVWETyrWBXUDjBQ
         lH/uGu6TgwUmdX0cVILbgOs0cVfl9RRB+vydxIGFpYeLQBADKhatTsp0ll8fBeBNgHUp
         eoTNkA7T5I0SXmXFySvyILqMqPGWkDreiwBJMGopPvDSdFO68ZpotFq75lyPw3OVmTPN
         bfZJp4wUQfhh8EKFc9O9o0SbQ5TaavPyKqmdL4YHnNmHWfq6rIdn2bx+bvFm+an8mAWD
         JwsrGQTLaQqYnfzycOwI/KOpVeugpTHb0DJ2v8GEm4pltdrRycmPVcxuUhAuHtHdNrJO
         kXbg==
X-Forwarded-Encrypted: i=1; AKwUvBzG+lZGZT7wj8di+SmdaXn+zJLSd+uQfJ9gWVLJcvUm52EvuPCsLQhIsliVCVdBYX/R86WPmbM=@vger.kernel.org
X-Gm-Message-State: AFuF++nvJQjrTnQcnmhikY40K8wvJKyRJ3R28f4ead9NgAHllaGJ+Y2M
	T3bvVPOY+Eeh61rt6kFUP5T076AQZKiWDQnE2LwMMR2/xRv6ij3FDYYIRFWPfxAhufbjwT6XehT
	3J4vE6CYOSE/jmO2Osa9dqg5vIPO+yk96hAHMh3JxUapbEHA25JlE7hQ/p0ZOVvSv5DPmVQD/0q
	+xRgdaAcbK3jBzW6Y5Gx6z2MHQ7cAJdjHgGQ==
X-Gm-Gg: AYBFou1ERuluMSqkuxjzPPwlS0CnolW7b8nEhjdTvTBRInTFVvkWG88XZ0S7Zgb8JdX
	mq766pOOsGa0cIr3rHtvwhwLMxl6sLGtCIrFDsGVq2ia/gfwrCIQdw/FRDNPANdF6AXduTf2CpW
	Nqp9L0n7jEH55sSBcrpJGe987jDHEefLgAtt/u9jy/zCn1RGdWQY7HpE5gtQ==
X-Received: by 2002:a05:6a20:a11f:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3da3a0af18emr6356079637.13.1788514911951;
        Fri, 04 Sep 2026 02:41:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11f:b0:3c3:b57b:6285 with SMTP id
 adf61e73a8af0-3da3a0af18emr6356033637.13.1788514911524; Fri, 04 Sep 2026
 02:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814082354.211351-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260814082354.211351-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:39 +0200
X-Gm-Features: AcwNN1WJ3FDLKcn4NhY0mFjhOVrTyC_iuBbL5V0szQwxhM0gmqimaKPle9KR43M
Message-ID: <CAPx+jO-xK2AWPL5WtOqDbBsEDtHM5d8bLhQcSUj0f+MsnjFOOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: hsq: Fix use-after-free in retry work
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang7@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 4W8v-TJ5IRgHnFgJiNGfDQD5l-LLDp54
X-Proofpoint-ORIG-GUID: 4W8v-TJ5IRgHnFgJiNGfDQD5l-LLDp54
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX0w+fQZkr8ssI
 Cq06h/IUBLRqhsSygpib7gpUXGYfyclpaJOKK49lnvi3ID+2e+JI41E8f3nQNaNc++BntnPNOO5
 6+tJdm3lyoe9voyBd4jEYp58irnwy10=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9a9260 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=9HIRHvUZk0GByUwP-94A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX3jNdY/rp/zW7
 fGvwhTHObwoCS1LAwyWKBaqISf540fWrcn+8IuFwHH3JqEy+BfppE41bunHymshnpCjfpWEUUHl
 wvblHzSEDBuUm24HZESDZ2qPkcoU3asbv5h9VBBz9qGl8gJBaZmMsWk3WQEm9AULWAKMjBIpQd1
 PV5W1j8H9tqImwEO8vsYoAe/HA7TnrjWq2h6s8SQfih1zPXR+BcF61LVYQh+IKXEWdTAwcNb60r
 w56d2MuGKRSBwe6OfDJPRWJ2JBI/tSYW2lKtxP4LU5FsC5fiAMusMs5sGfkKgP07HqSg1rocnV8
 nJtk+MpjcgOaXdVOLSCY/bOV+yqGcI+v4anaVUlwN7oJnD7sCfq13XYHuXhJrEEEhRbRWyKOQ6X
 WVZ1oGgKbuYwxClH1qrZoE+5P235Q5bg3nnJRV+DvKwi47sJCIVH2o3rAgCquSeUK8VLlnjA3WP
 8vz8QDx7RZvPqxQz2yA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040088

On Fri, Aug 14, 2026 at 10:23=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> mmc_hsq_pump_requests() queues retry_work when request_atomic() returns
> -EBUSY; today sdhci-sprd is the only consumer that implements
> request_atomic(). The work is embedded in a devm-allocated mmc_hsq, but
> is never cancelled during driver removal. Work still pending at unbind
> can therefore run after the devm allocation has been released and
> dereference hsq->mmc and hsq->mrq.
>
> Use devm_work_autocancel() to cancel and drain retry_work before the devm
> allocation is released. By the time devres cleanup begins,
> mmc_remove_host() has already stopped the host, so no new requests can
> arm the work.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: 6db96e5810e0 ("mmc: host: Introduce the request_atomic() for the h=
ost")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_hsq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 79836705c..57e172bd3 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -7,6 +7,7 @@
>   * Author: Baolin Wang <baolin.wang@linaro.org>
>   */
>
> +#include <linux/devm-helpers.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
>  #include <linux/module.h>
> @@ -345,6 +346,7 @@ static const struct mmc_cqe_ops mmc_hsq_ops =3D {
>
>  int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>  {
> +       int ret;
>         int i;
>         hsq->num_slots =3D HSQ_NUM_SLOTS;
>         hsq->next_tag =3D HSQ_INVALID_TAG;
> @@ -363,7 +365,11 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_hos=
t *mmc)
>         for (i =3D 0; i < HSQ_NUM_SLOTS; i++)
>                 hsq->tag_slot[i] =3D HSQ_INVALID_TAG;
>
> -       INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
> +       ret =3D devm_work_autocancel(mmc_dev(mmc), &hsq->retry_work,
> +                                  mmc_hsq_retry_handler);
> +       if (ret)
> +               return ret;
> +
>         spin_lock_init(&hsq->lock);
>         init_waitqueue_head(&hsq->wait_queue);
