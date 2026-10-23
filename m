Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769497;
	b=NUW5+dVBm0OQKKe6lBeEXHMkicgOS2046QwwHEOUFIzmpuOmmn3NIgTYl/xigxMZV3ey
	 7hHZfDsxZKSZHRQCTM/L8WtdMccVD+y/I0NVC6Cf6fCpCE0xp794nrBHXruFZCX5ceZFo
	 81J1Kcl644Axz4LnMotC2Wcb2F3PIuBu8m6Ky1jjTCwvZhucKdVHW/xB/SwfoJh3+xqCS
	 lHIbxg0lGB4cF3GyV2pClDDLgs4e5AKoyZjyecEvLSgP/r27UFKWB4p6LvUVX+OumgjSP
	 pH56vXEhWJBUXsc7iod9+IDgzVRWNCXOoxKqu7nRsBcHJRgtJAYsV1p+CfbWMNBjKVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769497;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=;
	b=EKQa4BO2RuPcgG3jaOYQLN8FKAA/YTKsv/ipvseRYGrAc+K23fkO6OsMZZxkXRvJ8m4f
	 JwMBzCbVoKtMPiBAAf4cdbe9jR0R0cQyXcpMil+Ofl942ZPSGiOwjT3wUo1wU/H1NN+5h
	 ISkt39vjlHIVcpoM0X1X9hrTLLH+S1GrkXNtIT6V4spc9pXyVK1/vuM7Ssrl8vB3NxQaM
	 IIviYXDxPhEnRxNtSh+RpFcVAWxgQZvbaluAEpMhKaDmhVatrMo48Hlv1Ceem+nuOoBcE
	 zsmhXMoZNZANRNwy3H++CWhqRmijKWpMi+O1w7uajwbruRh4WRBgYZrJHAmDXy0ZtHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsRLMs5e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="MA/L8Upr";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD07606A331
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAD07606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsRLMs5e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MA/L8Upr
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE718m3481158
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=; b=BsRLMs5ejriH/lIL
	YB0wgFGzAoAsuPOErC2LXvwXzaNy2zgUGBCqEztreE1rQoR8uG2Vda4z6BphVbJP
	s9A8tMgbYc4ssyexAEE80YfipkYOrkmXHRl+zWq95Z2Uy6tgyMvJkeRt0Mr8IZUC
	uDLfTYwXmqKb5dcStOt3upPfcEoBrdWhhxCBNBCdoVOMLhRX4pA0OvNUBCkTDvTl
	TsN3Aj/0yrdsuLtisWNATXENvMRPVp3T382aezpYGYTX+5oHEl9I+C2zU3tE3KvG
	TY/M5ZGaNcYoRfDSDpEdvBl3PyId13ra4ZXhZNDWurndI0Kvp3kJk9b0izTG1OPW
	FBzUFw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0mu6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 15:31:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ea381ce04fso10349575ad.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792769494; x=1793374294; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=;
        b=MA/L8UprF2wuU4gh4D0ySRU1xQJU9C+HjGOCrlzC11OW34e80uiVEm6lRxjcTkR/fL
         bAyDIc5Y5q2KmMj4Gz8U/jdzXocoJEV/hAJAfVhUJZujqHA4Up7jl5hnBafhUPAYtJeR
         f4l/fXqNMInAbvgahYGbZAkblS/Q9uHiNJY4E0t7SS863McltXs/67Rp2WPmgCxQ7SVp
         gG8UmXuk0DQvJn07CVWvcuwpY2g4MuGDkfC7rPRzBi5/EHCAxeoR3VX6v1kB31NQk0LY
         HkR3TOSJKssG3rg5bv24v4eyb/L7ifqPUWXkIX34lDaI4SN8ElMT36EYdkR+CJU/dIkF
         Aafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769494; x=1793374294;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=;
        b=zH+iZj4+Xxqrkfufb9uzML4f8F/CYkzqy7N4yNXccg+cS2vxHY1Fodtn+wtn/9+JcE
         1lY+mgsj53hOd42MiB0lzCfxuJISW5l5e9ef7/MM3A+lvLROU3vj1azur+xDzPw188Np
         ovXyxFGXRSsHCHZ8Pl0RdIPf9k4qQHdiybsOMouLI6Q7gUrDyHAstZB0q8OwhC6q9MkM
         XGjFyBUtvh3WSt6rznAWf+xlCs5s55HeONNOBGVRu3LKf1PaAaGA5LCMyuCXz5+/ccGi
         IJmpXDyfW8bXzjdJ1BpMyCvlpt1mK85eO5TfI4gQpJftHu0a3dEHAr5nunrEhXrlKkw8
         xYVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvIGlKPlZmWXNZJ+XnMQKkDEGoacakLTUCPJ+/gDClvDnMKutJq3NXfGZTSs/gYoXzVUh/2gI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJvroTy3J3Xxmw9Yy+6YIe9kdi4jf94uwT8gt8d4F9Eqcm64ge
	fM6IZyER7VvyQO/aeCLfas3SyZKFamS8gllTlWPuKUi2qp7hmek4OljcuuCx0DhEUml6QIhF00P
	9aEXvKajq225G1zvF6bDLH8WuFaIKyLVMvTncSL+qs9+HtAD95AmeDrNfmYY=
