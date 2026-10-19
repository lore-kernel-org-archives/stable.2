Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD54825AC;
	Mon, 19 Oct 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390136; cv=none; b=W/rSbH+y9dgMhaefMM6cKgX2p1q6hdrpgf1QVSNlujBSugz6ExsPo+sb3kRn33fYRX6Czyf6nX4mAZueeb3iqMj22P548QgQOEjuAkHTng/Dhqpc5sD4Z6b9U19hp8JvOv33GIHEa01ulW5htaYpgXvvLwgZ9UbDWAxiZSSOo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390136; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W40j2TL7R60+xtO02FIQtV/KXmWhAXBi/f7t5eXfwqJbOvP81SBuvCa/63rorBZJQmsAw6/93gu4BUhrcY2yo+4kHNHOUjLRM3IDUE/b9ytwo0z9ce/fqIpJcDEKcYZwNOM7kZCXZNXmaH36YiI6f37ANLsQr2Abt/gtk7/Q03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm+e6IQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm+e6IQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314431F000C4;
	Mon, 19 Oct 2026 06:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792390134;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hm+e6IQI5UfsED0++0zXpsNPCntBVdjonmn83/RneO1/jekcMBn3XI0qT0ZGX1BWt
	 DIBmVhx2qOcxdS8ChEHmdd9EV/H8uyEppR8hukOFcMYAgcQb7pvd/YAeZOtm5pnW2h
	 BYF2AHg++20ggCQAjwbrWCHSFifnJocBodfm/3/x8VzMuGSqR6QfY8cWhcUy9yTh48
	 3z/C2VL+/H/exmyMx1vc8wjBt6I2wxcFWUOhr2e98/ThQoPH8Aa/VfCCCkdljJvgrJ
	 O1blebw1Hc6e3/tf6bcr1tPotXcG8+n+GBRd2ZbvbUIy/0z5INJzywmWrd/7tZJb0q
	 1neu5m+dXJ5xA==
From: netdev-bot+sinfo@kernel.org
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 jacob.e.keller@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH net v6] net: libwx: fix VF PM suspend/resume flow
Date: Mon, 19 Oct 2026 06:08:53 +0000
Message-ID: <179239013366.3290.140006599068872765@kernel.org>
In-Reply-To: <20261019060216.38458-1-mengyuanlou@net-swift.com>
References: <20261019060216.38458-1-mengyuanlou@net-swift.com>
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
