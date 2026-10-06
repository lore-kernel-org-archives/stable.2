Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CF472796;
	Tue,  6 Oct 2026 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297088; cv=none; b=LWVY/imziceWUmQInQhhpQc8w4c/JrdEWM3Ot/9FTnUHJg1pImLKectvE1WcGUh/h/AZC17ix//HqWacCFUD0WmbPx8XNkTvOeK4+qOhdiZfRV/tuNWD0DE+bC0YZ+TbBmj/EJvnwprfS++o0H0aFz0OL//VeOobOhaqpc8ccMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297088; c=relaxed/simple;
	bh=ABsrCd4xsUiI1dIvQDDn75xRj4S9jxkBwXb5vUKxTmQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3l1jmiF3dHgs30Z2fdHAMfHQPhWbAPTowE8L4XR0Fh+Zl0wcia8qw2+rUtIZisNgjE2RkW4jt/7BAl6VnOfLU81OQrvRdIDj3gP8LRSqjeM/g6o0Y30547cuRQngxtN03uYJgRGIG23sRlV5APLiB2O5aVQ6ct7f0D/phfkF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDoM1SPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDoM1SPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A551F0089D;
	Tue,  6 Oct 2026 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297087;
	bh=zyhGUE+a4xlake265GIXRz9IKBNZHkIQPeRgPB19Rig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WDoM1SPnbQh5e9DeadcHW4kzjY2Hr63OudVM8wZkhS4t9fGiEX/+mWV8v0McRA31s
	 wySGFLk3nC5e3kIg7gPmS8BF3ep+ZiPiPLDE+9RR7Dk9+oe4qJHrBwVvZgxBNdVQab
	 RcDAQdHzHHycPwdoVvZsL0ieLH93vkmkAL9E1hiKvJZRCi7/c7eV2w+hktB8P8Snd2
	 biR2g+HrNYi6+nHq1iosBlN4rV1orkIBoA+u9wUCoaqVxtvlMohGngpcv4vsUi4tk+
	 d9rSI+uYTEYl8AqgOwEnC/5IdfvPxW79vUeRim7IVsij7+rTGzT7Z4WyA7twWU+OYQ
	 KxkZbHzQD/bAA==
Subject:
 Re: [PATCH net v2 3/3] net: fealnx: allocate the card index from an IDA
From: netdev-bot+sashiko@kernel.org
To: r.zhambakiev@prosoftsystems.ru
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mgr@kernel.org, shaojijie@huawei.com,
 aleksandr.loktionov@intel.com, benato.denis96@gmail.com,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
Date: Tue, 06 Oct 2026 14:31:26 +0000
Message-ID: <179129708601.434549.13207509601281200322@kernel.org>
In-Reply-To: <20261002140954.261779-4-r.zhambakiev@prosoftsystems.ru>
References: <20261002140954.261779-4-r.zhambakiev@prosoftsystems.ru>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the IDA "reuses ids on re-add,
  preserving the options[] and full_duplex[] mapping by probe order".

Pre-existing issues:
- [High] fealnx_init_one() (drivers/net/ethernet/fealnx.c:482-518) builds
  the PCI resource name in the stack array `char boardname[18]` and…
- [Medium] Other legacy Ethernet drivers have the same static per-probe
  card counter used to index fixed-size module-parameter arrays.

--

net: fealnx: allocate the card index from an IDA

fealnx_init_one() used a static card_idx counter that went up on every
probe. This patch replaces it with an id taken from an IDA, which is
freed when the probe fails and in fealnx_remove_one(). The id is kept in
netdev_private, and boardname[] grows to 18 bytes so it can hold a full
32-bit id.

> diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
> index b5e96c7037f37..627e570fd399d 100644
> --- a/drivers/net/ethernet/fealnx.c
> +++ b/drivers/net/ethernet/fealnx.c

[ ... ]

