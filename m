Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104769;
	b=JXQ4yWGM2khkzSnnWyHhlCtR/HFrqRz9sdHujd5NwUG8eYAQsu91BOklS/3ad7HQAkEd
	 7HkDKqbHJnOQxsyqZ9KDHHmljoeBVwY3+Zi7H+4gzSun2jEnislLc2tT10SB9WKTAHLbf
	 a6ceCb+ZTJCG2R0jcIVdHAhcagb4evGO0TfCRALMF3WV3UAbFDXM52zKJTce5c438RNBe
	 HD9P1PIJQYy/ZNIn7cMWwsLYI1xN9ZDP0FUOY8EOidYxICh299KCMoCLtsJVV2KlPl+Hl
	 hN6ABFnxNYmpLEgbp5OF688GbO1dfDq9c4IpVSVgxCgkid/XbPrKn6GV3yf9ICHGrKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104769;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=wD6BFJ6JrYkMRhR+rPzMaMCFtMlLO4L8u3ZtLB0XJ/0=;
	b=eFZsxfur2Htx6BOO2aauWzv7N/sxkctAKXioECm8ktTJyiptntxlox416AGXhaRcCRr7
	 TPEmD7nzuF/6eQtR9BgDCXcix0oKe3qv1RV3wLF3wAW8dk6zCz5IXt6wE1w/i/ximucf9
	 u6P1d7qPEcAiey1kXZiD9jRaZM41t5pn4o3rBC+GUK7VmmubldUAq+pPBkZjLqBi55IVp
	 8ca903O/rUySoy1eXPmH/cxWoNplHynQ4hayCS1cAFv1pTC/IoJH9Ksm6qvahNpe0OKXt
	 9RP60F/naUIB7Q/+8835GB6wo6ef1YK2LCt6NW/IUpYSCV/ghkGkyNikD5f4ESB08Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNk3+buX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33321606A336;
	Thu, 19 Nov 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNk3+buX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFBD1F000C6;
	Thu, 19 Nov 2026 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104768;
	bh=wD6BFJ6JrYkMRhR+rPzMaMCFtMlLO4L8u3ZtLB0XJ/0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QNk3+buXrSibxNQDgUJXaT3j9GxjhJpmtSYGUgcrEET8ySMhSpsQG939EwGOwf0CY
	 8cSA0qlKIPq/QPyT5IYRGBTs4veseVn6PtosddlXXlYEtTefr2dOAqUpkSBfxzrMLN
	 0mIj1EV0GgHSekEccIh7Zkfk2N3UNT6k6RaRPzDjZa06mFMv23ryqCpRQdw+izPYY/
	 HjbZNQuvbtG+deKTXCg3nxyRyWbLrCHQZdW+sbn+9rwbCmIKxYakVsTDXrB6NWDMmK
	 zJ6DshMrlXnh8hHOKk4EBYYXSgTjzob7lpd+FxlpLo2anIMpbnyhoxouuQCboLzK1e
	 9zNsBueYXIbMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B47603808210;
	Thu, 19 Nov 2026 16:12:48 +0000 (UTC)
Subject: Re: [GIT PULL] vhost: bugfix
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261119022615-mutt-send-email-mst@kernel.org>
References: <20261119022615-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <stable.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261119022615-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 5570a998b884c988dbe105430d7e2d8e9411e37e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1715c0c04606ebbe832cc760abf49dfd6f2ae1f
Message-Id: <179510476718.3187685.502114948524303216.pr-tracker-bot@kernel.org>
Date: Thu, 19 Nov 2026 16:12:47 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bioloidgp@gmail.com, jasowangio@gmail.com, minki@morningstarsec.dev, mst@redhat.com, stable@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 19 Nov 2026 02:26:15 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1715c0c04606ebbe832cc760abf49dfd6f2ae1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
