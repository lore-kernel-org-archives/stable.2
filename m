Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CC3AE6F5;
	Thu,  8 Oct 2026 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431957; cv=none; b=CV4OOZqCOwC2mDlIAwxb/MwoJIslz4GoGXJ4jV3tdKPIUmk+GBsrsuiO999ePr9zN9Oa8F/mqgBSl19MY4lo54d0UmydNiJQDJBrb7LyJO3V2ib+N+Q5yVhjEh4zVG/SRMJfp6phJwfr50KXfv80OM4QFWOUicsH5ShFcfIh95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431957; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWMnLFXJf5hC6mk5PsRXzvv35FxtjLMziMz/Faa0q65nD69e+bqqxOMN9OLpSawU8Tiep9WW1ocD9SfIzAFOSClXJuMywYoK+rnSWsaodvxj91gW/Yl3jkpfEKY3szHn5JhYLjRoA1EFjBzxbFkXxYMduyqz6nWMBnZTvZX6FYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfmmtHpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfmmtHpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81331F000FF;
	Thu,  8 Oct 2026 03:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431956;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WfmmtHpS/Myhydt/TVyMFReRPcy1QMHKlSXn/o/jQz0KRnRG9mwUSC2zyzNttD8tw
	 snu/KwVceaOyNVT7W07YFFfMk1DijvxKGrt/dKLv+kse8hK40mSBYmYnRdK4GcIzwu
	 IZTEzgINbj9OslJJSjhb0d5AZK/UB5PsGU/FGMft0r9RVCSpKpw1wk0QoRfyQ9nSLJ
	 YocYbQtdrhTItOYe/800MrHAgOw4I7BPQiVGTke0JBV3nFr4xbafrrGLmjpv5d1LGD
	 Woi3ijbasF+/gko3jAU3I3Bjn6zW6U/Sn8/Ow4MxNLO4UU+TjIi0QJEcarlTZTarI+
	 hWiDcdIaPw6jg==
From: netdev-bot+sinfo@kernel.org
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_netem: prevent packet length underflow
 with negative overhead
Date: Thu, 08 Oct 2026 03:59:15 +0000
Message-ID: <179143195544.2527009.14860370525417657852@kernel.org>
In-Reply-To: <20261008035656.330667-1-dungvn2345@gmail.com>
References: <20261008035656.330667-1-dungvn2345@gmail.com>
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
