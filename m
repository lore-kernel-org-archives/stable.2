Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE274749CE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743474; cv=pass; b=Wk45S5CnkSshLJ2HXL9dlxM3LjMJ9RN08JL+5UKq+n+BypNP5AFJeR3a5oPr3/ipSbv9I0zCjBwkCwLv54yAVOuUpBDtEsEsLqKJEdFAQnvOPMU+UWYknL7RW9nKrSjhGchWftoe4mA74xjifDYqhK/tyhv0U1qKRSNJNYx/FXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743474; c=relaxed/simple;
	bh=+5ssgy8v1nToduf2dudMHLP7F3zMv+EGGsLhk51SR5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDcfOYPcIQqukN9dGzBEUAL4rK3mDdhzI1KnoSwK7/HjIauG1VSMaXq3Vhw0PV7Qj2o3WjNZvdkr+SYdc/u8/g212ny5DKF+sj8sx5EJ8tPGLV9GTfXp8ysLz6cMRapwjL67FF/HW0xdNnY1BXwaMLg0GkIwBdayb+D2qZ5X8ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/1O2cZz; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/1O2cZz"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10ed63c0so4521cf.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784743471; cv=none;
        d=google.com; s=arc-20260327;
        b=cAXE703jbYtLI6KIQRMO82yegEC0VzefN5FZojybJPm7fA6yjqDv8OD3PS9fPTeCNn
         eko7VzSkZJBIdMqGgaIwYmAkDKA4NU7+LELTBP8er8p2EV26i0wUyYm9pN09hO/RU+II
         +OKCcVnUjrJyUGoeOfLTvbmBV8MuSfxZsfJcyj1+vpMeNKL+zp6sHvU+k7zVnnlSI21f
         35vl7wM4bUvWXy9eS2t+RsrY7pzDXuuL82WgtasrQJ4gGdX6FrRi9yLch9jUsBLQ0ADa
         0mznHMLk8jkMDtXOlUq+S275FneaY4hEhvsB+C/L2qVViaJ/ogUgwKp2v18fSz+FKbS5
         Qztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+5ssgy8v1nToduf2dudMHLP7F3zMv+EGGsLhk51SR5k=;
        fh=yWnq6FLhkmSJM8Hf1EcFJAiYS8EHn97mUxBOB9UzZVk=;
        b=SSr4mwJWpQ1fotiEGPYfdxfBWxRATQwVJZYACYZzeE+QqaaMHgwReRafmTBCJ2Vb2Z
         gt3MXL+nqKIgf2I7z/16NSy+nmdgJ7L3Iv/79ncGv9j8+jNKWEe8tHQug6uOARCNsoMN
         0/L4CRBZUFWToelwvg43915sUQtBdYtu+lTR6ESCw8nNtTEjxtPciZc7+Zf0qfuzU1jB
         KBfUAIT/O5ycsBGDdRvzRN95PrwDovC6UUYtu8I9bGNdAIPlJmV2L5nQDgoeaeZ2Ki0U
         z0bTR2GkctRGDqyuU4zYh8/GwEQbdeV4JctPi7ETn54DEQlRClme8wkFiJgZPjOZ6cyG
         sCvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784743471; x=1785348271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5ssgy8v1nToduf2dudMHLP7F3zMv+EGGsLhk51SR5k=;
        b=G/1O2cZzAFW83GtG6zjIPQRCQoC9B9WWux0eK3ec4rEclBI6r8Ixce+cRl7vZZV+vn
         A5opXa+Kid1IX7pygWMfuYQvHfERezYvrFMbFcxKfHitMsoz/tzsy1smfMgU6WLmd+u+
         BTaNOYjA8zA3lNohZUEHbsTcfXxtjAQMbCu+yo8L9B/OktCTZvMTc15nfbfytlEXQnth
         eetUbd95sVPEukA5PG1N+1j2696YTTVdURIWoPv4rovWHcTYJ3aayEJtsS5wkJf+B9rH
         l97Y9DgpAlcn+ObAec32yH2TG1yV0utWbJXCzAVJuD+qWqQy1fVUznr8c62f/RbNgpLq
         tYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743471; x=1785348271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5ssgy8v1nToduf2dudMHLP7F3zMv+EGGsLhk51SR5k=;
        b=tKWYm2fmmUHLzERncQHO/ZAzbc5g6jZqCY7bS1UaOCAKkrMIS4YXS48NT8SxQM9IVC
         BeQZgMdWuubHgSpw/M7ELoEAcckA/9E+j/rZY5YHWCjIrW0nS7G/8xUL0lTDTBmIrdwT
         vWebF0NSyUZ/aBiO1c/Mc/Ma31vRyB9VEnQWrV+frNzxzCrQEakMc8WEzYqXR+ZEaTTo
         K0jBx7aqj79WbHqAZEU8nqsBR0AtTp2nc1262VrCwx9zwWbNppA+YgCn4+TOPaZYXOnS
         XYFBuCGsO0Nt9IPD3S9PY5I0myaDqZzJuyviTYa9jvWKdTye5eld4J3JAVNd1w4KnkLw
         fZKw==
X-Forwarded-Encrypted: i=1; AHgh+RqWi345mZnDHhw2n4JD194bB7rrEds0pygRKVdojsrqtWynSRgfS9Vv8iZqk/AswbHlNz7RQSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+zEiLgpieZq+cRXBBkilxZNBOT+LnvrnrL7AOfckVUQGBUC6F
	uLg2m0LefCbenRTFN/BYRd9LN8qTmo0f8uWJG2UMd3nrq3bDB2YmstBi8h4X8K4ewesOsUVdWnZ
	1yBPCq6pQFKyd1j5Bc6as4EgAYXi20ltC3fwlK2bkSEC1NgT+Vp6MYVx6
X-Gm-Gg: AR+sD129nEH9xkCK3Z+0f27BmJxSdN2QRxNVV1ED5xuVCdHl6FoOFOCCb72wojHO+Ld
	bmSFhNleM/CRBY3JrK1bzDn2smEJaEhZPYkCq9on3KZBGZ6ieBCConx1CxaJguhDdAkY+LVjdr7
	cUr87xaN8ABZAjyOfjHsMFmEXDlh0BESHBr8aYfBHHSZ9ho/zIJre1QdGobDtcsNTCkUxkzX398
	18X6m1s0iME+Hsgj7Bp5miDuH6/GfESapIKxU+qpgVNVn8wlQ30ix1INWs=
X-Received: by 2002:ac8:43cb:0:b0:51c:935d:8d74 with SMTP id
 d75a77b69052e-5283be3e9d4mr374341cf.9.1784743470255; Wed, 22 Jul 2026
 11:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com> <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com> <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com>
In-Reply-To: <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 22 Jul 2026 11:03:53 -0700
X-Gm-Features: AUfX_mwbxqkU-iAMaiWQ1yNey3EgrzgXznb4NhUQjYMjtNDBUtwxFYY_8mI2M90
Message-ID: <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:47=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> =
wrote:
>
> I think the issue might be a parameter mismatch: in C, the pointer is
> declared as taking a parameter `void (*)(void __iomem *)`, but in assembl=
y
> `imx6_suspend` has no parameters, so Clang generates two different hashes
> for them?

As long as the C prototype for the assembly function matches the
function pointer type, the hashes should also match. Can you dump the
hash prefix from the OCRAM and compare it to the disassembly of the
call site?

Sami
