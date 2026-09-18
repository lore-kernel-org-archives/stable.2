Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2249AA20
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760528; cv=pass; b=guiwjTwmQMbUlKVXRVJto2JFXosL4oE8MM+8NR92kWdZNr5N1nC7X+aF9u5AKK256FGpTifCDOBBWgWlctbSvz421olbXxQJCFr0Y7UfwnSX7WP7ZfKFQo67couz69Hd2G+H2Lm/sNvy5TaC2nBrtZyJOb8NQBr5Sje1R8F2pos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760528; c=relaxed/simple;
	bh=FciYpfzLKANxNupwU3w7Epq7qWdhQfQ2fn9tImiDYOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGY+Bo0xsa4KLEEVc0SsH+jogWU3mPzVUocslX8n/d0F718LL/aQIx0b5o7DvMcMCEkNHPqyQrVrMZSo1liBAj/GkRsNzmJ5hQ55Y1vdokzP3sox5iRd/e6wJ8c9R5jaxRnHMK2jAloYdFz/iDQCLbdF5bjd5D5YvtJiUR8xYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUGoa5HU; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUGoa5HU"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53113d72966so55351cf.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 12:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789760521; cv=none;
        d=google.com; s=arc-20260327;
        b=etxokRnhE9mAf+/FY/UuxNk1C36zVHVy9aDpAwcedvx3DXKXheKl6tUvcmBH44tovD
         pFQ+KiwnqOE+BlNYA+8cbRyVzl1vZAlgFaUG2XD0AT7FWW7KpqHxZ4SHk1SSnOUKegdN
         96S1vVmMmz6AsPq2FHx4um+OPPC3uf1lEQ1SPj9p7SpIW3he8jdewJbWc4np0sOM2sUp
         b3+Kpj8XqKYaYU5rIf7j5Nm6usZX1zCWGrX0DUsLje2aBMv7o55vFn8RQSqEH7/s8aLY
         wSwvWvH3+GxrX/bjfP6E5vDjo52gVFUanXXuPPRqd6jaW++pfh6Gg4UnhWby4E+YOMQQ
         mlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TCH7p85Cm7cElO31LspfZMTcJ2Lo8qhjOuojMqh9w6s=;
        fh=xIsSQdzPBWqhYhUcI2FTr+wDgduGgOmdm+A3ts/31Vw=;
        b=daiKfUTEBzSn5vYwf0bpr1qMVZL2GpvPvv8LqvIMsapkHBXcxY9Qbyc7StHt10N/6c
         heV4HcnMw9T4qFix63DmgCzFheHQSC5f07fK4cOcjGEZVWYwu5RZ2YhFoa3SSIot1k/S
         SLHZkB3dGGUTH4iOMmoq9y8wyDZo30ae+R6Zq18L4YkGIFg0FCp3/vhyOU6chS/M/+UG
         ywO4Fr1JlaKmVwLgP0zgUlJ3H5qPufi4TQheBqBXqcwzBo7MZdchD8NRV08NREsh9icH
         3Ry2gKqyC7BvsLNQqB8pgVKp41mvOWPij0qsOCsEht3ErfItR/e97VCwsogQvDseFBAX
         x4sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789760521; x=1790365321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TCH7p85Cm7cElO31LspfZMTcJ2Lo8qhjOuojMqh9w6s=;
        b=jUGoa5HU/vNuc8F/pwa+jvfY7AybeMM5t7s7Cz0jArL9EYmw8nCxDKpwEeuccvaNwz
         /SWjCtI8aB/zdRdYlVX/4jiRK0LpmDIUbnQmbayzwHpUfHae3xEwPebCcvrGpZCnqWbJ
         7vBV6YLHcTJGxUFWYBXGUo5gEOX0LoyLT9lGYqRGWMQgT8ULaz7Gso3azB0+vIcUCHtQ
         f8ro7vFYNoic3XuqODB/3KQS5OI5YgSX8sIrcyVNj0BgEuhLlUCwpnsLnphJfgpcDMps
         aYhHMqEbH4TwJ2eN3Wvil+kpFPhgtXGBv45ev7lIVG9ze7zVSKivnUMBBJx/k2tqYnI/
         CmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789760521; x=1790365321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCH7p85Cm7cElO31LspfZMTcJ2Lo8qhjOuojMqh9w6s=;
        b=h9kA5Y4DLDSx4Ino4jZWk9HWD3UizFiKF5RF4JOZsN9ueFIrgrl/KNb7JMcx36b6GP
         /94X2lsHNBuXAI3Cs01Him00yRbAvQ+zPs9Y/OD97zLrWI5GI34iU07SSQoaXf692dkA
         W116jrbDoWft/W7tg12N/DBE4BNOgBo9ROAYPyhuqA4L9By0+nXkBkoPnzUb6APCA0yO
         3WiNH0QKUT0xMx8RtfpRThfDw6Ex9e5CFJJFAnNookqL81Nk68ezkPGSYSr8wJZXg085
         7/wIHAhLwDwkryqKHKXbuc1dx7mr8OSGTgnE8q0KIlZtAdjc4R6mQQfowfFwcdnKJtbb
         H42w==
