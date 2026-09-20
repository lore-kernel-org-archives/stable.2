Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F73D8902
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789942323; cv=none; b=V3VitzhTB2wxoNOb4xSs9pqnK5sKRi8LYSSyZ6zta/gSdOJYMX0tbOr426i+PlyVxFrYTb2D3Y5uH+Jru1z/qMWfx8q8SICvGWIgSQXXSRN2m5wovcm7/gcplWi4eDxkzBQj7JQ7YC4ACZvwQdI8BmpWVodSMGYir8j1q1JzT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789942323; c=relaxed/simple;
	bh=m3SexezWYsSk736W38SFqu2ziBc1JJcqhx3pO3GqO7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex2EVwTvry8QaMlcWMb5DPF/X4LrAEdwRQrRaC4th5sztJboJqRG4Ae+ZIcjzmTPyvVVbDjCrsWmT0qwdE3ezP1E55Dnaouv12m2cia0X9LXkkIbuoFRMjC0Z0UlKTr+LScDKtJwIsyyA1De5Omh1juhFE4v4p8ZXzee5AJRx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va0mnB4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va0mnB4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BF11F000FF
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 22:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789942321;
	bh=m3SexezWYsSk736W38SFqu2ziBc1JJcqhx3pO3GqO7o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Va0mnB4vLEyC7LJ2ZpPkd0pwrqVfYBJ9sNmipn+W9tqa6FO+hGjy0ZC281X0iHmmi
	 xBAUUrCicU+YmUk3C0ZLj97QAFbpogDQ72J5vuE76Fdsf56mr9BBmLba0wh8PGRLZN
	 tfbFZeFZzAQY7MvZ6IJCC514QoqDtCUqs3khMY9/jqnarpokdxEnHY919U4Bnt6bV+
	 2Y9as+qCvkfiOjLvdun+cZ5JAQZ/TLqzJThMWI+Zzh51oawtNtnmN+G+yJfhLq0Idv
	 NnijKuSWnKcC+3d8gDWY5MODpDsCTBKOlyyDDNxXa3DCrOBzwqr1pEH2ve9yz1kueI
	 agBgHuknu2AqA==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c5231570so1931638e87.2
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 15:12:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxHVBkdiGGzAWNPPPHabr1+RX6M225aEblyPPjMSM55NmS7bQ46Xz/QgOduvUUthBQsGZG6KdM=@vger.kernel.org
X-Gm-Message-State: AFuF++ntImN3Ew9j8p7lOS4JE1FCgYbQ8wZjE9cnSx/J0YsyacURkV8k
	YZmUeuo93e6kp3eC9cKpFmq38PJh14amAREsZUxsT7w2B95hZfte3eXZ/A388dtaSlUKEuJosVt
	YfvxopMmJVTZITTJDFP5MIz9lts2lyEc=
X-Received: by 2002:a05:6512:15a2:b0:5b6:1a7c:59d1 with SMTP id
 2adb3069b0e04-5b8c183fd80mr2413485e87.43.1789942320496; Sun, 20 Sep 2026
 15:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912195552.76673-1-kmehltretter@gmail.com>
In-Reply-To: <20260912195552.76673-1-kmehltretter@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:11:47 +0200
X-Gmail-Original-Message-ID: <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>
X-Gm-Features: AcwNN1UEg-rAjFzamwNmqUNbJToIegygFu5WJqv4Wp0FbND3-H0NPmWS64QMjAA
Message-ID: <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: allocate the cacheinfo early to fix the
 PREEMPT_RT boot warning
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Dmitry Baryshkov <lumag@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Pierre Gondois <pierre.gondois@arm.com>, 
	Radu Rendec <rrendec@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 9:56=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:

> The series applies unchanged to 7.2.6-rc1 and v6.18.

OK please rebase on v7.3-rc1 because that's what we're working
on now.

After posting that I think you can put this into Russell's
patch tracker.
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
