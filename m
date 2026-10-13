Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8025363C53;
	Tue, 13 Oct 2026 01:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854121; cv=none; b=jFRNLEZ3y2liyNSgorXh0UdwRu24J78gSS8Q0bJIPbQ2BCkNQHk92xdiKJ/XWiUMBbPK+7IurKviTLzMg9NuHi7NyzvD7tj+Z0X57znWeN5y5nXqmLS1sVP56hFJ912aXLJVY7Ex755u92D9SWA+1LdCwqXiwfhaFx1OX9vyQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854121; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJjjUn/l3mU57qIgF9TvpvRo8mVoY2LKcgAlTPDlWrnTtEl92+h668TTg9a8oqRb8l0fLPu+uN9UcWm/9u1+QotecucA/AAWiZm6M86ztxv4ke5ZEbCDu8VoGz23A8V7IoOAdYkgW/m99lgbk4YHjNG6O8jIv0uJyK2WazXQm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPFYbJOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPFYbJOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10E81F0089B;
	Tue, 13 Oct 2026 01:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791854120;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPFYbJOo+N/pyhUfJOjVCp0P1q4q1Dc8eoOB88zAggOtYW3Qx8GwO7Nsn60RTTQNQ
	 PFOl/ti4qfYLllfHXiAdMWTORs0NvvKewlOBOMGfzGtB/9RKrrDsuuxftYp1QryoxI
	 dg6Iw+ID2WtTLBGQBYJacHHOKF6QZdccmhC6Qs0+ciNgWtiOgaCP1MqNEle0mo8zzR
	 MvPUevGIE4O6A/kSE+9L/NL9rgj762KGWJ+mv9itMs2aVJGuP7qlM4z7VXGv8Fkbr0
	 v7ByqQZnqsUoSD9V/JLlJd7nXrbdBaNVinIzsZSSB/HiZ73Nc5OZetzbs5GKQ/UUzt
	 xHBIg0XR1z1xQ==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com,
 maciej.fijalkowski@intel.com, avigailx.dahan@intel.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] igc: only strip RX timestamp header from first buffer
Date: Tue, 13 Oct 2026 01:15:19 +0000
Message-ID: <179185411924.2527009.3756808928521081401@kernel.org>
In-Reply-To: <20261013010854.4068874-1-p@1g4.org>
References: <20261013010854.4068874-1-p@1g4.org>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
