Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA19277C88;
	Sat,  5 Sep 2026 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633089; cv=none; b=QYCMlRQQxCxxkoM3d/RXK+060NVZyYRhxBsy5j1/HsFg9Hs47BhIe9eXLrmU+UY8NCFRc8PmBynd/wUfWYvbFtcDaMmpMk3WjTJxA0NRfQdnNZKIxa/kwFCAN3tHM1kvAp1UruPE5G7h+M/mxiZzpdnS+bJJ0ty96t5vxESWtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633089; c=relaxed/simple;
	bh=IYNtE8DSuI83MVcNu77fmGwSAjCcjWAYiQyEU9w5Yqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5Vuv0SFOyAF0JQxTyAnQoSOmrY1cDoADrMs+dglQRg/YD9HBAn8fo5cdFOyiLIFtooFHbo03iFK/vIWboK6NMdYaipybqiRazHBppQrprVQhh6Fd4LgTGUJdLDTnypXMEv4WPuf+LYNK6+QDxZ3w/ps1R0CHA6ujSjxuH7QTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg24wpUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg24wpUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26021F00A3D;
	Sat,  5 Sep 2026 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788633085;
	bh=ZgTZzsobBXFy3gqKMxbJ+2mygrq6b55JxDH+/SpJQas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fg24wpUL5obq0NbH/VNVdLz/Jn3YoXX1GiQ92Ss1trDWkXK3x7kpdDbgM1LD3rAeZ
	 oSj2dTwFizG6gKWM7bro0IlPCH5WoCj0tYVgOIpN6M+m8t4dAEtW8Vex7lo8iOuFd8
	 cMzZbRJwPDKgyrMEd7ntFKZXX8aKYtiG1qtL1lBQpQi+WbTofa2gl4kZtrl3zkvLKz
	 fXk9woc0Dg9ljj29z2e9DnLW4G8aPATDv6dPLqBjSLrBO07MsNXl7J8JaWhsGjdFJJ
	 er2/8q2TJjaWWJ5zcQGWtTvYRSR3V31uK1dLNXbWqouS4nUZCo4Sy56FYhDapIFoZZ
	 PkjfHaQTGq4yg==
Date: Sat, 5 Sep 2026 11:31:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johnathan Browall via B4 Relay
 <devnull+johnathan.browall.topgolf.com@kernel.org>
Cc: johnathan.browall@topgolf.com, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Pontus
 =?UTF-8?B?SMOlbGxzdGVkdA==?= <pontus.hallstedt@topgolf.com>
Subject: Re: [PATCH net v3] bnxt_en: avoid redundant RX mask updates in UC
 overflow state
Message-ID: <20260905113124.32280c67@kernel.org>
In-Reply-To: <20260901-bnxt-uc-overflow-v3-1-2ea7c42c013c@topgolf.com>
References: <20260901-bnxt-uc-overflow-v3-1-2ea7c42c013c@topgolf.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Sep 2026 14:46:47 +0200 Johnathan Browall via B4 Relay wrote:
> Tested with the equivalent patch on 6.12.y on BCM57416: the repeated
> SET_RX_MASK invocations no longer occur and the receive disruption is
> no longer reproducible.

You must test this on the kernel tree you are targeting.

> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> Cc: stable@vger.kernel.org # needs adjustment for <= 6.18

Please delete these and resend this to net-next, this is an improvement
not a bug fix.

> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13791,6 +13791,16 @@ static bool bnxt_uc_list_updated(struct bnxt *bp,
>  	struct netdev_hw_addr *ha;
>  	int off = 0;
>  
> +	/* In the overflow state no secondary L2 filters are programmed
> +	 * and unicast RX relies on the promiscuous mask, so the list
> +	 * only needs reprogramming once it fits the available filters
> +	 * again.  Reporting an update here would resend an identical
> +	 * SET_RX_MASK on every callback, which causes brief RX packet
> +	 * loss on some chips.

Please trim the slop comments significantly, or remove them.

> +	 */
> +	if (vnic->flags & BNXT_VNIC_UC_PROMISC_FLAG)
> +		return netdev_hw_addr_list_count(uc) <= (BNXT_MAX_UC_ADDRS - 1);

> +	/* Commit the overflow state only once the mask is installed, so
> +	 * that a failed attempt keeps the state marked as changed and the
> +	 * next retry or rx-mode callback programs the mask again.
> +	 */

slop

> +	netif_addr_lock_bh(dev);
> +	if (uc_promisc)
> +		vnic->flags |= BNXT_VNIC_UC_PROMISC_FLAG;
> +	else
> +		vnic->flags &= ~BNXT_VNIC_UC_PROMISC_FLAG;
> +	netif_addr_unlock_bh(dev);
