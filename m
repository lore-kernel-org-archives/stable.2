Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68643ACA74
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243262; cv=pass; b=EQNq+xVoUi08x9PnFPtJWWfM/zHbwdKkp6rKbiFgXTXtyQ6dLpdDrOJdYrbXS0QpUIlcnuJE/kVAfBlztjHo+/3EDFpgIIvD6u+Ohy0M1jarS3MbZFbr4qKr+U1OL1NQ/Bz2CxAuL3nkBzGpLuEzd3z5PU5xbjK8Yeey8ZMpzqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243262; c=relaxed/simple;
	bh=b0sx0plN/+brXM6H07t6I9Q3Pcn6MIVpSqkOawHATLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3A853xTYKgCgxwHYj3PIEeIOu8ZClLaE1y1I0vzwsXCYO7s/9+Zu8ZffgqWtQ7znWi7Vltkfz42gqOEXC9kf6POMYtNh4kmiQNNvIGl6HSHjDufIT6Fn+z80JrG1axSzTxfzo0QnnGNPqZ0BrfvrT0YhSM/oCSZqQZfLH7nPAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GuoFVeyr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzPKfZAE; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GuoFVeyr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzPKfZAE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SCrBgN2953946
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=; b=Gu
	oFVeyrj5q7qEfmAq9Ld9pF3nypwgyzdkuGSuoVTrliv1yNCHhZMtRTyw6zyxUXed
	t8JZrp7fZ4Usyenfy/Xmmfzzcauy0t9EvBjpfHflJsAUruSJ7i3Yd3Lwu6iJ87VT
	J8cUeEMAQv0iItVbW8kkoq58V8clS1/cXeexBCbcq/+hWo0xY4a9cMyRUEeUVADz
	aRRJaTgeyTHySUXMG5/VCYg4YbkxpYiN4HK+RNjr7WNgJg5k3t+iy0hEulHTBk2S
	/vgmHalkhe65yZjvFnEgTpanqwYpMzinT/iEHkpm32sdEqV9LrAzUDjMnujYjQHQ
	KeLaP8g/8L9ak2VswBtQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpvtv80bt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:54:19 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66850cde3a8so9441084d50.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 05:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785243259; cv=none;
        d=google.com; s=arc-20260327;
        b=WS66xV++3/PzK0UuC9OXQ6FYEXgJHkyAii3rMGC2lIIF9yW0OJrAoLYitRmEghLr6y
         jVbr1mvID/El5IPkNQtnCsitvbw4MWaimREcs2OII/ApoP1C8qfILhyGWSU0afe0rLsU
         S5WxO+xy/qzrn3GFir+sAiWzcGhbXUdTrmzbDF+0WX3xoqUxCGhSL+RtUmiSPoJFw1nJ
         TgWnRb7jRnaAVT3nxq4ftLNYmiGS+HTHHoV7r7kEOTHZgQedDHeUoSvoD5b7Q+OWPqqW
         BEGj+ZLojJbgf8V7odoI98B2l7UHXJbPSKSR2Je9E3nnd4tWlSu+lcz+CgU3wlNwn8cp
         mSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=;
        fh=mi6e3ina8l4GuNYikvGQi0lNi4FqyCJ9ChQKfsQYbvE=;
        b=axht0JvmHAdbCiliisSEqodjlSNgHo4+dCi4iY3T5q7B1YY+c7l5jNugevF0w1/tcf
         jpfC+L6I/cmk9Q1tSfu8/o/3xzZm0oPS4bS4SLVrZ5/h61CEhkjQXibu/b/s7bt/NC2v
         Wu99E9oFb2zGd6dUKU/GyC05qeVVRF/W/soLVdX7WqPy4sfEkcXoQlzVBZ3mrjSWb0f+
         M8za8UfthuKpKWdq3uZHq2T8TvCf5USUnwWiykV0vmwp/PksOgyncTx8mHxEko8UjlEA
         zcSvhGG9Apc8Up3jGxEoDu05SGqUP35p1/bYl1MyZgWCDnHtghoOIvAiyRJ0HovhrAM2
         tdrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785243259; x=1785848059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=;
        b=CzPKfZAEIS6S3G+O2OgCX4rMqU3JG1WHfeWlw3LlhhTntQr7udjjmvX5jUtoSXydAN
         6OiOu5EgcY2GTQ5AcI4Rdby9aL/+xrpK6ni782oZ4rZQl/raAByVWUPH6vDzYxAyV/MU
         TdFaL6c/LamYcbSR20HSGcj54X9xaw6+h82XxzfKuZHwnZODpYDv6bEznz7PbMepteJe
         3S00/cTlqxAI/p+1nCfAh4Q5/sd6QjUNVaK0qq1ioPkIOlrolhBZjBF4ZlnrqQutqjqE
         IZoIR1k5gEToA/iJP5k6B0cMM8XheHI9hj6c9BEzGQ44mHFkRnpduNt2PcY0FaM5+TR5
         2LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243259; x=1785848059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cawBiWQxfIarR0xDzJpp07gga51kPcOc4W3XKmecSg=;
        b=qr/sGLRphgS6ZWkiPFjP+UVrG2+WrM6FHmYvuEN2rOcO61CCRPnpcffYe10IW3Su7m
         bBhTSBUlF9uAredJqP+vb3rahBn7hJ31VaxHEP6jATsUZjyV3/LsPKS9lL/iLOKk8psa
         LYiWizFdEdGWWVrGisjpYpARR8EqouFx4iBS4GbwdD1/paw7GjdmwErqnt7Eh8SrwwYw
         ECKmL5fD/8MLfORHjawHjyIU7nCrYLr738ej2YERH9n0POy6eDpsKVV2Vi8eXWd5ni5v
         0aRczE+E6Qq6Jz6EXfexQBGMvwN0p8ZMxyS1tAjk+YNjiVIWBKlogDR9MIJANbVxY3ss
         gubQ==
