Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088107;
	b=ZZOCaEFTuOqeCGGX3EAQV2DwtXDYUFh9dTV6OfPGhsLIZaRxVHeCIGel9tIjwCg7rlCX
	 aCyuLN8Iv2ylHsdMFfiNogoCJSGCsgHff+TFyBuAZPeL64UXBlrNyJqXuA2c9BkmUeP2g
	 Bs75YxhQqPAzY/UebBe6/x/jkbog3fpyymKDMVxvzv2sQTxjRh1WRxoyXDDZ5B+fGawx1
	 fNS8svEVD0wM3YYH/0aWAy++oE03C9gw2ETlbHlCwiNurJoy1ag40ieBVykBnmzkz5Gea
	 4kVzzZ0ahP44Vu1gFA4r12yTxQ1JmIIiX3tkYdrsDGPbLeeef1QAOSzi5+uVDwEYEfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=FMpQr4oERKfPVYQMImo9+Zsx7VC8JcBb9TI2/x0JU5rpIp5DSd9War0MGUkgESNsetQg
	 62XVjFGp68c7FcZ0JoihIWClxONvtwdpm3YxEdLDTn1E3dvnmyUI5VDAGOzfYcfeZUBAK
	 qpEop+eytRDHxjyGIwSaMHOHi1k/r+q0HHr1Yr+vC5sKPPEOHiHMsnwaTmaqa85JMX9ru
	 E4jhfPPRpK73ApORr4lA+dsaI2s0OisGBZXuS6wnQgGwwam59d5sfTReGboY98ESp87u3
	 Acj5NpWloP8uyDEGcHkx3Zm6djt5cRbKyRabadZgG0ym7P2rc/ZUjwWjzUm5VX4T/mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeKvEEF0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4F606A321;
	Tue, 27 Oct 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NeKvEEF0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF61F01829;
	Tue, 27 Oct 2026 08:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088106;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NeKvEEF0gt1couCJtBXvr6fGOrN8pqOsyMrxXrYJ8vp5MWeDR6pXcsTd2jIGf+URp
	 iEtcmLh/U0cuwVZME6A1Y8uZZMBHW3XrbLqcgb0gKm/IMrXdtG4erKLygnI+m/BjvS
	 3WacGzMAyZxY25+MHAsjGIe13SCphYhnoXtwbHAJDsaw9rkB/xYbhX3nQtrOslLQSh
	 7p9Qxso++4m/K36ByK7+MljXrAkFoClBedaYyfnaDS132MeeXG2Zdo7CWlu+LjcxOI
	 cE7pC6Vcb/1hhF664kuOZEAJOStDp/nzhLKVc3RfHtQDyY1k8ARPaQzhbSkCPnrkpf
	 LCAyoFxvBIHaA==
From: netdev-bot+sinfo@kernel.org
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net 0/2 repost3] net/sched: sch_teql: fix header-cloned
 write and retry strip
Date: Tue, 27 Oct 2026 08:01:45 +0000
Message-ID: <179308810546.3327.8505039495265223974@kernel.org>
In-Reply-To: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
References: <QDISC-6HS9.v1.r3.20261027034729@mojatatu.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
