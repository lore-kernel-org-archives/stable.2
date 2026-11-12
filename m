Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514707;
	b=2DxfuAaUurcp5QxH79olRhZ1265DeX225J+xiFqCT7/Kx3JzRVio0bhdyCO66o7fHgqs
	 8Rrr0vrVu0KnLbgiAc4Mqk6qmQMgLbcvsDR5oxpeYwl6qZFluuSp0rucYYTQW9XEXz1Is
	 ti5imNmymMkTkyrG2/Yg1fBUqpxeZR4UJ3Q5VI5gxsHgZj0LhLx6k6aPyKe1RyBmJdD+i
	 H3Fdp7XM/vWqApCwHaEKD446ahEv8lt8u6l8zy23upaNzDHb4Ngb9JA7v1b8lZjOk7P1z
	 Ma4UUqW4vK7FfFwlZPSFyZ4ZMfgXcCHy/49omJ1CimyeX3pXDaZnBUUGLJ/NEo9R5vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514707;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PELjK/L9jce4ay8aMBxnTmm3MZS6/0vTv4b1DOTHnXs=;
	b=pMaZPMXUqb64hiV0H712o/TsMxypQCYZLFdleDMoRhZCDDZ5DBC3gFTtQfO48/zm6cyq
	 gEz+cvlGg4nwk0HtcgKFqO9Qz0XphoVphx5jSoqTdotRlRWsvAAGjyWvqM3ACyxyC0vIL
	 v1/8t99dzFKNOKq/oHr9GvYayCHE1BGtDbeM3xn1O+6VtxaebwZ23RAxjAHRgka9HwZSi
	 GT3rKMNAmTJbX72SJgndFnZQFlBQKSWsWjI4eIhUxKOTnm51xPJZI4mNgBWjMTVkrDRiE
	 re6aQPOipG2Bjp1rPbbWA0fGvFb1AnBK7FMufJOvswwayGhkcZ0Sp650LC/DIOhmPnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV51zSWA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA8C606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV51zSWA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F0C1F00929
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514707;
	bh=PELjK/L9jce4ay8aMBxnTmm3MZS6/0vTv4b1DOTHnXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RV51zSWAeX3l/5mLe0fPRliGyDx+PvZFURqVBlheSHcmcZOr7xCw/H2ruJIbBadKZ
	 FHLR/OWlUbeu4rGlh0xRIygVUxNlxHYE+bp6HXrNkc1Ipb+2P3nm8Kc/0SyV7ISGh4
	 TuE1gaetH5yPGzok2F9hb+btdrpFYQn/7EdW+GfsBVzhuGLxg5l94MAeni55Fgqs75
	 ZHYbDDjM9jg0y/L7yxQKaxx7tEtYWK3HxSCep7gzYUxXot783rYRC7J5k84FZzeC3T
	 zkrDiT/RxHgLEBWbdDFqUsbl4XfNwD+qAaJQ8hPoNDWh7rbOnMd2x5Ji/iXdG5l/WS
	 B6Y/Zk1OMzQXg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso241892e87.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:18:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGkmimFmgd7U7J/b2D9dTAr6Nin7yKHM+5CwPVUtrVvbHvEIlssLZd7l++Hbn6zXRWd74UY0i0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EwEKMO8sq2rZ1nbcOYzyLzjSbEKVm0tm0O9rXor9EdDSxLYUR
	xxcEGuS3ofiaw9POE3zN3lKIyNFs7wC0Jk7M8CjjdLEWrlgsPtKkKkGYoJwDzMhFaWYzXgjBnLD
	Plg273tb0mxIrL9KzvkJebtx/he2chwk=
X-Received: by 2002:a05:6512:1292:b0:5bc:f2fb:f50c with SMTP id
 2adb3069b0e04-5c1709cd3afmr151270e87.53.1794514705799; Thu, 12 Nov 2026
 12:18:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111225940.1573565-1-tytso@mit.edu> <20261111225940.1573565-3-tytso@mit.edu>
In-Reply-To: <20261111225940.1573565-3-tytso@mit.edu>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 21:18:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iaHqEkr+WqHLfJ6qYaC6n73BCo0NiKgQhf466Cr_RQzA@mail.gmail.com>
X-Gm-Features: AclHuK-IiYj--CiaJbtqzk4cWOHkMMr3R1ChUBdeGcZceIdAKYSCedVswaPimxM
Message-ID: <CAJZ5v0iaHqEkr+WqHLfJ6qYaC6n73BCo0NiKgQhf466Cr_RQzA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] agents: add a skill to determine Fixes tags
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Leon Romanovsky <leon@kernel.org>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter <error27@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>, 
	Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:00=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> From: Sasha Levin <sashal@kernel.org>
