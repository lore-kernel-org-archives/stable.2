Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5F472771
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119422; cv=none; b=P60ocmw9mHOp70YWZK0PY+YkQf5uM8WhvuYc7vNb5lYfMy800oCIvDGmh55QoBljLhc0VJvSgGddQ8ZVhe/y+FebQsLawaYVH2gtuiwyXrpRYy6zT5buQPp3EvbJkvtz4eJ0c4MWo6vOnqQh5hEu0g1EsmJ0kfyYh1PUArx4dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119422; c=relaxed/simple;
	bh=yVCqtgCr9d5AEEZOkLNo2T/1tBRofpYLIOK8koYVCVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fwe9AzPaUqa7Q85LlAg43LUDYJbK5X57Ae5fr0r+OO6ySOJqLnb0Z6G7EFq7+C53P/F65J5hHZ/8Zq6dv5cw0nCezyLpHX/ytj9gq7msTZPz8Tsj28HtKix130x0Cbfs9hgUlYOwQJ6KDNfsMIyFP2fx5qQ32itdikZoTbPiP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdKh6r+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdKh6r+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F41F01558
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119414;
	bh=eePxtdvlJjzeFaYvfQULf9dh9nPYQNGSDxyeHO12ujI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bdKh6r+DLD/cEaVeHiIinkFl31izq3ySPr6UIxKO8N0nBrRMiqmECdsJuVShs0L0r
	 SXcSjEfPMD9RZKQMqkBbbPQpRNhY1XmrIQdtMxR9yYlt6l4mk9DE6GL4cWYPuAN5Bm
	 3zEuPE6Oq7b8W7zoi6idASHYlX6jOfkEujU/Z4nosf6S+h4f/TJMjdVRHFmMhS21kE
	 4IZ2aWWJ8tr/PWYTPNEYewsMsY0hnxXagGtvjuYcprcEeYyaxNMJvh3x3h92CAsyF9
	 UctFO76Z1fq0nzUeqhlutvWreKAYa+QLBO16WvsXrEgO2/LbqB1ukkWTpw+mWam3wB
	 YWZQ2HztSoFmA==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3861388a91.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 09:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpIBeChRsUr0O2wMGoWf+ynO89MeQ0JASJ+RjcGHULlPo6KZ9dTrF+/varx/0luQqeepC7Db3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiszmjW9713xros/c4HIKgAYK0sYeDZJR7ZOqxtxSJFDzfIXXm
	VVr+uk8JPQ6avMkPq2L+MRcy0QjqgNuw5xlg24j2pJsv9i+TJ2ovxtLu8qLuLHVW0uRYuZgso+e
	yLAk040b/FC7n9rl8U6FEKgHSfoWU2is=
X-Received: by 2002:a05:6a21:e58b:b0:3a3:a9c4:3d60 with SMTP id
 adf61e73a8af0-3cb85f5c2b0mr29735418637.27.1786119414516; Fri, 07 Aug 2026
 09:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
 <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
 <CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
 <20260806205144.743c45e6@gandalf.local.home> <CAPhsuW7vPwX-BGWmtMhA8dYwDOQYQLVXOUddZPbTvoazMpaKgA@mail.gmail.com>
 <20260807084257.56a5984e@gandalf.local.home>
In-Reply-To: <20260807084257.56a5984e@gandalf.local.home>
From: Song Liu <song@kernel.org>
Date: Fri, 7 Aug 2026 09:16:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5bW-xogJESb=ydUMH-ZjczoTP9JbuwPJZgbGZBzv-1CA@mail.gmail.com>
X-Gm-Features: AUfX_mxMkoGIjCMp5svwQ1gJV0xExyCbO8IPGbZeUlp3jT9Nj5neQjyjjE9Qtkw
Message-ID: <CAPhsuW5bW-xogJESb=ydUMH-ZjczoTP9JbuwPJZgbGZBzv-1CA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	mbenes@suse.cz, jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Thanks for sharing your experience!

On Fri, Aug 7, 2026 at 5:43=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 7 Aug 2026 00:17:27 -0700
> Song Liu <song@kernel.org> wrote:
[...]
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0
>   # description: event filter function - test event filtering on function=
s
>   # requires: set_event events/kmem/kmem_cache_free/filter
>   # flags: instance
>
> If "set_event" or "events/kmem/kmem_cache_free/filter" does not exist, th=
e
> test will be skipped.

Hmm.. If a bug somehow causes set_event to disappear, this test will
be skipped by accident, no? These types of bugs are not common
though.

>
> > 2) It delays the actual deprecation of a feature. IOW, the feature will
> >    somehow stays in the selftests for much longer time.
>
> We do not deprecate features. tracefs code is user API. We do not break
> user space. The ftrace_enabled is something that is being removed because
> it is broken to begin with. In fact, if we find out that anything depends
> on ftrace_enabled, we need to revert the change that disabled it.
>
> The removal of ftrace_enabled is the exception and not the rule.

Agreed that ftrace APIs need to be very stable, as there are many out
of tree users. OTOH, I think livepatch can afford breaking some
compatibility.

> > Overall, I think requiring backward compatibility appears to be
> > attractive when we go from "having very little selftests" to
> > "having some selftest coverage". However, not requiring backward
> > compatibility will help us achieve better test coverage in the long run=
.
>
> The ftrace selftest requirements are different than the BPF requirements.
> We have been supporting this since 2014 without issue. And have actually
> found making things backward compatible helpful. We are not going to chan=
ge
> that.

With mature selftests, I guess testing LTS kernels with the selftests shipp=
ed
with them is still a valid option? I guess this is up to the folks who run =
these
tests.

In this specific case, given the logic is not that complex, I agree we can
maintain the compatibility,

Thanks,
Song
