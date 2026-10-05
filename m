Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB093909B7;
	Mon,  5 Oct 2026 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233035; cv=none; b=hYPPY/yC7cX+ekrtNTrOCPdNM1DZS7B5ZjD2iOXbNRnSdU9Ch7jPsN6q5+gFWkAkOIykb6pu9p54IrH7V920G3JqysRMtbGb8fNLAwpOQsJqLDW8ywQXgnU7fTc1f4leCR0c4PgO9oIQvsocxNu8CL+zP7RkcOg4UxVXWliYFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233035; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoY9GsfVhuWQXjkiWW+6Wjz8O30trZUqUWfA8s+E2UVHH7Tim+JTienOH5TrM+y7hKppE95KTLUt94mltkHIt3aiYOAUJDj0z5Ikfeh7NG7s6EynlVH45YyW0Lrljzx4OlQxRV3wVlk+VhFDy+D8o4+HCKVQgNp2uA73joxXwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y53ZuGJB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y53ZuGJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDEC1F000FF;
	Mon,  5 Oct 2026 20:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791233033;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y53ZuGJBaY2SKB9U6jzz7C6rF6M3kGmXPB2xsId75Kf20cj+NLE3Gi0DUMisvJIEE
	 2fmfYaRwJ6H+UV7NywcxHqtFZkAutQQrejEHMa0ZSAwHHlkaMLyiHLxVCay4aZ0Y3B
	 U672VvrxaloWdYA0uLnx0s4Eh+ijy6roHWALGcfigSN3VxHn3PEpVfE9YfNxCFxCpi
	 bCAAw6zzFK+mMfMMtsrOTxL9EM0ihGEpmyFEMJAJItrlJgfNbGGQUA7tgJ8VbDcn5/
	 fh5l1QOYtM1zsvqJr93vy1sNnvPET+tRX1kRpAYyrBAxbZ9p14SKM3sput2geeRMR8
	 J/GXSdRtSM3DA==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] wireguard: noise: reject responses for replaced initiations
Date: Mon, 05 Oct 2026 20:43:52 +0000
Message-ID: <179123303279.1402591.1890335379434041073@kernel.org>
In-Reply-To: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
