Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5257262E;
	Sun,  4 Oct 2026 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791145995; cv=none; b=jRCnUVU3CLQD94ubG0iQbu50S6qiZAOlJ1utw9OZ8H0YckqsphgAQZRDDWTwwiS8KX9aNiWQiwF9VC84TdPgAm0wnWzDQl4D0TTYB+z1l9ElfweBXc7bPSGxvafaWEr3UHWhZ/LHaE+v7JLnoL9B1wBgpTGCdwtc9lNYBwYIChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791145995; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gw8zmSbqN6alYuzjykOU77JS3Gu2t72QIicxn3ADD/6PGDZiffUG2j1b/UiBoanUCWSlFSkb63wjmHzY/SfoyM18+TBh27he4pOCaaewPHw/VSgS5Dgcx8Bs6nWEmiMRqWfNlDu8wokPBoXz2IU+yJRLQtWAHundy2Qja1NJgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7qncoNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7qncoNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846D91F000FF;
	Sun,  4 Oct 2026 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791145993;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7qncoNyNWAC4CUHpkM6czLwGBuqnKyAwehiFqc+zrCn18l+qTUJwrgkq0hlry7ZQ
	 kmdEHPq8vLkQp0Wp4p0R5LfgA8HYPN090jiDqiMBuZQUAgzJFhb63eewOzbQGN9duf
	 Q4E3DJFHlbWa9uGlU8Ge7BxBC6/Hdskib9jh4YLSsStYXXS8NOZMFMf4V7kSqAFQqr
	 aN6PQv7MQW6raWIoyBQHUQTEugutEdN6uQpOUhCnMqwSbBdVBIwYSrwiBV/yxIjbCQ
	 1fvmHU5gQ+idElqjoC3vuS7mc+/lkZrOzOjoj5fHyDiJhDeeees1nBjVg6UZWsJFgJ
	 NuxkZNn2s5FJQ==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
 Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: require real-netns admin for
 bridging
Date: Sun, 04 Oct 2026 20:33:13 +0000
Message-ID: <179114599305.1402591.13084971051679051287@kernel.org>
In-Reply-To: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261004203149.3042491-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
