Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA91B87C0;
	Sat,  3 Oct 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036809; cv=none; b=Yljj88JdJULFdkDiyfsUZsNVIuYHVDYbCj2KlDYpcqpE7fgRbdDdaKlXAHPigq5AOyUFJnHLjWCqW9A5j9yet0/N0Ghahn5RQ9KJS0lr1gfp3MXsXN9XZvwsNggti9xvNyzOYKCEJuNUaYrHZm5HciF+AvRx//xGoHd5+S+10bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036809; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBMbLZPejkLoQ/V4RHuIp5zDY+Chv8ajBqqGq9YUEICRB603aP8zdYcEDAow5qhqYMqkOfcf+aKSNNvTzCLo8IryyIb6GkklD0Y/eQD2dKQirGe7UWwYuVRCmFswnpsMDYpGNE4C+pdXft7R95YR+EbSAn4uH5mw523o5OKrbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRBg9Nrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRBg9Nrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D561F0089B;
	Sat,  3 Oct 2026 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791036807;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lRBg9NrnrwlSpPueC54OONeNo9TpACUY2tgiYSgKIwtximvuiq+6rSp+lWaWbHnrl
	 O1wIkVYmrL4SaYO9zqk8NciSxJ05ewIfy8u4uM33DvOyO8J5c0vHS5+ee3u4GivpL4
	 /NwZ6ypa3Hm889aUUFqW2LN4K6kECKblXX8nzci5WwsvGEXeWKBqLwIsfNh+1ytbWx
	 rdWORKoRO2ctTF2p8IWfBcfI99Gg2VEZeq1DRLFLFVBIFQbeRVay50yTnEq1kp9bYD
	 JM8Em3NjY2qB6wN74je7H3mAhwYy+Wi8xl5JUddJyuQXiyr7QtGaHdmrPhCwK+Irix
	 ZUy5+QlBCrgSg==
From: netdev-bot+sinfo@kernel.org
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: netdev@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Keerthy <j-keerthy@ti.com>, Kevin Hao <haokexin@gmail.com>,
 Alexander Sverdlin <alex@sverdlin.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: cpsw: fix failed-probe cleanup
Date: Sat, 03 Oct 2026 14:13:26 +0000
Message-ID: <179103680648.1402591.2581152276872666183@kernel.org>
In-Reply-To: <cover.1791035789.git.kmehltretter@gmail.com>
References: <cover.1791035789.git.kmehltretter@gmail.com>
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
