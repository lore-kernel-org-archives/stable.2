Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945F3331EB3
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822097; cv=none; b=rdUGb+d3uTWPkbV2y2QNLZtux5SqtpiGatWYXxSPyYpzO0vMMeQSRC8w8RnZ6SW1pOkWjuYiy/LZv5zmcaV5+8rI4/l49vuQlkq/Ex5qUAns6OJJCabksK4q1yvHem07rcUX2CnWgV7R8k9kt6uZOLv2vVVsKXTrNloVO5i074Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822097; c=relaxed/simple;
	bh=o9TpznHEP+mULVgqgdAUENNtI8edpUMa8ub34DChYkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmdTUFd9ZA4rsHfFIQ7QHk8qhcMbuWyNFA6aa3DWMx9s9sDp/cwXgGUDMfgIMI0nqTLYSG86FbbPzu9gNOzcUI3aXAPuZxxDsbXca19Pbuzuhow5kkWJbfnwWkA77X4LqLFzHdl3lUoIpwdom6JJZAIQRuI3p0f0ANJqFgsjUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM1xSfLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM1xSfLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A0F1F00A3A
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785822094;
	bh=2YkazKmUrLOhbL023icX4qsz/H9PHNK5zkIGmoZj/fI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lM1xSfLCkAU7KdCMW9vuDl6yhl6JJxRYPM3PqFFsUYgdj2JNCmBDX3Y3ohHUnQQyN
	 bW0wKpSK1Ewdy2m8tz1NOg0LvMEM4NToNupg2pBkl8pAAPk3s+3t5g5xtz/rAH76Jv
	 PVNgOtJWPY7257ZDXHIFSHHn+Lc8fwFQBwecvImf0Cox0tqGHQOqnSJFFhafd6fMrt
	 /5MUwP7vOyGSgN6iTxd43BUEC2ibMq9KYjEp+kDcsf4S/v4nQ4DyXPjmmZYYoHEn3F
	 D3jE8z6ZaGzYblGIPNT/OiGljkns8KbPkW6OxEIKYQ1SaPue4cmwswi49CXk+ONYfI
	 jUkiNZ06/ZW3w==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e55b62640so198453185a.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:41:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpS/x+Pc+Tcr6c6A3sAK0XtNV4tBy1Tbp/Oz4fMXD/W7WtKpFg5HYyeVr8y02ZgQWK5HTWJrB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZnT/mxTBKQ3rcrcnaHeHNcMwqPUI+6sMd3iFPz2I0+bgZyWt
	kwX3U3XkTwOvWYJ5nkfIokIdiYbNH+16vkbKnlJAnmoNfbVKNXZjzeqooTm25oUfLi5OU4t6urW
	WqisnhQiTKz/NqGPDH2nVzAtRP7+YDmU=
X-Received: by 2002:a05:620a:2602:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-934ab73aceemr1838213985a.0.1785822094146; Mon, 03 Aug 2026
 22:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803181232.14743-1-ebiggers@kernel.org> <20260803181232.14743-3-ebiggers@kernel.org>
In-Reply-To: <20260803181232.14743-3-ebiggers@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 3 Aug 2026 22:41:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5HJbh0LP3FW6-LjYJHvKXYAYuQsvxAX8VuemXS+CAi6A@mail.gmail.com>
X-Gm-Features: AUfX_mw1dd5UVIBtzqf2jWpfr06Ke2mXq4cnaMkv6N58qAVrkhjOup45SME4mRQ
Message-ID: <CAPhsuW5HJbh0LP3FW6-LjYJHvKXYAYuQsvxAX8VuemXS+CAi6A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] fsverity: Fix silent truncation in bpf_get_fsverity_digest()
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:13=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> bpf_get_fsverity_digest() silently truncates the digest if the provided
> buffer is too small.  This is a footgun, and it doesn't match the
> semantics of the equivalent UAPI (FS_IOC_MEASURE_VERITY).
>
> Change it to return -EOVERFLOW instead, matching FS_IOC_MEASURE_VERITY.
>
> Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Acked-by: Song Liu <song@kernel.org>
