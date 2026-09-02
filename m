Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994936A364;
	Wed,  2 Sep 2026 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387278; cv=none; b=BErYmyx6ytLdBsiE8/awoQ5gS3819ha4s3muTQp/sWX3OMns8JgvOCspUdfqHVO5B7VRI5x700JmqK/3ps3mSLn2ntt3aOM+CxyMqP/RFxfuLqdnE+/WyCf5yEUSh+QDhtm1d85egY0+TzyQUjzSRqkoIl8v9TQ8gVVhKnu8AQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387278; c=relaxed/simple;
	bh=pM0nVH+ROfLZ5875gkfdEwy+QLSBTdcDJv0o2zlhvA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2h9EH3hNFKLKRveNeBAdXThHvp1ogfLJDqrD6uU77GDdLmg+UC9DYtkQPwYk0SJLamKp0IcPljubPoAMBdcQe0vsX3MYWBbPUL6of2eO8WC9KFcKwiIN5zzyB7+PHy3zR0R2wrWQF5ndcCnqa6wJHeonIEqKQ0y8ah1yynid2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xte4SW+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xte4SW+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E011F00ADB;
	Wed,  2 Sep 2026 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387270;
	bh=H94veTPNOFasMeMfIScc1IbO4NoUZrcATYVt8HbSwI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xte4SW+lxA7DRuaL9oTGjZmoCcBwTiHJwjtb8LU45Ap1t5ETCvE0MWUFSIYqOu5/Q
	 Mv6UotC+Ssbn2AgANMXmZAD6kvN7/CB9hE4Re2qdHLC6ZTDhH0MVykqyB0Akjg3njQ
	 sObzrWuzYuPlUBu+nFpS0KkhoKICgiUvkikv0lk3Iwo2l0gwtTC1i/nPXWC9XNy1R/
	 hiA+MYq2nsUTxsUjfaMQFunnnW2YhrxmDU9ZfVJ9JW/G74l7scc6pfIUq7pKmSp12d
	 PPVPE/UHa39HmMqN1UsSseodF6tDQTTNxrF4MGGYM8zPQF9SDrANTMh8kIENZYiyuK
	 E7kN28ZRHXzPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/2] ALSA: aloop: fix trigger/close UAFs
Date: Wed,  2 Sep 2026 18:14:08 -0400
Message-ID: <20260902-daily-reply-0009-aloop-uafs-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901091302.66860-1-kmehltretter@gmail.com>
References: <20260901091302.66860-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport the two ordered aloop fixes for the trigger/close peer-runtime
> races. Both carry Cc: stable and each fixes a separate syzbot-reported
> UAF, but neither reached this tree.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
