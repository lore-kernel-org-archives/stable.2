Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A694071C4;
	Sat,  6 Jun 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705917; cv=none; b=rs2/FvTk85dSkSnc34I1mBJZcMIQY7RTMyTrASMdGVYKXRWzxHlZbqSgi7UvldlS8m8UlUJxVLg0ovkpRpZ/79woY3JcoPzR/rZFPUrElSTiT1/mre35HroHvxeK669nLqhNdzJzljmX7hY9P1unuEOnystBqvPfgbTr9DHWawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705917; c=relaxed/simple;
	bh=w8KItVAt0+fm6V6WDJEnFS5+1rYNiDNOukSq1TXw1bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9sWnbpKMeYFpZt6Uv6VZHOiucexEmCleuqxSChtu+Nvfb6gM1yqt5eN9echPfxfB5sfNQMd48/onCDXmVguOn5J3P2+cjonvk5sgO5wn4SNwyS7BgfeaJQUNCgJfw8vr38Q6iOvzfppkX/5Baymmr7uuzs4nwGPLt3oWZU3Was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrUiDR37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrUiDR37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD0C1F00893;
	Sat,  6 Jun 2026 00:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705916;
	bh=HWbV10nnmTpQwfZw6fhIV0Pl+PcFXfEUQ+ubuK4Q5SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrUiDR37yIzhkKIN7ptGZh8q6FHVENUeGnPGM68yovSge+YHysgUzb29/dyoKdK+c
	 ddb+IhQEwAV+Bg8iwZCwVC1m+TMdd6asWEpP9k4EzLrjt3mqKgzMiiIcUDMb7CZ8Sv
	 r0VoB53EsHebo13NiSto3oCLM/bOhViYVFZT0tNfgf6NrCCektNO4g0KE4etod4ixJ
	 F5grSq2LHP4oWAzR+DyVRAyfvslfeau7SE4tcp/NRhkC8wGGHJwsGW1AXOWQF+YLfT
	 qo5u99nviSo2cBLkHfoQQjQNn6DaYRAk14WhXmXDFpcWO9fHK+caVf+gd+clavdxzy
	 b/WNLae/qW9Og==
From: Jakub Kicinski <kuba@kernel.org>
To: lihaoxiang@isrc.iscas.ac.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ariele@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] bnx2x: clean up VF PCI resources on probe failure
Date: Fri,  5 Jun 2026 17:31:47 -0700
Message-ID: <20260606003146.4001333-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603071729.799370-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260603071729.799370-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Sashiko points out other problems with the error path
here, they should all be fixed in one series."
---
bnx2x: clean up VF PCI resources on probe failure

bnx2x_init_one() allocates VF PCI resources by calling bnx2x_vf_pci_alloc(),
but later error paths fall through the common cleanup path without calling
bnx2x_vf_pci_dealloc(). This commit adds a VF-specific error label to fix
the leak.

Fixes: 6411280ac94d ("bnx2x: Segregate SR-IOV code")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
> index da0f8c353e6a7..acb0379d94b99 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
[ ... ]
> @@ -13979,7 +13979,7 @@ static int bnx2x_init_one(struct pci_dev *pdev,
>  	rc = register_netdev(dev);
>  	if (rc) {
>  		dev_err(&pdev->dev, "Cannot register net device\n");
> -		goto init_one_freemem;
> +		goto init_one_vf_pci_dealloc;

[Severity: High]
This is a pre-existing issue, but if bnx2x_set_int_mode() succeeds earlier in
bnx2x_init_one(), MSI or MSI-X interrupts are configured. If register_netdev()
subsequently fails, the error path skips disabling these interrupts.

Does this leave the interrupts enabled and leak PCI IRQ vectors since there is
no call to bnx2x_disable_msi() on this error path?

>  	}
>  	BNX2X_DEV_INFO("device name after netdev register %s\n", dev->name);
>  
> @@ -14001,6 +14001,10 @@ static int bnx2x_init_one(struct pci_dev *pdev,
>  
>  	return 0;
>  
> +init_one_vf_pci_dealloc:
> +	if (IS_VF(bp))
> +		bnx2x_vf_pci_dealloc(bp);
> +

[Severity: High]
This isn't a bug introduced by this patch, but adding this mailbox cleanup here
seems to prevent releasing the acquired PF resources.

Earlier in bnx2x_init_one(), if IS_VF(bp) is true, we call bnx2x_vfpf_acquire()
to request resources from the PF. If a failure occurs later in the probe
function, the new error path calls bnx2x_vf_pci_dealloc() which frees the
VF-to-PF mailbox.

Because the mailbox memory is destroyed without first calling
bnx2x_vfpf_release(), does this result in a permanent leak of PF resources
assigned to the VF?

>  init_one_freemem:
>  	bnx2x_free_mem_bp(bp);
-- 
pw-bot: cr
