Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246E346ADB;
	Tue, 29 Sep 2026 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709794; cv=none; b=f6OusgKsDkV4aJiuqhASQs7kN4cHJNo6oIXxMv+iHrN+qDYJMMj6SEZXjT7GyyyST6u4PkrB0Wmakzl30UKeUBhUOvNO9SOUHyc48dm+/qNonpuSD2i0va0iub9lOdb5KFHcTqCzdEkBXmn5KNzRroCEmWQ9WcvLO7zPKNRiIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709794; c=relaxed/simple;
	bh=cSQ7YCu+UoGfjz8hkxjPBkniKzoBGa1mW6bgEpORYvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oCVM6r93zTICVjnuXIXYvDqxdYFwU2Peom6S+hqYcPdpfc7eJFU4I1sB4OI/mcP1MDh4JZPkWw+ZGWY0Tg6uySEeYR+G4wwfigLY4R9znJhhcZjyp+SROSTYhrL7HaWEtrK35wULzgDePLDjPQkAtvawtj56hPBrfmnhMxn5WNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (91.78.6.248) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 29 Sep
 2026 22:07:53 +0300
Message-ID: <3b43b4fb-8479-4eb2-be58-1df6f0f747b9@omp.ru>
Date: Tue, 29 Sep 2026 22:07:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] net: ravb: fix resource teardown ordering
To: Jiale Yao <yaojiale02@163.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?=
	<niklas.soderlund@ragnatech.se>, Paul Barker <paul@pbarker.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20260927144741.1320558-1-yaojiale02@163.com>
 <20260927144741.1320558-7-yaojiale02@163.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20260927144741.1320558-7-yaojiale02@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/29/2026 18:54:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 206322 [Sep 29 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 125 0.3.125
 408a76d0ab6a6a06c054d212c38932c1e9d7db86
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 91.78.6.248
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/29/2026 18:57:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/29/2026 5:22:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

   I guess you used scripts/get_maintainer.pl -- if so, I suggest that
you add --no-git-fallback next time. Your current To: list is painfully
long and contains some long defunct addresses (like mine)...

On 9/27/26 5:47 PM, Jiale Yao wrote:

> ravb_remove() frees the netdev before devres releases the managed IRQs.
> The handlers use the netdev as their data pointer, so an interrupt during
> that window can access freed memory. Probe error paths have the same
> ordering problem.
> 
> The remove callback also returns when runtime resume fails. That leaves
> the netdev registered while the driver core still releases its managed
> resources. A running interface already holds a runtime PM reference, so
> the extra get cannot invoke a failing resume. A resume failure therefore
> occurs while the interface is down and ndo_stop() will not be called.

   Seems like a separate problem?

> Place the IRQ resources in a dedicated devres group and release it before
> freeing the netdev. Continue unregistering and freeing software resources
> when runtime resume fails, but skip the unmatched runtime PM put.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Fixes: 48f894ab07c4 ("net: ravb: Add runtime PM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ea1c7e536791..a25f5ac7062f 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]> @@ -3124,6 +3131,8 @@ static int ravb_probe(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_dont_use_autosuspend(&pdev->dev);
>         clk_unprepare(priv->refclk);
> +out_release_irqs:

   Somewhat unobvious label name, given the following call...

> +       devres_release_group(&pdev->dev, priv);
>  out_reset_assert:
>         reset_control_assert(rstc);
>  out_free_netdev:
> @@ -3141,9 +3150,10 @@ static void ravb_remove(struct platform_device *pdev)
> 
>         error = pm_runtime_resume_and_get(dev);
>         if (error < 0)
> -               return;
> +               dev_warn(dev, "failed to resume device: %d\n", error);
> 
>         unregister_netdev(ndev);
> +       devres_release_group(dev, priv);
>         if (info->nc_queues)
>                 netif_napi_del(&priv->napi[RAVB_NC]);
>         netif_napi_del(&priv->napi[RAVB_BE]);
> @@ -3153,7 +3163,8 @@ static void ravb_remove(struct platform_device *pdev)
>         dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
>                           priv->desc_bat_dma);
> 
> -       pm_runtime_put_sync_suspend(&pdev->dev);
> +       if (error >= 0)
> +               pm_runtime_put_sync_suspend(&pdev->dev);

   Hm, definitely seems like a material for a separate patch...

[...]

MBR, Sergey

