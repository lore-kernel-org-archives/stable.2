Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004664;
	b=GHlhxLA2UqC4O+8DaXXDOF6WB4JDdyf7bgVGSjocxYd87VT4Bf2CjsUhXmAKIClPA9YU
	 uxOa23taWiionvDsbCsGZIBDncj14f7NG2VYoWQeTc79ZmQ/HsJjP0M2CvIzwG3VjC59a
	 EHCdYbCrmiIV42bVItsaIns+tdhDCeJIPoSAVzHuBCFOtObbziE1UMoMKRgEi/qRSYWQI
	 +/zNhs7a1M3ajRwnxYHa/GP4p8E15zyHxl2koRMZw+K4SI3d3qAwYOrFxbbZZT5AP6jOs
	 EAjV20fQn4XQ39RzEAlqW/v/mp8xx+IZFUESBL59TOPj00zucXKLhCr6c1fll5dZOEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
	b=a6i2/cHW5tzbGSgWXk957EOBX7IzHyRORYM8NP92RBOroRB/9DlZENRmJLCMw1ydQG08
	 JvKoZdUg8u4/Yw9nGiRYYzHv4FKC9ec4oELtSmDwlkecUlcT75W2YsoDzPARc4GP/uKIW
	 acaizzIB+xORkinKOyV4GmFyft3mhUmwzcfG0bAJcz1k/tgDmhpwP2DIpxtjt7PTnp5kP
	 F9PjFsJwBLGm2Usk1SwpzdJAD6V5Sz8otKHenrN/JgPZbkP7uTqrp1/JRMtkE7m1+qjYV
	 /rZPPpGcRDfEh7ze97S5Y6h2YU5AIynPQD9pLXCUPu4d4nw1BlgWCubby8AmsiM/V5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oh2lU9lh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5823606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5823606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oh2lU9lh
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4589379eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793004663; cv=none;
        d=google.com; s=arc-20260327;
        b=aHEvGyuLg05ybOoYix5C99gBDeSgde6kHTeBNnhPFDhqLWChOv9yBzdaF+ju6ZkJtw
         lGEYOQLYRXcwhUTr9xDNhy4qtaQdum8ZiOwGFPeCVhRrinmUK42ZgN8FNGJr/rVaXs5m
         lqk9JCEiu+56EmOKF+qjPB17rdfbrJ8RMlSQCE1aNwtK2dtOXNlNX9WAm9tn+9dM91aZ
         w+pNwubqDF1LgS8sHw+XgJCZogjhnp9z/F8OxZRwnX254BcluqjKVbFxRo/5Fqy+84IB
         GQndMwW1MfcxfFc6yo7t2OgpdWdFZiZXsBmjXvx+t4/isdSr/YQECau9lQovTSSOKJjy
         ceyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
        fh=JAq3wDMCtJNaGk16Z4qxQa9JhADUc4Bmyrvfd8GW8rQ=;
        b=ncnLXI1CAYNidF5iot5kc5BQEEQdk1J0viKUFkVU5+7VO7BcStVrnUbPk2U37iKzf8
         o1QEZjzjN2SBRhczGVqFKAqDn4kvOqfTpTu27yg1dosjL+fG/oEap8GdTM0JDxnO8bRm
         /2HoGEaj3K2ILEzx+ZPse5pojHBAsXsCbYIEzwaVMsPIlvQCxF7ljYSaHWnAaTtFm93t
         9zV/VNrv/2MUn5Mw46pYrlSN0b5lrzSiSGCX00IwRZw7rw5/EoBG0YZYY8Q+PmOoTPIc
         U1gZwBSPJfMN+4WXl/pdxtwtsP9UFAUfaeeVecOibDKwsxE0NNFCvdrnLiMWzdIpMX4W
         Q9dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793004663; x=1793609463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
        b=oh2lU9lh2XW5bOMIoZggPWD/M/w208pLutnXYKtqzP4b2JJ18pW6eKn/KP+fPwj4R3
         mJpwRBZtjw5JnMaXltAZ3+pKOxs/hLeOtkp5pZfFcWLpzypC6IJXH421xJ2LMwnfRlKp
         iU4DLNYUBFycQEAnXJlnNPoJS/84qHhQ0TZfCFg9RlzuSsaiCGLhH94a7bdHammdeDc6
         w0HeWoPpOek8aeQyfPlzrX/2hl8c9V8en0t0VIeqVCoRISPKKz5KQLH55rtOfwuA6nfy
         GVVqgUyBUKDqBbhrnLFbZMZ8sE0jKUvp9DqEXfi/mqUnrtrB2jK4BD/iWysVxfpDWVfD
         1P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004663; x=1793609463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkYXn6onLTJUFDnVxOEC6DFAsMb9fumAoXKz09PsQuM=;
        b=sGluVP/yTSZmZu/hyAKUGM+JIpHc4tfeXaGfFLqsOpu+6vkhXYI0o7XKQR2p+C7e3s
         CDjHcpHTu4EF35ayY1xsyS6h1RV4spkTdd5z2xaTBpuyy9kdR4KbU7pZgPmR+yW0fz7x
         ew6ZKPQmpvwWolvlnOuU6EY4A7uA503CEPkXg5MwTaNAZwQXazisFoImT2dE3qOSy51X
         q0dPrnIMJpIImQL5v/0C49ogjssOcORCsUDtyDLeS1wNvyRCPyPZFAD1LqDhBira/jVg
         e6pKFxO/zSXIKCzy5R8TUOlXyGB96Qb7lrhIA5WhY/WiXx/G0IkoVuw42Z36TedNcc2b
         MlGA==
