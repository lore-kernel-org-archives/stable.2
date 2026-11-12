Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515154;
	b=Q93UCOFKUc35ImaoDnS9KubG9yVRHyIwi52DMpDZ3/qUw3IA8qKYqYo0QUH/iyInamTl
	 eChH0T43SH2UcNbLuD8iXbHKTiQDyVhFMn4aKHUApY6tbwPJA73RV2UKOE+mwvk/UXbrl
	 XM/JoVOV4LqEJ4Tv72uyj32W0i40/3/5Qku4zc3KtG9f9Jc2wkQo/cShOKWJgDZK02/oQ
	 Eda47Z3yq3a3gB3ytt645eRjqTx67W8827vGLlUI5YM++zRQGIr2a3SZ/OkKf6hfRqZd7
	 hoJQMw8LO5ew4Swsb1IdbBXge6MHDFGr05NLE1+bR7tm8yvicydL2o+FJ4CvG7nvqng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515154;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rM527yu1D13pZ28TgOT2AsaYTjNbfnhY4LASaW1TbCY=;
	b=cxJyto69kIkKXIbeAtoKtTDeYz8aLpsDGVIVj1PAQ51y5DeWQZX7U0CiinvTqfW6gW0k
	 pDo6PyLDnhgtETDuZaD8F5Hqbkr1jRp6B/IMpEAoQiTmI5W1VaVQYq76UIa9fRWtIrg5L
	 XSafwbe57P4MMiNa24JvVBwEr4hq0CVpYrnowRTb6zLuqSBvFtJInZ/qb+VAvRVFvFftF
	 SRPY47lR4/MO/xJ4t9PKS0mrPrJKRfiGKgu8rgouEBRbZZWONSiX4r1klC0s8bDWaKD8j
	 DYBS/NiIbY/sT2yP2cZvA3PSBD3krlAP/jKLmiOoZLZWAJPIwKHltlsh1YJCgGfJVhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr0eumB+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB19606A882
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr0eumB+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419501F00926
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515154;
	bh=rM527yu1D13pZ28TgOT2AsaYTjNbfnhY4LASaW1TbCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nr0eumB+TAgvimd9aoSfe4jg5d8Am6Zqh5Wuyxig7fP3qU26RNovxlhslzUZ+/zIJ
	 Uex5ZC9XAIt+zm5EEatw5M8DUH6378Z5ZS51/XS47G558GsufR3rGjY8MSyWWZ7tOk
	 DRSOVtrCzK2QNqCnvHHGk4LnYg+yHfiXZZSfMMltH0Poa7fZ3wOzeT2tG2VD7rk9+J
	 +lSihpGEvY9fsuIRSwuk3y/qQ2SXj44FESvb1aiVZML3Fmqd1x1EZTvMwyNEqrQdIW
	 f4f++CSs/5Qo2m9lB88HGcbfsAqdWHTVEtgEyNFpbpMGWgGK2GyqjhU+Qb612Vj8XJ
	 c0Fkt2rt3qGGw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c1479be604so209367e87.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:25:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGvmzoICY/X5ZBD834SptC3y7ts+7cX6IRd5SZLH1IwOcrNOMwvBc4zWc1loIvNQyaDFrxYMGg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xqcF/Jxa8uv2EqWfvxnaV+s2TnP1SDNDsAPpW2AJLTS6X0Ral
	e/DNRsqRpQm/6BaRF/aqKFE0WfAZGXOeHbJ2DrjRIwYSR6lQflPhDLgF8U3cDLjJOa4vD2aniHi
	TRyPlyPqEs0SsuPNruS8pzpPTj9Uhciw=
X-Received: by 2002:a05:6512:398f:b0:5bf:e540:8606 with SMTP id
 2adb3069b0e04-5c1709d8e46mr173072e87.59.1794515152658; Thu, 12 Nov 2026
 12:25:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111225940.1573565-1-tytso@mit.edu> <20261111225940.1573565-6-tytso@mit.edu>
