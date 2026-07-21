Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D8415F20;
	Tue, 21 Jul 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660354; cv=none; b=AGwSlYEarRWdJ5NkG/rfRfqWsQChhgQQALBPwINlG9uh3H9b63Y3/fdlvYheIzWRYyPer1vP9dB6iygfFBM2BXqYvzYx0X7hO2Sm1lYMMxqmhAN8RcMrr9jKwHBks5vFivArfFH0DrQKKOaKmtx4yqRU8hi/CW+UnsjvW5gylNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660354; c=relaxed/simple;
	bh=VSxlEekplyFGpy6C9+npQeZMyga3VI7DNmU37msnOAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrWxg9a8l3vtZubttvIMD4s0sE9Vp1td0zB34+On50lp0T7qVWOb6T/287reBn1Cg+CERUPovun6bsCx4E+xwHiWedhgtr9wUWhpuGLJjGi2ldpJ0abCnbMa0cLbqext75Qtp6w//GV4Kyt2IRvxgIzup6G7v4kF6jD3KD3cMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNAFVD4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNAFVD4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D133F1F000E9;
	Tue, 21 Jul 2026 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660353;
	bh=IDZDnmzvJQLeZ4nJnIlCYRqtxDTL0Y6iZ7l8wogYW1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RNAFVD4iju+pR9XM2fFjcMm36y8K5HQCjOCTKAMN2PzOehxBhjz4IwAlTYFrXLRzK
	 C2EK9VRQ3F6Hs59Jc24bDhYNBaMzq45u/b9LmdIvU0fI75O+vZml2Y2/0e5yDTuAg7
	 dpsVkWtMN5bq0d16n+vH9g1lcQ/a3x5OKmukixuAZHM1e/QJ5oVzlJXjZAtEi6jWq3
	 hWAanZKvaJ9e5WgimVNKmaYk73H4TrynOQdl7BDcCJZu7pvBo3nHUHu/qTR7AzCIzV
	 aDdWlyp85hDngF+HXd4hpZCgKf2Fx0gRTqEP3+B53e+qmvqNWmNh0Otmx0mokdq5qn
	 DaXLcW0np4qyQ==
Date: Tue, 21 Jul 2026 11:59:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen
 <tung.quang.nguyen@est.tech>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] tipc: fix NULL deref in tipc_lxc_xmit() on node
 up
Message-ID: <20260721115912.7438f90d@kernel.org>
In-Reply-To: <20260709144718.64535-2-bestswngs@gmail.com>
References: <20260709144718.64535-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jul 2026 07:47:19 -0700 Weiming Shi wrote:
> tipc_named_node_up() builds a bulk of this node's cluster-scope service
> bindings for a peer that just came up and sends it with tipc_node_xmit().
> Neither step tolerates an empty skb chain: named_distribute() finishes
> with buf_msg(skb_peek_tail(list)) to tag the last message, and for a
> same-host peer tipc_node_xmit() routes into tipc_lxc_xmit(), which reads
> buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
> buf_msg(NULL) faults.

This patch has been sitting in PW for 2 weeks, due to maintainers being
on vacation. Please repost if it's still relevant.
-- 
pw-bot: defer
