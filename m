Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347863A9D95
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950255; cv=pass; b=MYAOgksN2ZGNqj2AP0lhnJj0IrzbzrETJNTeS7UkbW5pyM6gt/ZAB+dhkfMRj9tBKSS2c5BzQ1NjvDFl9jBM681ODjR01fCQXCaptC6vtKwihzmLcJJbyJs5v3lOMgn3LWRJhdKWxQ2jMb0/uJ+49XEno6seveqkvHF0jsnJlT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950255; c=relaxed/simple;
	bh=DZ/xG6lf3TV658IbkqgJtug/TnD1W4FxX/TVgttLamo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9tirmlN4JOTOr1c8r1EVghyXxWb+nO6yj9doJUt2EIvKlG0nR1ARxwQAtqWDS295qI/VC/xmFoMoi+dQrIzj7JHp7NV8pnBlyMmc1lVOr6pdpUEjHja3hdeygDLWIdXuXSzldtwW63YIC5JlJL8OR+Wlm6U6n7SJwxSnLrw6oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5FgN2ZF; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5FgN2ZF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499add6348fso3495e9.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 13:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787950252; cv=none;
        d=google.com; s=arc-20260327;
        b=XQdhXMwtd4L2pL6DolVoEYxZ/hQ/3Aoav2CgVHkC9d+QdXnU4fbJyXoeo/CQc/UOKt
         hV92whFCfStnMdd14YR3VLuLzxfKa6byeBs+AYbaX/BuLv+MViefk+IFD6J6kg850B6O
         sgbj1XvAWBJC+UEcccABlQd7Z7JZx388zUCrMoXhFQPSoY2rTvyEQiAyJkFsFjPqVg4f
         9+rilXh+opb3OxSOzXNc5Hh+8ml440im4Jf7Z9lHlvn5MVorpiEeGdzJJIZQuZLjhbCY
         IkIZl5+hJSLSVZ2poydPBxncgb+YnhitW2KVjKuTHDrWPYiGN+KEzM1yD0GaYkA9BPI1
         FPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jz/R80xhYUJ0EJWe3D+HLAqSfz1N+6Poi2/4tJO2Abk=;
        fh=lCWBu5cmvsWvPy6A252a7FiefbMCswgJwduiqNN60zM=;
        b=HP+3PdXlHd16SnLpBWpWinWY9mZoSdrXfluDBSW7zTukP1buHw/DO8ql6xxqUslPEn
         lk1qTTPOChGM11qqpp/Cle3TMJdBryygMPEG2yxYM9i5BoSta7+z3xYPO671VKqliEcA
         8sUZpMGyr8sMnomhreXDIQneeRVSyrZx3H8DFtsZTtxMNQ18tWHtLvqrWSSWzTYkxdWA
         32wy89yifP/vAXRo3QHJPWoqkgPQWCjGbWDScW7CfZ8nuTZY0BXuGgGdPxBd0jJYp4gR
         5yYxGfV4SHERxJcmBtIWJfLmyM84kjID8ZtD0+/5iybZrK4ExHvi5myvc3wbySyzjO4O
         pStA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787950252; x=1788555052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jz/R80xhYUJ0EJWe3D+HLAqSfz1N+6Poi2/4tJO2Abk=;
        b=K5FgN2ZF2IpARdAysxe01Wtyir8mjqtk24I6HqJ7qVdzCjGbSZ7D7td6OyqOEbjNh+
         K57J23FYqYzbmMdXabhUIlk7KqHvAk7Adev+dazBNLHaOjkuFRnKZVVquc2GvvUhTS2G
         DyehNFWg/m58HvTFQIbkwpJxm96M6MaJwLw+YOfBkpY4NPgWhtzHHUiuNgEqDmP67TDA
         1n58PpHF7wd9/Du3js2arWicSeGrH7r2Wo88nr6lKMnWw44sXPAslip+zR2hCPEYK9HP
         LZ/RNnt1MQW9orFKodVP8g/YnJH1yuZoIUYCeF8DLjVaB9mY+xOVG1pbrY6QKuZHhZQr
         a/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787950252; x=1788555052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jz/R80xhYUJ0EJWe3D+HLAqSfz1N+6Poi2/4tJO2Abk=;
        b=LQ+SK6wQbhALaiLy/tZ6rsNbgJIPddAOFiLumK6kqW/rT3NAHFfhTHE16IRpjIi8Ma
         g+dsKdzFddHmfLVnX22LPJOZ/2//X6tQXN6RTkp2+0Hu85D0IRCF+LzN3sccqTyJqHyV
         Mh3nA/xxalIIa6tH4p6b3arpD5qyZAOyeMDpicvRMj1AtvHZ3W3CUepkZnQPDugA6QNG
         dsnzM+aOMcutdm04UFQYuqOyAECwKYNxiHvgGAI1H+5Iof49EP2mlS3aSpX+Ey03+6wg
         7BmttDlPG7EJchFuepPU4MDpGhsbfAsmCumDmEJDUqMBl/Ua/Su5hTM8gbMbE4hg71C1
         2l7g==
