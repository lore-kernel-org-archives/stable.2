Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055574;
	b=LazHhM+XwqXwoikH2WZV7KnfYfkOQN0ReqY+f1hWNxKmLqj11qan1dhIswfyQQ2qpqq9
	 K+ORdSaja44IsX/LA8Yd8qEF5Tj/2dvpu4C7e7JRvoqh2+texeA5/TWk1kPbgKWkqRvBJ
	 ISqeaJNMiGUoDtu0zsXTGRMdqaVIjKEkIN9jfni6J6lw0nS9FGMrNqTCUB1Gnk6TDeMWU
	 Vbe5TKMge/IIB9xQkFCeMB62cLj6/+uu9Qv+f3jbdU/thVStNNpSPiZjiH0TBc7m6LVmU
	 TQlviBvEFjVcTuunn/XGd+wqqYqpfJLeG0MkkF1zPnWyX/KBo4md9H4Nw6cvFGQ6ozQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055574;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/RiPgyoXuembimyDq6WnhbjkgPIJFpoffN9+ARbON4Q=;
	b=Hrc/+U+5G33HoEXLBzK04M/I4DIW9nWYBlomHezhJ2p8I47SDxuAEZNBPCzhtZknv7/l
	 WIQ+lRFrxHJ2Tx5dmv6b93ScWjxZjUuzkOhTyOdE0/RD4nTTnrRywUxXktMSCzBNFZrYO
	 9LGzRF3SGUgHxRFjXTi+EWWkubVT3SaDq5UtOtOYzDnUWRJQ7gLuWViuF6ArkYKo1UfaL
	 Yy/AM1oMz9ee1xnYJKcDhvLwiGcHQDeAj118/nRxLSzX9qrf/gBdZ3/JB+8yif4Q1H23Y
	 lQ98TcA0I5cDB0YrFgqJ350bc7JJLhIRr0hemqW13B/KgO3LElKIpJCI8AqwLnZMY0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjLVTBZa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60B606A326;
	Sat,  7 Nov 2026 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjLVTBZa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286251F0089F;
	Sat,  7 Nov 2026 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794055573;
	bh=/RiPgyoXuembimyDq6WnhbjkgPIJFpoffN9+ARbON4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kjLVTBZanYT45cNamz8KZqx4UF1JUJoQOjZ2AZ1BlKr3QRZMTupufknRY5QkMZ+lX
	 UnTFpTddxV3lyO6+WRTw1eIiWzxH9XvUQKw5Cv1BKJRchgtVXQsraaAnYgsaifghaN
	 qoJUORi35W5qKZLS21RYDRDTxtsyEHGDUo9hyLmwNRR4Ei6ofquYj2yZOcPqH+8gKr
	 Afh7CPIoU3gAFJ4B56UABiiiJC+WrPYDVBUFwGtwfyeOuR8ISHuf11joJ8TgGOfaes
	 XFllM0JZ9GK/Tjhg7OPS1DHdKuauN4Yi3/mSxRCU8Tfv75sLGJeAPe/GFakbG6BOv4
	 joX4XEJegZ7wQ==
Subject: Re: [PATCH] igb: disable the PCI device when resume fails
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 07 Nov 2026 12:46:12 +0000
Message-ID: <179405557264.994134.1212641106918033235@kernel.org>
In-Reply-To: <20261103102849.1340413-1-vulab@iscas.ac.cn>
References: <20261103102849.1340413-1-vulab@iscas.ac.cn>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds pci_disable_device() calls that unbalance the PCI
  enable count.
- [High] igb: missing interrupt and hw control cleanup in __igb_resume()

--

igb: disable the PCI device when resume fails

This patch adds pci_disable_device() calls to __igb_resume() for the cases
where igb_init_interrupt_scheme() or __igb_open() fails after
pci_enable_device_mem() has succeeded. The aim is to release the PCI
enable reference that resume takes when the resume fails.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c6..853bc99a10113 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9621,6 +9621,7 @@ static int __igb_resume(struct device *dev, bool rpm)
>  
>  	if (igb_init_interrupt_scheme(adapter, true)) {
>  		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
> +		pci_disable_device(pdev);
>  		return -ENOMEM;
>  	}
>  
> @@ -9647,6 +9648,9 @@ static int __igb_resume(struct device *dev, bool rpm)
>  	if (!rpm)
>  		rtnl_unlock();
>  
> +	if (err)
> +		pci_disable_device(pdev);
> +
>  	return err;
>  }

[Severity: High]
When __igb_open() fails here, the new error path disables the PCI
device but leaves the rest of what __igb_resume() set up in place.

