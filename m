Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372236E466
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033733; cv=pass; b=oR11d7W2bduqfnIvz7wDASzRf/dsKkbpXO7D0AZZ5Ni5rGQ0aojiRuSmvT13fuoQbzSXoX9svJGNALPIerRUlyDTqD+1TZSj61de5deo8vUCO3/cjYUOcqiQ4Gjpr8FmktyjBPJvzLmxx6lqlltKhJqP0bfUYwDRRzlIVkdkFtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033733; c=relaxed/simple;
	bh=P9oAoZ7SecBGhbTjR0WqYokr5JGDD2Bt/xiDHYc/qjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y23vPKWf6pqf+M3aOK5PGUchxr6gnEVP0jromyolcLcm+FmoFAri6Zw4SeGwULaPQdalnOSLLRNq/KNo2kRI/3TvIoT6fgkXCdyjLGZqTAhW9c0BarytLswyh3gnh31srZmq1fKUlUBle041pKpBQw0aYnZvZ1qF2bXqZYOalGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F4KnF94T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OwseXXVR; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F4KnF94T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OwseXXVR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A8psrK340890
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=; b=F4KnF94ThZPlCPXB
	ELuACDM7vfX4nzSaDQPZ2nwfPYa2kiethzdgojbYncp/GJlM1PpgA8MVhziljHN0
	BMbRolZ5FAeZf0jub24aO0L3T9DtkEcfIEALAv0acWO/t1wPgcEvOs2sWoRn+Aap
	biHeqtD079eamRlmvVsXGYHa8r81KTcGP2nxsCgF4ukpAjn2rsbbARgaSROcSUJK
	LQtnlrO4tNxIrr74DK8xfSTLUlzJcbwUarRsEBHldvcrGARMsOxRqzMQfIJLLWeL
	nxhu+fhvZkFKfTrgJKhnQ7en80JXJF6QQ+mGHAEc0W01WGcqVlzJZWR84QN/6KrO
	PYr4dg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrak8gs4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:48:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso369462a91.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789033730; cv=none;
        d=google.com; s=arc-20260327;
        b=REu+13iKd8dYqoYeq+nBmEiR6nWgjG2Ra3LWKCn30XpA4PEwVx94SwzZ4r1uwXHufd
         Enpe7DOExIOopsCvkvWhT+Vijo50fusViJV7YMyhQlb7oVh+ROUaD/OPXzUNT66+Pt8x
         OAJqKwUkr51cUdeMQZ996d3BSwVjDUF21TwORtteKS6Ief+icx0QGC74o/y/sE2fSfq6
         1KyGY9QBIalcuZy6Fjb2H0TJzbbBbA1RpFvn7YKN1+JiWQ6cO3bGbQsrQErKWoOKXWj8
         OovibH4c0FuMFB1CoOK2mY36RSdwpM45MSnNJ43v1hMFM/cEK4TYwZZgf4/cglpntcUC
         eTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=;
        fh=jJES6pUPzgnbM8m67+WPxB9kMicClRbXheET1YsgEI4=;
        b=XbzHlxrhY8VKbtyZJCgRcTANpgZdVlnb/Hw8waN2DPkP7N0vPN6BFCmCxxza2ok7Oo
         qFAmKd8qYTmEifs8OSh0uJtG/xuOnGyC0iO0uuwiaZyS2AgwlvAhkWAtqf0D6sYXXJF8
         fak94b45Iuc9LjVRTDJ8qZV2j4yt4Yd3+MP6PuLy5+eO1IiFaIYL1tYsmbkg20hdfFKD
         GxR0hGimOa+5eWg6TjQTJvKS+o7Io1IZtwBH/fXhTDbVBHv7T2D8kMRIt2tEJFqcRPcY
         zbmvvZzkg1ldLVri9oee+kmMzzGfWk/q0W/73s85WoJC3a01zp2Smlu77hym7NlQK/WG
         GLtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789033730; x=1789638530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=;
        b=OwseXXVRLXcLF8Q/LPoSjzcEiRysHr0EM17EG8aa4L1CrcOSNiXP6yD2eO+93JtM/V
         Umau0lahU0kxuWa2G9Q0bxTAXotnAC7GAB5KGcpysPKXrEmmJtNy0zKFHWT+1uH3TLYF
         xqlR+uWqLXPEAyyWp5+zv2xsEw9hQvC0sHmy09rod0ZXKL8HjOiEaY1vpiOpETcXm5d0
         dHysh7jXqzQCYAAhBK/jMbQHTOT+AQ5uVQIBtZOT4QdlBsG+SISwyejnEmW7IQQswpyo
         ctymM3jO35TWL7/l9wkNXWOEiaOGAkAaKXZpQK9cN9Lh2L/f20smPNXtjkf5ormpfVlI
         ITig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789033730; x=1789638530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=;
        b=JeafYobUvI9m3KSCgENXGiRAcHySlFuEqhJFqHtxz3e+9K/Svr8lQEaCdkV16VhKP6
         KzApRndu+ThmbMwdCs02LuJN+7Dp5bprg/AUiPyO+mLXuHKgbHMx8K8G/k7WT50geI/I
         OjIT5oZ5oeJfK/FSM8Vsv96BMURaOeFt4JWuU9eR4996QTccd03/knv3ZUwHN/QzLOLF
         z1+48TdeyeWUrYxTrxQfC0IWuoGspN7MTIi8x7bjzFp0x+zWuWvoBcF03iw24hdorHSn
         6qzMj5vRn1DHJbZVomcqyTEFkJebNgk8OasjrkzMhOp5GTciJhsBTLcPMpX2xDX66Asd
         4ssA==