X-Forwarded-Encrypted: i=1; AHgh+RondNJBCQS4jNBweKwMjhyXN6UYtvmHKRA2RbIKIRe3O3NNJr5oudZ6D9NehERmUhsGLkEYm7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGSOQYmMY61+u2olM1NiYnjniS6QdGjwzdEj7GzCVD090ng+Q
	RRu1mDHBntia2qjiQyjsLbeKowmYu3tsNus8vJCPXm/SZch0QgNnJt9FRMpdABiMzYaYd77zkwq
	Q3HeOIjUg+99NObIKly3t6uqhx2MTHEZ7CP39Z4v/kJP1i+/H23u6DXylApTT8WSNDx8TmzebFj
	qmjvuJ/40suCNDN6h5Gy1v7/n5tfEkbNxm4w==
X-Gm-Gg: AR+sD11/jtwaJ5XYvZv48XY1wgMPuWNO6Bjl+NDifuHwe5C0pBxYuIiaezcSbCiLHcG
	nC8yN3l9bQ2KHtKda1VLTgamn32/WNSYDgn/4n/eSL0DtSl9VbjctRnhisNqno5pEqb1oocg1+I
	ot8m7T844nDRVy876aE1lsz0OhHKcdry4sJotnK60aviTtzvlVD0lzrM9vyw==
X-Received: by 2002:a05:690e:4395:b0:668:1c09:aef1 with SMTP id 956f58d0204a3-669054c30c9mr601979d50.6.1785243258992;
        Tue, 28 Jul 2026 05:54:18 -0700 (PDT)
X-Received: by 2002:a05:690e:4395:b0:668:1c09:aef1 with SMTP id
 956f58d0204a3-669054c30c9mr601973d50.6.1785243258645; Tue, 28 Jul 2026
 05:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com>
In-Reply-To: <20260728-riscv-acpi-lpi-timer-v2-1-5a30e0021ec9@linux.spacemit.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:24:06 +0530
X-Gm-Features: AUfX_mwIyP8SKtHFksxOpexuAlrA0_ifqJrmlt19_-9C5OcL2egVfaB2UDApqMo
Message-ID: <CAB19ukH1Srbw+Yko_-21DiV7Wc0ysJX9cmE7xDTwtrmUm_5rMw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: acpi: Handle LPI architectural context loss flags
To: Peixin Xie <peixin.xie@linux.spacemit.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Yixun Lan <dlan@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>,
        Oza Pawandeep <quic_poza@quicinc.com>, Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: fU--Sb2tuWClAKLJ2rGBSlhyuG8OfgXD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfX+13+cdif5/ay
 qhQY+BqYZr9oeJbrDBeY7WlptsKoCNiZnBljuuSSodNSL3qW7dz3j4XevL2z8yS5YtZNRK2+HQd
 fJhiWk0rqMeDaQ6CAwaXK7cYP1dYd9U=
