Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41223ABD8E;
	Fri,  4 Sep 2026 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490399; cv=none; b=Lglf03Gv4vQOgqVRkRd7Nd+Ef589upIIwyYB4rqDw0Ap3BSGshinzmBeHqXFqbqSPRL1y0DeKMFndP3ct4CNusNYFAEMFixSNuoxUlWXRisQQZW9AKlr41kA3/h2Z13xboaQJbiUR06IVgb2gZKBr6zl0FM5mbc8aRMllCoA6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490399; c=relaxed/simple;
	bh=3/HS/AWzx4RPz6YwpnvYqEAbBqHIN2VRbV0wjxi2U9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVi99dPWYi27a5MnsD5vB3asD4S3gwi6Oz0fEDSk/mWckvSQi7R4NDqBscUGgI0hiaBmsEAV+QS5nabKIqB7xvDorZbxQqqwDqy1oK2g7+sacb3scxadtW+iWmzLFIkLphBEgTS8IWFJD1t2KELT4Qvhsh2zwC7owxIKy0cnpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoPGEjOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoPGEjOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AB71F00AC4;
	Fri,  4 Sep 2026 02:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490396;
	bh=RtScbCUKdTeBZPrLF6N69BotgtOOC8MdP2tGr1B7utw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aoPGEjOt1dXsP8rlQabatg7Q0n/0QfvAq4HmQwjeB/z0420KUfRhiD3UX8xzPym1u
	 9sx0zpd9IUY0ZJqznUP8ll1mKrwopV643ThMfjKjcFT9my7/qycvc5rvjUneE8GMLP
	 D6V9jRlcaQ/2MiErLeQnJcdp11gDPNLYVXCA541u+TOfop6pyYR1GVFjKCddrD4TeA
	 ZVGaGGZ3MavghZlVERqNfpt4L8GP9NOzNLzF6RP6KHKQisVKgh+/aNT9303URmN2M6
	 0kfA3BetjUGMAI19dVgkeaZLyGeZ91Wlnok9R5eVkoJdp76YOJBOt4UyK5cuCT8Iax
	 sr3tSLls47PSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.12] tcp: fix potential race in tcp_v6_syn_recv_sock()
Date: Thu,  3 Sep 2026 22:52:52 -0400
Message-ID: <20260903-daily-reply-0002-re-tcp-syn-recv-sock-race-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903174016.689839-1-florian.fainelli@broadcom.com>
References: <20260903174016.689839-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Sadly this breaks the build in net/dccp...

-- 
Thanks,
Sasha
