Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211704;
	b=jausZfJ+fmJcZF1L07jIVhZrS54e1b3EYrLO37E93wdGVAXAZRJMH6AWY0RKTCxyqeiQ
	 OYSGBtdUx9NQ8g1vx0ei5g2VAdtUBZcK3kw2XcfpxLiA6YHjZzSHQSmfIzIyxNtP5mZKW
	 Fk2U+Myd0AxrBcfTmtDyCRPe6U+UnXBDIjL8cRetNXuShqUZeCFxrOpnFwb7ZgxiZphOW
	 oPdhskayRL2pntCekMoWgaynlxIEj+UeGdNgdOEoy3uF4R8+rn9JSUNFL0CsYxbxvneha
	 kOvULMK9vdOYFNizRyIWjbMqE4eGHpDiYuWJ9OxXshs/kLsE/Tr4R8r5RAjJzkRm0zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Hz/vQ0cC8LIImozfyrkYFQ6JF2W44qIv/cdNsX24dDIEQdEnryqEQ8APS3+exD2WTkcl
	 00qz3+pCVQ6RE2LKR6XOMicwSedJ+OLz/f/SxRgiHAwFwrQNyDQZA0SI+BV3sVVROksLz
	 J2RQ81WJGEAyyxmxGjjAhDF8ZCsdlBvjFpGLRcIsEKdqGm/HGAk4sgFlIpstzEkjSFdyC
	 2eh7tLZNuZnGBDHm9nnsFxmSB3X0vA1NgtLdbmw8OZ/7MR27HDmWEMdHn+E9xSdak9jA3
	 JA18fCi/NQhs1kZDjyEYlmTRIIyY5ij3b3Zp8hOSE6EwspScFGRXXyUIUgaDgmhziTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrIisKZS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181D606A338;
	Wed, 28 Oct 2026 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrIisKZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F711F01828;
	Wed, 28 Oct 2026 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211703;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NrIisKZSkCxre/Saa4vsqf5NrdgTF8pggl0HDph9mu6/2GtRud/GJZHSFj4aLoN4V
	 fzHq0waUuoqI+CGHwgMXN06ldKfjzeEOSk7lGB1rvsmJ1VYr0YMzR5faX+p+KzqTz+
	 yUxmYmCGthKntmFBCT2l+Yd+pXAO/VAYB0GRDTfdCp71WmRFR/5tX7MUEbfaCC3T8c
	 HB3tU3y4xsBqWRyRo2aM/XuPd/N+DErphei7UKXj/paL3rH8US5e06842cfyf+QwW9
	 fH3jkVcCEIaSdlTwcS0IcQZVOc8N+HoFZK5Y+ZmG1JM2rrA9U1NRYGFDmAaV539cQr
	 JbfFhSSpG/VLQ==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: 
 Re: [PATCH net] net/packet: check TX_RING fragments before memory accounting
Date: Wed, 28 Oct 2026 18:21:42 +0000
Message-ID: <179321170283.3327.5134425472965295524@kernel.org>
In-Reply-To: <20261028181450.2221013-1-edumazet@kernel.org>
References: <20261028181450.2221013-1-edumazet@kernel.org>
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