X-Proofpoint-ORIG-GUID: fU--Sb2tuWClAKLJ2rGBSlhyuG8OfgXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfX5lHgQ20p3BgB
 ILM1yF3cEX+euPuhPXWs9ixKzFx/EIGO/O2LFxJNoLIAxsSM9nvxSLYcwNFWYC5NuZG5w7oW8I4
 h6pSYT8REkY9mNxHu3VFBz9XhmRVU9Le0PMkvAmalqZpRSlvOVmRqYDzTyxWPHqg6sXR08CsQlU
 0C4c7WP1Od8e9rVUbZkc0druchtaSbNRp0tWb9QGVBkGSFhvXlGcW8Zbw51H+CoE8J30uP6zOkE
 iMG3tx8tt49de9+GlclppicGI+wbeJQvONG0i6nzN9qtvaWFcFwi2CI1HxnXWVPTPo4t1IzuezV
 K8PJJfUryD0OnaTeYIV/V5BQzKkOlzxAnBtse3eW2ks5/OUnOpeCz82c3n2TqqXK8UJp68WsYLA
 OAsqmhEYAOnEdC/vBIXS59xKB80WSmYowHw15Kq1UtPnY9FFTqqbwKrnSpd6odO+2iH13+N7iJS
 A58NEjK7iXsSOPsoUMw==
X-Authority-Analysis: v=2.4 cv=dOiWXuZb c=1 sm=1 tr=0 ts=6a68a67b cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=bC-a23v3AAAA:8 a=lv0vYI88AAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=YoT47lCsnKj-Z75T7f8A:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=FO4_E8m0qiDe52t0p3_H:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280114

On Tue, Jul 28, 2026 at 5:24=E2=80=AFPM Peixin Xie
<peixin.xie@linux.spacemit.com> wrote:
>
> Commit 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for
> broadcast timer") replaced the generic nonzero check for LPI
> architectural context loss flags with arch_get_idle_state_flags().
> RISC-V does not implement the helper, so it falls back to the stub
> that returns 0. Consequently, CPUIDLE_FLAG_TIMER_STOP is not set when
> an LPI state loses the hart timer context, preventing cpuidle from
> using a broadcast timer for that state.
>
> Implement the RISC-V helper and map the hart timer context loss flag
> to CPUIDLE_FLAG_TIMER_STOP.
>
> Fixes: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcas=
t timer")
> Cc: stable@vger.kernel.org
> Acked-by: Sudeep Holla <sudeep.holla@kernel.org>
> Reviewed-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Peixin Xie <peixin.xie@linux.spacemit.com>
> ---
> Changes in v2:
> - Correct the FFH specification reference to Chapter 2.1.1.2,
>   Table 3, as suggested by Yixun.
> - Link to v1: https://patch.msgid.link/20260728-riscv-acpi-lpi-timer-v1-1=
-c722bce01e48@linux.spacemit.com
> ---
>  arch/riscv/include/asm/acpi.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 26ab37c171bc..2643e28fc08c 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -12,6 +12,8 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>
> +#include <linux/cpuidle.h>
> +
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
>
> @@ -67,6 +69,23 @@ int acpi_get_riscv_isa(struct acpi_table_header *table=
,
>
>  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_=
size,
>                              u32 *cboz_size, u32 *cbop_size);
> +
> +/*
> + * RISC-V Functional Fixed Hardware Specification Version v1.0.1,
> + * Chapter 2.1.1.2. Arch. Context Lost Flags, Table 3
>
Isn't it Chapter 3.1.2, Table 4?

> + */
> +#define RISCV_LPI_HART_TIMER_CTXT_LOST         BIT(0)
> +
> +static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
> +{
> +       if (arch_flags & RISCV_LPI_HART_TIMER_CTXT_LOST)
> +               return CPUIDLE_FLAG_TIMER_STOP;
> +
> +       return 0;
> +}
> +
> +#define arch_get_idle_state_flags arch_get_idle_state_flags
> +
Otherwise, LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
