Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D441D9663;
	Sat, 10 Oct 2026 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614151; cv=none; b=u9rF6afdI32S8UmlKIuQcZjEHosUqhuNxC9m8LLoMvR0fBUzhqyvX4/Scz7yp+aGe6innwfvE5dnht1vndDrk1f2tUORKddr6JT17z1TBHw7Jel9lk9M/0kO2+RFFies/lAXxqbBc+jpsS3jJRudTYtFJGdq2CpLT9Y4Cv0ueiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614151; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTHzMcKjTF/suFsf9IfgeYNDjqsHwsG/T+CLdBrSNulPsi6DVxCXL5cSYQnVBJLVIgYCkoVB4KcFy33KW9+LMRH07gIJaUrvaq9yCAmhlp7O+L2hWBxyNjJkTbcVBZYk6HhX8S53Ss5WlSr6X83ALxl8jvp9j0GMCcUhyGmwWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbM3Yw0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbM3Yw0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AF61F000FF;
	Sat, 10 Oct 2026 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614149;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbM3Yw0GQH0Cbw3X4FtVdbG2p5/5hVXOYwuDmYqg01W0cOcE2052o8/azi+o8+US5
	 sxGYVhcUXMlL1/UkyYVqolVfGJMJhpR8k56Q+A4tVPdGhm4XMVJ6pgooeKuQbccQwm
	 uk0N1Bn2IGq8OSZ7aIZMt82tYiuKgH5DRF1iYejh6io8QBHh9RcfPUXL/4Wjd6gGKu
	 sP1iD9vZU5ozM04ruNprGaJMmiFJecWc++5JOhce0xWdtIyTSgXx4G53NPY5Bv8qSl
	 rAgtpuSP78rxeAWTfj5npTJ5iIf0Lz8MEAh+VmFtODV9G/ZDqXiWZrHsG8vFLAHUui
	 K9u1oV2uuOsiQ==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] macvlan: require lower-netns admin for IFLA_MACVLAN_FLAGS
Date: Sat, 10 Oct 2026 06:35:48 +0000
Message-ID: <179161414850.2527009.775187842130785607@kernel.org>
In-Reply-To: <20261010062944.2671656-1-bsdhenrymartin@gmail.com>
References: <20261010062944.2671656-1-bsdhenrymartin@gmail.com>
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
