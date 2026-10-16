Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E84AA013
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156273; cv=none; b=b6rm+vg44wzo5ZlGrjuMNaA8Ik3fQ7ipu85RTUxn5zQVQBAGUzoJVo3HN3xFU5YNjL3K7cyXuIHQZckky1+zzNqTMsCJ05pHWYqX/Vxqc91HzHeLpydq0Et5Atfv8d9gnCFmpMSP5jxeUymEm6+5/e21BZD5Oh5dPTQ4+eMB/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156273; c=relaxed/simple;
	bh=BBsIr0ceDH3+48Wp3B6AC6dZfwGfRQvuUXtgjeRw0mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlKAWiqdE3RgnW8LS+C0U77alOsImDbDP40MNFIh7rM7xSAcms5SWjqKSl7qb4c7LtA7Tnt4o9sOUKjKjrJXOr+FwhWdjfKIMLKLzzcwBK1qZXFyX4/2NLmv/8wXcVqS5uwDqq0C+ldpiWEaifB9yDoWpN/FEMG+uVooU05CuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za3Uv6Uc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za3Uv6Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B54E1F000C7
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792156272;
	bh=BBsIr0ceDH3+48Wp3B6AC6dZfwGfRQvuUXtgjeRw0mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Za3Uv6UcKLj0XRYXFTQq/4RqqDGfPiu1h3/6xmB5lFnc4g4vTmcWi2s6G7Fffm2n1
	 3x/l4xMR/8JJKu4IDtR0bBvJSpYcbpCRHsgcreuqMul/wlgiCP+dJwcGOEfV66/g7k
	 GaiZxmnD/LxJFEcex14X0fnSFoBmizamkfMPSCji+F+0fNVnu8qqzQ0xerQ3CzoG/q
	 DvsH/ZyOPqEFWhFS4oHLM2LfidVvfpV7C4RXw6Ty58LRtFl6TufKZM8KyKjSoM68l+
	 cgPHx/+fiJjeFwUYUQ8tuCAT30CuXTHMHfRuDnJQiqLU74izGkikfGDx3+bE1acfKB
	 fUo3wCyontNFQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bccc73eea4so1083603e87.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:11:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxbqB3gg7EnO22pbH8PkA2a/ppe+yhGAXnmJ84ixIpTZLAkdlon5O+1gDtbGwIRfJC7PegIL9Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKs5aE2Y79feZnbFNIRGuanY/ep+dtUWtCmshpmfBQKEjhRV+8K
	e1viPX6RHQFayJ90x6vigOZ4f9wijJL/oxl5ez7ksJBEr9IP+/IdefgE/s99G2tRzYhi1KP349N
	03iF4NPg+UNJnJcgcnaNwx2CNNpJZMGU=
X-Received: by 2002:a05:6512:3c96:b0:5ba:445b:4b8d with SMTP id
 2adb3069b0e04-5be475afe8emr1060502e87.4.1792156271003; Fri, 16 Oct 2026
 06:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-gpio-shared-fwnode-lookup-v4-0-2253ad645fd6@oss.qualcomm.com>
 <20261014-gpio-shared-fwnode-lookup-v4-2-2253ad645fd6@oss.qualcomm.com>
In-Reply-To: <20261014-gpio-shared-fwnode-lookup-v4-2-2253ad645fd6@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 15:10:55 +0200
X-Gmail-Original-Message-ID: <CAD++jL=PmXA=6wNKB5+knFgESPO8w9+dbx53zQhLaTJLfMzn3g@mail.gmail.com>
X-Gm-Features: AclHuK_nqW6_dALNF0pMMcEXNEFSryLqZA472GtOh4iREDgY7eMxeRYQs5SCHGI
Message-ID: <CAD++jL=PmXA=6wNKB5+knFgESPO8w9+dbx53zQhLaTJLfMzn3g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] gpio: shared: gracefully handle no-device lookup
 of shared GPIOs
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:38=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> We use platform lookup tables for shared GPIOs. This mechanism needs a
> struct device to work so fwnode-based lookup with no device associated
> currently causes a NULL-pointer deference.
>
> Adding this functionality will require a larger rework and it has never
> worked anyway so add a check that allows the kernel to gracefully handle
> this situation with an error ahead of implementing that functionality as
> a new feature.
>
> Cc: stable@vger.kernel.org
> Reported-by: Abel Vesa <abelvesa@kernel.org>
> Fixes: a060b8c511ab ("gpiolib: implement low-level, shared GPIO support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
