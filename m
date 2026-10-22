Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792709899;
	b=t+ckVcX+DMOBn0NhKQfGWrY0DdHPwdDFj/aOzrMqp+xPZoilofPNmSlm6SQJBHLTy4eW
	 e3dZZkYlBXGvJ+8QwR38baYxM4FgZo6cBFTpdVuMXTtBOUdG4jnM4hrZHMuvJnxCAxiyl
	 Vo0EOQprBa2MCVEJDxaWhfpKB8M73u+gAXn8Ov71j10DDMuYT2mUfyohL7jOmzCRiqYTi
	 eKxmB7MEQxzKMBAjSbakzxTrjEjXhvzxX3P5efSJ91CCb1NgMbZ0FQPBrCZ/O4Q2eNysr
	 zcP9MZwWF9j83FIJvMc1vIXSupx/xeZhbg0zb+/uLmFwyvama6wcLRPNyuhGGVRlj8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4h8EJtUuQDNTtWsFUTYQGXARXr8rvvu+aTdvO93crQM=;
	b=cpuKI5KyEtdOslGILmu1B2I6SrKNcmN+EWM5socTruM0RUtcUS5f4cebngl04mLPCgS9
	 OhbbEaXiW2XKcnN3vR4sIkenYcasPtPydu5xFpv1XTLXQ9w5MmCq760YABoxMsTvf5IiS
	 Yfq3HludtX1hcJDBwMyu9pNvsB8JD8d3B+moeCb93fgkbuT3I0/3gtnIAyaUUYSg1ZNSV
	 xugnBDLeKEJWoxe1npeLrp2HFy4SFPqjBm8zTYh6vVn/Pz5ZV9GB/cf5+aZ/VKA261l+6
	 c2A+Hjq+tBqT7oowg5r3fB5X/bhP+htaKL6G4VQFLPX56bqKr7NaFzqtIbficboXP3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kAWpkhn1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DC606A31E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 22:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=kAWpkhn1
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1949a12.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792709896; cv=none;
        d=google.com; s=arc-20260327;
        b=dCm8wo6qS23GE0e/VfZeGNE7PUtK0mjjVRyEAKv6w+H20AOCfHE/rypIXVhXsQ9VI/
         U/2L2603IbRcCrh9qN6EQEiJ9icqVNu/NOGmktve8Hb0CU3TDs/f8XyPCa0l3FszxowA
         d1uQ0sJJeWJFtAm8a+bdn4hkKVg0NbI4nkLaq4fisFTuYgK/W/DEvfPGI6OnIUuhh5xl
         j74lSxa2XJ3ND+FBn6mKbsGty5GrsbG4Xw0X8Ku0tuDzAiw/gMRBG30J/5mfWEr9+n/E
         3bG3fnB3J/1+RdOqwojmHZB9aTsUnp7vTLdBVQSFkvLDB7XkesMeiz9H1bSq4jwPDSmW
         EeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4h8EJtUuQDNTtWsFUTYQGXARXr8rvvu+aTdvO93crQM=;
        fh=7MRUxY8+/ik6artXQtOfTnf9p8d8G9MaRdNUTHkPxQw=;
        b=de/7k7ys/Tw6qBRAxB0quLTCphyjxnti1nsVWicPkXBUzi8uNdRymnwrYiJyxyiAci
         0TVqTSS74B+g9VjVen5Ib4pzrUswzaJCGoNac2131++YPQPD+ND9hVOgRHuZ7usVz0Mz
         X51YUdQMEmllIS0zavhL8HmO730iQeZSrjH3mCJ7FcIE8Z+IN+fXS2p+LoJK6LTBnpqL
         ZeB0ef1bzpDlp7ep+n0UP6pbLkJ7nxzC67li2KjSRkXB6seWITmfJK7Cxfxqk1rL//mZ
         fAYQ6AJg5ffKRl7l0a6Ljo72zAWxLXg73VhQcG69R87tZtUxIyFUx+t5rsV4BQyvQsPg
         340g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792709896; x=1793314696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4h8EJtUuQDNTtWsFUTYQGXARXr8rvvu+aTdvO93crQM=;
        b=kAWpkhn1xJIsRNb3kWf753Jo/W1Z9mqUGTtDto8RAWIddAkJgZn+T1ZScI238Xw36Q
         qWKFhPYd264ScQPYkDRL13eNkyduAvBpqsczVv+z8utITIo9zymG135SeAU5POJKGS8M
         MWSba+2TyycipFlrHFl1R0vsellMcEGh+TldPzF3vnmlAFVZJ2N/YpqjKn8WhPDv96F7
         l3w6V7quxAIbR+/O3fb4BSTp69DGSEnKM8xhqiEko9P+wxOFHIeh5XOSxUob0m95Pk9F
         NWbF9E1eyxYhOl6MSHmpr/655ZHRbGYikxJsxmxfnGr8SLx7G2GKAcaZY/9jOOVVgdpV
         53jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709896; x=1793314696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4h8EJtUuQDNTtWsFUTYQGXARXr8rvvu+aTdvO93crQM=;
        b=bqZZ/MEfWh6tQdoLfuE3kPuScDiaq/tqsJGGvQys4y8crJbe2NRpj1aaCJVAenF9qA
         JOQW0c7txl5yW6L30+e100I/FNA0mmGs/q23Pp08PfQzFwZM4Q5IXRnZDz+yT+y4VSgL
         5iCBVXoZ3ESVtuwBkoB14qauj6MtHPFt/2rV+xS0j3OYEEvyFocRjENVqf8EccPrxrpV
         yD1d/DO1+VmRx/8TthkCijiiiMjioch053GBto3Q26yY6FDGjKSU6L9t/fORmNR9e3Wf
         ntYzSNVuKobeT/8eiaEICGAy1OfxsZDcm4bxoAwIZ2EukrIp7Ql1feR31aeoEAUpks0U
         ZFRg==
