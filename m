Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004634;
	b=g48dZIkvNkvA6Sa9mepQRXNVh/n1o764CVrwhvpimfeEpViQ8lEeTks85YtqztXILF2q
	 XC5IFSxmkc+az53dMWOwTYGcjqp4+2b9ft9Am2gGpxOhR5Ul0Q0hCzLnP0jGzUTHOQni1
	 4yonIZCsWpv8ejMid1mJolJaAXlfDovaSW6HzDicr5OmJfKD3MEaDByNgLlmDAVKl+C+R
	 JRkIUdGXss1L2Mu8C7XWgFnZcaom8+NDt87ra0dXJ0HO0s6mwuiy6AOnnkbuoe4kPENaO
	 JzwEhU/KQR9CRmM/PBTepj5vnm7mNZMECwwAGMExviSIWmD4i6T5U3w0Z5n12Fafp5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
	b=Ww+zOLTxzOm7Fm7YRGBw9GQ5fs6IpCfi6rMMxWOBu+V443aVc+COsUisU5EKXcL5/pWr
	 XuTXzlZgxz/ayodFXc5UaqPcJy/IAvGhLWJOvDQazzpFVNfn0trmWVGfSZ387coUQcnWc
	 BS7FhvHEi/Q2YiAoGimCljKNng1UCYwgojYgW3uYvizFJ2DeEg5KA/OsPR/6HkHNQjF1M
	 /5/dADRlkwxh16CMqhQahbILIXUIUOAKJzK+C9DtwzEgx2EJUAuvfEagc9RR6LzXLbVO6
	 Kzh/KBn9iO1qX5mpR6zielcMHbNNayX2kNL/oMmLl6fTcTbVjTBmd32IW7pfUZKsVyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nn0nVMTW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F7606A32F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 405F7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nn0nVMTW
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36661f953e4so5240797eec.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793004633; cv=none;
        d=google.com; s=arc-20260327;
        b=fdP0/sOJRVBNV6KnAQPhrA1k1ZpqQLZaXFaMkq0wXd5gS7uEc/L/N2q95FZ3f3QjAE
         b06z6U+SgTjgSJsQoWvV5fDRb1TyUkWgiAAFSYgtjJUxP+EgUdVe3D+BXXkk86zHtwC8
         HaxJSjzBj4nUf917QblgZsRLCN7V+sn4TxQlYguoh3EKW4i/dQ2EfuFK4MzzWmd64ACZ
         2PuTWRDEFP7hz3rAoqIllyJ1wAAU8fJBTyAvzV/2WjCPipkfPlHNMVlBI7UiA4DW8UhP
         /S2MSP9ImXWNs3DAor4roQsbXmosahDGLFHTHo0icNFETpPl/1idlySKuQNx21lwma4J
         ENkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
        fh=PdbwUnfaw9PKKSeToiafS9FiuOH4GqjldBjgCDzLQPU=;
        b=bQQVsC3hL2nIkJW44TyS8LbanEviEbqYhXSI022mU9SH3yZn/OxAwS3uxQ+epbk2xw
         dzRwZu46ITLUZ1pJp+P7Nbd0MAYSWuZCYsiByXz8Ns0FDesJJHwM/XnflToOXH0tMxww
         EKWPTbsf2+HLgEs8+hT5PxRXSEfZb/rtLBYrQSQEIKmE88+Z2LgBjfPbugj17RKLNP4x
         MiiagOrZ/yBfhdf1dbO9NExuSmGkr4K6mFZv1XsHzeLvGZMHN8VGJiwFlFekqJNA3G/i
         4e30TsEGViwf3yRRTUeoEwNdHoLsr+KqOwXPfc0gR1ChPAubpAQC3S2nEjBntzpaIn3g
         KcIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793004633; x=1793609433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
        b=nn0nVMTWa/ugZXPz401T/3tm2krdJPTQqU9DomZfF4YDxk/9Q9Uh6xz5nhH6qQ8P1E
         AeYL5P0ze3rc/tKbby7ir9sx5t0zkHCxvV2s/Z1mk1NnH9mt47jESv9zkkwMSVZbO7kN
         a6q3ybnwzDOLcS5B4C0qvq41i/h1wkclm4EbNTzFxQY95U9tpUabB500RG/Nx53/SglF
         Yaj/7W8im9IIiHbhzpwoGIqJWCpWQ/mk3MJ0BJocjD1/BYp+QawbLJpfI0kBLJxo/Azx
         baDB3XQzzCf9lfyV+uio/X8ICKiL89jsF8lex617pD3TS3z6DwNwC6bvmQXehcSeWAo7
         3J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793004633; x=1793609433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xS2sklpUUUsLj11Ls/tuw9BnZ0uRdCDBYmfpAjGG9c=;
        b=xstf02A4Et3kjKR/0s81HRjCwsJpQbcPoyPFtcvhyPc3EUPw44cQAx5YGKyuXN/DUI
         dAVuOPXpdMqb+FywrUmDDcJ/kyqaEhe9vzvMBSGK35TRi79zTtYgTrKQREaxw9VzAykB
         tc2SV94Mkfx/cHd8lTFhjZA+iAZrewSdEtTVKGNkLYRvRTgNTk44G9FkG0GJI1bp5msf
         gV38s6swW2u7cj0MkxkOVXvr/6U6ZPZz9zE9YcuVAiOv83A2pXapmNt6T9gKu3uZILch
         wp32uUUWxqQyVzKjLzoyw0hFDqt3bvNznItJEUwwbOJ+Ijr1+0ZwCL6xD31GUc0rGzt/
         ldbw==
