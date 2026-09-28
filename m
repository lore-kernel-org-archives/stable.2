Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61910485501;
	Mon, 28 Sep 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590595; cv=none; b=LwYv1nZZC5dtk6vVNrRMEkAYylwDI0v3uZxj3QqfclI8mJH8zEYEjoZ3EZPH/4+k34Z4k6aZoxW4q7eyOTvErXYjCIuMt0CJUDnRsa5vL6YLkf3J5AIPuDP6v1hj6l96HF1VZ8kMGNpIOKjGylxwj7H+zWAztD6ntVVZ5YVs3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590595; c=relaxed/simple;
	bh=zCo/UPBMdU9bV/I89CwGEALCttBRx/RtfQo7P/GNFGQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MiM6QV+NVOns4jkrzU0co2OAj7hpPzu0Q+8DBQXbUMyHpkja8iR9WhkfuYLBYRQX2Ldu1ukoe0mj5Gj7wjsGIb7Fh8NpUZ7NqjqBA7gR2bFLbbgT9/PCDRyTQ57ZcZOHskBIB5sDdUsmdOqBeBB+vIEXA2jmgSf2o/DTYgF9v7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea2IoAqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea2IoAqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462611F000FF;
	Mon, 28 Sep 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590594;
	bh=etan1i0QlkGI9ymPe4sBc1kewwzg4v5oWnGmaGuoq0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ea2IoAqbhQBN298GzM7zylp3SKGP+PY+5jwXn8L7vS99opwR+N/Zm7DwK+j0dpQap
	 AjTgk7uKldbJTFRMpOUGiuzIWqE6WbbNQZFIqdnDtS+oOsd62lHMaAUZX0MnpnDrJR
	 yjD7nKqP2s3dBg4GVCNcLTVHzcZnevEOjfPr1RkgyouoMtLsMVxiYFbspkcFqCI62I
	 Jkr8bjl92VXgKIK9BGycHje20ZPIysXbbs308FqZslmjlx1B/kmCcfeMwH7P+T/Nya
	 2Xr30D89hjEzJzuWa38UfcDLvIi2RJUbsQbt1cYVrLSodPVSSA+wHxSKGzusk1kTYO
	 xeGMIrj0zUv1w==
Subject:
 Re: [PATCH net v4] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com, stable@vger.kernel.org,
 aleksandr.loktionov@intel.com
Date: Mon, 28 Sep 2026 10:16:32 +0000
Message-ID: <179059059281.3145.5878621064360703289@kernel.org>
In-Reply-To: <20260924095955.3471-1-nsvatoslav515@gmail.com>
References: <20260924095955.3471-1-nsvatoslav515@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says something different from what the
  patch does.
- [Low] The Fixes: tag does not match itself.

--

net: e1000: fix warning in iounmap on probe failure

The error unwind in e1000_probe() unconditionally calls iounmap() on
hw->ce4100_gbe_mdio_base_virt. That pointer is NULL on non-CE4100
hardware, so the call triggers a WARN_ON_ONCE on x86. The patch makes
the MDIO unmap conditional.

Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b

> Fix this by conditionally unmapping the CE4100 MDIO base only if the
> mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().

[ ... ]

> Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")

[Severity: Low]
The subject in this Fixes: tag doesn't match the commit. Commit
13acde8fffc0af has this subject:

    e1000: cleanup CE4100 MDIO registers access

That commit moved the global MDIO pointer into struct e1000_hw. It also
changed the error path to iounmap(hw->ce4100_gbe_mdio_base_virt), so the
hash looks like the right target. Could the subject in the tag be changed
to match? checkpatch.pl flags this kind of mismatch.

[ ... ]

> v3:
>   - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100

[ ... ]

> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..d7e279b739b8 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);

[Severity: Medium]
Does the commit message match this hunk? The message and the v3
changelog both say the unmap now depends on hw->mac_type ==
e1000_ce4100, "matching the exact logic used in e1000_remove()". The
code here checks the pointer for NULL instead. e1000_remove() does this:

    if (hw->mac_type == e1000_ce4100)
        iounmap(hw->ce4100_gbe_mdio_base_virt);

The NULL check actually looks like the more complete fix. In
e1000_probe(), e1000_init_hw_struct() sets hw->mac_type well before the
CE4100 MDIO ioremap runs. So on CE4100 hardware, these two gotos reach
the cleanup with mac_type == e1000_ce4100 and the pointer still NULL:

    err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
    if (err) {
        pr_err("No usable DMA config, aborting\n");
        goto err_dma;
    }
    ...
    err = e1000_sw_init(adapter);
    if (err)
        goto err_sw_init;

With a mac_type check, both paths would still call iounmap(NULL).

Could the commit message and changelog be updated to describe the NULL
check that is actually submitted? Since v3 was sent without the staged
changes, it would also help to confirm which version is intended. It's
also not clear which version the Reviewed-by tag from v2 covers.

>  	iounmap(hw->hw_addr);
>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924095955.3471-1-nsvatoslav515%40gmail.com