X-Gm-Gg: AYBFou1Lyx8nLpma0ZLhlIqhHbykKYFP0nHRslZ/Ee97kiPYQr/IhCpCtUuXt0FEIK8
	oa0soxvURjxpjzENvkBC0L2mYxnjfUdeQpKis1P1W/6n/DpwFEh+LLmSMnKPa76tFa3jvETtSnJ
	UbNls/EV8aW2cDcKSdxM9dJp+Piym4Qz3M/XTKu52JfyvN/HxBBxz8il5csbFataDfyfCs5OaHK
	wnD2pXEh/NI62xDy4ikpffmOm/FchlS67/vtlegu8p7nhIaJCuA9Ax54ykYl6UuW3N2Rc+OUylX
	O0RmATPctA/VZx8IWSj3I1ms0zWSKea+hPo9NlBiemjroG+XNi5R/ho7G9Aje2f7UEEmQHbnr5u
	litQWmP4NLtNcnKienVHj744VF/l1UdaM
X-Received: by 2002:a17:902:e848:b0:2e9:743a:7a9d with SMTP id d9443c01a7336-2ea7c28b349mr20823025ad.13.1792769493490;
        Fri, 23 Oct 2026 08:31:33 -0700 (PDT)
X-Received: by 2002:a17:902:e848:b0:2e9:743a:7a9d with SMTP id d9443c01a7336-2ea7c28b349mr20822755ad.13.1792769492870;
        Fri, 23 Oct 2026 08:31:32 -0700 (PDT)
