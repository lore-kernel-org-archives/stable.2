Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBE3F871B;
	Tue, 13 Oct 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902048; cv=none; b=SYCUFFOtpuDQ/bqMhb55BnHCwoTnqIIohs+1QM9rCNpu1ryiVOawiq2GAxZW7NUK5nu0RJij3SBbXMyXEZAH/tXOKk7MhFpQtHxc4amJw+GuRmkQgTJNLXunKjdTs5r6jEDJITJzJ0Mkl84PVcsXg5vuDxNU7cssNpI8eoS7Guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902048; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnMopFjmLu6g/xmPz6XRYTTUKCykMcY7lQOogQuZA4yLW5vKUr4yC5CVuEiFyx185XXIj5CN5Ppspw7Tbt4Ill1Cy+25UKkoPk23UAfPguQbuJH9N8gD5U9Yy+9scC9eTKQJ7x3kExgkTKj3v/ASKsYJQHOevUwffD50fHvfYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOjfhjbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOjfhjbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507601F000FF;
	Tue, 13 Oct 2026 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902047;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SOjfhjbzfa5ijmk3BeTBw21xK1pD83Kx08RfH90arxmtm6R1+KhTM/flpc8aNhNDO
	 BNPZFic8fUrL+tJiSDxVj9OwCG39Kk59jyLS5eKUMATeLPWSaPQht9912w62iAe3K0
	 v46Lng5ipnd+b2yQdhV5Ooobyrdj5oVl4FeLhFuH20KVPOy9+xF/1D3P5SwvrGXk9H
	 qj1Q8+POJe35VDVjl9o1Y4DiNmtKXv/yEUh6l4Yqz6z5exb6Xu13gcSL8Um/Yx2lHc
	 wZi6bQUyzRlpP+tQ0MUWe/EVgHpfyDbYwfHqgW4N2T3RoLLlep2DGzMTm87Q1n9RTM
	 547jlDD8QHk+g==
From: netdev-bot+sinfo@kernel.org
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Quanye Yang <quanyeyang@proton.me>, stable@vger.kernel.org,
 Ruide Cao <caoruide123@gmail.com>, Kyle Zeng <kylebot@openai.com>,
 David Lee <david.lee@trailofbits.com>, Vega <vega@nebusec.ai>,
 Ren Wei <weir@nebusec.ai>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <kafai@fb.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 0/4] mptcp: misc fixes for v7.3-rc8
Date: Tue, 13 Oct 2026 14:34:05 +0000
Message-ID: <179190204581.2527009.15289846980073982527@kernel.org>
In-Reply-To: 
 <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
References: 
 <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
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
