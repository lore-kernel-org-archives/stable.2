Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92F478868;
	Mon,  5 Oct 2026 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196396; cv=none; b=TdCAT1pa78uyjr+D3coFjoQ7/FCDbOWD7fkZc6A8JEYDWKQRvWbEg2kVGQdY1jVfvXguil83cvaiUFCHSZu6U/ZcXjAx8H0JTA7FmUIu0i5NZ+ZAWW8asusAv9w6bwI16cG3P98IDGK52rn4GHo0LUH07wSCeZNCegK0CB4bOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196396; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TYJ3PmTCLgWtibTc29COI+p6p6NQ6WFrBc1+QVBdlWHHOhrs98/9C5m4KgOS+Atd9qDISOBHlT1L5lh2o82Aw8R+47+jC3gPXcMXsWpedqkiloxVkh2ARevad00zhdcat08JGxp1NA81MhWdBsk/H8bhA4Hsb3aVc8SiJBVE0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXglm/yD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXglm/yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4296C1F000FF;
	Mon,  5 Oct 2026 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196395;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXglm/yDkhX91Jz/tA2TuU/72rH4Q1xtPjYYAsdLfVdEwNuFJW/lXcbKWQl2uBJAf
	 F6dW/NB2rrnTbYfJX8+cmPz49RBP2qZBIXAyEhbGv68JzxbQ2VcFUkr6srd4bNcP8z
	 l2m63N4KfWcd7PNrTFYOjosDMzAWxLR1vYkI0P0kt1xzp5+TIiJ/gXiHKSLepCTPsp
	 sKv15OS5fVcb19ehjvokc+4XdG0NYY2tGHafG2O8xqKCo8uaNDHWhYfBVUxkID8tNP
	 Wd3vgUjGxbdrhY00dslTZoZfhPnBEtjfJS5ZDhPsf/ikoPE9Cjom+HgEpV6WapjgWu
	 rKuJVL4bG28vA==
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
Subject: Re: [PATCH 5.10.y] net: sched: cls_u32: Undo tcf_bind_filter if
 u32_replace_hw_knode
Date: Mon, 05 Oct 2026 10:33:13 +0000
Message-ID: <179119639380.1402591.2155637888002963@kernel.org>
In-Reply-To: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
References: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
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
