Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362876;
	b=sSuGmDAExiV6useRQ0M5DDoda57FUZjhlBiC/CUi6yi5UnqHIi8qhfo/qH7qn3QsUhQe
	 hEV76Q2w8XcOckT/0d6nmbQX6Q1VaqJfNWiqSbQZqf+zBcrRVbmTaff3KHBgQx0f8Odjv
	 gNj+pjPJonwThPXor0ZFqzzFAa+48gZve9mbDk7qB9KozNoGbfK4E/cVUWoVxmplzdPGq
	 3w5ASuCU1aG5N460cWYeZW0FdMgV37nQxlA6nTQ8d1tB/Gn4zubBKd44o+QsAoFkzU8Fw
	 Ts58PedtWzdGeYX6jDvF9wbgtDDoOjJQzqkJOAxH9hmoDQG7zMOVaven1ZxEP5PBp9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362876;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=bs+aVi1+6hDy1HNy6v6dzYMiqPyVoyHt4w4ufaPFezs=;
	b=mHHW2hop/L05wMQiVemjg7BIOvjFIPUrDT+hsT7xoMy8fg5D7GBIMurPVD/JL3D3pDMg
	 QaGtuGwwUHGW3UDAQg4uGiKuc1xFdAW/YcrMluYh3ul6fQqdXH6SdCqvkVELeXIipxFod
	 MRKvul69mKP9yAaK5MIdgjr/DBC0G62JEPryUP8EjlkAaWxHueibvlSlGf3LOiBoMdib2
	 2DweWIS9CFVwZ1LHzdXaUpcrR8XwJ8hCpvwZRXTkSwXhRbCjjZ26XssRQS4mhV61wK3OL
	 XHsG1/CwCbhYvsfV2Ns53ewLzCwXsgn9zi698sU4sN/w1s8/6CbbGrcRATCg5uYS9Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShtsgSig;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68F606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ShtsgSig
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBED01F00A05
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362875;
	bh=bs+aVi1+6hDy1HNy6v6dzYMiqPyVoyHt4w4ufaPFezs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ShtsgSigYIYS02Dgo3ulYttIR6NWLDZHXsS+qvuEfybQsNYFpMApFz42nPGouZlP+
	 pjIHBRIBjBgcAKZpeqgyvk2XANMh2uei0s7EbTlBt5GZaoprhHHvMpuhhJW7xW2wpQ
	 B1+AP8fzjmifGmgoTWoG56L25HdHLlw6PKCs57hPQOVxx08zgpjtBx+oxFKjlPIPem
	 d5md7EN2vVJKGaZyYwr2bR7wgfb6yqOdKBr0VPoz7vfbWTc9hukUT8Tc8XjSvSMi9U
	 DOt5i1Eoqid5UDTlPGd//SwVBMLr5wxW/8KUC23jzT/ghYgy2LEqDh+pHcle+9xuYe
	 CgbFYE1dzYerg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso3370518a12.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:07:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHiDfOpX01+knwxcNb6+y+wRZaM8znLX/DZYJ8HfoJ3XbOTiLtsKJ/e4qgTBx8tD6ZjYnBI+Yo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vpzbdkhp4gurUIwr8PSAXsJt1v+aIpHlzjSDyeQ2yTSt9IrGO
	t53JpZG+yU31OvvdotCQJztjWd4C9/ybf0xyIedXoiUk0sw4/l4I8ta2vmDmxp8JmpkEj0pJPOX
	ZpBbFz7S7Er1WfkJgGu2FXxzVy4xAhLI=
X-Received: by 2002:a17:907:728f:b0:c50:5e10:71aa with SMTP id
 a640c23a62f3a-c5066afced2mr70360266b.14.1794362874533; Tue, 10 Nov 2026
 18:07:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109142429.1741882-1-wahidzk0091@gmail.com> <20261109173229.1921147-1-wahidzk0091@gmail.com>
In-Reply-To: <20261109173229.1921147-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 11 Nov 2026 11:07:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-n+zGBq4i7rfLyX+_Y6zEMLTCCqb2vAgcnmavqKxtiHA@mail.gmail.com>
X-Gm-Features: AclHuK8X-dE1jij8Odw14OGuXlOkUvdVf6LdzFcz6clCkOfLe7qi0UBLqneoZto
Message-ID: <CAKYAXd-n+zGBq4i7rfLyX+_Y6zEMLTCCqb2vAgcnmavqKxtiHA@mail.gmail.com>
Subject: Re: [PATCH v8] ntfs: convert a named $DATA stream safely when making
 room in a record
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -4895,8 +4922,19 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
>         /* There is not enough space in the mft record to perform the resize. */
>
>         /* Make the attribute non-resident if possible. */
> -       err = ntfs_attr_make_non_resident(attr_ni,
> -                       le32_to_cpu(ctx->attr->data.resident.value_length));
> +       err = __ntfs_attr_make_non_resident(attr_ni,
> +                       le32_to_cpu(ctx->attr->data.resident.value_length), true);
> +       /*
> +        * A reader holding folio 0 waits for mrec_lock, which we hold. Do not
> +        * wait for it and do not look for room elsewhere either: the reader
> +        * keeps the folio until we drop the lock, so the attribute can neither
> +        * be converted nor written without waiting for it, and the loop below
> +        * would only convert other attributes for nothing.
> +        */
> +       if (err == -EAGAIN) {
> +               err = -ENOSPC;
Please explain why -EAGAIN should be changed to -ENOSPC.
Thanks.
> +               goto put_err_out;
> +       }
