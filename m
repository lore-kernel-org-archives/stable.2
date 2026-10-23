Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741694;
	b=GqJImU4FLST84D+iCRNtnV3JFr+Lu68ewkHUoSWj6RY9Ai+ednFTh0G5mmOxkszXTNZy
	 Hd8uvoGnimBLcHSi8WWkEtuCQWx1kMFWtIY8ttxef/zsOjsLb3ajmQ7smQ0sUoFSz2mTa
	 xraHHs8kB9x7lXGlDKHw5PSD2w9+1Rq9FsDVloiEW61ONMR3rt2usSV4vVTgbuBC6eDJ6
	 neJID2SlXXyHXKBJATtXTjWggNRvnyHRLXwQ6sKqBrl7Rk4BSqo6U59nc4bmPNkDKv4+z
	 nMqhHsmjAG+6t1ajQPvrDQ9WWdu56866SCzUR022VJW4K7CI9uqMnAD7DxSnRk0s9Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741694;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=EiZ8lOPfizBDUpiAnQfsOSdnB/G+LbpHrUN7eD8vABPEeel+mMMs0Pu5FfHxh8A6kvw+
	 pz4FGrcs3uYmZSdOIr/8OftuR67pZkshvY2PxMNwqzDAAGq9SUtoAJuU/XI9XMZdN56qs
	 sU+Td54HbMJ9m3NhpKUSXvjWmGNWw8MGzZafs8dLb/yF3LZYNjEgyGXQag+6OVB9gySgt
	 NBKZ1dGBGEUICtZnRnvwZMCOGnLS2Ce/K4lAYbfpv7XLKJCQPzJ0CjT595baNnAU0JOmn
	 R5GMW5P5XAdK5IAfTo7GEkHNcUCvTIWuX9HQt07CRgh4didc2W5TQffu60jvdfYYJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuX1rlNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1046606A31A;
	Fri, 23 Oct 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuX1rlNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA1C1F01825;
	Fri, 23 Oct 2026 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741693;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EuX1rlNZvyN8pEYl+oUYkS1Ewo+8EK9QVbelEq8mtGTKqR7cN83VSV8eAmHLxW3Bd
	 jI3D+XJuSgCSNk8Il1pnRXS6XCLHdNBxwGHGNN8ATzT6jf5NFCwTPoqobu3tm9HtSz
	 OYl/WlGWUOLR1hdi8eLnLnYOubCQjMGTIFN/t+0Ri2nES1Wwwjlm/rFINyNnL6Q3om
	 UJOVgnPxnzhQIQnKlqd6po8cLMNgbVwzs0ebL9qjHzGldScA3rtThKuAdPzN+nGPXF
	 bt95OO8YO/hTq5D8NcFlqMg8hEln2vB47yH7iXtM90cb1bqV7NH0AvhpkBbxULwTQQ
	 BFvAe7Rmm8e9Q==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] inet: frags: prevent acceptance of partially
 authenticated reassembly
Date: Fri, 23 Oct 2026 07:48:12 +0000
Message-ID: <179274169251.3327.5424575942192002457@kernel.org>
In-Reply-To: <20261023074515.2347924-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261023074515.2347924-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
