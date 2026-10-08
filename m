Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D273B582F;
	Thu,  8 Oct 2026 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497830; cv=none; b=Soc2u7aOJo5WVjrzbMfM0TLXghZ4MroloFBDx2IXgY/glz81Pm2GXER0WwNwKEJ9wydMo4fAOy6/O/DrASg61BXoyYuvu7Nk14rsc/AxeQzavO6RlXH8paLQaatzJxj4OmfVjfqa4734f1SCRq/RDw8eWAx375OYTeUcEn7x5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497830; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+SgHDjL1g6Pb9zTGz/EQaY0zYZErCzjuxXnpGc4zdQ0vhY3zl92LKazVJCkNx9qK0Fwzpo1dHTBZlEeD6ZdEahV5DdlhwcT7O3S2UPOwDo87rgnv7ebgmWNiueC39DlQdEtELi+CYMxrj8uZIHs84Zx3jYZkW2QUVLmxSEaP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9ya2rt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9ya2rt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D181F000FF;
	Thu,  8 Oct 2026 22:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791497829;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9ya2rt42FrQLvcLCjILPyHBDWyJUikcddQFjSUNIt+rvQBr2m/5XU24HLFeSeoR+
	 SAno5PpFxPglKdMhz7M1B6OYlaYP6O/ePQl01fg9oygdAcxsMtHlsuCsUKdj+xHgwK
	 vdZ/JdGsbhBvB8kEkADJftWgkTaM7QegeXtXpZdU3xbivfF41UizWAG1TxQKfaLQzm
	 gzDS0QVIlP8Tepnpy6SIYWPt6yUxAsK1aKTZdB8zVP+SHVAoGGsEOn7vg0b0kVcDvx
	 Ykw5W7nFaFoQC8c7nWCsxQpiUglerd8NhxRdqIzCwxWRA27uP65FvfneD/ol/lve7+
	 GbvqEhbYRX/xg==
From: netdev-bot+sinfo@kernel.org
To: datrujillo@nvidia.com
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Alexander Duyck <alexander.h.duyck@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
Date: Thu, 08 Oct 2026 22:17:08 +0000
Message-ID: <179149782834.2527009.5150802946060103412@kernel.org>
In-Reply-To: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
References: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
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