> @@ -473,9 +478,8 @@ static int fealnx_init_one(struct pci_dev *pdev,
>  			   const struct pci_device_id *ent)
>  {
>  	struct netdev_private *np;
> -	int i, option, err, irq;
> -	static int card_idx = -1;

[Severity: Medium]
This is a pre-existing issue in other drivers and was not introduced by
this patch, but the same static counter pattern shows up elsewhere.

amd8111e_probe_one() in drivers/net/ethernet/amd/amd8111e.c indexes
module parameter arrays with MAX_UNITS (8) entries and does no bounds
check at all:

	lp->ext_phy_option = speed_duplex[card_idx];
	if (coalesce[card_idx])
		lp->options |= OPTION_INTR_COAL_ENABLE;
	if (dynamic_ipg[card_idx++])

Here card_idx is declared as "static int card_idx;" in amd8111e.h. Does
the 9th probe read past the end of speed_duplex[], coalesce[] and
dynamic_ipg[]? Repeated sysfs unbind/bind would be enough to get there.

rio_probe1() in drivers/net/ethernet/dlink/dl2k.c and sundance_probe1()
in drivers/net/ethernet/dlink/sundance.c only check
"card_idx < MAX_UNITS" on a signed static counter. That is the same
wraparound case this patch fixes for fealnx. Should these get a
follow-up?

> -	char boardname[12];
> +	int option, err, irq, i;
> +	char boardname[18];

[Severity: High]
This isn't a bug introduced by this patch, but since boardname[] is being
resized here: is it safe to keep it on the stack at all?

Later in fealnx_init_one() the buffer is passed to the resource core:

	err = pci_request_regions(pdev, boardname);

__request_region_locked() in kernel/resource.c stores the pointer and
does not copy the string:

	res->name = name;

The regions are only released in fealnx_remove_one(). So once
fealnx_init_one() returns, the names of the BAR resources point into a
dead stack frame for as long as the device stays bound.

r_show() prints r->name with %s for /proc/iomem and /proc/ioports. Both
files are world-readable, and for readers without CAP_SYS_ADMIN only the
addresses are masked, not the name.

Can an unprivileged reader see stale kernel stack contents here? And
could the read fault if the probing task has exited and its vmapped
stack has been freed?

Passing DRV_NAME or pci_name(pdev), or keeping the name in
netdev_private, would avoid this. It would also make the 12 to 18 byte
resize unnecessary.

>  	void __iomem *ioaddr;
>  	unsigned long len;
>  	unsigned int chip_id = ent->driver_data;
> @@ -483,19 +487,24 @@ static int fealnx_init_one(struct pci_dev *pdev,

[ ... ]

> -	card_idx++;
> +	card_idx = ida_alloc(&fealnx_ida, GFP_KERNEL);
> +	if (card_idx < 0)
> +		return card_idx;
> +
>  	sprintf(boardname, "fealnx%d", card_idx);
>  
>  	option = card_idx < MAX_UNITS ? options[card_idx] : 0;

[Severity: Medium]
The commit message says:

  The IDA reuses ids on re-add, preserving the options[] and
  full_duplex[] mapping by probe order.

Does this still hold when an earlier probe fails?

With the old static counter, every probe attempt used up an index. The
Nth fealnx device probed always got options[N-1] and full_duplex[N-1],
even if an earlier probe had failed.

With this patch, the error path gives the id back:

err_out_ida:
	ida_free(&fealnx_ida, card_idx);

The next ida_alloc() then returns the lowest free id. Say card 0 fails
in pci_enable_device(), or at any later error label, and card 1 probes
next. Card 1 then gets index 0 and applies options[0] and
full_duplex[0], which were meant for card 0. That can force the wrong
media type or duplex setting on card 1's link.

The same happens on unbind/bind. The mapping follows the order in which
devices are re-probed, not the device itself. If both cards are unbound
and the second one is rebound first, it gets id 0.

Could the commit message describe this change in behaviour? Or should a
failed probe keep its slot, as it did before?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002140954.261779-1-r.zhambakiev%40prosoftsystems.ru