X-Forwarded-Encrypted: i=1; AKwUvBwf4iEpJukCWfhgyd1v9Q9irY+GKDb33mJyE29BfSWTITSh2pJsPFfj0JWlUcIRP1eFsFcI1Qg=@vger.kernel.org
X-Gm-Message-State: AFuF++mCrWSh3ymRWaesv52af2cgzkvmraMMYQXbDVG7L4q4oiyGwD5r
	iJ5GPqg4arwX8yyKacqdDhlbcXPTMdqZ53jX98nCcDOrNImoqpmBvD4UWRAxO6vHK9V8zQoLk3o
	rz1oO8myxqsx7TlIaOikNoW2XBu9LHQhIT5YpWiAO
X-Gm-Gg: AYBFou2B5bjPu51KSM2InwiZyST42zm8FhaedyzA4ArbTzwD2l8BX/OLvJQNpsM4HCk
	Nz1hA2oJwdHBprVUcY7tRDf7zvCs4LmRvKWqY3b9ONezk/w3I2cUSmouUP6+EHp8jfi5iHj14kA
	WSsBDD18eadbClRttc7cB9N7sR5OM79B7JGQAr69SrXOUOnYAOdwszI9YTfjNQzE0HbXYwnS9NM
	WBEcxQeiPNmdX5uHUj7BzYwsBJcFmK6/fqZp6MG6fbqnQW4DzsX3fAEgYhl9D6CUgWh4GFr0iNq
	Zd9teJwEBkGr71PJeNgyoVFybaKg3pq+h81BqB9wcraipS9guSPJ/YUmWGB9JQ/UZ1zFL3LMNiL
	5rx/6kuRYU9c=
X-Received: by 2002:a05:622a:4c16:b0:532:9cd6:2184 with SMTP id
 d75a77b69052e-532af5ca677mr3511171cf.6.1789760520919; Fri, 18 Sep 2026
 12:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aq2MQLKmyrxkFd0Y@eldamar.lan> <aq2O42fwBRdHELBC@eldamar.lan>
