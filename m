Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797157;
	b=XsywHw1z3m1GemeT583UL4C6VcRoZIhHzz7rg3gPGEOUC84FH5GAdXlCZDHBCHdHqAkt
	 HEvR0oY6z9uB66k1dKvZpnUjLPyY8wDCbamPNOnGoy3T4IF0jWlet6FM3V9hzBppd4qWI
	 a7InkoaCtG2m+0a3wGZPai2UI9GUPc5VmysobY56VHbHrEKQ+EhNaFJXOWRT4VqW0WhPy
	 4lvwUhZREsjO+ISyi0PwgO3eRDrMuyd/KBljQ5Qcioq/5krSHORriyunIUBXEYf8P+uRZ
	 ieMxvcGJaouQ7828yhWklRB06jr1a559tsQYdDUc78zyNHEhCLiaEj9NmxQN1o/7RkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=KqxiA3lLXIGYrb6Orjr2tvhyCTxjiNV+pkKH8a5JfkzshV/b9Suil36gHwqe7tFA0KL5
	 5bKu1pGkuZIaHpAaZVknzr+56t7xhpZs3f2rlzijam9ssy/utfhvMgGfNfxcbjTe3pDOe
	 +zVZ6OqjoiobleS9ZKHlJgdE/W4F5dg7C5/UT7xUo1OydfF/Gu9B2193SuXweW+lSpIXM
	 0Kt4g9zYH/BJ1yFn84nkYRtq6xSXdoM6RGRZId8qfC+a0tbM6AdRewkM603Dr5t8pV7/o
	 ilX1DTCa7Lt3S9orYwJ0Dxk7jr432iEky12jLGA2VHZDJmu6sSByfylolR1+6ex85ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUlp63ag;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD619606A32D;
	Wed,  4 Nov 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUlp63ag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23D01F000C1;
	Wed,  4 Nov 2026 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797156;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUlp63aga3UMVDyqh1ngWGRKLBYgpglVjpk6DY2jECK+glhxVlW8a51KARWKCIiW7
	 GVuIG+JRY0e5y1MmhSUllt/IRDo6OxpcKSHR89g++p/QzdvnUDsG6pvPmGPhGY2krh
	 8zlvNuXLO7TKulDQIR9e8vvci4D5GmqXvRqq2kaAyb2ZbD2kx0fVMKbGIU73HkjBZ2
	 Q+5wBI7hwHw3FFiDSROX0nLJzuAWCeMu/4kJoR7gN9POKJT8OPk+PuIvYxsiy3+wGP
	 MauzuH2NiDtoYe9OCzYRUvImxH4JnhpZkIvVbMbBYsk1mGjtqBIfegF2ZwgAwjCvC4
	 vPKsopESK/5fg==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net] mptcp: pm: kernel: use RCU to free endpoint listeners
Date: Wed, 04 Nov 2026 12:59:15 +0000
Message-ID: <179379715527.488859.15110751341771291620@kernel.org>
In-Reply-To: <20261104125327.1041456-1-edumazet@kernel.org>
References: <20261104125327.1041456-1-edumazet@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
