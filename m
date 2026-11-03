Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702029;
	b=j7w9ksninY8bcx//q/Il5lsvK1GCLc7VuZQ+qb4RJGATPZ7ITATC7zHth05DrH03suc8
	 7Jj13ZtmFgpO4cxw+RjMiUdzAPkR/uahUspanmAXCHTCmllpbXHw0SVqvs6pqORHFPz6z
	 lR4/lxTzG6dFev0kMBtdQf57t+2vuLofbyR5WMgiGW32kJs5WmWrgs8hOYVZkTm7MtYUK
	 5nPt8LmOyN6GhPpTwjpepD8PnUHhK7awEzR/rGi5dfducdfEa73Kjj0bBZmdaqDA6uObz
	 OVVtsnwOM6mr2XiMW1iRH33MMZGPE+Fp4pOUysSvy0pXJrHp8A2ft4OjdJ6Fo+4Sr3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=0RTDTlzCg/rBgp3pm8XRGUNB3Gfae67aYoX/olqv1CrFvW2qjwCZlc9iISCCB2hULCZ6
	 6tMS8zl2sPS61/fItqhGM5g5BKOavYbSY55QgBTiazOIyYdkHheh5Du7dbmo1az4IPryW
	 Cu6VjcO7GZDQN2toN9aV3sPzBX2PgGYr/4rwt9l2ubTnFScLgegWgNrP6U6De8+4QTW7x
	 BsEzFlLIANGhmvrZJFUJh25jgpbFdqBG78DhI41LXo8uI0dKN/j2/qnwhxNrUXaTqz6Dr
	 dYbJFqF61JT9dedb/Vqe7Z9Lie3Y6SVh5AewRgRSeV1AMI5Kq8PJ57mApTnpXoq0Pyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkeSnErc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE060711C3;
	Tue,  3 Nov 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkeSnErc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1689C1F00919;
	Tue,  3 Nov 2026 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702028;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkeSnErcN8V5IjQdx8qDnZy5rv9ydNUpG4dp81QYzlI634014mZ92h4UEZpbnomxM
	 3Jy4Dsel/u5g62wxRx3He3uSLWTlrW3HE8vPa0rFaTeel+rpk/PWAJLRDJACtFC/pm
	 fbSyA8GHTXLH1Ps3Mnu2aLu8latpnmnD5cnmvH12cnxGIAcH68wMuzGNRZtchK+OiI
	 GZTqwjD1xqy0nyRPnf4nLAkWtJ8iEwS77A0A2NNKRA8KsDHRsE4YGkpIU96EJ33dDq
	 4fibLDzrBzzuTtHup6CeiRg2wOwDykXt/ulaJnfxzMiA7BdGmiQTJ09S6R56X09zxP
	 ArpCl0VQ9hqXw==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Alexander Aring <alex.aring@gmail.com>,
 Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: fakelb: release platform device if driver
 registration fails
Date: Tue, 03 Nov 2026 10:33:47 +0000
Message-ID: <179370202766.488859.9817846542273017775@kernel.org>
In-Reply-To: <20261103102854.1340581-1-vulab@iscas.ac.cn>
References: <20261103102854.1340581-1-vulab@iscas.ac.cn>
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
