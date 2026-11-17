Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953526;
	b=FPXcGTUov7TSE6b63TFukk42pIsfOe7lKqXgzWaFrJbhxPAMEheQfZHCGrtGof2470yb
	 5Onunghxbpb/4nzaAzxqqugtltk+W073YFHXdRb1+yP/Ly8x2TPYgueZKLkjFbUImC5P/
	 qy/DdbppyxQsrGtc2KTbEcY5P0M2MkjeXSd/ekQ6UnjSDuiXI2coLFo8lcEEGienTXibw
	 Do1cM3EsMiVgRcgDRuDnHAsfkZwcBRbr9IyXVv1fkR2eAZ9v/xCmXI+VWz/MoHvbn26qi
	 aAaT0go7gFKDiY3hnKcP31rrlzBj4EOJdR8wICSu6FcceQ37djnzqPW5E8u1V9E7GdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=KlbJQthCBugcNFJ7Gwi6V5yGPxVaxCZMV8SNIhIhG00IE1c38qi73Q/VvxUyz8+wYU2i
	 cD5o+EHGTI3bZFNT5LF3+s2uZxaLF7cR/lvSoGP2nZ8P2YykdjXscprZdHJF7Ctv1vyaL
	 ziEUdkH+W+S1aRQ58T3unsm0MeyjTp54AvrY+I84vcznxXQLXGcUCXQPbch/rpazkBVH0
	 KcB9jLkRPwV3h/8IPvGjbYfzGKvaHwf8oNW1Q9IAnbaSkXYjr9X0ohTd3grTwxsyJ+RhV
	 V4FHMbslhW8vbrUVprle2TT9ZT2eaNfKZDMS0QBVMmDHQ1GgfVLBID80mWsmV2F1VLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyIslzlG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0068606A332;
	Tue, 17 Nov 2026 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyIslzlG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FE81F000CB;
	Tue, 17 Nov 2026 22:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953525;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyIslzlGpMoRVmjrvP5eJl2GK7CKt9ywP0kw0m7LXIqKjAEb/PJjra8PwtRFHAOE2
	 1Dp1y0oPnTJ91C5sXJQvIH9MXXm4E/3JiwTpxOScY7sXtLVPCo0W2nCe1CBLrURY05
	 zsT7womHKkpaglR20qQSKPlUqa1jGE9FXvEBKv1vLlpAfJVHeTNPjEy9JHoJgxGLrG
	 3ptrQdU4EBYXjRrCkCmlQXDkdX3x5x+n7Mu48yhLAEMSM2EDStKxsKijNoyxhx11Hi
	 dlLcXQHIojqt5Xtu5leZJ2RQXXr/TAVxKHmdr+pYp9PWo8ks5TvGt5QF+aq8OmCogr
	 KnPxxElzuZAfg==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Oliver Hartkopp <socketcan@hartkopp.net>, stable@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Zhu Ling <zhuling0805@qq.com>
Subject: 
 Re: [PATCH net 01/11] can: bcm: copy the CAN frames outside of lock_sock()
Date: Tue, 17 Nov 2026 22:12:04 +0000
Message-ID: <179495352427.3291.18107293383947918297@kernel.org>
In-Reply-To: <20261117220818.1142581-2-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <20261117220818.1142581-2-mkl@pengutronix.de>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
