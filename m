Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D33FD139;
	Tue, 25 Aug 2026 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658593; cv=none; b=UtUZRtcQWWOCMYDI+mY+XhZMRIg0XRZxjFkbavsSb9R854slBK0wFXdcTUaX+VAjyk+lMXw2gU48esMagaocI+cp240ryWpQX9BulzmY06/f/1UQIT4z+ukIPxA+X1Sq3la/jpwPcUmX8/R9m5dMSrUQ9322mAwYRLhQEJ9mAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658593; c=relaxed/simple;
	bh=7HsK/q4hdd5iyl6NAyoOJKhkw1wlJiWWUjnmuaw9sQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeRbeH3sw90s9+xntB5QnEawC9O35fqd70NlF6ws58THQwjFN90U7gtgMghov/Eev3JTbvqascOpUFhhCnUKEfbCcEgCjnuHvoVuAr2OwktgqxLT2DWaswm6KFCyWwLHubEdaBqoUKAf1S0yjLuIgOM8kAeLo4gQk9AQlKVSt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsJRqSNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsJRqSNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C956B1F00AC4;
	Tue, 25 Aug 2026 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658589;
	bh=I8aAnpC+U2U4v4kj2zSuG8wXI0uZsk9I36mmsIH0Apc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsJRqSNOWC/g01jeLPauOGWu+TMXfIKOH0mwfvb/kn7zJedG0+1cM1NbzOeW2QYHq
	 T9MJNw+vkz8vEYdjA8kAKg5flhaWyl1M9nyCdnCryUudwKyfBesrPejSlfbPHrrerF
	 54sgE+QjRDzb9kSCveyDB6mAMakmGYGeLbOEHVF7ejP63e2u/0so4RvwMG+A1eCleF
	 0n4YzjbkE/PFKPGZLgb7bD8t+wZ/VbsVOYrZzFr3B9HCGUZ4nf4YMdCAVaH8C3lv2w
	 SWgOgL0I9pHPWzXVjzmG4mMiiuNX6ILiqu5iRO3hrOb1B9UVxzjbjrnpDIQYbJDgXX
	 qQdcgXKRmSF9g==
From: Sasha Levin <sashal@kernel.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: Sasha Levin <sashal@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v3 0/2] i2c: imx: fix SMBus block-read of 0 locking the bus [stable backport question/offer]
Date: Tue, 25 Aug 2026 07:49:30 -0400
Message-ID: <202608250009.7e963743cf842d4e@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aogVVwPlOmCqFsg_@codewreck.org>
References: <aogVVwPlOmCqFsg_@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dominique Martinet wrote on Fri, Aug 21, 2026 at 06:07:35PM +0900:
> tl;dr: If maintainers agree, I can send these two for a future 6.6/6.12:
> 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> 07fd9385f0d8 ("i2c: imx: fix locked bus on SMBus block-read of 0 (IRQ)")

Thanks for the offer, but let's not take these on 6.6/6.12.

5f5c2d4579ca splits the read path, and the split leaves the block_err
handling in the atomic variant only, while the live non-dma path ends up
back in the unfixed handler. On 6.6/6.12 the block-read-of-0 fix that
shipped in 6.12.101 and its 6.6 sibling landed in the shared
i2c_imx_read(), which both paths still go through - so pulling the rework
in would actually re-open the bus lockup those trees are already
protected against.

07fd9385f0d8 on its own buys nothing there either: it patches
i2c_imx_isr_read_block_data_len(), which only exists once 5f5c2d4579ca is
applied.

Your premise is right that b460b15b3cc2 is now everywhere, but
5f5c2d4579ca also carries five Fixes: follow-ups, four of them tagged
Cc: stable # v6.13+, none of which are on 6.6/6.12 - so doing it properly
means backporting a six-commit ISR state-machine rework into two frozen
trees, and upstream was still fixing that rework in February.

-- 
Thanks,
Sasha
