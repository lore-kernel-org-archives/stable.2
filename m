Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302E3955FE;
	Sun,  4 Oct 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123034; cv=none; b=biqMLUQW1ekO4TQFegXKXxT2eJ//Yfbl9Qs9BEkNw5X5C3d+6N6z2493oXsiM+gi7MrG4zVG8RdgLUuDVRl5/q0LV83kAqJKfJXrOwje43k8dZsxTgcOwITvgnaNOBJiN2v52saE5M4bACBRGf+6zzfR+XUfNha/iJyGnJWgoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123034; c=relaxed/simple;
	bh=kbqvkRuOvhOGbq6l3L0HKHsp9gtavI4tXwtIjeNf+i8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZC2V6SBYSg34wcQ7KUs88WeptRg2CUMx+UlqZyN2JJ2BTmq3exTe4Zm70W8VeBNDltp5IvHNQAJOack82ChgN33XGRb35JoB+R7/DM0CWpLEw28UE165qNPKQPZdH1ozQ0bGSoo7i8+twhltqQA9CMBoh77A5i00ES4oBgggZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjVmPfHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjVmPfHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178891F000FF;
	Sun,  4 Oct 2026 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123033;
	bh=QANzCq5wf6O8mXgh9UVvU9WkUp/U54WKm0cktzoIPOk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZjVmPfHprwS+q4H+GoSksxOK0TNXl6FP0MTqBIdT6cau8rJgcnJ+XIuXqdjowEHXo
	 jl6vs4N/tL/Jz3rh+3aBbPWaVO7JydXEL4PWUA3Cje13jEEdYAfehJIlnYA8iyH6Tc
	 ilUO/T+SKhtgOsymyepS1/A6LRrtEqLdBeoRVtEP3DuwTR2kaa2aa4yqbbKeVLvQma
	 U+WbPJ2p611MAOZD4DMTpQQyj9f3G6Qy5lfvXzavhFha6tC4JqzGKQ9CdzHMWlLiKg
	 9b1Qj3ABUMJH7iX4rI+LlYTmoQbgGgjyChC5D9m0fMI1/sltUf9TKBk6Owyk7WfMok
	 RrBpTgI+2F8IQ==
Subject:
 Re: [PATCH net 1/2] net: cpsw: unregister secondary netdev on probe failure
From: netdev-bot+sashiko@kernel.org
To: kmehltretter@gmail.com
Cc: netdev@vger.kernel.org, s-vadapalli@ti.com, rogerq@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, j-keerthy@ti.com, haokexin@gmail.com,
 alex@sverdlin.org, arnd@arndb.de, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 04 Oct 2026 14:10:31 +0000
Message-ID: <179112303157.434549.9729493516800136823@kernel.org>
In-Reply-To: =?utf-8?q?=3C2f459154f5bca89a07dc978c834e98198c08c331=2E1791035?=
 =?utf-8?q?789=2Egit=2Ekmehltretter=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C2f459154f5bca89a07dc978c834e98198c08c331=2E17910357?=
 =?utf-8?q?89=2Egit=2Ekmehltretter=40gmail=2Ecom=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In this patch, the cpsw_probe() error label
  clean_unregister_netdev_ret in drivers/net/ethernet/ti/cpsw.c now…

--

net: cpsw: unregister secondary netdev on probe failure

This patch records whether cpsw_probe() registered the secondary
dual-EMAC netdev. If it did, the clean_unregister_netdev_ret error path
now unregisters it before the primary netdev. This avoids the reg_state
BUG_ON in free_netdev() when devres frees a netdev that is still
registered after a late IRQ request failure.

> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index aa3531e844e87..4fc59f9f23fcb 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c

[ ... ]

> @@ -1764,6 +1766,8 @@ static int cpsw_probe(struct platform_device *pdev)
>  	return 0;
>  
>  clean_unregister_netdev_ret:
> +	if (secondary_registered)
> +		unregister_netdev(cpsw->slaves[1].ndev);
>  	unregister_netdev(ndev);

[Severity: High]
Can rx_mode_work still be pending on either netdev when devres frees it?

Both netdevs are registered before the devm_request_irq() calls, so an
interface can be brought up during that window. Bringing it up, or
changing its address lists, reaches cpsw_ndo_set_rx_mode(), which does:

    schedule_work(&priv->rx_mode_work);

cpsw_ndo_stop() does not cancel this work.

cpsw_remove() follows each unregister with a disable:

    priv = netdev_priv(ndev);
    unregister_netdev(ndev);
    disable_work_sync(&priv->rx_mode_work);

This error path does not. After probe returns the error, devres calls
free_netdev() on the devm-allocated netdevs. A queued or rtnl-blocked
cpsw_ndo_set_rx_mode_work() would then dereference the freed priv,
priv->cpsw and priv->ndev. The workqueue core would also touch the freed
work_struct.

The primary netdev already had this gap. For the secondary netdev, the
free_netdev() BUG_ON used to fire first. This patch removes that BUG_ON,
so the use-after-free on the secondary netdev can now be reached.

The next patch in the series, "net: cpsw: cancel RX mode work on probe
failure", appears to fix this. It adds disable_work_sync() after both
unregister_netdev() calls here, which matches cpsw_remove(). Its commit
message quotes a KASAN report of "slab-use-after-free in
cpsw_ndo_set_rx_mode_work".

Could that change be folded into this patch, so the two are not applied
separately?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791035789.git.kmehltretter%40gmail.com
