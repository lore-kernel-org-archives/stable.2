Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A12DC357;
	Fri,  2 Oct 2026 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974116; cv=none; b=TrAApx+mwOB05Wm1z7g7Ma3cmC6UleGmnb47OYzPWYifzFDwaGOWwY8q9cBjeKrtff/w4j2iiUmbQzzhYC5E9VttEtwUI1YU1eqkrvFPTlAqAyNZj/0HQEHx1qnTG3JqF1BWlSK5uRFh7SWA2SQg054rYhlp94cTl0wInu0Z2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974116; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PX9MkbslvGRhhL+giqIUvBfWTWKBGXA1yHRtMHk0asm/Qq4XK5RyH9TXWDkVSlu8PR1yoQwnF7xHtoKWbvvaSERAS02ytt9IXjFU9PgUxU7BePe6Ykis0HJ/2+l0bIsalBUPAD43NDLfRZaW3Gy/puITNxiNzX89JAtgOZZ9JmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7LlxC9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7LlxC9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D937E1F000FF;
	Fri,  2 Oct 2026 20:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790974114;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O7LlxC9J9jBUEQYTtDRqimj0KUXceMLQ8g9t20+nPzzbB2yrOGJkXcqg4YrUYdXo4
	 5TkfXBhOQBEi0TxKiencu1083XC6SPMGHoDTnaoZm8bLXWyBmMN1OMYz1P4NJKg4zV
	 TvmdtZwkROLdrTNfJKM61XwPDNOdM8fDYwPPr1RjLDtXkovkDc8x+0zwp9OU28gHyx
	 EffKKu46aGEg7EkIZw46fleM7bv7SL5aCIRU8MC7iF6MXb1c0WIDo7NeAfgHC3vZOE
	 i35hTnmni3L98A0pIY38dpqxP+OxVtZXgUmpall0zL3619E7iOd5yro1HT7ff/YFeS
	 pUaBnmA4GRtaw==
From: netdev-bot+sinfo@kernel.org
To: Artem Dinaburg <artem@trailofbits.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, David Arinzon <darinzon@amazon.com>,
 Shahar Itzko <itzko@amazon.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Shay Agroskin <shayagr@amazon.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Noam Dagan <ndagan@amazon.com>,
 Saeed Bishara <saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH 6.1.y] net: ena: Add validation for completion descriptors
 consistency
Date: Fri, 02 Oct 2026 20:48:33 +0000
Message-ID: <179097411333.1402591.9823193935815787447@kernel.org>
In-Reply-To: <20261002204534.26297-1-artem@trailofbits.com>
References: <20261002204534.26297-1-artem@trailofbits.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
