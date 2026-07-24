Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF57643CE44
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908453; cv=pass; b=PknaJJMhGq+F8xtK9QfDASJXYrG/iR5XKliRSAiYoSCn+tNigZVVLK+QEF78399wV+9O20uMnMeXZ3qZ46vrvffi+1zM4D5KdkcFz6jHr+jFph4FUvt4M4YbgMFgWNM7a6kD+0srrMuJcNALuJ+u6hZKbHe9nmVYg0HfF44qS1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908453; c=relaxed/simple;
	bh=ENUPkRl79pEx0BA0+dcKj8PnBBniGh5LL6VfEya2P3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGl5Zjs+1zA2xHAzZZmfrVC2OBrI/TicMum6Rsn1VgcfVbk/3XJzivFEHLh3gAKKsUsPydLKKcl7NC53tex+cTOfdafkfRpHeWUOCtq69Acug6q2ztCMuRKjABANRpf4cCsqeJ9ZGf1p23SUKTVgn/GC8twH1feFXnKe/fyBZkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srbVl4Zz; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srbVl4Zz"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so229321cf.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 08:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784908449; cv=none;
        d=google.com; s=arc-20260327;
        b=HQg0BHtnO/u9h+KrgETUtHMAL+lVn2VntFaugF4yufEmwgGUdEaoY/YtYWW3TFKvkF
         0K0WfuLBJvWbppw0/BAnpKga2jRzhEdHriokv++SkfK6WX62nZHibyUfKAl0ygv0gGUO
         o2GhyB1n9ZKHd+HIp+CQVy40mRh+ahMTa4kxoJJETyWa3Q3/DW+iyDrqF3Xt/jM8Ku+0
         35jximkdCPYBa9ntMuC0iAYxfTVQOm5HvZKiVvnn3GlxehytE8FEzRuoh6+7XCChVBds
         63jSHz0yP6tMoKceupX04FDZ4FKPOWXQSBpBg4xv8rUctYT/g+3cfaeiKptwo38PWgT5
         Y/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RK+0ydkVq3QkQA31vNi6A6UpE/xnLiLeTaBJXi8dr9A=;
        fh=Q6aQDwJPpjFrW0mGgfiRcLpfKkBcoTlyU3BtJ01kVJ4=;
        b=fo8tN1jbx+/vLXl71KDdw0A3YSumWDvNzKS/fn8VxL7eTYGcWw36bWg46F954T1GoT
         urKlv85MuoeeRcJjKfijfUQl+vhrJ61I5Fer6YwHEPa0wxh3f49UpDVtl0yXT+ntSOa2
         QrTFkDgBrX4wK8VuWnZB7z9BUao1Dr17+nPrszFSblajDU313yf9hHHjCvJyYMNE2P/7
         mY0vyzu1JC0pKo8+5wBEwUjtl2eGajB5Z9BE3U53z2h5eJBFlO90hx74j4Hzucdc/Zfw
         25ITg93xMoYsieX+kd2lGMPuiun1x9vjtPD80QbfqULhgC9Q6nu5/tvV2CAbqOiZouDE
         0eXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784908449; x=1785513249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RK+0ydkVq3QkQA31vNi6A6UpE/xnLiLeTaBJXi8dr9A=;
        b=srbVl4ZzU/E1nxYtGqj+bGExVkKlixZCtzb41xrxpsG92JY7Do2LGeKQMMXYnt+vC+
         e+/7IwPzzpwcUKBZhA6ElBLuyYIMtpqlhxUtQ2c8qQ1AB+WcuJK+nSzV8VFos7mTPlIG
         TeDQ1LyDK9v5yOsIJnnk4t/aXjUGLU0w9kgVScYYKhtzQ0hBlV6PKVf1m7S9GNr/TwMh
         zsroybScP03w3WB1tccOcWAxB+kSfsIDVWGOsZi94CccY+bX97zWVXFGHpez1phGyUWS
         t/FPjrUdrnl/Oxk4Sojjv2XI+GsOD5BQuVJSj2ZndKfXnZcrqdPADnSFUPviUWpjLb1b
         zLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908449; x=1785513249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RK+0ydkVq3QkQA31vNi6A6UpE/xnLiLeTaBJXi8dr9A=;
        b=dDFjL5xi+R7IRXHgs0Ad0o5SNgYpZBElbIYewVbyD9NL2d7cuVOorzygtsGrxoqgw9
         0wS7N1dmBWt3VYYp5QP9P+Yt99VykAHG13WyHTmSC81y7/KVORb/xoQFDGN98YAJ38WN
         hxR45FajmUnrzaz07Y0UrNK36vij+gLCr7hlUFOER9u0ZujRkzsKFHfQP+af0auatf1R
         ASvq8QIKz/+wn9vRmoyq9WXIXX2ED/7llQz6gqgym5SkuxBihYtoG+1fNLVL9lpvvJTI
         NRADybMiHWNUs1GewOlTnQGRXj+i4r4lK2CwXhdzFHsV4U9qOj3dWjphD7Okdk9V/HqS
         /mKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnI0Cdi+W2L16eyEJud2CSI6r7qSu8Y6lJthmfpReSyemvPprgF8EkKZkMp2a8hTLzU4OaZHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymKzdUL3uBi3eV3Pjm2dFomPDk059ihjb68ZjSWXdr1GanYxcE
	6vy9zj+HX+MeF35PRHy7aHh7Gt31loxFkxYPvGzZotXTotx7txiHOs7HduxZ5fd6N2YEmppYjws
	wUZae8fqQxWh1JmS17u9UY+xsLuYZWPoe7Y8dOlc8
X-Gm-Gg: AR+sD10liHO78xlXExR9i6/6t7BB8HtkOCDQhCgFhyobz/k0PzplpFqOzZmDHbUSxOZ
	2n4BG37ZR9IfECFQ3SdzyWjvtLirxssF/gcQOwAeR2bVVxtuO5uqacwuaAHEch2M8hDLsy4896M
	Z7pdQBhMHksMgDqth+Yegeasum+LPREbmymGUC3rKxXcBR9yv1dDMnfiDDxsk3QovK7QGUp3FQj
	LPF4FWfxV8Qps/a0UDz8TjdSyRaYu8UUoitOzPAF0QYqLh8Y0bcL+yUUZ4=
X-Received: by 2002:ac8:7d47:0:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-5285229262bmr9058571cf.3.1784908448716; Fri, 24 Jul 2026
 08:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com> <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com> <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com> <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com> <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
 <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com>
In-Reply-To: <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 24 Jul 2026 08:53:31 -0700
X-Gm-Features: AUfX_mwjkzQa0aKFOYVTkcojOnlyLhgENNWtHi2USSUpXbUHkHbBUjoNeksPsS8
Message-ID: <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
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

On Thu, Jul 23, 2026 at 12:56=E2=80=AFPM Yo'av Moshe <linux@yoavmoshe.com> =
wrote:
>
> On 2026-07-23 9:21 PM, Sami Tolvanen wrote:
> > What's the value for the __kcfi_typeid_imx6_suspend symbol in
> > vmlinux.o? I would expect the hash value to look a bit more random.
> Checking vmlinux.o with `llvm-readelf -s vmlinux.o` indeed shows:
>
>   a488ebfc  0 NOTYPE  WEAK  DEFAULT  ABS __kcfi_typeid_imx6_suspend

OK, so the hashes should match. I can only assume that the hash prefix
doesn't end up getting copied to OCRAM for some reason then, or
perhaps the source of the copy operation doesn't have relocations
applied? Either way, if this turns out to be infeasible, I think the
__nocfi approach is reasonable in this case too.

Sami
