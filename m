Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B343B4A3;
	Tue,  4 Aug 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878684; cv=none; b=kNsx4NmfbKsB4t6ZPOXVIESVLwQx4v16O46HM/nSo1He7T1QUOF1S+7P1Gn7Ml/kzdKjYG65XFPKPf6+LipDwKitxrlkhg+Avduw3sFwEdLs5I8dEgPBBayZjrlGiT8QiS/WM66aKdefLSfFAB9iQhQYX/PpwWAPIEiw7ziXsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878684; c=relaxed/simple;
	bh=6dl8OSg1XFIwh3f39Je6VMfFapVo5mv9XzWgUhjWrwk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D9iXxCvbpBxm6K/p8gpjkZh5Au4QaQNquzcWU6/yC1DPlQ/1k5fJnYt3Bin/g1hOHIlnbsHEAsssW2VkvWXuBE3C5cEJUi/zYEux9S54bCJSLwhV5uSzYTT3aXJYXsnyzQ9NI69cAsN2nfaUgBvfXbTJQaD+5K8j+IiprLYMI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZAqWE4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZAqWE4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9A71F00A3A;
	Tue,  4 Aug 2026 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878683;
	bh=Q9c4Uy+59nf+0whCDDdw4y4B/NrYM64oav86QXjz8G8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iZAqWE4umkFufExEJQhVYR2zhJDtJ5vzdTRK62M/OXXpOZ4ieVKr13xc2T0gN3ftI
	 lnMWfVqRd1TQlCyz4xCdXymbxppCrR4KB95rFki416g6Wvx7g1GnRWg/N3zqu7SLmw
	 XVvsguuPNYoACIoASLDsFXRmEvTHtz3Woav2kHkmv5Ibg6ucVylzfcNPiBKK1S3NQC
	 kNNd1Gz8lZtOohfRVsKnBzlJOiWLcWsGMyiOJFl2PII+aUnS4V2hckW+OwafpsQwA2
	 VYEiar5Vw5OTG9KG4dni/ENBkpPmncAiHOdh6RBhLkAAKWs/0fy8nxWa4g1+gHJrl3
	 G5TwO+UZnbtbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A5C3926648;
	Tue,  4 Aug 2026 21:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,vdpa: last minute fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260804170624-mutt-send-email-mst@kernel.org>
References: <20260804170624-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <virtualization.lists.linux.dev>
X-PR-Tracked-Message-Id: <20260804170624-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 42bc45df5905e2b7dccb72adaf7730f66cfbe03f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c21bb4193868a8de71fc4693fa741e195fdf5d86
Message-Id: <178587864330.3792733.10616267372223041264.pr-tracker-bot@kernel.org>
Date: Tue, 04 Aug 2026 21:24:03 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alhouseenyousef@gmail.com, borntraeger@linux.ibm.com, dtatulea@nvidia.com, junvyyang@tencent.com, linfeng.sun.dev@gamil.com, linfeng.sun.dev@gmail.com, mst@redhat.com, physicalmtea@gmail.com, slf@hdu.edu.cn, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 4 Aug 2026 17:06:24 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c21bb4193868a8de71fc4693fa741e195fdf5d86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
