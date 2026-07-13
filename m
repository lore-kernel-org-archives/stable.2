Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863E3DE424
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933973; cv=none; b=MhHoUdug8qzZZzjnuSR8cICptCSAb8HHpQLJjwnF/A5ryc00Sx7VrsPlC4+IIFtgJZv8JmLV35zWBPFscEsgd00TI7l9beJM8G/czQ6aaKeyHnMSXdZ8Ujv5VVEgof9upQyazFHu3K9nBYHWLcYsoYf9ZbWa7ELkgwNkIACVn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933973; c=relaxed/simple;
	bh=KR7ofJS3EykDayBzMtL2mzrr5NE5XcLuA8fzBY6jaNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAuXjeG4nKDMz3UOARpi5VJGnnGWJq3yNcXSEZ2Fc4o5C4l2RSM3hCNqEcOAvKS26t+zY/wrT+3jSlicK1v49Ib11TC8md1oyRGPaB2WX5nsAncLERWjpIxjxU89M2vQx+J+GefWmK5VvV3bpJzlSdVwk0VRD1ocZ7XXXwoOdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-73f6a641f6eso997061137.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 02:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933971; x=1784538771;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mdt2ZpMbpiIZVtPHl8mFZke/+oHZ4bhDPI14xdCANR8=;
        b=PrDxRhhVINcnoD1Em6vvIuQT1fyv678xxSq1orziCLgEizFWsjpCFUWhFThhiZLSPh
         n8pdS3czkIbrUQs8WBz0PqfNSiWypl7sk3fBT3BGA4oD6/ctvS7yU5PqiPTjjqXFDqOF
         R1FEvIBFkv4id5rtyPAWhpiVLlRlj2QhGp4xE++H5wRmGWjqnKhML6ZukDx70lGLQfHL
         LESxNWduYcFVtpwFYNYxDjiNKJJ/KG9a3JCtJpodN8PGGUGFs4s+48sx2HDDUxeyCtZp
         8+0cDi1l9Nz/fLFTaWkT8fCGq9U33gkLjTUYF45B+7FFS6czt4bqJGsYsufMWS9fFlW5
         R8ng==
X-Forwarded-Encrypted: i=1; AHgh+RrnqT6+HXCaithzK8uKT4Q6npFKF1JCPbmuYZlWqnAsnHDGDyNoFM5ug+mJOhhkvGVW4F/Csas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGN5+yEZgNE4facMcIo3iXBWHnYL5YDDGwH9w8ZCJ2gn4y/1DE
	F9S/7qB65wfWeiyo+xarZBDWwqm2r8xCwwl6UaMnQrnwzVQ8Gm+Nw/zZlyR+rjIO
X-Gm-Gg: AfdE7ck/EgcPNi6wjaWJFrJi4cMyOGPWz1jZgzC5/5ps3GyYHG0j5xTsXVuU2SAsgOl
	Spn+aedCFZ0qMN3QmP58vWTQwlERpiFwK5dbQscU+jXmCz+0lAstD3k9PtAwq7QTI4mKqh/GFiU
	Sk05LoFoHKZG6PtrRzW1srHgd96hcvuan+8QN7e42YX+AsH0zV/z1XGnx5qNZ1bueHM6YHAUqi5
	ZoPh7cr017yIC4uCnLN6fMYlovBrzafQuUtL6NSyPcYeFlGpeyZmlFLTcDpmpz4C8CWUjCp8464
	OTPepL+6h9zbGJ7J1EsgswRxZYIA5gyQ4upp+y4SQk4tePuVcMlIPuVZhUzpcT6teDvhL/X3PiY
	CBF5x2hCP3UQX41jh6q0M9HC58l22LwE3xEnPMlddqIXUxaIzX0WAE4C4M84ec9mdC/IGTNYZu+
	F/Hu+uiDpKrYZ3Ghbw6C3+Tjim/eGeB8QAaI4FEkCQ+cShJTTqvA==
X-Received: by 2002:a05:6102:38c6:b0:739:626d:4473 with SMTP id ada2fe7eead31-74533848931mr4773400137.0.1783933970660;
        Mon, 13 Jul 2026 02:12:50 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6a3eb8esm8450226137.3.2026.07.13.02.12.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 02:12:50 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-745497ac8fcso320345137.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 02:12:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro22uqK+3b90PpKeb07ywzOCqcV1WTs4AD+UilufAVx3Vkd8KxGtMKlBCONFcpxQpl2wRacZCQ=@vger.kernel.org
X-Received: by 2002:a05:6102:c11:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-74533d5836bmr4638111137.13.1783933970193; Mon, 13 Jul 2026
 02:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710160450.64967-1-marek.vasut+renesas@mailbox.org> <CAMuHMdUQJ8mzUi0birB5f1KnCMX_QufHTgYB7AW=d3ZoFer+Yg@mail.gmail.com>
In-Reply-To: <CAMuHMdUQJ8mzUi0birB5f1KnCMX_QufHTgYB7AW=d3ZoFer+Yg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 11:12:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVD=y++zr8sfnf9ZjW8md43ifmuytd-F7PY7r6e2p9Tbw@mail.gmail.com>
X-Gm-Features: AUfX_mwAEKuhdsHoYqlC4vkeXsOmSglqwfwCjvHk1qnz5qkYmbXVC-KIeAr11Bw
Message-ID: <CAMuHMdVD=y++zr8sfnf9ZjW8md43ifmuytd-F7PY7r6e2p9Tbw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: ironhide: Describe inline ECC carveouts
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jul 2026 at 11:11, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 10 Jul 2026 at 18:05, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> > The DBSC5 DRAM controller protects DRAM content using inline ECC.
> > The inline ECC utilizes areas of DRAM for its operation, which are
> > in the DRAM address range, but must not be accessed or modified.
> > Describe the inline ECC carveout areas used by the DBSC5 controller
> > on this hardware as reserved-memory, which must not be accessed.
> > Include DRAM areas which are unprotected by ECC as well, those are
> > parts of the DRAM which directly precede the ECC carveout.
> >
> > In case of high DRAM utilization, unless the inline ECC carveouts
> > are properly reserved, Linux may use and corrupt the memory used
> > by the DBSC5 DRAM controller for inline ECC, which would lead to
> > the system becoming unstable.
> >
> > Fixes: ad142a4ef710 ("arm64: dts: renesas: r8a78000: Add initial Ironhide board support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> > V2: Include the unprotected data areas as well
>
> Thanks for the update!
>
> With the ECC carveouts, Ironhide survives booting with "earlycon
> memtest=17".

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
(also with all offsets set to 0xcccc0000).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
