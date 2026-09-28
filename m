Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEA4BEE50;
	Mon, 28 Sep 2026 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602173; cv=none; b=WCzVRDPspYIaEGouovEG+vRBx7LZrQdINGGAUq/Zesk4qUcF5YLnk0g9I4ZVLtuhOfcllL/PQh2v+K/T4X979u0tE8S1Bsog1xtjyK9qeOgJBLIJCSmMbPXHF+ns4hUBQjR+oxFyf4OI4v2NvPEM/KgLEVqCszpKk+1shmglJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602173; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzzkShOcmQ+oOI1QcChsLujfhHGSWSSTK5nuaSD7sLvU1KTSy+z2OHDkt0vqzXvyfD9w/zDGIxo6ZE+pTx7WzZbTPh7cYTXNJYBvWIOFrlChiFQnl3vNxBoYCLKXqMJ/BuXA2V7aET74fBNsZb98fTdSyz+rb0ZFPjmdQbTWZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkhZr2kN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkhZr2kN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE131F000FF;
	Mon, 28 Sep 2026 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790602172;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hkhZr2kN9xlZyPG7DSNJzZtV5dCWhUthi5/gk+mfXfH7gbDMIzf3IzJKV1/XsuXph
	 rVZcwYkjqz2xTqarcBlMGoVPMCFYajNLHm2crVf9qqNnhjvCqSS+ICLK0mwBBEpcEP
	 e0Iho5a6UEeVBMQMK9RYRneTcsr2QogXur25NJ5w/M/+c56bxeP4nafjwTspUJGHrg
	 /6KZS6rvv2ASThbgqN/Sh9yhp9up2YzZ4UfDRQxDxmyF35m9SQ1AnCTyxZpkFMtfTb
	 +Gs+ix+FejonURmjy50aRe4haeLLD+A4q2w8wHIHOcAQeRXSJVC/SWhPuNOrFfLcYQ
	 RK+lOgWL8IPzw==
From: netdev-bot+sinfo@kernel.org
To: Yuchao Zhang <ndaugoing@gmail.com>
Cc: Toke =?utf-8?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4 0/2] net/sched: sch_cake: prevent shaper corruption
 and stall in cake_overhead()
Date: Mon, 28 Sep 2026 13:29:30 +0000
Message-ID: <179060217089.31693.7921839735693556642@kernel.org>
In-Reply-To: <20260928132452.59996-1-ndaugoing@gmail.com>
References: <20260928132452.59996-1-ndaugoing@gmail.com>
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
