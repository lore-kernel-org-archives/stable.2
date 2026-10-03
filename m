Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A43B0583;
	Sat,  3 Oct 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067227; cv=none; b=WuCUnbnMhLPTY0dpPiKnaS5aOVwerBsT76EoxjYbdjmZifHreadte4k0zO3Ju53eqmZg9WGFnH8N2fDPNi9BqIUWUgUc5SeMqj/wWnlLlLSHaJ+kfG85O8LrSv2iVitXP5MLaWl65t3Dj9bb2ebY6Q1yvqggndxKhgvwsi92aCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067227; c=relaxed/simple;
	bh=L7pwffU3fZsS+/W7QfK9PO0bGs2w1m1fnbDh7pK5+Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYLj8HHsmF5bZIenS/AxW7HdeejpKijAqddmb/tILGGmaAcswiAl/t+XbarwGqudNP/lT1FF6wZ7m58rUpyp2dgfIWskAsdTYxumKcxMIxA6sDWGOrG3FWGbZe8ywitQWaiEGy6Kl9AgjEeaVJiU81ylsJcDF1USigmIvD1Cy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc7d7Q9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc7d7Q9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DFC1F0089B;
	Sat,  3 Oct 2026 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067225;
	bh=ZQJP1J/W43TjYs+7RMpzpaCZzFr74DHsRH7rvfe8WjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nc7d7Q9NZ22VxhMTWY70nrf+vRyFbMM8jOZO1cmZ6tXfFTEHxmyvZyNkWzrpF9D6w
	 DhllHUYOFL/IPh5HoY1p8ZM+XcZWGmo4UdJzxM5IS74Qa/I+dadAs6pqXMOEMszLZu
	 Ks1H3HRE42uYlars9+9tzNUBonxe6s+DdtvTIzIHbCI85At8zg/4d1RGSuPywlXygx
	 2aim7ZZe2NxMrjyuj5CkTiAnXflcdkg2cVPvxyWUIOAU9CiODs0P6Qt0IxoW5iQPuY
	 RGq0w3eM99FjSo6fV1d1CWlfu3FZQ6F9MKtNeF3HYXyIZx8Ua7QoHifQA+zdYyN2fJ
	 h5lrRrWxpb4Ng==
From: Sasha Levin <sashal@kernel.org>
To: netdev@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	i.maximets@ovn.org,
	kuba@kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Jean-Paul Sergent <jpsergent@gmail.com>
Subject: Re: [Bug Report] fortify false-positive + real overread in skb_metadata_dst_cmp (geneve, gro_cell_poll)
Date: Sat,  3 Oct 2026 18:33:09 -0400
Message-ID: <2026-10-03-1-daily-reply-0028-re-skb-metadata-dst-cmp-fixes-tag@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003005449.2675.1@jpsergent.gmail.com>
References: <20261003005449.2675.1@jpsergent.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Same disease as the
> tun_dst_unclone fix 4c6d43db2a4d ("net: dst_metadata: fix
> false-positive memcpy overflow in tun_dst_unclone"), on the RX/GRO
> sibling path; that fix carries Fixes: 69050f8d6d07 for the same
> reason.

I've queued that one for 6.18: 6.18 has the counted_by annotation it trips on.

For your skb_metadata_dst_cmp() patch, the Fixes: tag should be ce87fc6ce3f9
("gro: Make GRO aware of lightweight tunnels."), not 69050f8d6d07 ("treewide:
Replace kmalloc with kmalloc_obj for non-scalar types"). The overread predates
kmalloc_flex, and 6.18 has no kmalloc_flex at all, so with the current tag the
fix would miss 6.18, which is the tree that panics for you, and the older
trees, where the overread is silent.

-- 
Thanks,
Sasha
