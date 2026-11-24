Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519123;
	b=Qexz4eOvdJVFJX8bd+T4HyYnWAdtXILCj62MxmOsymjV6UQqMgF4mFrv4n4yOU9bzZ8j
	 DtOHBP7SnF/V5JgUymTXEGkiZhcXQUolTLHz365y1PoRzTNgYwHZTcTjgAy4Z2+BDa8or
	 0LrF0B+6oYzmBKkSggvtC0VBLeprCHnFJrt3R4mlCdb3V+HhktUrxPeWvzSVws887e4CI
	 SMIWUMZMjV9Ljd45SPhlgQb+cWYE9SuTayQgDndGRRqNfCWb/WvKvdKKIHlOJm0Nj2O0s
	 2e4p1L++whddmBhhxR2RWwkB8AKNa38Oikp56j5TCfw46qqC2VjdQ/lo1bLSO3DPIQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zWCBxQaDnc67itD7Zy69q7XjxPuH2oichietMTNWCaE=;
	b=aRWEPf/wMHunk2uvZpjxEQ2ifbpeAgn8zZAFaOZlxPHc3w6CrJGOH0BOgSJHMgqtmRD1
	 vCfcDwaigk2r//nc/f927x9i7IO0py2+F1b6v/Omyk8u1qTPZcpa6T7zX3B/G23bx++Tu
	 H+5Dd5GWQAix4nHGxMZ1Sif1bRBYIqminpuUhn5ouLGM6omPi51L959AeNyDVQvwQgwhe
	 pfXgZnH1Ro1LWe7hUpD76e/U+Zpb8rbZo/SvArHO0GiKNLRPLQeS9lI4sMvB5+UA9etWc
	 Nr1y+SQBxRaCWlVgX8tIdnkQbsuqtGjDBe41iFuzmuTjf/GW62xBb8nV8TDUT7BDTbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9RRly5V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7E2606A687
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D7E2606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9RRly5V
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c1479a959aso3196603e87.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:18:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795519112; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBEzgU7wiRFVJiM7qEKCQZrzw6dBpnMIIwozBTvuh/jEED66ChowlrDDDJXFLtlIQR
         H9UloVvMCw2jYEFgG8Uo3sPSWsa6t0/fl1lyC4V2yWdlJxZXz8lup4jA+V3J092zo1W2
         a8yi8F8dHoffvwM3cJBmjrzQ4c9tm8g9HWdrt2JUJfqXiflLhmCvVmky/AGzDfYELJcy
         K7bGh+qtBpON1b6+wqdhtes0GOhcmyhiTcLd/6nV65m4bHl/1hbvKfsYMeWkPtlywng0
         fC2GC141YzuLNwmGM7qsYoiyhnlkziL6vDj6eFjfB5VkBuNJ5E8hM6dviFu4m8uOf2sb
         hivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWCBxQaDnc67itD7Zy69q7XjxPuH2oichietMTNWCaE=;
        fh=Buw3vvC4BFos3zKz6ZeNvYpjlMygcQ/rjjr7DY5R4Ng=;
        b=FFjdGr8QOTa78cGkUaaLqbCI37EWVwIwAkj7caLHKa2g2VZzTFyKSN93RFJs+bBEc7
         MDxnYVZnlhjYZ5Nb235OG8uMtPtDK6ebX1gAU/X1YamHcEiRbkvLBUTXIwyxPaqMgyzs
         iSSBkNOcmRX5G0BGuB4EwbfcdONkb/zMi6p22hf5bUz8jgRNV3h36FcdfURhmuQoYJ//
         KV5M3C+K/lHOuQPlGifGbf606agnJC0f77urK6LYMmbiQjGXNhRGqYeYJFhPYUZYNNvQ
         h6K+DlbJZwWil8c6un9tHJzbd9yeWA8QVIVcyA2tjM5da2wT/j9A8wh9OsiAdOBedcyN
         lqjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519112; x=1796123912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zWCBxQaDnc67itD7Zy69q7XjxPuH2oichietMTNWCaE=;
        b=q9RRly5VnYFyowhqBSQL/48g/NufBr1Gan5N3JqmdUgoGgtYe/hgLkEwSaF//7oeua
         Ze9JDy55EeCG+kYuwByhnoI3dpKs8FqrVTfIvi21XaQ9QdzDsHGK7qN95u+8Md2JHt2o
         N9lePfSa2hCu2/fRHrNyPmfhAeMJWWbaqvOLj7upAFXbe9ZcNOXSK5YRLR1mHHx1bfes
         bkXvQOjRCBlzsuizEl4abZ4SV+hzQper1KnjJh8IheVBkPlEVd9g0O/fEqVSgLBzMZR9
         JSZBf6wouDwnbyKx89G0AP3tRQXdDO6+ZtHBTpKM2RcQTjUIeP9yTbXdz86gTV/3kJlf
         +qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519112; x=1796123912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zWCBxQaDnc67itD7Zy69q7XjxPuH2oichietMTNWCaE=;
        b=Iplmkc/soIVSkqDG+wsaawetDsAFXkmX7/TtKGet818Opo6SU411j+gsmeOgZ3leaZ
         DWLa1u9ObT50vvLjHWj1UjMwqP20M4FJhWP1Cv1+WI6bywb7FOTyv4iuFMUSzsYL5lK+
         I1UqLDj9gJ+JzEFcjfuCHq9dbzHUgjZNGTNNmm7s+M4xXV6XrX0zFZRmSLY27Cx36Eo5
         WQ0vY/0TfKqk9iAkRnAIiGNdqatOH24ogwM0J41gH/hq90DK0t0DjePKOQvhLTFCcTMZ
         ZDsWueShFeqAlok4pgMK+ogYl/nLAi2cSH9WO76zYh1cdHcQg9LL0GbO5cQgfASuBGN0
         +JCA==
