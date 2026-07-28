Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E63B841F;
	Tue, 28 Jul 2026 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267814; cv=none; b=mVDtu2TQM1peJ5kaYw7i3nPIeH0xwDo2r57pOPGdy6EKak0wMVGbUhIoIY7x9s2V5v3sAzDHofobA4CqLNgrPKVq52NlqGbUK+w/h4CC5gSGHW9/WlRYpklnABRiJGcv47PPd+uX2u+ORHu+3+W5aIvQy0jZmxU597SUua+NTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267814; c=relaxed/simple;
	bh=7OpDyvNAJJTP7XbjoVlBAa07j/sNbsD2zHTTsWqizik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhgmk6sT3oqkh5GqVQD0dM1lRNV6pvNjk3QTmvdNKAllffYdVPxmVlNBktcIGzvVx4QIfCZ+09A4qjBD/gNZnkN8KQsXHzMZ1vg03YEtlqDYgqFIYeDh1HwnNbo2NmDOFwN/SxsYmxDeHpVU0dRtzD6PheZPHEps3FRxD/h2wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7pmtOhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7pmtOhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606011F000E9;
	Tue, 28 Jul 2026 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267811;
	bh=7OpDyvNAJJTP7XbjoVlBAa07j/sNbsD2zHTTsWqizik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=T7pmtOhYhCeMdagtqDQsyOlc2X6vHaiJHspQNb+xB/zoMsgG1RdtbXFJkZdI050Su
	 g1nCEhv9B4nuYI+y/Uhq/11t+ZoFpvb9qREHKZk6g3bBJ1ZmbVn3Pjg6HtSpHUtSuM
	 7QYNQuDYhXhbyBoX53XxJCgGYz7zgLNui35EPFGZhwLKSSWFN+bI+/bAviDKsTeeS9
	 MG+wL4uX8I5zaVeB7t9pukyhV/pNNrKL0t0wV33sC9Dv8Sg4Hu1eIk2diXrOXts5ZM
	 WD/hYQoLhy1H2jhygdPGDaPSr/6KqbYDO237nsDw0xL2qO4+fl8UHsW5dOvl7TjVwY
	 nAq458363yXOA==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Florian Weimer
 <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13>
 <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13>
 <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
Date: Tue, 28 Jul 2026 21:43:27 +0200
Message-ID: <87o6fqhpcw.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27 2026 at 13:23, Keno Fischer wrote:

> On Mon, Jul 27, 2026 at 9:12=E2=80=AFAM Thomas Gleixner <tglx@kernel.org>=
 wrote:
>> Reworked version below.
>
> Patch looks good and passes all my local tests! Thanks!

Let me write a change log then ...
