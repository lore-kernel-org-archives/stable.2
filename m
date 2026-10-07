Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9E356757;
	Wed,  7 Oct 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394484; cv=none; b=As6P4YGnOcGUbSQwndwLTXlO88lTtpSEaHlocmXPFGV7AoEIzXDzMI/cou7UVhVYdxF2dTUtkFY6zD0/IjKH1oMcIrtvLaieH42lbvfqzsEq+ndaFvydVPKTDANH6lD1lcdtneHoX30LjqlaQ1g5I7gv8bMBu0b52BTeFq2NpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394484; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caw9rG1yF3iA+ktkLoOhMxxZPkq5fXMwokJAnA7J3Sr7W3x0xcJLnTcnKid3rls2Rvr3e8hrEFO0Xu3egOXuuJDKISp8skYUd3/wB2tfVIyEApLdOA9fzi9rNlP+eFvSglcTVKkiOpmpgmd5fY1oT9LoGDos2ZUnBUmp5caqA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIcUcrCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIcUcrCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB1A1F000FF;
	Wed,  7 Oct 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394483;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NIcUcrCOQDrNxZixirPNjMKOr7K0Uq78ti1X7n6LzXM1uZQVjRAjXombYh2jygVMk
	 NJ190M7v7slbyPPFXbfmpb3GCzdkgqvZ5SuDKGPXncsI+6FSII2e+Dv+dKIe/3hpGu
	 BeDssMoraBRg03AfKw8pa/fChtqxtDh4aTBhtWRCz+jII8JaRLKvoC61F/QTIxINg9
	 M+Rv9NB7+cdmMrBwSYwGNksH029belR8qP6ifrWRN+EIdf4zMxHaX8o4M3yqO0NZO/
	 en8IJzUWf1Qj13GAe1r61/WvRPvd+VuFbbm8uDbXCrZHPfgS4kph1eiGBRZ3T6h9HO
	 DVJe58TzVcLfA==
From: netdev-bot+sinfo@kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Date: Wed, 07 Oct 2026 17:34:41 +0000
Message-ID: <179139448190.2527009.17897220638829712578@kernel.org>
In-Reply-To: 
 <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
References: 
 <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
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
