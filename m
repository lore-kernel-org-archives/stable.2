Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5513CF039
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141742; cv=pass; b=uKrKufOe0joF6gRohO9M6c44aj62mexPtfUIg962+kbqGgglaKOKWq8lYDDTdxVBCdiSB86v2uJndZ+2nJBnk4Gs1bc5Fe5+FPftTutAuUR6xBtkTO/I1QwJMERHCvWBaDX560CinsGzjlF+9Hnu4oh1aeqDWX043czaeBM3tWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141742; c=relaxed/simple;
	bh=4fMeCgiEb7KH5DAj6ObJDXdV0rN1foJUWuxcGDEvDxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1DmK9DwKUbLB3Gl+/kf7BnLG9eNjk2rt1eKQsVpJhBRE5g9goD7c1UYBh2XVBOBYiI2vylZGJKJ47DUaOZMqajpBms7fOdYAOdU//s1Ejr9kch1/DETYeWIZS5xio9VT+hkQoez2E2t3UojG6/sl4QTZcU8ruWZ10aEl2XRqKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBks0T6j; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBks0T6j"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so9128335e9.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787141739; cv=none;
        d=google.com; s=arc-20260327;
        b=ERezdCWBdQ6oRkcBG5GJx+FvTnU4uQy2f/LulM68IfoFfLury5by+coZesRgpJZ0s8
         9OuugF5zD0NIUCdXMjz3Sg0yQFrZ+IV2NwgIJjJHI+Km+az7TzbBth2CpYFcLwS5oSoU
         m3Cp+H7WZD15D4w849kIddVOgEshIpalAyxXjkKEThnTaSEh2N+Ay7t9YiYjRrruHC0s
         KV8whmr9Pt07lBtZXy6wryTOdlJOTmo698jrNTU5wdGPrzjpJzhy4AsvTO0/Uc+ZHIOD
         mAhJHf3CZXgg4KC0yB6+pqKUVKVS8XHwI060vfuDtljclIqHxCWMYds8tT8z1OeKtpWw
         h9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=72eOsfV6zir1DGDYJWBdwYLSoDHNbYLfxtcu28MhLOE=;
        fh=IJDlt71holQC9YFo+krm/VTVZaZgeMPKWtcN2jFakEU=;
        b=LlxYpS6eXBdcGKlWfvISzTKuRzOIkVLXyQjpo52VN9GYFB8au8/xQHlG9fznicxEH3
         OAx+rSKaWl2f/GrxZWs5kq2a96G+vqlPYy/UxA0XcG6OG6j5MWOQ7/eNM+R3/cEiI+uY
         LmWmiFB5rmDt++u0uo3KLvBfacHgR3Xu/XfLORwuVBstSc3W06XP6UwWWU9fGtZSxEXg
         cOP1ZRKi4xD5xkYgLkbx9egIZtAwlfXeP2iz8DNwpib4HbvLcJDaeuKXSyZNS9HtvhuT
         izkzBTicRO0sJ+6BbWJWbvMWcyTZ9HnYXCquuF7kXDL4LUIKIId5dkoRMZQHjlsZEDbN
         wp8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787141739; x=1787746539; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72eOsfV6zir1DGDYJWBdwYLSoDHNbYLfxtcu28MhLOE=;
        b=lBks0T6j9HEpObbvpWeAGBePdh6GTjy9+iMWAEIfOojnKud/r9HCMFRj4R/cJHas+P
         0xvlucBqgFvSj/lquo1MD5iq7/r+kQe2jgx1jRchXjH4dAlVLegN1FvOEoY4V1DE1DYu
         EzoJus8MPsnYk/ErA9qC/V5v0JWCBLkVrZK+O2nbsDh8rYfRrNK8qec5NsJcTlpiVsZK
         1C4Lt0xgJl/jxAhsr/BBwbA6Ap0AnpXLI6tpNoGO6/YET+sKn9kWKUkLNZO7fcGnX5mI
         THGQRZwGEAV6JWxsbS4NN0wFYSdwefeh3uDP1Uxhv0HGowPOZNseFG5593cIpeVOSiNH
         aveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787141739; x=1787746539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=72eOsfV6zir1DGDYJWBdwYLSoDHNbYLfxtcu28MhLOE=;
        b=T97V8y8Z4DlfdoLz2q0RySq4ZemGlPeUo8AUstCZZh3GhByOj+aYIwFy3Zc4G/Ci4F
         ePKETArHnHEjd9kZbd7tw29TSVj5S7mvX1u8GF3og/6ZL8HCcco6Ibw8tJh29ofQRZGk
         2X3x1/BmHdg8QAolRqEPBhYq/BKFxreYyqadpV7Wd2iyrXX8bPRuKmwLm8l48jZyvVlx
         TmgGvR7fxPKSaSymmfvlBF1p3pXVqHhvq0Zv1fldTUtMVdoEK8T6WsTAi0O2vjrvaeci
         D4uipYJNSOVFdLq4su/SM3J/OXLJCngs7JOyErMZDJtaZBEc6txQoJ+sgm288X/iZewS
         3S1A==
