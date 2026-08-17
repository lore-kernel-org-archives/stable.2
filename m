Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5D440A25;
	Mon, 17 Aug 2026 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980289; cv=none; b=ffDTGqKLcErbws5ucIWCUlCDSEaUxTTs36kEE40Epk99bKpM0qFYhqUKQNUbuPWsUNhrQpf1iZX83nY1G80YY3J0UuIJyyTjCCusOVFH9G+HuNr9pHZ90HeMa/Elk7lowi2JYFnQ5sgdBO5LFn/TizXdoG4YG9bzafXDx2TKH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980289; c=relaxed/simple;
	bh=b08zChp0o29dodsssb6TkSggxUxNj5Udb6Jvc8WhoJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNgQzsnZf7tyVh1kJMoXgfVYaxhjyckzR/BNIH3EA6oaFIzPwr7v1BrKGKt3oLykwFMZigYL56lPQpp0KU/nAWpUe3W/ylfGuDtKfs7eHPkR3fhfbJKCOovP+uwV/VU88H5e9GiCIqRqQsGwHbVB9QE8RiF+LwHsooBFsu60uTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgZ80qrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgZ80qrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7BB1F000E9;
	Mon, 17 Aug 2026 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980288;
	bh=FuPzUDmQKbOowTX2ptTEZOqxyo+PviRTDwqmhrgRh+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QgZ80qrQ9uknhgs079rAM4s2WVxww1TwsfuiqFRMOFCN28qXd8abOb3wvgG5yWdkD
	 1DsA8fZg9beYfIzltSo0QUxMtDgh5tGQtebrbIq9/Ns4zXWa14EAEPI5vE+0v67/yX
	 TQ5tv5meh6F5KzEdTDaTVwcAF3p7pcyGBN0U0HM4pA+oCMbeXHfDSGMkHjcrhWfXDK
	 C9PFHbmw/vtDDEotpzYZaAFESlBn1N7AZF9DTkGHJrrB7ZvcGkggnEl9GOzzP36cxI
	 krUe0Bw3o8/CE1myC/4S0Q9N4bVEL0UEkJuXhGJuo+F5SVfgNVgN6KMpGSAgOd9g5C
	 IS4P+aLSpXU+w==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Peter Jung <admin@ptr1337.dev>
Subject: Re: [PATCH 7.1.y] Revert "tracing: perf: Fix stale head for perf syscall tracing"
Date: Mon, 17 Aug 2026 11:24:40 -0400
Message-ID: <20260817150000.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816133101.83109-1-admin@ptr1337.dev>
References: <20260816133101.83109-1-admin@ptr1337.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The 7.1.y implementation has not undergone that restructuring. It handles
> BPF and perf consumers together, and already reloads the current CPU's
> perf event list after syscall_get_data().

The analysis checks out on 7.1.y: 57918341dd19 ("bpf: Add sleepable
support for classic tracepoint programs") is not there, so the added
hlist_empty() early return runs before bpf_prog_array_valid() is ever
consulted and a BPF-only consumer stops firing.

Since this reverts a commit that already shipped in 7.1.6, I would like
your test result before queueing it - you mentioned you would have one
today. Ping the thread once you do and I will pick it up.

-- 
Thanks,
Sasha
