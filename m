Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566677;
	b=da8DKOBRU/N1Cp1A9xlN8oS6Dq9yXeaAsFqimLG9uTHDF0vzzWrhHag5dEeNSJDAiP0o
	 /HnZFrk9RjttN/my9ihZJs253IjOWopk44LObAs11z2JMssH7Kqmh9j+1AdK2OM/0GoHk
	 l98svdjA8KDGaKC4NveE/g/EtGDKidhugIKg+KNZLoZsg8r8XVaC8tm4nJsUXz5rAQGfM
	 7kjK3RFBAhlvcVPJDZ1EOTo+BgGczBLhE049OZ9MUNRgZJweSELE261M6TV8RwLkjS/zx
	 zszvZH/o759Xt85iFghuA9K8o3JNobRPj/mh4E6tfL1vzXNeDO5ELgguqEOR6y+/u2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566677;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BN2F9s2PQf7tU6RRltR0YAnwJkqk291xnopYpp+Hfyg=;
	b=oO5LFfATgO3KSjqbblvpi8b5mKCnhqr1PJ0kPYrrNeTPLt4sanijjswDtVr2TqDp1fh8
	 sqle3SqljYGxvSt5zUsOytl0feEph4hnDbiD1sBqApdLMXMHpMIjgzIg0rNeJJhccfYD/
	 aiqFQnxpwhC+gFaEU8su4/d0LTeSuEaen/2OviniOaAghN7k+xYQarwWGmr2CmgKydHH5
	 L+VDMcMm2RHTMshM1R1UcDnfUqZd3+evouyZJbDVZXP0X+I4lCtC7TMRM5eshrHO4zQxn
	 bf0NDrXsQ33diIow8bLw/sy1Oh54Y9wyNiEbBP0Yg8X0mbTHbV7U15Z1jyP8ym0GrEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BRe/PYyI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B324606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRe/PYyI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AC71F000CF
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566676;
	bh=BN2F9s2PQf7tU6RRltR0YAnwJkqk291xnopYpp+Hfyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BRe/PYyI/yoZt1u1HTXqkMKwn53SBdSNEWGEZXaqXNZRmgxSwtGDCDU3NLJNp4lLe
	 UQ7UUtY6CiIMJQEGhHfalMlnPMKDjR2awTM9X3t2rm/7+7CkfmcWPh+LdUUTdQKGkV
	 CoyN996FXe6EaDngUpMBPP9OFImd7wnahwzcTxqszYTcW9us7AH6STAZCY7cF6Lamj
	 y7flrENpCm/4ZQd8tFy7bOpKZACJyUfCd87EoIegqy++4B+OIjT0rYaUTtUlmGrf1h
	 AtPg0S888b7IhdWXUHOyp7uq3eM1Tm0QFkANgsDfzhr28XrftjqMCIHccr9X80Uv6Q
	 q/el+e913uPJw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab01c46697so3365661fa.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:11:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByjwwwROiMrmaZxouato4pzVv8+SBkLMr5dlPwKp03620yLHo9gs+vORhywi/qFfv7fD7sOJGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLB7ffBiGzGSOM2Io8GG0YZ+NnZa4MrUFhg26NTv4XvdntSQ02b
	hwHqBGar9l1g7XcqKWjmID0Z7YCsBfPdUCUvi9Xo34fKXYo1o2hmueq6KEiyk3npATPmNyHKozZ
	CwfSRtVovYNvKWehqwoOJrP9kahGXzZY=
X-Received: by 2002:a2e:be10:0:b0:3a6:692d:b7ed with SMTP id
 38308e7fff4ca-3ac441af820mr3582211fa.20.1792566674920; Wed, 21 Oct 2026
 00:11:14 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020230358.6649-1-dennylin0707@gmail.com>
In-Reply-To: <20261020230358.6649-1-dennylin0707@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 09:11:01 +0200
X-Gmail-Original-Message-ID: <CAL4WiipjUx57YcOPpeOXmwC-Pd-+S65cNzRgR15b1hXn5vX2fA@mail.gmail.com>
X-Gm-Features: AclHuK9XkTKE8LY4XXIySiR2Hxl3nqPuxbPFC__w9yVfrKZoEw8taewo9nbjSAk
Message-ID: <CAL4WiipjUx57YcOPpeOXmwC-Pd-+S65cNzRgR15b1hXn5vX2fA@mail.gmail.com>
Subject: Re: [PATCH net] dql: Reset the adjusted limit when resetting the queue
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 01:10, Hungyu Lin <dennylin0707@gmail.com> a =
=C3=A9crit :
>
> dql_reset() resets limit and clears the cumulative queue and completion
> counts, but leaves adj_limit from the previous queue lifetime. Since
> dql_avail() subtracts num_queued from adj_limit, BQL flow control and
> qdisc bulk dequeue can use stale credit after a network queue reset,
> until the next completion updates adj_limit.
>
> Reset adj_limit to the new limit as well. With num_completed reset to
> zero, this restores the documented adj_limit =3D limit + num_completed
> relationship and makes the configured minimum effective immediately.
>
> Fixes: 75957ba36c05 ("dql: Dynamic queue limits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---

This looks correct, but the stale adj_limit only lasts until the first
TX completion after the reset, and the =E2=80=9Cnegative=E2=80=9D case matc=
hes what a
freshly initialized queue already does.

I do not think this deserves net and stable; please resend for net-next.

This will have to wait for net-next being open after the merge window.

This looks like some LLM stuff to me, with absolutely no real world impact.

pw-bot: cr
