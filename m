Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696373;
	b=jgYYA6Tf0ZxhP7kr65sbFlk+ZpUKMDrAPW/s+plPfFipjFPxyQ1QnDetDDkFkzqT/4Jq
	 TQMB758HzRxxfPlFIzmlAbcnpl1vPXyWQrJqYMv3lREfOvBgoJZWkz540/ytp2EF01QxY
	 +c/+A+SwiDvIwDPTIsKDq9DkY4aX1BfIkddz28m1K+rTciV5NPCQ/nqSLcfFiE4xdzydB
	 fVI/MeOKsyLv90RL1esXyvEt2srV7jTFlQknFMf7Oi/y3UYxHKeBbuDd3EVjua9o2bkwy
	 MwPaYh69E7OxXGGKRQRBFX+LdCu5gOKEz+tdfkiW6onittbJz83uu/YOOfmZFab1ONA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=4tAt3QA+V3MXQ10KJxQwYf7/qazWXYKHcOJObSvoS+wZsht/EUN/6UOhDXUenBx3eeiZ
	 jRywfFTEVgWyX8f+5dODVUvJBG+L+/c/WLLRnN9TNmuqis7zWgPgf0WS/923v+B+B6BhJ
	 DrrFlq08V2u9C8G9EkJg/WMmdpooQHTAlGg8MWi2GJVwMp9ONWrrqHu0PzV86HkKdCmuv
	 wTAwl3ckJGQOdiaRhjMLa8SLs30HdxdG5bhg5Xy7NfdyU7nc0aLKbyEb0jPqoil/gKSps
	 GPc8jH6zSHAqsoPOYZiUmNQznhpT8bjJew4+fAv8+n2p/aVTeSy4Yl+nwvlcIOKSw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRI1fEBO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61890606A31C;
	Thu, 26 Nov 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRI1fEBO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600561F000C4;
	Thu, 26 Nov 2026 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696373;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jRI1fEBOuz2i1ctIthzz1Z1iDZV3HQWDNSs2yGL6lrjkzUXKpc3WE+1DG2kJN6iS1
	 kZjK7dbSB69iPVtZdyEejb5SxAj/kDph8ow6GQOsN5GlSWsMPQ/NdrCfV2+MCoysPD
	 r08a38xa+YsdDl/s4QFX/14dc65X+TX4l2PRYBmUsQ8facepcdx4lgVbwt2GhUiLZY
	 nLsRPpsxUBN0Xcp4KIQAwJRiOgCKh6uoMhHpNuPiEAOXhr3A7YE3lH2u8UeiMb/Nrn
	 YvKbUBCDBbMfTmcHt2QrVMSij/+vSStpzLh5eB5g2BigmRkjer/Ky+li3KzH3GjCLr
	 HfNjYQQWnl++A==
From: netdev-bot+sinfo@kernel.org
To: shaos <shawnq1@163.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: enforce the FQ-PIE memory limit
Date: Thu, 26 Nov 2026 12:32:51 +0000
Message-ID: <179569637186.3294.18098149279699097124@kernel.org>
In-Reply-To: <20261126122902.1504968-1-shawnq1@163.com>
References: <20261126122902.1504968-1-shawnq1@163.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