X-Forwarded-Encrypted: i=1; AKwUvByTnhUOGtdG4ozR1gWY2+wwZma3f6LN8BcOsZr3TtK0K+AgPXJcsVWkybABejGFD5/0Yewu1Zw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKacNddNPEjbeBSKA6Us9XA0hHeK1/R6XfO8rcahZxxCB+nzKI
	XTLRFaOo6xWtTTyX5NjyBRaSt4nP86KwiBP/I1Plf3vQ3CnDeEGYRinB8YB0IxUGYRXul7AjwRD
	GKhqprmAnIdkVSgLmnZ5y/zOqFwtMbR4=
X-Gm-Gg: AYBFou1N8n3hCQ2QrjoG2h3RDoPomh1N0rm3053p57rATYkIV1zhgyR4jSA2qBv5GZY
	PEQII0qAQkwVRTaFsuGNDZ48pRwC2QdJmfpSpwBDrUyJaax4CRyIgBB2A4CcN6+W/bwBK1JbPqU
	xvCfZhnMwp6bCJr87vIYay6h4Z7//3fMWTP78nJZQ38cORnLG8ihiVoqXAvmc0ADKLrUVzLQxJl
	F5g2NQyUAWy9HS3xnfr+sF4AjPaELVjerJDBMZdNtbRugwV6qXe9IeZTVr9eAqclFM6xuB7Tyej
	r/cMp4Zs4yHKPibJE0g1S9DhDWJPzY7DTA22u56u8WKPeh0SJ8n32TsCeODSEmaNFEPtqgESZhA
	GMsBoO737wHWvac7hfGZmxstnrJikL6zN90MOyw1JUtlSsJ/maEBFxoG5cNWpFtJHMbsRJQ==
X-Received: by 2002:a05:693c:87d7:10b0:366:83dd:46f7 with SMTP id
 5a478bee46e88-369e84bc5bemr9492113eec.17.1793004632970; Mon, 26 Oct 2026
 01:50:32 -0700 (PDT)
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
 <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Oct 2026 10:50:21 +0200
X-Gm-Features: AclHuK9eFB2IINUeequ9JiBD2-5Y_QxsonBBC6Q_QH-dQtxOvUA1C2K4ZB60Feg
Message-ID: <CAPVz0n1X3K_vtCNUg5k6oStVCfwZEpXJSSGJdk1OK24au1R-UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: tegra: Fix overflow in tegra_get_tolerance_rate()
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
> tegra_get_tolerance_rate() raises or lowers the UART clock rate by the
> tolerance from "nvidia,adjust-baud-rates", given in units of 0.01 %. It
> calculates rate * tolerance in a long, which is only 32 bits wide on
> 32-bit ARM. With a tolerance of 136 this overflows from a clock rate of
> about 15.8 MHz, i.e. from about 1 Mbaud, and the rate ends up adjusted
> in the wrong direction.
>
> The Tegra Note 7 (Tegra114) uses a tolerance of 136 for 1 to 4 Mbaud on
> its Bluetooth UART, as in the downstream device tree. For 3 Mbaud the
> driver asks for 47.79 MHz instead of 48.65 MHz, the clock rounds that
> down to 408 MHz / 9 =3D 45.33 MHz (-5.6 %), and the WL1801 controller
> stops answering after the switch to 3 Mbaud (HCI commands time out
> with -110). The same overflow gives 23.31 MHz instead of 24 MHz at
> 1.5 Mbaud; both rates were confirmed on the device.
>
> Do the multiplication in 64 bits. With that the driver asks for
> 48.65 MHz at 3 Mbaud and gets 48.00 MHz.
>
> Tested on the Tegra Note 7 with the tolerance of 136: Bluetooth comes
> up at 3 Mbaud, scans and connects to a paired device, and the HCI
> counters show no errors.
>
> 64-bit platforms are not affected.
>
> Fixes: f04a3cc8d455 ("serial: tegra: add support to adjust baud rate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/tty/serial/serial-tegra.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab (P1988) and LG =
P895
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
