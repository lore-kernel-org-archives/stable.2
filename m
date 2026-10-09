Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2C42252A;
	Fri,  9 Oct 2026 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525612; cv=none; b=WtmRcB4aeZNteCF7H1Jo0tHeguwQbS/liK+Omm/5EXqLIOfjTAq0o0zknkh/luyk+WCakHCjAQLj0WJrsQfdjsBf0Gba9Mb4pO/sSSaur01C/H24hi/TBTPbk1XIHYpnHsVa98bVUhbmds8dmoAzrWSZUGva6om7Z2TRQkjh/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525612; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f0yOpA/nsUiwplAafTMVqFwGjQbx1VokATtag5wvjZL06eyADAlThvRnSINiUMha7GSBrTrE5wY+ArehEVTdUutCdoWyGhgGiqQsAiOG4UZWVGeMXpzRMI3+6QhPWAp7EKjZivq2PvzGu8RwooABV1TQTKagjf+CAmTBnwxsdr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCc4jOKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCc4jOKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AA51F000FF;
	Fri,  9 Oct 2026 06:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791525611;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCc4jOKFM0tjFb7zyEvaGLZRrVF/Q8eQOz8bV+bo6tme50c7RT4gheThxkxLemutG
	 pad0LX1fvhCPn7JHsf3WaVR3b8Fd9+eUpZ35oNabknXDQRSC8QJqbRUd7FK/SWmM2d
	 dp4hN6ejNpis7dUgNH0EoyF7sUU1REK1w8GmzhrEMPrDKdUMwmSEt5dFYUH6Gw3sBA
	 0oI3yujtJTsl0lilURwCp2KN9R79CG1I+Sn09kPP1tsGIHGr4bJkS1XDzS455nkPK7
	 143VK0ywYSN26YH+mFOfyUhFtuoyEdM0AdTlerZJqjmnOGzAmQ4iDWM4DLWE0P+IS3
	 mPxA4W+8WZhUg==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 Ying Xue <ying.xue@windriver.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] tipc: fix broadcast sender hang and leak on last acker departure
Date: Fri, 09 Oct 2026 06:00:10 +0000
Message-ID: <179152561066.2527009.6131469500831214961@kernel.org>
In-Reply-To: <20261009055601.2304158-1-bsdhenrymartin@gmail.com>
References: <20261009055601.2304158-1-bsdhenrymartin@gmail.com>
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
