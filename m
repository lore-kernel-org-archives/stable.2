Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6135295C;
	Sat,  5 Sep 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621177; cv=none; b=UqCZpPYwH7RRN1RoGS8dSMdbrJKVbhRbesaTxZMMXSrhfouIpbaJwzo3rH8IPb4SxDqWR5/hzC57L9B25xssHAXS050PI//mpOKgLj6xPbNGnRmWI9qJTOWKpEU7/NBL4+KhFPtaWkTilwtxOyuXk/DnmoXPLMMHYl7XaQYplkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621177; c=relaxed/simple;
	bh=kI/mIG19gukjXtouze+qzkC6XMDj84Z6GsMJ2gpjYkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrrdAJmyQ82NI96NSksoiVmvPCKUhK386SigccmIuwicjQCMgGSa6CpnHyrUinQQQ8JcWvwZyp3c8I//Kh8BojlSxBHmV77ZQA4z4JKhAcyE/iNjTk46TNOR9Fzi3W8Oj6kjt0MUlSzfmwjIISYtQAdOtyZvA7Apf7OdoL10W/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3IXwhZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3IXwhZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4841F00A3A;
	Sat,  5 Sep 2026 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788621176;
	bh=BkWPh6Gua2IRm/+pcShalXBR64Zm7N7iYCF4ViH+Vkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M3IXwhZZ/fDF9n5VvYKr+Xj8vnZ8SFcj/qtoQT8ZN2iJ1W/wbuKT1JaZMN+hScAQ9
	 Yw30jXuByHDMvlxB2UBYO9PzrJeTvR0vZY0BkcdfTFQDNJ6gniEhBr/hazwEAc6tEw
	 +vjutX70VZhld+cBN50Pk83J7mVJUwAZsLJA4cXnqJyA3NHVSlPhWV6cWGnzseDdH9
	 Qy4M+GuQjxeLbKXMx2BuX4srx9JdHxwdJy4UvEFv97T8UggsBWJOaTgt/rAgk/MyOW
	 8KLiv/kljtGlzGW2EQO03iSLjpzCJGutbnAdNelF6LDlx8T6jDKWW3q2p7wmEqaKZF
	 hVROLXRBtpJjQ==
From: Simon Horman <horms@kernel.org>
To: zihanx@nebusec.ai
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xemul@parallels.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
Date: Sat,  5 Sep 2026 16:12:27 +0100
Message-ID: <20260905151227.75099-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai?part=1
---
udp: diag: bound bucket lock hold time

This patch limits the time the UDP hash bucket spinlock is held during
netlink socket dumps by collecting a bounded batch of matching sockets.
It takes a reference to each socket, releases the lock, processes the
batch, and resumes from a preserved cursor.

> diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
> index f4b24e628cf8d..18cfe0df654dd 100644
> --- a/net/ipv4/udp_diag.c
> +++ b/net/ipv4/udp_diag.c
[ ... ]
> +static void udp_diag_dump_done(struct netlink_callback *cb)
> +{
> +	struct inet_diag_dump_data *cb_data = cb->data;
> +	struct sock *sk = (struct sock *)cb->args[2];
> +
> +	if (sk) {
> +		cb->args[2] = 0;
> +		sock_put(sk);
> +	}
> +	cb_data->dump_done = NULL;
> +	module_put(THIS_MODULE);
> +}

[Severity: High]
Does this module_put() introduce a race condition with module unloading?

When an active netlink dump for UDP sockets finishes, inet_diag_dump_done()
invokes udp_diag_dump_done(). This function drops its module reference using
module_put(THIS_MODULE) as its final step.

If this was the last reference, a concurrent rmmod udp_diag operation can
proceed and unmap the module's text segment before the thread executing
udp_diag_dump_done() executes its return instruction to return to inet_diag.

Could this result in a kernel panic due to the CPU attempting to execute
unmapped memory?
