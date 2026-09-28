Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA7296BCF;
	Mon, 28 Sep 2026 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599169; cv=none; b=jm67YyAHXFzKDc+0Y7DKQQ0u8RHNuDtyMpffJu2qNQj7AbTCeIQeQF/1Szaf33VXoKq8Aqwq7FW1ovLhY8ddiVrxHCQ6YLC4Iw5uVx3SMWV4bcwwai8iGL6i/WilhJHXBjfFsCJ3nlpwPF7LGxGcU9hq2CPt/t/Ux8PaYEWN9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599169; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YizHgXvNRt9i35idSpsCP+dgPXu6NJiHEJvayrI0AmIpIcpIDA361zitiZmpSwpKHneLEytfcGOfIQC1eetxA3GDmoLqHf6oF1y2m1i1JJ7Qvh1cFpb6MobDDZVYJ2rjNY9gFsFvyjrm0ARr7f44shyh2NAc1lYn0KHG7l1ddeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWyYoASU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWyYoASU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D541F000FF;
	Mon, 28 Sep 2026 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790599168;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWyYoASU1sR937AvQP2vKlYXcdY/HMVhvCPKSNXzbJ9R+ENQAl0ADFM9iQpWZWdTd
	 mtWMHKt5Mji2LwgpCOsdUaDZqKkAKz1VRepjfZrS/HbXIhG7ZHLgCrH2ZBB/fyMJCu
	 DhJIBuyiN2l8p/HoOfoJdK1Jf7IIhPdqqrA/bJBTk9P1e03saWcf9x3+LQ1tdjDDlC
	 WU11Mc3rkQySmCZi3/oPYgvHL2jEoAgLQpJuWzhe9v+xhyZLbfCqAUB7idLUMT67cT
	 i2Fp9j8gtLgNaZ13oiPHu5WxQVy7/ludkHPDp0CfdnjQhKUnS+ZC27DyHz2lQyGmRc
	 th3RJguq4frVw==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: stmmac: do not keep the new TSO MSS cached on
 mapping failures
Date: Mon, 28 Sep 2026 12:39:27 +0000
Message-ID: <179059916708.31693.15841769312205825846@kernel.org>
In-Reply-To: <20260928123422.1698785-1-xiaolinkui@126.com>
References: <20260928123422.1698785-1-xiaolinkui@126.com>
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
