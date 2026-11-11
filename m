Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433882;
	b=HoNFZfKRTKVTuwoR7m3wooMagcBBPivJruWUj3z252XVylJ5LcmRLx8KmkUEh1nTHg9Z
	 Jc5f4e8bgOKHmf5mTFSwAvT4tNvINikl3i7SD4QQdPzDun6rNsqvOMuQVU8dS+DvqTvi/
	 oTYp3IdLhh2Bp60gOkmelIMJUiwI20Ofr+tXjqA+/idnzLEUdlLZ3djHhFyht6M8He1zR
	 kRNslDm6Ry9itlsB9S7Qsx6Boy4d6HHWuGiENEc6EKNyfrgYIiN0iwwouY8VpRKdp5dlH
	 DdTQihD1W0r+WQLmiNW+jO4xn2wFcK5uwfzVoVTlbA9yMKOLbM6FlB/51I9jVBIUtTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433882;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Rz4XOYh038Ch/+nZRuz5RydjVsTzk8Xf7tsD7d2MGqDcEB3OwiYcLP8tZyOj5rAsHiBX
	 gyZkWHHExSIEebzcYBaesiwQWzemo5t7y7S6cLJtGsZ+u5ob6rlIwecJmNgM1ta13IELp
	 JnmQD4Td1Wun9WQtxwWlPGAj8NHrMReIcbcwz9vzAN9/GiqiMAAYms4uAwGSz5SOjDuJT
	 tEhQhc04U7+Rfx3h05ARAyYRnqKbhj0P5JwEccNKHlYZiyXfjuvihQc1JGV0j2ICwlkUQ
	 9Jnrs1KpWUBtvVNNmlmMb1m60NStpZZKd1J+u3GtOrSeg2wCH2tB64la3xPDjth1htQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKL+PkwI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6C606A31C;
	Wed, 11 Nov 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKL+PkwI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0819F1F00A05;
	Wed, 11 Nov 2026 21:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794433882;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKL+PkwIoCL+0iLLkRhJZ4/4bQEmXPxrDuc6PHlE2yprotuzb4ln6tMgkfBbMAGrm
	 cmiMep51pjpYf2IZ8rpz2Ga0TiWuiIRPexfYmn/9jGsiqQuNDi6Q9yIbIfvt/O3ty7
	 ZzRDHBrp+/HMgCYFJ0w7AmYtsJ98T+/rjCuyMOiw+vO6qx9G4GzsrS7VKIb4Ph68N9
	 4NJr4hzoadDBqAUaUPS+Wf4a9yFKRT3pePhnav8BjnalLClFVI6P/PHC84j1lezPia
	 7XVOFXw3onR1phBQTPXVmdmWnuwNcGseXwoG9u9Qanj6fi7cqqzJC6C7XiIe8eiDl4
	 jnH32Yso7oFpw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] udp_tunnel: fix GRO callback mismatch during setup
Date: Wed, 11 Nov 2026 21:51:21 +0000
Message-ID: <179443388157.2168702.6402576631905322740@kernel.org>
In-Reply-To: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
