Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514340;
	b=JbLhMbw7TyNmG9+Ou9/ax1xvHAsiI7pSYMH6wLcIeYm9zyv8pXEOce81pjsvxmrHpU5D
	 XRW4ZtS2knNsUQgVMWKAg1Y+ZM95tNWHuG37TRlDEnYdjpSXr2SLFGIf8cqKyNq+c75AA
	 01xAJoFOO3yHDak35LgEjlHm3CF6fVYnQHCp0qBKmcBiYIPCGeZHMecyyQchUlPfrR5YG
	 GhHCSGGGwahdzjMu30W2qhN04UY0a9w0GcZDq0dbgbZw6fd+oNxGDETI7Jt/J90TFivlR
	 0vOvHGDA2NImDUDwcjURMywDofJcwXaCquU5koolsQFnKAiYwOCToW0M7oJO8aC9ZDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514340;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eakRgnWHv93CEQPpJprbZeATRfmw83XT/BkhRlCQLg8=;
	b=PSZLQNqnJKIruntKH0MKeY/quQXXgip4QsuSNw9i46uZ8Hvo+nAY5wkPOQZQC33b1C2d
	 DI1N8MAMUUg1TjDcAap8J/lvLzZ3jkXNFm19Xh4MS7VocFy+nUklY8bxGDSxqxSFPct2a
	 JKeZWJ+Mkxt2SWB/9zT+6UcyVRwH5/s9kc9ixeJuxvolxFlfJVyeIZ6IVMzVrVe/j6mPr
	 QbvotSFSv1ivsjQYFx+9QyWgj9luZaeOYRxRjUw0X948XGjFOeU5RJciqM70ZQEzzG7EF
	 eCpz3t5rhHM7eqIqIauychlQjNhSNtXxHhtBo1O2TCQPa3kHvi9sUsMDkW9WiJ+xkZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSHbJVnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8B606A881
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSHbJVnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26061F000D0
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514339;
	bh=eakRgnWHv93CEQPpJprbZeATRfmw83XT/BkhRlCQLg8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bSHbJVnvKo5zci/a1AG3EHF0wmI3lxnUuv9gNNDuCIUa9Xii0VLak9IqJNPLZgz07
	 Ep6uTeYWFnkORVWYYXWAyg7SZgXCKfvNk6z/NhDifM4Id8WAepGw8vhSpVItzOqscD
	 TF2VhaDh2DH2yMOTWY94XPcZy9echX8uG/ncBVHz+DJB5Pr9MgK8ft8ydYXyix3mve
	 hWrCBu+M9W+3Ln+9mf4dO2kVpEd9Z//hls+ej6fWmz+gownoDGd2DyLr0VO7cJstov
	 /3YNA8WdNblZK+OsyjcZjgG5Ukde7JElh2g3+Jlod2YdTbI5vfAxx3cuANNhpcxa16
	 a74kXQpbTvR9w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3adef977ad9so1426331fa.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:12:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFKoEVOV5O3KL6MNC8Eds4Tke7fiBTvL8GO9yhUzHQl4O0BBGqR65u0SE+SZu+rp9ZzLGwuFMQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OzHben0eqnB76zaH0B3eTzmIrwGmTI7ycgEGeBqxa3NDB81Ga
	b9gbPUN9LBkhdMy8GK8yy+YAC9SDRMrcUslQkGftT3c0ZpkUxLfzh3kG9/ZxJLQbY6+XqBH8+mT
	Eh1I659YpJB8VOAcpXo/m1Ds6sx+y4Vw=
X-Received: by 2002:a05:6512:1325:b0:5c1:4c83:ae37 with SMTP id
 2adb3069b0e04-5c1705faa61mr179985e87.2.1794514338096; Thu, 12 Nov 2026
 12:12:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111225940.1573565-1-tytso@mit.edu> <20261111225940.1573565-2-tytso@mit.edu>
In-Reply-To: <20261111225940.1573565-2-tytso@mit.edu>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 21:12:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jQh5o8rT0EDZ+zMXmPn8i0Dz+FoRK92OeYGeHbzrf4Lw@mail.gmail.com>
X-Gm-Features: AclHuK89jLhFcAKrJXWTO7te7t_zZMTV5xHcIHChc6as7m7NjdEkpvKrRplXSrU
Message-ID: <CAJZ5v0jQh5o8rT0EDZ+zMXmPn8i0Dz+FoRK92OeYGeHbzrf4Lw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] agents: add infrastructure for agent resources
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, Bradley Morgan <brads@mainlining.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Leon Romanovsky <leon@kernel.org>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Thorsten Leemhuis <linux@leemhuis.info>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter <error27@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 12:00=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> From: Sasha Levin <sashal@kernel.org>
>
> Add agents/ as a home for skills and other resources for
> coding assistants. Describe the skill layout in coding-assistants.rst,
> together with the rule that skills only inspect and report, and add a
> MAINTAINERS entry covering the directory.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Link: https://patch.msgid.link/20261020161642.3713052-2-sashal@kernel.org
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Fine with me, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  Documentation/process/coding-assistants.rst | 14 ++++++++++++++
>  MAINTAINERS                                 |  6 ++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/=
process/coding-assistants.rst
> index 509dbf23a099..b8f2c74e46fc 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -19,6 +19,20 @@ For guidelines on content generated by AI coding assis=
tants see:
>
>  * Documentation/process/generated-content.rst
>
> +Agent resources
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Skills for coding assistants live under ``agents/skills/``, one director=
y per
> +skill with a ``SKILL.md`` entry point in the `Agent Skills format
> +<https://agentskills.io/specification>`_. Each skill points at the proce=
ss
> +documents that apply to its task and adds only what assistants tend to g=
et
> +wrong.
> +
> +Skills inspect and report. They do not change files, create commits or t=
ags,
> +or send mail. A skill returns its result with the evidence for it, or sa=
ys what
> +is missing. Do not fill a missing result with a guess or a placeholder, =
and do
> +not finalize the work until it is resolved.
> +
>  Licensing and Legal Requirements
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..eb348cc9588f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -734,6 +734,12 @@ F: Documentation/filesystems/afs.rst
>  F:     fs/afs/
>  F:     include/trace/events/afs.h
>
> +AGENT RESOURCES
> +M:     Sasha Levin <sashal@kernel.org>
> +L:     workflows@vger.kernel.org
> +S:     Maintained
> +F:     agents/
> +
>  AGPGART DRIVER
>  M:     David Airlie <airlied@redhat.com>
>  L:     dri-devel@lists.freedesktop.org
> --
> 2.53.0
>
>
