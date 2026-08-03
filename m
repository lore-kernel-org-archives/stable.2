Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F0333429
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772028; cv=pass; b=A24lGGA1KJ5T1uPgnmM0Yp8zesuwITcqAOYq7WJ3soJunanlfMN2joBY1EdKitBeJPKEQRkMxylA4bsv79QHg32go6I1rnvpSUTEOvX1vHtPhU6uTPTp1h1kzCQ95woQNpQSsbK3iwNOZ1rjK/axua1PXlp7bJkALScd7ouDfUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772028; c=relaxed/simple;
	bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVH+swPC3OwJm2R9I+SQ+r8NEOTDTy/TUnbv7PMjCMNES8aYly3RFrb3gdblf9pnOXN6JgkCtsBhH73F6lCi9w4TVYhBijfl146whsYHPbi+X2WRcucrcVAOdDsJKJD7RxI6iAFhBxO5vobN0oHj77BUGqSIHx60qy9xv7tj52s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIrNE2dr; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIrNE2dr"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69f4acf7047so589818a12.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 08:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785772022; cv=none;
        d=google.com; s=arc-20260327;
        b=D9JviXZuSoQvXTVQFwHpQp71x/usj+PPMUBKZ48ZxhXrWJtcQKdOvvbAJccqCqQuyP
         XT2NbJbKHIbwCTf3iCYL6qbYqBknD+mrAU6sC7SW4fg4qIl+h97ezofGFuerzrNQZm6j
         Fdb0C4BQC91sbUSDjug2YpbdzNYEpDrICOR1Or19WSWelfl7HCgFFQk9/3gU3/g/YAmg
         Sk6PvvApt0iEB75RW94MhjUXK/EJBXjb8tH921IK17+ssoEJVss2tno0qFQfVYA9aOZ0
         D22Am4CLQVnkkHzgrgqEbwzUTc7p0IqT/wgnJ/kXrzM1/0pNvcJ0TGuKC5mW7Ppz+t1T
         YAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
        fh=HkdKRzu66m3Mfosw6T1FWHosYNBnI0ZfLMzBtj/RRlQ=;
        b=QS5yYpRRDfNoLC+FvHcS4Ri79bWxzDM3tPV2C2ZBuAxI4KD6OppzMcRXyorS+78Le2
         lkbldzr4aEAvlnxTLe6f8LYUW6d2021mZ82+fVkRgHs/uBSxJF6doZem1MAd0eDvfN/I
         7NO823WY+JjfdA88dZUSuAL9rqVuETk9IXZnQRKHiN9QC7c2FTGoZzhRQGoX+2WchGSF
         zJgySTxBn5yBVz2GX/Z0JC95a9unM83FvCRs41N6E4FMsa8cT0SmwXe1ZeMW+k/cxtsr
         8rOuAEwCqp7vnbrV9KG3rdnD6XtSzyGmvcuaI9VDj9Z9tq5o//q2uZY/vgrIUhjHMiMw
         zviA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785772022; x=1786376822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
        b=fIrNE2drkrs+Hej3dREqqzeCTqKFtunVLL57kdi7pCxzFU4J1EpDA2gBEn3XxNItF/
         p7sCGRlZIV9smkHiA6X/yG7JxjoV+VEgjMGwcgxIqGQ1sW65DSx6UL82kLkoGYhVnKTO
         g/estd3Wq81aCxrT4HViUW4Yhllu6p2kicVcRakbVxMqXFB6Fhbx11/Qn0cfvdtVhF70
         4LBLCzm2gG/bLPMVSHQeHNrPvJcqTCx3f+/pDeCIVRUEaRhfZROBIA50zFQX+oIrIlQ6
         +b/OabrQp2FkCzGcfzz/n9bvgbdxySxT8yJTzgkO4Ew4MmHi/CDE04zlRmcH6wYRt5Ag
         6hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785772022; x=1786376822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9j7LG29CWoYTu6tfO78YEbBNKOeC6jsIJJlx8TGfV0=;
        b=PyuMT7lmPiDu7hIgL953NdPh/gt5OKagrp5ZJz5LfRl16u51Odc3IeB25wSbMYHI1G
         gjPO+964O5ZWzroOSF3o+noZM7nrG3iRh1bURQPcxNgA/4B6V1bedx99uTX+8RF0/Hfe
         WntTSyfraYAVVrv0iy2r4Ed//Ac3C5ku8H2GYlZWOhcqpn0tFD2L277fdNEi5n5zXoZq
         Jmn45o3KMpSUVRNJMugK/JAmdzqOG2UMz1UyGWJPyEAQaJ/WZp7B1/2MUlRmgUcpi8hG
         +mdfT8fif3pNb0QMa0WMvowkijKpLGppEajmGJ+3+bzwBqTpvs+1PDXONecVQR2ezMrj
         Iqdw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/OsmaIJg4G85HaYXdl3jidktjMd5LqTDvyTTobHV8T6e4Iqpq0Lzw+H2Qoe5YJXfw/ynen68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMLTFG66Bk8z1A8LI5wMiFXIukdZKCKBOVBvW6ZD/LnteVMLN
	cwghcgQRL5Kuervh9SQ8J4y0Z3EGznJ4zVapN5U/T7gj950d2XaHaIHiyyPLJveX1pnewSHYRKx
	D/QZQ9pCboDLoXdP7juagvKqkFpruEnw=