Received: from localhost ([155.117.96.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea947ac357sm1667205ad.76.2026.10.23.08.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:31:32 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 23:31:26 +0800
Message-Id: <DMCBQSJ0B22A.2TDXAXPJNPZL2@oss.qualcomm.com>
To: "slack up" <yxcnew@outlook.com>, "Anup Patel" <anup@brainfault.org>,
        "Atish Patra" <atish.patra@linux.dev>,
        "Paul Walmsley" <pjw@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
        "Andy Chiu" <tchiu@tenstorrent.com>,
        "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] RISC-V: KVM: Fix builds without CONFIG_RISCV_ISA_V
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.22.0.r35.g0a434803
References: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
In-Reply-To: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
X-Proofpoint-ORIG-GUID: zX2N_xmS_xuAC7IEO5xTj-WOumQ6MAMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX/s55WCVXzMZ6
 CmaEh5qwnAjQtHWX9qX6+XCH+Sp3XYOLmLGzr5yT0ZV1tf/vHLETuoS1Xgfd9/5VRzfH6gWk/KT
 Q1E9rvwClzkB+2BJydUNRfIsGmbbADGdfnQsjN8wjwCIlZVspm0mJVkFDylNsvZiMOZ/Zo8Mnpc
 37rGdi7fMmKBrjwNb3jEjgfNZppbnWLu8PbXnccbRZHmlZbXhf/vPhz4MIRQyqKkWRqLvyj0upO
 KV9P/fUyjai0d2BgR1HDSDTKHcqtL7mp40kNiQTYYbPUSmaD6G5MOwJMrpsJhDXQ/PCVWmGbZA8
 +VD2fhtbFnJQAU4Sjd8eFdbla5+b6R20ZtkurSDWmCOVtUg7YvxAi+zJR7Ifw2xm/+CuR3ooANy
 O00vzWe/5kCDsmFrODDvSlyvbYOZAvz7EfBZowtrmoK20S1zsxaH6sqZDQPFAIOxKt85kL0Fr39
 MjPVOFFsveFnTYMWFNA==
X-Proofpoint-GUID: zX2N_xmS_xuAC7IEO5xTj-WOumQ6MAMi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXwUdcg6xahA7y
 jc2r2o7yh6QwuJ4E4C7UlG6jv0NMWdelS6Or9SgjLBplsUnqzEBsk2ftFmQh4RtdxAuhhyuJD8C
 strcPrk668iVMe8EpcpWYqrpdzRALYI=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6adb7dd6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ilsi1XWDFcrB9FjxRIUvHg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B-Qh9SJ9cMKcPyFv0BMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060

On Thu Oct 22, 2026 at 1:31 AM CST, slack up wrote:
> From: Xiaochun Yu <yxcnew@outlook.com>
>
> Commit b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context
> handling for kernel-mode vector") made the KVM vCPU load and put paths
> call get_cpu_vector_context() and put_cpu_vector_context()
> unconditionally.  It also added an unconditional call to
> __kvm_riscv_vector_restore() on the guest entry path.
>
> The no-op definitions of the first two helpers live in <asm/vector.h>,
> but <asm/kvm_vcpu_vector.h> includes that header only when
> CONFIG_RISCV_ISA_V is enabled.  The KVM header also does not provide a
> no-op __kvm_riscv_vector_restore() in its disabled branch.  As a result,
> a KVM build without CONFIG_RISCV_ISA_V fails with missing helper
> declarations.
>
> Include <asm/vector.h> unconditionally to reuse its existing no-op
> helpers, and provide the missing KVM restore stub when Vector support is
> disabled.  This does not change the Vector-enabled path.
>
> Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for k=
ernel-mode vector")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaochun Yu <yxcnew@outlook.com>
> ---
> This single patch fixes a build regression when KVM is enabled without th=
e
> RISC-V Vector extension.
>
> Tested on base a804c5742bff (Torvalds master):
>
> - CONFIG_RISCV_ISA_V=3Dn, CONFIG_KVM=3Dm: full Image modules build passed=
.
> - CONFIG_RISCV_ISA_V=3Dy, CONFIG_KVM=3Dm: vcpu.o and vcpu_vector.o rebuil=
t.

Tested-by: Ze Huang <ze.huang@oss.qualcomm.com>

Tested on commit a804c5742bff with gcc 16.2.1 and clang 23.1.3:

CONFIG_RISCV_ISA_V=3Dn, CONFIG_KVM=3Dm: full Image + modules build passes
(before the patch: 3 implicit-declaration errors with gcc, 5 with clang)

> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 6371d5ea5392..ebc619ed67dd 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -11,9 +11,9 @@
>  #define __KVM_VCPU_RISCV_VECTOR_H
> =20
>  #include <linux/types.h>
> +#include <asm/vector.h>
> =20
>  #ifdef CONFIG_RISCV_ISA_V
> -#include <asm/vector.h>
>  #include <asm/kvm_host.h>
> =20
>  static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_conte=
xt *context)
> @@ -55,6 +55,10 @@ static inline void kvm_riscv_v_exit(void)
> =20
>  struct kvm_cpu_context;
> =20
> +static inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *co=
ntext)
> +{
> +}
> +
>  static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>  {
>  }
>
> ---
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
> change-id: 20261021-ospp-c1-b4-submit-e22dc09faf5a
>
> Best regards,


