Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04864E36F3;
	Mon, 28 Sep 2026 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612175; cv=none; b=RJIsINdak88EsAOWKcCdprDrxx2gq74xQyU0Rwl29HxHsbWyT7tq5lnzswe4C4Yoq30XSj991v9rKmyFrbNTx5a7u9XSKUrNXDPiX9jtBCRRvnAjj7nMlerFJJtvJYu5Zeb3/4jxxmduig+KXz9z6QVEFShKmcUALCQIHpMzwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612175; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNpkta68rIJcmiKJ36nno++P6LAuQkx372Oa9qGLzOe1pfikvllX3KQHFTdM7a7xRvwEZaNTH+AbDTzztLqeyeZT2OD14RysneIJWifshzaCYoyM0S83E8knsX3Z2LQM1KDTsIY3h6tJQXCkmwU86EKtWuY5nXLlOVoVEMtxM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfudVjuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfudVjuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D065D1F00893;
	Mon, 28 Sep 2026 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612167;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfudVjuLGejcxJqWgUqmmKRtuUXhI7zuNJZhE1R4GsCXfr+E9bBoG9rD/9gFGG2MK
	 4HgvCWUimHpNisK1QJfEiG/b5uMw2mXiHGq23LdoFBDEEOu12RtxPAMJ0/1K77WTyt
	 Rb/8OxLXEQbH//HD/IKWV65WtI5rMmARlg278H4S0SUUOs9sqQo9+jksRanp29eUmt
	 a0N5B1YTKAKiiA6edbadfmhYz354S3kWKJP8M+6XQBu6W5MYJRGjcmpbMor6tymzua
	 DGsgx7G09zNGIvGXazImmQKUL14h595Ktgw+nP+YM5gr61kdCfcWfINap++AfPuvjg
	 8PUepbX+U0u7w==
From: netdev-bot+sinfo@kernel.org
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ying Xue <ying.xue@windriver.com>,
 GhantaKrishnamurthy MohanKrishna
 <mohan.krishna.ghanta.krishnamurthy@ericsson.com>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] tipc: hold a reference to nodes found by link name
Date: Mon, 28 Sep 2026 16:16:06 +0000
Message-ID: <179061216640.31693.424352671155791136@kernel.org>
In-Reply-To: <20260928161246.1895273-1-nicoyip.dev@gmail.com>
References: <20260928161246.1895273-1-nicoyip.dev@gmail.com>
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