X-Gm-Gg: AR+sD10sVWmVuUWKAPHqC7EUbOGb4zy25aGTzpVczjXmE9GAfhmuBwydfPD7Hg+8vZD
	Su37/WYfmNgbpEQCu63fOyIsqfj+xLPWC3Voj+2QZFTzngQfbsJjdO2FmFg5y8q43pi6VH/owfo
	C1t83I4/jNOd3+QRATyaQYmn/9l+G02oUFHFBY58NZyVd2u+9smbqmX3a+job/LTVPx3Ai+KIkN
	sYYcU2wpmfKs1W3odKmPrMigsSJwPJX/SutPjEXYkwHS+SaUsMpGp/dX7A2d4E/AW8KGS8kyUUs
	QdwDOjJy8TA3nsyCZUqkupm4wIy44zufikyy4Luj0XXWls+TmXtWuxK8VcyqiIcQ+wdvHliqxQ=
	=
X-Received: by 2002:a05:6402:28c5:b0:6a0:4e35:deaa with SMTP id
 4fb4d7f45d1cf-6a0a7c66dd9mr4790179a12.1.1785772021709; Mon, 03 Aug 2026
 08:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731142220.3000214-1-nicoyip.dev@gmail.com> <2026080347-marsupial-clothing-b083@gregkh>
In-Reply-To: <2026080347-marsupial-clothing-b083@gregkh>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 3 Aug 2026 23:46:50 +0800
X-Gm-Features: AUfX_mxNdEwX8xfmOVCyXhNGM2l1XfvLV34VZ7QqIAlDAto2-nGRnPOrK2ukLPQ
Message-ID: <CAAo+4rVBDYfhJU0-KOQz=XDHpgc7mnSB9ciUQgdrcG6Ec6NafA@mail.gmail.com>
Subject: Re: [PATCH] tty: serialize device registration and removal
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Richard Watts <rrw@kynesim.co.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, Aug 3, 2026 at 10:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Hah, that's funny :)
>
> Look in the mailing list archives for why we don't touch n_gsm issues,
> ESPECIALLY by changing core tty code to work around the known
> bugs/problems in that code base.

Thanks for the clarification, and sorry for the noise this patch caused.

> Your LLM should know not to run this code, please tell it to never do
> so.
>
> Also, you forgot to add an Assisted-by: tag :(
>
> thanks,
>
> greg k-h

No problem, I will be more careful when sending LLM-assisted
bug-fixing patches next time.

Best regards,
Chengfeng