In-Reply-To: <20261111225940.1573565-6-tytso@mit.edu>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 21:25:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g=9eo26EwabnKBS-qM+YV4gTqZO4bO3EwpSr1N3SLDWg@mail.gmail.com>
X-Gm-Features: AclHuK8AK-YCIRGgFSyL8HURcsSl3PSuZZQrLFmJgc1XyrQkd4ueYU159Gy5kxo
Message-ID: <CAJZ5v0g=9eo26EwabnKBS-qM+YV4gTqZO4bO3EwpSr1N3SLDWg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] agents: add a skill to write commit messages
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
> Assistants are asked to commit a fix with a detailed message, and the
> find-fixes and stable-tag skills leave their tags for that message, but
> nothing says how to write it. Messages written by assistants tend to be
> long, and Linus recently asked that pull request text written with an
> LLM be less verbose and prefer the imperative voice.
>
> Add a skill that sends the agent to the parts of submitting-patches.rst,
> 5.Posting.rst and the maintainer documentation that cover commit
> messages, cover letters and pull requests, and to the P: profiles of the
> changed files. It adds what agents get wrong: stating only what the
> change and the supplied sources support, keeping the text short and in
> the imperative mood, and adding no tags that were not supplied.
>
> When a semantic patch found the bug, the message includes it, or its path
> when it is under scripts/coccinelle/, so that reviewers and the
> Coccinelle developers can see it and run it again.
>
> Point the bug-fix procedure in coding-assistants.rst at the skill.
>
> Link: https://lore.kernel.org/r/CAHk-=3DwgXU50=3DKgZNZc1JDxsSxg9Z+DjG1_2y=
U-fNXpZtUe4XDw@mail.gmail.com
> Link: https://lore.kernel.org/r/50531bd9-f3ea-2d45-7b3a-a96a446a8fcc@inri=
a.fr
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Link: https://patch.msgid.link/20261020161642.3713052-6-sashal@kernel.org
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks reasonable to me.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  Documentation/process/coding-assistants.rst |  9 +++--
>  agents/skills/commit-message/SKILL.md       | 45 +++++++++++++++++++++
>  2 files changed, 51 insertions(+), 3 deletions(-)
>  create mode 100644 agents/skills/commit-message/SKILL.md
>
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/=
process/coding-assistants.rst
> index c2f9b71650c1..f0bae6bfe9a0 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -41,6 +41,8 @@ The following skills are available:
>    returns its stable tag, or checks an existing one.
>  * agents/skills/find-siblings/SKILL.md looks for the same bug elsewhere =
in the
>    tree.
> +* agents/skills/commit-message/SKILL.md writes, rewrites or reviews a co=
mmit
> +  message or cover letter, and writes the text of a pull request.
>
>  Licensing and Legal Requirements
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -87,9 +89,10 @@ these steps:
>     another one. The fix must not add build warnings and must pass the
>     checkpatch.pl checks (see submitting-patches.rst). Then look for the =
same
>     bug elsewhere with the find-siblings skill.
> -6. Commit the working fix with a detailed message describing the problem=
, the
> -   solution, a Fixes tag determined with the find-fixes skill, and a sta=
ble
> -   tag if the stable-tag skill calls for one.  Do not add a Signed-off-b=
y tag.
> +6. Commit the working fix with a message written with the commit-message=
 skill,
> +   describing the problem, the solution, a Fixes tag determined with the
> +   find-fixes skill, and a stable tag if the stable-tag skill calls for =
one. Do
> +   not add a Signed-off-by tag.
>  7. Identify the maintainers and lists using scripts/get_maintainer.pl.
>     Documentation/process/security-bugs.rst shows how to do that.
>  8. Indicate what could not be done. If the fix could not be built or tes=
ted, or
> diff --git a/agents/skills/commit-message/SKILL.md b/agents/skills/commit=
-message/SKILL.md
> new file mode 100644
> index 000000000000..c75f028c56da
> --- /dev/null
> +++ b/agents/skills/commit-message/SKILL.md
> @@ -0,0 +1,45 @@
> +---
> +# SPDX-License-Identifier: GPL-2.0-only
> +name: commit-message
> +description: >-
> +  Write, rewrite or review the commit message for a Linux kernel change =
or
> +  the cover letter for a patch series, and write the signed tag and pull
> +  request text for a subsystem pull. Use when committing or preparing
> +  patches, when asked to improve or check a commit message, or when
> +  preparing a pull request for an upstream maintainer.
> +---
> +
> +# Write a commit message
> +
> +Read "Describe your changes", the sections on tags, "The canonical patch
> +format" and "Commentary" in Documentation/process/submitting-patches.rst=
, and
> +Documentation/process/5.Posting.rst for cover letters. Follow the mainta=
iner
> +profiles, the `P:` entries in MAINTAINERS, for the changed files; they t=
ake
> +precedence. Follow the rules for skills and for attribution in
> +Documentation/process/coding-assistants.rst, and
> +Documentation/process/generated-content.rst when a tool found the proble=
m.
> +When editing someone else's message, also follow
> +Documentation/maintainer/modifying-patches.rst.
> +
> +- State only what the diff and the sources you were given support, such =
as a
> +  bug report, a crash log, test results, or the list discussion found wi=
th
> +  `lei q` on lore.kernel.org. If the reason for the change is not known,
> +  return no message and say what is missing.
> +- Take the Fixes and stable tags from the find-fixes and stable-tag skil=
ls.
> +  Add other tags only when they were supplied or given on the list. Neve=
r add
> +  a Signed-off-by.
> +- If a semantic patch found the bug, include it in the message between
> +  `// <smpl>` and `// </smpl>` lines. For one under scripts/coccinelle/,=
 give
> +  its path instead.
> +- Use the imperative mood and keep the message as short as its content
> +  allows. Leave out markdown, labels such as "Root cause:", intensifiers=
, a
> +  restatement of the subject, and the story of the investigation.
> +- Check the result with `scripts/checkpatch.pl --no-signoff`.
> +
> +For the signed tag and email of a pull request, follow
> +Documentation/maintainer/pull-requests.rst,
> +Documentation/maintainer/rebasing-and-merging.rst and
> +Documentation/maintainer/messy-diffstat.rst. Summarize what the pull con=
tains
> +and why from the commit messages in the range, in the same voice, withou=
t
> +repeating the shortlog. Ask the caller for conflict resolutions and test=
ing
> +that the history does not show.
> --
> 2.53.0
>
>