X-Forwarded-Encrypted: i=1; AL+hErGD5tpevXKjbqJNf8tbzWKKzc5qf7Mwr48Xin8cC0T9ANrg4nG4NapmQdhg0oCPZ173CsAEGPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O+X+KMDaPY9OKUrY8eeaXwAiGPDfiOT+8N9aDaB2AuCo53IFy
	vV5Cu5J3pBVJdPyLh5Q8T73qoz06kAg4g5rnbNV2DORLG0G/0s5KJfTkUcDXv6ykbM2O0lLv6bz
	bbNdOkkrkhAnCg8qSvnXRRAtso+tZZMQ=
X-Gm-Gg: AZFdTZfZ3xl+xumNEz1gyVrvqSnZKO2jwfT8DU84Sv/Ukxnm3hLZ7qCvRXXW3k3EDBo
	Q+dsugDEmq/oCnZ0in2hrQvXKojabhG+Ngci3odkvK1weZ6HWnh8PdIzvekKqEwhahLIzfnoDHd
	BLMzIhSJJHZQl3jR85DZqloVy3e5xuPa4Q1EtjYCHPDa6UDC73hrPQs787mMYBuUd1AIW2ijT2s
	PEZ1wlSoydW8DOp0yZE0LTbtRXJa4EGHPimA58b6xMMJ6pgm+omvxuvBB/Jru0deDqhLjPK1S0V
	3kI5Se3LS+m3x9wP9RfRSuzzt/YXEh18nnA0+d5+RHtNVystJlATlvQqHa8xQXsWvdToWvpopWU
	etsVnY3fhJG81e5Vgv0SrrCTk4IV1MBT4++omifgMfbKiHVOF0pAmYsgCWHfp4Jo6VyqXPooJiK
	Gsc57AAFaviEuxIZ0ar9CNSOm+tRc=
X-Received: by 2002:a05:6512:108c:b0:5c1:5be5:a543 with SMTP id
 2adb3069b0e04-5c1bc660a53mr4292498e87.9.1795519111544; Tue, 24 Nov 2026
 03:18:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123223357.535424-1-festevam@gmail.com> <179551300942.327856.7174455040291936744.b4-review@b4>
In-Reply-To: <179551300942.327856.7174455040291936744.b4-review@b4>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Nov 2026 08:18:19 -0300
X-Gm-Features: Aa3M54rPCqpnfWWfBJ5P36EvmMGDYSDRBq9WyY_WgO-ypfC7S97pWkWQHrUAf_M
Message-ID: <CAOMZO5ALfN-zGZuVn7tm9gpg+1yO1tQGKt+O2NXem14hbr+_6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mxsfb: lcdif: Fix use-after-free on unbind
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: laurentiu.palcu@oss.nxp.com, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, marek.vasut@mailbox.org, mripard@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

On Tue, Nov 24, 2026 at 6:36=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> I'm OK with the change (except a small nit, see below), but I have a
> general question: is there any valid use case for removing the lcdif, oth=
er
> than testing?

Yes, the motivation for removing the lcdif was to help decrease power
consumption on an i.MX8MP board.

> No need to use the @ret temporary variable, just replace it with:
>
>                 if (IS_ERR(encoder))
>                         return dev_err_probe(dev, PTR_ERR(encoder),
>                                              "Failed to initialize encode=
r for endpoint%u\n",
>                                              of_ep.id);
>
> With that done you can send v3 and add:
> +Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> +Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks for the suggestion. I'll send v3.
