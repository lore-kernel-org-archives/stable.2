Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D790368D52;
	Mon, 12 Oct 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813881; cv=none; b=O1biNYnck5iGOB8cEVycJkERDRrQOAHoyPC9CUisK4cjLSLTtJbxgKvzj9Mgvdqmagd6in0hhz56mn4JKz96r+GtdWtK+tQTAmlyXPQZxtfC2WZRbLG7IwAFbaLRIF//ds+J7VvBH1KWm1WiCtK8ozk4ejTZGkbThKNa7YiGrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813881; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPrY5qIzMpENnuacPKGOvrMmNUOf7bs6NqdTwtLRWp0yiUuyBK8p7Gd21sLKXPnS4Kd7ybk0QrUG13QRjJI3doGeWTEOk0rdCgzqUJ+lXpzw1gxxhOAbIUwfpngfFv6VMiUTc/gd3MR0r9QBK/s9N377NPEIPoO20qvouutW+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twf95riG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twf95riG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF11F0089B;
	Mon, 12 Oct 2026 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813879;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Twf95riGH328vwM5t6sUI+0uQw04ZuywrurWmcLTig+VuBkSSfhqEHA5PJ7mjknFN
	 xxAnmD9/PisBJUO6IjExkUVZCyBqNq7LZtSHDZ67ku8awzFpBWBdzOjFIjLB0aoV4o
	 Nh+cpr80jOr7j1HTW61N/81hoT7JbdSSPL23NTYW+CEOumSbi3k0yYdY8eCzgRejpI
	 mRDjq8A3s56lf2GKTP30QY99yfDr4go5gCQ6fELgkGRFdOR6tfrPSwrXe+5BxOPfwH
	 CSsE6yGJdesff/Bu8dt9p0AfiPoeFY8TPOnU03oEFthob2gKos5RWqCeZO7ru8rf/n
	 qOusgaxY/JZdw==
From: netdev-bot+sinfo@kernel.org
To: Jiacheng Xu <stitch@zju.edu.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: avoid NULL dereference after failed probe
Date: Mon, 12 Oct 2026 14:04:38 +0000
Message-ID: <179181387860.2527009.9066593732667851992@kernel.org>
In-Reply-To: <20261012135941.78329-1-stitch@zju.edu.cn>
References: <20261012135941.78329-1-stitch@zju.edu.cn>
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
