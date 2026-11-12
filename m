Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445857;
	b=l3WJmEqi+DtlbPH/LPH4W2X0Vi4j9bb1SGQchRJEZbr+/Q4ukrz7ZBqWV7l6GiACBrRa
	 TWp1/PdYjdzyaj077eXiRfeS27woh2HxwS4OJ8B54AUCuZIMMOC4Z+qxvrRjeUbPGvYl1
	 1AveWxeGRPviwrt5a52J3UwvSQXw2CJ/h4py/QNWGOW3unOltBpn5pUA+hCHDjltQmSNs
	 7gHzEBBNSJkaOrg11osL78eH9jzuQdrZxSdBUunWOJFcTF//xVlOUmShPMgsXUPm6xUQY
	 0QNHPmVpWlOGHrDgjFGaf4hUEaznBQi0Cokkbfy8hSQ76DMTuJ9PDufRabzqEaQzb5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445857;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Sg33oRoQoVee7JjFWfxdDgNWAM0j8s13PpiFv5cw7Ks=;
	b=dSjmp41DJFmV+dutehxcZuZl+B+41yo/sn3j0XFIUq7sx4VOuDZsNF9UyQuRdClayIKq
	 sLvTwOeGcU36CboJB/1D6j87LZzLLaBF0kNlUnBQeC3oCTuWIsFKt14JRapgKPNKvhKAK
	 wUvgazk/wNBkFRjZYTBjdXsqPWORdqSU8RQRsLiwvM5l9NomP0HuTx05vC/pssljt+bdQ
	 3UnZG5GMGMWkMrirURjm3XU0fqC99ZIcbqG167JmTSvG6SawuXqdqMFGZd11sJVf+Jf8I
	 HeFDFUE+FdoI17H1tyn9OyxZPfqIFN6LEdEsJHGU3fNtgMd59FBNKAOkWte/6ksfdMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=lKnZCupj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E80606A324;
	Thu, 12 Nov 2026 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=lKnZCupj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1571F00A05;
	Thu, 12 Nov 2026 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794445856;
	bh=Sg33oRoQoVee7JjFWfxdDgNWAM0j8s13PpiFv5cw7Ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lKnZCupjO3yK/mZZLk2i8vWpoqQEGkjX8ITOF3AYYtxE3G6XA1uUb51AaGXZTwWa/
	 I3b2szAXQ8ib2XBaVlgoYYPQ49mmsO6AHettz9pXLqrhqXGVKq4tnBjgHN8mZXfgjP
	 d90Qak/JcVpBqA88A28EAG/1S+Cc7ngN/v41xxyY=
Date: Wed, 11 Nov 2026 17:10:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: workflows@vger.kernel.org, ksummit@lists.linux.dev, Sasha Levin
 <sashal@kernel.org>, Bradley Morgan <brads@mainlining.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Mark
 Brown <broonie@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Leon Romanovsky <leon@kernel.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Thorsten Leemhuis
 <linux@leemhuis.info>, "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook
 <kees@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dan Carpenter
 <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, SJ
 Park <sj@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 3/6] agents: add a skill to determine stable tags
Message-Id: <20261111171055.527b4bf3da705367bc78a64c@linux-foundation.org>
In-Reply-To: <20261111225940.1573565-4-tytso@mit.edu>
References: <20261111225940.1573565-1-tytso@mit.edu>
	<20261111225940.1573565-4-tytso@mit.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 17:59:35 -0500 "Theodore Ts'o" <tytso@mit.edu> wrote:

> From: Sasha Levin <sashal@kernel.org>
> 
> Whether a fix needs a stable tag, and which releases it should reach, is
> decided by hand and is often missed or left too broad. Add a skill that
> sends the agent to stable-kernel-rules.rst for the decision and the tag
> format, lists the kinds of changes the stable trees take and leave out
> in practice, and adds the checks agents tend to get wrong: finding the
> first release that contains each introducing commit, checking that the
> fix applies to the oldest affected release, giving every stable tag the
> same version, and following the subsystem's stable policy.
> 
> If the decision cannot be made, the skill returns no tag. Point the
> bug-fix procedure in coding-assistants.rst at the skill.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://patch.msgid.link/20261020161642.3713052-4-sashal@kernel.org
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  Documentation/process/coding-assistants.rst |  6 +-
>  agents/skills/stable-tag/SKILL.md           | 72 +++++++++++++++++++++
>  2 files changed, 76 insertions(+), 2 deletions(-)
>  create mode 100644 agents/skills/stable-tag/SKILL.md
> 
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> index ca1cc255606b..81ee530a8a7f 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -37,6 +37,8 @@ The following skills are available:
>  
>  * agents/skills/find-fixes/SKILL.md determines the Fixes tag of a bug fix, or
>    checks an existing one.
> +* agents/skills/stable-tag/SKILL.md decides whether a fix goes to stable and
> +  returns its stable tag, or checks an existing one.
>  
>  Licensing and Legal Requirements
>  ================================
> @@ -83,8 +85,8 @@ these steps:
>     another one. The fix must not add build warnings and must pass the
>     checkpatch.pl checks (see submitting-patches.rst).
>  6. Commit the working fix with a detailed message describing the problem, the
> -   solution and a Fixes tag determined with the find-fixes skill.  Do not
> -   add a Signed-off-by tag.
> +   solution, a Fixes tag determined with the find-fixes skill, and a stable
> +   tag if the stable-tag skill calls for one.  Do not add a Signed-off-by tag.
>  7. Identify the maintainers and lists using scripts/get_maintainer.pl.
>     Documentation/process/security-bugs.rst shows how to do that.
>  8. Indicate what could not be done. If the fix could not be built or tested, or
> diff --git a/agents/skills/stable-tag/SKILL.md b/agents/skills/stable-tag/SKILL.md
> new file mode 100644
> index 000000000000..d87bcc95089d
> --- /dev/null
> +++ b/agents/skills/stable-tag/SKILL.md
> @@ -0,0 +1,72 @@
> +---
> +# SPDX-License-Identifier: GPL-2.0-only
> +name: stable-tag
> +description: >-
> +  Decide whether a Linux kernel fix should be backported to stable kernels
> +  and return verified Cc: stable tag lines. Use when preparing or reviewing
> +  bug-fix patches, drafting their commit messages, or checking an existing
> +  stable tag.
> +---
> +
> +# Determine a stable tag
> +
> +Read Documentation/process/stable-kernel-rules.rst. It says which changes go
> +to stable and how to write the tag, its prerequisites and its version. Follow
> +the rules for skills in Documentation/process/coding-assistants.rst.
> +
> +Judge a change by what it does, not by how its description labels it: a
> +"cleanup" that releases a resource on an error path fixes a leak. In practice,
> +the stable trees take:
> +
> +- Fixes for crashes, oopses, BUG and WARN splats, hangs, lockups, RCU stalls,
> +  deadlocks, data corruption and security issues.
> +- Fixes for use-after-free, double free, NULL pointer dereferences,
> +  out-of-bounds accesses, integer overflows, uninitialized data, reference
> +  counting errors, and memory or resource leaks.
> +- Fixes for races, including data races.
> +- Fixes for incorrect behavior, such as wrong results, wrong hardware
> +  programming, or endianness and type errors.
> +- Fixes for problems reported by syzbot, other fuzzers, or the KASAN, KMSAN,
> +  KCSAN and UBSAN sanitizers.

Marco had some thoughts on this just today:

https://lore.kernel.org/CANpmjNMvM_TCs7Fao9+gM-NNpQyBKYumSuWOt_03ZX+tLwbjWw@mail.gmail.com

And Documentation/process/stable-kernel-rules.rst does ask for real
things, not theoretical stuff.

Also, I would keenly like to see changelogs clearly explain *why* a
backport is proposed.  As I have said 1000 times, "when fixing a bug
please clearly describe the userspace-visible runtime effects of that
bug".  Can we pleeeeeeeeeeze get this requirement clearly enshrined in
this patcset somewhere where the LLMs will read it and comply?  It's
really simple for the LLMs to cook up a paragraph for this, if so
directed.

