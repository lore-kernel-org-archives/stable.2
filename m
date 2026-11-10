Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305214;
	b=xW3DKqiWPNHNPumu5Dq+XJXSJo2HfQ7nYf4ZDneorc1hJBgmYLrBwUVnHtG4C0PA+X+P
	 iKpOp2D7kw0xYQr9RRuUVmC//dPl4F99o+9Glk+VLkk4gA9jfzUB3uJZRgnadcseJGopu
	 xx2jH2onWP1ALVS1Y51hAP7wbAI0vTLrJc9ftqG1zzLtzUwcIFyDJFZq9lj8k8N68L5Di
	 xPPjanyAkCHTVwu3Pa3PK3BAu4LoBnXYtTVxh+QBQ6Jmh1QnynkCzoSp5X0bTjyuJwfGQ
	 ZGywP2/v/+zQ/4FVwXOnaWDdBf2oh0ngVIz0V7PhYLn3uHJLVfARKFDZaGkTer46eAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=zplHw4CyhkN1xiivaHt7M4tXKh7ixIes8nGWweBU8PgFNWNNEQeaK6KNpxeGkcnBM971
	 9fSKQ/d8ngQuDP4HipIKFEFnQPqXkk7bpZxMI1JIsf3YNg2FHCS8/tP64vKXVV9hzXn7O
	 I2A3TstfMFdphwM4KRJq3cnYWZq7NDdGX7C+dEmgYHmaOjDK8DMOqri3R1uZfzogyk+5G
	 XWiVXpgeKjw6HQcrVmDtMjJpifnvUSuPsMBiC9tQjNM0XS3sqMQGCULmealdn6JxhSrjF
	 IcLIQK1LySauoyHOQO7KaB/jx3/imh/3eWnoIV9pa13G1WWBCAVgCJnGrlgpGRVNhTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFlfhp9b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410660A2613;
	Tue, 10 Nov 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFlfhp9b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DFC1F0089F;
	Tue, 10 Nov 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305213;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFlfhp9bdZDdIkhShsQEy/LhhmK4cn9CcXySEINdQoGaYL1XN2LZIfwVCWgmnt497
	 EYzswdUlpYfMp2HgMVKtemXEMr+HAHU8JsOF+nfr4DiaEvEB1mW8Po2FQjOYKLsiNR
	 wH+x8ztP8265qW5805nrHf+aQj6iNC7RJUfms7EeZbL3Ao7AXVkXWa6GT+m+e79HRm
	 sIz2NKzYqk7yuXToAkGts1aJSCahes0dcGZn7Aj3O6nyViyFqnGsjZ3TIfyOYVhUZP
	 nn6ko2LaXopCLNv1j57Bx9J1KqV3IvXlzb7Am1AAq4eh+tl27iuxVj7tDQ90OM7ybO
	 cP/1AbCLyj8bg==
From: netdev-bot+sinfo@kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: 
 Re: [PATCH net] net: tn40xx: fix swnode use-after-free on probe failure
Date: Tue, 10 Nov 2026 10:06:52 +0000
Message-ID: <179430521299.488859.1743918211448248351@kernel.org>
In-Reply-To: <20261110100051.2567443-1-johan@kernel.org>
References: <20261110100051.2567443-1-johan@kernel.org>
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
