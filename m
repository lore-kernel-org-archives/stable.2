Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955747DD70
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038186; cv=pass; b=oosOCXwH4qhpsjwVDYAoYx4/Rs/JcAJJWU9wb3TVqPjQjpj5djFvngvMkH9BEWsEkNGxoNbKqwClp3Tl37dxecj21CvlhoopSdCI+klervDasTiBqW+EUDREFgYta9nAFd7ZMNvmZKFcGh6QPYv8wNBjWKPO6DAcCb8JTtTLGpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038186; c=relaxed/simple;
	bh=5IdzfBAuda1Ugb7dvbIa+3pE4vsLysi0rcWtfaUR3BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jH4hfXCgWwyqC5TVy7OXr5b6tFJiaeDtuKq4ITq1dUHEvPQ/9Q/Z6mxg6h4mm65wVMs6Np6CVli1h91DFubH5CHMVlxgvxAhAFqIYCoDkJJ2SVNQZpk6nPSR1YHf2E8r8v5EpEdASGsGs+JRLbFBYblxHPaHgDUjh723grTcgL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXeWdspq; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXeWdspq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38096590070so734668a91.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784038183; cv=none;
        d=google.com; s=arc-20260327;
        b=GXjdd/cQqlsJIXFNzqxAuvcm4GsxMUZUKkjnnsZTgNTo3Qb/26fmAuO9O2mbGOJLnY
         +4uUzC2EIDcAYy2HVkPKvXEfGYFTXmYGOuTiozS7Tisb3A4RiSLjtaB94odNfRxDo0xf
         P+C1RaG9yb03FKT+WVrUsNcxAf042nVn3BcooQPW2DNbzq+Ko9sWn+aMNHEcKmL1J5Wr
         Sh6+SjkDYUZQRamP9gp3gtethujnM7ZOvzfHExlgcThXmu9F0YxUHE9z+MpKhUFvrKUS
         s8rHlEYWJdaZbU32meA++FUP7MrQkFUDuwFp85seGhCukB4CaNIuk0rf0nGgyqmdapg9
         ZnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5IdzfBAuda1Ugb7dvbIa+3pE4vsLysi0rcWtfaUR3BA=;
        fh=pDBtYJswwDm7Jxd8qY1bLvcVAc9TVCQmmfGIhyXpeDc=;
        b=UCoVul0EwbqgWXZzYoGytBumKh8/ri/l230YHAWS0NJ/lz5GjIXnn/FRacsAL+uLw7
         EvB4ldMbm+sbVE5Eow9WBHADJCy9Ku7ZH1nOtLyNAxntN6U87RXCd611vkFS+3Jk5dh3
         EKkbL02LUW+9sMeeDHg/+6noBfGrKCycmF90Tth2cq8VktYhpX1vNITKBrq1nUShY10o
         LE+jdG8R/n7uRuMjT01uNAdA61J/SIa/x+T6UslrGdee2dRfaYod7A4O9o5dgkSE49AD
         N2K3i88aGFgRxYqzPUXvMqyYdRqlcv5cvCYn+fFISXIZ53sQu55dJCVHq5cul+VKqhaT
         U5Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784038183; x=1784642983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5IdzfBAuda1Ugb7dvbIa+3pE4vsLysi0rcWtfaUR3BA=;
        b=BXeWdspqbLaupeIZEjiitm9hl1+qYIcVeoIGRxKOEsZLOVLDH6mm1v3tG/sXYjGF8e
         NIE6np/yPGZvr0Cu+3Zc3rNcnv8/Xr0XzeXpBgORloYpFUu8gd350+lFMn0+970/+597
         n9SJPfghvl9yAstcVr+iOgRoX09x+gG85x4I0ghmXfTB3EuEQvc56oDZWtQnnD6Xy+PQ
         9qxyRO3GPNijtUJ9VXbekbKn3NALC71fT3w8njaxuNY6XuSh/Dq9JrH7hxGvawlrGhZa
         hNZsvZe0Dxgwe+iz1XMMEur1P3Kdfyu4Bhoq0w2J0A+Y/qoRccF1cZ6CLGfpJNsLiJJc
         p0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784038183; x=1784642983;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5IdzfBAuda1Ugb7dvbIa+3pE4vsLysi0rcWtfaUR3BA=;
        b=cIoqmvU18sfgL/8iI5ErURbYP0SbzY1ITe5wMHdLNTKn7nJN5BV6W53nKRApWoTvg7
         0gnOkPLx27I/DLA27Eo2v1wbgA/pN0XAn747z/ghDUm4v3yzbEiO8YlZss12E8odQcs+
         SCs6dnu8CKjSZt2MzsrDRjJq+lsRgJPNSmSfCz1NxXaRAq14oR5ImP4CapU3MGS5sPYt
         v+E1vpUc7tpSBdDdQ0YzTXu27Ol2ntP5lsrxmB7oOIc0o/Gzc8ioLkHGkWkvDNwS47FY
         PAKE0eTFDUDE2um0qZ3UtzkeuzlNCnUny9kKwdofsOG88udH/Uj0BMBjuxdlwfheszye
         VHNg==
