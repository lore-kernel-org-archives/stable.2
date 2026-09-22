Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73655D897
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091544; cv=none; b=F9uOAIZtg2tap4mweCXJhHOIZvf+MchwJNeORiGg9nsycnD/SwcnIFw3s+qwqi7cp6NUKTjqd6R0SdmWx1u4M4haL3HoAA2t8Q12G85wGCmK3TYomymHLnALp8KVVj0WPnIGMCgGqWtDKrzKfT1wZ9PdZhhFTzz0qFXMj/vqKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091544; c=relaxed/simple;
	bh=KWTZxSe3jNf1DG1Dv8H4CK/gODfRCeAfnjXIQirw7u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2tcwqM75waTN/KQ+W7KTgLAomPPUgOJmGqV2NcQ5jEB2P29X5M4aENs6fEmKaj25kr4e/pFz4AvCFzLI/D/ocsdqieURfrVwNTp/r8gi31kXUOUnwXt5o+kElFilqyq6ZO0gngA5FYiJUyp7VWd506c8gNFJv5mQV8JEhduC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYMGDHRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYMGDHRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012A41F00898;
	Tue, 22 Sep 2026 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091543;
	bh=H+ivCIsNDT72uSFZt13rK2C9WJ9C0ULuVDmM21xOhAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MYMGDHRatIfV8x1M9jXDWfjfJYpLbOCmfkeefudQ0ukZE8OneinCIBoHBantyXToe
	 o/VSFx1W1PPXm9fGso8ylpJn7dkfXhnyYaHxH3QVImSewB1no7J4EthA4UePzG1c5t
	 m68KE5X9Aj73V1ZiBaQZk54h/jAEqIVG7xVNC4mnQF0/QbtoE4HG9Nms3HH8auQQ6c
	 xfUb9whgFvNZ9DQNjFBtk5Jbe16EbLdh+h7T9o4nvFJqPwXgPzrkiiXtRPMrVpGGuq
	 R12B+27+7vBkwsh2ea61TxsPTPOlA0q2vBDOrqA6/iz5QYgcxcjTSi8HheqNqdSuQz
	 kYbSFD0dNioAg==
From: Sasha Levin <sashal@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [linux-6.6.y] 6.6.158-rc1: stale ASSERT_RTNL() in __ipv6_dev_mc_dec() WARNs on IPV6_LEAVE_GROUP
Date: Tue, 22 Sep 2026 11:38:54 -0400
Message-ID: <2026-09-22-daily-reply-0001-re-ipv6-mcast-assert-rtnl-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921074753.GC13965@francesco-nb>
References: <20260921074348.GB13965@francesco-nb> <20260921074753.GC13965@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could 98363feee39760011bd2225558c0fef9487c449f be applied to linux-6.6.y?
> Or the problematic commit should be dropped

That hex is not a commit, but the rest of your analysis is right. The
commit that removes the stale ASSERT_RTNL() from __ipv6_dev_mc_dec() is
e01b193e0b50 ("ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec()."),
five patches earlier in the same series.

The RTNL conversion had already been dropped from the 6.6 queue on
September 19, so nothing with this problem shipped in a released 6.6.
The full ordered set is now queued for 6.6, thanks, and 6.6.158-rc1 is
the only place the half-converted state existed.

-- 
Thanks,
Sasha
