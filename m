Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C61A3166
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782050326; cv=none; b=mNlVx04SdJYdXt8lwR3iisHxXuXuxJG2aDCRWGohhDdxQwk+tDXVC9Ry0A5lLNgOF5FZTuDTDM0v2VkvFTdpgv4EL8jkTG/Q8eVLCJuz679nzNhhrxukuVCBhhMMNYwHf9wdZ9Nq6b4Pji70VLrqCr20TiNJLMPBpBfAiQD2HE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782050326; c=relaxed/simple;
	bh=3qL/0xrd9bchHC+0B3Uv/kjtp9P9wjqQNfv/CHi1n/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAk8FH+MreraOaR58AWqaV37tlABBqfgKMJ6tp/Wio9mXa8e1Mc7VV9u1PgNq2CxGGYy1tc8hMf1PiDySWFxarT3o9lJa1auVDJTv3zai+EOewuPymHMCVWBCQiprjaQ6QEKMC5WCWkxDafrZFfEmu77nPhFKpjyObhlxu5J2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5hWy1ir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5hWy1ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B511F00A3A;
	Sun, 21 Jun 2026 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782050325;
	bh=3hOZ/uxPHZgVX7/9+rDM1vgttk5sp+Kzrpl787XorcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5hWy1ir38E4ks0eHosVqTIPVotxlOhJ2f6cyl2Za5WtOlKCNgMjX8pwtA1bZ6A9p
	 NGXzz9jxjNmDsUl16+Jkin3BmGpn47fcDlKAOd/R8se9PZjLAPiQGK2SjvdhNlrt3x
	 vuA5WcMQ2UHVZtDJMMDK06GS9IDiHz0+OWiclPo9s3AJLVnXrX8IjeT09V9grsl5kt
	 DnfZxJL20O9T5sqh6sufPqTShU4HlpOiL3L4NhBtlE54YTtIsDMHs4G2nuJuXy+DzI
	 gwzXuYd3DAOmBlMic7BJDVgdykzv9YwA77YsIRo3i5ds5VjMjLD8iGRcV9eqVopZly
	 I4G5P1bB0EtAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please backport d289d5307762 ("ip6_vti: set netns_immutable on the fallback device.") to 6.12.y.
Date: Sun, 21 Jun 2026 09:58:37 -0400
Message-ID: <20260621133722.0010.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ajJ6TSzxuWdfQkxf@eldamar.lan>
References: <ajJ6TSzxuWdfQkxf@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 17, 2026 at 12:43:25PM +0200, Salvatore Bonaccorso wrote:
> I have a question: Given the commit say "ip6_vti: set netns_immutable
> on the fallback device.", but this won't be anymore a correct
> statement, should 6.12.y get a "dedicated" backport instead of
> claiming it the upstream commit?

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
