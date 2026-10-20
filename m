Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491268;
	b=dlmkcwki9Cow8Hs2TrzT0eyYmd2Y5H+VIwDdBGYvHKy/KOj0aaMT39/SKX0+yZ1cVuiU
	 zHMVQoiJ5UFnivVXogF+3nOnYKt4KYzZnH3psRf6DdX7uqyIDvHJuHrncDb0luDom5hCX
	 kugyatKEJGtAeZqeJgoMF6N6kO1kDMfiFUbSyem4gJD6fFzeRKr3S8i+J2Dyj2H61awmy
	 3N764bqaybM5VEzFgOLFAj3qAd7/6JA8fyNa27eG5qLw15bm6nW9UYhf811ftFpPnVei7
	 dRpy+ByeG5xG4i4LyrBXza3LwC4PzktTx95Guzt0TuOeH4Ij3L96d/diFAtdbmjUj2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491268;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=bWF807aglHCT258t1OvSkj6v8jQP392NAX6e4SUaE0W7ZMQecFJbm8Hbqrhu5d+TarwE
	 E00TFxjbdcFIqsxGI7MsbB4Uaws34ff/rx+IPWNUDPuDbpdSPzr4WLvtTlwrDsfmOf5e2
	 XWGitMkSTmwWpmJlAoTBglZGYZyldWKcHy8CFRMGzKHU/NVjEsCG4VSQ2bAfC1LkZ9v4w
	 YttcptD/GRJKKX0LN9p7i+ZQMb+m9VoX8aqoHYRqqcnW9OcB5fnR6htkftR+SgnPbaVUg
	 s37obHvUrSryadOfQCDAaWlP9Utixye9uFS2B6dg3jcQV2W1y7ntH0QuojaO1FjgxjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPGaIhQF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB05606A319;
	Tue, 20 Oct 2026 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPGaIhQF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0BD1F000C4;
	Tue, 20 Oct 2026 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491268;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPGaIhQFdEhqqoImwFh5JpaMNkZi1YnRW7EH/hbDSb98+Rklz2fkaadBiGkkaAeDp
	 ohMcA6JBld6ZQmh88Vtr4O74xIn981NEilLjilJfKnfZ3LU2FOMQ6EKBZOHQZxyWwR
	 xTmWeXeKAaWa+LHmzA9wFGi2+EWo3WGSeja+yeII+8qTDwF0JMqFIdLpn01BNBcXl+
	 v1Kl9xsGdfqld/6pN/wg4QR2w50yjWpyJFTyzbhKKgth5RfY+NWfnALhTUkfRDiy9Z
	 2PRn9MNZaYb0EGibTUXY+BYt2Cc+HuXHIeVkdTSm/KnAp7eitjX5WBIT+COweD+evg
	 4aDnVXGMlLxtg==
From: netdev-bot+sinfo@kernel.org
To: liuc63 <liuc63@xiaopeng.com>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Guanglei Zhu <zhugl3@xiaopeng.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: wwan: iosm: fix NULL skb deref in ul_td_process
Date: Tue, 20 Oct 2026 10:14:27 +0000
Message-ID: <179249126722.3290.2660625753519664062@kernel.org>
In-Reply-To: <20261020101150.16967-1-liuc63@xiaopeng.com>
References: <20261020101150.16967-1-liuc63@xiaopeng.com>
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
