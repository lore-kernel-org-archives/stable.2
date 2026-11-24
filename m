Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556328;
	b=2gG/XHRbV60A27ukXPMUe8AlcZ5DQHpLjH+km89ZrEVR/F1qGRyyVqy2mIIQsEJOWbSi
	 5Tdj3XNkZOohH754rp6AvDswYZD/eXvNbijlNetwONMpULOSHz3QhBXCj3vN8CKeT0PV7
	 UmSt/OjRm7PwhqIBddjTJEzRp2s9MR9eH9EDR8fQ/JqyQ0+lwbcxzRBtaVg2FbcdbJvV/
	 cMWf/ZiVYmQXPHDvLhpYJly0t7sE4gUcz9P4v5snRRo7Q+Nc3trDYNkqfxTeM1qn8R4TT
	 Y3EvGUcGJkEe0zVuRIwDimuN+rVHAHdzrYZQwMlfQ9s/14o0MFPJvjcF4HpTk6xh1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556328;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UDznTv7tvXw7e6fmTZhMJ4Cm4gT1kF7rLrwjGIShnwY=;
	b=vmWgnrC6BNb9RVSwmu0k1OoTltjbnEQ/gC1STR2vfuDzCEeN305Dcf7vvuCUceh0S+w/
	 3ij+43yUlcnEMkNiUKU4LoVJ556p8HmBXRuVgnI9Y8uGK4KZ1DjgR2tkDBl4lmyHTznqw
	 7xKxaj+aJChvPPqR3LA7f50fvHD6WXPBe28EseiuJC26OIEinGrAjgXM4qo3hRYjXkLR9
	 DoprE99MR60B2yahbaex0BrRecbhTn75BtteYxLh4SVQTUxuIYzsW0d7kB1hv/rIIKO0j
	 CAuizvM/fUYbzBIePpJvr69j0x6+BD/c7zt0FmF+jCpDv7plLnGWaNQXx3oFN1IdwvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aucOB2zf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6E606A691;
	Tue, 24 Nov 2026 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aucOB2zf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97231F0089E;
	Tue, 24 Nov 2026 21:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795556328;
	bh=UDznTv7tvXw7e6fmTZhMJ4Cm4gT1kF7rLrwjGIShnwY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aucOB2zfnLBk8rLtyw/N5Epc20E2KqRxx+ZKX47RHV/9XWcFgAWwS8sD7BtrLr/8F
	 HAZKdXCwENrM4q0q4cw2tDPw6nf/2MTzYo1eWPsJnKvMUMRIKrJ3x2wsrqzdppNHs7
	 IqRWTY1IfX8UGVl2KSpmGYRRUoUmlznIuKexnSWhH967yb15jFrP+Q48UWL55kTIkC
	 Q60imLaVhJdxKonCtFb1iPw3gFJ5Psw63EuSG9LTSAhP1n8D2pnQzgVbTbMUP48Mfq
	 Ov3mj+Ja1ER1DBPvDe7zvqGj72+sKcQJx7Ksk1Z2EnEFp42LYPKhWkDC2RRISSX4oe
	 eH+kKc9jkDzTw==
Subject:
 Re: [PATCH net v4 4/4] igb: only allow runtime PM if the device can wake up
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 21:38:47 +0000
Message-ID: <179555632736.3135.1658046091917963917@kernel.org>
In-Reply-To: <20261120210134.133238-5-antonio@mandelbit.com>
References: <20261120210134.133238-5-antonio@mandelbit.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The runtime PM usage count can end up unbalanced, because the
  same decision is made twice.

--

igb: only allow runtime PM if the device can wake up

With this patch, igb_probe() drops the runtime PM reference taken by
local_pci_probe() only when pci_dev_run_wake() is true. Devices that
can't signal a wake-up from D3 are therefore never runtime suspended.
igb_remove() takes the reference back under the same condition.

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 4617aba5759d2..36bd395e36dab 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3654,7 +3654,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>  
> -	pm_runtime_put_noidle(&pdev->dev);
> +	/* A device that can't wake up wouldn't notice the link coming back
> +	 * while runtime suspended
> +	 */
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);
>  	return 0;
>  
>  err_register:
> @@ -3876,7 +3880,8 @@ static void igb_remove(struct pci_dev *pdev)
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  
> -	pm_runtime_get_noresume(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);

[Severity: Medium]

Can the runtime PM usage count get out of balance here?

pci_dev_run_wake() runs once in igb_probe() and again in igb_remove(),
and the first result isn't stored. pci_device_remove() then always ends
with a put:

drivers/pci/pci-driver.c:pci_device_remove() {
    ...
	/* Undo the runtime PM settings in local_pci_probe() */
	pm_runtime_put_sync(dev);
    ...
}

The count only balances if both pci_dev_run_wake() calls return the
same value.

It looks like the result can change while the driver is bound.
pci_dev_run_wake() checks pci_pme_capable(dev, pci_target_state(dev,
true)). On ACPI-managed devices, acpi_pci_choose_state() caps the target
state using a flag that root can change through sysfs:

drivers/pci/pci-acpi.c:acpi_pci_choose_state() {
    ...
	if (pdev->no_d3cold || !pdev->d3cold_allowed)
		d_max = ACPI_STATE_D3_HOT;
	else
		d_max = ACPI_STATE_D3_COLD;
    ...
}

d3cold_allowed_store() writes pdev->d3cold_allowed, and nothing
serializes that write against probe or remove. On a device that can
raise PME from D3hot but not from D3cold, toggling the attribute flips
the result of pci_dev_run_wake().

A second case is a device not managed by the platform, for example an
igb NIC behind a Thunderbolt or USB4 dock. If it is surprise-removed
while runtime suspended, the result also seems to change.
pm_runtime_get_sync() in pci_device_remove() resumes the device, and
pci_power_up() does:

drivers/pci/pci.c:pci_power_up() {
    ...
	if (pci_dev_is_disconnected(dev)) {
		dev->current_state = PCI_D3cold;
		return -EIO;
	}
    ...
}

After that, pci_target_state() returns D3cold:

drivers/pci/pci.c:pci_target_state() {
    ...
	if (dev->current_state == PCI_D3cold)
		return PCI_D3cold;
    ...
}

So igb_remove() tests the PME-from-D3cold bit, while igb_probe() tested
the D3hot bit.

If the call returns false at probe and true at remove, igb_remove()
does an extra pm_runtime_get_noresume(). One usage count then leaks on
each bind/unbind cycle. The device can't runtime suspend again, even
after the driver is rebound.

If it returns true at probe and false at remove, the final
pm_runtime_put_sync() in pci_device_remove() underflows and logs
"Runtime PM usage count underflow!". With power/control set to on, the
extra put uses up the pm_runtime_forbid() reference instead, and a
later pm_runtime_allow() underflows.

Would it be safer to call pci_dev_run_wake() once in igb_probe(), store
the result (for example as a bool in struct igb_adapter), and test that
stored value in igb_remove()?

e1000e and r8169 call pci_dev_run_wake() again at remove in the same
way, so this pattern already exists in the tree. In igb, though, this
would be a new imbalance, added by a fix that is tagged for stable.

>  #ifdef CONFIG_IGB_HWMON
>  	igb_sysfs_exit(adapter);
>  #endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120210134.133238-1-antonio%40mandelbit.com