>
> Blame and existing Fixes tags can point to code movement instead of the
> change that introduced a bug. Add a skill that sends the agent to the
> description of the Fixes: tag in submitting-patches.rst, and adds the
> checks agents tend to skip: pinning down the bug before searching,
> following the code past moves and refactors, comparing each candidate
> with its parent, tagging a later commit that only exposed the bug as
> well, handling merges, reverts, backports and bugs older than the Git
> history, and taking the commit ID and subject from the commit rather
> than typing them.
>
> If the origin cannot be established, the skill returns no tag. Point the
> bug-fix procedure in coding-assistants.rst at the skill.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Link: https://patch.msgid.link/20261020161642.3713052-3-sashal@kernel.org
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks reasonable to me.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  Documentation/process/coding-assistants.rst |  8 ++++-
>  agents/skills/find-fixes/SKILL.md           | 39 +++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 agents/skills/find-fixes/SKILL.md
>
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/=
process/coding-assistants.rst
> index b8f2c74e46fc..ca1cc255606b 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -33,6 +33,11 @@ or send mail. A skill returns its result with the evid=
ence for it, or says what
>  is missing. Do not fill a missing result with a guess or a placeholder, =
and do
>  not finalize the work until it is resolved.
>
> +The following skills are available:
> +
> +* agents/skills/find-fixes/SKILL.md determines the Fixes tag of a bug fi=
x, or
> +  checks an existing one.
> +
>  Licensing and Legal Requirements
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -78,7 +83,8 @@ these steps:
>     another one. The fix must not add build warnings and must pass the
>     checkpatch.pl checks (see submitting-patches.rst).
>  6. Commit the working fix with a detailed message describing the problem=
, the
> -   solution and a Fixes tag. Do not add a Signed-off-by tag.
> +   solution and a Fixes tag determined with the find-fixes skill.  Do no=
t
> +   add a Signed-off-by tag.
>  7. Identify the maintainers and lists using scripts/get_maintainer.pl.
>     Documentation/process/security-bugs.rst shows how to do that.
>  8. Indicate what could not be done. If the fix could not be built or tes=
ted, or
> diff --git a/agents/skills/find-fixes/SKILL.md b/agents/skills/find-fixes=
/SKILL.md
> new file mode 100644
> index 000000000000..12b6ea83876d
> --- /dev/null
> +++ b/agents/skills/find-fixes/SKILL.md
> @@ -0,0 +1,39 @@
> +---
> +# SPDX-License-Identifier: GPL-2.0-only
> +name: find-fixes
> +description: >-
> +  Determine the bug-introducing commit and return a verified Fixes tag f=
or
> +  a Linux kernel fix. Use when preparing or reviewing bug-fix patches,
> +  drafting their commit messages, or checking an existing Fixes tag.
> +---
> +
> +# Determine a Fixes tag
> +
> +Read the description of the Fixes: tag in
> +Documentation/process/submitting-patches.rst. It says which commit to na=
me
> +and how to format the tag. Follow the rules for skills in
> +Documentation/process/coding-assistants.rst.
> +
> +- First establish exactly which bug the fix addresses: the failure, how =
it is
> +  triggered and the code involved. Trace only that bug. If the search le=
ads
> +  to a different bug or subsystem, go back to the fix.
> +- Name a commit from the history of the tree the fix applies to. A stabl=
e
> +  backport of that commit, or a commit that exists only on another branc=
h, is
> +  not a valid tag.
> +- Treat blame output, an existing Fixes tag and a bisection result as le=
ads,
> +  not answers. Follow the code back through moves, renames, file splits =
and
> +  older implementations to the commit that made it wrong.
> +- For each candidate, compare the commit with its parent and explain why=
 the
> +  code was correct before and wrong after. Keep apart the commit that ad=
ded
> +  the code, the commit that made it wrong, and a later commit that only =
made
> +  the bug reachable, which gets a tag of its own.
> +- Check each parent of a merge, whether the bug was reverted and later
> +  reintroduced, and whether a backport differs from its upstream commit.
> +- If the bug is already present in the first commit of the Git history, =
name
> +  that commit: Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2"). Confirm that th=
e bug
> +  exists there instead of using it as a default. A shallow clone boundar=
y is
> +  not an introducing commit; report the limit instead.
> +
> +Take the commit ID and subject from the commit itself instead of typing =
them.
> +Return the tags with that explanation and the candidates you rejected. I=
f the
> +origin cannot be established, return no tag and say what is missing.
> --
> 2.53.0
>
>
