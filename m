Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2920125F;
	Fri, 25 Sep 2026 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790295160; cv=none; b=tqAjO2cXUyQrZBmtd/rF1J7Xe0tPgctIrqbPa/0shqyMuu+7NXINCrPXfpNvc+vk+SUN3rbEWS9KnVtR2pfnf7bNBMisj2Hd1Qya+OnAxtE9d/VS4oas98JgKfMNSp6yaPrkU1r9DJlj1ZrBJEcHrZ2mZ73dDbkJ7kZWKbeshi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790295160; c=relaxed/simple;
	bh=Ka6fjohxVLvIJb3mKfacKxI50YbjbKSCRJZQWGma0q8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IVSHoSmoNSqonuDG29t2nvKP2eo7IO+8LHnkp3TcNx7jNxL7dR7Zcv0j+5y4QTU8VUobfAygD8c09l4bMNw1HNw7Bq3uFWgCILabHAN2+t3eK20tahtstSfRt5p01E2AzLnHLhPSlzBdAHD+YpegDuWrq5+nVM70hdxtT0V2H5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d62M2mnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d62M2mnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCDD1F000FF;
	Fri, 25 Sep 2026 00:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790295159;
	bh=NijenqkEmlD7BGvKZgyS1RNLk1i/htdIoLXR1LdvVHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=d62M2mnn2xaMHyZw7oF95yeKI1lYyJwhq9oVD6Dqn6llkqcOV59MuivjZWPAzA/iN
	 lADDBhG0A3psqcCrjaazdTMzSMAoWj3IjnbqkLE8Ga8egaBRo3C7/ta7pKlxLfgcic
	 nvkg+1Cc7qm8kRj5ZmGJwp/8KxU5vZPzpr9VOH5UdgeG5B0mLIGIU8udwddu6/SMCc
	 xuWlaRkNMyL8m171aXAVChBQfhklgC/b+ds05HwSDQrgZsQvhIO4o5fE360TVeiEcd
	 qclzLfwFaJ+aTKByEsja4OmgwrVN9FezfTpnpaEELUxXHoyZxxtBMVazUybvSkyhbX
	 rMwK8TGiuYeGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56CE43A566F7;
	Fri, 25 Sep 2026 00:11:29 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260924032636.GA314300@sakamocchi.jp>
References: <20260924032636.GA314300@sakamocchi.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260924032636.GA314300@sakamocchi.jp>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-rc5
X-PR-Tracked-Commit-Id: c6b51091cafff9ce6c03c1416aa13864d17ab97c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 165768bb70265b5c38cf0b73fafd75be235f8b14
Message-Id: <179029508800.2260802.7495434420249510643.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 00:11:28 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Sep 2026 12:26:36 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/165768bb70265b5c38cf0b73fafd75be235f8b14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
