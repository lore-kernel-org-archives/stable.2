Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1982222CC
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368864; cv=none; b=eIE+WhBKxo1xMccj2eTxptjQlnQ7BmMuTZInPRHWCLow7hWhJg2ygDhxr/kOrbudGHynyH/U5X+IQGWZFc6Bdjfp28r2P6rMXzxQT68ubwxA0hGmklQ0TKrUACHLFGNPIdtKvnXK1FF4QMt99oCCM1GlNGlDFi9S+Y0R9ozqXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368864; c=relaxed/simple;
	bh=wyoEifHU0eXEj3qPTg16+WpvrnzwjLB7koE4soUKSo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl80P9g/OkvFzTzK+9ePONRx2paS2VY8bRuC3i0fNmRtYgUv+Hl6ImyqHYJj5jC783I1WD0iV/qYVKfdbBsuS07hBBFC/Nb5zX02POVww+3QqOmLvdYlsd9oUqvWAF5j0zQcGoA+/IsPgABvG7A2LXp9rWJLdDB2aUFWv6oiYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9o/nmpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9o/nmpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B829F1F000C5;
	Mon, 19 Oct 2026 00:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792368863;
	bh=EwlkZjU3f9yv6DwfhewJ680pHWHwYAYUM3KrJwpF8GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A9o/nmpVnDaej//P4Sp8Nhmqkw/YYu6Wf3dLTtEZiXHFrz6VGXasPqxuVdhssOnim
	 9XrEr3OT1COaOuJe2iB0ntoNBLszTKbZk/jOFpT2BNPsn1pJKkydHsNNVtDp7NvTXh
	 eji9oQu70REq/TG5cNXVj2hz0EamaEof+FxTFrAuvXvwu9kA+JICsh6xCbnRpAd+Q9
	 SECD/YcWgTad3HaHXo++hEuOO9Kye1aEOGhmah+FcCSrVkFMARb0nt7yGdIqRDXbX5
	 rzRBMyaH2X+JjCwAOXoZTeflEluxfvwtz1oXtba7pZftuxWqzwcIR/oJr0nO+Zl++S
	 jQcn9iAEeymnQ==
From: Sasha Levin <sashal@kernel.org>
To: Harin Lee <me@harin.net>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA: ctxfi: Regarding recent stable backports
Date: Sun, 18 Oct 2026 20:14:14 -0400
Message-ID: <2026-10-18-1-daily-reply-0003-ctxfi-recent-stable-backports@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d19f3435-57fd-4ddf-9465-36f359c8b8bd@harin.net>
References: <e5b53e3f-02ac-4afc-9fa1-823ddb80875e@harin.net> <d19f3435-57fd-4ddf-9465-36f359c8b8bd@harin.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 Oct 2026 15:46:19 +0900, Harin Lee <me@harin.net> wrote:
> On 10/17/2026 4:10 AM, Harin Lee wrote:
>> For 6.12.y and 6.6.y, could you drop the following pending backport
>> from the stable queues? It is adding new functionality from my
>> original patch series, which was not present in these stable branches.
>> I don't think this change is good for backporting to older stable
>> kernels.
>>
>> a2dbaeb5c61e ("ALSA: ctxfi: Refactor resource alloc for sparse mappings")

Thanks for the report, and for looking at the stable branches. I dropped
a2dbaeb5c61e from the 6.12 and 6.6 queues, and from the 6.1 queue as
well, where it was also queued.

It was only pulled in as a dependency of 277c6960d4dd ("ALSA: ctxfi:
Check the error for index mapping"), so I dropped the whole chain from
all three queues.

-- 
Thanks,
Sasha