X-Forwarded-Encrypted: i=1; AHgh+RriX4KgIGx0ohG6uw5rV7qZdEswvgd8Y1CQWfQpGrSIbYXaXn6UZ+utLPQQMH0tVXd3GH2k4rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXc9i+WFl8zW0GdxGQkaqmX5mFNJF/CDNX26fYFoQPjlr5hFrI
	CP1XXEIAfpEJmnKipHugIHcfu4ZoD+XdBrRitrKYATksevXH/XTeXr8EmninHWV+3Sx6NJ8UUnG
	92TqnRbwM7JMh6d8QGp0VqIk+8BXWjtc=
X-Gm-Gg: AfdE7clRhaXva2r4ilSpAtfUdGmBfSQLYVNGNn4u+lZ7mxRnxnAx+eUfn13WbEdnTch
	u1jqLrXRGpPNdkPZfhP08bh6/JV1znRICf7Nalit0SiksNH71GUqB1CbkTpUY5gru8hqFd+EBW1
	sV0WUCibBChJN3KT8KJ1MGVYU9HEYm2C1W8SAvdql7JkiP87XpqQSUZqG2SmT637+mc3JHHAftS
	mV1VO+ugOiJ3AXTOJLglDi00B+i3g4AfiqFt0eY2HA6wSaK9su+FdZMUjm1sB5u4+5lWvi0wsda
	sp8Yvg0M0y9T3mMoRuX6cdgbZdJEcQR3VJiZZW0kQH94k+xUtMTU0u3pP/MHPdik2IRbJUKfA6m
	BAgi6172MuKlx
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38dc760604fmr9794243a91.0.1784038182439; Tue, 14 Jul 2026
 07:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com>
 <20260714083331.69482-1-litvindev@gmail.com> <alZBCoBorSGsCw-t@levanger>
In-Reply-To: <alZBCoBorSGsCw-t@levanger>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 14 Jul 2026 16:09:29 +0200
X-Gm-Features: AUfX_mx--yhT3w1NL0wLQwdIGz-EJTA8oL5Ed7RG3qAqn7teI9MMql8DPSUS0vc
Message-ID: <CANiq72kCEr+576R3U-QpNkKm41HFPzrR42z7RCJNo_YAt+MR=A@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/tags.sh: Prevent binary files appearing in cscope.files
To: Sergei Litvin <litvindev@gmail.com>, miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org, 
	nathan@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:00=E2=80=AFPM Nicolas Schier <nsc@kernel.org> wro=
te:
>
> Miguel, are you with with it if I take this patch as well as the second
> one [2] via kbuild-next?

Yes, of course, thanks!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

(If the `cscope` target is actually broken in some cases, then I think
it would still be fine in -fixes; but since nobody complained so far,
I guess it is not that urgent anyway...).

Cheers,
Miguel
