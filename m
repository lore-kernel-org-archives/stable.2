Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD303845D0
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941108; cv=pass; b=iZCSMx4MJ0fVFXZV/VWmIq592AYn3ko6occaZxDsVfstXGztrbHMQ+N5FQKg4MuXRfx0vXrIcRQ5QMDnm5zG4RdFhtFgszCFxZ8IZ/CjHPGzraCWYWbYEgP7gAsytCuT32Wb/E8kH83F0Vrob3NgaTD0wV0xGR1CM2EKJiDlN+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941108; c=relaxed/simple;
	bh=reE3ZIiA8bR6q5vWMypk5waJeiVnZpjysUAdSkXjsNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5HRnEpn0TlWDAH9sSzEl05SXtoROahdvqRPGlT5h8bPM4krQSpfub5LBOKt70eeWDdbgPIUp1ZXjJsHRpmPcmnaF3wTR0TEaD3rXU8cDz+3V71deVxuzzYhkqGg9ln/MeRX5A0jPNtAUB7x1SuBSZYk+ht0qrE/BI1rMhQbsLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYZD8Ipk; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYZD8Ipk"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80cebd41372so30670017b3.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783941106; cv=none;
        d=google.com; s=arc-20260327;
        b=FZMD7mM3ERkj1wcCTUSgnn5+1awDgeDk0Q2XgLMqWl9IZ9eISJCbY4qpE7iAMafrHN
         S1zWRLj0989OCnK0acodx6wv5MS0v+ckm2cZTv6TpUCgKfhlKWP6YfwrZB09yfvm2n3F
         Z/jovLPZ41ucnuDwCPRmF1S3N77qIJV8LD0s6i7Lpl1jXZ4L/LMleWEpYblYwRA/rK/Q
         W/9NoHNpjBfLRpfBd9tzFJ24CBMMXuz/F8HYBxYme20aDGoroirEPX5rPpn8JXkYINUs
         ysNC4T7sUPJt5PjIVTCnDr3P8qI37Day0bmEYTVImwGZi8TyiQmCmty+Hv3LGfHO30cv
         Xpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4NrvnEAuHaG+ihZe9SM0nCZuvqTV6eJwGbpjBAxoUPw=;
        fh=n6OrC7SLXE+VUOWxt+nqi4w6nq9oWIHSoRhRzQJ5Pwc=;
        b=YJBW+bazOh2ANPmcB1m+zp5kj63T3P2uj5IfJAvbYGhzmbS8y+5qcIN9gwd23a36Lm
         IsrEWqeNkqLqa0UnOkObKSSomtHeonYXFqVske0IVHwBJzwbcdudxEgIkRZfJ4MGic6t
         Esb8NXbiWwOfyHQrG5MfoVt2Age7OXny7mLunvP3TV8AHRoBaUoa3pXwfzYf5IH2qpLN
         QJmTmkv7e0QMDuj8yrzqnBUpNNIqyADfnLWWZYXqwTaseK8jDSuLsAPoP1rgk+voboId
         e7A8UkaJGs3Yxipy/RnCxJFcF6uHyaXkEopfUSm+0zoXbEFk8+fOg7orZsmVzzn3jIJA
         cuhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783941106; x=1784545906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4NrvnEAuHaG+ihZe9SM0nCZuvqTV6eJwGbpjBAxoUPw=;
        b=pYZD8IpkIku5UfEhVJQng/Q1qEXvvtb2iK8nw37pweh8Ltf+ZZxc68k8hxEYUYF0pi
         RizImnTmB1kQGK9fBAOyttojIzSK/d7qyqFG6GXvoCxTXBpyYWSSsE9B0X7yDqs2VyUP
         dGaJ9lkLm4jMCgH7Kd/qiffWZOkkchzMS9n3z4MFUpFkV/qfqjh6pyBJvOyap6fK2ERF
         fnqmVy9Tej7SftkJYfpqwtkDPD+kSK/gf6LELkEY1tylKpFT5p6kMZboOdwqOmnUkPRQ
         r7OV40yvkusjO4nLOiTHz7vOS9NV5Fu8w458bYOSy3Vl4kTd05FbA34Zq8sLam9flMkz
         JcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941106; x=1784545906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4NrvnEAuHaG+ihZe9SM0nCZuvqTV6eJwGbpjBAxoUPw=;
        b=I0raJauX5ALDzAUdslo/ffZ8khz8IaGq4CRMQr4jcy5ptXejDxRRfizAJqbKgE9lni
         XZH9194MrjsFkFP/lmGcILjYHX6zam/UcBELCy7Hco/nxCYjEQsFlS3Yw0NeNBpUdePZ
         hsRKDFdLyfCAb/NW+F8SJ7ZM9zyjowt+0XN7YA3yXsCS9IWUsDlQAkO4YiFWqxBxt5M6
         uw1QsTvs2DMrcguNya82UvqhdxgV3levka6YbKkGICKSPF85MQzuk6YX+cokkyH6+Ior
         siNjEbdMVn+mYsbhEjv7uoQSoz+A+3zdD74u6XtwrD9YjY6NrWRsaZNSLNg7OLorKpAX
         quSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7FRXfb10g6Sv0+xwi9T1D6zBOfaoGoZW+d07OXN8t/xFuiVISfLCEam8w5zN4Brgx4O65U6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Mu6m+Dbsz/l0umlCB/x7dOg+70Wrp59hIQZ6yOeVTCfRHWVl
	BNmKzv7lncw6l++eyYkD+YUpnBAQxWRIfOLujjSPkhxae3b7flBqL6cUFJSmHmohdJ7tRtlH1dr
	1DH54Ik4IBpcK7ylDuEe1HdSLcMi97cm1ZPpsGzpJaUCo