X-Forwarded-Encrypted: i=1; AKwUvBy9k6id+VMev6/HQ28C4fJkr+RSfGJCYm1BzAcWHyZkYcJ+6RGGTkg5cujsY6DMq1Tte6vcMRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0HKxxxR+Y8L6CMcI0VOWzszn9hJh0qLXwXzehouZ+06/5FZYv
	qH3QjjP12YgVACsdXxXm+GyUFBZfbVE+KtmK5xX6LnzLg32Dsm+0POLITsmQGyHLRqjbufJsATl
	PPpn3r2N2Ayvyh2l24NhyHzrLoMUd+TfUa+nIoPGu
X-Gm-Gg: AYBFou3TsBygtpYSwUatIngV+Kz/YijnxOoCVBR7oPIqO35xQ00as/Nffj1M2RAT9Ng
	OQlbLLEYU8PaeaC7MMVJYZIGjAaAxsrC7xFB8+IjlvYvx55FLGcju9abBWIHV8JqbK/ug2vghNn
	fC/AkoA9uUwDCTPOEg5D+QXr4Fe4r0cFfB+439/pLTxdo8m6rz+6VMDPKgqUOXwT+Su9uGWhInW
	O17mZWBLC4tOH+U1e3b0yWviTtaBPoTJKboKfsWABOV6nkTn3KbplLmRMV8IS21P8RhxKBfx1N2
	ROY9Onh3S+gVwQuTZK3ClNbgg+sYqnfp+WYuIRvWi59QYaOVjznSL5f7kUFYheeChwNqUsG6cry
	xnxhZIYRLQn4KAX8N7COtlFY1458fp4fxro+apKc9DeNmYqU8/j0OWXulMPDDQBHi
X-Received: by 2002:a05:6402:20cc:20b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b43505cab5mr9309a12.16.1792709896086; Thu, 22 Oct 2026
 15:58:16 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-update-autofdo-split-machine-function-option-v1-1-5c71b3005e89@kernel.org>
In-Reply-To: <20261014-update-autofdo-split-machine-function-option-v1-1-5c71b3005e89@kernel.org>
From: Rong Xu <xur@google.com>
Date: Thu, 22 Oct 2026 15:58:04 -0700
X-Gm-Features: AclHuK8dO3MsAmO6cAa68r7ozQ6JK-D1flEqoU6M1Xnqf0FQ7RSBHTS-OpOYYkM
Message-ID: <CAF1bQ=SN8wZ1hKDTtGspBiZ8VQBoUtQP6uNioO-ZOOvS2tLZAg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: AutoFDO: Update split machine function argument
 for upstream rename
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Han Shen <shenhan@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks good to me. Thanks for fixing this.

Reviewed-by: Rong Xu <xur@google.com>

-Rong

On Wed, Oct 14, 2026 at 4:40=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> A recent LLVM commit [1] renamed the internal LLVM plugin option
> '-split-machine-functions' to '-function-splitting=3Dall', breaking the
> AutoFDO + ThinLTO build with:
>
>   ld.lld: error: -plugin-opt=3D-: ld.lld: Unknown command line argument '=
-split-machine-functions'.  Try: 'ld.lld --help'
>
> The plugin option is needed for in-process ThinLTO, so handle the rename
> accordingly using ld-option.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2186
> Fixes: 2fd65f7afd5a ("AutoFDO: Enable machine function split optimization=
 for AutoFDO")
> Link: https://github.com/llvm/llvm-project/commit/3e6acc87c58843e551d6e8e=
4bf06c26712b04622 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/Makefile.autofdo | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
> index 1442043da139..57a3aba6ffc2 100644
> --- a/scripts/Makefile.autofdo
> +++ b/scripts/Makefile.autofdo
> @@ -22,7 +22,7 @@ ifdef CONFIG_LTO_CLANG_THIN
>      KBUILD_LDFLAGS +=3D --lto-sample-profile=3D$(CLANG_AUTOFDO_PROFILE)
>    endif
>    KBUILD_LDFLAGS +=3D --mllvm=3D-enable-fs-discriminator=3Dtrue --mllvm=
=3D-improved-fs-discriminator=3Dtrue -plugin-opt=3Dthinlto
> -  KBUILD_LDFLAGS +=3D -plugin-opt=3D-split-machine-functions
> +  KBUILD_LDFLAGS +=3D $(call ld-option,-plugin-opt=3D-function-splitting=
=3Dall,-plugin-opt=3D-split-machine-functions)
>  endif
>
>  export CFLAGS_AUTOFDO_CLANG RUSTFLAGS_AUTOFDO_CLANG
>
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20261014-update-autofdo-split-machine-function-option-d4edb03d=
370c
>
> Best regards,
> --
> Cheers,
> Nathan
>