X-Forwarded-Encrypted: i=1; AKwUvBybqRfBbyx6w6MdUhZ7m96HOX7zCbgZf+T7HsxzchbXpAnvNy8NpUKnZZbQwCg05VoXvfiUr+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSMWbHkfNXffQnMHmjyRc8IznOjPEVZqC7cseUj4bzs3LDddGv
	qh414iIdCgtG4dV0Pa0/1CQkGI2kg/FY0ZFe0hUa16ReKmKE0xPMbGPrUO615yoEIaJtv0J8RCC
	SzZud5uu8GsPGa/g/6hGmC6jQFGsPnT8=
X-Gm-Gg: AYBFou2kGE7EAW2f4yiAySwPrghlP6949UqaPXWpNp9LmvWZWXQWI5+Q4tf6pI8RWY5
	jVTQ8mtCKmMwHxtXzqmLTCMuK4rvkVnpP7hxb0ufzC5aDWt0eszuLe0TtI4Ol2C6DSzyyxIybXq
	VXiFsmC/fnZgW5yEyEp+tWNS6ORzMXw2lNJtGgBW/17b8iTGY+LIZJU/8EuM++WXg15Gr12XmMr
	3/LtQF/mnuCs9HLKHFVlStwm4Q4jlIDk90lrAyY3x0pXLBbRITlJHbygjfDUxXUBme42PQsDlZx
	voE64lMMN9ySkDXEH7I6Bu298bSSQ4bJkbvM2BrTotaAfI0HSOpL3qS3fuhE+4NUVwSgDCguI3m
	sGRRy+FdJx5IoVxxWP3SoAisBC3Lb0wD9P8jgmCR4RI9Pzoq8sX6ivw1RJh9yJlC3NAyb4Q==
X-Received: by 2002:a05:7301:db85:b0:369:d486:457f with SMTP id
 5a478bee46e88-369e834e14amr8992878eec.2.1793004662453; Mon, 26 Oct 2026
 01:51:02 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-2-267b5b7a79ee@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Oct 2026 10:50:51 +0200
X-Gm-Features: AclHuK-MLwyI42-tjUetBxMw3Pp3JS4p0iAKrtkhDYxpLMnE-AgEIVtlDEnzRGY
Message-ID: <CAPVz0n0bc8Ox8jLmeGZTHhT9+=xKmw-poX0gM+e2SE55zYf26w@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: tegra: Fix overflow in tegra_check_rate_in_range()
To: admin@tsv-stahl-riesa.de
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Shardar Shariff Md <smohammed@nvidia.com>, 
	Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 26 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 00:5=
0 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> tegra_check_rate_in_range() calculates the deviation of the configured
> from the required clock rate as (configured_rate - required_rate) *
> 10000 in a long, which is only 32 bits wide on 32-bit ARM. This
> overflows as soon as the two rates differ by more than about 214.7 kHz,
> so the check lets through exactly the large deviations it is meant to
> catch.
>
> On the Tegra Note 7 (Tegra114) the Bluetooth UART ran at 45.33 MHz
> instead of 48 MHz at 3 Mbaud (-5.6 %, see the previous patch). The
> check calculated -0.18 % and let it pass, although the limit is 4 %.
>
> Do the multiplication in 64 bits.
>
> Tested on the Tegra Note 7 with a tolerance of -500 for 1 to 4 Mbaud,
> which gives 45.33 MHz at 3 Mbaud: the driver now logs
> "configured baud rate is out of range by -555" and does not apply the
> rate. With the tolerance of 136 (48.00 MHz) it logs nothing.
>
> 64-bit platforms are not affected.
>
> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/tty/serial/serial-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988) and LG =
P895
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
