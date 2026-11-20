Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795191269;
	b=TGzxf/Acro2NcXr6dAI73LJ+IGkVvWsm/dIygX1Tmq/jqdhJr11xBExaACZ4LHCKk4Np
	 VmiI0kPlY4nSlprX8zE+Dh4ngyGNgLhGWdeCJcLNlmb9Mtr19gHGJXkHbkgDTVUsu85fk
	 BURJlH4TBbQqf4Pr/7i87K4nl3vzEBA5CSqHkAnRw17tpOQ6TUpg9pfFm2LidMai5qcf4
	 dknDaaX9lr09gBuQi3N02F9ArTi95EtbIOyXPuIziIadFEt1o2yLfmrsIsEoKXsKy1vf0
	 vhmAsAVrqb2kURpJbicPS90C9PwCF9eHVPbzM9sbeRSOmtxbKlSs2u7UsfAhuUv8ANw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tPQFXsNAl/wRSW6m8naA81pYvhglw9HtAzNX8HCIivQ=;
	b=RURZAT8MvKzIK9wSwlejagGcWxC7r9sfK9rru+HqHW38nqrtw/ee5XrW0Gs+r0QqbpOf
	 K8nGh1nJdCXGd+JnCYuGNazLED4qaIOlMWO6hgcoppSc1zDXOr7nZlTBc4WmE8JA05Hhg
	 fcIOJeQd0dWhFVF+gNEq+o+5eHM4ioEfLOWNZ50Cmh3UO9dhAj1qG7uB+/D4LfPk3k6nu
	 qsohnZf+QDfBv8rIKzCY9nDXaXHDTwF9ftDEZ5Y8S3gKpIVL4fmZUZGyZThVabjxK2Uxw
	 kQUTrHgJEWJLL3dDU/M7vrzBgdSdQpkdyhyRh1ALVNlWGWAqIb/ogPOb56TVemhPsPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RS8Pkspa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FD606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377FD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RS8Pkspa
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4716d76fso99780e87.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:14:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795191267; cv=none;
        d=google.com; s=arc-20260327;
        b=SXV1oepv2bhhrvTRdfzKQGLejULyhhJuh6u23B8yWkV9fBlr0+CRkCioMATe/vii1O
         73i0AI+ZujvDJo1sZqonrjY/jf0Yk5BADHW8DYhnM/HU4MSXuDhnP0sJkPt7xtVeIi7r
         /zZdvv/ANe1z3RbIlUMaog+WSM0fyNo8kW4dDrEDjU1q5NVqynBza1aA8BYp3kGvg22n
         SwnFsYs2v/nv8dLb1gDEW8PmEdV48q3IflHsyqc3rPVDQtw/9OeibTV2jCxUQ6K/CA3a
         u1TM9nDRCgCYSf3bmQ9vGsoYVKgLMYPi4lTlSRWritmptvDbauIUquFFUufS2MjeZio4
         THnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tPQFXsNAl/wRSW6m8naA81pYvhglw9HtAzNX8HCIivQ=;
        fh=jKxyZBYeSJWeuhEuheMdmQv8xYnYlbNyinp+uQAaD7g=;
        b=BpXDEwFQMPoIYtynKW+FZIgPRGiuuje6QnFofGDxCu7wfD+Hovt/B6iFozOsuizQ9u
         V9gwthETdfu7UmwBKM5OY6fJ+c4TEJ3Ls8rhNuWmKhZYVWaGpK8KZ0hoYvucuYLYLyqV
         Jimpyt0fsjLJrUhvp0UJG4+rf9ohQuHdkvu45f62ssE5iK0hvjwEINxv3HEYqlc984O1
         qH2Si9tDlydHzKifHURoHj+dBRf/ReQqHOqZSZIEDsWd690DPyTypcKqluWakadXh1MP
         TL0wBYfL6Q9hoCRM2KkGC4Lo02A3lkD9y2hTi9Acwd+03GdIeKbKIHceTtK8oTsBsJQU
         zmPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795191267; x=1795796067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tPQFXsNAl/wRSW6m8naA81pYvhglw9HtAzNX8HCIivQ=;
        b=RS8PkspaLz2T6ONibWCHr97w8oZlsBvYo62Doi04AwI6TVzDibPpu7diFiFEJQD+/K
         UagsgbdewCtdRKwJTP8IZat4Fci0cALimd/DNeGzKU4rEfqatgn2SgDODj6em0zXb6tu
         PR/9MCisUvQzcbGbxpHesFmTdojKZksyAMLAcU4jU0XGuRNpnmoYTPa4zhh95OQZMVvt
         WZNoTFQli+1/gnU7DTstBcnXQjsAiYJmmJ5OKvLAXEdsqJA6vUBImswGt5JqtbfICBGq
         KIbStl63j6CtxAgM9G1SrLqCzLpxF1Yos5uQtOMBukJJjk4T3gJYPPmtcLZuQQB40rFM
         g/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191267; x=1795796067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPQFXsNAl/wRSW6m8naA81pYvhglw9HtAzNX8HCIivQ=;
        b=KEaXUK5bX86DdQasUl/dgxt+bQIDzxa5k0XJ229Oeb+RGFECNTFU0NE/QOQZtH3Nis
         dxABQ0tWa46erGDrRbXXATjGeZ4NXuX0jXwE2YKv5Fv76eLlawb0LgoprSXybVWCwCdM
         JB0Ll5KRz5CZV2r8nD4y6g4IH+VGG3ShZtj+kkdeKpCz5UvpfzPWdm+tBa/7jfK8V9LI
         anmg8E9PfPXkh7xGVThliw0BTf333jVOp3DN85mr4zb9AJyt9T/pXnJFbQTUapI1VDpP
         PvWQ3UDwTno2Vw8CPD7zui2y41D69RslacUYLBG0V8C/aaq2OGpjVHbKPorlZYAI/lDD
         BO5w==
