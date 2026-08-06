Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D539BFF8;
	Thu,  6 Aug 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036835; cv=none; b=SIu0a37Ipddjm+1NoBKK7NuCoihBMF6a2pjK1D9IOsCUgKOp1G9NXGrN/mWQbdDTqTUyvnd+4JwJXs2xRBHyEXL7Q9z21TPTRR8b/fHuivtw0NYr+3+ThuYh7UVsERkf8eLSZyk0zYI0D8EST24V0/QlOFcAVyqABT2K/hcPbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036835; c=relaxed/simple;
	bh=G5gB71O+AMwIn7ZKV6k/SQMv8lHJ3CXs2D9nYyxGHto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHNdvHYCk2UvMDaS54Trnq1GWb811X4LBVeS6T8J30Mg1YJ/anvAneKiLf+JGmWzm6EsCC1rC8j9Z3acMRTpAAFcmnREe4o2CvWslMGUEAb5O9Z3ZYqeCWEJzoiCc9NKt81Kbr4kf+IhMkgl0gUX/hpMb1ZL1tvc4nYXfAZjVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqiuYSCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqiuYSCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697031F00A3A;
	Thu,  6 Aug 2026 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036833;
	bh=AgXrl7/Klsy7YlnozOzKlN0KBdwpjsLzFlJp4/F2paw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KqiuYSCeVnyQIrmSDfXwDyZ1pn5X4MacE8BeEzjcwvc5JW8RdELL5p36vx7RbK0oY
	 XiwG5PO4hNV3bF6COocUx2CWnmPot5WgiAv0IA6thihVUa4cghZQRW9oaq51lDz06f
	 BbPEHsLCqkO4XM9uNWjB2LrL7FArqlEszCMyNmsIlBXRDi92cy3KAnl1ak8v82c244
	 VzAudf//I/aGbkzkaGcA31fuFMjstbtkd7kAXqzJ01REfEv5EXeTVsbKPY1PZVKguL
	 zTTiCt7ucOmpfTjQORyVVu0qo/ICJSum7LzcBH5GJ5Lnv+sw9DDOS2BcPZ9Z74kcNL
	 BAm6Gd11uy6jA==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	doruk@0sec.ai,
	michal.swiatkowski@linux.intel.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net 01/10] iavf: return EBUSY if reset in progress or not ready during MAC change
Date: Thu,  6 Aug 2026 10:20:32 -0700
Message-ID: <20260806172032.2935407-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-2-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
iavf: return EBUSY if reset in progress or not ready during MAC change

This adds an early bail-out in iavf_set_mac() so that a MAC address change
requested while the VF is resetting, or before the adapter reaches
__IAVF_DOWN, returns -EBUSY instead of waiting with the netdev instance
lock held.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 29b8403a066bc..630388e9d28cb 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1042,6 +1042,9 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  	struct sockaddr *addr = p;
>  	int ret;
>  
> +	if (iavf_is_reset_in_progress(adapter) || adapter->state < __IAVF_DOWN)
> +		return -EBUSY;
> +
>  	if (!is_valid_ether_addr(addr->sa_data))
>  		return -EADDRNOTAVAIL;

[Severity: Low]
Is the placement of the new gate ahead of is_valid_ether_addr()
intentional?

With this ordering, a request carrying an address that can never be
accepted (all-zero, multicast, other non-unicast MAC) now reports -EBUSY
rather than -EADDRNOTAVAIL whenever iavf_is_reset_in_progress(adapter) is
true or adapter->state < __IAVF_DOWN.

The core does not validate the address itself, so the driver check is the
only one on the rtnetlink/ioctl/sysfs paths:

net/core/dev.c:netif_set_mac_address() {
	if (!ops->ndo_set_mac_address)
		return -EOPNOTSUPP;
	if (ss->ss_family != dev->type)
		return -EINVAL;
	if (!netif_device_present(dev))
		return -ENODEV;
	...
		err = ops->ndo_set_mac_address(dev, ss);
}

Since -EBUSY advertises a transient condition, callers that retry on EBUSY
would loop on input that can never succeed. Would moving the state gate
below the is_valid_ether_addr() check work equally well for the stated
goal?

The ordering is still present at the end of the series, and the commit
message does not mention the change in returned errno for invalid
addresses. Could that be noted, or the checks reordered?
