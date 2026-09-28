Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1E486E7D;
	Mon, 28 Sep 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590218; cv=none; b=VDGACXOQFlGvSOpc/6mi0hJvrUMQrrr/CbQwvU/w94JV/wNtcY/Fk4cQksgM36T7kHnd3ZqiqXUuhKBZqIvJMPdwwGdOMRMxfEIV0U9tthT1Yl65ZR9MRI6NsAdyu0TmPvmJ8EjxBET9vnSOKtQPjb0VW6gHUoA65/HeWkdRza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590218; c=relaxed/simple;
	bh=Y8tqISrbaLy2wxSqdBa7oBcvHS/ml/79qD4P6odJHT4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQcvBAGBvlnxo0OWns02nALlWkHleG+VUy7E62FJpg71sXxSXm+/QjWe+oxsrutv/LCvbYr+Ww9n4ddnteDGHsXUlReF3NGyal8bZTodXuoJfG2wAFtL7GrS2rVBYLs1txlvbwmi+o6phyiFPA5Xb2u9lQSfofxV/sh9za/y71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlX7tEQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlX7tEQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F851F000FF;
	Mon, 28 Sep 2026 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790590216;
	bh=9MntvWW9bEeKi0i0MyUEHXEi1fIu9h3nvRSRBG6xKOE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YlX7tEQ6DPjiU6Ou1ycBzSHAUWiI/6t+uxGq0KekQoUIt5bNPFcisFea6QqI3p6/8
	 bP6/W+oMxqVgPWd/ulgmWlnAQJx5e9OhAGHA2lrNQd8hqVfkc7+v8K90CtbckqWVEf
	 k97YUxnACPiWYmSpm5+qHykloi0/zBEBXUreV7tGbw7+3KutLComTtSQql0H9SF3ob
	 mLUSfB0gm0LCp42ZifW3AtuwX0OTJWbD/TTuV0wNsziouWFwBuTCuFZi4hs/kP587r
	 uBE/NqHWv/0vJlrKK8exe9jngIKZKA8NjWzkbpWQdbWJslLd+dLpfzasNLn1g1UycF
	 OwrhFbWMq/74w==
Subject:
 Re: [PATCH net v3] net: e1000: fix warning in iounmap on probe failure
From: netdev-bot+sashiko@kernel.org
To: nsvatoslav515@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
 aleksandr.loktionov@intel.com, stable@vger.kernel.org
Date: Mon, 28 Sep 2026 10:10:15 +0000
Message-ID: <179059021568.3145.6865816311046573732@kernel.org>
In-Reply-To: <20260924095152.3069-1-nsvatoslav515@gmail.com>
References: <20260924095152.3069-1-nsvatoslav515@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message and v3 changelog describe a different fix
  from the diff that was submitted.
- [Low] The new `if (hw->hw_addr)` check before `iounmap(hw->hw_addr)` in
  e1000_probe() (drivers/net/ethernet/intel/e1000/e1000_main.c:1232) is…
- [Low] The subject quoted in the Fixes tag is wrong.

--

net: e1000: fix warning in iounmap on probe failure

This patch changes the iounmap() calls in the e1000_probe() error unwind
so that a NULL hw->ce4100_gbe_mdio_base_virt is never passed to
iounmap(). On non-CE4100 hardware that pointer stays NULL, and on x86 a
NULL argument to iounmap() triggers a WARN_ON_ONCE.

Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b

> Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY registers")

[Severity: Low]
The subject quoted here doesn't match the commit it points to. The title
of 13acde8fffc0af is:

  e1000: cleanup CE4100 MDIO registers access

The SHA itself looks right. That commit added the unconditional
iounmap(hw->ce4100_gbe_mdio_base_virt) to the probe error path.

Could the tag use the real subject and the usual 12 character abbreviated
SHA?

> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..156903089fa6 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> -	iounmap(hw->hw_addr);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);

[Severity: Medium]
Is the commit message describing this version of the code? The message
says:

    Fix this by conditionally unmapping the CE4100 MDIO base only if the
    mac_type is e1000_ce4100, matching the exact logic used in e1000_remove().
    The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
    be valid for all error paths reaching the err_sw_init label.

The v3 changelog says:

  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here

The diff has no mac_type check, and iounmap(hw->hw_addr) is still behind
a NULL check. That looks like the v2 approach.

Was the wrong diff sent with the v3 message, or is the message out of
date? The Reviewed-by may also have been given for a different version.

The pointer check in the diff looks like the better choice. A mac_type
check would still reach iounmap(NULL) when the CE4100 ioremap fails in
e1000_probe():

	if (hw->mac_type == e1000_ce4100) {
		hw->ce4100_gbe_mdio_base_virt =
					ioremap(pci_resource_start(pdev, BAR_1),
						pci_resource_len(pdev, BAR_1));

		if (!hw->ce4100_gbe_mdio_base_virt)
			goto err_mdio_ioremap;
	}

err_mdio_ioremap frees the tx and rx rings, then falls through to
err_sw_init. On that path mac_type is e1000_ce4100 but the MDIO pointer
is NULL. A mac_type check would therefore still hit
WARN_ON_ONCE(!is_ioremap_addr(addr)) in the x86 iounmap().

Could the commit message and changelog be updated to describe the NULL
pointer check, instead of changing the code to match the message?

> +	if (hw->hw_addr)
> +		iounmap(hw->hw_addr);

[Severity: Low]
Can hw->hw_addr ever be NULL here? It is mapped earlier in e1000_probe():

	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
	if (!hw->hw_addr)
		goto err_ioremap;

The err_ioremap label comes after this block. Every other path into
err_sw_init runs after the mapping has succeeded, so the check is always
true.

The commit message says the hw_addr iounmap() "remains unconditional",
and the v3 changelog says this check was removed. Should it be dropped?

>  err_ioremap:
>  	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
>  	free_netdev(netdev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924095152.3069-1-nsvatoslav515%40gmail.com
