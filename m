Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684530146C;
	Sun,  4 Oct 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132905; cv=none; b=sQn69icaUYZEYwcPlJqNpLPqQn9Ml4GQMCiRsYJPYk6+BiMRpdjmB5nOieD+6S8yyUMW4cWHygvmieJctIbeiH+e0jTovgqgnxY33yCl+GvNselBhUu9b7TARW1+zyedvsiKMUK0Zr9wRZiRlb6x1cVZaIvSIjw1ojLUholE7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132905; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSnKuvWYgz/18CPb8KQ1y+Dqq728ndLIFccmO1iEtxX7rrEAkYJwkoNuoHELapA8JE7LQwQuXeLaD6xL8XvSUP9FNN+42a8cgUQa0TKlTBb5seuEWaDkENpJtN86bQZ9DfwxoA6lc06HRWXHirTaMUcaBEXjLv80OWMGwoI6gCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNJ4BsFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNJ4BsFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1206C1F000FF;
	Sun,  4 Oct 2026 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791132892;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNJ4BsFJsV5oWgAFzxq0CAaWUNVWQIUTaNRVjywYyxDI1D7/W73DdPSiG2dwc030L
	 b5iliC9akvhKPmToxWDtW2SZWxxjMBrSFGRulimNaCQgUCq0SEu7tVZH8yxYgenYIb
	 xc1w+EFy2ANqwCYP76HNjlfQVK0IhVBl8vskQGldWElQWm3gO59+CS04BuyDSsl/gY
	 gboVNjEAPIDzj+xcM7YAo55LsaHLENg8IGC6PkQOd0bC/FhN6RfM5sRobygBV/aeKd
	 5oybUA062gscSwOH3Is876fTaUq7GVHhuw/0vHxdtf04VvQvX55J+cRvI+wIy6BOGM
	 FrGPPBi/H0xIw==
From: netdev-bot+sinfo@kernel.org
To: Weiming Shi <bestswngs@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, co+71b6509cb791e531@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, Eric Dumazet <edumazet@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: reject zero CWND route metrics
Date: Sun, 04 Oct 2026 16:54:51 +0000
Message-ID: <179113289156.1402591.11780212844994913254@kernel.org>
In-Reply-To: <20261004164944.2006741-1-bestswngs@gmail.com>
References: <20261004164944.2006741-1-bestswngs@gmail.com>
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