X-Forwarded-Encrypted: i=1; AKwUvBx5YK93QWA/IhPhGVhW0uIr3HsOLcuIYvDFq2XFuIEAaiNKcTS4Pd77b2kyMdv1YOS2x1cmn7o=@vger.kernel.org
X-Gm-Message-State: AFuF++kOpPQttNbH7mxb7E1zB0s/T5cD8ixAF9xN9Hnv9tkIYPZOMg9W
	CDIX4p3TDFHgrNT6asRWSbMDxS3/3JlcDZbLtZmtlPHz6bHysu2s1vmQEZE6yNYGixI052tYcaO
	SW6Ih7coLvSWmqhIMIQ91H8cxYacYkYALIjLDObkqiZoWej/XAupA0Lbm4Y1TJS1iqRN53vk8no
	2hx7UOIqx+QOscs/YcJtQMf7AjXqcagw4dqA==
X-Gm-Gg: AYBFou22MRMX1VmvXxpdI4Q/nkxWvoFzBT5sNj/9OwgcFrSCcRUXTkVt/6rEaZlaNau
	63/kY28rehUh99f2Lq1mTel7st3odPezJ7AgRsesCn3yFEAnsmCP80IqMGfCuvQjRTxGxB4ndJK
	HSpabAuc/BO8yBbZsnlA7HanJWF+outiJubuGJ42iDb4op5kHpqD72DiXSkQ==
X-Received: by 2002:a17:90b:5485:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-39d70c2f16emr9938805a91.24.1789033730186;
        Thu, 10 Sep 2026 02:48:50 -0700 (PDT)
X-Received: by 2002:a17:90b:5485:b0:398:9be6:f999 with SMTP id
 98e67ed59e1d1-39d70c2f16emr9938760a91.24.1789033729754; Thu, 10 Sep 2026
 02:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721073612.137259-1-xb@ultrarisc.com> <20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com>
In-Reply-To: <20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com>
From: Anup Patel <anup.patel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:18:36 +0530
X-Gm-Features: AcwNN1VtrgITlL2Xz8ROk6p7GYj2cQAUch2tRwnfxZo4Abg2uCG431NY2Z7hSEs
Message-ID: <CABBgwmtrZY_KB+ffy5At3sz4FjOqkePiDwCEsF-pG7ZBJBOxBw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
To: xb@ultrarisc.com
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDExMSBTYWx0ZWRfXzcL0UAQ7kaya
 +H4KgHUQIz+ehPWpiY7A8kfJBU7l4JPefgQjdaiUzNBwrHwsCLRicLSH0WhhPEB2eUMPscuPwku
 xi290UgNJ8wv39JaXINEIPCGWE6nSd8=
