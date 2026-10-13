Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841D448B83;
	Tue, 13 Oct 2026 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888357; cv=none; b=GfNghWgqrHbnr0Z2mbC9LKrA4iIReT5OwUerg/2HtnE6n9xOvG4nbcknziuC+9OfRMBfORyhvwzoYpL7gk50muP9vKzuCK7vvFoUbV0qSJtJFwK+P0IQT6VsEqwT5TpIWP19ZJYEnN1ZYX/kSQQ7XAC5Bg6ngEmtusVWvD0cd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888357; c=relaxed/simple;
	bh=Frc+ADQTxRwKDWaoqMQMlUJQ/gCXB8qyIs31/48aD70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kciijJ25XfnEGtqEGkLi6gqSIu/Lj+/7w3qXoL8BWbWoP3IZ+wbBg4WNFlUahuZfKobyQcyRvphbBVp+Iygwn5xpNWSESOWxDdw/3zHGbxTBYx894cjGmtgrFLhIoYeJhIxfUO5mIOKS32K88UG1UNGJiLKHkh90/bWN9gl2Bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjzKUoIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjzKUoIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7781F00893;
	Tue, 13 Oct 2026 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791888356;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjzKUoIzYsjfWVFa6zwlLypbC0nHp24n5PzrcrCd9KZTq6EQdE6pphWbAYX/Osr78
	 ZavI+elihOCRXDjEBO9FmozbpK09Huq7aarqEsJ4xw9+BmWZrDChdjy6g4zhwho5/7
	 +RBY7ZSOemJA5CzOxZA7a6PGNgil5tBaAPGledYBaNDXkrqNVjX2JuV6pYAItUzwU8
	 gXPOPgSyPhAH+tQUwSfm4CGOOoVoNXalILUxeVLdTRvjdvCX5wpjMXvIFH+MYOfYLg
	 ehQIUXC6XFQXyU/DGxxEE3wqal8KTo/483l20ib5zajjMREcQmP2zfj3mInJjCnXL+
	 CE8Q0PrI6TrrA==
From: netdev-bot+sinfo@kernel.org
To: Denis Arefev <arefev@swemel.ru>
Cc: Sean Anderson <seanga2@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] net: sunhme: fix infinite loop in unmap_partial_tx_skb()
Date: Tue, 13 Oct 2026 10:45:55 +0000
Message-ID: <179188835531.2527009.924571463417104581@kernel.org>
In-Reply-To: <20261013103228.37430-1-arefev@swemel.ru>
References: <20261013103228.37430-1-arefev@swemel.ru>
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
