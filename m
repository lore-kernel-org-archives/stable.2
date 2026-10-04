Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0132B100;
	Sun,  4 Oct 2026 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131433; cv=none; b=glMvyW8wwi0FfSpEJFfNP0cmih+C/BWPu2mrSWWCeKTIox+B3g38IFCatIduvac+hlaTFdSRy/sniV7VOR+nO61r8/uctIArkRRXbiFqdRCCKLsJd2tP2aZvW0v7EK71moL6z0sxH504zCuexC3sRLHtfh0FRXoqw12pqo9lLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131433; c=relaxed/simple;
	bh=1PhH179gsuOt8b03NLM1uj8nRWinWC2B0Sk9mz2+GCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unc4A+2+liWcuqjHgcK6+ljEOtUw94h8p+OrSNzrIdSpNkTaPCusNeNRKERb9TI2jaMGlV6FjvFUBQxmHBaKD5hPT2eHw0FEcqRGDTxbC7WLio+yBwja2mzlRjWYpTvVWD13AEOZ14Ty8KQ5LikPcTy9OpMs1gS7Nh3ZEPerO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBK7ivaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBK7ivaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4611F00893;
	Sun,  4 Oct 2026 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131431;
	bh=SKrRD/RbvtksCwyJOHSUpOj7N0EZFsk0+D6uNzFV8a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oBK7ivaTxkhelb6UIfQYJigSjV+5VH29JhG+kaN+oMthfm1X87ZSP6TbcCxB/edkb
	 IFnBD8YNBWs/2cfsVM9TwwAdNApGxezhSG7lqa7ENQ6GRaDmZ7Kn3s205W0iY65NpZ
	 De+YsTAcIYO70pQKxPn+K5hvdXeFNqB2GBOF2poIQnexNgyUkp1WWJ/gqrHSilRwaG
	 0Tb6IaCGQ5mOfHzwl/McE7ij2x4G/7pyFd9AZpM2jCqLqfFMMpTYb+3+hzDotfnkTb
	 BJJbbKDdO7VfY6JKJrqF/N63H2rFsz3HFwq4hhxomG5Sl3CY5c5linB7grbD+Wrgox
	 xpet6mik0SKpg==
From: Sasha Levin <sashal@kernel.org>
To: Jean-Paul Sergent <jpsergent@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [Bug Report] fortify false-positive + real overread in skb_metadata_dst_cmp (geneve, gro_cell_poll)
Date: Sun,  4 Oct 2026 12:29:51 -0400
Message-ID: <2026-10-04-1-daily-reply-0013-skb-metadata-dst-cmp-fixes-tag@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003230533.1650829-1-jpsergent@gmail.com>
References: <20261003230533.1650829-1-jpsergent@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Unless you see any issue with using 3fcece12bc1b, I will post v3 with that tag
> once the 24-hour waiting window from v2 closes.

No objection, that is the right tag. 3fcece12bc1b ("net: store
port/representator id in metadata_dst") dropped the options_len equality
check that ce87fc6ce3f9 ("gro: Make GRO aware of lightweight tunnels.")
had.

-- 
Thanks,
Sasha