X-Forwarded-Encrypted: i=1; AHgh+RqpbJiyohZkzzwex83yApFo9pYgrWEr8OoZK+cagng9u6b9LWSTjIdQfJjGQz2nvIuYOQ8qSb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUfgc1aY8Zr7y5VTl4U8C0zZzOoLiHCdSksGrKZxoDNmxVqGZI
	j/igme323aCOCrj7Hkh47qdde2+0qm5TuBEitrk5OUnV0RCezpt9DEZaUttYXkrIcLdQnqVDk3O
	8fpvkytoOm3ABn3CheyMMc/IVcW3JbdUmCebE69Y=
X-Gm-Gg: AR+sD12jlbX/bxxINRnSKkNn/fgIgSXlKli/otQ9ymBR2SBTnlXpclQFGjkvnlVwyky
	F6zkDJCgOM7bc8wmlHG4ajz+MDO+JzsAFVh0Fn3SgmD6NxOjlyOjrCUS/Yyp1vd7jqi3Du/adeJ
	VwtSHVv2jJQ51XBD+hRxKYQVfrhM1JHUlvOrxkCs16Uu8xpsB8S3roD6UKDbmdEegLGlaCf5sE9
	iI/atGfC+fapp6leZpkPnATkfyocMYxKLtlBXagtD14qCx1Uwy3KrhrVL6fM/ZOzHAz2oHyJNhK
	+o213CZBbHNJr7R8puMXACxazWKJsWpJZ1nXCz892hkFhTAkpUVZn9+W1BlkIJ4/tHAyzu93ZFQ
	Dsw==
X-Received: by 2002:a05:600c:3f12:b0:499:7a4f:d13d with SMTP id
 5b1f17b1804b1-499aa199777mr77339065e9.4.1787141738948; Wed, 19 Aug 2026
 05:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724025322.2341205-1-sammiee5311@gmail.com> <CANLsYkz+h6ONmvhgdfGLNu21J+LrMSySFw9sxRcR4ZxLwPfbsg@mail.gmail.com>
In-Reply-To: <CANLsYkz+h6ONmvhgdfGLNu21J+LrMSySFw9sxRcR4ZxLwPfbsg@mail.gmail.com>
From: HyeongJun An <sammiee5311@gmail.com>
Date: Wed, 19 Aug 2026 21:15:27 +0900
X-Gm-Features: AcwNN1UpRanTlUxzoBhHyJNzchxXX5y3Agcm4VcHLo9-bTKNg0iBcNni_1ps50w
Message-ID: <CAJciObG2OahhKz+t9pbA1yCHz4pFQLK6EKmZMwY2zxqD33SgQg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: elf_loader: bound the section header table
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for taking a look!

On Wed, Aug 19, 2026 at 1:42 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On Thu, 23 Jul 2026 at 20:53, HyeongJun An <sammiee5311@gmail.com> wrote:
> > +       /* find_table() reads the header at shstrndx even with no sections */
>
> Right, but if there is no sections, @shnum in find_tables is 0 and not
> arm is done.

The loop is skipped, but there is one load before it:

  :266  name_table_shdr = shdr + (shstrndx * elf_shdr_get_size);
  :268  name_table = elf_data + elf_shdr_get_sh_offset(class, name_table_shdr);
  :270  for (i = 0; i < shnum; i++, shdr += elf_shdr_get_size) {

:268 reads sh_offset out of the header at index shstrndx, before shnum is
tested at :270.  Both callers, :336 and :380, reach find_table() without
checking shnum.  The value is unused when shnum is 0, so it is a 4 or 8
byte read past the buffer and nothing worse.

> > +       shend = size_add(size_mul(elf_shdr_get_size, (size_t)shstrndx + 1), shoff);
>
> Why the shstrndx + 1?

To hold the header at index shstrndx the table needs shstrndx + 1 entries.
It is keyed on shstrndx and not shnum because nothing here requires
e_shstrndx < e_shnum.

> Also, there is no point in doing this check if @shnum is 0.  Please
> move this block in the "if (shnum)".

The check it replaces, :95, sits outside any shnum test today, so moving
it in loses what master already has.

If you want it inside, the way there is to drop the read:

if (!shnum)
return NULL;

at the top of find_table().  The loop already falls through to return NULL
at :313, so it changes nothing today, and the bound can then go inside
"if (shnum)".

I am happy to do either.  Let me know which you would prefer for v2.

Thanks a lot!
