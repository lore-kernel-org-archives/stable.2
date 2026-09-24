Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5F2F0C48;
	Thu, 24 Sep 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270019; cv=none; b=k7qUWKb7Pw7JFBVvsyRhaHB87gl6/+CqK5aDoIKABWnJwUvHK01glg010nIWTySmyE2DI02Tz2FflRZI2tC8uF2WOFtRU0CERu8DU/Mghsjz533HDhq2XADST5+j2vGXVldcRpqUGOR1U8lSnruF9DgygFg1F9uiwJLjD/oVl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270019; c=relaxed/simple;
	bh=XbytcMUnqILb3H2+SnnaEuyCZCfQ4jlOEE1FgecpDFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDJHK7V0Uxr3BFDKFQExteOGmLjHakexlBNQQ5EDleUg//kJfqx9QgJ7ZCjXOSZ1xdXxhrDFjXvljF9LSvDrHEYPekvV901MyijH28bsR2e/60z3ETPn472n+JHb3DU2KGtfXJ83QD8QXxtpC7vaBZJtDhyopKP9Wd9b8qyBMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkpYA0br; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkpYA0br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958A91F00899;
	Thu, 24 Sep 2026 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270018;
	bh=kxMY1nqX0yyGvdIZz68ICS3+ucAiC6IkbfSFVxjdUOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OkpYA0br9Z+nqOV6iwnooU3a9PFXfF17GLqHBA8ks2ICgq3akAIEaf5EH7r+eIXgt
	 zij7fZYbcT4cuaKvQhUaU48PdhNqZz6ocloJViw6PD4OObn8I+0/PUbxYirtuERCQF
	 /+8CeWqaqmK9J87vCLJcVewgG5JA9A5FHOO3FJVtJeQFpLuhqxRzPAXPxTwmNptRPf
	 uMuwvFJweuNOmRqN8AwyrPf1Xc/r6oXKudf4qcEhQM5G6UmARw0GPJFOVRAhjKpUyX
	 7Gkxnn9eb8QHizZ+exKAVGQgkmfZR3ocE2LPVskflvOdmG4b2BEtHSZEk5ZAFBHCrh
	 9y+6lF7yrncxg==
From: Sasha Levin <sashal@kernel.org>
To: Artem Dinaburg <artem@trailofbits.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sandeep Dhavale <dhavale@google.com>,
	Will Shiu <will.shiu@mediatek.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 6.1.y] erofs: Fix detection of atomic context
Date: Thu, 24 Sep 2026 13:13:23 -0400
Message-ID: <2026-09-24-daily-reply-0004-re-erofs-atomic-context-follow-up@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arSoAUX4jDzgY-rG@MacBookPro.fritz.box>
References: <20260922200448.27724-1-artem@trailofbits.com> <arSoAUX4jDzgY-rG@MacBookPro.fritz.box>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for your effort, this commit has a follow-up commit
> commit c99fab6e80b76422741d34aafc2f930a482afbdd
>
> erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC
>
> could you please consider backport those to stable kernels as well?

c99fab6e80b7 ("erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC")
is queued for 6.1 together with this patch, and 6.6.y and 6.12.y already
have it. I've also queued both commits for 5.15. 5.10 doesn't need either,
since it always hands decompression off to the workqueue.

-- 
Thanks,
Sasha