X-Proofpoint-GUID: fbpStdvIzaNz-kpkWVQoOAXEQapjrfX1
X-Proofpoint-ORIG-GUID: fbpStdvIzaNz-kpkWVQoOAXEQapjrfX1
X-Authority-Analysis: v=2.4 cv=EspHPicA c=1 sm=1 tr=0 ts=6aa27d03 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=Lx1EvxgrAAAA:8 a=W-_n0kkjAAAA:8
 a=BwDWKhTLMd55pYuKsv8A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=ZFi1QaP_tuf8dODdgmj-:22 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDExMSBTYWx0ZWRfX6wb2qHYQxOca
 firZKiCpXQbLMa1Wf6vOfO8CAhhN1USyAe7lhJUdE3c8+oKnakTdd7yaFvW5b42y5+bAdx+r7D9
 +ntgxfFArpHZpDZzDFvVTIS1ioCO59d/WuWM3xoU5KnzqBexHLCCA7n7Ga2jXJII33l81GUQWZX
 Nv2jZAAPOZdSnjSGXXt7bCtbP3waQXpMCWgUrRok85UytPr64727+DJdwP+59B4AJdu1ImBQs6B
 NuMOsVBHuZfulDMBAJf9UTaeq2J9JmMzU5Qw/uv5ZxFQ/34cLwVFN6X+r83YXmdfMlClvaPCOJN
 w2sIthg3jZ7evI6j1BbKKj9T+MSXMyHQWTHTmAlawfyQzI48v/XHrXZb+RKdjbXNQe/ZlqgoStP
 o2dj47G3CPZ+ZvQQlX4evOPu4BXRldSkO1aYl2ofAq983estjoJr7FPU4AOaiXnwIlMRyGKQO7y
 oAtsZHG1rK/r9MBltVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100111

On Mon, Aug 10, 2026 at 6:51=E2=80=AFAM Xie Bo via B4 Relay
<devnull+xb.ultrarisc.com@kernel.org> wrote:
>
> From: Xie Bo <xb@ultrarisc.com>
>
> KVM device ioctls are not serialized against KVM_RUN. As a result,
> kvm_riscv_aia_imsic_rw_attr() can snapshot the physical CPU and HGEI of
> an IMSIC VS-file before a concurrent vCPU migration releases it.
>
> The HGEI can then be allocated to another vCPU before imsic_vsfile_rw()
> uses the stale tuple. A GET or SET attribute may consequently access the
> new owner's interrupt file.
>
> Serialize the entire IMSIC attribute operation with the target vCPU
> mutex. This prevents the VS-file from being migrated and recycled until
> the attribute access completes. Acquire the mutex killably so that the
> device ioctl remains interruptible while waiting for KVM_RUN to finish.
>
> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IM=
SIC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3-rcX

Thanks,
Anup

> ---
> Changes in v2:
> - Use mutex_lock_killable() and return -EINTR when interrupted.
>
> Link: https://lore.kernel.org/r/20260721073612.137259-1-xb@ultrarisc.com
> ---
>  arch/riscv/kvm/aia_imsic.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index d38f5de08..74f520e57 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -969,9 +969,14 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>         if (!vcpu)
>                 return -ENODEV;
>
> +       if (mutex_lock_killable(&vcpu->mutex))
> +               return -EINTR;
> +
>         imsic =3D vcpu->arch.aia_context.imsic_state;
> -       if (!imsic)
> -               return -ENODEV;
> +       if (!imsic) {
> +               rc =3D -ENODEV;
> +               goto out_unlock;
> +       }
>         isel =3D KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
>
>         read_lock_irqsave(&imsic->vsfile_lock, flags);
> @@ -995,6 +1000,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>                 rc =3D imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr=
_eix,
>                                      isel, write, val);
>
> +out_unlock:
> +       mutex_unlock(&vcpu->mutex);
>         return rc;
>  }
>
>
> ---
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> change-id: 20260810-imsic-attr-race-06772a04450e
>
> Best regards,
> --
> Xie Bo <xb@ultrarisc.com>
>
>
>
