Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C973395243
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613052; cv=pass; b=HApVNalZ8JrHF6jUcmJ9mMTWqmEtWh7mBWn5f64GprQ8/FrnxIDAKYUsMoyykW0RtVmqLQfKOiq55GTq4N9LnReD86DJ4YVI2BqoUYObJhqJR9ShZZZCwt8bAJNVgnkm4OfEe1Bws6yIlYDV91W5yrFEsXnRBTkGLtpS0rrZQLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613052; c=relaxed/simple;
	bh=1AKZmIXPV27rOkD4RR6k5prDAk6supclxkDPEsQRfj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcDKLtHKfC2rAE/ZvAhDAQ+bKA0dzyt3b5GRiF2MwBbFQ4rfDzkC+r7CpoWf9kN6lvL6XArQSbk0k5UIu5Wkn2UrWLMT/CW6Z+E7t9WavSC6HA62nFMRybTjrCsSP1tTY71nZtWS0nf8oS77/HvoN0F2siRAY7niogpNk1aEYyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8FCoZRN; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8FCoZRN"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so7454661a12.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787613049; cv=none;
        d=google.com; s=arc-20260327;
        b=QBMi5MpqLTFVZqYlljQt22Gd4gUHQCrbZTbj6Bmvyi9ZKNyOn4U3H6j86xFq9LuYp4
         3ZkB7U3cC/N2Rip2wOQ2SYE8BDKoVQtv1rS9gTvV6VF0+XhNTXcwBMD/5XyOTzplizIl
         dBqgtG/SdyQm0v4EDvf5I713bDbedmEPolJZ1JFHBHE6mmX80rSJBLUZ11+wO2k82GMP
         J/orrvQxeLeGZobWYjjVovtHz248PUt6pwpea6XI0kfnH355cB1qSaBtyff7n/gtDS53
         Bi2SQIzAQhVNHUwYlshO2aGfUHTdRb9HIJwuq2bRyYt71PGOARGs+nBYsDJcSszu4/Bl
         UqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ciun1s7gJbj8kr+GJGzvFPSKEFSRpsUeoIvHsQ/oBM=;
        fh=Xdpvi8iM8qSe1U3QP+Sd22C0fyyOVKJUf/N/RAewZ+g=;
        b=Ke3dPrD73SxW38kngqfDqe30P/yZq1LpD8qbgRiTU5QrdC0UViLakDSKOuRt/Pa6gR
         ECSjwKIq2ljfusc+zkmONBWc1Cv/l3x88soferQ8DbJDN4gNhpcuu7Pgbv7Aehuq0P8p
         Vm7w/B1K0gAz/87vFxfxQWPfGJ9VG5cVnwUatG73J6N6B0kqEexIUvPPmV6+/BqcxEDX
         4Co5Bp6fy0d9IsY3V7UZcDaODfS4uKPt+0ePeY1nPeRfBxPLX5x67uq8pYnaZdC6eEJY
         JPm6J5vLXMSHWyqfCFiluunxlJNQ/qdQb7Dh7mcGbapveH3GX+w4X8E6xKI5L4F6Ws1f
         U8bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787613049; x=1788217849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7ciun1s7gJbj8kr+GJGzvFPSKEFSRpsUeoIvHsQ/oBM=;
        b=l8FCoZRN2tnMXP0z1ziaUD37FlNcp5BqSXnkhh5mDcP3CqDCOV75miclwxC+zhNNYx
         4zOWhc64ifSHjjECC8Ot9v3GqnqWoO2D4EK0lLgYPmKuztbpL0EYrlGxx0Mh1sM3f9HE
         4S4PI55x4PN8pBnkzXt+G32UsJXFbpFUtze+iF2TlhJSF3BaiWMqL4zwAFxF4yKr/vIa
         agDAbFQ0I9RJjd1UhxjeH4769QlQKg9/Z+L3ieFMaXrbVF+3jOIcgA15YFga8MppXukv
         OX0csPD/025XfYFYb5jiAH7PLVBqJkTotCNt+BwODScwtDteaUXFDVG/TAG00qGMxrpO
         lwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787613049; x=1788217849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ciun1s7gJbj8kr+GJGzvFPSKEFSRpsUeoIvHsQ/oBM=;
        b=JE3mCUaWfAkoVsd8OCZfR9/qj7DZJORF5VtXhwEY/ne7pX7jUoVK+KRHhEKU/7tiGe
         qPKkSWjETD9HcQui29K+aPxj5GDv3ORisNf9cp3xsCvdsf8CkoZUfBWbon0S/j9b+PQG
         Tqe/Q+LUGT3eCqV/lpCYvRSftEFLoSAIzD+oAk+59W1MXp66NhZfLV6NegPDIwkHJOkU
         tYlPhBL1s8O73nQ86i0SARMtH7DD0FwJBKrYnjS51K/5Dcsn3JA3apT9zbSuM52Elizv
         HCHdBZ3yYottCRyFa8P58wwQJr0MQfG/vdBJ48RBWQyqBjBfjBVrov1bCn+d/cqUyVYj
         SmBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4EE3UrX/P3Rs0bl6XkKOzw2LwmXgCzhtGMw3tw28RnYnGkwvYP80YxLxMd7yqg/72KX9MdRA=@vger.kernel.org
