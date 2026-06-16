Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25172853E9
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781652938; cv=none; b=rfAuqHrQtvxi2evtuy2Cr8S+QE3jJUK6e44kwLLEFbD/XY2DBqWw8m9E5G9VRy4V+HDvo8+i5oG9xKs3oUnv9/+9sF5gN8fn6zuSPPpNIwEWsv8NmpW3RzFfroJr9BG51AtrwvJam9zfEclyvwhEyeOCanKhoKJ+e7X6M8WDAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781652938; c=relaxed/simple;
	bh=KZOvQxZy50gYPFxhnZu9XcEiN2jcIv3rhRYvhuCs4wQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=s7pbhciAfmFG7CZeueV0f9MMIf4psyy7QVTqUoe/PGUy8PRjJhtGJj2LnsfMY0ntJ0qfvbgfzhwagcgkLIp2+XbK09N6Ojg09J6f7mlSvueYGRsbTzIUKiDwj722exuTq6O/O3jVCJikdSvRM8XCXLMF3raaMyBLwnTv47WI8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KDrL1dqB; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KDrL1dqB"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-307631dbfedso10967994eec.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781652935; x=1782257735; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO9GhEB0RqsfMRIU+s/5rIJn5IBIFCGVZh4WwNHq168=;
        b=KDrL1dqBA3cjXyXgKs5S05ggxGGWMFFIzx0UwKX37fAXq28Jo7e9nAR1+lYOu+ghBP
         akTUBT1SeMpD2UhxUUUhU6YgPluJPhYeHmIaxD+ac92OnIisEbTVaC8qpUMCgoOPuoq9
         z70eQg5mcrvB0RoU4fGv4tLsPaNAiNrX23DycUv/mUjWsoYVgPIF9YIm10Ty132rQxSd
         u3vW3xtXzQA6i+khuA3/1CnuTMix+Nx65WmAa3S7FO63LxcM6WgQyRBFXzj14T3y0/Nc
         RZ+5rjKlEDhp3qyxIjC2CvFJ8I2beR3drp/FdtOiBX09ie6j/BlCjlhnCuLAzA/+4sPy
         M6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781652935; x=1782257735;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GO9GhEB0RqsfMRIU+s/5rIJn5IBIFCGVZh4WwNHq168=;
        b=Fo8RV/U7G9CNEq/CmKsiR9E1iQBzzbzgSOhy+y0NfpDhflF8Uhuc/0e2G078b2ezwe
         lNgraoKLKUQ4WLHX8CALmG+ylNbjaJpW7NUFtAikwSBFAcq+EKybo35lOhHG2G3kmILK
         UKqEHK0UcZB0rRUOB5wspweWNJJE2tTnCx9qcWphM9IgDGCfMD1Kbbq0vcDduHdNcK1q
         5D8AqX9mgAnQfU0+cCFL5NKIJA+7/pPAo9iAtAe+3a+Omro7QApr9K8UFnLje9qtlOQh
         TpZtE/6v/4U9SgMqfNTDESSqlO/DCo1BHNRjHfsTcmHrZ3RqTlmhf88KlpxB9c5bLZL2
         RkZA==
X-Gm-Message-State: AOJu0YzLzuXqypclOn+gE8ZyVDWAP41TbxZ5BpNIB+BheXHF4AyPas0j
	fOBd0mGgOADJr88ELJbdeSudCqm1LXUFhtl2xAkHaCeylKUp/71/ZtdxFtEemcl0jLU=
X-Gm-Gg: AfdE7cl+1S2hW9kPq0Qnl5p5OHWvXjm7FrX4iZzd7OCoa/IjNYQ93g4mYEwqYX0KPiy
	t09iyAiswyL8IqpghfO9TROchyLFoRmZFY0VqqyoNoTDtpI+bKwvtu7uO9jbTNsc357b3L+h+Bc
	BzajFtvQQHquELYlI51Xwrq1zgF+1DrmXaSOBDs7xf16vdEQgCsYdM8LVprH1KphFcbJvBfKLft
	a84eHMiYcM6EbwXoat3iyEwvJp0LS0GkDuDl0qll02HCKojKznsQ6N+5dskKAirT74RQYhiePEL
	XymVjDRitBiFaCIDMsKl4NAjmNPijKvWaaFnZjwDkKEYCqqiFZDtRJMS1V+j94CW0zEcrhyFRUn
	+/BqyAmIaCvLmD7uVvuKz7yFUWRT5bA9izzZm6RLax7sl/2DfqUzJ1AxgE3GorJaOGHa1o6oM9L
	vu0uVO
X-Received: by 2002:a05:7300:d516:b0:304:d8cb:841a with SMTP id 5a478bee46e88-30bc9efb228mr917030eec.14.1781652934917;
        Tue, 16 Jun 2026 16:35:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bc1e2bd13sm2341882eec.2.2026.06.16.16.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 16:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 19:35:32 -0400
Message-Id: <DJAV95U1GCBI.1LKNKIW9SW740@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>
Cc: <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>,
 <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <songliubraving@fb.com>,
 "Yonghong Song" <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: Add missing access_ok call to copy_user_syms
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260616083056.405652-1-jolsa@kernel.org>
In-Reply-To: <20260616083056.405652-1-jolsa@kernel.org>

On Tue Jun 16, 2026 at 4:30 AM EDT, Jiri Olsa wrote:
> As reported by sashiko we use __get_user without prior access_ok call on =
the
> user space pointer. Adding the missing call for the whole pointer array.
>
> Plus removing the err check in the error path, because it's not needed an=
d
> also we can return -ENOMEM directly from the first kvmalloc_array fail pa=
th.
>
> Cc: stable@vger.kernel.org
> [1] https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.o=
rg/
> Fixes: 0236fec57a15 ("bpf: Resolve symbols with ftrace_lookup_symbols for=
 kprobe multi link")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kern=
el.org/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/trace/bpf_trace.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 82f8feea6931..75495a5c3507 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2376,9 +2376,12 @@ static int copy_user_syms(struct user_syms *us, un=
signed long __user *usyms, u32
>  	int err =3D -ENOMEM;
>  	unsigned int i;
> =20
> +	if (!access_ok(usyms, cnt * sizeof(*usyms)))
> +		return -EFAULT;
> +
>  	syms =3D kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
>  	if (!syms)
> -		goto error;
> +		return -ENOMEM;
> =20
>  	buf =3D kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
>  	if (!buf)
> @@ -2403,10 +2406,8 @@ static int copy_user_syms(struct user_syms *us, un=
signed long __user *usyms, u32
>  	return 0;
> =20
>  error:
> -	if (err) {
> -		kvfree(syms);
> -		kvfree(buf);
> -	}
> +	kvfree(syms);
> +	kvfree(buf);
>  	return err;
>  }
> =20

