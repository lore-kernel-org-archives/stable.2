Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973721;
	b=ke3A/wEkEli+vUFuEm+MJozLXIo6nzwN4Q0ikV+dZGbG4RHXB/nOgTRs/Mosu+IP8tDc
	 if8gNt4u14sCDi5FLYmsnexNW1Uw9lt0XT9TeHLSIOeSjkzMRNKR2qDbAFF9hWj5dum6o
	 cYumYXnJXYBRzLgfwupuQtHCyleRVrQ5Z8HNEHsqHrCWsLfoqoJ3Or2jVWGGmgVYsnZQ9
	 Z4W8fEv/7fTC6M6Uypt34UyAdEJGpINDRIED5gYyEaZabtWqSwog9F2Io+C+sBm5l8bBT
	 Tdt4FVQ5EkARO1DFrnGkZ4fR5zH9XlCP86sBbq+0rqpqhR/8CJrX/Ir/TIdTEIzjxfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973721;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=OwRufSi6ohCEqNQ/Pc7Rdpn8PEyFj9kTp0A+0bVzM4qyb66qZrTD6Azx5zPOlLegfAHQ
	 bozX2arZ39gm+nlCicKYou6H50Ttb7KwcDJ3fBHP0ffsSDyea4p+BowHZ6dSOlHOYMOqG
	 dW7qbcYWkILU9uuKffINwMji/OM91tbVRRrs5r73QMxvqRvY3NHa7uH6EOSlwIuznFkH6
	 xJFOxQi8xHK9JTX0pJ7OfykjCxOdjd3mq8U0Bj8rhsOc1mRoC2IldKOHyYKFASZDyHQfi
	 yG98vcJSnXSwVsTlWQgcVAmKffIb+5yTel8EqUga4w0hiwjgSJEb/L1lYMNUadmpw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQfAHEo4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31719606D80F;
	Fri,  6 Nov 2026 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQfAHEo4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F221F008A3;
	Fri,  6 Nov 2026 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973721;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WQfAHEo4M6MIAVKfypgwDG3FeiCi0B0JFTj+PFvpFL3uPtrAymJ5IeeAhxCFW0Cfy
	 1gUAmAUZJQ7XhNaDso3bcsF5q0hsGLqIVpiWd1j+wr5AXky4IhlQgs56CH27YS9QF2
	 gjTzVBfkzL82Lm9v00y5VE4BMHzJjpHqAOu7dhHkItRICk/DGDVa+Lt16f/I0pmEOo
	 Zsk1yRlWuINrf/r7m7RZuL5zWUjKbwT50fqCnowGCipZP8kBBxmIukjM1+UyDnKVY0
	 BIHMVU0hVssrLHoIDh6NZi9KQulDB7elRYO+BKQzt63COelUlXkgGM9kMCKqbVVSFe
	 IZKH1CvzEv+yA==
From: netdev-bot+sinfo@kernel.org
To: Lin Jiapeng <ljp1205831794@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, TencentOS Corvus AI <corvus@tencent.com>,
 stable@vger.kernel.org, Lin Jiapeng <jiapenglin@tencent.com>
Subject: 
 Re: [PATCH net] net: reuseport: avoid duplicate closed socket insertion
Date: Fri, 06 Nov 2026 14:01:59 +0000
Message-ID: <179397371960.488859.17332481477084448537@kernel.org>
In-Reply-To: <20261106135841.418-1-ljp1205831794@gmail.com>
References: <20261106135841.418-1-ljp1205831794@gmail.com>
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