Earlier in this function, igb_init_interrupt_scheme(adapter, true)
has enabled MSI-X or MSI on pdev. It has also allocated
adapter->q_vector[] and registered their NAPI instances on
netdev->napi_list. igb_get_hw_control() has then set
E1000_CTRL_EXT_DRV_LOAD.

None of the __igb_open() error paths call
igb_clear_interrupt_scheme(). If __igb_open() fails at err_setup_tx
or err_setup_rx, it also skips igb_release_hw_control(). That happens
when ring allocation fails in igb_setup_all_tx_resources() or
igb_setup_all_rx_resources().

So after this hunk the device is disabled while:

  - MSI-X or MSI is still enabled on pdev
  - the q_vectors and their NAPI instances are still allocated
  - firmware still sees DRV_LOAD and believes the driver owns the
    hardware

The runtime PM case is worse. When igb_runtime_resume() returns an
error, rpm_resume() leaves the device in RPM_SUSPENDED. The next
runtime resume then runs __igb_resume() and
igb_init_interrupt_scheme() again on this uncleaned state:

  - If MSI-X was in use, pdev->msix_enabled is still set and
    __pci_enable_msix_range() hits WARN_ON_ONCE(dev->msix_enabled).
    igb then falls back to single vector MSI. That overwrites
    adapter->num_q_vectors with 1 and leaks adapter->q_vector[1]
    onwards.
  - If MSI was in use, the same thing happens through
    WARN_ON_ONCE(dev->msi_enabled) in __pci_enable_msi_range().
  - igb_alloc_q_vector() then finds the existing q_vector[0] and
    memsets it. It calls netif_napi_add_config() on a napi_struct
    that is still linked on netdev->napi_list, which corrupts that
    list.

If this patch is meant to unwind a failed resume, shouldn't this path
also undo igb_init_interrupt_scheme() and igb_get_hw_control()? For
example, igb_clear_interrupt_scheme() and igb_release_hw_control()
could run before the device is disabled.

__igb_shutdown() and igb_remove() already call both helpers, along
with pci_disable_device(). How do you intend the resume error unwind
to stay consistent with those teardown paths?

[Severity: High]
Can these new calls lead to a double pci_disable_device()?

The commit message says:

  The PCI enable count stays elevated and the device remains enabled
  even though the driver failed to resume it.

A failed resume doesn't unbind the driver. igb already drops its enable
reference unconditionally on every teardown path:

drivers/net/ethernet/intel/igb/igb_main.c:igb_remove() {
    ...
	free_netdev(netdev);

	pci_disable_device(pdev);
}

drivers/net/ethernet/intel/igb/igb_main.c:__igb_shutdown() {
    ...
	igb_release_hw_control(adapter);

	pci_disable_device(pdev);
    ...
}

igb_io_error_detected() also calls pci_disable_device() before it
requests a slot reset. __igb_shutdown() is reached from igb_suspend(),
igb_runtime_suspend() and igb_shutdown().

Without this patch the count looks balanced:

  probe: 1
  suspend: 0
  resume: 1
  failed resume: still 1
  remove or next suspend: 0

With this patch, a failed resume drops enable_cnt to 0 while the driver
stays bound. Any of the following then calls pci_disable_device() a
second time:

  - rmmod or unbind
  - the next system or runtime suspend
  - reboot or poweroff
  - AER error_detected

pci_device_remove() calls drv->remove() even when pm_runtime_get_sync()
fails, so unbind can also hit this after a failed runtime resume.

In drivers/pci/pci.c:

pci_disable_device() {
	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
		      "disabling already-disabled device");

	if (atomic_dec_return(&dev->enable_cnt) != 0)
		return;
    ...
}

That second call warns, which panics the host when panic_on_warn is set,
and leaves enable_cnt at -1.

>From then on, the count stays wrong:

  - The next pci_enable_device_mem() in __igb_resume() moves the count
    from -1 to 0. It still enables the device, and __igb_resume() turns
    on bus mastering, but pci_is_enabled() now reports false.
  - Each later pci_disable_device() moves the count from 0 to -1 and
    returns early. do_pci_disable_device() never runs, so
    PCI_COMMAND_MASTER is no longer cleared on suspend or unbind.

The existing teardown paths already release this reference. Should the
new pci_disable_device() calls be dropped? If they stay, the other
disable sites would need driver state to make them conditional.

Because of the Cc: stable tag, this change would also be backported to
stable trees.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103102849.1340413-1-vulab%40iscas.ac.cn
