Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193758;
	b=Or/ODesrPYhHIV/PuwxQ3Okf8LBeoyChQCbnk4hABC7O7TR7gkA4aMt2llDpF8q9qMPx
	 L4US0meL8P7DmbzsttkvaTgHeuuG0jI/Fv51EJIRiT5dBnqJ6QUtt40eClhIgbQbIeCDh
	 hrQ1psfluGLJrQgg2GBNWOULCqAt+4Vk2kMQKZV3DlvHN1RQi6+cx5B9K8du+ACiiP1WW
	 fqdrkDE4aU1L0XscCAerk5O+z6fRTeBLg5La1C9ry+Fwj1HhNgGfmaDVqEH026GPoDPAq
	 +NsTdBnDbH0/cX+2CAQzccPVM466P3HxgRLaHxtUvrL/MBgeYW16CGX0nYPJPgKjwMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193758;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BJDYdb4P/olInFrA40dkka0MmC2ZyiMvcWyibk/vzAM=;
	b=ZHvUZdK3sQPKRbolunVdrLaY/6Z8ymPAIiG0d8VjR3OUebe3+tSuxmeZG4njAcYCBErO
	 ZnEBldSxrM1dyq5XNUBu7GZ0HjGt/Iwn5TkCZcFPvd2wfCtlhyd4b1KOe5PuKG8SJ1yCQ
	 OtVW/28P4T831xNRSOBQsJ8sOpEzWdLtBbinNSmNwaifB/OfpIQTqNEdC4I+CUrCxmphM
	 uCsHL+03dbD1AUc1j6SWCs1yJr/QsDa9FVMNRH6YZZZHtP3ekiI5mdL5LEzLlA+aYZGFW
	 6SHGVeKeiVJZ26STSXBA+QMPXv2lgNaKzU/7Jvsd9uATn9+gpAOFif6ahBa9OGCk+og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fq/5IE27";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983060A2617
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq/5IE27
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4956B1F000D4
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193757;
	bh=BJDYdb4P/olInFrA40dkka0MmC2ZyiMvcWyibk/vzAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fq/5IE27WvzJMFscUB1bCw5izPLaXn5+97xW9bYVUY++ukPf28cF2J3YW7pHuwy6+
	 OZuIn0GixT0+2Ik3bzniOVOiNdDoUfJ0yl0RIkpex/zP8u/VSH/77qoqnk+Vy2mCie
	 f1vsDqOhccB1MOrynxCT6XMSil+NhUPvxLvPE2j1yGULwVIb65VR1IcZhlX8/gHgTf
	 qcuA98BdzefYqnUl6S/gWFd+iu0vXIojG6ewN/nBcQl1c4RuhSzbHxKBXw4r3BK8aV
	 uHg69tEzL4t6d0JhJx4CEIl3tMrTfMNYD93HGxOqbhbK1GzAKINIZb+MYHHteiYiva
	 1xeZlqvOcTkAw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ae1fd4252fso11008871fa.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:55:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEFnalA2BKQBO75iUm1IJTYQlvxeIYbtm/i+i39nrlPGRR/HSQXS2H0Ly8ZO4OlTrDNenaQiDI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xQeqz5eJ6rbCFW41q3YqQ1CGfT/Bm0a77fnP5mmVwtnkZInmG
	BJ074aNWaitrhS2HGzxjOsjwDXRXZ7P5ZGsQzOXYiS/IxsBoLhHYWlfsWBOZrCXxPyMLZWGu+cJ
	ydZK7zAiurII7yeRZABiB+Q5/W+70KNo=
X-Received: by 2002:a05:651c:542:b0:3ac:f258:618b with SMTP id
 38308e7fff4ca-3ae7f9a05a8mr13045271fa.6.1795193755714; Fri, 20 Nov 2026
 08:55:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113163951.1510082-1-gyokhan@amazon.de> <avvmWA6YX2I-ovJy@vireshk-B250M-D3H>
In-Reply-To: <avvmWA6YX2I-ovJy@vireshk-B250M-D3H>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 17:55:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0huaCmgy127J-5_V__dCCgJQg-w9NzQBA-zhHdjfHjFTA@mail.gmail.com>
X-Gm-Features: Aa3M54qGvidR4YxFoTFAjVhSP_68rz3ap42qWF3hFBaP-5_P7AZDLHhLT31-6cc
Message-ID: <CAJZ5v0huaCmgy127J-5_V__dCCgJQg-w9NzQBA-zhHdjfHjFTA@mail.gmail.com>
Subject: Re: [PATCH] selftests: cpufreq: Disable the runner timeout
To: Viresh Kumar <viresh.kumar@linaro.org>, Gyokhan Kochmarla <gyokhan@amazon.de>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 6:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 13-11-26, 16:39, Gyokhan Kochmarla wrote:
> > cpufreq_basic_tests() reads and writes every policy file, offlines and
> > onlines every non-boot CPU five times, and then shuffles all
> > frequencies and governors of every policy. The amount of work scales
> > with the number of CPUs, but the test runs under the default 45 second
> > kselftest timeout.
> >
> > On large systems the hotplug loop alone does not fit. On a 256 CPU x86
> > machine each offline/online pair takes about 0.5 seconds, so the
> > reboot_cpus 5 step needs more than 10 minutes. Even with the timeout
> > raised to 180 seconds it is killed in the second of the five loops,
> > and the frequency and governor tests never run:
> >
> >   not ok 1 selftests: cpufreq: main.sh # TIMEOUT 180 seconds
> >
> > A larger fixed value would only move the problem to the next bigger
> > machine. The basic test has a fixed number of iterations and does not
> > wait on external events, so disable the timeout with timeout=3D0, as
> > ftrace, timers and net/forwarding already do.
> >
> > Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second time=
out per test")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
> > ---
> >  tools/testing/selftests/cpufreq/settings | 5 +++++
> >  1 file changed, 5 insertions(+)
> >  create mode 100644 tools/testing/selftests/cpufreq/settings
> >
> > diff --git a/tools/testing/selftests/cpufreq/settings b/tools/testing/s=
elftests/cpufreq/settings
> > new file mode 100644
> > index 000000000000..d3e07370a7e4
> > --- /dev/null
> > +++ b/tools/testing/selftests/cpufreq/settings
> > @@ -0,0 +1,5 @@
> > +# The basic test hotplugs every non-boot CPU five times and then walks
> > +# all frequencies and governors of every policy, so its runtime grows
> > +# with the number of CPUs. No fixed timeout fits every machine, and th=
e
> > +# test always terminates on its own, so disable the runner timeout.
> > +timeout=3D0
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.5 material, thanks!
