Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF1469826
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978884; cv=none; b=XFbZaFnORv+emknAEacWN20pbxPd8UVWAPoPA3qzbmS4qTeEeT9I3rN06ggOjFYbnNlxCkvBc1fsDl0rHN/QpWV4Kgv/kXly4VMdjBTaoti4iJ4F6IVa9OItr1FJPTrCuSPe33A2s88OFinxDCSqXWojHkiVAkLj8pmzdbDNAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978884; c=relaxed/simple;
	bh=k91PCIsglX/avMYZM2GBWQRyBGhUYLSyCoq0L6rUfNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSUQRJMlNCOeZ0yyqIxXdh1PbbukiyLS3bdFoI1hnbFfuMzn2ZX8C3lXFh0fINq//nzkurmX4Hv4qYOGWkTUJyqNEf4XHNR8YuDn3aK8vVjm70lzM0y5mam7Mq66dYP1zUybKqOfwktefuDbE0p++MtPHX7oQXkkjVcO+4thrio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsmMVYic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsmMVYic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8061F000FF
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 22:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790978880;
	bh=k91PCIsglX/avMYZM2GBWQRyBGhUYLSyCoq0L6rUfNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RsmMVYicIlHlTc4ngTMunR+mU3efUrVIA5XDNiS4xLqeFxT97p/zbkohjKyXZB245
	 QBSG6XNGfev5vJljO+4xi8jDYDuJ3vH0TpCsRrP9YmUXamfWlB2SSIazaInhzD5+Ia
	 4FhkWRHg/at1cLUHzqnpsdHxqJnN3fxiJmEn472X6utJOE4t3cNwxzvw3EQmGQg3YS
	 3yq/2Eg8o9FH4W2VHPait5ba07DYWncZHT5Ii5cR1CTDAWBVkbQJiLrT3XL9g5apbv
	 OPij5DwJgqTph+gTJNcC9mxEpcsJP9kJ5Jjeopjf6VlJIu56hi32s3eLq5/Bl8RCHC
	 hLuuthQKrXSyg==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a77da28307so3166281fa.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 15:08:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwj5sKVCSmDNCPkUtXk8am57sUc7VmkkWgySI61FmmJh4zYquyAxDNH30pEAd4EnUvMG3OTzPA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIb4Fll7eZTq1KC87aNQ9+fx4DfsNU8CpQ6Uzf68DApopln4D4x
	XZ91QVD4kxTNPjx9t3XouRhcJ87Up/voHtYIoIROF2tVvi5NLh75tEYsV1FlMyUyyzLjakn+Gst
	+XfFM/pOrbxLCCHguDhTMs7ICwn8KKT0=
X-Received: by 2002:a05:6512:3052:b0:5ba:3df8:5dbc with SMTP id
 2adb3069b0e04-5bb9bafb278mr1353833e87.20.1790978879599; Fri, 02 Oct 2026
 15:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 3 Oct 2026 00:07:47 +0200
X-Gmail-Original-Message-ID: <CAD++jL=AY+LT_8+0XGv2FnzFyr9AdECbbOpezut09iXy_C8yyg@mail.gmail.com>
X-Gm-Features: AclHuK_r7ghda-WxvEHsugy6kptVq1vsr0S6qzOmcTDK5YtYQ0iK245OYyu1SDY
Message-ID: <CAD++jL=AY+LT_8+0XGv2FnzFyr9AdECbbOpezut09iXy_C8yyg@mail.gmail.com>
Subject: Re: [PATCH 00/15] power: supply: Fix AB8500 and AB8505 charging
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Wed, Sep 16, 2026 at 8:49=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:

> This series first fix two serious bugs in the AB8500/AB8505 charging
> code making the charging report bad figures. (It only affects the
> human-visible status, the charging itself is safe.) These two patches
> are tagged for stable.

Sorry for hammering, but can these be applied?

Yours,
Linus Walleij
