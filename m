Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDE4CEE4E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579192; cv=none; b=JoHGnsVYYX45QvuT6t0ibx4Ho5pM0U5o2CA+e7t0S8PWAfQYAbI3J9hG6G4Ob0KrTzly73Xasj8XNUdWL7zwf1VfnevZxblgLZZSr9FpfmRcJK7nYNqBtVmpJ61wyi2CcuGSwMFZwEV52wUO+S1fy5U1oLs8VpNfGMBa3XMiqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579192; c=relaxed/simple;
	bh=GvpDqPtcVDHmIGNRN5Cwdl96zxBMwJm//wszUGDWEyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzDrh/+4FDFOuVO6A37W1vdo2LGR8UwcR/+ww1YI+NoGePhvOEzpyGa844xCOimP/eJaJNTlYDXPY5WZWgH9g5Fa2ry9o1rKJmmevEDHJX6AUsMMF2CtKfDWHyxZ9sEJazSmuu9g+8nFbWLWEjTmvGrtPowMYK+rVROOOGMQPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoJeGhwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoJeGhwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980981F00899
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789579189;
	bh=GvpDqPtcVDHmIGNRN5Cwdl96zxBMwJm//wszUGDWEyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UoJeGhwPyLW8ilCTa6I+PhjeWrHSN2Q49sMY1cb2yvVyBm48OIxmEr+3pNizbM9HR
	 KZ2HcdqhA8GwzgeVhykmzvBdvqkCWZlVMhQx8Fk0K6ZYTgpiX7bVpw6c9WxbY2Q4tP
	 vuTO5kH1hYhqq3ycpDvHsjNvnePStrU1wPMe/qPkF8THXf4VZRpAklw/Zs9J2ljoTj
	 muwXBbm33JRjDsM7wjxzvPrffatvwAxi2tNORvSuaQtDvVobNj9FjyFjL8T8dgd6p5
	 OfmTLfC7/u+jTpq5MRqWsNOq9fH2UEOSHVkg1xYClXQtsi4lrUEmKbfbbMU/6yj20e
	 CdNVnepyCtiNA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso1342569e87.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:19:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/Yr8lych5RITjGkqXxJoeYGy0hCOLA1AuRdshI2PHcYRu+0Yqn0JZaHKJE0146Xua7Y4VY58=@vger.kernel.org
X-Gm-Message-State: AFuF++kDRcg/HIli7DtdHxCtsTdWDtSXBUf92ZVk8yATa+dCBC9f6RT3
	70rviBsZbBRa8munT8aDDG0dWYDu5G4gE5XOHtgUUjNK0koA5ZHLhp3jW2fFLXqwf3mPOXaehIq
	DEyCd/NNvLXW3v1IuyjjKG4P7+HAba/A=
X-Received: by 2002:a05:6512:2388:b0:5b5:e7a8:9b1d with SMTP id
 2adb3069b0e04-5b8b6625ba5mr1991668e87.13.1789579188303; Wed, 16 Sep 2026
 10:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913040312.21966-1-mhun512@gmail.com>
In-Reply-To: <20260913040312.21966-1-mhun512@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:19:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLn=6K7EZLuXnP7vcNe2s1TpNF+gVCnGqh2e0AnPeB=r+A@mail.gmail.com>
X-Gm-Features: AcwNN1VsVf0Ab2PJqc6NKhxiLm0epWqyyaiftJvVfZNznCffNKfZ2aSXL8uXvug
Message-ID: <CAD++jLn=6K7EZLuXnP7vcNe2s1TpNF+gVCnGqh2e0AnPeB=r+A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: single: free the IRQ on domain creation failure
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 6:03=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> w=
rote:

> pcs_irq_init_chained_handler() requests a shared IRQ on affected SoCs, bu=
t
> its domain creation failure path only removes a chained handler. That doe=
s
> not release the action installed by request_irq(). The probe can continue
> without interrupt support while leaving the shared IRQ action registered.
>
> Use pcs_irq_free() to undo the appropriate type of handler registration.
> At this point pcs->domain is NULL, so the helper only releases the parent
> IRQ handler. Then mark the IRQ invalid, as the other initialization error
> paths already do, to prevent another release from a later probe unwind or
> remove.
>
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
>
> Fixes: 3e6cee1786a1 ("pinctrl: single: Add support for wake-up interrupts=
")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