X-Gm-Message-State: AFuF++l1suYrNNCpG2FbjDQ3oZTQjQiLcty6/3txUFMjbA9fKJU1P9hz
	mdrvnY3ahiRGmW+AMff1O/pAu2OQZ3oIq1i0fmScPjLz/US1QX0UvRkxWBxDVTz7KYpm5z4NOR3
	J0a1lwEqf9tdP6Hs0thzfQBBArJ8LAAw=
X-Gm-Gg: AR+sD13Qg301lDGGWPLtf2kkxp9E5kf0/cI3MMVEcSlHRkCPkDo/1Ui0eWlRpcafNei
	cVLKSpkOUPw+bgICfx9+eFljwNOMp63hzz5Q1EL96Q/l2usHr6r9ol/z0qKSyMMHqNYjS4zZo9L
	998ktxHjUZ5+qvfPNhiCYWCg0UMAX9P+t7ZLCVOKb+fKGn5AeA5MjS1JFL4gtoQxm65YEF1lC9S
	zRbSDHtp4QDVvGsnM1SjzTO+ZEKB45Tfb0XDzQ98mVfGTalCPMvvRSB0sOR16WST32K0GDeiKr0
	5aTaewQUJnmu6u7JBM7FPxjUOwMqAU5pfgzaCy12q1faTaTHVpdWOzq4xmjXHfxCDZsQpOx4oot
	y6rcJDod6yx7RCaVxsmJ6c+qScSGE
X-Received: by 2002:a05:6402:414e:b0:698:3469:fa99 with SMTP id
 4fb4d7f45d1cf-6a582979538mr25815513a12.0.1787613049239; Mon, 24 Aug 2026
 16:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728125456.32359-1-meatuni001@gmail.com>
In-Reply-To: <20260728125456.32359-1-meatuni001@gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 25 Aug 2026 04:10:36 +0500
X-Gm-Features: AcwNN1XFC4yYq0ENqCoieHotSGlfytchG6KGUunZeKEe3ss8OuZzkSdaTs4Wzz8
Message-ID: <CADqcGB=j8cSE-CW8dLC8My0rk70RC-Qidmvr-dZvzCUFE5wadA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] staging: rtl8723bs: fix multiple OOB reads in IE
 and frame parsing
To: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping.

On Tue, Jul 28, 2026 at 5:55=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> v2 of the series fixing out-of-bounds read and buffer overflow bugs in
> the rtl8723bs staging driver where length or offset fields from
> untrusted wireless frames are used without validating that enough
> bytes remain in the buffer.
>
> Changes since v1:
>
>  - Dropped patch 1/5 ("fix OOB read in rtw_get_wps_ie()") - did not
>    apply.
>  - Dropped patch 5/5 ("fix skb->len underflow in monitor TX path").
>
> Muhammad Bilal (3):
>   staging: rtl8723bs: fix OOB read / stack overflow in
>     rtw_get_wps_attr()
>   staging: rtl8723bs: fix OOB read in rtw_action_frame_parse()
>   staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
>
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 7 +++++++
>  drivers/staging/rtl8723bs/core/rtw_mlme.c      | 3 +++
>  2 files changed, 10 insertions(+)
>
> --
> 2.55.0
>
