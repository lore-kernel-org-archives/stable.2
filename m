Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976441B8EC
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051119; cv=none; b=sMRr9RkDqJ8zY8gKK4317OCKbhGU1ZvZP0bITchrmEVwqpfExsBrd0jI5UcMXugePM5/lVW5NnapoYJFN/n/pyPBFlNydK6Kt+7sWDjD1OqAru74eldkVgMDOtTfcp8SWTwPnqohKt8jBrdvkiLc/yVfFCobXXdN2Dl8TGCjRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051119; c=relaxed/simple;
	bh=omYC/0CsEWbjCXrhWXnCRdSCMvvNYHrVSNaA5Kh2WME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzNYYHYNZQ2HlBc4UGZka19iEDw3wjFVJ6mSf5qMor+I3ArYwDIJonDMw53OIa0D6iRGPGzbjw2gp+xB6kUqvntmPxksg+mz+zY0lK6oW0rUY7rmnBYZl9tpPx2+ly9ixDWh1L9g0UrjlCsL6SZQGzhhAgESZp36ncdOOG4EXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdY4ykLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdY4ykLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DACE1F00AC4
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 21:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786051117;
	bh=7iK461ESpNVqLm9X3mINmjVFtgPa61Ne86Hxh9FvtdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MdY4ykLfCOE5L1anriEHxDSQWaxYawwnXuTy6R9nqDGCksSj13W14Q3Blv0o2Yqbc
	 /kLP75p0VjAXXJelRJuXaxhAfJwiV7mLTk9pJOMkxIez+0UXQb/4daKjd2hYQthjXc
	 S/3ubeTLb1LiymIdN7FU5HLsSJL/IeyUduKRksbgvo20QtdAk5ECW7H514hnpJoy+8
	 p0iGPcGCJ6FmEroi6+Ku4MhIR0QdFJDb133TKcxW5wQPp5nJN9bB+ClZZ0RDgrDU3L
	 zTF/HNjTth5vrWLYFSNbAe9vApJWfgvC/yP0oT6dG0V7DJKkHajhgp0BCno+GWPs5l
	 eluT0mPRgedoQ==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93108a3c326so95287285a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 14:18:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq2MllYiM65X/Svm6W2VOUr1omkulMQTCQcml49rc7yrxcMEiGSlAJZ6YPpOsOnNXyz+jFlSIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgREiw6lmdMeuoc2+SMUz8KWL4k3xQ0rYC6B81U/3InraTOd6
	0ac3e2+fVeFI0kOyjnl+xhuEToUnL0rWAjHtvki+i6SocDBhKbGXEe+Zs1B7C9mzzWpFs+PUW1S
	JnBD76isJFeWHsIW8HEvG9vAk1owdA/I=
X-Received: by 2002:a05:620a:3d89:b0:915:92f3:54e3 with SMTP id
 af79cd13be357-9365945e9demr809487785a.4.1786051116804; Thu, 06 Aug 2026
 14:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com> <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
In-Reply-To: <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
From: Song Liu <song@kernel.org>
Date: Thu, 6 Aug 2026 14:18:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
X-Gm-Features: AUfX_myLm4rrhFHB6ribxegz34WsGyCezFjywzASsvUedhjj05jmJkbjlTkIwlw
Message-ID: <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz, 
	jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> kernel.ftrace_enabled=3D0 is now refused on kernels that deprecate the
> knob, so the old disable/reload flow no longer applies there. Probe
> for this with ftrace_disable_supported() and keep the full original
> scenario (disable, fail to load a livepatch, re-enable, load, confirm
> disable is refused while loaded) on kernels where it still works;
> otherwise just confirm the write is refused.
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> ---
>  .../testing/selftests/livepatch/functions.sh  | 14 ++++++
>  .../selftests/livepatch/test-ftrace.sh        | 45 ++++++++++++-------
>  2 files changed, 42 insertions(+), 17 deletions(-)
>
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testi=
ng/selftests/livepatch/functions.sh
> index 30dc677b2f45..a65b7b1ac8ad 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -126,6 +126,20 @@ function set_ftrace_enabled() {
>         echo "livepatch: kernel.ftrace_enabled =3D $result" > /dev/kmsg
>  }
>
> +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=3D0
> +#      can still disable ftrace on this kernel. Newer kernels deprecate
> +#      the knob and always refuse the write with -EOPNOTSUPP.
> +function ftrace_disable_supported() {
> +       local orig result
> +
> +       orig=3D$(sysctl --values kernel.ftrace_enabled)
> +       sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
> +       result=3D$(sysctl --values kernel.ftrace_enabled)
> +       sysctl -q "kernel.ftrace_enabled=3D$orig" &> /dev/null
> +
> +       [[ "$result" =3D=3D "0" ]]
> +}

Since the selftests are shipped with the kernel code, I think
we don't need to handle backward compatibility here. Instead,
we can just assume disabling ftrace is no longer supported.

Thanks,
Song

[...]
