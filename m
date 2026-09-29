Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD54A4986;
	Tue, 29 Sep 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676546; cv=none; b=DiHXu933FQjsSv40JTt94D8GhBxtA4k0OJF2oyZcKGqN4qrlwDgmDzR9Tn47TlAfCMRqRCFBbeIFPaDdpFkcX+h4PKAtIWBIg/8KvJ1rMsDegQM8xhxsRo4XFTrrbxT+UzYrkmbR3PTv0bq1RMX5X9O9sM23r0e1vhXGdXOKvK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676546; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRMVWMTJn7/BCt+4MW8oKl5X8MePQlf9tKfoDxUUxpu+5+9zdtCTHw72QjkbPALtbGnnn9w9PSCQgeEurqGV3KIu1GzN9DBHCfKwrocribcZFPtdJMnki8O1xRwUSUBtiAjCTIRbCwSqZ8FopbvI1Gc6H/J5KQZANF6zrj1AnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROcM1f2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROcM1f2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F431F000FF;
	Tue, 29 Sep 2026 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676522;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROcM1f2QZMMTfQUHLbBRVV1/Ya0wqIqVPmVhTj8tG/aarZK6RA4v5DJi8Y5KO2bao
	 RscFF+CKZ3rTvXJWidAipQFIuyZp2W7PI7dmwFCRa5RYGFE5iKGEKr7C0JB3qHlaVL
	 qXKeJE/Ep3np3gR0YW8NNOclMjF54q9gOq1uXRYEELn5ATPKOye9RrxKqxlD1OYPjl
	 vZDHOPBtiKNPWM4TzloHdPvJ7DAo4v6yT95gl1RjOFittUGg4RdLu3UNkiqcep2qd6
	 ouBHT2imODIn8f9MgDTO1SESHujZfkn/78dr6T4ECNncdm1rRy1dd7tGR5hqLBWbUc
	 s3psVEU1jiZgw==
From: netdev-bot+sinfo@kernel.org
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, willemb@google.com,
 daniel.zahka@gmail.com, alice@isovalent.com, sd@queasysnail.net,
 eilaimemedsnaimel@gmail.com, imv4bel@gmail.com, nbd@nbd.name,
 dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, steffen.klassert@secunet.com, lena.wang@mediatek.com
Subject: Re: [PATCH] net: gro: mark frag_list GRO packets as SKB_GSO_DODGY
 when a list element exceeds gso_size
Date: Tue, 29 Sep 2026 10:08:41 +0000
Message-ID: <179067652114.31693.9188496279514819087@kernel.org>
In-Reply-To: <20260929100256.23192-1-shiming.cheng@mediatek.com>
References: <20260929100256.23192-1-shiming.cheng@mediatek.com>
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
