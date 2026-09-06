Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4543DA5A6;
	Sun,  6 Sep 2026 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701654; cv=none; b=iNaClweZxTfny2yLKQ8JjOqm9zKEvuZudERDmJonuWZHG36KV2n0GOxE3qbjcXLRDqOvOZ2aqfJ37ngAfCT3IJk0zBzy70ooW+nv7TCe4vYqfeXNNCiA/da6tHUEjDx4uOi9XqGZIe7L058y5QZ5vPZTWBjnZpQoyFwa8ExPnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701654; c=relaxed/simple;
	bh=GcnuUKSDTjrjKt3dwZsrbWpHfRqJGSYafHVPgHbF+c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCd/lCs7QxNbBlgr173h3n9sxfScjR/nUbrr7w08MtBqWlqy/omWZfcaoLve3GartlSfxSiAGBFyqRLtLyvZuVtVkHGmvKYGM490Na9lMePZmvXyIeIXDwH6pmU3xCiABsrN1n79nhZtN8t0Cbk11aAaEYRoNuxj9wkhiJ5p5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk08MnZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk08MnZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE2D1F00A3A;
	Sun,  6 Sep 2026 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701649;
	bh=bQjJw6lRuzR3MyVeNvu2ZnKxhMxp73rcBr+n0G7mURw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wk08MnZOG2SgH6iiQOva/ZJEIww2Yd+w3jI0FDdbHoIE7ZqH7HCvxBkiLqh1rTaHI
	 t3VxiAAWRJSHrEgiOMasUAtUi6IFrenQ4C4JR/c+NshUhCAaPya+z8+daTrmq0EmLt
	 hTZs9GJUmXqhM1WzgHbxuqKn3M0vXfmlLxEz6wA4TH78S9x4kZCWRPDXT8EY4i99eA
	 XW+NFyWgObTIIFnJQIr40DsnAMlreszZyv54NbCGQRTprbuWCk3E/F4wSfMwh00VbD
	 DRG61rRvj1mU9F1mAXAZP1PKAvDcdyuPMHR02Mz7xvSstQblOYPovgSW5Sx3QW+cme
	 2o277ds9wJz+w==
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
Subject: Re: [PATCH stable 5.10 v2] tcp: fix potential race in tcp_v6_syn_recv_sock()
Date: Sun,  6 Sep 2026 09:33:14 -0400
Message-ID: <2026-09-05-daily-reply-0044-tcp-syn-recv-race-v2-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
References: <20260904183500.3841094-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This fixes CVE-2026-43198. v1 broke the DCCP build on some trees because
> it did not thread the new argument through every icsk_af_ops.syn_recv_sock
> implementer. v2 updates dccp_v4_request_recv_sock/dccp_v6_request_recv_sock
> as well as the TCP/MPTCP/SMC implementers.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
