Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18F3101A0
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743722; cv=none; b=J9Q0f7B8N5pxcD6PUFyglgHNalBj317jsJccb00D9/GL7JlAR0cA1mxCBVmf1geA3OeAtmBk8Tcc7b+eUteaeejw9e2zaPoX0tr/HmgYIiLf30opJBHCBjB2qwWwE0wRxzfD3Manbbz3swiRhZ70UEMSlKFGqgEG9vhdBF3c3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743722; c=relaxed/simple;
	bh=Wuo+bMt7X8tweXE396YuJxWT4Aq/RkDqSUllNrlHizk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii9eH2mPFAkSjQKRQS3LaAHCqZNX6lbhsPcS/jB0y1WN7lhG/K776mgk/FuAhZN6of7edhQpAVTNXGD8JViZ0PqkvLujuHawWqqw0CK5LqfSpHe8nrzjugSEFD3aGk6tWx6ZZ/uYnIac8339ttaJwrBIB7whoFhJR/rmiKNEMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7y0Hp19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7y0Hp19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071621F00A3E
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787743721;
	bh=Wuo+bMt7X8tweXE396YuJxWT4Aq/RkDqSUllNrlHizk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G7y0Hp19/Av66o950bB/VeUxWsvcU51z6yZRQve86t/JBI7xs2ETlgPKa2rlBZVdT
	 +wzEuMW+D7IoREah0lJ8TB1aijmrMKi/dFINX9q2fGaIErIsRMb5QLohg2rLct63MC
	 kl9xX8xjjeb3JP5V+Qa+9XeMVjV3E5A1i66uDvnaQ/08xAHacNx5w2VKZ5TQd0QW+o
	 uUBbwLp21eMwiIWc7m52GfAvGdlRQ1FJmmr5WX5LSYjeLlNBcmenxr+7ZLPSZIMwJ2
	 fAMNS0O0DPBEeXzQ7ipY2svMZLr7knrBKCr2Z3eY+7P3QrIYF9sfrTIVQZSNce4jrB
	 KWnV8zG1SNgYA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a5e392b2b3so1155109a12.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 04:28:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrpbCRFEPg/XC2rKOkoLbwTpVepmAa/xTudanvqb4eDe9EfG1LhqzjuhNYBJHlNtcQd2HU0Kkk=@vger.kernel.org
X-Gm-Message-State: AFuF++mZWAMCrPBsL4uofbzq8eug1Gx9j38+0OQeRIl7sg8Wgzust6YT
	QS8/bLwK+moqSzd+OQHb7OcHBOhf+k9cXPmkFwyaQmUdft3Y2TZjAbj656gmS19KIGBrqKFO5eq
	5WzTXEjhKtd/oAqtiKqvKIzhfAtsr69s=
X-Received: by 2002:a05:6402:42c5:b0:6a0:8885:e6f0 with SMTP id
 4fb4d7f45d1cf-6a5df5f0b61mr7500755a12.3.1787743719648; Wed, 26 Aug 2026
 04:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824054115.114298-1-zenghongling@kylinos.cn>
In-Reply-To: <20260824054115.114298-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 26 Aug 2026 20:28:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8RD=NisPHjoD+8meAh6s-nnN7jeRYmyH6Fv+9UVhBzwA@mail.gmail.com>
X-Gm-Features: AcwNN1Umr7HrHWw_6xgnr6FeYmdAF4X6UTN7nxBD-H1Af0wJVN52kVeriAwjaOQ
Message-ID: <CAKYAXd8RD=NisPHjoD+8meAh6s-nnN7jeRYmyH6Fv+9UVhBzwA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix incorrect MFT record pointer passed to ntfs_attr_record_resize
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 2:41=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> ntfs_new_attr_flags() passes the wrong MFT record to ntfs_attr_record_res=
ize().
> When the attribute is in an extent record, ctx->mrec points to the extent
> but the function receives the base record pointer m, causing incorrect
> size calculations in memmove.
>
> Fix by passing ctx->mrec (the actual MFT record containing the attribute)
> instead of m (the base MFT record) to ntfs_attr_record_resize().
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
