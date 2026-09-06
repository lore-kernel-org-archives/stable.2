Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0C3BFE4C;
	Sun,  6 Sep 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701661; cv=none; b=H6yh3tt0mXQtpfyMtojQXSTmKGoa3tfxvyAeFy979QKGunSRirdoiOvXesWk80uzxd3+ughtrV2b07GA5Bd1myNDoSM0zR2U04ol6LSW+SwQySs0TeFdGsowyvP0tTbzKM1jVT7RTLgeoJRvjsCKmuLvHcP35b8UD9uWbbmsLZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701661; c=relaxed/simple;
	bh=T9XIPd0PXAczHEhJ2YVktMwqZTIWpsCkPYE24eac/7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot9VRozXfRbDesqrRDZFuxnirUGQdyIQNleUp+2O/K4HlO2BGl2N1ebEWhNFYsK8PIeHWyDZXzoKr3M8YEbmojTzbWn7zf6bXBELz5HZDPg7/GHX6ggpK+Rq2yH6BfpzKEjYXatx17Sxa3M4IpLiCMRWmyPjPst27cPzOj07SRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfg20QE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfg20QE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3991F00A3D;
	Sun,  6 Sep 2026 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701656;
	bh=Ry2qa7B8zqQlZdsb8Ls0F2VxWF/DEuEm0K4rzPENld4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nfg20QE7tye0QqHY7PTx7wlBvyUF+12BPTJXSyt2N8KMjoPupXx6gByxTEihOI0sJ
	 lg8BAo6YBQw9Do82i8gAbprXTGOyP1y/BZn03VTlPa9E6U6OGEF1rNAkKr9Y8+eGWH
	 OqelvlOeEMu9VRhXmmmnoy8tWP0j2wgOp+6+k7qyAY1WDu1aEZUvP52TihxBzgrP7d
	 4OaNj7z0mv/Q0FjJUcbrWxPJW2xD/YTC1DDLoYfZY/AM6YcIWOgQ4AitczqZVll2lX
	 Il9uhmThg3gSuDxTCQenFKdiEPjKsrEB4O6k6MnJrqjocFgxIzRdroM7vEz4tuvqaB
	 liaPIALdXX4Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	atul.joshi@nokia.com,
	joakim.tjernlund@nokia.com
Subject: Re: [PATCH stable 6.12 v2] tcp: fix potential race in tcp_v6_syn_recv_sock()
Date: Sun,  6 Sep 2026 09:33:17 -0400
Message-ID: <2026-09-05-daily-reply-0047-tcp-syn-recv-race-v2-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183500.3841094-4-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-4-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This fixes CVE-2026-43198 (v2 -- v1 broke the DCCP build by not updating
> every icsk_af_ops.syn_recv_sock implementer for the new argument).

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