In-Reply-To: <aq2O42fwBRdHELBC@eldamar.lan>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Sep 2026 12:41:49 -0700
X-Gm-Features: AcwNN1Xo9CcFDvMIoZjCpwlNo4XAEGxqbdgx0v6feQC5GXfhUVaYP97hIbvrbVY
Message-ID: <CAP-5=fXL7comAJeMbcWKkT=Ju7NyEUFnWfTvY60SxsSeazWDLQ@mail.gmail.com>
Subject: Re: Please backport subset of 2f5d370dec3f ("perf test: Change all
 remaining #!/bin/sh to #!/bin/bash") for stat_bpf_counters.sh script to
 v6.12.y and older
To: Salvatore Bonaccorso <carnil@debian.org>, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:20=E2=80=AFPM Salvatore Bonaccorso <carnil@debia=
n.org> wrote:
>
> Hi,
>
> On Fri, Sep 18, 2026 at 09:08:48PM +0200, Salvatore Bonaccorso wrote:
> > Hi
> >
> > Recently for v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52 and
> > v7.2.6, the commit b02027776ac5 ("perf tests: Fix flakiness in BPF
> > counters test on hybrid systems") was backported, but it introduced
> > bash specific syntax.  For versions after 2f5d370dec3f ("perf test:
> > Change all remaining #!/bin/sh to #!/bin/bash") aka before v6.17-rc1
> > this is not a problem.
> >
> > The proposed patch is a stable series backports specific one, as one
> > cannot simply backport 2f5d370dec3f ("perf test: Change all remaining
> > #!/bin/sh to #!/bin/bash") without picking as well some other context
> > related changes to make it possible. So I was proposing to only change
> > shebang to #!/bin/bash in stable series were it is a problem, as in
> > the stat_bpf_counters.sh script.
>
> "Obviously" there was a typo in the commit message and a missing
> explanation, thus v2 of the proposed change as follows.
>
> Regards,
> Salvatore
>
> From 804ae26dab32c846467d7b7887d8f7dcd3348fa5 Mon Sep 17 00:00:00 2001
> From: Salvatore Bonaccorso <carnil@debian.org>
> Date: Fri, 18 Sep 2026 20:48:59 +0200
> Subject: [PATCH] perf tests: Change shebang for stat_bpf_counters.sh to
>  #!/bin/bash
>
> When commit b02027776ac5 ("perf tests: Fix flakiness in BPF counters
> test on hybrid systems") was backported to several stable series
> (v5.15.221, v6.1.188, v6.6.157, v6.12.110, v6.18.52, v7.2.6) it
> introduced specific bash syntax. For versions after 2f5d370dec3f ("perf
> test: Change all remaining #!/bin/sh to #!/bin/bash") in v6.17-rc1 this
> is not a problem as the shebang was already changed to #!/bin/bash. For
> the older stable series this introduced invalid syntax if #!/bin/sh is
> not bash:
>
>         $ sh -n tools/perf/tests/shell/stat_bpf_counters.sh
>         tools/perf/tests/shell/stat_bpf_counters.sh: 12: Syntax error: "(=
" unexpected
>
>         $ checkbashism tools/perf/tests/shell/stat_bpf_counters.sh
>         possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh l=
ine 52 (bash arrays, ${name[0|*|@]}):
>                 base_instructions=3D$(perf stat --no-big-num -e instructi=
ons:u -- "${workload[@]}" 2>&1 | \
>                                         awk -v i=3D0 -v c=3D0 '/instructi=
ons/ { \
>                                                 if ($1 !=3D "<not") { i++=
; c +=3D $1 } \
>                                         } END { if (i > 0) printf "%.0f",=
 c; else print "<not" }')
>         possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh l=
ine 57 (bash arrays, ${name[0|*|@]}):
>                 bpf_instructions=3D$(perf stat --no-big-num --bpf-counter=
s -e instructions:u \
>                                         -- "${workload[@]}"  2>&1 | \
>                                         awk -v i=3D0 -v c=3D0 '/instructi=
ons/ { \
>                                                 if ($1 !=3D "<not") { i++=
; c +=3D $1 } \
>                                         } END { if (i > 0) printf "%.0f",=
 c; else print "<not" }')
>         possible bashism in tools/perf/tests/shell/stat_bpf_counters.sh l=
ine 68 (bash arrays, ${name[0|*|@]}):
>                 stat_output=3D$(perf stat --no-big-num \
>                         -e instructions/name=3Dbase_instructions/u,instru=
ctions/name=3Dbpf_instructions/bu \
>                         -- "${workload[@]}" 2>&1)
>
> Change shebang for the stat_bpf_counters.sh script to #!/bin/bash.
>
> No upstream commit exists for this change as for versions post 6.17-rc1
> the scripts were converted to #!/bin/bash already.
>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>

Reviewed-by: Ian Rogers <irogers@google.com>

This should have been caught by the perf tool build as that build runs
shellcheck on all tests when shellcheck is available. Maybe there
should be an action to run perf builds as part of the stable backports
when the tools/perf directory is touched.

Thanks,
Ian

> ---
> v2:
>   - Fixed a typo in commit message: hanged -> changed
>   - Explicit state to what shebang was changed for stat_bpf_counters.sh
>     script.
>
>  tools/perf/tests/shell/stat_bpf_counters.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index 76d4a7f15a43..c4f71bfc0fc6 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # perf stat --bpf-counters test
>  # SPDX-License-Identifier: GPL-2.0
>
> --
> 2.55.0
>
