Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041740682F
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196959; cv=none; b=O8EPDmwauoct3rGBA48TV9FDR6oWaQVisvinOtUUW8IVwzMtgeK/voKve4CtsrpGPipJtrRqd8gg9C77j2EmQ/DdBWqltZb02dVA7Qsxz3Kiyhs+MP9vWBC5pkni7mH/WFMa06frrnDXeYu8wQq80nofrtG/KtPfDciwNtZdfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196959; c=relaxed/simple;
	bh=T6g7rg3VitWcivV7EeuR9/yu2am9emv7c3wvIiILvEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ldxkp51vr0Y5V4HEPMYHR4eKaz8LJDEXRS2lw3XTp40ttYWfX9nQf0DeGWC3o2xqDbntrF9dOghmfVrqTjpvail4MDg0ysCVAV9SLx3jVA1/4cn6K1Zzt/MVdef168YFdBNa2ufdSLbxgTLzTMUxoyJbrkJV5EK+L+Ny4YQ4AHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrUnnujf; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrUnnujf"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6b5737bb2so77540a34.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781196957; x=1781801757; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh9XW+WhkgIww8VbLUN7r2hGLoFdTbeh596jB8sD3f8=;
        b=RrUnnujfxy00+c8g0X3L+FmekhiBn1M/EKVeBtewSm6yEa7uQvLWyRmLZuD0xfqbYn
         0cDT7LicQCJJa/Zi6im+5xgF8fTQL3qVHl0mHYTmsM772KfVUSkcQi3DAqx4F391xC0Q
         vBX/LhpnlttN8XBXYIsT0OTHg0HWKZLqDz1nzjTOiV9m446+viAhbJx/HOP+DH+lkRy4
         jV1Yx7HOxTvnQMXFMdWIZ4Jn/XjZN7QQm0331U23FqGvTixU7HyaHmMGoHstkSddo6kM
         MfmwEpfL+6ODeWEvBpbjYyBcDFYu0iyTocjeY26znnSj69ZSDEXw3b0T7k1ARVJ4/L9L
         AP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781196957; x=1781801757;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh9XW+WhkgIww8VbLUN7r2hGLoFdTbeh596jB8sD3f8=;
        b=Up20wnwIpPpblaS5pCXBLBMEP1JnA6NpIyOorNJFeuTl70Hz0QdAf9VvH4OOCSFPOk
         7o5P8TK4b+byUV6FkGAuZaVhz9iwmimVUTHH00/QDwwWJpls4P6ab0/MdKIZhL8N6o30
         ZYZLFj94Zh/laGZFC8oShCixAarFRbHMd7mRF4NcFvV17hMrpcTh3swuVql5neDQq7+R
         bAtxlz3m/2Mhcmippa9J/dWxhP8Dmq6KnAMbntrAe/FXx4K5m/NQx61C8ZNqSpX2b2aZ
         3wbSUIxf2gs68HeDYYaguxt/dCD0pRoVhpMV3FLC9glyacM60aFK7QJEAcu98z8Yf5UN
         mebQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4WE4vfgrq/fHkFgU4Sh5G5QgqxK+sJBEImTU48HF9d6ksUH85EnQ39c3PJRqxeLGDUnt/eyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNExg6WeypiMacvK94mYQoO7G2Uo+kmH/9QG2ysZOqX85Tfqn0
	wV/2et5Ai8wBpMoVhCaSmpZbAtCFrI3k961qWgIcOgqU2T3NA8Sr5rWo
X-Gm-Gg: Acq92OFv6AYcNr9wlGdHn9p07U1uWy9KF3fgG/VcQ4FYxDZgc3xXfdGWsXOpu8mO0pT
	TthOYTibOlA8CswQW3I2ZKbWeAF71ALrdyStMMZzpm3One6q7sE6UI/zExbvf7qWPvd4AajA1eA
	grP49jCUvtbcKSHbO3y/xc8w2pl8H9Ml7IcD7uQQUP9QWsUIR7iOpLbO0sofNzzL7KfkKSg1z6O
	9Iw3aW+EdOhqBFeD6iCW8yCgIQtzMbDpd79dHMRxai8+dWT7fpvId2nVDBX/fJtxTaMDZugGkT4
	d3vgKg8WmcZEdnogZLAarlDzl4ZnBGG0Q7OGcPMyMgXMOOLlb0YfjUitwmi4pzNy2PTT10F6TXy
	QTlgOzFT0pnM/NXrO8/mFj5WfU2EU7LxoFMp+MB2/+kfLErnouqV6aTVz56efBlbQLTwcc8CUvz
	d3twlkdVU7EXZjtBmZpYT6HCAaTxGG/GA12Syafzv4zB1ZrifejAriry9CCm7gh7zk1NuJf/hpq
	XfTgijWPMsDzfdBuQ==
X-Received: by 2002:a05:6830:6885:b0:7d7:d524:bc88 with SMTP id 46e09a7af769-7e7735278camr2782858a34.10.1781196956889;
        Thu, 11 Jun 2026 09:55:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e774cee36fsm1748641a34.22.2026.06.11.09.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 09:55:55 -0700
Message-Id: <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <kpsingh@kernel.org>, <haoluo@google.com>,
 <jolsa@kernel.org>, <menglong8.dong@gmail.com>, <eddyz87@gmail.com>,
 <shung-hsi.yu@suse.com>, <stable@vger.kernel.org>, <mykolal@fb.com>,
 <tamird@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhenzhong Wu" <jt26wzz@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260611160749.391279-1-jt26wzz@gmail.com>
In-Reply-To: <20260611160749.391279-1-jt26wzz@gmail.com>

On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
> Add a verifier runtime test for a branch pattern where a helper return
> value and a related scalar stay live across the same control-flow
> sequence. Rust/Aya-generated eBPF can naturally produce this shape when
> a match on a helper status keeps data derived before the helper call
> live across the same branches. Such code commonly uses the helper return
> value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=3D 0
> branch shape.
>
> The test preserves that branch shape but shifts the success value to 1
> before branching. Using r0 =3D=3D 1 / r0 !=3D 1 avoids depending on the
> verifier's not-equal-zero refinement, so the test exercises linked
> scalar precision and pruning behavior directly instead of being masked
> by zero-specific range refinement.
>
> On affected kernels the verifier can explore an impossible path where
> r0 and r7 are linked by scalar ID, keep the wrong branch, and make the
> test return 1. With linked scalar precision tracked per instruction,
> state pruning keeps the real success path, and the test returns 0.
>
> Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_scalar_ids.c | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/to=
ols/testing/selftests/bpf/progs/verifier_scalar_ids.c
> index 70ae14d60..de71d547f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
> @@ -448,6 +448,41 @@ __naked void linked_regs_broken_link_2(void)
>  	: __clobber_all);
>  }
> =20
> +SEC("tc")
> +__description("helper retval linked scalar pruning")
> +__success __retval(0)
> +__naked void helper_retval_linked_scalar_pruning(void)
> +{
> +	asm volatile (
> +	"r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
> +	"r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
> +	"r7 -=3D r5;"
> +	"r2 =3D 0;"
> +	"r3 =3D r10;"
> +	"r3 +=3D -8;"
> +	"r4 =3D 1;"
> +	"call %[bpf_skb_load_bytes];"
> +	"r0 +=3D 1;"
> +	"r6 =3D 1;"
> +	/* success path keeps r7 independent; failure path links r7 to r0. */
> +	"if r0 =3D=3D 1 goto l0_%=3D;"

this exercises linked registers with BPF_ADD_CONST logic.
We already have such tests. Why do we need this one?
How is it different?

pw-bot: cr