X-Gm-Gg: AfdE7clSHy5SnxKBcsxZwPNP4Ec02a780P3gkVu6HlIHvJFTPNRW4M4HxT2V46+jNSR
	oe95945uXzMbeAZEL0mFS69eyqpjI/NC+256HSDnV00NYSHHmoxsYL2rR9tf4fUnM2Rf6TiMAil
	Ps/J9hgyDNTBNJ70Kr1ciGkscC1sywOK5pVjF90+XrYwJF1hXG+rcxjdjIjcParMZfWjyThmg73
	o9e2VFNmGtDgFc7xybZuxYdW4i7pKRhbpmBLVMqdbAEC8LZ0QLQ1Bf9+DgDhPcXfuHwKI1aF6+2
	T/t9QUZH2ANf8xuC+lY2Ug/7iNU7AB9nGJr+vcZZ
X-Received: by 2002:a05:690c:620b:b0:80c:85c6:898e with SMTP id
 00721157ae682-81e901ac70amr62178667b3.61.1783941105949; Mon, 13 Jul 2026
 04:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713063513.215781-1-shung-hsi.yu@suse.com>
In-Reply-To: <20260713063513.215781-1-shung-hsi.yu@suse.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 13 Jul 2026 19:11:34 +0800
X-Gm-Features: AUfX_mwt6y9dWHTw1akM5JZlx25bW7epDzcN33A1C37dw0beEB9vA4ospeyhCn8
Message-ID: <CABFUUZG5++CQ+CoVaVgXGEPn0CwAz5JciBwk+xcRQh01frC3GQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/1] selftests/bpf: Enable BLK_DEV_NBD for raw_tp_writable_reject_nbd_invalid
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Mullins <mmullins@mmlx.us>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 2:35=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
>
> The raw_tp_writable_reject_nbd_invalid test relies on availability of the
> nbd_send_request tracepoint, which is only present if the selftest kernel=
 is
> built with CONFIG_BLK_DEV_NBD=3Dy and the kernel built from current BPF s=
elftests
> config lacks.
>
> Without it, the bpf_raw_tracepoint_open() call always returns with -2, le=
aving
> raw_tp_writable_reject_nbd_invalid test always passing without exercising=
 the
> checks bpf_probe_register().
>
> Cc: <stable@vger.kernel.org> # 5.2.0
> Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
> Not sure if fixes tag is the right thing to use here, so use the cc
> stable tag instead to get this config change propogated to other stable
> branches to make stable BPF CI's job easier.
> ---
>  tools/testing/selftests/bpf/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests=
/bpf/config
> index adb25146e88c..e1797bd87904 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -1,4 +1,5 @@
>  CONFIG_BLK_DEV_LOOP=3Dy
> +CONFIG_BLK_DEV_NBD=3Dy
>  CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
>  CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3D1
>  CONFIG_BPF=3Dy
> --
> 2.54.0
>

I tested this on bpf/master at 7cbd0c4cebe4. With the patch
applied, CONFIG_BLK_DEV_NBD=3Dy and the nbd_send_request
tracepoint was present. raw_tp_writable_reject_nbd_invalid
passed, and strace showed BPF_RAW_TRACEPOINT_OPEN failing
with EINVAL rather than ENOENT.

Tested-by: Sun Jian <sun.jian.kdev@gmail.com>