X-Forwarded-Encrypted: i=1; AHgh+RrfG9N6xRNeUcpBYnyxschz/vOfUeAJLFWq8O1zQn1lQgih7uWmRN9ra4slCmPAPgMttOEy/vI=@vger.kernel.org
X-Gm-Message-State: AFuF++lJZHXw0UjHjmuwF6RBJzF9qnZ7oy27hUImjTF5sXLt9iR2NZIy
	E8S9BFGKMnBwyRicyaHJaGL++kvNp6FwZRZe5TvjlR2stu5kmc04bXSEESzAO1gdsZe21dgJGF+
	RYHZa2zdZA7pvlDa7usf28aLkHa4LtdHT4ABcGS8U
X-Gm-Gg: AR+sD13L4KtweLyFOxrk8ET3PMBrMOr73f9R+dK8AH9K9ATpqXKTCry4RMcAEUO1Yfu
	LQdD2XHCOw4EI3sgIVipcH7QkWSetZ6fvSNyu+t9o+eJ5/jCZzolOyFVyeZ9OYlkEZ17ZJO7mLH
	I62RzzxaZ6pFS6PveHPSS0GDktfXu/T1c8Lb3vwabiDAPkphTBfSM7HVT7WRVkTKU+xXPoe5Rla
	ZTKfoSrprIUbZpzh2907yInBe7hNV+MSZpQcOEHFVwh5riWlBhsl3Pd8wUsi29gyi/gcJ26l/Nw
	JdJn6nFIdb0YuA4lHgixsZ8Qul7Rm7EKiuwjh7yeTQ==
X-Received: by 2002:a05:600c:21ce:b0:499:c3da:6f40 with SMTP id
 5b1f17b1804b1-49ccbb10d13mr260135e9.4.1787950251892; Fri, 28 Aug 2026
 13:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
 <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com> <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
In-Reply-To: <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 28 Aug 2026 13:50:14 -0700
X-Gm-Features: AcwNN1VOtvX9Y95_BvBjuOVh8z76AnKrtJFeJUv6jycw2oA0qmipRhZ22a1HmKs
Message-ID: <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Yo'av Moshe" <linux@yoavmoshe.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 1:19=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The 8B alignment seems to be a requirement of fncopy() for 32b ARM.
> But functions in ARM can have 4B or even 2B alignment w/ Thumb, I
> think.
>
> Doing such an override would add unnecessary padding for each use of
> SYM_TYPED_FUNC_START where probably none of them have this fncopy()
> constraint.
>
> ```
>     #ifdef CONFIG_CFI
>
>     #define SYM_TYPED_START_ALIGNED(name, linkage, align)        \
>         linkage(name) ASM_NL                    \
>         .balign align ASM_NL                    \
>         .fill (align) - 4, 1, 0 ASM_NL                \
>         __CFI_TYPE(name) ASM_NL                    \
>         name:
>
>     #else /* CONFIG_CFI */
>
>     #define SYM_TYPED_START_ALIGNED(name, linkage, align)        \
>         SYM_START(name, linkage, .balign align)
>
>     #endif /* CONFIG_CFI */
>     #define SYM_TYPED_FUNC_START_ALIGNED(name, align)        \
>         SYM_TYPED_START_ALIGNED(name, SYM_L_GLOBAL, align)
> ```
> then this driver could do
> ```
> // fncopy needs 8B alignment; see arch/arm/include/asm/fncpy.h.
> SYM_TYPED_FUNC_START_ALIGNED(imx6_suspend, 8)

Looks reasonable, but this still feels ARM-specific to me. How about
adding the macro to arch/arm/include/asm/linkage.h unless you have
other users in mind?

Sami
