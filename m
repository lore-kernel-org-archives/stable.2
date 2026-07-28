Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836F25A2DD;
	Tue, 28 Jul 2026 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272703; cv=none; b=j98VrNoH5B5E6ywb+gEiNA3wo5op+OhJDEIhMWMQfH9UemmKqAc6R/ALU39njZhdlLsaD1BMcNhKPiIkjvngMVRGmTibxs0lcB+gO4yhxd2Si9W1CzzYxmFDDjwk/Xu0UhGE8jRbLuS8UrATPKMuhQ5roRpylMY8+K7cCKzNk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272703; c=relaxed/simple;
	bh=n8uCmLAu+vMSnsDdXLNubnTDxFvoOSr/RBOFmPFwJJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwN5vo25pyhgxK/ULrBz3KiYsTlK2nsUdZTLWGdoUJuAhbpC0aT5ljTlJxQkorHeoQY7BdM7zhQ17db75ZLtODYAbJxgOK6/UzaEixd1Kpw6nw3u2+Uk+0NyEksDideaCZSQB20HgFQlYXqtE5Sfo1AeoGiTNsGWUCQoSp9wSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBYuwqIj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBYuwqIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642421F00A3A;
	Tue, 28 Jul 2026 21:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785272702;
	bh=+d4Y6SJStY6jWcuTPSBIguPkXtE6f0A1wQTLHqva7gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XBYuwqIjMeSO56ld0pjQL/GJJBq94mvY0Bja3PEgAaBvIHvxTdnPjaC1SN5cdC9SQ
	 ZYybgPAbSOROu0zjTZ0LXIStOwjST9AzGiBxLRgpiTiKi1+g9sBBIaamuHYV8NDeJa
	 A3IWbni+K4hxb0o2S1hEOpM0cIzld8zvCS00YJgA/oqL2v/VHf1gg8o582F3KMQN7j
	 I1EAxAzzg2SFrNKwgkN6TPNX15ENuvx52enmHmeEAlxYAn5EW/dOWc86iw2/RAPn4n
	 SNZgYeH+xXIXb5YDhIIqktW7RJUfUJBdR5lHSO5LfPMG/N4dIzn+dQofXaojcjPnNh
	 Oipzca8nEfTdQ==
Date: Tue, 28 Jul 2026 15:05:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] nvme-pci: disable controller on admin queue IRQ setup
 failure
Message-ID: <amkZfAmClmnzSCYV@kbusch-mbp>
References: <20260715074459.50760-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715074459.50760-1-mhun512@gmail.com>

On Wed, Jul 15, 2026 at 04:44:59PM +0900, Myeonghun Pak wrote:
> nvme_pci_configure_admin_queue() enables the controller and then requests
> the admin queue interrupt. If queue_request_irq() fails it returns without
> disabling the controller, and no caller compensates: nvme_pci_enable() only
> frees the IRQ vectors and calls pci_disable_device(), after which
> nvme_dev_disable() treats the controller as dead and skips nvme_disable_ctrl().
> The controller is left enabled (CC.EN set) on this error path.
> 
> Disable it in the failure path, while the PCI device is still enabled so the
> CC.EN clear handshake completes.

Thanks, applied to nvme-7.3.
