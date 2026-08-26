Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24B19AD90
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707221; cv=none; b=jrdqkY8Ay90uVTcP5Qx2xC1k0BEJEeP6taJ4Gd+2tDGd2mgwf4UXuo0R/aiau9rkDOydVMl7fko2N3M2x+oPp+hL2kR/ie2ySEFRcA828vW53pyVnz6R6mOFntoxKWsxVSBOkY8wEzva2eIjWUb8IYo4nb0jvuvMmtTG7y+7m2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707221; c=relaxed/simple;
	bh=XnC0OAV8aac6dSnM/x5f16DLZfKmuzQPmXK1c/DyNuQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=cEKV/nrS+ktvttwcpZEV4+H6Q2NtyV1kVT+Mgi23yJjj9SBnx+5g4W3uR9TNoSOc7yjBamZCYJ1IZ8Dwz860wCAeBfoKhCtRpataAgW7eAyRfoRYwljboyIU8zzBx/4mp5c20aQdLQO5f+7LfU4MWZZS5TmyMs7WtZYyKCZFWh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvXDqPCw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvXDqPCw"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44cb057311bso133990fac.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787707218; x=1788312018; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fUDFu0Aj3iEpRXjvLMN725jqc9wt6Juyi3TstW1quH4=;
        b=HvXDqPCwS3WmApsIZxRk/LmujckKD/zFiNYJLt9nYFf/jckjdQ5su2iEzw8Qiz3NRb
         BtNpHC+MlUY5Us+RkWmFUwkCwcZnI8iys1HHMHjXcF3P5sz3Np/IUHAZZJXEyo8+wxAW
         06rW67lAJF6VaN9kKj/+Q8D4VZsdbDYOjjZyUwRwOZBfBi8phQ1+u5FDvbvHJmG4h7JL
         RZRp5jvtEhKTOb1OlNkZrVMSb0jN0q+/8C3cm2AION+ldD45LGW/CgZjPs8AAQBaTx7E
         TnCr64jx2OlamCUnqDwTYvzl582HJpjLxfUpE5AZV58WPybVO+3fIB9YLWeBO/KL/wQ3
         NZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787707218; x=1788312018;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUDFu0Aj3iEpRXjvLMN725jqc9wt6Juyi3TstW1quH4=;
        b=tO5oZzZ8rSzp1xTcb8YF2GiW2ti6722YG+3BZliu0Rp6WHOf89XSUD1+ZNdi+kNzkJ
         OOY1EsMLYbvwMGYwxg87yz7JCj70JqTrFDtZStWYgGm34jFsjzDYaLM1q/cpVHEBgkSp
         b4XMahWYSw3h4c0dmG1IYq2xJuSM8MKRsQgbdumDqO3td+tlCHpgH+9BOc7tFtuYTouh
         4gwaQuFUF8S/no/m/jenaWkBUSevxFfIEkBJu7U8mHl2Bvms5++FJGUCuQqO2F/SQ9Js
         divh8X4LVXxvURbTPGB/N11HxYCV6yz08wxyecOojAGwmiSExlC42I92p7c6WT1Y1/uj
         A+2A==
X-Forwarded-Encrypted: i=1; AHgh+Rrgubrh2hkEXAUl/GKrXhmDqh9J+IzL43rVfC2HT73WMlCV4go1pXHJ3EzthEm20aCu/LAmtAE=@vger.kernel.org
X-Gm-Message-State: AFuF++kPqew2ROMPUYbQppkf0kiWPgEbAfCn8c3C419axKRdSnuAeFOo
	c9n0MP1+/qBrlVDfEsWKzOPGI8dTxG2hrxjyQn3pfDm7IiXPUXlzH318KAOX2A==
X-Gm-Gg: AR+sD12EOCIji/GjXDAXO3T6q1ONdTTL0sJLL8zfhIgHAVkjQ+i+wa2TCboPdlD8z3v
	kCsrN+wZRMrSKqCdljIfjYy+QqLI/b5BSmvIvrXaMKRyzBMimjxaS+ettL2TDSvgMDevzGPHV1g
	46XbL/B0IZE65hxXuu/bQIyBoBfEXvqBky5Ua7/zWiREHva09kJuodyIs7TJiZaREg+T6Z3E3sz
	mcke6coRIRFUodSmnFaawTPklsxF8sMyVJ20qQobmMfTCu3ECnaXBG8AlpUpGt5XmHqSOXgB8mL
	fupmnVQTDe5K2NMsMVo+vt76lv3Y3Dw++tbq464hO6/oeu/Rffi2fK2RPjyfI69eJRIL+SsCY5c
	YV5TwIO81B+QTbLRJS7XFtYGzgaEbxk0SkGhSSbOcTg9wZnkz5rziDJsW8HQSUegM/soIl5BPqB
	xT51ApInwWYggtJC8sq7qfQ87ax+96BVIbqXN8QWM/ogdL6puPqRUNcOCD90h6aLd65s8jZRpKa
	jHTRcQzGb1PJlR6Nr2kumZpjJKIAdKLff+7LkxwvlHZCcVN/jC02Q==
X-Received: by 2002:a05:6870:7d1a:b0:463:18a0:959b with SMTP id 586e51a60fabf-4659ab270acmr4525251fac.21.1787707218263;
        Tue, 25 Aug 2026 18:20:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465b014ca15sm841315fac.14.2026.08.25.18.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 18:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:20:16 -0700
Message-Id: <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Christian Simon" <simon@swine.de>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <tj@kernel.org>, <yonghong.song@linux.dev>,
 <stable@vger.kernel.org>, <andrii.nakryiko@gmail.com>, <olsajiri@gmail.com>
X-Mailer: aerc
References: <20260822225444.2774461-1-simon@swine.de>
 <20260822225444.2774461-2-simon@swine.de>
In-Reply-To: <20260822225444.2774461-2-simon@swine.de>

On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> A JITed BPF program can use one private stack per program and CPU.
> Sleepable programs can be preempted, allowing another task to run the
> same program on the same CPU. The second invocation then reuses and can
> overwrite the first invocation's private stack.

I'm confused by this. sleepable progs go through __bpf_prog_enter_sleepable=
_recur()
which has per-prog recurison counter. So preemption of the prog
doesn't break private stack.
If the same prog attemps to execute on the same cpu it will be skipped.

syscall prog types go via bpf_prog_run_array_sleepable()
that have per prog recursions counter.

Looks like we're not doing it for bpf_prog_run_array_uprobe().
I'm not sure what the right trade off here.
I feel universally checking for recursion is better
then selectively disabling private stack for uprobe.

> Disable private stack for sleepable programs so they use the regular kern=
el
> stack, which handles preemption correctly. This change is intentionally
> limited to programs marked sleepable; preemptible non-sleepable dispatch
> paths require separate protection.
>
> Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private st=
ack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Simon <simon@swine.de>
> ---
>  kernel/bpf/verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e37ca75e5c4..038753ef07a9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(=
struct bpf_prog *prog)
>  	if (!bpf_jit_supports_private_stack())
>  		return NO_PRIV_STACK;
> =20
> +	/*
> +	 * Sleepable programs can be preempted, allowing another task to run
> +	 * the same program on the same CPU. Since private stack is per-CPU
> +	 * and per-program, the second invocation would corrupt the first's
> +	 * stack. Disable private stack for sleepable programs.
> +	 */
> +	if (prog->sleepable)
> +		return NO_PRIV_STACK;

This is not true in genreal. sleepable progs can use priv stack.

pw-bot: cr
