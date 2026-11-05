Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.193.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911648;
	b=NMK/9Rx/exHF9ShqeSduDXmT+zicxqwgOe2ZMFT8haPfuK4lAcjQjnR5FPKC//g/0PGO
	 dl3l5w9HPtGIYfpPxnTN+zDyILkm2mXWkyOaOsd65f70J91aSQfTl2nLMmW+hki+AV+nR
	 euGDE7+ePeG5xSga0S2P3Qsm65arYkWZei4rRpZadv/edrmU1nAvN62htBoXHdZZGqFXL
	 P3WpAL/fDTYFf96gNqMMeVkDnr+sYqkx7ZEbDyvEcb5k+gt1O7/R8mNklIT6KKcusAyfN
	 nWnpMCSRNi1wWmu1Fd3tWGUabOfLXB8AZTeB2C0ohX3vv73ZFaMrhfYFAaeKH3+6NUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911648;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=70nlDvoBPsnGpl5oVrTXxWd2kNX6qx4N/2s5G+z+mzw=;
	b=OMimTDKEQZ1rrAYEFxctWLQWrBZT1Bjvv7i2ue29pNefnh2A+49BNiYWRDxuin2s2hnu
	 1tiWHk/qjYIrIR5c+Fu/90zsmIVJcvWgzf7hF4NmxRs048BFzyzpM8vFKKXh8MLdpOoWt
	 oNYRWGaVpvjq7AuYhK22b8vjl0Wgnu947zjb3Ca6xyaJwSpgCuXz1IQowsdi9d/udWyvy
	 0dp2ph+kgS74Tp9W39ZCjBFits4ZUs9mNKzW4cM/SvZ3geYwXDEP4AlWiQJv3+buS1c5Z
	 A9Fi7ZbAYrHMKpmlqR1UKgs8+nXF3569td76wCDo0ijIzixrHKlpuFT+DaWRZi/4AgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auroraos.dev;
	spf=pass smtp.mailfrom=auroraos.dev;
	arc=none smtp.remote-ip=95.181.193.9
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7F606A31B;
	Thu,  5 Nov 2026 20:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C7F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.15.64) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 5 Nov 2026
 23:47:14 +0300
Message-ID: <71b77625-8475-43da-a62b-983cf572229d@auroraos.dev>
Date: Thu, 5 Nov 2026 23:47:13 +0300
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pmdomain: rockchip: Don't log when of_clk_get() fails
 with -EPROBE_DEFER
To: Yao Zi <me@ziyao.cc>, Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner
	<heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Sebastian Reichel
	<sebastian.reichel@collabora.com>, Midgy BALON <midgy971@gmail.com>, Finley
 Xiao <finley.xiao@rock-chips.com>, Frank Zhang <rmxpzlb@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, Kevin Hilman <khilman@linaro.org>, Caesar
 Wang <wxt@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261105001257.1368266-1-me@ziyao.cc>
 <20261105001257.1368266-3-me@ziyao.cc>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20261105001257.1368266-3-me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

Hello!

   Please consider using --no-git-fallback with scripts/get_maintainer.pl --
I don't see what do I have to do with this patch (other than fixing another
bug in this driver earlier).

On 11/5/26 3:12 AM, Yao Zi wrote:

> Current error handling code considers -EPROBE_DEFER as hard errors,
> logs misleading dmesg like,
> 
> rockchip-pm-domain ff600000.power-management:power-controller: power-domain: failed to get clk at index 0: -517
> rockchip-pm-domain ff600000.power-management:power-controller: failed to handle node power-domain: -517
> 
> Use dev_err_probe() at the callsite of of_clk_get(),

> and check for -EPROBE_DEFER in places> where its return value could propagate to.

   To where?
   And I didn't understand why you couldn't just call dev_err_probe() everywhere --
the error code seems to always be propagated...

> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
> Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 34c862e56aad..c147cc88edb1 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
[...]> @@ -1006,8 +1006,10 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
> 
>                 error = rockchip_pm_add_one_domain(pmu, np);
>                 if (error) {
> -                       dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
> -                               np, error);
> +                       if (error != -EPROBE_DEFER)

   Why not just call dev_err_probe() instead?

> +                               dev_err(pmu->dev,
> +                                       "failed to handle node %pOFn: %d\n",
> +                                       np, error);
>                         return error;
>                 }
> 
> @@ -1102,15 +1104,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
>         for_each_available_child_of_node_scoped(np, node) {
>                 error = rockchip_pm_add_one_domain(pmu, node);
>                 if (error) {
> -                       dev_err(dev, "failed to handle node %pOFn: %d\n",
> -                               node, error);
> +                       if (error != -EPROBE_DEFER)
> +                               dev_err(dev, "failed to handle node %pOFn: %d\n",
> +                                       node, error);
>                         goto err_out;
>                 }
> 
>                 error = rockchip_pm_add_subdomain(pmu, node);
>                 if (error < 0) {
> -                       dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
> -                               node, error);
> +                       if (error != -EPROBE_DEFER)
> +                               dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
> +                                       node, error);
>                         goto err_out;
>                 }
>         }
[...]

MBR, Sergey

