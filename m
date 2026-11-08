Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135742;
	b=5eqAvTeq4QMGPb3uuvwwXRT2VZJqZXlQ9ueKmXGa0wFtNpC+vDl40SYmjurIOyF2jmm4
	 3yS4BV6r7sZEkMewerfICy/9N/46bAbR0ByAxAfjl3excJbpd9xvjXCQPBG9Meo4hy6Ur
	 oGwjN8l/aRfnhJaxGfQwQ4E1vNqr8TI1iKMOANI3NoGu2EMEZvUD9tMbfvdbLIE3pEiaQ
	 HgYBPg00nR8UuyB2TK3k62Rlb1fduby7c9NNAHyW/xfEWIxwRC4Yo+vH9FzzsXeLWd3R+
	 kz7s97FMBE3E3lDELOt2341ZxlnzlQwOSIJ7iq9YY6A1mdTHrUZRbK7NbM/Nl2Vq/OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135742;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=KlUtxw3RAtB9S1XzJcHYoQnBL0c8XCLPPEo6A1WNn9EKbMxpiiZ0C/cFRFIcUB1yRFHU
	 xGwys/FehvBs7WfmZ5doihyRtgWZnQcrRaaYHpq14VsJVyQDSqgkMm8ZxM17Bq3ul7rHJ
	 7ObVWb7B8coIgW2sJz7VGCWi6Uc7Z9zve7uFjqb+ymveI8M5kFXIWLceRLeyiaXjD4Olc
	 UC8uDZ+JARNGTrpdSZg6TzgqRbPRXhmQRcIBvYbTdTxQp3f7SsBsA9jbUPLJAcmBHV313
	 IknSR8oT2HWO/LVfpHAr3Wy9o9Cl9/NiNDmIOfnCCHCAsxJMnZWbmiyjXQLvq502aWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzmhbbNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEE606A31C;
	Sun,  8 Nov 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzmhbbNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7791F0089F;
	Sun,  8 Nov 2026 11:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794135742;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzmhbbNTQ+8OtdbqG5vhl3PRhQPK9ifYoWq0rqUD4lvkCXlimcovhTFh9dLoyknhj
	 ePMLN361GxKwqp0xADpP4lNA06feFgkvDhLIoG2CtzDh/C2cWSFgJytKWmt0BL1ugr
	 b5PJv2qKyXkUCmEaBcELJY/1ZPTh+rdw6jx6YJIYDo+4hJilbWkD9ml/eFQxGP9eE6
	 XwfHnmG+dYvty6Xoxr6/P04IjPdEGonqaEPlJQczMX5zGhZU5juNtFAnSO721TcppU
	 ylkKSVK6v+iuJQSrRzlPJO0FEnAwNspAN7lQ1Qq+AMQlf8owJh+hH0SkOXiZvr/Nee
	 y3Mz5MJMcGO1w==
From: netdev-bot+sinfo@kernel.org
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] nfp: flower: hold an RCU read lock while using an
 offloaded MAC entry
Date: Sun, 08 Nov 2026 11:02:21 +0000
Message-ID: <179413574104.488859.8245109562691912571@kernel.org>
In-Reply-To: <20261108105605.1668-1-getshell@seu.edu.cn>
References: <20261108105605.1668-1-getshell@seu.edu.cn>
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
