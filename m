Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522738;
	b=hpc1YYJGAJXoB2SyCV2FJlqiNLEmI2+6e8GIqG5WbxFTatH2cMTNykWsORJ0loT/v4KS
	 P6YJKlHV5/RiCFPUUWBh8sk+E9vcRzCZ8MwZDsvGVhujdgarJOZBhFiFHMD83f43EAQiM
	 Z6C7iW/5+ZLzMN9eB4slXIJBQjJcFRNNLqQ0TN19qyPIOy+qD5hxGklsePlfvwruH/ruD
	 1/jnfsGk9HL3u/E9PvBS5k8S6qMAOLvdp0gb97BkiageVnEmguJJA7q2DCoE5B9TpOavl
	 KTzT9iv6R6RswpXuhBiEJuDR6rR7wYghx3q7pe9moArmNvTH/JBSmfyOPypnssPzikA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522738;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7I8Bl8j2DkVNE27qVMX3vqtaNvrvL7NhHRJK3KxV54A=;
	b=irzdLl6g2hWL1aX55X442Bk5lBVAaWt1PBma3y7OjfI5F5SDH5kaY86LxLvYt4Dvi12k
	 qpJZxacMm7eTy79Ear/Un6InfRv8v/0P+jVrepYuIP8xNKEhecMl6Ct3O/KL5Zv4nExvd
	 5H/xb0JWmouRmzO9MUerIVNFE+S1lNjjBKYkdfJw5O5UF8iJ3fxCLh+Fy22rrjJzlwePR
	 v2OJyMbiJebGGJonrYr5cllBForNOAE91YLmb0unTWid4r+85v1TnoS5uS8Dje70wyh8C
	 d0edHkEaXec9FnXincRGQH0BtuBxYHL8LOFKkPdOdBHiO/dNSvjnrnTZmnUzqijn5ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR3VWbUK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF260A3811;
	Thu, 12 Nov 2026 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WR3VWbUK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B350D1F000C5;
	Thu, 12 Nov 2026 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522737;
	bh=7I8Bl8j2DkVNE27qVMX3vqtaNvrvL7NhHRJK3KxV54A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WR3VWbUK1imnQlQmpNAhqSsCOW99QnIUHIcVwRERBUB4R/jAwYxqHbCFi1NkKzLoa
	 ++/G59vhWLixAa9mEUEFGaU4gePyrs3VnVA09595dCjvaKajFGHofoN8XhUcYErqHP
	 mChkoSGEKpddY3E1an1/DwCzTOeoAfXiiV55MWuRWtgoWvpRLoORurIa4d8gh/hEcp
	 K+epw8KzroVsBPW5kuFg8ur7b1k8r1APmZnYOG0rRYfEeEaF5aWQPJ6qMb639O7JbH
	 0Y8hT2yAVt9BfRDAyG2aNSLli4ZxHj62IV5iifmtuRZCbF+l9cL+Y+KQCwGeE9GoNI
	 XttgZKyF9yFfw==
Subject: Re: [PATCH net v9 09/10] can: rockchip_canfd: prevent timestamp work
 from rearming after bus-off
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol@kernel.org,
 heiko@sntech.de, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 wg@grandegger.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 22:32:16 +0000
Message-ID: <179452273623.488853.960003123754786062@kernel.org>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-9-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-9-6643f3825ba3@qq.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit "can: rockchip_canfd: prevent timestamp work from rearming
  after bus-off" is tagged Cc: stable but does not say it depends on the…

--

can: rockchip_canfd: prevent timestamp work from rearming after bus-off

After bus-off, the rockchip_canfd timestamp worker could requeue itself
and keep polling. This patch switches the worker to disable_delayed_work()
and enable_delayed_work() to stop that. It also adds timestamp_lock and
timestamp_active so counter reads are serialized with start and stop, and
rkcanfd_timestamp_stop_sync() now calls the non-sync stop before it
cancels the work.

> Keep workqueue operations outside timestamp_lock; the IRQ and restart
> paths already serialize start and stop. Synchronous stop waits for the
> callback before reinitialization or clock shutdown.
>
> Fixes: 4e1a18bab124 ("can: rockchip_canfd: add hardware timestamping support")
> Cc: stable@vger.kernel.org

[Severity: Low]
This doesn't affect the current tree, but should this patch say that
it depends on the previous commit, "can: rockchip_canfd: serialize TX
with bus-off and restart"?

That commit created the one-time probe helper that this patch extends.
It moved INIT_DELAYED_WORK() out of rkcanfd_timestamp_init(), which
runs on every chip start. With this patch, rkcanfd_timestamp_work_init()
in rockchip_canfd-timestamp.c becomes:

	spin_lock_init(&priv->timestamp_lock);
	priv->timestamp_active = false;
	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
	disable_delayed_work(&priv->timestamp);

Three calls need to stay balanced: the disable at probe,
enable_delayed_work() in rkcanfd_timestamp_start(), and
disable_delayed_work() in rkcanfd_timestamp_stop(). That only works if
the work is initialized exactly once.

The sentence "the IRQ and restart paths already serialize start and
stop" also relies on that commit. It added the restart quiescing in
rkcanfd_set_mode() for CAN_MODE_START:

	WRITE_ONCE(priv->irq_suspended, true);
	/* Wait for handlers that already passed the suspended check. */
	synchronize_irq(ndev->irq);
	rkcanfd_timestamp_stop_sync(priv);

Without the prerequisite, this patch won't apply to stable trees.
Suppose a backport fixes the conflict by hand and leaves
INIT_DELAYED_WORK() in rkcanfd_timestamp_init(). Then every chip start
resets the disable count to 0 just before enable_delayed_work() runs.
That would trigger the workqueue disable count underflow warning and
undo the requeue blocking added here.

The prerequisite is in the same series and is also Cc: stable, so
stable tooling would normally apply both in order. Could the dependency
still be made explicit? A prerequisite note on the Cc: stable line, as
stable-kernel-rules.rst describes, or a "Backports must include ..."
line would do it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
