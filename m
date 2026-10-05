Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB3A475338;
	Mon,  5 Oct 2026 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197599; cv=none; b=o1Rjd0sjOr9PtPosAShCxnDpHngdAHsDjA1/hk2BESkMQSS/zd81avNkWVHbmEBI9h7JWWXzocPdcvwMIU2x4mmPawWP04HMUXze1Px+zCtNUlImn+GY8ygQrcuJ7cJEBePR4GLIgqGJ2BzuvKzfP/b4SbeI8hssYAilPieMBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197599; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoygIwiEpgwwSAVtr0IzaX+XkhAyWsmYNp9J7eKF5BvH4w3+HEgDn56vIUS1D3/28b4dFVrkPyRa5FWF28DZSNQmjmPdkHLEhbBv1Jv5Hb2BP1jVCYci1LZN91DOU8LLOEr/srnUmU5YENcKcJ5kBybI9bvTrmYHIVlvUaRZEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrSoIlXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrSoIlXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435491F000FF;
	Mon,  5 Oct 2026 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197598;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DrSoIlXiGR4Hn9+cSfMUi8oc6xCATyYk3LEXhRejXGNYTd+S+8zV388wgowGubC6R
	 xl/4LsCowJhKvULNedWhn2Bl6tdPJ3WHet0PMccgxwEEOXVQAUkssBOt0ilQRE6Lv1
	 sb9lraZfYS8BKiUG9juUiwMurjNchRzLgc1Iw1e0r2adHHKNZaOzBWr78Rl/cy0Gqs
	 LPM3paGhcbzKI5/+RK/V1A9y+VHZPaoTSEgwc62yvJIyOPPzdztTwL7EaAUiB7lDK/
	 dWNrisSXAWUD91YQjJv5vZc3hXjVYc7HX1xZYksww2XZtXoVeMOfOMvR8vd7HS9hD9
	 Q2bCV31iT5shQ==
From: netdev-bot+sinfo@kernel.org
To: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Cc: stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 John Fastabend <john.r.fastabend@intel.com>,
 Benjamin Robin <benjamin.robin@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 Simon Horman <simon.horman@corigine.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] net: sched: cls_u32: Undo tcf_bind_filter if
 u32_replace_hw_knode
Date: Mon, 05 Oct 2026 10:53:16 +0000
Message-ID: <179119759679.1402591.553723338940135052@kernel.org>
In-Reply-To: <20261005-cve-2023-53733-5-15-v1-1-caeaaf7de3f5@bootlin.com>
References: <20261005-cve-2023-53733-5-15-v1-1-caeaaf7de3f5@bootlin.com>
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
