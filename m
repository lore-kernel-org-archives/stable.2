Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7138B124
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038321; cv=none; b=JRpJ8YY0sBQU03BDI7VI/M1Kze4c547VrVZNDlnPp6eltrW8Xp15n6rNyM7zFkjgndvZ9z+lyUfbW2vB+SDeQUce7OuJEdJ8oiP9d3mRfmWnLwh+Lz6uMSn7Wn+VEpSHxwj8hiX9v+6kGXyjtNmW5kIbhvvV3F3y0pfFzZA+478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038321; c=relaxed/simple;
	bh=+qYEbrsbxj7e9WQzvoPeckK44XOr8IeXkOfRcwGoItc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dN7r6LlyaGPYH9CJ2np+gckmj/NP3yZfn/rQhtbnu8XJYYPCq5Dw7AfHVrJQCKISBxLtVBrlLAe/K6QqFwAJ+hdFFk5tLxVg8SCWWyAV5gx7wB/hTqqwc2X+8F6Mcg/ID2v67k+HxrHBxQOozYxlxWFrk0xDaQEWBAAwo30W8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwmmCRaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwmmCRaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ECD1F00A3A
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787038318;
	bh=fgU1zVBtw16i3Xm5dVnrej6Xkx66zn4xXZdqZiqmMe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jwmmCRaEd7pqX2Mbtyl5Nr0TzvSVYM9cYBUrrRhk+kwvToYclAE3VIY+EbKo3BFhS
	 cxQhNeEnvoETGEBY4cHJxHUd01LcM0Z4jq3sSy1GSERO54yW8vnlZmOLqxN4NYOrsR
	 /Gu+g+CTozsQWrotWzm/cLmtdPMZzzNjbtc5lDOuVYW27uFu7izpk82tugmLVm8CZI
	 8eXuSeA01JRlP840fihBFPDj70oBJEtIru/MsdocGW/bJwquGwEpPA+y6EI3sA5ipP
	 O7wYm0CpHEGP9COziZ9TKPXXmQxCsKFyxI1sa8cuKMPDh420tkQ5UeD1nzm77aCoAI
	 M4Wh9YBtrfpkg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so786001766b.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 00:31:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq1kFtSs+mrvccnvhBJ15zcU4Fa/icvafhJK0G6416LGt+i43qG87dROgZDc6saQoKOgdWcRhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqwqk8FP3q4GiIZV7rU7UZ+kbFi2HZI7HFJH6JWpZQPJaf8b4c
	nQD4OgKc879AsUww4h1pjjYb8M2WPMFv99EX8cck3EVNLgAo2QsGFW+ehtL9yh0VOKJgvfE0Q47
	MXau4CSZ3gkiRG5CUl9VRFxVVt3IFIRQ=
X-Received: by 2002:a17:906:fe02:b0:c16:9edc:612e with SMTP id
 a640c23a62f3a-c212a090d19mr1497844066b.3.1787038316995; Tue, 18 Aug 2026
 00:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817171657.212776-1-sorenson@redhat.com>
In-Reply-To: <20260817171657.212776-1-sorenson@redhat.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 18 Aug 2026 16:31:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8sLqY_j4yRQy1vassOwqovocJACH71Y2Zsv1YSetYs+w@mail.gmail.com>
X-Gm-Features: AcwNN1Wyl_fTX05l4Fm8c5G-HZiGJsoB1qry4FfCMhYS_uF0xlXDr7lpTUK1Lxk
Message-ID: <CAKYAXd8sLqY_j4yRQy1vassOwqovocJACH71Y2Zsv1YSetYs+w@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix use-before-check of ReparseDataLength in reparse_buf_ptr()
To: Frank Sorenson <sorenson@redhat.com>
Cc: linux-cifs@vger.kernel.org, stfrench@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:17=E2=80=AFAM Frank Sorenson <sorenson@redhat.com=
> wrote:
>
> reparse_buf_ptr() reads buf->ReparseDataLength before checking that
> count covers the full fixed header:
>
>     buf =3D (struct reparse_data_buffer *)((u8 *)io + off);
>     len =3D sizeof(*buf);                          /* 8 bytes */
>     rdlen =3D le16_to_cpu(buf->ReparseDataLength); /* offset 4, 2 bytes *=
/
>
>     if (count < len || count < rdlen + len)      /* check comes after */
>
> struct reparse_data_buffer has ReparseDataLength at offset 4.  If a
> server returns OutputCount < 6, the read at offset 4-5 reaches past
> the end of the received data.  The off+count bounds against iov_len
> were already validated, but that does not protect against count being
> smaller than sizeof(*buf).
>
> Split the check: verify count >=3D sizeof(*buf) before reading
> ReparseDataLength, then verify count covers the data region.
>
> Fixes: a158bb66b137 ("smb: client: optimise reparse point querying")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Will appy it to #for-next with Paulo's acked-by tag.
Thanks!
