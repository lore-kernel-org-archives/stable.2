Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B03B388C
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785603169; cv=none; b=fzTRIaRwUDpUjoBAwHWseV0s492g2vEIrmnJ8LIHxQsMrgi1nDoagg0Ktq67CB67DiPG5RPVFD4zg4I95YFIl4O4RPZ5gc/0wxuGc0DzGEV/ejhuUfFW3G7fxBpJDyKLjFumNueTPUx3aI5bH9xmlRyUNZAPlnsPlWrSm04t+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785603169; c=relaxed/simple;
	bh=KgdOOMyZqtF9at8+Chv5TnjOOT3t+C5+wsxUxONLNNI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ked2kaMBBctrC9o+/dY7HeUZeL43mDXGVxvM4BCXeVzMST+m9tF6TOXnjUqdmHZBBbZ8LtY4HdmlxvDDJHkQZa0faTlDxw7UStRlNxLfV/rcR4bpOZHeKP1rLPB3DdrExyy3pXyqPVCHlK6EYtc5lVFH1i6cfpGG9HSUh8zHLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW8mZCcu; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW8mZCcu"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso4164525e9.1
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785603166; x=1786207966; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wIeansZilxyffldQc11/VX8an2oLgIWn7z7CoIfg0tI=;
        b=kW8mZCcuJkv5kOqCwhFSmru0R6wA0mH5LZTWEBDQafnO+bMZ4udYRdC2N902z/0bto
         WMTOgdZq7UHijeqc9PjTQryAi+UiHIgbTDwfDFFttMpbc7vsh9gGMaiEz0Sn92lLW4ad
         S7w2m+ggMgs8mN1QC3VbZvyhSr2zJdqI0QuFQoXWFS+YYZceA230zBiGqTODDJINI+Go
         CjazApNM+7L0Is+mPdU30TB0ImbnaBucVANoq+bCQ/kYscu/CYXipbDuUK/5rRIzrwEI
         dcRvts40qfYHFnjF6EuBcDZIafsM8jUovFfWSy4NiBpeFHeK3j1OGpzfIPrgwAkcIlv/
         XLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785603166; x=1786207966;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIeansZilxyffldQc11/VX8an2oLgIWn7z7CoIfg0tI=;
        b=RpbNoB61hmvQCf/V4H5DxUkfh4ISn/9YRM4a/mFZGKjqnKN8zSqeUls6g6U9/9NNfn
         ufW14cVjw3uP/V2WQ39h/lPaxr5HjhI8mEn3Pm4Z4Ce64bIMqwqN/oXExsNJIG5o080P
         SWR5O2+FCQSyO0FFrey3lzMxzhEthBbNYU4QDrz1mGT3sSIYzV2RBN2Nz+cLmkjeIVaf
         LHmqwRUNvmMetQs2Hfxe4UGudY9GLPFS2Z91DoD8kq0X/3Rcz8Dc8syDLfEO5r7qs+A+
         YjQwR+D7CCN0ztN2kDHcWV8t7RJ171kjsS8JK5BU6wh8FE3NLlJj6j7DlK7ph/dGmZCy
         7A1w==
X-Forwarded-Encrypted: i=1; AHgh+RrGEDSpSaec09VyGSXjBd/xS+UVXWHoAtonGXeKfYtuXSnTpaziR+A0HE14wHBMZF9ywiSkJm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzXre271Q5scnYM+wvCLhPg4E9zINIJrMlnzsIEZ1PY5EgRbe
	vOSXcik4fYtuqFiwjtwR7CNTL38z3iztl4Ck0N4PetTtg0Sflh6YFRiO
X-Gm-Gg: AR+sD13gx1TB2EbOOsvmGCBQrg8a/PsUwyyPhNYzerBXqhuVlDtG2Wbdtgc/ob2uXIR
	fZ/Ocqov/yNY6/j8sMEq9fOBYUaLMOWYcJZgfWRXH8lgddCeyWxQpbrRqDjkuC5AqIX4yhAvBNY
	HdBrBkbDej2a2ofdLOlTzsTGnzfEO1Gz69+3R3hczNrguvepO5jTunOrh6e1ogXvQkVxZ02pFhF
	zyuhzMChpdMb+lz3zPktSuTwOfgADJPohUrbet2owaa+koqp1fY1LC59AA8JsjxJEzGRalucQeh
	2IfmrZaANNkAmeUQCpk569LA2IqLnmf+YATc804LlNv8zL61NIsuH7gyzXlhmrXy3xODocGAaWH
	ux4YjWE+wqrdjGIH7jpG6jTr0RTcdtweuAEEx2XxSlG7eEeV8yE438Xi1+x9w22JnYGso5haOjh
	XJux8DwvJ3gGPqUvzyZ7ydfuBDaNV+hlsx015+51oEk3kmMkveD16Du8YRqOBVmB/uzHiNfmBjz
	dyn19+bsxwb/JxjSEFoMd+NXHcRr1mqy6OoIBO7OYHFv1BKIacou1bFPw0TWWKJIzw7QatkO/aJ
	ZQYtJhUrD5UJmf8YS/UgIGyQqw0=
X-Received: by 2002:a05:600c:8b17:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4980c66c926mr70298535e9.3.1785603166215;
        Sat, 01 Aug 2026 09:52:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808191ef9sm78066875e9.1.2026.08.01.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 09:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 18:52:45 +0200
Message-Id: <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Jiri Olsa" <jolsa@kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>, <fsverity@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260731003925.2728977-1-ebiggers@kernel.org>
In-Reply-To: <20260731003925.2728977-1-ebiggers@kernel.org>

On Fri Jul 31, 2026 at 2:39 AM CEST, Eric Biggers wrote:
> The BPF verifier and the dynptr abstraction ensure that the memory space
> referenced by a dynptr remains valid.  They do not, however, provide any
> guarantee that the contents of the memory are stable.  kfuncs are
> expected to remain memory-safe even if concurrent modifications occur.
>
> bpf_get_fsverity_digest() didn't follow that: it could crash if
> arg->digest_size was concurrently modified.
>
> Fix that by using the known-good value hash_alg->digest_size instead.
>

This makes sense.

> Also correctly handle sizes over INT_MAX, which previously caused an
> integer overflow and crash.  __bpf_dynptr_size() returns a u64.
>

I guess this occurs when using file dynptrs? Otherwise the size is capped t=
o
DYNPTR_SIZE_MASK.

> Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