X-Forwarded-Encrypted: i=1; AL+hErHH+Y8rRgFcDGLZyz/xw9ulIAC9/SC/8ZkoQJRATtClB7lyW6SHkA8prT6QOye5VdkiJRuy+68=@vger.kernel.org
X-Gm-Message-State: APuU4Z8K957uwd+HVhMBNrXgPP5hSzaO/Tf1WHuxjQ/j5tWo5AY7iehl
	98SqneNdqk8+vOzVj0+YdMdA+9PZQLmRXxpQTGLL3umiRprLcPprn93n7D43uifqIP8nu8zEFk1
	15ViBTJ5ZXrYkHjRerdcmkRdwK7L3Dnc=
X-Gm-Gg: AZFdTZes9t+Bu1Mx2nDo35zR+7cbLCJT4H9UPsg/iXKRUPCnGUtkTZa/KWQ/UfpNHd0
	+a9UIKocKm1bBOnEqoHGpaNIabSbxfig8PAgM8SVAVOpZPdv2NxFoqbK8tDQJjLLWQTrgUX6sL5
	ImNWy3dknudvbjNocx+e+UzfPbwEbf5bIO4qNvkPZp8+4jC6i/DMh5RrUiepcqNEPwvdssQp0I3
	EW4e86bnIcJY6v5k1dPw8B4RIy+lq2QWU2OeCWhZijKJ9d6XULWuS8ZComiDrJHGjTvp8EJQi/e
	vSmP/jy3N4eK/7//8SOb+tUiGsSQJi1QCsFGmzwVUaY8KILyliF9IDkvgrUDaDT7veJ5uY5GRAf
	pfXCoVW2NziV3R1ugE6AxWlxTM7FMVFgCcb1eW5NUMV2PbVjkt9ENG9U7PZh5lLSnKIVMFXCfMS
	PoPBGnE1oY6LyuLO5k6Gh/SkCYZkeTktlZ5Ygw5MvNtAeyXPmec2RNESpuLL5oDXG/Tr2rVgXT5
	/rhcEFr2fLhpYf7P9hnbOYkvyfoGjKMo34wZamc7ywLwrYjMlEPioU8F3x0D5zT9x0xl578QXzx
	EACPJVfJ14kJLn19zPd3
X-Received: by 2002:a05:6512:4382:b0:5c1:57ce:d4b4 with SMTP id
 2adb3069b0e04-5c1bc75212cmr1017879e87.2.1795191267195; Fri, 20 Nov 2026
 08:14:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026111814-mushroom-shelving-5b17@gregkh>
In-Reply-To: <2026111814-mushroom-shelving-5b17@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 17:14:15 +0100
X-Gm-Features: Aa3M54oJzVdfpA8BR7yKDmtpV6PC20lqPsTZhupV33qCy1LIIznuI44wcp864JM
Message-ID: <CANiq72mXHMJv8sbkJZSjsexQunEkz9=SDhXytXXZZNcJXfJ2dg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: bindings: derive Zeroable for
 bindgen's opaque array" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: sashal@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	nathan@kernel.org, ojeda@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 12:13=E2=80=AFPM <gregkh@linuxfoundation.org> wrote=
:
>
> The patch below does not apply to the 6.18-stable tree.

I think we can wait on this one until something happens to start
needing it (i.e. another backport).

Otherwise, if we want it, we probably would want to replace the
`derive` with an `unsafe impl` manually (unless we bite the bullet and
backport `syn` or similar).

Cheers,
Miguel
